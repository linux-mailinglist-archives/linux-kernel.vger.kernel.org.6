Return-Path: <linux-kernel+bounces-564453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F02A6556E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5487A5894
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA03245038;
	Mon, 17 Mar 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE8lNC0h"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FF230BEB;
	Mon, 17 Mar 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224835; cv=none; b=nX33R7Z/wil6a5IRm6w8Og4x1hOHgAT/vEwWcf3ATSkhgRLiczVQ7lvBgemtnr3QCQbAmISTfz/XKmonwAtdkJAf+/aFZrKmUjUGXL67TTJAgaZcDBB/CrGiayNlufT3YCunVtaKpHbEnIYPWe2dQpJwSsoqbsS7bccfeh3N9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224835; c=relaxed/simple;
	bh=XfqaR4rLMmJg0up8v9GiocrjVSDMO9H4FuLaMgbIav0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDH8If9GXxBc79Rv96d1lXVqvEhoHZyHL23MPVwdgzyu6ukTKBqcj7FKVW3hs+A9LZ5gWCeZBv1yfGuEYyF+3uVfIfO3wYckWsLnc4btH2XLohcgbRyQgmsIg75posmO926jRM+1Um67bddTHKefPyN6+4JeXBCyAruw9q76iGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE8lNC0h; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fcef5dc742so966124eaf.1;
        Mon, 17 Mar 2025 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742224832; x=1742829632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bV+oVvQ1hBLUJw/fm0rVg4LsDbUI9KBKsLORHjrq2g=;
        b=eE8lNC0hzhmzQugcqnda9+YIWdpStMxn5Nmm0gnxFqnHfRnDGp3zfj6dvT7tBmnBC5
         kCKWjyhc6y6Oml4xk3Uprm2ZLsSDLyBi+R1B1Kxk74soBuLQExeOdyuH1iM3YVtxwRI/
         0VrxhOGSBkmi1O2k+HkWMprvGUilmOB2MBgLSoTs8aeMlxLZFJPOVd34ncQHVkEVhgVv
         NT74iIx1CP+DW30ebZMkXVVJO15Lh8sMgsxfR8svFfJLQhy/3++2BSwl5fHYvktM5hm7
         bFnSJuQlxoHchbxmfdKlELTvGttxdOpxIDhwMaXKrRzlTLe4RdVKqW71fluY7dFLhwQL
         F+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224832; x=1742829632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bV+oVvQ1hBLUJw/fm0rVg4LsDbUI9KBKsLORHjrq2g=;
        b=nJZt1+TjrozB+yFnJ5sceaDEQOmB9UkAGuqcW1c1CdU1MPjj5bkam0f21lT6EiCXpC
         4e2khZda/+LHmhWOb5ABGiah3ZuAX2Aw2quYZQ8cPdKrAj27/twIR1SsIgatoaIynXRX
         40EwtOAV9WJCRsjitELUAtVhRH66Fo5PkNFpwQ/VnrmfQV5Y4Q59G6yrSdEiTL6Q9bw8
         tmf02EOMvBatQjgLMoXc/7sEfAuRXYzIUjbBKbrDdNSQ63b0ACm6bIwxGDd0GeCgFDBc
         5ntpubG1faUPfIRzmOnjPPZsLUCpHEGKyAKuCrN4E20MOWChwjNiYCgN4mrVQz7aCu63
         I+hA==
X-Forwarded-Encrypted: i=1; AJvYcCVdMw1lkvYfuGyf/EycDM4qobAAS6y/qtycbxQQqW1aK0ywHfF9ttp09XG3nOloOkyswM7rnDLQm0VHn1E=@vger.kernel.org, AJvYcCXaYRsECQyTnY6JeXpY0efyh9FPQbfscFktsoqgczlHC/4M58ZpTXAYANpj7GD3N06Lwks/nEkgYljdQp+GLZ9glVht2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/XftEpmP6oyNZKyRYElWUR7Ae/LlD97YELMgYLBo06/f9S8X6
	sJKwLuU4Aqyr7Z8relL1e7KtCRHwwlNTsV76GODvSfD7gS8zdhUoQWKiGwwssKly1FK798ede1n
	9uIMYnbVkZZVurIjvB71eVEzibDEoQh56p8w=
X-Gm-Gg: ASbGncvGZAvAXK8sP0pJnI22h6oEikC9AVQJval9+wQR92gzQMFd7LpmIIa5Nml2z6J
	pdkdc2KEV0fPSk/b0NaqgOv+APSiNjMiQb3qV131HEEoqHKdqmlaecZhsGaiAjQiqyzgEPEsm0u
	J/DYXXH5ipzFavs8CsgOybP0lmnusuuzjYup8rHThfrJ+jV0r+tgcSypy3Sw==
X-Google-Smtp-Source: AGHT+IH+S4XFi28gHGaMmeysqGWxl2iKRrtSLSEJMicA1DDHNUaljAuU7XuFwjXjeqVbjNrLs0Zn0OrBFYUEQy1rpZU=
X-Received: by 2002:a05:6820:1b8c:b0:601:b582:3a7a with SMTP id
 006d021491bc7-6020e038a4fmr116453eaf.4.1742224832322; Mon, 17 Mar 2025
 08:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313151744.34010-1-gasper.nemgar@gmail.com>
 <4970c2cd-9637-460a-8e85-bc44f7b0a550@redhat.com> <CAKi4K-hFHy4_F+fQghFNNR8cnkojPcE0uXQWsf5+5dbqjXGs0g@mail.gmail.com>
 <a6c79155-daac-4c2a-9b91-5c8480dc14b1@redhat.com> <b168d04e-0a71-45a5-898f-31555ce306fb@gmail.com>
In-Reply-To: <b168d04e-0a71-45a5-898f-31555ce306fb@gmail.com>
From: =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>
Date: Mon, 17 Mar 2025 16:20:10 +0100
X-Gm-Features: AQ5f1Jr1Wtjce7kIwJp9gygGmxnSHt2KzLVR0unUdkqWaEiZ9ryfs0M4BuvzRHY
Message-ID: <CAKi4K-gea7pS76=68C21KLV_YHk-K_jJ+CEKexz=+JuuZr9Yyg@mail.gmail.com>
Subject: Re: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1
 14imh9 unknown keys
To: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, ike.pan@canonical.com, 
	linux-kernel@vger.kernel.org, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the suggested ideas, I have found the document myself
and planned to implement this, currently i am occupied with my college
exams and will resume working on the patch as soon as possible. About
the Performance Meter (just below Delete) what you are talking about
doesn't affect this laptop, from my research only the function
`ideapad_wmi_notify` is called when that key is pressed,
`ideapad_acpi_notify` and then `ideapad_check_special_buttons` isn't.
Another thing, when the `platform_profile_cycle()` is called it
doesn't affect anything on the system except
/sys/firmware/acpi/platform_profile, is this intended and gnome just
doesn't handle it or is there something wrong.
I also tried to make the mic mute LED to start working but was unable
to, do you have any ideas as to how I would achieve this. I have
dumped the acpi tables and examined them and I don't think there is a
way through that. I will research other ways when I have the time, but
do you have any ideas in the meantime?
Thanks a lot

On Mon, 17 Mar 2025 at 15:08, Peter F. Patel-Schneider
<pfpschneider@gmail.com> wrote:
>
> On 3/16/25 4:41 AM, Hans de Goede wrote:
> > Hi Ga=C5=A1per,
> >
> > On 14-Mar-25 12:35 PM, Ga=C5=A1per Nemgar wrote:
> >> Thanks for the feedback,
> >>
> >> I will go over your notes here and explain things.
> >> The Eye button on windows triggeres "Eye Care mode" https://download.l=
enovo.com/consumer/mobiles_pub/yoga_9i_2-in-1_14_9_ug_en.pdf#page=3D50 <htt=
ps://download.lenovo.com/consumer/mobiles_pub/yoga_9i_2-in-1_14_9_ug_en.pdf=
#page=3D50>,  does linux have a keycode as something like this, i didn't fo=
und any, should we jus assign it to one of the programmable keys?
> >
> > Yes that sounds like the best solution.
> >
> >> I will handle the performance as you have suggested, thanks
> >
> > You're welcome.
> >
> >> The shift + prtSc i have made a mistake here, i meant the Fn + prtSc.
> >> Just PrtSc is handled by a different device ("AT Translated Set 2 keyb=
oard") and is not managed by this module. evtest told me it sends SysRq cod=
e which is intended and it triggers the selective screenshot.
> >
> > Right, e.g. GNOME does not really differentiate between sysrq/printscre=
en
> > and KEY_SELECTIVE_SCREENSHOT and always uses the dialog instead of maki=
ng
> > printscreen directly take a full screen screenshot. Still making this
> > the Fn + printscreen comboe send KEY_SELECTIVE_SCREENSHOT is the right =
thing
> > todo and is also done on other laptop models with the same icon.
> >
> >> If I assign the Fn + PrtSc to KEY_SELECTIVE_SCREENSHOT the evtest show=
s
> > me it triggers code 634 and code name is "?". Is this correct behaviour=
?
> >
> > This just means that your evtest is a bit old and does not know about
> > KEY_SELECTIVE_SCREENSHOT yet.
> >
> > Regards,
> >
> > Hans
>
> I have this laptop and did some digging to find out which keys use WMI, h=
ow
> they are described by Lenovo, what they do now, and a suggestion for what=
 to
> do with them if different.  I think that this is a comprehensive list.
> The descriptions are from the User Guide Yoga 9i 2-in-1 (14=E2=80=B3, 9) =
from Lenovo.
>
> Key: Microphone Mute (Fn+F4)
> WMI Code: 0x3e
> Described as: p43 Enables/Disables the microphone.
> Status: Already handled in ideapad_laptop
> Key: KEY_MICMUTE 248
>
> Key: Airplane Mode (Fn+F8)
> WMI Code: 0x3f
> Described as: p43 Enables/Disables airplane mode
> Status: Already handled in ideapad_laptop
> Key: KEY_RFKILL 247
>
> Key: Star with S inside (right of F12)
> WMI code: 0x1
> Described as: p27&43 Displays the Lenovo Smart Key quick launch panel.
> Status: Already handled in ideapad_laptop
> Key: KEY_FAVORITES 0x16c
>
> Key: Snip (Fn+PrtSrc)
> WMI Code: 0x2d
> Described as: p43 Opens the Snipping tool.
> Status: Proposed patch uses KEY_PROG3.
> Suggestion: KEY_CUT 137
> Note: If the snipping tool does a selective screenshot then the
> KEY_SELECTIVE_SCREENSHOT would be better.
>
> Key: Performance Meter (just below Delete)
> WMI Code: 0x3d
> Described as: p44 Switches the computer=E2=80=99s active operation mode.
> Suggestion: KEY_PROG4 203
> Rationale: There already is a mapping from a thermal management button to
> KEY_PROG4 in ideapad_laptop.
> Note: I think that it is better to not hardwire keys.
>
> Key: Speaker with gear (just below Perf key)
> WMI Code: 0x12
> Described as: p44 Switches the computer=E2=80=99s active audio mode.
> Status: Already handled in indeapad_laptop
> Key: KEY_PROG2 149
>
> Key: Eye (just below Speaker with gear key)
> WMI code: 0x45
> Desribed as: p44 Turns on/off the Eye Care mode.
> Status:  Proposed patch uses KEY_DISPLAYTOGGLE.
> Suggestion: KEY_BRIGHTNESS_CYCLE 243
> Rationale: This KEY_DISPLAYTOGGLE appears to be for switching screens, no=
t
> adjusting brightness/color.
>
> Key: Star (just below Eye key)
> WMI code: 0x44
> Described as: p44 Opens a custom (user-defined) app.
> Status: In proposed patch
> Key: KEY_PROG1 148
>
> Key: Fn+Esc
> WMI code: 0x2 or 0x3
> Described as: p20 Switch F<n> hotkey behaviour.
> Status: Explicitly ignored in ideapad_laptop, as the switching is done in=
 the
> device
>
> Key: Fn+spce
> Described as: p43 Adjusts the keyboard backlight. (Done in device.)
> WMI code: 0x41
> Status: The code is not mentioned in ideadpad_laptop. The backlight is
> adjusted by the device.
> Suggestion:  Document with an explicit ignore.
>
> Key: Fn+M
> Described as: p21 Enable/disable the touchpad.
> WMI code: 0x29
> Suggestion: KEY_TOUCHPAD_TOGGLE 0x212
>
> Key: Fn+N
> Described as: p21 Shows device information.
> WMI code: 0x2a
> Suggestion: KEY_ROOT_MENU 0x26a
> Note: There doesn't seem to be a really good match for this.
>
> Key: Fn+Q
> Described as: p21&32 Switch among different performance modes.
> WMI code: 0x3d
> Suggestion: KEY_PROG4 203
> Rationale: Same as Perf key
>
> Key: Fn+R
> Described as: p21&32 Change the display refresh rate.
> WMI code: 0x10
> Status: Already in ideapad_laptop.
> Key: KEY_REFRESH_RATE_TOGGLE 0x232
>
> peter
>
>
> >
> >
> >> On Fri, 14 Mar 2025 at 10:34, Hans de Goede <hdegoede@redhat.com <mail=
to:hdegoede@redhat.com>> wrote:
> >>
> >>      Hi Ga=C5=A1per,
> >>
> >>      Thank you for your patch.
> >>
> >>      First if all a few generic notes:
> >>
> >>      1. When sending out v2 of the patch please add
> >>         platform-driver-x86@vger.kernel.org <mailto:platform-driver-x8=
6@vger.kernel.org> to the Cc
> >>
> >>      2. The patch subject (first line of commit message) should have
> >>         a prefix describing the subsystem + driver, e.g. use:
> >>         "platform/x86: ideapad-laptop: Add a few new keymap entries"
> >>
> >>      3. Your patch is missing a signed-off-by, see:
> >>      https://www.kernel.org/doc/html/latest/process/submitting-patches=
.html#sign-your-work-the-developer-s-certificate-of-origin <https://www.ker=
nel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-=
developer-s-certificate-of-origin>
> >>
> >>      4. Your commit message / patch should also have a body, e.g.
> >>         the entirety of the commit message could look something like t=
his:
> >>
> >>      -- begin --
> >>      platform/x86: ideapad-laptop: Add a few new keymap entries
> >>
> >>      The Yoga 9 2 in 1 14imh9 introduces 4 new hotkeys which are not
> >>      yet in ideapad_keymap[], add entries to map these keys.
> >>
> >>      Signed-off-by: Ga=C5=A1per Nemgar <your-email-here>
> >>      -- end --
> >>
> >>      A few more specific remarks below based on looking at
> >>      this picture of the keyboard:
> >>
> >>      https://ardes.bg/uploads/original/lenovo-yoga-9-2-in-1-14-g9-5501=
78.jpg <https://ardes.bg/uploads/original/lenovo-yoga-9-2-in-1-14-g9-550178=
.jpg>
> >>
> >>      On 13-Mar-25 4:17 PM, Ga=C5=A1per Nemgar wrote:
> >>      > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/pl=
atform/x86/ideapad-laptop.c
> >>      > index 30bd366d7..af124aafe 100644
> >>      > --- a/drivers/platform/x86/ideapad-laptop.c
> >>      > +++ b/drivers/platform/x86/ideapad-laptop.c
> >>      > @@ -1308,6 +1308,14 @@ static const struct key_entry ideapad_ke=
ymap[] =3D {
> >>      >       /* Specific to some newer models */
> >>      >       { KE_KEY,       0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } }=
,
> >>      >       { KE_KEY,       0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> >>      > +     /*Star- (User Asignable Key)*/
> >>      > +     { KE_KEY,       0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
> >>
> >>      Ack.
> >>
> >>      > +     /*Eye*/
> >>      > +     { KE_KEY,       0x45 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGG=
LE } },
> >>
> >>      It looks like the laptop already does display-toggle as Fn-F7 alt=
hough
> >>      it like sends super + P for this (AKA meta + P).
> >>
> >>      So mapping this to KEY_DISPLAYTOGGLE seems wrong, what does this
> >>      do under Windows?
> >>
> >>      Maybe KEY_ZOOM ?
> >>
> >>      > +     /*Performance*/
> >>      > +     { KE_KEY,       0x3d | IDEAPAD_WMI_KEY, { KEY_SPORT } },
> >>
> >>      I think that instead of mapping this it should be handled special=
ly
> >>      and call platform_profile_cycle() instead of sending a key-press
> >>      to userspace
> >>
> >>      > +     /*shift + prtsc*/
> >>      > +     { KE_KEY,       0x2d | IDEAPAD_WMI_KEY, { KEY_PROG3 } },
> >>
> >>      Looking a the symbol on the keyboard this should send
> >>      KEY_SELECTIVE_SCREENSHOT
> >>
> >>      >
> >>      >       { KE_END },
> >>      >  };
> >>      >
> >>
> >>      Regards,
> >>
> >>      Hans
> >>
> >>
> >
> >
>

