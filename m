Return-Path: <linux-kernel+bounces-303481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B81960CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29521C2316D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C01C32E5;
	Tue, 27 Aug 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CpjVyVLy"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633C1A0721
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766844; cv=none; b=LplTR53mVyeHM7QcSkcE0wzCZ6KWoteCT57qp8VxxOyNoQFGo+lvctTVcAA6fC0cuV++dqhsaxxupWjVeGJYALVe2DaWQjENuvyZJV5rQaxgbNDGWBeYQiE6dauvs6phMr308favI6WsIMb8T6gYM372T7UZT2ubZWICPM7R+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766844; c=relaxed/simple;
	bh=44SZCDbcmzG09AQZ50x/Dy0zdigrMGUoG2ovPXzcraY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwLTWLh2hGYIxpniH6DYw7IsetO4FQBWnNJFvKSC+V0jmXEdkyWe95P7k+sUlYKLTsN7icpgeBF4mOcK/KEQRoKocUAFiHfIPme6z61IH2/9jCwovCbvvQgFVymg7f5GicUCP7jKMqYCqwz37bd9rxK86b2lDnBUErXtbFKaMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CpjVyVLy; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-842f91f2545so1503121241.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724766841; x=1725371641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKxMqQG/y28P0kTx7Xe5S5QMMuqHP6qRbSeqqy9q1io=;
        b=CpjVyVLy5c/V9kneWzvGwtHgUsw8nK6uGRWNfs/gjunmnxJqN+ariYsTRTH0bzT09p
         y6yOe3icMii+wpKRlQh0Ogk8BamOwXXAIY/DmSqvFZAetMufv5CpMyK7KfdQ6yp7MEn2
         9gSeZcQAYRmWzmLah4jLn6+ZLl+ZZMWzwqJloEOywEPFX1cuSX0CcI5IcKwECHMYtK/z
         cIHssH2NWfu9liPRij15fpYzEHjguohQ/2Dxv8O0mM68iuT4mGy1smXQzq2d+Nf3dEf4
         sfSo1Df+SIROCcTm/Hbb/FKYRWs3afzj6ZOxqI+pyS75PI/scm/xsQa7j9GLs7tuVV4/
         tN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766841; x=1725371641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKxMqQG/y28P0kTx7Xe5S5QMMuqHP6qRbSeqqy9q1io=;
        b=nfE/py6Zji7TLfditQIggcyc69O63rbXSnlKdZfAJrhTdAEFGL0SBYl7UTY2XvhgWh
         XU8HrCQsVsc3R5+8vyknrxwZqvTWg0BCg0RtUQ62nd/CXqyZU6/mMtcLuVnHScMgaR62
         vXtA2L8uRCdABVBjpAG3TPo2H8YkD8CuAk+hPGOpSlCj63h/Mf67qtX8EjVKUJq/ZTsU
         tHvCUvgmBxa/JEXryPl39yiTEVVsbP8yFZ/JIuECaToxlTtyAaKn/oZWFp9anAWgUSYU
         LG7DF+o0fpxSwQLkQI3aLu6m4REoUtJijFzgI7nXkkNXxoqT7nJvi6ROVpy+cz81FNMc
         UQmw==
X-Forwarded-Encrypted: i=1; AJvYcCU0k/D+rUkKW7HYU9BLEdtkwYhMywwDNU/miWWNjy1ZdoxFE9b1Avo35uugue9qY+nywBWVmbqU/CTmEfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx800ZWrn8VBYEvlN76AdMy7IYzk/IQAHpydvIKBV8VQOBXqX/N
	iUSd16vXmlLpxUWsMACRxEA3nI0iHCmEuIMenFLlydDwW4CzgZ1IsT01BxUoi7uPpmSOLTewDZ7
	8eNSDAuYaO5di5NLSSXYQPJPrnHDt+t9hOAv6bQ==
X-Google-Smtp-Source: AGHT+IFJBKlcd3fVo5oPev8XGIfBhFCYIhK7+76gcZGfvbdrMN/1PzVakFvXI+Y+D4GZ1/51eWthgnEpHo6/gYqnOLc=
X-Received: by 2002:a05:6122:1689:b0:4f2:a973:8ae with SMTP id
 71dfb90a1353d-4fd1a52c651mr15262226e0c.5.1724766841131; Tue, 27 Aug 2024
 06:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819064721.91494-1-aardelean@baylibre.com>
 <20240819064721.91494-2-aardelean@baylibre.com> <20240823195251.032c0c22@jic23-huawei>
In-Reply-To: <20240823195251.032c0c22@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 27 Aug 2024 16:53:50 +0300
Message-ID: <CA+GgBR_uH2GMY_KVfiQOhs32anZo+3-NK2piYcQv+HiBOsSxLQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: adc: ad7606: add 'bits' parameter to channels macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:53=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 19 Aug 2024 09:47:11 +0300
> Alexandru Ardelean <aardelean@baylibre.com> wrote:
>
> > There are some newer additions to the AD7606 family, which support 18 b=
it
> > precision.
>
> Hi Alexandru,
>
> > Up until now, all chips were 16 bit.
> >
> > This change adds a 'bits' parameter to the AD760X_CHANNEL macro and ren=
ames
> > 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
> >
> > The AD7606_CHANNEL_PER_CHAN_SCALE() macro is also introduced, as it wil=
l
> > also require that the number of bits be correctly adjusted (for 18 bit
> > parts).
> Where is that introduced?  There is a _SW_ variant of one macro that isn'=
t
> mentioned...

Right.
My famous forgetting to update commits after updating code a few times.
Will update.

>
> J
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7606.c     | 58 ++++++++++++++++++------------------
> >  drivers/iio/adc/ad7606.h     | 18 ++++++-----
> >  drivers/iio/adc/ad7606_spi.c | 16 +++++-----
> >  3 files changed, 47 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index 539e4a8621fe..dba1f28782e4 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -333,16 +333,16 @@ static const struct iio_chan_spec ad7605_channels=
[] =3D {
> >       AD7605_CHANNEL(3),
> >  };
> >
> > -static const struct iio_chan_spec ad7606_channels[] =3D {
> > +static const struct iio_chan_spec ad7606_channels_16bit[] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(8),
> > -     AD7606_CHANNEL(0),
> > -     AD7606_CHANNEL(1),
> > -     AD7606_CHANNEL(2),
> > -     AD7606_CHANNEL(3),
> > -     AD7606_CHANNEL(4),
> > -     AD7606_CHANNEL(5),
> > -     AD7606_CHANNEL(6),
> > -     AD7606_CHANNEL(7),
> > +     AD7606_CHANNEL(0, 16),
> > +     AD7606_CHANNEL(1, 16),
> > +     AD7606_CHANNEL(2, 16),
> > +     AD7606_CHANNEL(3, 16),
> > +     AD7606_CHANNEL(4, 16),
> > +     AD7606_CHANNEL(5, 16),
> > +     AD7606_CHANNEL(6, 16),
> > +     AD7606_CHANNEL(7, 16),
> >  };
> >
> >  /*
> > @@ -357,22 +357,22 @@ static const struct iio_chan_spec ad7606_channels=
[] =3D {
> >   */
> >  static const struct iio_chan_spec ad7616_channels[] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(16),
> > -     AD7606_CHANNEL(0),
> > -     AD7606_CHANNEL(1),
> > -     AD7606_CHANNEL(2),
> > -     AD7606_CHANNEL(3),
> > -     AD7606_CHANNEL(4),
> > -     AD7606_CHANNEL(5),
> > -     AD7606_CHANNEL(6),
> > -     AD7606_CHANNEL(7),
> > -     AD7606_CHANNEL(8),
> > -     AD7606_CHANNEL(9),
> > -     AD7606_CHANNEL(10),
> > -     AD7606_CHANNEL(11),
> > -     AD7606_CHANNEL(12),
> > -     AD7606_CHANNEL(13),
> > -     AD7606_CHANNEL(14),
> > -     AD7606_CHANNEL(15),
> > +     AD7606_CHANNEL(0, 16),
> > +     AD7606_CHANNEL(1, 16),
> > +     AD7606_CHANNEL(2, 16),
> > +     AD7606_CHANNEL(3, 16),
> > +     AD7606_CHANNEL(4, 16),
> > +     AD7606_CHANNEL(5, 16),
> > +     AD7606_CHANNEL(6, 16),
> > +     AD7606_CHANNEL(7, 16),
> > +     AD7606_CHANNEL(8, 16),
> > +     AD7606_CHANNEL(9, 16),
> > +     AD7606_CHANNEL(10, 16),
> > +     AD7606_CHANNEL(11, 16),
> > +     AD7606_CHANNEL(12, 16),
> > +     AD7606_CHANNEL(13, 16),
> > +     AD7606_CHANNEL(14, 16),
> > +     AD7606_CHANNEL(15, 16),
> >  };
> >
> >  static const struct ad7606_chip_info ad7606_chip_info_tbl[] =3D {
> > @@ -382,25 +382,25 @@ static const struct ad7606_chip_info ad7606_chip_=
info_tbl[] =3D {
> >               .num_channels =3D 5,
> >       },
> >       [ID_AD7606_8] =3D {
> > -             .channels =3D ad7606_channels,
> > +             .channels =3D ad7606_channels_16bit,
> >               .num_channels =3D 9,
> >               .oversampling_avail =3D ad7606_oversampling_avail,
> >               .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avai=
l),
> >       },
> >       [ID_AD7606_6] =3D {
> > -             .channels =3D ad7606_channels,
> > +             .channels =3D ad7606_channels_16bit,
> >               .num_channels =3D 7,
> >               .oversampling_avail =3D ad7606_oversampling_avail,
> >               .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avai=
l),
> >       },
> >       [ID_AD7606_4] =3D {
> > -             .channels =3D ad7606_channels,
> > +             .channels =3D ad7606_channels_16bit,
> >               .num_channels =3D 5,
> >               .oversampling_avail =3D ad7606_oversampling_avail,
> >               .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avai=
l),
> >       },
> >       [ID_AD7606B] =3D {
> > -             .channels =3D ad7606_channels,
> > +             .channels =3D ad7606_channels_16bit,
> >               .num_channels =3D 9,
> >               .oversampling_avail =3D ad7606_oversampling_avail,
> >               .oversampling_num =3D ARRAY_SIZE(ad7606_oversampling_avai=
l),
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index 0c6a88cc4695..771121350f98 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -8,7 +8,7 @@
> >  #ifndef IIO_ADC_AD7606_H_
> >  #define IIO_ADC_AD7606_H_
> >
> > -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) { \
> > +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {   \
> >               .type =3D IIO_VOLTAGE,                            \
> >               .indexed =3D 1,                                   \
> >               .channel =3D num,                                 \
> > @@ -19,24 +19,26 @@
> >               .scan_index =3D num,                              \
> >               .scan_type =3D {                                  \
> >                       .sign =3D 's',                            \
> > -                     .realbits =3D 16,                         \
> > -                     .storagebits =3D 16,                      \
> > +                     .realbits =3D (bits),                     \
> > +                     .storagebits =3D (bits),                  \
> >                       .endianness =3D IIO_CPU,                  \
> >               },                                              \
> >  }
> >
> >  #define AD7605_CHANNEL(num)                          \
> >       AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
> > -             BIT(IIO_CHAN_INFO_SCALE), 0)
> > +             BIT(IIO_CHAN_INFO_SCALE), 0, 16)
> >
> > -#define AD7606_CHANNEL(num)                          \
> > +#define AD7606_CHANNEL(num, bits)                    \
> >       AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
> >               BIT(IIO_CHAN_INFO_SCALE),               \
> > -             BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> > +             BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> >
> > -#define AD7616_CHANNEL(num)  \
> > +#define AD7606_SW_CHANNEL(num, bits) \
> >       AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SC=
ALE),\
> > -             0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> > +             0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> > +
> > +#define AD7616_CHANNEL(num)  AD7606_SW_CHANNEL(num, 16)
> >
> >  /**
> >   * struct ad7606_chip_info - chip specific information
> > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.=
c
> > index 287a0591533b..dd0075c97c24 100644
> > --- a/drivers/iio/adc/ad7606_spi.c
> > +++ b/drivers/iio/adc/ad7606_spi.c
> > @@ -67,14 +67,14 @@ static const struct iio_chan_spec ad7616_sw_channel=
s[] =3D {
> >
> >  static const struct iio_chan_spec ad7606b_sw_channels[] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(8),
> > -     AD7616_CHANNEL(0),
> > -     AD7616_CHANNEL(1),
> > -     AD7616_CHANNEL(2),
> > -     AD7616_CHANNEL(3),
> > -     AD7616_CHANNEL(4),
> > -     AD7616_CHANNEL(5),
> > -     AD7616_CHANNEL(6),
> > -     AD7616_CHANNEL(7),
> > +     AD7606_SW_CHANNEL(0, 16),
> > +     AD7606_SW_CHANNEL(1, 16),
> > +     AD7606_SW_CHANNEL(2, 16),
> > +     AD7606_SW_CHANNEL(3, 16),
> > +     AD7606_SW_CHANNEL(4, 16),
> > +     AD7606_SW_CHANNEL(5, 16),
> > +     AD7606_SW_CHANNEL(6, 16),
> > +     AD7606_SW_CHANNEL(7, 16),
> >  };
> >
> >  static const unsigned int ad7606B_oversampling_avail[9] =3D {
>

