--[[local player = Aurora.UnitManager:Get("player")
local target = Aurora.UnitManager:Get("target")]]


local NewSpell = Aurora.SpellHandler.NewSpell
Aurora.SpellHandler.PopulateSpellbook(
        {
            spells = {
                Riptide = NewSpell(61295),--激流
                ChainHeal = NewSpell(1064),--治疗链
                AncestralWaveofHealing=NewSpell(8004), --治疗之涌
                Downpour=NewSpell(157153), --暴雨图腾
                AncestralSwiftness=NewSpell(443454), --先祖迅捷
                Shield=NewSpell(974),--大地之盾
                SpiritLink=NewSpell(98008),--灵魂链接图腾
                EarthlivingWeapon=NewSpell(382021),--大地生命武器
                WaterShield=NewSpell(52127),--水之护盾
                Skywrath=NewSpell(462854),--天怒


                LavaBurst=NewSpell(51505),--熔岩爆裂
                FlameShock=NewSpell(470411),--烈焰震击
                ChainLightning=NewSpell(188443),--闪电链
                LightningBolt=NewSpell(188196)--闪电箭



            },
            auras={
                WaterShield=NewSpell(52127), --水之护盾
                EarthShield=NewSpell(383648),--大地之盾
                Skyfury=NewSpell(462854),  --天怒
                UnleashLife=NewSpell(73685), --生命释放
                CalloftheAncestors=NewSpell(447244), --先祖的召唤
                DownpourBF=NewSpell(157504), --暴雨图腾BUFF
                AncestralSwiftnessBF=NewSpell(443454), --先祖迅捷BUFF
                WisdomAncestors=NewSpell(1238279),--先祖的慧根 四件套
                SpiritLinkBF=NewSpell(325174), --灵魂链接图腾BUFF
                EarthlivingWeapon=NewSpell(382024), --大地生命武器BUFF
                ElementMaster=NewSpell(462377),--元素宗师BUFF
                CoalescingWater=NewSpell(470077),--聚合流水

            }


        },
        "shaman",
        3,
        "MyShaman"
)

local spells = Aurora.SpellHandler.Spellbooks.shaman["3"].MyShaman.spells
local auras=Aurora.SpellHandler.Spellbooks.shaman["3"].MyShaman.auras

local function hps()

end

local function Ooc()
    local partyMembers = Aurora.fgroup
    local player = Aurora.UnitManager:Get("player")
    partyMembers:each(function(member)
        if not member.aura(462854) then
            spells.Skywrath:cast(player)
        end

        if member.istank and not member.aura(974) then
            spells.Shield:cast(member)
        end


        if not player.aura(52127) then
            spells.WaterShield:cast(player)
        end

        if not player.aura(383648) then
            spells.Shield:cast(player)
        end
    end)

end

Aurora:RegisterRoutine(function()
    -- Skip if player is dead or eating/drinking
    if player.dead or player.aura("Food") or player.aura("Drink") then return end

    -- Run appropriate function based on combat state
    if player.combat then
        hps()
        Dps()
    else
        Ooc()
    end
end, "SHAMAN", 3, "MyShaman")
