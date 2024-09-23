Return-Path: <linux-kernel+bounces-335974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D897ED61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771421F22262
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206A19CD1B;
	Mon, 23 Sep 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LU9eZzdq"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9A77F2F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103066; cv=none; b=WhnppFIaF/z8tyEptH+PbxE7TndzxD2uvQe2dKZW8FT3RRbHFfhvUwSNhv0kTZ6s3x+rbXDUY+NwKhjaFRe+kjjXUwHg35f72QUZscaCXctj3rcCrBGa9WNfyRQFN73z8dIJrOuVdU0myTjABvUfmYbQdNA1hwTK3thdhqAbzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103066; c=relaxed/simple;
	bh=BsjiBnqrAUoClTsN7+h6hJtOPsIDoWFHkgfUY8gNaSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1n4vMg9dw7pi/dbOXnYyAM3qwRqRmFjzIVmf2p00lvBPBpQQGfpHCAgWBF1hyDRQMlJjQkMlMxII4IZZZHOaN1+ITdU/OYcfW0FH8cvPshSE6StwTWH4M39btVIQxqju5P1Pn/ELv8ElizZumXKeidANycljHJp8hvSBuvdMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LU9eZzdq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f759b87f83so45747321fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727103061; x=1727707861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4OUNFjDByLq9FRjOjUg0G9EEfy30+IfreUniUhssi4=;
        b=LU9eZzdq8W7MCX45vErNuHSMrDIXqCUBmRx7Y/TgbuYdVBlektvf7IgtMirUwyUA49
         Kqjtrn34SFnQILqiFyRaiNVSnc6i2sGr2AvmKRrlJroOk5SM6B50cmEK2zaHoLItnWHi
         1B/atNWXX1ydTV7JTmyT68vfzSKwqcpg3NxO5WHsD5DqItfDJXcbQBtoBmNiq5uHH0vH
         dx8sGw1T6aZ2X5c826/jVe8W6hUTAaJ/ywOjAe/K6WM9ikztlmZp4QCRqt+/1WRrUCNo
         kYmgQ2VfUwTBh7ZeNVu5+mv2mjHr3Fkja1psmnwR5/5eMH7sOc39tmdFJtIW13f/v3E/
         mvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727103061; x=1727707861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4OUNFjDByLq9FRjOjUg0G9EEfy30+IfreUniUhssi4=;
        b=m1uQuD27FrbTzNu7XuIqLSY0GYcU4wA62owi1W6xvZ69X3XDRo0U3nlHFVpxvlrZfq
         djhktUkx6IRzSJxvZ2Nmro+QHt+oqk5ZOjaPXqUMMmj2ux29eonuEYhkXwrsix1jk3tF
         vET65qJGEKbFPndEKxE178hz38uIVO+whOpWSqb5gyacm6kHhezs3CQNIx2gJeeitckq
         MdtI+HTyuxfoHItZNhev0uIik2F1qXLZ+DqkIEJV59aWGE/5+nc2hWAilImWiO3tsKBx
         2cW3vhgdOfn4ew3QxJUHXhC9njTFHBmgwHQv/4AwW5Vx8Rw4H+5GsejeHfW6KMBqQfSR
         PhCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw5A6rJterCwGSRfQsj/LnAQehOPXmx9CIQbR0KX7NIHW9LS5EujSvjO5gOIrWMFr9HMmvk52pkUkaKTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2IQphaaghMKdaAnh4fzX4GH05ozSvVl2UgUwM375nQwqCQgq
	mj/3I2qcWbnWbIT8yKLjjpoJTZRvYvp4U9pvvvSB6AdQuhwsAaoYbXqX7zHD8bXHLy5m2Q6tYRV
	+QCIuXr4R0HV4sdxvq/W1ZPQg2+a6fDuIgJUPuA==
X-Google-Smtp-Source: AGHT+IHc9xA0AFD7Yfw//MelyGncj9IdZ6HsoEM6nE1m1oiGo77DmPCbqw5ewHz2iMAEDz2rJOzQ4D6MhH5h66Sfe9U=
X-Received: by 2002:a05:651c:54b:b0:2f7:631a:6e0d with SMTP id
 38308e7fff4ca-2f7cc365e12mr62173071fa.12.1727103061396; Mon, 23 Sep 2024
 07:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919130444.2100447-1-aardelean@baylibre.com> <20240919130444.2100447-2-aardelean@baylibre.com>
In-Reply-To: <20240919130444.2100447-2-aardelean@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Sep 2024 16:50:49 +0200
Message-ID: <CAMknhBFso4RXhhLSN_x1JEDCi70y-2BDVHKAzuh=bp7dt7dgxA@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] iio: adc: ad7606: add 'bits' parameter to channels macros
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 3:04=E2=80=AFPM Alexandru Ardelean
<aardelean@baylibre.com> wrote:
>
> There are some newer additions to the AD7606 family, which support 18 bit
> precision. Up until now, all chips were 16 bit.
>
> This change adds a 'bits' parameter to the AD760X_CHANNEL macro and renam=
es
> 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
>
> The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for IIO
> channels in SW mode.
>
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---

...

> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 6649e84d25de..204a343067e5 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -8,7 +8,7 @@
>  #ifndef IIO_ADC_AD7606_H_
>  #define IIO_ADC_AD7606_H_
>
> -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {   \
> +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {     \
>                 .type =3D IIO_VOLTAGE,                            \
>                 .indexed =3D 1,                                   \
>                 .channel =3D num,                                 \
> @@ -19,24 +19,26 @@
>                 .scan_index =3D num,                              \
>                 .scan_type =3D {                                  \
>                         .sign =3D 's',                            \
> -                       .realbits =3D 16,                         \
> -                       .storagebits =3D 16,                      \
> +                       .realbits =3D (bits),                     \
> +                       .storagebits =3D (bits) > 16 ? 32 : 16,   \
>                         .endianness =3D IIO_CPU,                  \
>                 },                                              \
>  }
>
>  #define AD7605_CHANNEL(num)                            \
>         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
> -               BIT(IIO_CHAN_INFO_SCALE), 0)
> +               BIT(IIO_CHAN_INFO_SCALE), 0, 16)
>
> -#define AD7606_CHANNEL(num)                            \
> +#define AD7606_CHANNEL(num, bits)                      \
>         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
>                 BIT(IIO_CHAN_INFO_SCALE),               \
> -               BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +               BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
>
> -#define AD7616_CHANNEL(num)    \
> +#define AD7606_SW_CHANNEL(num, bits)   \
>         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SC=
ALE),\
> -               0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +               0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> +
> +#define AD7616_CHANNEL(num)    AD7606_SW_CHANNEL(num, 16)

It looks like the AD7616_CHANNEL macro is no longer used, so can be
dropped. Or alternately, don't change the lines below to use
AD7606_SW_CHANNEL.

With either of those changes:

Reviewed-by: David Lechner <dlechner@baylibre.com>

>
>  /**
>   * struct ad7606_chip_info - chip specific information
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 62ec12195307..e00f58a6a0e9 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -67,14 +67,14 @@ static const struct iio_chan_spec ad7616_sw_channels[=
] =3D {
>
>  static const struct iio_chan_spec ad7606b_sw_channels[] =3D {
>         IIO_CHAN_SOFT_TIMESTAMP(8),
> -       AD7616_CHANNEL(0),
> -       AD7616_CHANNEL(1),
> -       AD7616_CHANNEL(2),
> -       AD7616_CHANNEL(3),
> -       AD7616_CHANNEL(4),
> -       AD7616_CHANNEL(5),
> -       AD7616_CHANNEL(6),
> -       AD7616_CHANNEL(7),
> +       AD7606_SW_CHANNEL(0, 16),
> +       AD7606_SW_CHANNEL(1, 16),
> +       AD7606_SW_CHANNEL(2, 16),
> +       AD7606_SW_CHANNEL(3, 16),
> +       AD7606_SW_CHANNEL(4, 16),
> +       AD7606_SW_CHANNEL(5, 16),
> +       AD7606_SW_CHANNEL(6, 16),
> +       AD7606_SW_CHANNEL(7, 16),
>  };
>
>  static const unsigned int ad7606B_oversampling_avail[9] =3D {
> --
> 2.46.0
>

