Return-Path: <linux-kernel+bounces-549500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1684EA5534B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B792176813
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00525CC88;
	Thu,  6 Mar 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Ad96yJ+2"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA52147FD;
	Thu,  6 Mar 2025 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282994; cv=none; b=uV62fFhAHY51u3CBIMMKLs7nGhg36ptzZIILENTImO3wxQr2hFfgSx76tdIWK/ve1jw6wJO2O2e2Us38eRZN+B4wq42qyRDjzFKObkZwJ2d/ZK50QFGJHxD0/TxcQbLVuwXpEEUXXCpE5ZcniK8pJw5f8440YvvB9VLZMn/ltks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282994; c=relaxed/simple;
	bh=m5G5ImChXblzOK16r3EN8cvkLdg3wQdP3CsMuUEnf84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agSyteauY/U4dRTj7NtLPDWda4EL3C/R3GUVd7J8ju6R4A9ZnLwxAjQpo8SE0RZRR3N8GtXHMDxV1KpdrOFDwuDZghyc9yIN2HjBPMcjW1ESBt/G6ElnHp9+Okq9rM4aHqSbXDFFp4st4x7gV46AGFlSCFYJEsOjsdh1HHCgRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Ad96yJ+2; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59f4f.dip0.t-ipconnect.de [217.229.159.79])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 2D5012FC0048;
	Thu,  6 Mar 2025 18:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741282987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztPP88OHRGNbxkdavb7bi4jX3Ap7eHSxKC1RPRuKmsI=;
	b=Ad96yJ+2kt3c1wRHuweMFL0Wx5RktsNwXTf8RtzUG3PTmooP02IegXFnrp0riXHLIYyLp2
	nb1pZQRoHUIEpRGSr9Hq7gD9nc8AINKsveYDiLISzRcc0X3yMj4XsQTcYpdITpjykwKfsv
	aRuxvbtkGi7lqQhMu/wH01tUm+hU/Bs=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <6c8a2fe4-1254-4df0-bd58-348b48b94854@tuxedocomputers.com>
Date: Thu, 6 Mar 2025 18:43:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 FN-keys
To: Hans de Goede <hdegoede@redhat.com>, mario.limonciello@amd.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <20250303190442.551961-2-wse@tuxedocomputers.com>
 <1bee0a62-058b-482a-8eec-d45b8aca1614@redhat.com>
 <d74c348d-474a-4871-8b94-d836e8d054e8@tuxedocomputers.com>
 <1fbdfe7f-0f25-4de0-805c-b712663f7681@redhat.com>
 <e6f5234c-98ab-4a06-aa1a-59726f395ea4@tuxedocomputers.com>
 <b0d0eac1-76e5-462b-9ff5-605536fa00b4@redhat.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <b0d0eac1-76e5-462b-9ff5-605536fa00b4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hans,

Am 06.03.25 um 15:46 schrieb Hans de Goede:
> Hi Werner,
>
> On 5-Mar-25 4:41 PM, Werner Sembach wrote:
>> Hi Hans,
>>
>> Am 05.03.25 um 15:18 schrieb Hans de Goede:
>>> Hi Werner,
>>>
>>> On 5-Mar-25 1:07 PM, Werner Sembach wrote:
>>>> Am 05.03.25 um 12:25 schrieb Hans de Goede:
>>>>> Hi Werner,
>>>>>
>>>>> On 3-Mar-25 8:04 PM, Werner Sembach wrote:
>>>>>> This small driver does 2 things:
>>>>>>
>>>>>> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
>>>>>> F21 to conform with established userspace defaults. Note that the
>>>>>> Hangaku/Zenkaku scancode used here is usually unused, with real
>>>>>> Hangaku/Zenkaku keys using the tilde scancode.
>>>>> So this control + super + scancode 0x76 sending is also seen on
>>>>> quite a few other laptops and I think we need a generic fix for this.
>>>>>
>>>>> I recently noticed that KDE's keyboard-shortcut settings actually has
>>>>> a  control + super + Hangaku/Zenkaku -> touchpad-toggle key binding
>>>>> in its default bindings (IIRC). But that cannot work because xkb actually
>>>>> has no mapping for evdev code 85 / KEY_ZENKAKUHANKAKU if you look in:
>>>>>
>>>>> /usr/share/X11/xkb/keycodes/evdev and then look for 93 (*) you will
>>>>> find no mapping. I think this KDE default binding may be from a long
>>>>> time ago when this did work. Or maybe KDE uses the FOO part of KEY_FOO
>>>>> as symbolic when there is no xkb mapping ?
>>>> It does not work on X11, but it does work on Wayland (there xev also sees the Zenkaku/Hankaku keypress). Don't ask me why.
>>> Interesting, so in xev under Wayland you see something like this
>>> on release:
>>>
>>>       state 0x0, keycode 38 (keysym 0x61, a), same_screen YES,
>>>
>>> With there actually being a keysym of "Zenkaku_Hankaku" there ?
>> No. Sorry I got it a little bit wrong above, I didn't know it exactly anymore and had to retest:
>>
>>
>> With the keyboard shortcut deactivated, xev on wayland shows this:
>>
>> KeyPress event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 246681, (83,3), root:(1273,701),
>>      state 0x0, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XmbLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyPress event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 246682, (83,3), root:(1273,701),
>>      state 0x40, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XmbLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyPress event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 246686, (83,3), root:(1273,701),
>>      state 0x44, keycode 93 (keysym 0x0, NoSymbol), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XmbLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyRelease event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 246690, (83,3), root:(1273,701),
>>      state 0x44, keycode 93 (keysym 0x0, NoSymbol), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyRelease event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 246696, (83,3), root:(1273,701),
>>      state 0x44, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyRelease event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 246703, (83,3), root:(1273,701),
>>      state 0x40, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>>
>> With the shortcut active, xev on wayland shows this (and the shortcut works):
>>
>> KeyPress event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 365034, (83,3), root:(1273,701),
>>      state 0x0, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XmbLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyPress event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 365036, (83,3), root:(1273,701),
>>      state 0x40, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XmbLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyRelease event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 365060, (83,3), root:(1273,701),
>>      state 0x44, keycode 37 (keysym 0xffe3, Control_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XFilterEvent returns: False
>>
>> KeyRelease event, serial 39, synthetic NO, window 0x1200001,
>>      root 0x4f7, subw 0x0, time 365060, (83,3), root:(1273,701),
>>      state 0x40, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
>>      XLookupString gives 0 bytes:
>>      XFilterEvent returns: False
> Ah ok, so in KDE the shortcut somehow works under Wayland despite
> the lack of xkb keysym mapping (maybe match on keycode?) and then
> the compositor absorbs / eats the Zenkaku_Hankaku key-press +
> release as it does with other compositor handled hotkeys leaving
> apps like xev to just see the modifier press/release events
> (which the compositor cannot delay / filter for the same reasons
> as why an i8042 kbd filter won't work).
>
>>> Because that is not working on Wayland on my laptop with the same
>>> issue (after disabling the hwdb mapping) and I don't understand
>>> how that could work at all given that /usr/share/X11/xkb/keycodes/evdev
>>> has no mapping for EV keycode 85 (93 in that file) ?
>>>
>>>> Also: Other DEs don't have this binding.
>>> Yes that is an issue, but see below.
>>>
>>>>> *) 85 + 8 all codes there are shifted up 8 compared to the KEY_FOO
>>>>> defines because codes 0-7 are reserved for modifier.
>>>>>
>>>>> I hit the same issue years ago on "T-boa Tbook air" laptop and
>>>>> their I fixed this by mapping Hangaku/Zenkaku -> f21 in
>>>>> /lib/udev/hwdb.d/60-keyboard.hwdb :
>>>>>
>>>>> ###########################################################
>>>>> # T-bao
>>>>> ###########################################################
>>>>>
>>>>> evdev:atkbd:dmi:bvn*:bvr*:bd*:svnT-bao:pnTbookair:*
>>>>>     KEYBOARD_KEY_76=f21                                    # Touchpad toggle
>>>>>
>>>>> + teaching GNOME to also accept Ctrl + Super + XF86TouchpadToggle
>>>>> as touchpad-toggle:
>>>>>
>>>>> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/data/org.gnome.settings-daemon.plugins.media-keys.gschema.xml.in?ref_type=heads#L577
>>>> Yeah KDE would need a similar fix and other DEs probably too. I hoped for a generic fix that does not need adjustments in so many projects.
>>>>
>>>> My first try was to do it on the XKB level but on Wayland the RedirectKey action is not implemented https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/merge_requests/794#note_2803713 (and probably wont be even in the future https://github.com/xkbcommon/libxkbcommon/issues/18#issuecomment-72728366) so I can't "unpress" control and super.
>>>>
>>>> If it is a more general issue, why not fix it on a more general level in the kernel? Maybe a generic filter applyable via a command line quirk and/or a quirk list?
>>> The problem is that filtering keys with modifiers like you are doing
>>> here just does not work.
>>>
>>> Your filter is seriously messing with the timing of the keypresses
>>> which can be a real issue when not actually using the toggle touchpad
>>> hotkey.
>>>
>>> Lets say the user is playing a game and has mapped super to
>>> one of the fire buttons and is using an in game weapon with
>>> some sort of auto-repeat firing.
>>>
>>> And your seqpos variable likely is 0 when super gets pressed,
>>> now the keyboard sends 0xe0, 0x5b which your filter filters
>>> out, and the user keeps super pressed because they expect
>>> the weapon to start firing on auto-repeat. But the super
>>> press is never send until super is released or another key
>>> is pressed so things don't work.
>>>
>>> Likewise if the DE, an app or accessibility settings want to
>>> differentiate between a short and a long super press all
>>> presses now become super (pun not intended) short because
>>> you insert the press directly in front of the release, losing
>>> any timing information about how long the key was pressed.
>>>
>>> This is why using an i8042 filter for filtering key-combinations
>>> (and the EC emulates a key-combination here) can never work reliably.
>> Ok, thought I had a clean solution, but doesn't seems so xD.
> Yeah these single key which the EC makes send a whole key sequence
> EC level key-bindings are a pain to deal with. Some for some other
> keys emulating Windows hotkey presses like "Super + P", but those
> are simply send unmodified to the DE to let the DE deal with them.
>
> Sending these unmodified to the DE pretty much is the only thing
> we can do.
>
>>> OTOH desktop environments already allow having Ctrl+Super+something
>>> keybindings for DE actions. So we can re-use the tried and trusted
>>> modifier handling in the DE to deal with combi part leaving just
>>> the issue of mapping PS/2 scancode 0x76 aka evdev code
>>> 85 / KEY_ZENKAKUHANKAKU to something usable by the DE.
>>>
>>> ATM both GNOME and KDE already have support for
>>> Ctrl+Super+something for touchpad-toggle except that KDE expects
>>> a "Zenkaku_Hankaku" keysym where as GNOME expects "XF86TouchpadToggle"
>>> arguably the GNOME solution is slightly better because Japanese
>>> keyboard layouts already use/send the "Zenkaku_Hankaku" keysym
>>> unrelated to touchpad-toggle use. And I don't know what happens
>>> when pressing ctrl+super+Zenkaku_Hankaku while using a Japanese
>>> layout.
>> When I interpret the xkb-config correctly, JIS keyboards use the tilde scancode/keycode for the physical zenkaku/hankaku keys, at least in the default config HZTG (henkaku/zankaku toggle) is aliased to TLDE
> Yes I don't think the 0x76 ps/2 scancode is used on any actual
> keyboards other then for this toggle touchpad key thing.
>
>>> I think maybe we just need to patch atkbd.c at the kernel to
>>> map scancode 0x76 -> KEY_TOUCHPAD_TOGGLE since normal PS/2
>>> keyboards never generate 0x76, this would lose the mapping to
>>> KEY_ZENKAKUHANKAKU but since /usr/share/X11/xkb/keycodes/evdev
>>> does not even map KEY_ZENKAKUHANKAKU I don't think loosing that
>>> mapping will do a big deal.
>> At least from kernel side this would be a very small patch, are there any objections to it?
> Well it would break the currently working touchpad toggle in KDE,
> but the same applies to doing the mapping in hwdb.

So I looked into KDE: They use whatever Qt is doing: 
https://invent.kde.org/plasma/kwin/-/blob/be91df80ef44386f98a831a5f4dfdfd4a3b6e83e/src/plugins/touchpadshortcuts/touchpadshortcuts.cpp#L41

After thinking about it a little bit: If we need to touch multiple userspace 
projects anyway, I tend to not touch the kernel at all. After all: From kernel 
side the key is mapped in a way that both X11 and Wayland can see it (given the 
right xkeyboard-config).

Thought dump below for userspace only solutions:

- Map KEY_ZENKAKUHANKAKU to XF86TouchpadToggle using xkeyboard-config

- Add Qt::ControlModifier | Qt::MetaModifier | Qt::Key_TouchpadToggle to KDE

- Possible regression: If user updates xkb without updating KDE the formerly 
working shortcut stops working

or

- Map KEY_ZENKAKUHANKAKU to Zenkaku_Hankaku using xkeyboard-config

- See if that fixes the X11 binding of KDE

- Add Control + Super + Zenkaku_Hankaku to GNOME

- If user updates xkb without updating GNOME the formerly working shortcut stops 
working

- Possible regression: I tend to the first version as there might be at least a 
change that other DEs work out of the box with it.

Best regards,

Werner

>
> I think it would be best to just post the patch + create
> a KDE issue and then see from there.
>
> Regards,
>
> Hans
>
>

