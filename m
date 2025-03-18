Return-Path: <linux-kernel+bounces-565550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57AA66A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E5B18983E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5A1DED57;
	Tue, 18 Mar 2025 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8bTaW7S"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F33CF58
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279404; cv=none; b=IGQsy7ZS0SHxD21Av4lCZDUvoJxWMd24SZ2S/Vuo82yIRdvfM+Q+JHD866Byn666/7vprYmc5VU5q/OD3Wj2BOot8aM3p7FlvIzmgdh4u1m7yY85+BsbwqhNM7yEi4ESEcmOEA+D4Tqa6TQ+e1JPPuyD++uHYIOwb57gTMT8Q8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279404; c=relaxed/simple;
	bh=gQUIlx1Zg5+nexoGHiMLl7DClG+NSiyXp/N85MNvyZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJo+8WAy0SN3jicYbnBDFC0GfbSDMo2LT91UDKKWUmuDbT8Fxe76EfoL4lhg/EMdW+Xmykzcz6nPh6g8qPQcACLPOW33lSyL+K86y7ZXhQffPBJuJR0FtuimucUnbGX/xLDy2XZ9yhM8InY7EoryGEk3ShKZ7gSQ6/p5pczsz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8bTaW7S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso20852075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742279400; x=1742884200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjlGvph9FbeHzoqEjT5wXcJBYP4G9CrB0xyfis6EXwg=;
        b=j8bTaW7S/dYAboiVY4z5GWmVbJX+V6CvKoorL4OWHeWGGGi581NXWMh/y1/8/CZtDA
         6yyNj2cZgosfPyaWyB83oOEDQN2skk9M+eMslo1GexvIUJvjfkYGpA3pae+06Y4eugZz
         OTUfXbCnC1r58bkfJHg5hBlKPqIv6vFbFWEVeO38D2HswxeCYGwB1+KPPZmhHAvdLAD0
         eKdiEgQhNJZCIOZLamR6ey/lxPZPWzaqUxtA1bvTLYguLmc0K5XIFUq/thwkWEiSWM66
         Yee4yy94zwKhQ6CQfBvar0oFWrYiwUIPfluG+0lGT7DgrO8WLOSs69Q92aD7xzU1MpV6
         drsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742279400; x=1742884200;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjlGvph9FbeHzoqEjT5wXcJBYP4G9CrB0xyfis6EXwg=;
        b=I2tF26l2WApAPmQOL7XcQjz5nOOF+BuP3SxfxDHxk8FNovHkRsjvzDUd+R+TrnNLAc
         SiAExwyL04kwglqh2Wq5rxBvRBs02VCRWTdJi1j77YGqCqY8mHu87krOpLMJd2rTSn7K
         sp4/lovBdzuxFlt+EbFwGbQWsXd09fqFlsyU1DEMm4PXWucVVsKLILHeZ4DkpJHJqfw6
         hvx9W2/wOpOblNoQXpQnb4VULDLGd37dtpHhshwV36rsOozxewHzs0FYiXRO1ElSFoIP
         oYVZmx8CulweDMv2O58+CLuRJ12IX7uxcJ5T3wpHb4UpDEgAR3c+2m4KCq72YgACXlbr
         vphg==
X-Forwarded-Encrypted: i=1; AJvYcCVRDkJ1VDjfHbd6IRVhrj3A/8fUeiexCCUNghONRHcHgRKYqf2w5d/uj1zYuwHUZobprpLFBv4yH0KNiJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzkECMOW4A7yerimhC+t1acxIBWHLDesZaOOIjCf3kIjJNczX
	LVTENBmXH+CYG1FaFFrQK0Fd8mUOufnjN0R/qYxs5m9Iyp//pXTwN/77MdcWOml+o6YBgD30XH5
	z
X-Gm-Gg: ASbGncs0CfpubM9JisBP0I5Zz1/UAfBZSGbmNXa4a+E/Raa5EwNERuBCG9FmFcT/t7X
	3Zjbpg/1hg8Fqgd7htNGEK/5loTUSAPUf1wh84GBqZbwtYEs6buRiV0iy99YfybuB3iTqvTXHN8
	UwuX8KS/790Yl0UjEi6QCYFAflw80aWXRRnrBoaLFRyfB5W5TjaPx/Pe0fMyPwsOvOtLrDI+XYP
	3+ObdjJDDjjZwggowlHK5VSTEVA/U1c/hLDaD7CcAy3P7IyK68lF69bBPSrVpD+2w1nQS5PZEXP
	0LSM8Y3F6p+k68lrUFNoNx6vd8n7suEqOq7Yn05/736uhtPC6yXiVg==
X-Google-Smtp-Source: AGHT+IGvkDQyai2xtZeXLR1F8esFYWuLjTmm+NlpTt1JcTgeasTcJhfvy1fpJlRGxBNpxuafLcoMZA==
X-Received: by 2002:a05:600c:310e:b0:43c:fc04:6d48 with SMTP id 5b1f17b1804b1-43d3b7c9a0fmr7634995e9.0.1742279400388;
        Mon, 17 Mar 2025 23:30:00 -0700 (PDT)
Received: from [192.168.0.62] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbf901sm124206115e9.15.2025.03.17.23.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 23:29:59 -0700 (PDT)
Message-ID: <93f5e13d-2a4d-4528-9c55-37a79eae3da3@linaro.org>
Date: Tue, 18 Mar 2025 08:29:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix W25Q256 and W25Q512 chips
 configuration
To: Jakub Czapiga <czapiga@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250317182103.2060524-1-czapiga@google.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20250317182103.2060524-1-czapiga@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.03.2025 20:21, Jakub Czapiga wrote:
> Fill and fix configuration of Winbond chips:
> - W25Q512JVQ (+lock, +tb)
> - W25Q256JW (+lock, +tb)
> - W25Q256JVM (+lock, +tb, +4k, +dual, +quad)
> - W25Q512JWM (+lock, +tb)
> 
> Top-Bottom selection bit is SR(6). All mentioned chips have 4-bit long
> Block-Protection field.
> 
> Signed-off-by: Jakub Czapiga <czapiga@google.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 8d0a00d69e12..8ebb1461a4e9 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -145,6 +145,7 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.id = SNOR_ID(0xef, 0x40, 0x20),
>  		.name = "w25q512jvq",
drop the name on next version and add it as a comment

>  		.size = SZ_64M,
drop size if flash supports SFDP
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
drop no_sfdp_flags if flash supports SFDP.

Btw, switching to SFDP shall be done in a dedicated patch, then come
with the BP patch on top of it. Comment applies to all patches.

>  	}, {
>  		.id = SNOR_ID(0xef, 0x50, 0x12),
> @@ -190,6 +191,7 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.id = SNOR_ID(0xef, 0x60, 0x19),
>  		.name = "w25q256jw",
>  		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
same comments as above for this flash and all from below.

Cheers,
ta
>  	}, {
>  		.id = SNOR_ID(0xef, 0x60, 0x20),
> @@ -221,6 +223,9 @@ static const struct flash_info winbond_nor_parts[] = {
>  	}, {
>  		.id = SNOR_ID(0xef, 0x70, 0x19),
>  		.name = "w25q256jvm",
> +		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x71, 0x19),
>  		.name = "w25m512jv",
> @@ -249,7 +254,7 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.id = SNOR_ID(0xef, 0x80, 0x19),
>  		.name = "w25q256jwm",
>  		.size = SZ_32M,
> -		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x80, 0x20),

