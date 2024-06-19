Return-Path: <linux-kernel+bounces-221152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91390EF84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77411F23106
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D414F11E;
	Wed, 19 Jun 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NOxU9WS7"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737114F9D0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805418; cv=none; b=cA2xcgzmnjQvnxqNjLkCYJo6G7wS2Xp/aR6rgKQcULWRxvm8Ie1n6h4xR4ESJwjxZF+IOSwJOKp7olH8A3nu48Z5o+LmSulfWj80sg7Wr1fqaMOzJpcjaJXe3MSXUSL+z+1ecNRHe7epslfWz/1qFwfEKHEtmMuEUpUF88IkpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805418; c=relaxed/simple;
	bh=4YpmGHY2TB039BP2VfN05LGC3OdymGgIoGdy6v3hIW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA+Z79695+Uml5QY6Ur63g+jmjLYClN6a//OPcs86t8rAi/iGL1uijlmPH7nL/jJdtf0KL0pBprOguau26LXUV8VGn9NB9eQz4+r0wpOGqSyGma+Ehn0Qb6e0KXVQYQ0vtw73e+Cm3P6c0MIy9tLp84aDueAeRFRj4N+X1kgbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NOxU9WS7; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70089223245so519663a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718805415; x=1719410215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSPgTLrYAIER1520IHBWtifoNKXPibq2elTdXzAWxws=;
        b=NOxU9WS7I1ixeQ7jNAPSnvkNNAq7vq1V7Hh2mvjvOMLxUIrk461Xx5bIKBQNUFTGLy
         cfkndtJCSRUbYolCZG9rJqjnMQllZjJAU25YAWyBCuDH439nma3IOp8AX550/Lv7Msml
         Si9itxDSRpabOUkdfmzxBopjNb/1YgfCnKBDUCMXTyhljhmu6v4XOg1hjQMDbVusi1m4
         P+1Q6f7SrvvF7QII1cgUQzqNiP7OfHgHg6Besn+PHikhADSdgVld2I8Y76sajfPiWKCA
         qK9c6C1MRn37l8NTlI95tnTYUa7scS6XJ5oG5DSIALcqW400Z0ULAeRKdrCNW3n8tvlm
         rjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805415; x=1719410215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSPgTLrYAIER1520IHBWtifoNKXPibq2elTdXzAWxws=;
        b=wLAAsoixBiylSHNM6zZ+jwnjZDTV3xM7/cCrWcl4glU6fIg7SO1GzhVvUU/xYJBrU3
         JL3Xgmv6U/I4+oOdERjrNiN01x48auW6Z1cJNsyMiod0oMFgoj04V5fQmK0PxStJe7Vs
         0ucjWXakyhKMGijT6d9oTQgskmGIFPrvH5MowCvXVPrJ7ZbXdlOOF4Aisp6ZLIiCtMDM
         NAfzL14LHICrLeSSc9gHydX3sVxkgHBH3jeeWCpnfowJesR3E8EH0i8TCgnf7Sr98yF9
         Jwu93sB/GNVbiNOax550V0DVDJS+Rjve4Y+O3R63NBttUIOz4gADjss4W4QiE3tNnSBe
         X97w==
X-Forwarded-Encrypted: i=1; AJvYcCWnjWqXGXPNPfxJwLCRW7ps4tTlWfQoysNCi1I6mNtaKF83L8qdB3elRu4+8tMPsIefPToimV52906mCY3SOmtS4DI5F8Ljylf3dCBG
X-Gm-Message-State: AOJu0YxYsY2U5zUvVT4LNGehvOdFEDmAkDpyqdPdKOC2JfQd6DemQAJ9
	40zH+DpF1k3bDykTyjoaRiFo7EnRJiR/F5+t0eYVHKwQIHIz6qbK9A6rky29VnI=
X-Google-Smtp-Source: AGHT+IHQhtwtn3q99qx1DtHTwYTM65SjEm6yem4vTsRk9lAiFBEHwPqq1Ktxa7Qbe5eZABSkRNp2ag==
X-Received: by 2002:a05:6870:63ab:b0:24c:a547:7b5a with SMTP id 586e51a60fabf-25c94991652mr3393011fac.14.1718805415510;
        Wed, 19 Jun 2024 06:56:55 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f7f5sm3695527fac.44.2024.06.19.06.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 06:56:55 -0700 (PDT)
Message-ID: <6f945701-cac0-4a56-9ca7-1daceccc5efd@baylibre.com>
Date: Wed, 19 Jun 2024 08:56:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] spi: spi-axi-spi-engine: Add support for MOSI idle
 configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <ead669c15db7cfad4034df1d743fd4088f1c2253.1718749981.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ead669c15db7cfad4034df1d743fd4088f1c2253.1718749981.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 6:11 PM, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 0aa31d745734..787e22ae80c0 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -41,6 +41,7 @@
>  #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
>  #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
>  #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
> +#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)

Calling this SPI_ENGINE_CONFIG_SDO_IDLE_HIGH would make it more
clear what happens when the bit is enabled.

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
> @@ -646,6 +651,9 @@ static int spi_engine_probe(struct platform_device *pdev)
>  
>  	host->dev.of_node = pdev->dev.of_node;
>  	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> +	if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1 &&

Currently, the major version is required to be 1, so this check is not
strictly needed.

> +	    ADI_AXI_PCORE_VER_MINOR(version) >= 3)
> +		host->mode_bits |=  SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;



>  	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>  	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
>  	host->transfer_one_message = spi_engine_transfer_one_message;


