Return-Path: <linux-kernel+bounces-204370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13348FE7D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A32286DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13F51E4A9;
	Thu,  6 Jun 2024 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXDE0bAu"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC2195993
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680687; cv=none; b=BwT/k+v0k9oF1R1xWo5APm+9sh1XhmQ5tXStmkb77ZPqlOosn3BuxwfscfGfAa/jFWxubT3VI1TsO0cCciUjJ+Dqsh/fjRALJCZHEqrSobCc1V8t52OBWiBdxOs5oZk/jTkOGfJGx5E+LdOx+M3dLieMbjVyekGsZg4+u3+3LP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680687; c=relaxed/simple;
	bh=/MpEarDTdmsHsly2govIHxY4tMGV9P2aqiICWrHuL2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEl9tcaZyQvI/jkMYvBNlxOhlp65I3APZuoHVGZCTiJD2xePXPKmkJcGq/Bz5fJAmwlaISmgJyKNQfnQiATz/+4GE/IJcyAAKJ5Xo4uMMxIOaUZsCQpuOFgYr1C4rpHjSACygogkZ3VOynDr4vi915ulzWcjQwXPFotdVjSOcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXDE0bAu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b88335dd7so1206845e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717680684; x=1718285484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zmsP1MNZwY5lN3l4HikogMd/Cj+hwxphgWW3D3oRNE=;
        b=LXDE0bAu52au3h/Uhkhkg54ryABffnLfDkzE/RqHv+tITyhRQLVUQwuyi3aIi5XuFe
         LR3Mdsuhz3vWb9NDodaDbQ0QgioI43p1wu+YOjIyMPoWAj62d0AZ+ePCTd322lDn8MCP
         2xTUBmJkS2OuMIQ/3n4iGo+nbhL4bfv3JVwsUgrGJXm+YsZbuMqb/ImFqa6NGupPgg5t
         VcnAF+ysqgBesqohBdJc5oSzY9hRkLFBDKTm5mKokuaU3gwKcw305a3cj4aZERjzBrtp
         if1KX0B5QG9duqMeHQPfKHnDK8B6faYLM197ruDE+9H9hWZE9JvFZjuLtK9fnGWKkxFP
         jYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680684; x=1718285484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zmsP1MNZwY5lN3l4HikogMd/Cj+hwxphgWW3D3oRNE=;
        b=T8J9/35gpivsS2K9RrpogoTjXZcSOngf9stxkqercL61CCm/UU/kct+cgZHKapGL2s
         IUeLbs0fuVGGMoF6vS35D9O6UqhqHCm0miurmlY3FzKyJkxub9CW1e8AQ7RPFhpyUXll
         CZj7cbcad9+r4XMz/JJW7096uPOHK6eYWWJE7YYxSQULkx5Q7MPJQNhYhxqckG3I51hD
         nfKyuSRgYl2yUeyTVAzGILrErpWBKDtlbYdLmle1h8f0CWRJHqS+4xcjWV9Hh78dn/lc
         T8OSXxHM9eby3kFOcD8rn7XIqf/Vl3fBnS5H/jn4JHRTr5YPAp5FYPPEksSQTEVMV9ej
         znig==
X-Forwarded-Encrypted: i=1; AJvYcCVZtGHAnQKZlXj4PPCtQHXvilMgcVHBYRMMHc0408wgORX0x6gTRxYHx/vR6azpmmZVlL7LWDLbK4drf0ceSLJvh7iBXHO+ugnqvRme
X-Gm-Message-State: AOJu0YzGwNLBXI242BNaDPWMRIvGMBLZk/UL4AVrJqDIK0kKSAPkIBj+
	8EHEuH9wqNJTbmf4dJjTJiYPbkbKnO1x9gd7BcQ8b5y9+5x3qsw3+Cn7doz8N+E=
X-Google-Smtp-Source: AGHT+IE+sRUqnMl9LYBdQjKLK+TsMvxU650LaPvKzR0ViFP7J0QmNGczcpsl7tjNVr8GlgDc5ZvASA==
X-Received: by 2002:a05:6512:3189:b0:52b:885b:aacd with SMTP id 2adb3069b0e04-52bab4b808dmr3849492e87.14.1717680684478;
        Thu, 06 Jun 2024 06:31:24 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805c421esm98277666b.48.2024.06.06.06.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:31:23 -0700 (PDT)
Message-ID: <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
Date: Thu, 6 Jun 2024 14:31:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
To: Esben Haabendal <esben@geanix.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
 <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 14:09, Esben Haabendal wrote:
> A dedicated flag for triggering call to
> spi_nor_sfdp_init_params_deprecated() allows enabling optional SFDP read
> and parse, with fallback to legacy flash parameters, without having dual,
> quad or octal parameters set in the legacy flash parameters.
> 
> With this, spi-nor flash parts without SFDP that is replaced with a
> different flash NOR flash part that does have SFDP, but shares the same
> manufacturer and device ID is easily handled.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/mtd/spi-nor/core.c | 3 ++-
>  drivers/mtd/spi-nor/core.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 3e1f1913536b..1c4d66fc993b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2933,7 +2933,8 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
>  
>  	spi_nor_manufacturer_init_params(nor);
>  
> -	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
> +	if (nor->info->no_sfdp_flags & (SPI_NOR_TRY_SFDP |

I don't like that we update deprecated methods. The solution though is
elegant.

> +					SPI_NOR_DUAL_READ |
>  					SPI_NOR_QUAD_READ |
>  					SPI_NOR_OCTAL_READ |
>  					SPI_NOR_OCTAL_DTR_READ))
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 442786685515..77f61a984cb3 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -535,6 +535,7 @@ struct flash_info {
>  	u8 no_sfdp_flags;
>  #define SPI_NOR_SKIP_SFDP		BIT(0)
>  #define SECT_4K				BIT(1)
> +#define SPI_NOR_TRY_SFDP		BIT(2)
>  #define SPI_NOR_DUAL_READ		BIT(3)
>  #define SPI_NOR_QUAD_READ		BIT(4)
>  #define SPI_NOR_OCTAL_READ		BIT(5)
> 

