Return-Path: <linux-kernel+bounces-403852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DCE9C3BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9131F22AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5016F8EB;
	Mon, 11 Nov 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXJxbpyo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E51474B9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320299; cv=none; b=MdzKI7kIoU9pkb0a0YtXeRPV7ZPV8Oeyv1tXRncRprQn4/y5HUuDuHqc98bjUzznmfc/NHp2MWNuE4R7HABrrht7WEeiinaXZZruHUahVZnA4aDTNaguVsZnhDpW2K/iRqGYddERpHoFP4t4Zh+onhw+LrNvIDCE/IfoAsjBgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320299; c=relaxed/simple;
	bh=YQnV5IcYve0K6ImjwVy9/VTkz6Bo7ZdNcGNvHGpQgb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X30KP29B1HayqxaoexsKFEbLOZWaJv2X8qB030ecnHa525DDU1z8l35J1eV/rnVR2/pPwd8jS7tW3RnEYAaKKlSoG9IVoTrl6PKl+yaVD6Xz9ixpHt2z2NOz3Z+u3i3040ZAXQ7bGlILJ751TgRW+v9veRgNBx9zpk8zDjWwcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXJxbpyo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53b34ed38easo4290632e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731320296; x=1731925096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhyKJC+ZlhIvd2RI2qZdoBI7BLL1Xj6/nlNpmII5adA=;
        b=DXJxbpyoW3WJEFq7L2lq69nUggqYp4+hgMaCrieLVLdeUtCseerwcFuQ0YPCnmEEeb
         46ID4nnWiT74PPtY0R1wwuwZ4S2+jfwCsWjxFJYIn8lsLHrHNgPWnBeRxUDteSorwZVg
         zMBbKtSGIXDVk121S49McTJ8vGMBm50HQ30KaWAu9asCT2qHnVNMPo1ewq8zDtAOzyGb
         4mtIj3uK0nPcal0e7WF2qZ/Bx0PDHgGYReHWItx4r1v7KoTubm9VKhnsTwMUt8+gJImw
         CxZODKtaya29fGdbePhfxisMr/z4b73cfvzibj4tsBL14zmTwgGjHa+VHfB4BiCYYGb8
         +Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731320296; x=1731925096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhyKJC+ZlhIvd2RI2qZdoBI7BLL1Xj6/nlNpmII5adA=;
        b=XZnppYXwQ2JXMYubPhSa84wEI/mdDggRGaVnbw7yodoYoXJ+1v2nMkhRNBbQ5ddUBR
         pTP5YUttyVrsfvosJtuiimmsLFkBB06jEOxlw2VHN49ASRDE4An2sTdE25ERmUBeVIcn
         jQB7MBMIZ1oGDVS1h7/D/cFmJTZrHXecKVoSbQPGdGYxeyEEZRvH5onnYPCha9vUVThF
         cgs4BUsVQWhfqpzAefAemUFtZxszVqlC4xFj3PL1ywnQ9bRUvdhgEjvMkr/cQCe3eOcP
         2O0PAcXzQ4mjcalp8uv3pXWCNt0xUAQkGCTU/gxYY3HzeLnHOezYAEj1bsbdRVIIE1yv
         UIMg==
X-Forwarded-Encrypted: i=1; AJvYcCVRL1DHoOE+8QJTuic2ItKqMelAy0lLqdrJex54dJQT1kDoEg9DvXQ4B91UOKS4rLJMLz5SDSi9S+kjcqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdcISJ4NutxiZ78n1ZdSpVDhVI7NgE29r05gdHLi7xYsKmimz
	qFybcLK45WEisl3e5FbF8bKERrLbIgzAheKpLbnyD5wnqOz+J108Kw3py5qqyd4=
X-Google-Smtp-Source: AGHT+IEfUlCd+ogGcecrle4DmhwPBvBsn78CHE0X/HnxFrBFSrVBduh4K745TFt0HlnQBVGN0Q4Geg==
X-Received: by 2002:a05:6512:3408:b0:539:8980:2009 with SMTP id 2adb3069b0e04-53d862e4d8dmr5193051e87.36.1731320295752;
        Mon, 11 Nov 2024 02:18:15 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b2c32sm204503145e9.10.2024.11.11.02.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:18:14 -0800 (PST)
Message-ID: <437e9c87-fbae-4402-858c-ce6de0a992c7@linaro.org>
Date: Mon, 11 Nov 2024 10:18:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: core: replace dummy buswidth from addr to
 data
To: Cheng Ming Lin <linchengming884@gmail.com>, pratyush@kernel.org,
 mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>
References: <20241107093016.151448-1-linchengming884@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241107093016.151448-1-linchengming884@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 9:30 AM, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> The default dummy cycle for Macronix SPI NOR flash in Octal Output
> Read Mode(1-1-8) is 20.
> 
> Currently, the dummy buswidth is set according to the address bus width.
> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
> dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
> host to read data 4 cycles too early.
> 
> Since the protocol data buswidth is always greater than or equal to the
> address buswidth. Setting the dummy buswidth to match the data buswidth
> increases the likelihood that the dummy cycle-to-byte conversion will be
> divisible, preventing the host from reading data prematurely.

This is still very wrong and the `fix` is working just by chance.
Consider what happens when one requires 10 dummy cycles. BTW, does this
fix a real problem, or it's just a theoretical fix?

I don't like that we're chasing our tails here. The fix is to pass
directly cycles instead of bytes and update MTD and SPI to use cycles. I
had an attempt to fix this in the past, but I can't allocate time to
respin. Are you interested in taking over and fixing MTD and SPI?

> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f9c189ed7353..c7aceaa8a43f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>  		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>  
>  	if (op->dummy.nbytes)
> -		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
> +		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
>  
>  	if (op->data.nbytes)
>  		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);

