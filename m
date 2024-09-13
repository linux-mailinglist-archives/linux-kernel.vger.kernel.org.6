Return-Path: <linux-kernel+bounces-328127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31006977F36
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E11C21C15
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437651D86EC;
	Fri, 13 Sep 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QPaFNfe/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72F1D88D4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229055; cv=none; b=fj2VgBItDwzPWXPWZcR5z4Vezms84O3r5X+UUO35k6iLOtn/79ZXyCswhEunRoUeAjll9M1FrJOTb827MfwA8NDTnkNDwXL4FjbRSzapZ5FYvIwR+f6NDd1ajCe4Jqt83LFA+VGSTkoycu1eYQGJeXCjuQPgzPn6VxZKdStsUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229055; c=relaxed/simple;
	bh=k9kZPHPhjlFedxi2BTcX+2wc3SebhNfzustyrKJeAmM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DeTevvHxD8eN5Pf/lTfTwCVdCYSlE4evzCwwVdCGkEK52jsEoagXp6YoHc6cF1rCiyg+C028cQV3m0EJ6SNjPND4VfU/nePfa1NSbrY11Sms9bTR/gR+dcdEpVcoH8zTiqVjG9bU1F+l7qqD/UyfA5rbWIdbnGDINNvXjWhkXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QPaFNfe/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb806623eso18851185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726229050; x=1726833850; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGSAMjSOLd61VP4y6gqf8nhkY/Om2FO5l8i4tEiPSrQ=;
        b=QPaFNfe/Nss2JR5mABWmHv5joXy2v2KumpzdT2xz9gMywbZPQrWbaM8i5UTMMAgqhe
         mmnHDb39K2emPhmb5MOMQmrXDJeCe0wsZMNQO4BbKgrZmOsfxhOoZbsWl7IJod0i8075
         cmj59utulQZF5d1ymJmSnn6a8weHgCOqKS0uxXHSTZN5a370WkqG1q0Z5WODRgntyMz4
         LEid829yPzbiOX1tPWIkhzpx9xsJW3v40IqPlr/rZVQff4gp41JXXEL2yu4WexbNqecF
         41jb+L8bKUpVBPbSCkwYmalAl2F8GWBAVNuiLeC6/CvP0RCCo1JBGWaXbK61+ejtd3CU
         Jtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229050; x=1726833850;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XGSAMjSOLd61VP4y6gqf8nhkY/Om2FO5l8i4tEiPSrQ=;
        b=dP5xg0J16oKddpeddrONuNcNGF64Zeoj6KEjay/Bm9HZHy8LtY8qxkvdID8kGaGCrM
         cVHGtG2IZNn4zOgzfMHW819Fk1wJpJOO3WUCF/c9KSZlvR7XNv3HT76F9DGlisw3VRkj
         DFczDY1HMfjvDFF7DK1obes+zJi0YD9o45+5osVM+zbK+57aTlzRg9PUrVzm1Cxxuvxp
         oD4wn4joFTNb1TgRFguh9ky5FzYy349KbIB6BeP8N1Jv2zVgJHr/87/8wce3PzxqtcjK
         cocYArCqKK7YH6lYULEQcf4/c1WWJHA6RD9vknOy5dhwIl6QSHl/97LBCAccGHoWt256
         b8gg==
X-Forwarded-Encrypted: i=1; AJvYcCXcsR6+BX2JBE+GQQgDYCqZ5Uuhly/+CPrp1W3xkpjjSCmqiD/i3iMHAtltw7s+MALDS1xFhFvflnLx+2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyryn8nuybr/wmsX5UCGK32naXzu1UFszQd0LHS8tSybt4JL6Ho
	5DbYIHaJG6fUgo8rRfmHejlld+mWaxnDwaqgb7aVWNKQYb7xqL02dNKnatOaWzc=
X-Google-Smtp-Source: AGHT+IHZnZr0EqY02Ab2sJcM/6QWgSbf9WyIXNplySB+jxpY2oqGPEbn2ZL+hIT8UFSIR08Co35uCA==
X-Received: by 2002:adf:f94f:0:b0:371:8e0d:c1d9 with SMTP id ffacd0b85a97d-378c2d07281mr3732080f8f.19.1726229050140;
        Fri, 13 Sep 2024 05:04:10 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3738sm16689605f8f.69.2024.09.13.05.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 05:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Sep 2024 12:04:08 +0000
Message-Id: <D4554LAXBVEX.2Z0H6XMUIPOUB@baylibre.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/6] iio: adc: ad4030: add driver for ad4030-24
From: "Esteban Blanc" <eblanc@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, "Lars-Peter Clausen" <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Nuno Sa"
 <nuno.sa@analog.com>, "Jonathan Corbet" <corbet@lwn.net>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
 <28fa2ba9-9b02-43ac-b070-85a173a5db60@baylibre.com>
 <3c2e0d65225f20c04722f017f7866a47c346782e.camel@gmail.com>
In-Reply-To: <3c2e0d65225f20c04722f017f7866a47c346782e.camel@gmail.com>

On Fri Sep 13, 2024 at 10:22 AM UTC, Nuno S=C3=A1 wrote:
> Hi Esteban,
>
> Just one remark...
>
> On Thu, 2024-08-22 at 14:39 -0500, David Lechner wrote:
> > On 8/22/24 7:45 AM, Esteban Blanc wrote:
> > > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> > >=20
> > > The driver implements basic support for the AD4030-24 1 channel
> > > differential ADC with hardware gain and offset control.
> > >=20
> > > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> > > ---
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 13 +
> > > =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/ad4030.c | 854 ++++++++++++++++++++++++++++++++=
+++++++++++++++
> > > =C2=A04 files changed, 869 insertions(+)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f17c42bea19c..6a5a0e7b7a51 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -420,6 +420,7 @@ R:	Esteban Blanc <eblanc@baylibre.com>
> > > =C2=A0S:	Supported
> > > =C2=A0W:	https://ez.analog.com/linux-software-drivers
> > > =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> > > +F:	drivers/iio/adc/ad4030.c
> > > =C2=A0
> > > =C2=A0AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
> > > =C2=A0M:	Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 88e8ce2e78b3..f4bd05780f6f 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -33,6 +33,19 @@ config AD4000
> > > =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the =
module will be
> > > =C2=A0	=C2=A0 called ad4000.
> > > =C2=A0
> > > +config AD4030
> > > +	tristate "Analog Device AD4630 ADC Driver"
> > > +	depends on SPI
> > > +	depends on GPIOLIB
> > > +	select REGMAP_SPI
> >=20
> > It looks like we are just using REGMAP, not REGMAP_SPI.
> >=20
> > > +	select IIO_BUFFER
> >=20
> > And also select IIO_TRIGGERED_BUFFER?
> >=20
> > > +	help
> > > +	=C2=A0 Say yes here to build support for Analog Devices AD4030 and =
AD4630
> > > high speed
> > > +	=C2=A0 SPI analog to digital converters (ADC).
> > > +
> > > +	=C2=A0 To compile this driver as a module, choose M here: the modul=
e will be
> > > +	=C2=A0 called ad4030.
> > > +
> > > =C2=A0config AD4130
> > > =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> > > =C2=A0	depends on SPI
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 8b80664c6d6b..0e4f833abf0b 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -7,6 +7,7 @@
> > > =C2=A0obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> > > =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> > > =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> > > +obj-$(CONFIG_AD4030) +=3D ad4030.o
> > > =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> > > =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> > > =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> > > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > > new file mode 100644
> > > index 000000000000..a981dce988e5
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ad4030.c
> > > @@ -0,0 +1,854 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Analog Devices AD4030 and AD4630 ADC family driver.
> > > + *
> > > + * Copyright 2024 Analog Devices, Inc.
> > > + * Copyright 2024 BayLibre, SAS
> > > + *
> > > + * based on code from:
> > > + *	Analog Devices, Inc.
> > > + *	=C2=A0 Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > > + *	=C2=A0 Nuno Sa <nuno.sa@analog.com>
> > > + *	=C2=A0 Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > + *	=C2=A0 Liviu Adace <liviu.adace@analog.com>
> > > + */
> > > +	.type =3D IIO_VOLTAGE,						\
> > > +	.indexed =3D 1,							\
> > > +	.channel =3D _idx * 2 + 2,					\
> > > +	.scan_index =3D _idx * 2 + 1,					\
> > > +	.extend_name =3D "Channel" #_idx " common byte part",		\
> >=20
> > Labels are usually one word and reflect the datasheet name.
> >=20
> > Suggest `"common-mode" #_idx` or `"CM" #_idx` for this one.
> >=20
>
> Also, .extend_name is not to be used anymore... In the end of the day IIO=
 will create
> label files anyways but from what I remember about this, extend_name is n=
ot to be
> directly used this anymore (so other think it's still fine). Instead, use=
 the label
> callback.

Yeah, Jonathan or David mentioned it. I'm using `.read_label` callback
now.

Thanks for your time,

--=20
Esteban Blanc
BayLibre


