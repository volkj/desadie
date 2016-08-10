--
-- DeSadie 2.0
--	Instead of banning Sadie and other fake client names,
--	shows a message box informing them that the game is Minetest
--	instead of Minecraft or other names.
--


-- Names are added when they are seen with a numeric pattern
--	attached to them, as Name1234. Only add the name w/o pattern.

local fakeclient_nicknames = {
								"Sadie",
								}

minetest.register_on_joinplayer(function(player)
	-- register a timeout of 5 seconds before showing the formspec
	minetest.after( 5, function(player)
		local playername = player:get_player_name()
		for index, value in pairs(fakeclient_nicknames) do
			if string.find(playername, value .. "%d") ~= nil then
				minetest.show_formspec( playername, "desadie:on_fake_login_form",
					"size[8,3]"
					..	"label[0.1,0.5;Hello, this game is called Minetest. If your app recalls Minecraft]"
					..	"label[0.1,1;or is not called Minetest it may be a not official client.]"
					..	"label[0.1,1.5;Please download the official Minetest client (visit www.minetest.net)]"
					..	"button_exit[2,2;2,1;keep_playing;Keep playing]"
					..	"button[4,2;2,1;exit_game;Exit game]"
				)
			end
		end
	end, player)

end)

-- Code from http://rubenwardy.com/minetest_modding_book/chapters/formspecs.html readapted

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "desadie:on_fake_login_form" then
		return false
	end
	if ( fields.exit_game ) then
		minetest.kick_player(player:get_player_name(), "Game exited successfully")
		return true
	end
	return true
end)

