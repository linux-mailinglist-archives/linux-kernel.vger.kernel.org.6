Return-Path: <linux-kernel+bounces-194496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B21B8D3D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1261C23466
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC715ADA3;
	Wed, 29 May 2024 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MexWv8wR"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5510A35
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002044; cv=none; b=CQ9JWVyo8phN4wDyRSoN7WJszCbdeE2OfgpwUhVxWZMct0v68IvchH0/Xo+h8bUSGbR8UfjpCeFXZ42RugHP6lZoR7qIlRblDxFxUmyqpBvkIPdKBG0ppbpsGfDvvgHSUxNX275E40nteWZHFtZaqSnAImxMbuEBXDbR4EHC4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002044; c=relaxed/simple;
	bh=bu7NemNpKFWjO/TMFN45dKSrd4mpHQUTXoAEcBKTrDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb/MFhFKrQAZdA0g2LSz+f6c0yFp1sKJoo9yHttdMVb37tBOVvMMeavas/cIDgyElE8eRTej5bsbgN83lW5RdioNgYOeYw1zPDqgxe16nKqvG0/EeIyH+AXstosf/3vOVBUIP/2U+7b0zfPnrdTFV7jrv1UqJvE8NPypSwD/TUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MexWv8wR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso553a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717002041; x=1717606841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoiH6lwmGs4PCawaoWyQsbF1ZjB3aSEqZRmZUUflfr8=;
        b=MexWv8wRG+kMBoVgKVpRzGNzcZndfD6xFQI8n/c+n6yi/TnJ8aRPnyi9P7rZpT7FQl
         gsoCfHkFANgsGQobbUrhAHV15zfDkFXIDXXwpAAJvwG+ZQY/2Fz2+Pg0FXkeYZpEvENB
         YvjEEu+1gHsyPtgvC1p3qE6bOyNf1sV6Nz0g8pNpRxJiAu3zShFMh8FiJgFIGYojun7Z
         eOftMXuvKvAtVZRQvFyan0yzV0+wou0MJ3q3G0/I+JhPrJ7XE2uwMCQguUnCKHKO7zc7
         Y/fpND9QkGt1vTr1dXO0WbMZ7eJwHPyTKfhLGS1siQWkg0jUD4qv/0uZTYAi6mV2yLKl
         fAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002041; x=1717606841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoiH6lwmGs4PCawaoWyQsbF1ZjB3aSEqZRmZUUflfr8=;
        b=IsIIEETHWPO2c60nXXI2TvAb9cf7Id7xgb36OeHilfFx5FtqQmjFcLcfDGdVWBKFMT
         kU3ZenuJZtYo3wF6mY4uaqzxliXajCOSzjMUaw9Kx1/nxLHNUm/ojsGP6vTfVXTcZtOt
         JnmFbV8+x42Yp62WjW0i4XZTeFQU9PacUGQ4NBhCnb4IbiI3aa4F08EKkjbtYSJhOxMv
         yioz/gXVKmLBtZFpiY0qje0ARfzOkwdMoYQ6zC/+ipLd7EMvnNam5wLLZb/hsOiRSw2C
         9x0woAIqK7hoEu9yW6qDvkVPp1nh1Kr2OErp8m+ATCcY8XUhUEmHBoD1WIsiOCU5p3eD
         Kodg==
X-Forwarded-Encrypted: i=1; AJvYcCUyCLvN71qZZQXSO+68/oHuCBYfrGlIyv3sxjzJHVx4lL2JCrNNzhus0jlBTmQ+M+a3QqBzAbEiKZgT+SiOGscVFFX0HjnGVG6mLWBN
X-Gm-Message-State: AOJu0YyKIMoJa0zjRez2ymqTClo/N1bny4TVAkk09UThVo7f4BVe4Yj9
	gKehVJSL5WHr1VP2FnpI+LI6+tzb3u2QqJZdLFablnSn8naJqFAB1sDjQAjHjJxo3JKaMdNdZKX
	ybG5Eg+FCCVHRQuLnLvDhPz9lXlKSuLFu3kUZ
X-Google-Smtp-Source: AGHT+IGiepejwPJySSOJTS8Vdh/jCe6ATC7+zN+DhmTfyw6FDv0F1k25j/gWlegvODKQm49Var2SQjMrbaSqv9YkIEo=
X-Received: by 2002:a05:6402:290f:b0:578:33c0:f00e with SMTP id
 4fb4d7f45d1cf-57a02fcb5dfmr233619a12.0.1717002040619; Wed, 29 May 2024
 10:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net> <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <9cf224dd-51eb-4608-abcf-06f337d08178@t-8ch.de> <SY4P282MB306325BB023A95198F25A21DC5F12@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <c9b110eb-ff0e-41f2-9492-8a5d8c3c01d0@roeck-us.net> <b8072b36-688f-41b8-8b32-40fc4fa4d148@t-8ch.de>
 <6824f030-92da-4439-af3b-8c2498f4382e@roeck-us.net> <SY4P282MB30638301303268093B6D1ABFC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <22a16af6-93c4-454c-853b-5959a5c018d3@t-8ch.de> <SY4P282MB30634D9D9873C9C8DC41D4EEC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB30634D9D9873C9C8DC41D4EEC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 29 May 2024 10:00:27 -0700
Message-ID: <CABXOdTcyuR-YJYoMrAh11ksYcL-6LZPFERw94Z8-mTgMUfLP3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Dustin Howett <dustin@howett.net>, Mario Limonciello <mario.limonciello@amd.com>, 
	Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:40=E2=80=AFAM Stephen Horvath
<s.horvath@outlook.com.au> wrote:
>
> Hi Thomas,
>
> On 29/5/24 16:23, Thomas Wei=C3=9Fschuh wrote:
> > On 2024-05-29 10:58:23+0000, Stephen Horvath wrote:
> >> On 29/5/24 09:29, Guenter Roeck wrote:
> >>> On 5/28/24 09:15, Thomas Wei=C3=9Fschuh wrote:
> >>>> On 2024-05-28 08:50:49+0000, Guenter Roeck wrote:
> >>>>> On 5/27/24 17:15, Stephen Horvath wrote:
> >>>>>> On 28/5/24 05:24, Thomas Wei=C3=9Fschuh wrote:
> >>>>>>> On 2024-05-25 09:13:09+0000, Stephen Horvath wrote:
> >>>>>>>> Don't forget it can also return `EC_FAN_SPEED_STALLED`.
> >
> > <snip>
> >
> >>>>>>>
> >>>>>>> Thanks for the hint. I'll need to think about how to
> >>>>>>> handle this better.
> >>>>>>>
> >>>>>>>> Like Guenter, I also don't like returning `-ENODEV`,
> >>>>>>>> but I don't have a
> >>>>>>>> problem with checking for `EC_FAN_SPEED_NOT_PRESENT`
> >>>>>>>> in case it was removed
> >>>>>>>> since init or something.
> >>>>>>>
> >>>>>
> >>>>> That won't happen. Chromebooks are not servers, where one might
> >>>>> be able to
> >>>>> replace a fan tray while the system is running.
> >>>>
> >>>> In one of my testruns this actually happened.
> >>>> When running on battery, one specific of the CPU sensors sporadicall=
y
> >>>> returned EC_FAN_SPEED_NOT_PRESENT.
> >>>>
> >>>
> >>> What Chromebook was that ? I can't see the code path in the EC source
> >>> that would get me there.
> >>>
> >>
> >> I believe Thomas and I both have the Framework 13 AMD, the source code=
 is
> >> here:
> >> https://github.com/FrameworkComputer/EmbeddedController/tree/lotus-zep=
hyr
> >
> > Correct.
> >
> >> The organisation confuses me a little, but Dustin has previous said on=
 the
> >> framework forums (https://community.frame.work/t/what-ec-is-used/38574=
/2):
> >>
> >> "This one is based on the Zephyr port of the ChromeOS EC, and tracks
> >> mainline more closely. It is in the branch lotus-zephyr.
> >> All of the model-specific code lives in zephyr/program/lotus.
> >> The 13"-specific code lives in a few subdirectories off the main tree =
named
> >> azalea."
> >
> > The EC code is at [0]:
> >
> > $ ectool version
> > RO version:    azalea_v3.4.113353-ec:b4c1fb,os
> > RW version:    azalea_v3.4.113353-ec:b4c1fb,os
> > Firmware copy: RO
> > Build info:    azalea_v3.4.113353-ec:b4c1fb,os:7b88e1,cmsis:4aa3ff 2024=
-03-26 07:10:22 lotus@ip-172-26-3-226
> > Tool version:  0.0.1-isolate May  6 2024 none
>
> I can confirm mine is the same build too.
>
> >  From the build info I gather it should be commit b4c1fb, which is the
> > current HEAD of the lotus-zephyr branch.
> > Lotus is the Framework 16 AMD, which is very similar to Azalea, the
> > Framework 13 AMD, which I tested this against.
> > Both share the same codebase.
> >
> >> Also I just unplugged my fan and you are definitely correct, the EC on=
ly
> >> generates EC_FAN_SPEED_NOT_PRESENT for fans it does not have the capab=
ility
> >> to support. Even after a reboot it just returns 0 RPM for an unplugged=
 fan.
> >> I thought about simulating a stall too, but I was mildly scared I was =
going
> >> to break one of the tiny blades.
> >
> > I get the error when unplugging *the charger*.
> >
> > To be more precise:
> >
> > It does not happen always.
> > It does not happen instantly on unplugging.
> > It goes away after a few seconds/minutes.
> > During the issue, one specific sensor reads 0xffff.
> >
>
> Oh I see, I haven't played around with the temp sensors until now, but I
> can confirm the last temp sensor (cpu@4c / temp4) will randomly (every
> ~2-15 seconds) return EC_TEMP_SENSOR_ERROR (0xfe).
> Unplugging the charger doesn't seem to have any impact for me.
> The related ACPI sensor also says 180.8=C2=B0C.
> I'll probably create an issue or something shortly.
>
> I was mildly confused by 'CPU sensors' and 'EC_FAN_SPEED_NOT_PRESENT' in
> the same sentence, but I'm now assuming you mean the temp sensor?
>

Same here. it might not matter as much if the values were the same,
but EC_FAN_SPEED_NOT_PRESENT =3D=3D 0xffff,  and
EC_TEMP_SENSOR_NOT_PRESENT=3D=3D0xff, so they must not be confused with
each other. EC_TEMP_SENSOR_NOT_PRESENT should be static as well,
though, and not be returned randomly.

Guenter

> >>>>>>> Ok.
> >>>>>>>
> >>>>>>>> My approach was to return the speed as `0`, since
> >>>>>>>> the fan probably isn't
> >>>>>>>> spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` a=
nd
> >>>>>>>> HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
> >>>>>>>> No idea if this is correct though.
> >>>>>>>
> >>>>>>> I'm not a fan of returning a speed of 0 in case of errors.
> >>>>>>> Rather -EIO which can't be mistaken.
> >>>>>>> Maybe -EIO for both EC_FAN_SPEED_NOT_PRESENT (which
> >>>>>>> should never happen)
> >>>>>>> and also for EC_FAN_SPEED_STALLED.
> >>>>>>
> >>>>>> Yeah, that's pretty reasonable.
> >>>>>>
> >>>>>
> >>>>> -EIO is an i/o error. I have trouble reconciling that with
> >>>>> EC_FAN_SPEED_NOT_PRESENT or EC_FAN_SPEED_STALLED.
> >>>>>
> >>>>> Looking into the EC source code [1], I see:
> >>>>>
> >>>>> EC_FAN_SPEED_NOT_PRESENT means that the fan is not present.
> >>>>> That should return -ENODEV in the above code, but only for
> >>>>> the purpose of making the attribute invisible.
> >>>>>
> >>>>> EC_FAN_SPEED_STALLED means exactly that, i.e., that the fan
> >>>>> is present but not turning. The EC code does not expect that
> >>>>> to happen and generates a thermal event in case it does.
> >>>>> Given that, it does make sense to set the fault flag.
> >>>>> The actual fan speed value should then be reported as 0 or
> >>>>> possibly -ENODATA. It should _not_ generate any other error
> >>>>> because that would trip up the "sensors" command for no
> >>>>> good reason.
> >>>>
> >>>> Ack.
> >>>>
> >>>> Currently I have the following logic (for both fans and temp):
> >>>>
> >>>> if NOT_PRESENT during probing:
> >>>>     make the attribute invisible.
> >>>>
> >>>> if any error during runtime (including NOT_PRESENT):
> >>>>     return -ENODATA and a FAULT
> >>>>
> >>>> This should also handle the sporadic NOT_PRESENT failures.
> >>>>
> >>>> What do you think?
> >>>>
> >>>> Is there any other feedback to this revision or should I send the ne=
xt?
> >>>>
> >>>
> >>> No, except I'd really like to know which Chromebook randomly generate=
s
> >>> a EC_FAN_SPEED_NOT_PRESENT response because that really looks like a =
bug.
> >>> Also, can you reproduce the problem with the ectool command ?
> >
> > Yes, the ectool command reports the same issue at the same time.
> >
> > The fan affected was always the sensor cpu@4c, which is
> > compatible =3D "amd,sb-tsi".
> >
> >> I have a feeling it was related to the concurrency problems between AC=
PI and
> >> the CrOS code that are being fixed in another patch by Ben Walsh, I wa=
s also
> >> seeing some weird behaviour sometimes but I *believe* it was fixed by =
that.
> >
> > I don't think it's this issue.
> > Ben's series at [1], is for MEC ECs which are the older Intel
> > Frameworks, not the Framework 13 AMD.
>
> Yeah sorry, I saw it mentioned AMD and threw it into my kernel, I also
> thought it stopped the 'packet too long' messages (for
> EC_CMD_CONSOLE_SNAPSHOT) but it did not.
>
> Thanks,
> Steve

