Return-Path: <linux-kernel+bounces-404689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74539C46DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5946C1F26F31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105491ACDE8;
	Mon, 11 Nov 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q4SJgzFv"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC41AA78A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357092; cv=none; b=SpSOwfhmGUxC4ev7becph49QtQjW0pHQFg0QdOefeDXU7BPBeGfcm54B1q2dj0+zqkwQ/PxDd3wcYdpdxQtIZ72CjrLais5Olc+CQ6GRcbSTCqfgcVbsG4qQ+cY5y6QtBgkAZz2F+2sDgzSKct+AC+v3E/5qRW+Oa6ZHKdASpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357092; c=relaxed/simple;
	bh=o3FK/0IgoGk9NuJ8Hrvq4qVdMuiPvjzK/CdXlMtyQ84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLkuTqo/pvI+h4dsWg2i49Qz0kzqCSCespSpm5xIex5lBFXRgqJnC44TmHUDRJRJbCesSb//xFwIB+YEqXXyC/Aq7ge61Qz4FLDE8w7pNuVSmhV+5DQDldB1S92OlfFruP/20x9gn8GZiLiBMmF5rpUICne4ZHNDSs3ZkJgZ8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q4SJgzFv; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc0e13d25so1873702eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731357089; x=1731961889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpnhkffXcHhvvIH2AEJndbfTGO8RYj08GSS7kAB7Fzk=;
        b=q4SJgzFvbl9r18DDHWCwWndf3WCV/t+YS28xzIOqNRKRCcGu6I7LvTBnwdp5TQ5RI0
         pW4jiUZjNvARK2kDxxvsEtGDrwKsOu6sSotn4a4ZwbXCzjfQwvh8bylmMou4KJ9vXK6F
         dfrA9hMu3uiqaNnNXmZdqiqiIG0WgAA/cOYtCtcuOyEMgTJ651FCkMKxyiAJ4Ne8A3IL
         Zrxhb72Q8PhMJg5+Yael6SjUUkeni1lheSNc2sw5YAUSDM7zJtDkbEvf8wISmi+YXuDz
         sjZkNGPm7eY2SdCg1VDzod+d8GlHLWMtEp2IpdQS2+NT3w4jHPlUEfzSKjrgMYIz2wyo
         x2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731357089; x=1731961889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpnhkffXcHhvvIH2AEJndbfTGO8RYj08GSS7kAB7Fzk=;
        b=KP2Cc4N8ekyrIWcY4qXSJEJtbgfc6dPg4NUwndW//l0R6a22WBOBFqS+IeGdGghW9x
         vU3YdF7LWdLyQRdctmtIIFmLzLiAh83BzGe9nUmULPDW6n3sAGua0zJSiL0NDBKHITDd
         aRpVrQ78rrlZyTvHwEGp1sbzPMBzhiPoN03G2N66uEXDH11zZizz7b5T2tDlHkWk5Gyl
         28L9//+AI6VtaqNuG21LXZSmFCiRrQwh6YkgSUmZw69KEOiXz8qxVcIBPfEYa5+mx6Lj
         v0tf/viFHJvXkKh4roxWWaxi8mMw3Bz7N17QLKKfEUVG2gPWmxJMk25LvnmLZluZks8o
         0L4A==
X-Forwarded-Encrypted: i=1; AJvYcCWX6G6uYg5L9lj5LVeJ1+BZ5dN3DrH2yub7rqhoIbwR4R/SF/T50vkz6M6QQUVV/jI65MIuTvyXLsl3ErU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPxeXEGe0qUjW3HT367anI+WY+scTIVM94YdPRhhSAkIXjGz8H
	KDCEJh/heIGMdHe1jfUNPANnnO501NTENuCQ7Ku0yVjQJwlMEsULdsrTnKgimWU=
X-Google-Smtp-Source: AGHT+IEobLDEagfW54O8GAanUWU7O3PxAB0d8AINlGQ7LblFN+wqIM6qfOx/tA5OR+entlvpbshn+A==
X-Received: by 2002:a05:6358:d581:b0:1c3:7b75:24ec with SMTP id e5c5f4694b2df-1c641ece629mr629538355d.15.1731357088991;
        Mon, 11 Nov 2024 12:31:28 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d39643b390sm63461636d6.90.2024.11.11.12.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 12:31:28 -0800 (PST)
Message-ID: <7bae5453-ff1f-40b3-b6ab-2f38e60ddaf4@baylibre.com>
Date: Mon, 11 Nov 2024 15:31:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: ad4695: add custom regmap bus callbacks
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
 <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-11 10:59, Trevor Gamblin wrote:
> Add a custom implementation of regmap read/write callbacks using the SPI
> bus. This allows them to be performed at a lower SCLK rate than data
> reads. Previously, all SPI transfers were being performed at a lower
> speed, but with this change sample data is read at the max bus speed
> while the register reads/writes remain at the lower rate.
>
> Also remove .can_multi_write from the AD4695 driver's regmap_configs, as
> this isn't implemented or needed.
>
> For some background context, see:
>
> https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/
>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/iio/adc/Kconfig  |  2 +-
>   drivers/iio/adc/ad4695.c | 74 +++++++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6c4e74420fd2..e0f9d01ce37d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -51,9 +51,9 @@ config AD4130
>   config AD4695
>   	tristate "Analog Device AD4695 ADC Driver"
>   	depends on SPI
> -	select REGMAP_SPI
>   	select IIO_BUFFER
>   	select IIO_TRIGGERED_BUFFER
> +	select REGMAP
>   	help
>   	  Say yes here to build support for Analog Devices AD4695 and similar
>   	  analog to digital converters (ADC).
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index f36c1a1db886..180a0fd4f03c 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -150,6 +150,8 @@ struct ad4695_state {
>   	/* Commands to send for single conversion. */
>   	u16 cnv_cmd;
>   	u8 cnv_cmd2;
> +	/* Buffer for storing data from regmap bus reads/writes */
> +	u8 regmap_bus_data[4];
>   };
>   
>   static const struct regmap_range ad4695_regmap_rd_ranges[] = {
> @@ -194,7 +196,6 @@ static const struct regmap_config ad4695_regmap_config = {
>   	.max_register = AD4695_REG_AS_SLOT(127),
>   	.rd_table = &ad4695_regmap_rd_table,
>   	.wr_table = &ad4695_regmap_wr_table,
> -	.can_multi_write = true,
>   };
>   
>   static const struct regmap_range ad4695_regmap16_rd_ranges[] = {
> @@ -226,7 +227,67 @@ static const struct regmap_config ad4695_regmap16_config = {
>   	.max_register = AD4695_REG_GAIN_IN(15),
>   	.rd_table = &ad4695_regmap16_rd_table,
>   	.wr_table = &ad4695_regmap16_wr_table,
> -	.can_multi_write = true,
> +};
> +
> +static int ad4695_regmap_bus_reg_write(void *context, const void *data,
> +				       size_t count)
> +{
> +	struct ad4695_state *st = context;
> +	struct spi_transfer xfer = {
> +			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
> +			.len = count,
> +			.tx_buf = st->regmap_bus_data,
> +	};
> +
> +	if (count > ARRAY_SIZE(st->regmap_bus_data))
> +		return -EINVAL;
> +
> +	memcpy(st->regmap_bus_data, data, count);
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}
> +
> +static int ad4695_regmap_bus_reg_read(void *context, const void *reg,
> +				      size_t reg_size, void *val,
> +				      size_t val_size)
> +{
> +	struct ad4695_state *st = context;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
> +			.len = reg_size,
> +			.tx_buf = &st->regmap_bus_data[0],
> +		}, {
> +			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
> +			.len = val_size,
> +			.rx_buf = &st->regmap_bus_data[2],
> +		},
> +	};
> +	int ret;
> +
> +	if (reg_size > 2)
> +		return -EINVAL;
> +
> +	if (val_size > 2)
> +		return -EINVAL;
> +
> +	memcpy(&st->regmap_bus_data[0], reg, reg_size);
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, &st->regmap_bus_data[2], val_size);
> +
> +	return 0;
> +}
> +
> +static const struct regmap_bus ad4695_regmap_bus = {
> +	.write = ad4695_regmap_bus_reg_write,
> +	.read = ad4695_regmap_bus_reg_read,
> +	.read_flag_mask = 0x80,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
>   };
>   
>   static const struct iio_chan_spec ad4695_channel_template = {
> @@ -1040,15 +1101,14 @@ static int ad4695_probe(struct spi_device *spi)
>   	if (!st->chip_info)
>   		return -EINVAL;
>   
> -	/* Registers cannot be read at the max allowable speed */
> -	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
> -
> -	st->regmap = devm_regmap_init_spi(spi, &ad4695_regmap_config);
> +	st->regmap = devm_regmap_init(dev, &ad4695_regmap_bus, st,
> +				      &ad4695_regmap_config);
>   	if (IS_ERR(st->regmap))
>   		return dev_err_probe(dev, PTR_ERR(st->regmap),
>   				     "Failed to initialize regmap\n");
>   
> -	st->regmap16 = devm_regmap_init_spi(spi, &ad4695_regmap16_config);
> +	st->regmap16 = devm_regmap_init(dev, &ad4695_regmap_bus, st,
> +					&ad4695_regmap_config);

Note that there's a bug here - that should be

+	st->regmap16 = devm_regmap_init(dev, &ad4695_regmap_bus, st,
+					&ad4695_regmap16_config);

I can fix this in v2, unless it would just be easier to fix during merge 
(assuming there is no other major feedback).

>   	if (IS_ERR(st->regmap16))
>   		return dev_err_probe(dev, PTR_ERR(st->regmap16),
>   				     "Failed to initialize regmap16\n");
>

