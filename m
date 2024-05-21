Return-Path: <linux-kernel+bounces-184806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4D8CAC41
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B54282434
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788656CDBD;
	Tue, 21 May 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bxfk22n+"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D414290
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287537; cv=none; b=ctmniR7eDMmOHqsX8ZeaTA6djRE77z8TkQwpUwgjHwoQ5d4mbPmUJIHB6ifDVDnk6vcVXfzDbP6wnZMaCK1dy0PGIFjJODqOHXKD9g2lyKwsJvXHE0P8AxmLgmnulaimIGLHWHnYJlDGcNPnzUHX9yM6UliyXntlBZQZb2qpwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287537; c=relaxed/simple;
	bh=HrkSTRpwzQrx25GBOwV9JMfsH7ZTLE5VmrQtBoPjVpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oktWCrv3rBIOUILqgtVl34B+pF7gKk9WD1fTB6W4BHBsOIAA2cfgpr/lLKKoz+j/e/xFUzBA/O6UgzDaqOvjm/NF786iF+6uq3pScdoP5Vif72djKFRaUHliAVeOyIcOs+uyWusxcHHcyG+h27fT40Vt/nY+F28Ah+iPj99cGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bxfk22n+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e716e3030aso31874291fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716287533; x=1716892333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u8lwFU9i0vjaUsXdcqI1/oUBUKt6N0tUiifOIzySzKM=;
        b=Bxfk22n+glHBHK1L7AE48NDSuaNLDn/z8eVd0AuYeqOCEPzmlNTS/bvc83QHaw229d
         pcE8qCNpRoAP7WKToggGjmC+txda8DZvsHrO7UpwyFfNdfI6/JrQXx60KBal6SVHb8q3
         Bkb/jBQ+wq6u6BMv9Trdhy94rXU+Dmsz3gpzz3rJuvwliYaW6zt2zIyHXottJDxk72Qb
         fczw+ya1jD0wRDXUEptkUwZlSkclHRLYOBLjiB1K4E+n+foXrPTp16Miun0tXtGmSI6D
         hDT56iw4En3v8+j14opMfDFXmcdHQwvLRiKF1FqGoZ4Xo37rAHkDTm5Gq712aPqV5LUh
         hUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716287533; x=1716892333;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8lwFU9i0vjaUsXdcqI1/oUBUKt6N0tUiifOIzySzKM=;
        b=SG3z5PlTcT0heQeNgFvuZsr8WfeHTBjx0tRrcv/snjwIRYgc3cVCNyBFzwPdGmKodc
         bfanz9Z96we6ek2AmFx5GfrPT37LKFh+2apA/p8WV5hMTC7wElr1XP14Op9ffbdsNeub
         kJNZ+d7WAcJRISrayHgkdymxM+d029uQAcGAj6KWy0cqnqxd5b7hFIjEsGcDshzBuV4i
         IdFF7Vbntw5sq7q3wWdkbdmCL+Cl6t5UohHuIlpr1V7N4YZdj/z65acT1+Fitr7jSCcq
         JV/dar4x1X47XQJP5j1ek47ijRakzRh5oKnZqwHR+nuo8CUkplpdhpjNZOhRm29ZF3n4
         j4xw==
X-Forwarded-Encrypted: i=1; AJvYcCVo70n+QqJIhWkU/k6rlYNd/PwDcq1cPiFoc8sdSxEwziCAdVxM9/KC0BBdzScmW9/SrfjL4QrgcR+ZRfy2b4XLg7Ry84QzjATTaagw
X-Gm-Message-State: AOJu0YxhnRqYulGO1jGGRTdF3iKAfjUA6VviW1TjjV+yZZYlJszjeVJ3
	Cgxy8eYYUyxJPGd+HZa2/ps7tM3tAT+0GzVdGqqt15FdNuJiD+g+pkgZvHY5F6D94QKvgTnQw+9
	W
X-Google-Smtp-Source: AGHT+IE7rppITVfppMDERrnSg8fsdvBMSBAoSLOuZhaaxwoZ4C42vyQHDlcVAq2aaaWFiYwqNTVisQ==
X-Received: by 2002:a2e:8794:0:b0:2d8:34ec:54e6 with SMTP id 38308e7fff4ca-2e5204ccd8fmr185946341fa.33.1716287532892;
        Tue, 21 May 2024 03:32:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013bf1a5dsm356277615e9.30.2024.05.21.03.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:32:12 -0700 (PDT)
Message-ID: <a41c9684-6562-45bb-b009-1fe7b265f60e@linaro.org>
Date: Tue, 21 May 2024 12:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] spi: cadence: Add Marvell xSPI IP overlay changes
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-4-wsadowski@marvell.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240509010523.3152264-4-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 03:05, Witold Sadowski wrote:
> Add support for basic v2 Marvell overlay block. Support for basic
> operation is added here: clock configuration, PHY configuration,
> interrupt configuration(enabling)
> Clock divider block is build on top of Cadence xSPI IP, and divides
> external 800MHz clock. It allows only for a few different clock speeds
> starting from 6.25MHz up to 200MHz.
> PHY configuration can be read from device-tree, if parameter is not
> present - safe defaults will be used..
> In addition to handle interrupt propoerly driver must clear MSI-X
> interrupt bit, in addition to clearing xSPI interrupt bit. Interrupt
> masking must be disabled.

Please use full sentences, properly wrapped, continued, readable. There
are typos above, double full-stops and it looks like one sentence per
paragraph... or some sort of list.

> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---


..

>  
>  	cdns_xspi = spi_controller_get_devdata(host);
> @@ -565,23 +809,27 @@ static int cdns_xspi_probe(struct platform_device *pdev)
>  	init_completion(&cdns_xspi->auto_cmd_complete);
>  	init_completion(&cdns_xspi->sdma_complete);
>  
> +	cdns_xspi->mrvl_hw_overlay = drv_data->mrvl_hw_overlay;
> +
>  	ret = cdns_xspi_of_get_plat_data(pdev);
>  	if (ret)
>  		return -ENODEV;
>  
> -	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cdns_xspi->iobase = devm_ioremap_resource(dev, res);

Why are you changing this to two calls? The wrapper is there on purpose.

Anyway, does not look related to this patch.


>  	if (IS_ERR(cdns_xspi->iobase)) {
>  		dev_err(dev, "Failed to remap controller base address\n");
>  		return PTR_ERR(cdns_xspi->iobase);
>  	}
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(cdns_xspi->sdmabase))
>  		return PTR_ERR(cdns_xspi->sdmabase);
>  	cdns_xspi->sdmasize = resource_size(res);
>  
> -	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	cdns_xspi->auxbase = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(cdns_xspi->auxbase)) {
>  		dev_err(dev, "Failed to remap AUX address\n");
>  		return PTR_ERR(cdns_xspi->auxbase);
> @@ -598,8 +846,12 @@ static int cdns_xspi_probe(struct platform_device *pdev)
>  		return ret;
>  	}


Best regards,
Krzysztof


