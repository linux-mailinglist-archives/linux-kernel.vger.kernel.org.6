Return-Path: <linux-kernel+bounces-552325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C366A57864
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 05:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AC916D334
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E0E18787A;
	Sat,  8 Mar 2025 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUMDQ70U"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D117A313;
	Sat,  8 Mar 2025 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741409702; cv=none; b=Sp5MebhPGTURGRf/r/QB9zNgRiCpKy/IEddZRrTyvsfJ3uWIIayhDlfASt9pxoN1yuvh12ATDAg6R+KwrmVafOzc14rsTK0KedY+au635ozOdEvWnzvnKgXK+Hpb5tBtkasbApU0Ac5ODE27fQV1UGUXQzPQ9nEc0cPsRxzt25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741409702; c=relaxed/simple;
	bh=79eWymJ/dJNrOsnciOWzUUy1t7U9wwQ0z8U24msUpgo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=G4WWiFdaxuDKemG7f4Mg0lglbgBw0P65iVe+LNBZB8X3usnSxmZs1aUJS1H2ttEfNfFzqdJCEmwT1dP1swB48CusQClbZUu6BRG9Xr36akJLFp/I/fzxfu31S1yrplCfjSD5M/yh0R2EXaiEvT7w5RmTB/MJYQJjxMVQhKt6uXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUMDQ70U; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fb2a0e4125so17990857b3.1;
        Fri, 07 Mar 2025 20:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741409699; x=1742014499; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79eWymJ/dJNrOsnciOWzUUy1t7U9wwQ0z8U24msUpgo=;
        b=ZUMDQ70UQ61UP+l+YbWPJF8g2FWWkDZL9f7dY/s+tc7QrP/iKZ5ivn/SqFhn2yVkhJ
         kI9qkyk9MuQOguZyg8CPYHOXoQ5uOJYJZnao7hQIPukxKr/xT/Ftf9GDYZnb2jNmZZ9O
         Xrd/6yuT3l4yUTHmb0ltO/qQL/k0VpWjuJxhOl24h7minjFjW9C6btI39oThR0D7pNMZ
         obK3IhveR+TO/JS/Lup67c0jzy9S3OrKa2wjdmiKmDQfBYV96cBsCpGvw+s9XyLpxBUq
         LqwFUr4Nq+Qd49t9pxwurZHwytFf9zTLJ/VpkBUd21aRf2bmLb67TRRzSwJHfrcuXJ3f
         Hnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741409699; x=1742014499;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=79eWymJ/dJNrOsnciOWzUUy1t7U9wwQ0z8U24msUpgo=;
        b=B++YN7hPKGZA1ZLNrr/H+A6gPkbplqne4J/L+kbMHrZ2bMFvKnc9W9sQ6twuoPI5DW
         3NiF+M6BLQQJ9WcZl8W1xCpbYWwX8qFT350Q4ba9Fm/6GpeCniJNk7ibf7LOStIrQULU
         LGaHnLI8nbp2pJVrZPgQGBxxalncxehPsIzu5plIwg+cbzcrp1toueCGDJhnjGSnn6vs
         J/F003a7Z8TvoiJ3w07VMQgiKb3uzdQKKqNvRIqS/XT5uIztzqGYRca0oOYabJRAsFwH
         tmfoT68D5XHMVf0IiZk4jTSwnQcLwJUWCsxD1kHEImCHkfLWA5zWWxQGUP2SQnaq4jPU
         9RLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVen+/D2oi5mWReCrveve7HL4eSuC9MU3eA8v/qI4r2AwUenrSr7JRKxy8Wtplungdz3Ios3T0N9K28N9T2@vger.kernel.org, AJvYcCVfG3U8waBp8dPaRxyX1kYEEB83JzNBX9yQ7uS2f5HQ3pxbrNvSfHb+g/ioxsTaXGZuSdnDoRsZWrmGcw==@vger.kernel.org, AJvYcCXhls7iChZ0Zz6Njki0/nGclyiJplLAjFzqbJ6qTWV9yIkEwVBYy8nVJThCSFokkrhjvd5E9C1XZb2uQTPLQK594a6dHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyU82ckOSBRh9XrFXeVMCKxfE6dPjdVoW3W9baU+lAOIdpCFd
	Y0PgSBcPHelcD+fvFX+SByoh2LW0YuLcSosa9CyiVzLnd4ILV1Tr
X-Gm-Gg: ASbGncsD4hy95G7YYVsOqbz74PQW3uFYsxLHg4zLgitdt+O9VwD7ymkwhCLXJtYO8Ho
	i0OgvxOQnU9RjW0ZLi2VcRjCiVOUx/YD/I09T2powOhyernV1Bbkx5CRMx8+dleJMAqmiEk4OId
	D0ep/Xre1OtAxmR3jSThILjzWPRiHiOq8DZjT12Vh3qRfWKKb1ZoSQJbRKniTNyxDf4ClND7uSO
	rPqqeD1Y+4eNP3JksRipjm1eYryOMeAARoDjex8e6LTUbSywfW8JU2nFOfGqJN2gONEKKE4npWG
	AvwB+EO9SjxMv35d7a2GXaCnbw5349GlScDwp3KCrXtcPOc=
X-Google-Smtp-Source: AGHT+IHqmQr8ufHJU7mJvjQTEpig38FM22E1OhqXdH/0lA7fBKukKwvf6tzl3LD1WvgacVEosW13lg==
X-Received: by 2002:a05:690c:300f:b0:6fe:bf9d:f6de with SMTP id 00721157ae682-6febf9e0392mr59139037b3.0.1741409699282;
        Fri, 07 Mar 2025 20:54:59 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fed2a528f2sm1553507b3.62.2025.03.07.20.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 20:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Mar 2025 23:54:55 -0500
Message-Id: <D8AM7U5UNBX5.XYJUL18HC2M5@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Armin Wolf" <W_Armin@gmx.de>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
 <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-7-395e7a1407e2@gmail.com>
 <a375d474-5349-4662-8ce8-4f8f55349901@gmx.de>
 <D89M2ZQJEH45.1HKFFX5ESXRSJ@gmail.com>
 <7fbf0553-e6b3-4964-9210-8cd720ae9c9e@gmx.de>
 <7c850374-8caa-430d-b114-1aaa944bbc89@roeck-us.net>
In-Reply-To: <7c850374-8caa-430d-b114-1aaa944bbc89@roeck-us.net>

On Fri Mar 7, 2025 at 6:59 PM -05, Guenter Roeck wrote:
> On 3/7/25 13:09, Armin Wolf wrote:
>> Am 07.03.25 um 01:35 schrieb Kurt Borja:
> ...
>>>>> +static const struct hwmon_ops awcc_hwmon_ops =3D {
>>>>> +=C2=A0=C2=A0=C2=A0 .is_visible =3D awcc_hwmon_is_visible,
>>>>> +=C2=A0=C2=A0=C2=A0 .read =3D awcc_hwmon_read,
>>>>> +=C2=A0=C2=A0=C2=A0 .read_string =3D awcc_hwmon_read_string,
>>>>> +};
>>>>> +
>>>>> +static const struct hwmon_channel_info * const awcc_hwmon_info[] =3D=
 {
>>>>> +=C2=A0=C2=A0=C2=A0 HWMON_CHANNEL_INFO(temp,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_T_LABEL | HWMON_T_INPUT,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_T_LABEL | HWMON_T_INPUT,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_T_LABEL | HWMON_T_INPUT,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_T_LABEL | HWMON_T_INPUT,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_T_LABEL | HWMON_T_INPUT,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_T_LABEL | HWMON_T_INPUT
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ),
>>>>> +=C2=A0=C2=A0=C2=A0 HWMON_CHANNEL_INFO(fan,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MA=
X,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MA=
X,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MA=
X,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MA=
X,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MA=
X,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MA=
X
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ),
>>>>> +=C2=A0=C2=A0=C2=A0 HWMON_CHANNEL_INFO(pwm,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 HWMON_PWM_AUTO_CHANNELS_TEMP
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ),
>>>> Since the number of fans and temperature sensors is only known at runt=
ime creating awcc_hwmon_info
>>>> would make sense.
>>> IIRC Guenter asked another dev to add more CHANNEL_INFO entries instead
>>> of doing that? I might be wrong tho.
>>>
>>> I'm fine either way.
>>>
>> If Guenter is fine with your current approach then you can keep it.
>>=20
>
> In drivers/hwmon, I prefer static descriptions such as the above and usin=
g
> the is_visible() function to determine if sensor attributes should actual=
ly
> be created. However, as I have mentioned several times, I do not comment =
on style
> questions like this (or, for that matter, non-standard sysfs attributes) =
outside
> drivers/hwmon, so you can do or request whatever you like.
>
> Guenter

Thank you for clarifying!

If there are no objections, then I prefer to keep it this way. With the
few extra HWMON_CHANNEL_INFO entries.

--=20
 ~ Kurt


