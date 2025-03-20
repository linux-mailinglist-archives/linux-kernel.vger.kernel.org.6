Return-Path: <linux-kernel+bounces-569694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAAAA6A63B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3E887752
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA0222578;
	Thu, 20 Mar 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUJOgP+u"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3E2222B5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473411; cv=none; b=lazaX21K2DlrKG8T1fE9COxDAqMhGT1KNZzdVP9d3egl0+ScFl/NoPTucDafBC6GrYQ++ofsV++IO9v/azfsOIc98ssJU9KNsnwzV+OaFABRF2XiS9soOpcuwi8zgVo1ep0gxJI4M86dOnKThN1Yz8DE2F4fX9wLhUtgz+X3VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473411; c=relaxed/simple;
	bh=CXYfkFhDMRdE7zi+DztlxCluS3zYROA1G3X4Ay+BqEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCbqfuw2d8tBtRkGQTpdq8lK+HEB/ns9ZsdcPuVliGT2KRzs8/6NK5IkYsS2GH4WThDV6xbXVprnObZMsfV/ox5A7Ab+xw8lTsVgstdio30m5loTE/STN3hByARs8pJoWu/p6H2OwiHi+UJ3Hk9D86cBFAIDJy8VAq6UsiDnctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUJOgP+u; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2aeada833so145091566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742473408; x=1743078208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4L0wtp4vAfj99xNR7JACQ5fBXNp5AHv/RHN+M6rMMI=;
        b=WUJOgP+uTulStjXHUj4BMW6WKPzWsb+rDA7omGvnT+2yp4usaJLvC+z+zzVM1k0b/r
         EW5GChq4tRNA+/CXZ99ngz4Es5k0V7CqrNE87/Yx7dHJZdK7AX38IlxvC1h1e1wtt4I0
         k6w/PkOtdsPHk35I6oyTYTK2dTcMg7RlJrxpuvTb4iRBksUM+5w2MWwldWIyaCsx1+FR
         eLcoqbvj24rOW2LUo2W9jtOOXvOwRHpbM3WqqOtqU9MFqgX1ct/+y5X8VB8OQXTsAaks
         9Ia2MapwHuYqXsMO+TXg9GKetw23GzXvXkE0Wt/83Zazgy6dnkZA//xDHqB2TrTIwG37
         +aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742473408; x=1743078208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4L0wtp4vAfj99xNR7JACQ5fBXNp5AHv/RHN+M6rMMI=;
        b=oQBkRjq2tJr/qxOpFrKmGru33Xl5NK15AnzX3uM9YICUF3pIuADXKLhczD0ggwbS0d
         LG/ZGTYesTH6PWH0ywWAbszS83u4rUiclPO2IOrP7sfbzn+wZQVVRW8qKKUHbZGR5y25
         4gm/eB1ixbvSBb8GIEn5v4qkyqZlQPqd+P/8u94+uinkAazomHI9zxszHDqbn1nIiila
         BuaA23u9wZgf0GjhkCGfvY1DF/AcBIK5T9Kna+HXu9eVTkrAADWNROoGU/4kAAL4gLEn
         if/umPncYTu0tmi0NL5BbkzVhiPzUFe0W1MogQPujfXr3k9q0ezJsueir0iP70Fc/25m
         jhbg==
X-Forwarded-Encrypted: i=1; AJvYcCV0TzT6w0pvKrO+JvCTl3eipd2nhOayJaJIjAmz4Tj+MzUWJHnnT2R7qEAylcm+XJD1/WW0OdI2IaVlyOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rAjE6JhriTxTEmKFkANv615P0Ss1dLy2UgPYgKz0iAfrDkSU
	DwpXmksY0sVEYrezf+TX47hXI3sUCIiVFYFCM8rJAV81KNNATYvrH08/MF1fXVw=
X-Gm-Gg: ASbGncvQvy+v2IkquFVqDBqnafCbsiRR/opu5DZ7ubk2Y6CNsywDbUVAtXvZXvMQxDo
	kIKdiWBKMJdSp4pABOAuIDlr8ZcAAjRzLL/d51U+XZMOhz3LCnH39Njfyh+ZdZNBAtDdDrZoikl
	LelZohlsPBfIKWtSSjs+0WaT+cIjyMKZWrl15kyOwCT698Rc0oc7Xha0TR1bDsHuJ5uphZijxnd
	8YaM3w5TIJEgA6J8LQ1tzCPIXF0DJBFyX9om17r6QJNsH8odA6Y3+fHLjwpnPdZOl6SntTGeIq6
	YxPJ64EUxN01TmrYjHvJ61Pz08m9wou5bcM6tG7hyPUOeQTnBaQRVg==
X-Google-Smtp-Source: AGHT+IFy4ujO0Rlctp5VuJNnxmLa2FTdTGd/kenok8V6y6/ECSHPNsDf3e3bTkQH3sfVrQUIU8/JFg==
X-Received: by 2002:a17:907:94c6:b0:ac3:8537:9042 with SMTP id a640c23a62f3a-ac3cdc8e455mr321840566b.30.1742473407716;
        Thu, 20 Mar 2025 05:23:27 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3da7e00dcsm96386066b.56.2025.03.20.05.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:23:27 -0700 (PDT)
Message-ID: <5db8f280-8f1a-43e0-a2d3-baf694eb81d2@linaro.org>
Date: Thu, 20 Mar 2025 12:23:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/21] mtd: spinand: Use more specific naming for the
 erase op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-5-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-5-45c1e074ad74@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 3:08 PM, Miquel Raynal wrote:
> SPI operations have been initially described through macros implicitly
> implying the use of a single SPI SDR bus. Macros for supporting dual and
> quad I/O transfers have been added on top, generally inspired by vendor
> naming, followed by DTR operations. Soon we might see octal
> and even octal DTR operations as well (including the opcode byte).
> 
> Let's clarify what the macro really means by describing the expected bus
> topology in the erase macro name.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/nand/spi/core.c | 2 +-
>  include/linux/mtd/spinand.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index b6c0993206ebab1dcee715ea6de33efe7d5af3a2..1959e8d9c64be004c71a0d6ac6454fde08e708fa 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -529,7 +529,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, pos);
> -	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
> +	struct spi_mem_op op = SPINAND_BLK_ERASE_1S_1S_0_OP(row);
>  
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index d041b1cc18de6add45800eaa7605bda1c64ca257..545531afe2dac593d112065483afd180226cc533 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -50,7 +50,7 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_IN(1, valptr, 1))
>  
> -#define SPINAND_BLK_ERASE_OP(addr)					\
> +#define SPINAND_BLK_ERASE_1S_1S_0_OP(addr)				\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xd8, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
> 


