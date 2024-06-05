Return-Path: <linux-kernel+bounces-202952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEFA8FD37F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F291F24D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317B18C34D;
	Wed,  5 Jun 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="erRnJep5"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD761694
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607024; cv=none; b=K51dvrhvUmZLvUEepWNCIj+PxTeQy380lfSn+IuR5ShPsM0EV2z7+4wlHG2OG+T24WTizblaOwwAsHlTFpxq0s4YSIalxu3uDxJKxDY4fp/oko+g9sPI9H9okTKGoJnER2+sauBnFEmlp+z90fJARM++o4qwTcMq0+EaL9/VukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607024; c=relaxed/simple;
	bh=CXzt17zcdptbt4BYuot7hQJfn4AKErAZ8XcgY5+S1rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoDjuKwpxjwaHQoRi514/Nxk2qyedPXY5esI+jpwkSr1AzwhrfQlGYO048heubEbqtMguKUtOQZnuR22DUa0Ak/h/27dOCwzPj8o57evKUHZRFgMl+qoXwPqr3tugOUV7xIKVPo9gYIxuyTrhaSSzkaXjNLmu0UJJ3Nhb+kxyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=erRnJep5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ba69e446f4so1050532eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717607020; x=1718211820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4a0+ecZleYjFXSGL5bL6k9ooCZXlJHeeje7JkdFAgc=;
        b=erRnJep5PGmPrSPH+IR5GspEtinpStrdDwxLgJh6SMCcnAXA1MJpI+hHmEddkumFI4
         8oWYnk1TxaqzXkUUPcZu34lr7c0rreBkckbSqGjB3uawPjJZaAWtAWOzDuHZD+hiZJHE
         6Qt7XGWIF5uq24X2wClbREdKFx9Zsr0NZs+lEWVXZ9Dfmr5LbrX3o6fGHBqsP/kUiYWm
         F6LjvCVB0LFyvZeDme7bDS8wygd3k1hB6XEM0ouFDbYiWFAXiTyYj9PsNWx9G6a3M7j/
         nHFAli+rSPOo2NDaaByPATgjzuMJEsq0RAmgIMMeu+iCSEO1NFaqDYAY4bSdQzdoNt56
         t/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717607020; x=1718211820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4a0+ecZleYjFXSGL5bL6k9ooCZXlJHeeje7JkdFAgc=;
        b=hr3WfIoI+d5MPpU+4M0DQnPKVkxOCKCyQewa3MV6++Ov5/7s3mXsJGH/m+tZBqXh+t
         iQf0zJFK/SSq3YKX9rQDkznj1n9EIAEJPWtSckWRfuDcEw9IA7aFARjrYXFycBr0P2/f
         M96MPGApaChhqmEJ2shJcL5h/U3Sb82E6PMlDMDK4EhAbITfcUiZb+CWg+6SXW+UR/Pf
         2JHpg03NNfZV17EL0qE0uHMIBdN7xiSktyMXYaCmbPQSZ9CDmU01X+S1Ilz9f5XVx3/u
         YQdbfKaUZgD7JvwazKqx1g1s1JveHibosoaHdI12wr46YGL8nvnma0tqQ/1DsS10oCuN
         wE6w==
X-Forwarded-Encrypted: i=1; AJvYcCXcbF2bUIpbgIazWoKrOTRZrxVTATwaI3B7tMvBY1sX6+xHd+Y7YS1NkC3B1LrXdkR/a/06B7uohGc+0l10oCTh8a90Ipr0uFqJXeGp
X-Gm-Message-State: AOJu0YwHxNhUZ2YyksEDXtYGRWkugMMsXbCEHYM5r6Yj+RhDPd2Qy5B9
	a/OsFpiyIbJIRbhp1akbbIKXjPHVnJjyu34Ie+tPACuBPxrMejFPfR0cFVsR2hc=
X-Google-Smtp-Source: AGHT+IEvzG/n/greZ/wSv8VPzHO80/DJZkSvumJN6Zi3ihQX8MKAO4NUq8gdiCwMpluFFpve4nP0pg==
X-Received: by 2002:a05:6820:2212:b0:5b9:fc9f:6a6c with SMTP id 006d021491bc7-5ba78d3b48cmr3465485eaf.0.1717607020326;
        Wed, 05 Jun 2024 10:03:40 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba788e3f14sm496330eaf.42.2024.06.05.10.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 10:03:39 -0700 (PDT)
Message-ID: <ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
Date: Wed, 5 Jun 2024 12:03:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI idle
 configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 5:43 PM, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 0aa31d745734..549f03069d0e 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -41,6 +41,7 @@
>  #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
>  #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
>  #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
> +#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)
>  
>  #define SPI_ENGINE_INST_TRANSFER		0x0
>  #define SPI_ENGINE_INST_ASSERT			0x1
> @@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
>  		config |= SPI_ENGINE_CONFIG_CPHA;
>  	if (spi->mode & SPI_3WIRE)
>  		config |= SPI_ENGINE_CONFIG_3WIRE;
> +	if (spi->mode & SPI_MOSI_IDLE_HIGH)
> +		config |= SPI_ENGINE_CONFIG_SDO_IDLE;
> +	if (spi->mode & SPI_MOSI_IDLE_LOW)
> +		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE;
>  
>  	return config;
>  }
> @@ -645,7 +650,8 @@ static int spi_engine_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	host->dev.of_node = pdev->dev.of_node;
> -	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> +	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE | SPI_MOSI_IDLE_LOW
> +			  | SPI_MOSI_IDLE_HIGH;
>  	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>  	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
>  	host->transfer_one_message = spi_engine_transfer_one_message;

I think we need a version check instead of setting the flags unconditionally
here since older versions of the AXI SPI Engine won't support this feature.

