Return-Path: <linux-kernel+bounces-394289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D19BACE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66201F22C83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A810718DF85;
	Mon,  4 Nov 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7yKJWsn"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCC18E356
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730703483; cv=none; b=oNsgqmnFMw3mnv/XkRv176WpmBDPmgQIhf5wzkZ95vySadwKTIR8YvQs1G2nvJWMRwVQYVkWXdCtygHuRsfa8mR+EXZW60kx1HXH4yaOG4uDkBbXkzr/8o9dZL5e2s+vJSfT1IDTgC1N4/j565KVNosC/6HwvLwX8zqHMZM+B64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730703483; c=relaxed/simple;
	bh=qR0sgzWfwEEsmU51aUsEmp3CyE6nMOGg+kYlHBe1T3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BguwYf+QKM+OKwVtk0Hq/2jzZGNVFtUNobJ3re9oSi6cQho/3jwCz71pPu/fTKwVo/ip/zGvECds9Tp71RDyXXMZX3Qvd3d2qNjM0spq1ipSnE11p/RHIA7jpa/1k0EXDL1agyuno9nWmysqjSafUf8MLm04pODtKalegeC02W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7yKJWsn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso599778266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730703479; x=1731308279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uThArOGSFE57krQRUMDraU1QLts27MJWPFmXg/jVzao=;
        b=F7yKJWsniAjK8JmAawYt8si8sJOqaR7iDxMG9i2oyHCf9PiVJe0fwJmkQyL4gEt64m
         PkvZfq5+qV2erqwQjUnTR1MCjxUsFxnxlIUjnf7jLTT2iF5zRAtqS48/dW1oSTKGx+W+
         D+L6EsvVVtkSATni+BM0sEfUEODDg/6lzCkwDP52x0nHKGp08NtJE7VjQZZytS17mO5R
         cJybwXy3xfC6ojJJR3jVXwpGK1BpXAPxYB+20aBuD3yEOsxpVPvEVD8jVJCkSWeGASW+
         DHsDyr3XlxFyjDayFW9nZOGaePs2QOQa4OrSuBGDytU+hkkYOoxOoTdmt2FAGUgKD2Sp
         OTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730703479; x=1731308279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uThArOGSFE57krQRUMDraU1QLts27MJWPFmXg/jVzao=;
        b=Zb+OvTlHVRJlJ2DL0gBXjSw5xK+WM6HsWyZ+gweznAMd5VcnELZF9Xg5fmQTAYyaEG
         yvSLyiuPW9Z8KQOb4m43MBWzy7qFbpDsbz5cuZk8C7DcD1hpUUM6Rg2I2lPjdQZfArgE
         zH8Y72XO3R63ikqxrks2SFmN3ll06goeIUL02tQiYjkBZMp6hnYSZnzv5MZVTeUlfk62
         AJqlgZwmmprXnibZ5Foh2yrCzwyqEZSiH5X1P1Xchj9jaIvV+IIBUWIvKZvzhIHzm9Ih
         ksiyOzC+1dlW+dMDrSkSFZNbtBSvtBw+yQhnFkKxoH5JIGs1FkrK54y3Sqt1ND2eZEQq
         11XA==
X-Forwarded-Encrypted: i=1; AJvYcCX2GUsbOs/P0gcq4Z6csNKaDOcDN5RJPYnY6xz3Jo/2cSfDbSFaPRcIErSAmlyTCFvZLnx5ozPt/i/Xqik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsCT6A/Y8KXkjFDxJzUuTGtIvxTWpmRfIg08qv3cM8h58EWUk
	VJEbiQDx5dQdd5ZTuM1ZwFTUADohdSgzVmYZBMYY2c4ev7x6jyt7hfDkGHXr7+A=
X-Google-Smtp-Source: AGHT+IHLXK4gEkLEnHzWZ+cB+wkZBRPe7wOaRk4G7SgrwXJKrL1Hs1gkERB9uAnQeROLxS1qFQqIYg==
X-Received: by 2002:a17:907:3f23:b0:a9a:55de:11f4 with SMTP id a640c23a62f3a-a9e658bc988mr946437466b.54.1730703479261;
        Sun, 03 Nov 2024 22:57:59 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c53d6sm513811066b.68.2024.11.03.22.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 22:57:58 -0800 (PST)
Message-ID: <97e61bf9-8539-414e-88fc-2d8b451057b1@linaro.org>
Date: Mon, 4 Nov 2024 06:57:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: xmc: Add support for XM25LU64C The
 device is produced by Wuhan Xinxin Semiconductor Manufacturing Corp. (XMC)
 and found on some routers from Chinese manufactures.
To: Ssunk <ssunkkan@gmail.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, hhlee@google.com, roccochen@google.com
References: <20241103142126.3406-1-ssunkkan@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241103142126.3406-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 11/3/24 2:21 PM, Ssunk wrote:
> The data sheet can be found here:
> https://www.xmcwh.com/uploads/954/XM25LU64C%20_%20Ver1.4.pdf

you probably won't need a flash entry at all because it seems that this
flash supports SFDP. The flash can be initialized solely based on its
SFDP tables. Have you tried probing the flash without this patch?

> 
> Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
> ---
> V1 -> V2: Removed redundant Signed-off-by information
> V2 -> V3: cc more maintainer
> 
>  drivers/mtd/spi-nor/xmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> index d5a06054b0dd..83e83c1c1266 100644
> --- a/drivers/mtd/spi-nor/xmc.c
> +++ b/drivers/mtd/spi-nor/xmc.c
> @@ -19,6 +19,11 @@ static const struct flash_info xmc_nor_parts[] = {
>  		.name = "XM25QH128A",
>  		.size = SZ_16M,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id = SNOR_ID(0x16, 0x41, 0x17),
> +		.name = "XM25LU64C",
> +		.size = SZ_8M,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	},
>  };
>  

