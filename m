Return-Path: <linux-kernel+bounces-569689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30731A6A62A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3878A188B1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58024221F3A;
	Thu, 20 Mar 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mp4Z9JMS"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76017A31A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473345; cv=none; b=sYVRq5yqOz7XDBjyTOR9IKxhlc0itU4EMDx4z1L1bbANonSjd7C5YrrkboEvb7dpPWCdnAO6kG/cQQy7aQFpkkaNYcztOx17pPvDgFynvXZ3t5m4eCPI4E+wPs5S2RBIKm04UUhEwH9CvzzBVAr5QHYKwwgH5oG6Va8BVM2iZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473345; c=relaxed/simple;
	bh=RlaNFJ+/2Ohztr2T2F68lXJH2XH6ggckAa6Y7NullIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzClhobIHOdcD4RQt29Sn2e3TlrOfiEF3tDj1eVj9H6bQ91t7e8Kv2NQoVu7YXMH1ctazWCrg+vKBdkCu5uplFY4x2ldfSBiyqyDTRKLLHH2OE60PPv++GQnivn3o9DihrwzcFPpWYt6N4PpYmNXzzvCabzG99C1j38C0tq+qZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mp4Z9JMS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso4532895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742473341; x=1743078141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VB7C72uv0q6FGUYx5k/EdSd4Dq+r1W0sd0YC2URqROM=;
        b=mp4Z9JMS9QQkyXMqxDjUMCqGJZYS47lIPdhyMunD/hbgAIs4AlchpF0TM4SBkFVQ9f
         QHabFC3lQKwUb1uY7HVyiE0JAoda7QX4IAtg6jv/+HafvVWR24mq134ioNyCkQ4fKTDO
         /QS3/KsH93KvAAS12reKH/sFLQVh0VPwqsxmIQayx/QKzu573Vq0MxZLfNKg5ORkR92l
         ccccfsdp4KBlPn2QKrmyR6BYWULS9mVDRVLLpUmtfqlhzBeENerHh0Y/IM0yd9Ed+LLm
         jfyOuyr6MwnpnwuAm7nxJo6vmH3ru3wshVYgOXHTcJdp7d0WFB8qHaNgJmGdS2IaNmwi
         P23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742473341; x=1743078141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VB7C72uv0q6FGUYx5k/EdSd4Dq+r1W0sd0YC2URqROM=;
        b=PQ3/BHk3niE0J6gMgM8tt5JtZFbteHmmbUbqpb9Uinpn63lOgHkS602kSLmQK4wemF
         AXhnSVaglJMiUPWl0t1DTTIoHVj8tHrjgJboUalwWBdi+JqaS8Dl70JSyxsTjMUSpgWd
         97AJDcHSq6mZrm+VE9JHylz9z5ZKbbp+WcaTyfVkWG+tb+LcZPwx7e7YC92mUWNIym9f
         c0HHAR9zuwGyy10fq74ZXMUlA1hWtk6xT1+6MoMaiBG4J2JCz87qQiDg2K8iGgwD/dQT
         rdtSKO8n+wcvxIBDIIvqXcHZp61RZCzOp3PduIYKQRjC1mgoRcuPfpd3fI6RoZriuU5O
         yZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4chjPE8EZX43nroEtpqnweqJlOVxmzkpfZQmlOye2VWjB9tMjvPUBzcxVAZqXozZ1PUF8mXAKsdqiB6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07BGDE2GM6FTe395P/jjk9n/FGOYDN0CglULsdIGon6dlu2p7
	JDKBk41v+FPxWb+dN/4j2pDqDlXCW9aRaq03IRVUPytpeVYo73xIqNFgP1FdrBY=
X-Gm-Gg: ASbGncvSJqUduVdPXkntENid2m9iP6h6h1q4JfSWeBnfgKfoblzJxlaYsjkgsBdLRPK
	as5uVwAQtc31ufx9YtXcnn8FXoIGND1m8mcRc4ghY9654UBhXVdUAt7ecjgP1XtRdM91YE05fHu
	SAS3XYgQ+9fuZuRDroPeTRTOiCW/t6gzVn4woHLon8ciqyXV3iyP7G8xgRRZOrhuAZZgkFC8JrU
	+o9HifS5vBe7JFeWoK6WSkK1CYaq65GmuI7MwyRuFY/jrglgb2eQvLLegjuC72oAq2cKvBtgvqO
	yCjUpqboZNqQrgb1gv91TYJ3Wztdv3DJy0rk8MlKc6QTEtHPOP5Q6g==
X-Google-Smtp-Source: AGHT+IEa4hSKgvDPWYGTY2ffk0ESLbrdnjJCFHK4rbjgFMQ6JpK5xa9Ql2PLLczNDIAmHxopLYeHzg==
X-Received: by 2002:a05:600c:3b92:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43d43875949mr64957505e9.18.1742473340892;
        Thu, 20 Mar 2025 05:22:20 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm24085743f8f.51.2025.03.20.05.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:22:20 -0700 (PDT)
Message-ID: <c4153f4a-667b-4b5f-8e2b-82c512df9515@linaro.org>
Date: Thu, 20 Mar 2025 12:22:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] mtd: spinand: Use more specific naming for the
 write enable/disable op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-2-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-2-45c1e074ad74@bootlin.com>
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
> topology in the write enable/disable macro names.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/nand/spi/core.c | 2 +-
>  include/linux/mtd/spinand.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index ea6b48242ad4a4e51c713907ce5cc55022cdb569..bbf0048104aac86e90b0706793db8503c8fc2a3b 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -362,7 +362,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
>  
>  static int spinand_write_enable_op(struct spinand_device *spinand)
>  {
> -	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
> +	struct spi_mem_op op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
>  
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 4f47adbe4566d7813ffd8fbfaddd1a85d88d0208..0d2f92d0746e8079e46bac9402ddd22d3d2a86bf 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -26,7 +26,7 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_WR_EN_DIS_OP(enable)					\
> +#define SPINAND_WR_EN_DIS_1S_0_0_OP(enable)				\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
>  		   SPI_MEM_OP_NO_ADDR,					\
>  		   SPI_MEM_OP_NO_DUMMY,					\
> 


