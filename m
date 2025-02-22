Return-Path: <linux-kernel+bounces-526829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC42A403FA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C140D176884
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226DB2C181;
	Sat, 22 Feb 2025 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2WgT39T"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5353FFD;
	Sat, 22 Feb 2025 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183429; cv=none; b=llDfyo53jS9+2zGHaV6dvcoNaQfLEkmEOai2HaxBxbHgBZovSKjQhBg7lD0HvfsoggNxKSjCrvgSDeGvf0qK2AiJZvZkFzrXJedgxf683P68htXv/v+C5j1ZSYKW5fBOLC8TSVUY9XUZ+dAYUUpDmLXz/wwPMCbIt//F3VBp54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183429; c=relaxed/simple;
	bh=qr85W/PiRzoYKCP0ImmABGA3K9TQe+z/nrWXd81Rydg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5Nvi0rEjRZXjtl0/qXV1snjlwNg5EkLakxzBIk9AQQdTGdhr2qd1Qjq6X06BXwQvid/XXRyv166s4geVHMoXa2oa6cEqdtqZwGpexOz/LpTi/hbOhSa+tFbiGL/7bYoApDN+jJZR5sgOkek2Q85PDH/OglVmV6+L/hdeVtiBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2WgT39T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2212a930001so75607955ad.0;
        Fri, 21 Feb 2025 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740183427; x=1740788227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8r7+y5SJBip6iQOe2wHWa44kb87aSgNqK+A4dnbHC4=;
        b=d2WgT39T6I4e5RgcOwEizuTAGXFO8DW5IzwotRaWkYjtNKwWPKao5jOdxuxItZoDNp
         320SGklTL6YkJNrZcgAPSa0xAsLZ1I5UMAlTT1IKDNLKVFnSYPZd8nBHGlqbx8UVIGcf
         vSJonXsQX+LohIlv97rJCOHmpaadH31+162HuAFoC5Oihz6PQEI0uVZ9pnyvd7D0OGOR
         Q9itpnv4Z6/fxkxI5ZRl73AWM+ASflIemAkN99nfolVcbvMcTi3rpvWvLMK2H16mCMo2
         /DW4pWIJWI4qCy7SUKh7QM7hBHX33fQP1tZvK9a8i5IHNR7OCwhC7iAl58jg6ZOFMfez
         5TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183427; x=1740788227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8r7+y5SJBip6iQOe2wHWa44kb87aSgNqK+A4dnbHC4=;
        b=sqzlo3HLI3cKu/fsjHKvQxCch1j/YpUKI3823nWnb8cjOCAj4CD4Onc78foDTkL44A
         Qbs1zlAyKFU28SVau5wug/02x9zt7qvyMrTOIkdy7NjZoqvG51Wda6b86QCQLURcNgYb
         A0gtnNu32OU9Opy+dzNwYzzxLJ2nZX/6yg3IdI9nuncBGCA5+hDaKIkKtX2+Shp6TJMJ
         m4kF3Exi0eZpXMtbvJFRLYLhyUdKY/QKf0GpVYjcu5HsLfym10XTNknp7ZJPDOesR1bl
         Cc8OzIJiC8Ut/TUj6fnQ0knVaa17pL+zMZj6YmbO0QRZ8BInpFDWENG06Zh7YQdUTJCX
         ke3w==
X-Forwarded-Encrypted: i=1; AJvYcCVDmTEuAD0NU7xtUaOk4jhN0zgmIbI8RfvVxfKbezRIBIU06jYUvm5Div4/VKvqklx8JApMk5e5rkCf@vger.kernel.org, AJvYcCVSXCNWE8XPCrTXVsSs/XEzXmhgeNmyXTwRPfAv9ifEmK7O9BWW4BiNTaxWzsJrnYKZyUVdAkNNPsLGewNu@vger.kernel.org, AJvYcCWrAqZnUdsaT420lxVanRVipAZzcN6lfOLlNg3bXBgled1d6uEODSgLVpavxryzW3RmxkYLAvW3xzctSfg=@vger.kernel.org, AJvYcCXB2SKFmbGEf+ed9fyAnos9rCVymD9OGXM3LJUgC7u6o8bytS1/JL4OsCREXWNJv2LPqXN36hItZRE38bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0DkKmoutaHdt/aGewPBupmLGJOR/iilQWMEMpGUSj1ObrNse
	bG906lS0+XYTHG3wpgAW50Gdr8gQD3E2G+3ssBxdCmmAO27nKBrv
X-Gm-Gg: ASbGncunVEyolgM8eV8vFYWSKZmMjGNtCGiXyt5WApYApDBGrFyDSt8cANKDVJDXS0y
	mJLSd4kfzPgwj4lQZclp0SFOASRhJT5Abbxnkh6gUVTlxruznkx10m2tKjQOEqRad21e+teXKUa
	ppvovq/AZw3xPD4HKb1s59Tyn5h2JEtbN4uCQUwJz+Sh2wuEVzGfo1qmREmlxuOdU9LHRDrB/xx
	DibKtgPmK7hJPL6vTKeteec5TmNfQm3DqC0yROxp67h0gzgTJWlstQzZKywLRQZX6DnerZT69DW
	npA9v6vCKgkLEHyZGN87wN5t4piPA2RzCLk4U4CZ72TFxB9ZAlqYtqaTWjRSurcXmQitz0D3cLN
	1ayAuDgf8EdKdyG/C+VQ3YTlA
X-Google-Smtp-Source: AGHT+IE1KT+jsLeYcAoG6RbWaNlaDRP+N3w0uHd3VKbF9XIGUtNL+tdpdnurdl0Wr+EIr+ZaQK09lQ==
X-Received: by 2002:a17:903:1cc:b0:220:e336:94e with SMTP id d9443c01a7336-221a0ed738emr72468355ad.15.1740183427150;
        Fri, 21 Feb 2025 16:17:07 -0800 (PST)
Received: from setsuna.localnet (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d039sm141779875ad.133.2025.02.21.16.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:17:06 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>,
 Jean Delvare <jdelvare@suse.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Martin =?UTF-8?B?UG92acWhZXI=?= <povik+lin@cutebit.org>,
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 14/29] ASoC: tas2770: expose die temp to hwmon
Date: Sat, 22 Feb 2025 10:16:57 +1000
Message-ID: <4993899.31r3eYUQgx@setsuna>
In-Reply-To: <409e8873-5ebd-41af-8162-30668271be6a@roeck-us.net>
References:
 <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <CAHgNfTzfK4HnYs+LDH7kcR+pZqSxT9YBZYQ=c+Mcpva4Vx=D_w@mail.gmail.com>
 <409e8873-5ebd-41af-8162-30668271be6a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 22 February 2025 1:03:38=E2=80=AFam Australian Eastern Standar=
d Time=20
Guenter Roeck wrote:
> On 2/21/25 03:31, James Calligeros wrote:
> > On Wed, Feb 19, 2025 at 1:20=E2=80=AFAM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >> On 2/18/25 00:35, James Calligeros wrote:
> >>> +static int tas2770_hwmon_read(struct device *dev,
> >>> +                           enum hwmon_sensor_types type,
> >>> +                           u32 attr, int channel, long *val)
> >>> +{
> >>> +     struct tas2770_priv *tas2770 =3D
> >>> i2c_get_clientdata(to_i2c_client(dev)); +     int ret;
> >>> +
> >>> +     switch (attr) {
> >>> +     case hwmon_temp_input:
> >>> +             ret =3D tas2770_read_die_temp(tas2770, (int *)val);
> >>=20
> >> Type casting a pointer like this is never a good idea. This only works
> >> if sizeof(int) =3D=3D sizeof(long).
> >=20
> > I will rework this when dropping the die temp sysfs interface. This
> > was mostly so that
> > I didn't have to change any of the code there, but since we're going
> > to drop that
> > anyway it's redundant.
> >=20
> >>> +             if (!ret)
> >>> +                     *val *=3D 1000;
> >>=20
> >> The calculations in the previous patch suggest that this is wrong.
> >>=20
> >> Either case, this is redundant. The temperature is already displayed
> >> as device specific sysfs attribute. Displaying it twice does not make
> >> sense. I would suggest to either drop the sysfs attribute in the
> >> previous patch or to drop this patch.
> >=20
> > The calculation in the datasheet yields the temperature in degrees
> > Celsius.
> > hwmon consumers expect temperatures in "millidegrees" Celsius as per the
> > sysfs interface documentation[1]. Regardless, as above I will likely
> > rework this
> Yes, I am well aware of that.
>=20
> > when dropping the die temp sysfs interface so that things are a little
> > more logical.
>=20
> Unless I really misread the code, tas2770_read_die_temp() doesn't return
> the temperature in degrees C.
>=20
> Guenter

My mistake. We return an intermediate value that is then manipulated in
die_temp_show() to yield degrees. I will clean this up for the next submiss=
ion
since we will no longer require the sysfs interface at all. Apologies for t=
he
confusion.

Regards,
James




