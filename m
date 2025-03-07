Return-Path: <linux-kernel+bounces-551425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FAA56C45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F06189387B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203021D3DD;
	Fri,  7 Mar 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zx0F+qlZ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9CA219317
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361931; cv=none; b=LV/ReDlsHCBTc+IHdLNjYTYQgLtdc3iSNfI/grsAtEmdlLR/CtTR+iUvdHXBCjGR25Kn4pX7OX5It7Pqt92e21WSAxejjJb6Ps1YfB+eASjZLe1RdLm0epS9qMHGwRCkG+sVdcBsBKsIUl9FKs8NmWWsRa+UWXt+Clym27Meup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361931; c=relaxed/simple;
	bh=A85fo7gKkXaPFa9FkJlgwJCdrqDwnB5ccjXo2X/wlzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgwMfu15RDnVXbNnkGMSb2tVJ123350L2Yp7RF1fkirYJ8B9aE9CqNGgqN51L3zSiqN9Mmaa9IIKEbi7weABQo49WxiKHM+uLFl47AVogW1ctHv9Fvb6GDcgz0yb7DZsBi4RFuAAQlM0Vwk47DiDTrEr0KVl5T0D2ZsrNzY49bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zx0F+qlZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso2532984a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741361928; x=1741966728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42vX3c5eYK6+PT3iK03vkSK6URE9IJeYdbtn09gB3H8=;
        b=Zx0F+qlZvCYwkS1Lokis7EEvQUcZ9uPwx9GRd3f0jK/afgKDUUqY0iRcDBSfaRz+jF
         kMcjfOlZyQt7o0qHYEFPP07SrtVaJKc+L2rnfo5Q+MvFToCS+Sv7IMFHI28uBtfnAowr
         DYMTpbOW6N7b97QlJrKBPybHGRjRSS2tETeBKy+lYNCL4HsMbKuxvRtCjykl6a/8dw0E
         iKqm4was9PDMlZIU8gAODsKD7LgiJgIiycFGCvDJFXxgvBrN05Y1EysziO+5+oxo7JO6
         lKKNpoaykDekPq1LXExuy3FbMOM12JTGziaYuyJJ/8RnltdkWIOwEZ29wWLb7+EFJnh8
         aHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361928; x=1741966728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42vX3c5eYK6+PT3iK03vkSK6URE9IJeYdbtn09gB3H8=;
        b=R/GmEpHYgj56fxadOUSa+fZLcXDdrOicFQ+7iSXqGVM3sTXYSD96m2qaCJbzDCVzjd
         lH53g2yMuLdbFlKoMIWj51ZOziyBOF6licYZUhZxv7BOv32wS7+jXq2/vhQoG0LIPG35
         hC2IUjEH56s8jCtV2oNgrjk8vOIbRuXo6z1gG0V/boKdZlSYRQ6VerGfUH9oZHMiSkDH
         vR53gJ9n9wx8ZkXsrso01KnsPhfJxfRStjVsv5QTLIC6oKgRDsjBsG3LHBWD1zl9a7Sh
         Tx1eUXmNiyZ3UlQJ6NiZGdZswl1ZCNS5dK4lN9yCMTZpFiNb5v2scvnp+CrlS8GhGr3k
         L9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXred5dSZ0NFYVC4FpaW5DnxLWqde3t0M6riO2P3nD1ts1Tr7B7VFWZfIrgZrSLuGJKWsxhcf+xUVHShZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1bhMa+OYVkWfF2AZgV8+ejuD05rq9q9aIVKxBmsQ+MOWbd9i
	HAaDsrM8PGphwFg5TIqvMTpJkoVMtkA5HKfaqGgXMGbO/aAGx/Mf4x4ASZ8hlb4=
X-Gm-Gg: ASbGncsCURRcklKeOorlo4YaJbqihB6d92M6s3eRgmU6dXIrc7LMJzzzcjrGPvgSip8
	UzJbVx4f7Nkq/2VLhlbcr5o3vVXW9q4N6tv7vcn/SDZEPL6FSFjRoCUNMyWezO6PithyjmWZ9mB
	Fk+aYMT97QnN1UkzheI59Px30UUHX5HggopO0/mKCPjztA/P+zbdlmbmMGydqg/+NlzTmibg809
	MtLpAszyVsDcrojFKNIndOTfgJIYVxSSgRhD/T/n467KGpBIIhJ88O5dpafDJE/apU8bt8yHJa/
	I74LpumJ4W0qWkq0etylWlwHt/2e3e85UKcxBgY+mCewMt1RVANLFw==
X-Google-Smtp-Source: AGHT+IFl1WF2/BmG5TpHqJMFXAy3oe958ZC0g+bU1yWwbSxiPj/UEP5KIcg9WYGq23IB0sHLCiTQ7Q==
X-Received: by 2002:a17:907:7293:b0:ac1:ecb0:ca98 with SMTP id a640c23a62f3a-ac22cd6e4ecmr937582966b.26.1741361927638;
        Fri, 07 Mar 2025 07:38:47 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943883csm295717866b.12.2025.03.07.07.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:38:47 -0800 (PST)
Message-ID: <9004166e-5535-4024-8114-9fdb217407bb@linaro.org>
Date: Fri, 7 Mar 2025 15:38:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] mtd: spinand: Use more specific naming for the
 reset op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-1-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-1-45c1e074ad74@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 3:08 PM, Miquel Raynal wrote:
> SPI operations have been initially described through macros implicitly
> implying the use of a single SPI SDR bus. Macros for supporting dual and
> quad I/O transfers have been added on top, generally inspired by vendor
> vendor naming, followed by DTR operations. Soon we might see octal
> and even octal DTR operations as well (including the opcode byte).
> 
> Let's clarify what the macro really means by describing the expected bus
> topology in the reset macro name.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/spi/core.c | 2 +-
>  include/linux/mtd/spinand.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 7a578f3522be93d30a9132cf01831515db77ae38..ea6b48242ad4a4e51c713907ce5cc55022cdb569 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -586,7 +586,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
>  
>  static int spinand_reset_op(struct spinand_device *spinand)
>  {
> -	struct spi_mem_op op = SPINAND_RESET_OP;
> +	struct spi_mem_op op = SPINAND_RESET_1S_0_0_OP;
>  	int ret;
>  
>  	ret = spi_mem_exec_op(spinand->spimem, &op);
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 0da8a1c7740ef5cbbdb2a74858465136638224f4..4f47adbe4566d7813ffd8fbfaddd1a85d88d0208 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -20,7 +20,7 @@
>   * Standard SPI NAND flash operations
>   */
>  
> -#define SPINAND_RESET_OP						\
> +#define SPINAND_RESET_1S_0_0_OP						\
Hi, Miquel,

Have you seen any reset op with address or data? If not, I'm not really
sure whether we shall change the name for these basic operations.

Changing them to 1S-0-0 may also indicate that there are resets with
address or data fields, which I find confusing.

I think the change is good for reads and writes. I'll check further in
the series and let you know.

Cheers,
ta


>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xff, 1),				\
>  		   SPI_MEM_OP_NO_ADDR,					\
>  		   SPI_MEM_OP_NO_DUMMY,					\
> 


