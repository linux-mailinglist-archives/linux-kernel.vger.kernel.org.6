Return-Path: <linux-kernel+bounces-228327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E5915E29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D86B1F22C01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FB014375C;
	Tue, 25 Jun 2024 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDVdHOge"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751313D244
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719293462; cv=none; b=n0Jl8caM324sykaRVo/xMipp3KT6GEW9jDc2b1SVjHCvGeTTPz+ji0qvdSvOsg5AryNAPCnFk4306QimVOWtfTz+HQKZFgmLDT0KHMT7cCWmbhl1FlyDwVXjVzKCEIgbm+egV6mpIX+fcZNaUIxV5ZzwPqHf9A01TfCr9xqrliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719293462; c=relaxed/simple;
	bh=EWg0LszmD2FWUuf5dzncr0aHObfLW2WZLpSUkktkRp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im9A1e96j4KtpXj3a7GXVbvOLNh4wTcAJEm+NMLzeEBP9m2aSjF5PpUx8YD9004TZpVDPhi3QzuFUZ3kJ77vpp5Z9BsALKoa2NzjWFShVJ4rd87R7elJlmuJf2ivQ65ipulXVkadpRuYl/8q/J3zcPYUHD8/Mqbmn8vMy041fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDVdHOge; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ef7c2e6bcbso70164e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719293458; x=1719898258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH4xT6oKyRDlJ/9SAo1hScjTVdx2cvP+qkd1fBGGz6Q=;
        b=LDVdHOge/K728smVwmsifzsiRrOkTbjXd1DB6kBdx4QW5YRADu11ckkMxLN+8QEmes
         CI0FR61oRK15ab/lpi2FZoxhwHVMgVkgx+Ly6IQE2BIfipkO0vHDPMu+dAdhGo6MhA5f
         VWvWyIeUcMoMu8lZMkdgPco1DsAosm4uBHfPqYvm7nRNEHaTY4qhFOVUKOUSzePOrpEM
         sfxUxqg8pSKRk9ZDr45UMNfpBF3502UuJSq52ci87zezGuskXV3juiSt62HCgo01KClH
         YxDwGzlEJ4Pbj8mUmcyys9izuvoBHEWhkPO2/yGdX74pwYRc0C7wE/wlpuyxD1bt8gp2
         7K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719293458; x=1719898258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fH4xT6oKyRDlJ/9SAo1hScjTVdx2cvP+qkd1fBGGz6Q=;
        b=TFU42wdcn3xYwH7kg+rX9l4v9WBb4s6ipAj7iFtkhleZr78hKUIMyEzNLo4W357N53
         pzbHma7jDKNAe4DmLelS0yrGC1H6IOMdWX0Ve5RircskiSn2RkOHOtXmDi6RFwgwKZ7L
         YBs1yeq+fPgKuCRmSu/Y1nu0HbeRZlU0kYYQNOuye0SZFoT88WpvXxI+uvhn9HuIe+KI
         aXXn17fH+uOHOJVQJEvyE10XmFa3NuLGFYp/Ge8UWVB/y9NMn6HR8mfxDSnnLAPErQt2
         2o/Yhuh/2zcT1zaevnvehivGJ8L77oyikXeYPMbh62Bz9TbjZIHAdWyrvF8UleBItDYT
         /Cpg==
X-Forwarded-Encrypted: i=1; AJvYcCV31SpGZHTJj/WYC9K8V+3R3LEFjPtXD3mYwWU96/8oAUbtFT1prbsdj6CUc1uN8Ol71q7sHa/q+HpW9q8d5l6RK6EBrv6r11VNwl6s
X-Gm-Message-State: AOJu0Yz7Izjmcr0xEnhubzphJP4DWdLhfy+n932dN1b+UdaMbpOJMxnt
	gb58pt2T6awVMxT5qTkaM0SrjcBIqUp9MuN84rX80P6GcaYfYfQLH/SvzshfJNBcdMBO3q72fl+
	Dx9n0aRt/zLrqVhQmhrDsi0VyvZicP8Pa2TcYBw==
X-Google-Smtp-Source: AGHT+IF1mvfwo/UQmf3qvzPkzrgA++cDgEF4wvUt2ZNU0MSeSH5sybGDUJbRd4oF+QdtPNEJrw7NC382zZONIdEp1yg=
X-Received: by 2002:a05:6122:4f85:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4ef612cdf88mr6901984e0c.1.1719293458411; Mon, 24 Jun 2024
 22:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624124941.113010-1-alisa.roman@analog.com> <20240624124941.113010-4-alisa.roman@analog.com>
In-Reply-To: <20240624124941.113010-4-alisa.roman@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 25 Jun 2024 08:30:47 +0300
Message-ID: <CA+GgBR9V=SqeA2fbeBDUO=Cr1s6GTbq6_779uQmiKCF2EjkHBg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] iio: adc: ad7192: Update clock config
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:50=E2=80=AFPM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>

Hello,

A few comments inline.

> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>
> Removed properties adi,int-clock-output-enable and adi,clock-xtal were
> undocumented. Use cleaner alternative of configuring external clock by
> using clock names mclk and xtal.

Should we keep the old properties for backwards compatibility?
While I like the new approach, the downside is that someone upgrades
the kernel and may run into issues with their board, because one of
these properties went away.

>
> Removed functionality of AD7192_CLK_INT_CO restored in complementary
> patch.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 56 ++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 334ab90991d4..940517df5429 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -396,25 +396,37 @@ static inline bool ad7192_valid_external_frequency(=
u32 freq)
>                 freq <=3D AD7192_EXT_FREQ_MHZ_MAX);
>  }
>
> -static int ad7192_clock_select(struct ad7192_state *st)
> +static const char *const ad7192_clock_names[] =3D {
> +       "xtal",
> +       "mclk"

Just a thought; no strong opinion.
Maybe add a short comment about these being "clock_sel" values
AD7192_CLK_EXT_MCLK1_2 & AD7192_CLK_EXT_MCLK2 ?
This is mostly due to the "st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 +
ret;" logic (which is fine)
Before, this change, it would

> +};
> +
> +static int ad7192_clock_setup(struct ad7192_state *st)
>  {
>         struct device *dev =3D &st->sd.spi->dev;
> -       unsigned int clock_sel;
> -
> -       clock_sel =3D AD7192_CLK_INT;
> +       int ret;
>
> -       /* use internal clock */
> -       if (!st->mclk) {
> -               if (device_property_read_bool(dev, "adi,int-clock-output-=
enable"))
> -                       clock_sel =3D AD7192_CLK_INT_CO;
> +       ret =3D device_property_match_property_string(dev, "clock-names",
> +                                                   ad7192_clock_names,
> +                                                   ARRAY_SIZE(ad7192_clo=
ck_names));
> +       if (ret < 0) {
> +               st->clock_sel =3D AD7192_CLK_INT;
> +               st->fclk =3D AD7192_INT_FREQ_MHZ;

Since this is a new function, an early return can be added here.
This would make the else statement redundant, and the function would
have less indentation.

So, something like:
if (ret < 0) {
         st->clock_sel =3D AD7192_CLK_INT;
         st->fclk =3D AD7192_INT_FREQ_MHZ;
         return 0;
}

st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 + ret;

st->mclk =3D devm_clk_get_enabled(dev, ad7192_clock_names[ret]);
if (IS_ERR(st->mclk))
...................


>         } else {
> -               if (device_property_read_bool(dev, "adi,clock-xtal"))
> -                       clock_sel =3D AD7192_CLK_EXT_MCLK1_2;
> -               else
> -                       clock_sel =3D AD7192_CLK_EXT_MCLK2;
> +               st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 + ret;
> +
> +               st->mclk =3D devm_clk_get_enabled(dev, ad7192_clock_names=
[ret]);
> +               if (IS_ERR(st->mclk))
> +                       return dev_err_probe(dev, PTR_ERR(st->mclk),
> +                                            "Failed to get mclk\n");
> +
> +               st->fclk =3D clk_get_rate(st->mclk);
> +               if (!ad7192_valid_external_frequency(st->fclk))
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "External clock frequency ou=
t of bounds\n");
>         }
>
> -       return clock_sel;
> +       return 0;
>  }
>
>  static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
> @@ -1275,21 +1287,9 @@ static int ad7192_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> -       st->fclk =3D AD7192_INT_FREQ_MHZ;
> -
> -       st->mclk =3D devm_clk_get_optional_enabled(dev, "mclk");
> -       if (IS_ERR(st->mclk))
> -               return PTR_ERR(st->mclk);
> -
> -       st->clock_sel =3D ad7192_clock_select(st);
> -
> -       if (st->clock_sel =3D=3D AD7192_CLK_EXT_MCLK1_2 ||
> -           st->clock_sel =3D=3D AD7192_CLK_EXT_MCLK2) {
> -               st->fclk =3D clk_get_rate(st->mclk);
> -               if (!ad7192_valid_external_frequency(st->fclk))
> -                       return dev_err_probe(dev, -EINVAL,
> -                                            "External clock frequency ou=
t of bounds\n");
> -       }
> +       ret =3D ad7192_clock_setup(st);
> +       if (ret)
> +               return ret;
>
>         ret =3D ad7192_setup(indio_dev, dev);
>         if (ret)
> --
> 2.34.1
>
>

