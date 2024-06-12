Return-Path: <linux-kernel+bounces-211147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE80F904DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB90287D18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70DB16D4C6;
	Wed, 12 Jun 2024 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CX073G+2"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9D16D32E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179761; cv=none; b=OFde1nu+Gnnd9pPAFQ/hI/Gx9ZtwWDBKvnaiEiQDy97ffdVBsRQRbojDUlqMp3bd576NoJ6wzlhvmrEB/iGhLpzqwOHvcq9RCV0fggpNXJV35Hf6R3X7yIHI0gi6JSDBteJB4uHJR2DGH9JvBtvb1Kq8VK1e2n+5oY1UVYNewsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179761; c=relaxed/simple;
	bh=8sIAZSlf4WuNaF1daREKewN6nBaPdnh2z9v++bC1Sxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLLwTECV1GUAnyTdVbx9fDOpQM53PQ7qdETVa+t8lQ10/EzAb8RybcqKg1dzutvJSSP0Hco8Rh8GvtkprfIYgmCYR7zMsh8lrpUF09k8uxAEk64Jl5AI4WWxQte+yRo3/kTyDtHUx9W6dvjTrX1wt11gwiDtfcXK6ExmXgT7OZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CX073G+2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6266ffdba8so553522766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718179758; x=1718784558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKb/vtoIHaAuT7eS6tdIIVHB4rHiCLnX6z8pJYSRJNs=;
        b=CX073G+2J4UrWr0g5jkZCykyavT78RLczvO3pdB12x4v/McT4EoyEo47UQawEISB5j
         E+Nvo0mjwJW2YOGeYTL7X9wQwh2cDbcnyCjMKJtpoWGtF6bD3jc1HpqQD6FGvKmEaV/o
         1f44AmHNGQ5YlFOMjQyPzedQeCDR+GdRM065VRVB3S+54BY8n6b7XQLb2Lc/PVevEm5u
         dFTnwxCLhn/hFmYBb40raW/JPpxnC9DOrZGQ6MnnEVWiUDzBkORZPSO0hDH88qyMx5ml
         T3VPmOBdnyhMBDtvozmJDZdMq2/nUkrwZx6o8IhBxhEXwiabyY3GFvH7O2cLeef7x3sj
         i3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179758; x=1718784558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKb/vtoIHaAuT7eS6tdIIVHB4rHiCLnX6z8pJYSRJNs=;
        b=pr91jIh0HqI8ISd41elUwzg3UsmZsxuipXZjkZ/WFlFKlghcM37DtQgwv92Dod2w0v
         e5X4LY+89L2Zsui3u09c8zqIQtE5P11itHlUSlzhw6poN49NEDT6RLF1w2H59ipK2RBP
         C7Vecx/wAnAEXBUlwMA0Y+zBIm6t8a8X23CT8mrUWrngTJ4dFjFtDxmYtn43YDe7qcro
         piU39EwlAHyFfeBUu8OHreXftLhkWUBwSJqAlcLctI9myORVcrOAZpHkPc9XQsfbfpVl
         8EtHPtKaB9PZoY49xdhjYa+FCFgkSvIQgNn7ouiSmWGEwZhJPDhoyarWsTF6sBBIDgL8
         mUcA==
X-Forwarded-Encrypted: i=1; AJvYcCWquZ7uKE3HdCQHCxFlv1u5aFCnX1ybPzgeJN4wO1/yHh6jH0zrxkKoJDxEJmUPOVqMSWuaLvcKlRC6CZmJEF5A2YP4yBtM/5WOhuJt
X-Gm-Message-State: AOJu0YxOXZcWap4ye4l3kjGaHmzBERyHb61pN1hQteZjlz+yo2pfHSyt
	Q2YO9ppKo1hH5ALj8/Kssqo3c00Vrc4qM69CYcF0zHMvsa0glEPGUE/J2CcE+bs=
X-Google-Smtp-Source: AGHT+IEyUqS7xeGpS62654NQBM20ZnTsaBaQtVWFbZpKweR38cT7xpNYg2DKAqfcljsV5Jo8GYnSxQ==
X-Received: by 2002:a17:906:3c47:b0:a6f:1c38:3370 with SMTP id a640c23a62f3a-a6f47fad6b3mr75793666b.36.1718179757867;
        Wed, 12 Jun 2024 01:09:17 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f16427842sm439552466b.100.2024.06.12.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:09:16 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:09:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
	Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Saravanan Sekar <sravanhome@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
	Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RESEND][PATCH] iio: simplify with regmap_set_bits(),
 regmap_clear_bits()
Message-ID: <6grkkioyfqvjy37ztevbs7lbkhc4yfvvomwk7jx5qjmrsdihir@mlluicav2cvs>
References: <20240611165214.4091591-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kp4epuvmx3jkqhoq"
Content-Disposition: inline
In-Reply-To: <20240611165214.4091591-1-tgamblin@baylibre.com>


--kp4epuvmx3jkqhoq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Trevor,

On Tue, Jun 11, 2024 at 12:52:06PM -0400, Trevor Gamblin wrote:
> Simplify the way regmap is accessed in iio drivers.
>=20
> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
>=20
> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> CC list got suppressed on first submission, so resending. Sorry about
> that.
>=20
>  drivers/iio/accel/adxl313_core.c              |   4 +-
>  drivers/iio/accel/adxl313_spi.c               |   4 +-
>  drivers/iio/accel/fxls8962af-core.c           |  18 ++--
>  drivers/iio/accel/kxsd9.c                     |   6 +-
>  drivers/iio/accel/msa311.c                    |   6 +-
>  drivers/iio/adc/ad4130.c                      |   4 +-
>  drivers/iio/adc/axp20x_adc.c                  |   5 +-
>  drivers/iio/adc/axp288_adc.c                  |   4 +-
>  drivers/iio/adc/bcm_iproc_adc.c               |   8 +-
>  drivers/iio/adc/berlin2-adc.c                 |  24 ++---
>  drivers/iio/adc/cpcap-adc.c                   |  44 +++-----
>  drivers/iio/adc/fsl-imx25-gcq.c               |  16 ++-
>  drivers/iio/adc/ina2xx-adc.c                  |   3 +-
>  drivers/iio/adc/intel_mrfld_adc.c             |   4 +-
>  drivers/iio/adc/meson_saradc.c                | 101 ++++++++----------
>  drivers/iio/adc/mp2629_adc.c                  |  19 ++--
>  drivers/iio/adc/qcom-spmi-rradc.c             |  50 +++++----
>  drivers/iio/adc/rn5t618-adc.c                 |   5 +-
>  drivers/iio/adc/sc27xx_adc.c                  |  41 ++++---
>  drivers/iio/adc/stm32-dfsdm-adc.c             |  29 +++--
>  drivers/iio/dac/ltc2688.c                     |   5 +-
>  drivers/iio/dac/stm32-dac-core.c              |   5 +-
>  drivers/iio/gyro/bmg160_core.c                |   4 +-
>  drivers/iio/gyro/mpu3050-core.c               |  33 +++---
>  drivers/iio/health/afe4403.c                  |   9 +-
>  drivers/iio/health/afe4404.c                  |   9 +-
>  drivers/iio/health/max30100.c                 |   5 +-
>  drivers/iio/health/max30102.c                 |   5 +-
>  .../imu/inv_icm42600/inv_icm42600_buffer.c    |  14 ++-
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   9 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |   4 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |   4 +-
>  drivers/iio/light/adux1020.c                  |  13 ++-
>  drivers/iio/light/iqs621-als.c                |   4 +-
>  drivers/iio/light/isl29018.c                  |   6 +-
>  drivers/iio/light/st_uvis25_core.c            |   4 +-
>  drivers/iio/light/veml6030.c                  |   4 +-
>  drivers/iio/magnetometer/ak8974.c             |  11 +-
>  drivers/iio/magnetometer/mmc35240.c           |   8 +-
>  drivers/iio/pressure/bmp280-core.c            |   4 +-
>  drivers/iio/proximity/sx9324.c                |   5 +-
>  drivers/iio/proximity/sx9360.c                |   5 +-
>  drivers/iio/proximity/sx9500.c                |  12 +--
>  drivers/iio/proximity/sx_common.c             |   9 +-
>  drivers/iio/temperature/mlx90632.c            |   4 +-
>  drivers/iio/trigger/stm32-timer-trigger.c     |  34 +++---
>  46 files changed, 273 insertions(+), 351 deletions(-)

I found five more drivers below drivers/iio that could benefit from such
a conversion:

 drivers/iio/adc/ad7173.c                      |  2 +-
 drivers/iio/adc/ti-ads1298.c                  | 13 ++++++-------
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  8 ++++----
 drivers/iio/light/veml6075.c                  |  4 ++--
 5 files changed, 15 insertions(+), 16 deletions(-)

But even without addressing these:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks for picking up my suggestion,
Uwe

--kp4epuvmx3jkqhoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZpV6cACgkQj4D7WH0S
/k5HtQf/VeZ8OLgNz7dXrFmR7AQ9UOUpW7yE/aNJ/0jp+/7SKFUid8kLelq2CIon
ZVEOQoxGVhsBhSmzwJGvZf6cOMAu4nWRuACbap5soHOv/ycOA3QIKizvIGt1TEEh
0/VqnqKzkXb9oxxMVSpN3tbFXRuYlvx7+jpdDVoguOBsVI5jeZb+AXseQscpy/nt
qD1t26pVyaJH3/Rhp0912HRYo6zsvpSCWJ/IssmngcMCXSnCjNUYK8mWeQX+QG47
rd6Yx/Q79PT6dB778e1LYvrOx5QTfFUe1NjjNJP+SjJH8mHE8CRBLdBXAVQJGfMf
tXTZy24yn6DSipC1sqLciFOAvQns1A==
=/peH
-----END PGP SIGNATURE-----

--kp4epuvmx3jkqhoq--

