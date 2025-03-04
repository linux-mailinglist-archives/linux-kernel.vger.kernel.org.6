Return-Path: <linux-kernel+bounces-544633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87BA4E382
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317BF1897486
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC32255228;
	Tue,  4 Mar 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZefE7sUr"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19613280CFC;
	Tue,  4 Mar 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101405; cv=none; b=ZRNSXFUDAT0oBNAMp+viZROvs2fTG9SfPi2issXa10AT5pADQ9HZEFhfUWDlyLTuWGwWAI4IJaYX2zJe9GnuMknrWTpDdpDDwEBDvFhBpSGVVWDngLiE6lM6dgnEIdi7Eh2JRst0ReYT1YjFXZuq0xk+tiVja+/U7cOTv/Ve+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101405; c=relaxed/simple;
	bh=Dn4+zLGkSbuBY9M3LhG1oiQATnMWEDzyvJWH0JyJhYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp55rsqrzOKs+yW4GA0iH+sSvs52G06InveVz5MxxGE2L4nMoLKUgXCACLXAv9mIHCCl+5O5PSeFfchZUs8t12c75h9BAnzNQNBUpIWnzGbqm0QsWcWNHRJjurNxZHQhYxMvASMajH6cZTHA13ZuF9m7ArWMwpFoTnH2vjJoKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZefE7sUr; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86929964ed3so5112252241.0;
        Tue, 04 Mar 2025 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741101401; x=1741706201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBExPiSD4X8jOCvNjsvczU6ubS0LpoXpsXfZrpLd6tg=;
        b=ZefE7sUrmiU+ZyT8b61DzxWaDHR709H+SQ9f4sKgQ3iED4fZgHRRgxPJhUJ2VmKTJE
         bwADBO++hwKjb7oAWuaKpp1wUhC9fJzor2XmyMGtMKCvLEZgpB1ntxDtTvOlKKbfdF2S
         WRtH5jxMZ9ndYWE5u0g3a0v313SI4LDiOdQfy1D5BWlfzZw3q6i8UB5beAw6HjiKWrhO
         QZrtnLTn9KI5x5qvruHNtR0LcL2KKTOyC9tr+B9yhEPjeBx/3qGnN+RhpS83MP+RDsZD
         Sbr7t7rhW5BIwBCv7rsCWBANJaeuQodQ4fEWexbLIA4WoKTQwMWmb6QbtEPIHKDXbYJP
         r6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101401; x=1741706201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBExPiSD4X8jOCvNjsvczU6ubS0LpoXpsXfZrpLd6tg=;
        b=LnXJ3Uya5+IBa5We9o7MCmMKzK87eIBJ86et7KWy0gNLdDL2IgbNzdmOqDYXT5rN90
         FEELoiPUEjkTNWOZ13mFF5FsqJm6Ym+MH/lNU1u9cHndrqHbJ9+8NV66gIsOUC+hPO7V
         yJtzVsb9Sse8shghC/IYBpMHZwgWwL9wo2i2m9n0sVjvfi7Fau8DQAOLf6w5AMjLfX5w
         sTM8vupdGiB3Tcx833DBmFZA8IbHJaTUDYPBxk41eWflOFJTxbtU4qI5u4dpR2QMSXyU
         R9BYVDkNP2mPjV0sCCb1GqWQGyGQhQuBV27GbqnTxotsgaXqpSwbg17td+s+46KDv4KU
         AUTg==
X-Forwarded-Encrypted: i=1; AJvYcCUSjpytGZP/TohHOrQR5I1wH5cTQhPw9YtuiYaARiCOaRpd25iF7rC6APcaPJKwuXJt1nCT02TnINY=@vger.kernel.org, AJvYcCVpIoLxc3061NiTG+L3ErEGmtLE8I+766yWOtkkLgDXPt7IuTJSs9uJzLvBW9yug2VFanbg01RZWiXGDLDr@vger.kernel.org, AJvYcCWE+JmBPWTM97u+/UOQgs1scuHotnCsDp2X/55psnlnEaUMSwnkOluTiA+QqhJYwuqKciDO7kUwrmAMis4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPQ/m/Nur7EyCGLutdGw9XcgNle+k0gBHw5LVznaifFqyijnr
	wsfsQeFr7SfeI0v3yiHtK7KYW6+RZVsRGvmZmfZeJZEHcgM8rnWodsItvLCla7xdnTJFTLxl6Ip
	UsBJPtxmXWupQCCdZkm6HlR6+KiU=
X-Gm-Gg: ASbGncuUwE3bVAoVdRFpgY32RYfsWN7ut21fxc4ziCQGxbZSPkWLCjc4pfAZQ6gq2nq
	XT9hNfQM/fh2uaBWYK2XR57QSIZAKLGbGfXPKNZ8K/aBGBz7M3VMGMMcXNP9+gqaMIEiGKrQKzE
	46hLE8BANqSzZQOfhMQCtPRGWY
X-Google-Smtp-Source: AGHT+IGiNXqMGZ/VCHM60oIynHo3ET2jPjUUoug+Y8PqqaIJx18YeTZsTGCb6GlaJbQZW0tfvKrzKsTqVti3TGE7cUI=
X-Received: by 2002:a05:6102:4189:b0:4c1:a53d:c24b with SMTP id
 ada2fe7eead31-4c1a53dc383mr3854575137.23.1741101400328; Tue, 04 Mar 2025
 07:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-initial-support-for-max77705-sensors-v2-1-58d2207c732b@gmail.com>
 <4e9a2383-108a-4440-8f55-77679a79e36e@roeck-us.net>
In-Reply-To: <4e9a2383-108a-4440-8f55-77679a79e36e@roeck-us.net>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 4 Mar 2025 18:16:29 +0300
X-Gm-Features: AQ5f1JqS56tyVOI6OUdCZnIl_32rX0ffxN2S021rHpFmP3HaKf7zWOvDUhUXb1w
Message-ID: <CABTCjFDsutg-BOKqH++_pYNaeX6SezVL0iyuePVA7m5gXA3Ftw@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (max77705) add initial support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 4 =D0=BC=D0=B0=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 14:38, Guen=
ter Roeck <linux@roeck-us.net>:
>
> On 3/4/25 03:08, Dzmitry Sankouski wrote:
> > Add support for max77705 hwmon. Includes charger input, system bus, and
> > vbyp measurements.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> > Maxim MAX77705 is a Companion Power Management and Type-C interface IC.
> > It includes charger and fuel gauge blocks, and is capable of measuring
> > charger input current, system bus volatage and current, and bypass
> > voltage.
>
> That makes me wonder if this should be implemented in drivers/power/suppl=
y/
> and utilize the power_supply->hwmon bridge. That seems to make more sense
> to me than implementing a separate hwmon driver.
>

This chip incorporates charger and fuel gauge, which are modeled as power
supply class drivers. These measurements, however, doesn't belong to any of
mentioned drivers. For example, ISYS is the system bus current, but it
not charger attribute, because charger output is split between battery and
system bus.

Powering diagram:

----------              ---------      ------------      --------------
|usb port|<--[input]--> |charger| <--> |fuel gauge| <--> |battery pack|
----------              ---------      ------------      --------------
                            |
                            |
                            |---> [system bus]

See also https://patches.linaro.org/project/linux-leds/patch/20241217-starq=
ltechn_integration_upstream-v12-2-ed840944f948@gmail.com/#952337

> >
> > Add support for mentioned measurements.
> > ---
> > Changes in v2:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v1: https://lore.kernel.org/r/20250225-initial-support-for-ma=
x77705-sensors-v1-1-2be6467628b0@gmail.com
>
> ???
>

sorry, I forgot to edit that

(...)
> > +static umode_t max77705_is_visible(const void *data,
> > +                                enum hwmon_sensor_types type,
> > +                                u32 attr, int channel)
> > +{
> > +     switch (type) {
> > +     case hwmon_in:
> > +             if (channel >=3D ARRAY_SIZE(voltage_channel_desc))
> > +                     return 0;
> > +
> > +             switch (attr) {
> > +             case hwmon_in_input:
> > +             case hwmon_in_label:
> > +                     return 0444;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
> > +     case hwmon_curr:
> > +             if (channel >=3D ARRAY_SIZE(current_channel_desc))
> > +                     return 0;
> > +
> > +             switch (attr) {
> > +             case hwmon_curr_input:
> > +             case hwmon_in_label:
> > +                     return 0444;
> > +             case hwmon_curr_average:
> > +                     if (current_channel_desc[channel].avg_reg)
> > +                             return 0444;
> > +             default:
> > +                     break;
> > +             }
> > +             break;
>
> The chip provides temperature measurements. Why not support it ?
>

It provides temperature sensing in the fuel gauge block, so it is handled t=
here.

> Also, how about limits ? Doesn't the chip support any ? There do
> seem to be some threshold registers.
>

It has a register in the charger block to limit IIN current. It also has VB=
YP
interrupt, but I didn't found how the limit is set. Actually, I have a feel=
ing
these measurements are implemented by chip firmware, rather than some IP
solution.

(...)

--=20
Best regards and thanks for review,
Dzmitry

