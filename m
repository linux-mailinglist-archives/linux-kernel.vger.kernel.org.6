Return-Path: <linux-kernel+bounces-346403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F998C458
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D651F21FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861B1CC173;
	Tue,  1 Oct 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jXkSfCCO"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A51CB506
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803171; cv=none; b=r0H4w6RWDSRX+cIx0VIb5UJWjG8L+stnots9Dc1EHLn+EDTprIwHc54tbQrijQr2W0w5Yg/ysLOyTG/TenuKOCc1HlV6vtNV0rQZCL4JZsJHFBAvIkcB+V4m//bL4/VcwiiOkyi9o6L7c3Y9V8aa49HXFRNnHdnJZVpT5IRHVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803171; c=relaxed/simple;
	bh=oO/Dd2KCEmuIxkNvFknsLaiwceuy/Dj9EmYaMyEszrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvIVnZJ1Y3prKz5x0pfPllapHJlVftiYuqO55QIX+Z7E+n+EegFOqJyOvvdHRClyMvaKPcMciDCZs0H6HnJImcUzLvNJY8jRQDZrbY+Awn3SPGiqNPOyaX0qjFWFjyM4vEZ/PCSNMy3PT6Ju28jaMPOAsj7qGyIq3zJkbD6W74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jXkSfCCO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fabd2c4ac0so41635741fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727803167; x=1728407967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y06DXlCXnvKJ/fY/x+blP4HdFfUV0z6ja0IGcj9Ke4M=;
        b=jXkSfCCOBzb72JNbGLGSVkzXSG0BxVF0x3cxTPJPQc2driU9sf7bAbiFiHdRMysb8/
         ir5A7R26AdgsaXDKJk/pe52Fr+psIwXcP/VGiuG2+PFqsV8mGmZF7OOcF2ux1iZf/hdl
         JdKcIgoMOtQ/SXk0b7J+qF+yWrwRUymJhBDIhmhb6wtzS4/FX5oy7iv0inusR/86w+xk
         lrN6VzgSGKuCpoGqTpAu88fbTiZMkib/YjwahWt9BaXIFkt0J+V3WlVdHpsHLVs0Edn9
         sT4cSp8PW1/kiXAVCYpbIgltzM56aMtMqwdWaPF398CjLzXihX0GzGT5zAbxhrW4Ppai
         tn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803167; x=1728407967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y06DXlCXnvKJ/fY/x+blP4HdFfUV0z6ja0IGcj9Ke4M=;
        b=uTfXsC+m+ELkrEYbQvNyyqdTX/Ghei3uSQjdUQZbk3ns+N7wZsLkagzwLGUA4Q7dQw
         q48EvLOTnxd9aDURgHLdMgR4y6Toj5xuv6cUU84Ep//TAPSTIyHFeEeS7W5DtP4muOmk
         2jrdrLSbF6qOgyvJ3jJfakh15NVmOoVO6YZcMwWplq6SE4C7r6t6WJjHhIuatAtQG3U/
         cJbZ7PLwcQ+mNcjqFrlN0fEvVtX5lO8zGlhydyHQafvNgfARYn+3+O64YhxDHiq/loAZ
         4oSJ7RTMBys7KB9TXEC36erDVd9cqF5EkQw5S/fFysyPfrHI6PkOhgpxBgewGTfRHCUk
         Pyzw==
X-Forwarded-Encrypted: i=1; AJvYcCWBrDUOQEKV71ApXqYLBYUcNeGZgYSX2vDeueVfRhdiYT0cuCJ4vvQJju7GJ8ZucIIyxJAYoDX5Qlam61o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxraOZNJulhltttaGOhEYC/tGHs646LcGVvrYs1ffZGSp7+M20
	Ruj2O2ujV5V/LuaHmTskosQ3JTkvl1pZDAc4ikrA7azZOudo4eCh0OWBidyAoKBsthuIbrledQ5
	2uwZRX/VaonGUKWRCFl5qxZMNNVTC94DNWgNHqQ==
X-Google-Smtp-Source: AGHT+IGCyAjSmUUhOOxonn0IXFjPj/ZIpq3rE7R5JDf3UZSodApeIDdzmaENM9VLJd8jJBLSLHTJ5cTcssP94Nc/hz4=
X-Received: by 2002:a05:651c:220d:b0:2fa:c9eb:53ce with SMTP id
 38308e7fff4ca-2fae106d1cfmr3888261fa.26.1727803167103; Tue, 01 Oct 2024
 10:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001074618.350785-1-herve.codina@bootlin.com> <20241001074618.350785-4-herve.codina@bootlin.com>
In-Reply-To: <20241001074618.350785-4-herve.codina@bootlin.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 1 Oct 2024 12:19:16 -0500
Message-ID: <CAMknhBHRY=MKmpiMnwHk8Gpdi5pWaUOZosyKTzX=83DuAxBvOA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: adc: Add support for the GE HealthCare PMC ADC
To: Herve Codina <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Ian Ray <ian.ray@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:47=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> (voltage and current), 16-Bit ADC with an I2C Interface.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

...

> +static int pmc_adc_read_raw_ch(struct pmc_adc *pmc_adc, u8 cmd, int *val=
)
> +{
> +       s32 ret;
> +
> +       ret =3D i2c_smbus_read_word_swapped(pmc_adc->client, cmd);
> +       if (ret < 0) {
> +               dev_err(&pmc_adc->client->dev, "i2c read word failed (%d)=
\n", ret);
> +               return ret;
> +       }
> +
> +       *val =3D sign_extend32(ret, 16);

Shouldn't this be 15, not 16?

> +       return 0;
> +}
> +

...

> +
> +static int pmc_adc_probe(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev;
> +       struct pmc_adc *pmc_adc;
> +       struct clk *clk;
> +       s32 val;
> +       int ret;
> +
> +       ret =3D devm_regulator_bulk_get_enable(&client->dev, ARRAY_SIZE(p=
mc_adc_regulator_names),
> +                                            pmc_adc_regulator_names);
> +       if (ret)
> +               return dev_err_probe(&client->dev, ret, "Failed to get re=
gulators\n");
> +
> +       clk =3D devm_clk_get_optional_enabled(&client->dev, "osc");
> +       if (IS_ERR(clk))
> +               return dev_err_probe(&client->dev, PTR_ERR(clk), "Failed =
to get osc clock\n");
> +
> +       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*pmc_adc=
));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       pmc_adc =3D iio_priv(indio_dev);
> +       pmc_adc->client =3D client;
> +
> +       val =3D i2c_smbus_read_byte_data(pmc_adc->client, PMC_ADC_CMD_REQ=
UEST_PROTOCOL_VERSION);
> +       if (val < 0)
> +               return dev_err_probe(&client->dev, val, "Failed to get pr=
otocol version\n");
> +
> +       if (val !=3D 0x01) {
> +               dev_err(&client->dev, "Unsupported protocol version 0x%02=
x\n", val);

Use dev_err_probe?

> +               return -EINVAL;
> +       }
> +
> +       indio_dev->name =3D "pmc_adc";
> +       indio_dev->info =3D &pmc_adc_info;
> +       indio_dev->channels =3D pmc_adc_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(pmc_adc_channels);
> +
> +       return devm_iio_device_register(&client->dev, indio_dev);
> +}

