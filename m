Return-Path: <linux-kernel+bounces-172241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2D8BEF9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0504CB21B16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849C14D2BE;
	Tue,  7 May 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wMghhhUi"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33014B948
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119533; cv=none; b=Tm3FNhsXXpgUCGKYVf8AWxTJXMsXXTljSb/reKYlxngYtV/x43Ft9UQ3piZfPcw6LYLOZAw6pRFzuIBXlIRJSkkzVNZ4TY3Zm4N7pbHmIyuctqpMMnI1eiJNiNdmC0bptR6VY7DVX+XhGsUAxJMSJGCRpz6WZGEEi5bkeW5yPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119533; c=relaxed/simple;
	bh=JQAdyYWuhwKBYmw4hHYfT+A9fdZkS2hZ/X2x9KJ6QuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJJ4sV2/bnj7Nbsyc2p0nM4QvAYSjdnmY/3jB1uTv1tGgEI0RQYZZfgTCIH9r9gAuJEHwcJs0cZT6DZb/yAZNGqtXHweONHgd4mME00K9g+p2UtpzP/p3mQhg37MeW/xAHBxajnPSfPEPeI7ONiOJTVtrT82Zgtgv56tefdh5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wMghhhUi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso27606141fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715119529; x=1715724329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZgP7jpdsv/dUl2ys6fa9rwbhK4lwe+m8GADAr80/YU=;
        b=wMghhhUiuS6FIT1FuA2+TG4tZ2Cq0msqVDgwKfd1TKOxW+j1QB7UX3mb5Oi8VJiD99
         id7zSh66rfmhsDnrAhT+U5YT28oftNvo3rHu4clYgy2oGPSOVS0zvkUayBakDI83FarE
         53vEHuajcug+n1K6DCEktudBCpq+8B/Vzlkhui+xlWPRtLSDyNiKNPtM2XaeAxQhNx8A
         6V/93QBj8umPvdzQNN7dgaRHU1sA8h0PlPTWvkuymYuhc3Uh9NYJyU2da44OxOUUqD4H
         LPPESgQp2rIkyk9tYZZ9yIlfQ7jt+MaGfiauMYvUxOFdjIT/EGyhGFM9afTT8t5cedIf
         za0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715119529; x=1715724329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZgP7jpdsv/dUl2ys6fa9rwbhK4lwe+m8GADAr80/YU=;
        b=QaapmihXkam8C3qZYIqMWsgF8aNrJ78Kjn2Cga/XCL6OAmaR9EDEGbhihkurL4NcqZ
         BPPvzENoosYfAMngUrkVHglfeWifDhO1xnfWGZCnqi2k5jI+4IPsiUvLBgf4uTEfX/bW
         QEp25x9CRd3Ky17rBRqEdCx2rMkpVRiuE+ptuWnEuor8lGb8wXhVHHJWTqZYRpKJRV+O
         2qchAINCv7h4wHtPMMRHAeX8bvUnvi/EGKRAIyPSVzWiP44VN4x32LvE/1c3CGI7RuNE
         /zqIoft/DMOnhzO+VekRCedUymdX2x5dGRncc8KV/2jstK2+AknAMdRwFY3TRPaGmj4W
         z7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXXPa79rY1ybKKv0TVxdrPxgev7DcLI5TYezVcGRX8zjV8EkfJmUptq2FJ1mI/jn7uWvpQQfhCS3ChrVA/dkyt6b72Q8ETTPgqaYWGG
X-Gm-Message-State: AOJu0Yz+kdAYDgx+uagvSieu1WY85MkZ+P/bGy6MPuq8eJV1B95Mwnn/
	oLOTQIbQJKoP8HSSZft1HaZjmWPtQtq9JVRZPBpCkpSVssOSvi+C+lQS5EXCT2uaIpFElEyARHA
	RjCzLcvD+LKPVpqAgHMPoNgFyAxusDY+takKQ9g==
X-Google-Smtp-Source: AGHT+IFvKHzFe0AJuvFV82RMupkai0IeeabZ22c/dPyUMw7jnjuWACpWmEjkFFj67BZyZnWzl7LMOOq90MCJLgD6mNY=
X-Received: by 2002:a2e:9046:0:b0:2e1:a2d5:62c2 with SMTP id
 38308e7fff4ca-2e4476991d0mr5916811fa.33.1715119529223; Tue, 07 May 2024
 15:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com> <20240504-bmi120-v2-1-3b3ce6e1c3c6@gmail.com>
In-Reply-To: <20240504-bmi120-v2-1-3b3ce6e1c3c6@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 7 May 2024 17:05:18 -0500
Message-ID: <CAMknhBFUOUy+TVi+baCN-FoLT8N=G4vOD5CgVgaKzvsu502CDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: imu: bmi160: add support for bmi120
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Danila Tikhonov <danila@jiaxyga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 8:01=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trab=
arni@gmail.com> wrote:
>
> From: Danila Tikhonov <danila@jiaxyga.com>
>
> Add support for bmi120 low power variant of bmi160.
>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Co-developed-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 26 ++++++++++++++++++++------
>  drivers/iio/imu/bmi160/bmi160_i2c.c  |  3 +++
>  drivers/iio/imu/bmi160/bmi160_spi.c  |  3 +++
>  3 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi16=
0/bmi160_core.c
> index a77f1a8348ff..468aa80318fc 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -26,6 +26,7 @@
>  #include "bmi160.h"
>
>  #define BMI160_REG_CHIP_ID     0x00
> +#define BMI120_CHIP_ID_VAL     0xD3
>  #define BMI160_CHIP_ID_VAL     0xD1
>
>  #define BMI160_REG_PMU_STATUS  0x03
> @@ -112,6 +113,11 @@
>         .ext_info =3D bmi160_ext_info,                            \
>  }
>
> +const u8 bmi_chip_ids[] =3D {
> +       BMI120_CHIP_ID_VAL,
> +       BMI160_CHIP_ID_VAL,
> +};
> +
>  /* scan indexes follow DATA register order */
>  enum bmi160_scan_axis {
>         BMI160_SCAN_EXT_MAGN_X =3D 0,
> @@ -704,6 +710,16 @@ static int bmi160_setup_irq(struct iio_dev *indio_de=
v, int irq,
>         return bmi160_probe_trigger(indio_dev, irq, irq_type);
>  }
>
> +static int bmi160_check_chip_id(const u8 chip_id)
> +{
> +       for (int i =3D 0; i < ARRAY_SIZE(bmi_chip_ids); i++) {
> +               if (chip_id =3D=3D bmi_chip_ids[i])
> +                       return 0;

It looks like this will match either chip to either ID. If we do this,
then why check the ID at all?

Another approach could be to put the chip ID as the match data in
bmi160_*_match, then you would get the right ID based on the
compatible string.

> +       }
> +
> +       return -ENODEV;
> +}
> +
>  static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  {
>         int ret;
> @@ -737,12 +753,10 @@ static int bmi160_chip_init(struct bmi160_data *dat=
a, bool use_spi)
>                 dev_err(dev, "Error reading chip id\n");
>                 goto disable_regulator;
>         }
> -       if (val !=3D BMI160_CHIP_ID_VAL) {
> -               dev_err(dev, "Wrong chip id, got %x expected %x\n",
> -                       val, BMI160_CHIP_ID_VAL);
> -               ret =3D -ENODEV;
> -               goto disable_regulator;
> -       }
> +
> +       ret =3D bmi160_check_chip_id(val);
> +       if (ret)
> +               dev_warn(dev, "Chip id not found: %x\n", val);

This changes the error with probe failure to a warning, but the commit
message doesn't explain why. We always want to know why changes were
made. :-)

Should also probably be in a separate patch since changing the
behavior here is a separate change from adding support for a new chip.

>
>         ret =3D bmi160_set_mode(data, BMI160_ACCEL, true);
>         if (ret)

..

