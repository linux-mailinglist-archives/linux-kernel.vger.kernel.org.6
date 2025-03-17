Return-Path: <linux-kernel+bounces-564305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B824A65257
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7EC1899931
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8E23FC4E;
	Mon, 17 Mar 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl2j3HhO"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C8238145;
	Mon, 17 Mar 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220516; cv=none; b=AT2ZyRl4nsNHWZdieR6lHRiiZnGHo/oZVttuSN3eKgFJQ8j2MO+VGOJssYZGAP3+AqcuSGUqqbsg2dGstG2T9WNhhD8UUYmPYb89G5cpyFwMgdD6c60xjiK/z6ZQcFbwafexYaYWPLbnetVxbCf6BgeF/CkzGehIpUrNkNPe5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220516; c=relaxed/simple;
	bh=Np5uytKyQZ21ba3CZhWmHX/Emp8BKXuWxxwD9ZvNZz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkrCaC3z/0hlNY+YJzFCgfTQUtWczzI3YOhje6r7bbMerCmfOHHngXL8YpSH4NKpPRpAiuiWBLQsxND3chyJ4VMqK5b0g7C6X2vFRfbPTjUV3mnuz7MHIbiRlawGC8G7ZveE6LJnWw7U52tpfm20ScEuLPCqnhFZFu//AXR0MO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl2j3HhO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c54c52d8easo600826085a.0;
        Mon, 17 Mar 2025 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742220513; x=1742825313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q96W2jfHCK5Qr5KiWedCs8F/77XCrh3uMVyQi4bZggo=;
        b=Vl2j3HhO3wmADHEDQGKKxdCnouyJAsXAasIUBmhB2bLgI9BUUZ91ttDugn0pS452W8
         zKtFhHXidCQ7jqP3vkJJV0a81hM4iAitdMFI8/XBVc37zEZsnPGeMNUp+p9xLHj19lgK
         YRVV8EgBYyW+Rb5ykGAMtku1OOrKCaW2jIZTwqZ+sTa3fruhvkS6Ef16rODQ0/vg+Lra
         /3amCK5i/AoWL2HRWIlIc6fiY1ISvd/ENNLl2ADKVixXMMVOK2MrNFHcpFZ4hZ1mMWUJ
         RYqEYtWOrpxmXJWwHI/TtzrA0G5d3Dv8zQfJYIsKyfMOe2JAPqEMEZ4WmW8tfOMPB9DY
         z7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220513; x=1742825313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q96W2jfHCK5Qr5KiWedCs8F/77XCrh3uMVyQi4bZggo=;
        b=myc77ZfiMBXvtfZnHsfLcPYhWKR00QlJYbDrJzTLjW04FlGW/8xb5dymlOEjXi5G2m
         Zr3P7u2i1PYcD3JzuGjMrj6N0zzleTvdybyWFQyXtynNhHMgbkTrZQajlGVMuJX3hfP7
         5iR3n3qQABhSDYE0PfpH36IZVmzH8AsSzn60r99Ownm0CXEOFzeZK0+Su+FDT+oSi2qi
         Fj11tC+Xzd4zpDlDKphpX70U74nPUAQz+kHcm5vynpah4jP03bt05VGzXOR+nbC5XWPv
         7JtZrHI9YiyIu1VpzNqtH0QYZ6Zcq00AG8h8jOSwo29gw5TsJcAA81DiNuKzdKIh5QHy
         7y4w==
X-Forwarded-Encrypted: i=1; AJvYcCV0W29Oj2M10/gHKCC/zkhbhzsyvq3IorooTv40k2Uy0PCFAGeqPXmoM3vmkWuAEdEyqlOtIfooxagXAsE=@vger.kernel.org, AJvYcCVQTdMZCApHSAiO/crG9WEgHGdTjEDP84RvJs2OZYrWT50l8Wq+v42vlQx/Yw2/glhEtcaqqLLQkwaUox23n+lG5q3mPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSgBoxK3oTuc2jRqW2TLHqWEEOQybiUVByeIr8ShGVekljCZht
	bKlx0hlhCp03S7b4HHzf3PQbjWkSUtFWz5KlXogRUqA2vwmv5nvH
X-Gm-Gg: ASbGncuOgmH5sshwOayYNh58kp0RGi2PqMoOiYYBrE90hlRnNdGYb0pYBcSVXsgba6I
	7FS6zAPZaxof2T8qwPdmO7YBEIPVmtOuufInvBtaCv60Zh18PI0L8V2dZ4ZLdx+kgDcJHvYpfYt
	iV5UzasVm3HoH/YrH/kj6IuilR+fMKHjK5M3FizfX1XtfCzaiNQ5iJKzdQiaUP/+cPU0Ga6j11f
	PmqJc0DgpujCuJWKw2uFPU7/GX5HPRldn9VAkgs29o8s8E8mIEzBXOEXEemN52DzKkjZt1PaaMb
	CUofs9ufRZPL+z6L0oBdrh/yu0W+OFpLs6qVRZ/oOloILNjUhrBuTzcrfZDRgnUYzerjNM9+nfG
	MK+E0iQ4nmheGeNDqLoA=
X-Google-Smtp-Source: AGHT+IGZKgwpoejG3SM+CP6jC9h3f7UhxL82yIvjfLTWcl3249ON9XkMGaVRAxc6qmBLltHqfklCVw==
X-Received: by 2002:a05:620a:385d:b0:7c5:93d4:766a with SMTP id af79cd13be357-7c593d4766fmr203323385a.3.1742220513472;
        Mon, 17 Mar 2025 07:08:33 -0700 (PDT)
Received: from [192.168.1.187] (pool-96-234-60-2.nwrknj.fios.verizon.net. [96.234.60.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fb39sm587699385a.85.2025.03.17.07.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:08:33 -0700 (PDT)
Message-ID: <b168d04e-0a71-45a5-898f-31555ce306fb@gmail.com>
Date: Mon, 17 Mar 2025 10:08:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1
 14imh9 unknown keys
To: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>
Cc: ike.pan@canonical.com, linux-kernel@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <20250313151744.34010-1-gasper.nemgar@gmail.com>
 <4970c2cd-9637-460a-8e85-bc44f7b0a550@redhat.com>
 <CAKi4K-hFHy4_F+fQghFNNR8cnkojPcE0uXQWsf5+5dbqjXGs0g@mail.gmail.com>
 <a6c79155-daac-4c2a-9b91-5c8480dc14b1@redhat.com>
Content-Language: en-CA
From: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
In-Reply-To: <a6c79155-daac-4c2a-9b91-5c8480dc14b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/25 4:41 AM, Hans de Goede wrote:
> Hi Gašper,
> 
> On 14-Mar-25 12:35 PM, Gašper Nemgar wrote:
>> Thanks for the feedback,
>>
>> I will go over your notes here and explain things.
>> The Eye button on windows triggeres "Eye Care mode" https://download.lenovo.com/consumer/mobiles_pub/yoga_9i_2-in-1_14_9_ug_en.pdf#page=50 <https://download.lenovo.com/consumer/mobiles_pub/yoga_9i_2-in-1_14_9_ug_en.pdf#page=50>,  does linux have a keycode as something like this, i didn't found any, should we jus assign it to one of the programmable keys?
> 
> Yes that sounds like the best solution.
> 
>> I will handle the performance as you have suggested, thanks
> 
> You're welcome.
> 
>> The shift + prtSc i have made a mistake here, i meant the Fn + prtSc.
>> Just PrtSc is handled by a different device ("AT Translated Set 2 keyboard") and is not managed by this module. evtest told me it sends SysRq code which is intended and it triggers the selective screenshot.
> 
> Right, e.g. GNOME does not really differentiate between sysrq/printscreen
> and KEY_SELECTIVE_SCREENSHOT and always uses the dialog instead of making
> printscreen directly take a full screen screenshot. Still making this
> the Fn + printscreen comboe send KEY_SELECTIVE_SCREENSHOT is the right thing
> todo and is also done on other laptop models with the same icon.
> 
>> If I assign the Fn + PrtSc to KEY_SELECTIVE_SCREENSHOT the evtest shows
> me it triggers code 634 and code name is "?". Is this correct behaviour?
> 
> This just means that your evtest is a bit old and does not know about
> KEY_SELECTIVE_SCREENSHOT yet.
> 
> Regards,
> 
> Hans

I have this laptop and did some digging to find out which keys use WMI, how 
they are described by Lenovo, what they do now, and a suggestion for what to 
do with them if different.  I think that this is a comprehensive list.
The descriptions are from the User Guide Yoga 9i 2-in-1 (14″, 9) from Lenovo.

Key: Microphone Mute (Fn+F4)
WMI Code: 0x3e
Described as: p43 Enables/Disables the microphone.
Status: Already handled in ideapad_laptop
Key: KEY_MICMUTE 248

Key: Airplane Mode (Fn+F8)
WMI Code: 0x3f
Described as: p43 Enables/Disables airplane mode
Status: Already handled in ideapad_laptop
Key: KEY_RFKILL 247

Key: Star with S inside (right of F12)
WMI code: 0x1
Described as: p27&43 Displays the Lenovo Smart Key quick launch panel.
Status: Already handled in ideapad_laptop
Key: KEY_FAVORITES 0x16c

Key: Snip (Fn+PrtSrc)
WMI Code: 0x2d
Described as: p43 Opens the Snipping tool.
Status: Proposed patch uses KEY_PROG3.
Suggestion: KEY_CUT 137
Note: If the snipping tool does a selective screenshot then the 
KEY_SELECTIVE_SCREENSHOT would be better.

Key: Performance Meter (just below Delete)
WMI Code: 0x3d
Described as: p44 Switches the computer’s active operation mode.
Suggestion: KEY_PROG4 203
Rationale: There already is a mapping from a thermal management button to 
KEY_PROG4 in ideapad_laptop.
Note: I think that it is better to not hardwire keys.

Key: Speaker with gear (just below Perf key)
WMI Code: 0x12
Described as: p44 Switches the computer’s active audio mode.
Status: Already handled in indeapad_laptop
Key: KEY_PROG2 149

Key: Eye (just below Speaker with gear key)
WMI code: 0x45
Desribed as: p44 Turns on/off the Eye Care mode.
Status:  Proposed patch uses KEY_DISPLAYTOGGLE.
Suggestion: KEY_BRIGHTNESS_CYCLE 243
Rationale: This KEY_DISPLAYTOGGLE appears to be for switching screens, not 
adjusting brightness/color.

Key: Star (just below Eye key)
WMI code: 0x44
Described as: p44 Opens a custom (user-defined) app.
Status: In proposed patch
Key: KEY_PROG1 148

Key: Fn+Esc
WMI code: 0x2 or 0x3
Described as: p20 Switch F<n> hotkey behaviour.
Status: Explicitly ignored in ideapad_laptop, as the switching is done in the 
device

Key: Fn+spce
Described as: p43 Adjusts the keyboard backlight. (Done in device.)
WMI code: 0x41
Status: The code is not mentioned in ideadpad_laptop. The backlight is 
adjusted by the device.
Suggestion:  Document with an explicit ignore.

Key: Fn+M
Described as: p21 Enable/disable the touchpad.
WMI code: 0x29
Suggestion: KEY_TOUCHPAD_TOGGLE 0x212

Key: Fn+N
Described as: p21 Shows device information.
WMI code: 0x2a
Suggestion: KEY_ROOT_MENU 0x26a
Note: There doesn't seem to be a really good match for this.

Key: Fn+Q
Described as: p21&32 Switch among different performance modes.
WMI code: 0x3d
Suggestion: KEY_PROG4 203
Rationale: Same as Perf key

Key: Fn+R
Described as: p21&32 Change the display refresh rate.
WMI code: 0x10
Status: Already in ideapad_laptop.
Key: KEY_REFRESH_RATE_TOGGLE 0x232

peter


> 
> 
>> On Fri, 14 Mar 2025 at 10:34, Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
>>
>>      Hi Gašper,
>>
>>      Thank you for your patch.
>>
>>      First if all a few generic notes:
>>
>>      1. When sending out v2 of the patch please add
>>         platform-driver-x86@vger.kernel.org <mailto:platform-driver-x86@vger.kernel.org> to the Cc
>>
>>      2. The patch subject (first line of commit message) should have
>>         a prefix describing the subsystem + driver, e.g. use:
>>         "platform/x86: ideapad-laptop: Add a few new keymap entries"
>>
>>      3. Your patch is missing a signed-off-by, see:
>>      https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin>
>>
>>      4. Your commit message / patch should also have a body, e.g.
>>         the entirety of the commit message could look something like this:
>>
>>      -- begin --
>>      platform/x86: ideapad-laptop: Add a few new keymap entries
>>
>>      The Yoga 9 2 in 1 14imh9 introduces 4 new hotkeys which are not
>>      yet in ideapad_keymap[], add entries to map these keys.
>>
>>      Signed-off-by: Gašper Nemgar <your-email-here>
>>      -- end --
>>
>>      A few more specific remarks below based on looking at
>>      this picture of the keyboard:
>>
>>      https://ardes.bg/uploads/original/lenovo-yoga-9-2-in-1-14-g9-550178.jpg <https://ardes.bg/uploads/original/lenovo-yoga-9-2-in-1-14-g9-550178.jpg>
>>
>>      On 13-Mar-25 4:17 PM, Gašper Nemgar wrote:
>>      > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
>>      > index 30bd366d7..af124aafe 100644
>>      > --- a/drivers/platform/x86/ideapad-laptop.c
>>      > +++ b/drivers/platform/x86/ideapad-laptop.c
>>      > @@ -1308,6 +1308,14 @@ static const struct key_entry ideapad_keymap[] = {
>>      >       /* Specific to some newer models */
>>      >       { KE_KEY,       0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
>>      >       { KE_KEY,       0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
>>      > +     /*Star- (User Asignable Key)*/
>>      > +     { KE_KEY,       0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
>>
>>      Ack.
>>
>>      > +     /*Eye*/
>>      > +     { KE_KEY,       0x45 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
>>
>>      It looks like the laptop already does display-toggle as Fn-F7 although
>>      it like sends super + P for this (AKA meta + P).
>>
>>      So mapping this to KEY_DISPLAYTOGGLE seems wrong, what does this
>>      do under Windows?
>>
>>      Maybe KEY_ZOOM ?
>>
>>      > +     /*Performance*/
>>      > +     { KE_KEY,       0x3d | IDEAPAD_WMI_KEY, { KEY_SPORT } },
>>
>>      I think that instead of mapping this it should be handled specially
>>      and call platform_profile_cycle() instead of sending a key-press
>>      to userspace
>>
>>      > +     /*shift + prtsc*/
>>      > +     { KE_KEY,       0x2d | IDEAPAD_WMI_KEY, { KEY_PROG3 } },
>>
>>      Looking a the symbol on the keyboard this should send
>>      KEY_SELECTIVE_SCREENSHOT
>>
>>      >
>>      >       { KE_END },
>>      >  };
>>      >
>>
>>      Regards,
>>
>>      Hans
>>
>>
> 
> 


