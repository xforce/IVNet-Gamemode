/*
 *	This file is part of IVNet-Gamemode (OSG).
 *
 *  IVNet-Gamemode (OSG) is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  IVNet-Gamemode (OSG) is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.

 *  You should have received a copy of the GNU General Public License
 *  along with IVNet-Gamemode (OSG).  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 *  @file: PlayerEvents.nut
 *	@desc: Contains the handlers for player events
 *	@init-author: Jan Christophersen
 *	@date: 03.11.2013
 */

/*
 *	function onRequestRegistration (enPlayer, strPassword, iGender, iFaction)
 *
 *	Description:
 *		Parses the registration request of a player
 *
 *	Parameter(s):
 *		<instance>	enPlayer	-	the player
 *		<string>	strPassword	-	the chosen password
 *		<integer>	iGender		-	the player's gender
 *		<integer>	iFaction 	-	the chosen faction
 *
 *	Return:
 *		true if the registration request passed, wrong if not.
 */
function onRequestRegistration (enPlayer, strPassword, iGender, iFaction)
{
	if (!g_PlayerManager.Exists(enPlayer))
	{
		log("Player does not exist in CPlayerManager", LOG_WARNING);
		return false;
	}

	enPlayer.bRegistered = true;

	/*	TODO:
	 *	-Auto login
	 *	-Tutorial (maybe)?
	 */
	enPlayer.sendMessage("[TODO] Auto login / Save data etc", 0xFF0000);
	return true;
}

/*
 *	function onPlayerJoin (enPlayer)
 *
 *	Description:
 *		This handler gets called when a new player joins the server.
 *		We will make everything ready for the player here.
 *
 *	Parameter(s):
 *		<instance>	enPlayer	-	the player entity 
 *
 *	Return:
 *		void
 */
function onPlayerJoin (enPlayer)
{
	debug(enPlayer.getName() + " joined the server. ID: " + enPlayer.getId());

	// Add the player to the manager
	g_PlayerManager.Add(enPlayer);

	g_PlayerManager.Broadcast(enPlayer.getName() + " joined.");
}

/*
 *	function onPlayerCommand (enPlayer, strCommand)
 *
 *	Description:
 *		gets called when a player casts a command (/xyz).
 *
 *	Parameter(s):
 *		<instance>	enPlayer	-	the player that calls the command
 *		<string>	strCommand	-	the command + params. 
 *
 *	Return:
 *		void
 */
function onPlayerCommand (strCommand, enPlayer)
{
	return g_CommandManager.Handle(enPlayer, strCommand);
}

/*
 *	function onPlayerRequestSpawn (enPlayer)
 *
 *	Description:
 *		Will be called upon spawn request of player (when he finished loading everything)
 *
 *	Parameter(s):
 *		<instance>	enPlayer	-	the player entity 
 *
 *	Return:
 *		void
 */
function onPlayerRequestSpawn (enPlayer)
{
	debug("Request");
	enPlayer.sendMessage("Seems like you want to spawn, huh?");
	debug("After message");
    enPlayer.spawn(166.187,367.387,15.179,90.0);
    debug("After spawn");
}

// Register all handlers
addEvent("playerJoin", onPlayerJoin);
addEvent("playerCommand", onPlayerCommand);
addEvent("playerRequestSpawn", onPlayerRequestSpawn);

addEvent("requestRegistration", onRequestRegistration);