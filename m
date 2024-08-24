Return-Path: <linux-kernel+bounces-300093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C895DEC5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021931C20EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B828382;
	Sat, 24 Aug 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ghpVJxkM"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93268374D1
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514649; cv=none; b=FRZ4W9W06NhCTGjmtCMDLAqx5K9oU4IabMgixCDsGx7ub0srBVH+Tlr8DUaF2Flh8mfteyumMjDGCK8rjZqySi91FhDdrap+kvSbkKHqSISwPZaoIepZWmwCsE3yRyDYC4mgz9V69c8zgZaHIz5Fs9BdMqVPQTPhJPoEgO1jc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514649; c=relaxed/simple;
	bh=zER3vEhoHx0tOWodj8+1NsgdLz+g9MwfXqvD/BET1x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePeD7UPnhjwc9Mc2ZyIxSbQitHnQ1Ixa1/vgec44klY1WhQARkhwNz9+2FI00Krd7lxI5jXBmZIfwL+ldQvd2ogYgaOPaiBSEZKYBGmc/g8rf/ZuZNTdVKUTFaZ+v4ZPcbHNonl4hkkX9iwfobnS+UYvZwrFif7v4Y4rVJHCXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ghpVJxkM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so3713299a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724514645; x=1725119445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnaI3J8L9jqL+YCydiZGDt22B1OuKa1x9XBslS2zAxQ=;
        b=ghpVJxkM/LrDQT8IOhE+oUS6HvIhMFfC9InFAOVIWOr65NwMo6hCeUqmOHvEL0EUnZ
         3Ta093xzqZF+nK60yw5vEiP2Qb9qSgl6bG/TYYQDiYaEsCeWoSOc0FluiS4vdEi5dxKC
         mTOPy+jxsEjS1geIXiMEGvNgn6LiskeLxaDt/ULJmg+GHM0Yhoa6mqiMF1DyTAjPLzfK
         jFjo7qtFjR5zALpe3inlkzHbQlusV887q1ch166Qi8Xbbao7DL9+tPIAdmPE/0MEt/RR
         CfKZlUsjFXHDI1Duj3wpMi5FW4CoGzQkL2bHW7XzN1ma1Zi8QIBgAedUvBRAC4bvfpsv
         Bh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724514645; x=1725119445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnaI3J8L9jqL+YCydiZGDt22B1OuKa1x9XBslS2zAxQ=;
        b=Mae/V+ISQewr68WtluvmcfccmOimeeRc3gdadl5t2qISl+NVyjCOIcS/yN3RabaLF9
         HEHXjabGNzc6XRdEPQg5xfevQT4xwROX9BtHiNLiSK6aipT0t+BpC+luTrlSXEQxR1b7
         4dAdaDvPzDVwy7/ulXdcB+jfGeDFxixaK9p50KI1lkGpsafEAyN16jMCNisMOEB/QysV
         cfW75P7whKPZlpmMrbjHIFaOViv9KOGF6R/pj2qyhPlbuB50Wr4cRTfRxu46jrvZHkYM
         Cj5IKTXiFo5639KJcZBnUrnTetM+LK/vwPUjkhw/aK9hgJAQES5YTHoAQBVa7n/heYsl
         ohfg==
X-Forwarded-Encrypted: i=1; AJvYcCVGP6ToOEgO3PqVR9ZgsRTc5ryMS9zMp8bLXsJIDqFvyUW17WczwyDy20jqqFyZRr4x3A+nCy34/RY3wNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJQjA9ayddWpvy9SiZ632yQryItYM1RuiCqD2tUP5LLP/vTjZ
	srgHuOiNfnL+1iDHWcIr0PNQ1frmTa3ZX30/B48+uepHUdJOjxeVdtEruPKYNY4=
X-Google-Smtp-Source: AGHT+IHxl8Ii7QkfKZckiGTzrwPt4ARSR1aUCLMT/Aw2okyL4ipRxnvwWURpN6mu9B++Zj8yAyum6Q==
X-Received: by 2002:a05:6402:1e8d:b0:5be:ff22:8eef with SMTP id 4fb4d7f45d1cf-5c0891ac450mr2833551a12.36.1724514644647;
        Sat, 24 Aug 2024 08:50:44 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca4d2sm3434336a12.36.2024.08.24.08.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:50:44 -0700 (PDT)
Message-ID: <7938fb2b-77c4-43a8-a2dc-55dda38404b2@tuxon.dev>
Date: Sat, 24 Aug 2024 18:50:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/12] nvmem: microchip-otpc: Expose UID registers as
 2nd nvmem device
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-13-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-13-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.08.2024 13:59, Alexander Dahl wrote:
> For SAM9X60 the Product UID x Register containing the Unique Product ID
> is part of the OTPC registers.  We have everything at hand here to just
> create a trivial nvmem device for those.

I'm not sure what is the best option to expose this. I let it to NVMEM
maintainers.

> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/nvmem/microchip-otpc.c | 41 +++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index 047ca5ac6407..52af4c137204 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -45,6 +45,9 @@
>  #define MCHP_OTPC_NAME			"mchp-otpc"
>  #define MCHP_OTPC_SIZE			(11 * 1024)
>  
> +#define MCHP_OTPC_UID_NAME		"mchp-uid"
> +#define MCHP_OTPC_UID_SIZE		16
> +
>  /**
>   * struct mchp_otpc - OTPC private data structure
>   * @base: base address
> @@ -249,6 +252,16 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
>  	return 0;
>  }
>  
> +static int mchp_otpc_uid_read(void *priv, unsigned int offset,
> +			      void *val, size_t bytes)
> +{
> +	struct mchp_otpc *otpc = priv;
> +
> +	memcpy_fromio(val, otpc->base + MCHP_OTPC_UID0R + offset, bytes);
> +
> +	return 0;
> +}
> +
>  static struct nvmem_config mchp_nvmem_config = {
>  	.name = MCHP_OTPC_NAME,
>  	.type = NVMEM_TYPE_OTP,
> @@ -258,6 +271,15 @@ static struct nvmem_config mchp_nvmem_config = {
>  	.reg_read = mchp_otpc_read,
>  };
>  
> +static struct nvmem_config mchp_otpc_uid_nvmem_config = {
> +	.name = MCHP_OTPC_UID_NAME,
> +	.read_only = true,
> +	.word_size = 4,
> +	.stride = 4,
> +	.size = MCHP_OTPC_UID_SIZE,
> +	.reg_read = mchp_otpc_uid_read,
> +};
> +
>  static int mchp_otpc_probe(struct platform_device *pdev)
>  {
>  	struct nvmem_device *nvmem;
> @@ -303,8 +325,25 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  	mchp_nvmem_config.size = size;
>  	mchp_nvmem_config.priv = otpc;
>  	nvmem = devm_nvmem_register(&pdev->dev, &mchp_nvmem_config);
> +	if (IS_ERR(nvmem)) {
> +		dev_err(&pdev->dev,
> +			"Error (%ld) registering OTP as nvmem device\n",
> +			PTR_ERR(nvmem));
> +		return PTR_ERR(nvmem);

return dev_err_probe();

> +	}
>  
> -	return PTR_ERR_OR_ZERO(nvmem);
> +	mchp_otpc_uid_nvmem_config.dev = otpc->dev;
> +	mchp_otpc_uid_nvmem_config.priv = otpc;
> +
> +	nvmem = devm_nvmem_register(&pdev->dev, &mchp_otpc_uid_nvmem_config);
> +	if (IS_ERR(nvmem)) {
> +		dev_err(&pdev->dev,
> +			"Error (%ld) registering UIDxR as nvmem device\n",
> +			PTR_ERR(nvmem));
> +		return PTR_ERR(nvmem);

return dev_err_probe();

> +	}
> +
> +	return 0;
>  }
>  
>  static const struct of_device_id __maybe_unused mchp_otpc_ids[] = {

