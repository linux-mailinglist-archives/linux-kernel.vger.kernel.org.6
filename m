Return-Path: <linux-kernel+bounces-569697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02EBA6A642
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6868839C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96B221DBA;
	Thu, 20 Mar 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmwEsnYk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66986212FB3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473711; cv=none; b=bHR+mvCo86M0CcawWCxUzC2aGWMXDU6bn3hKCRNnwnD/JZB/YNT1v+VIr1A895OiSGhXngc+d5svJp+T9bbsSEjnsyEJ5SZEgNUOyBXjNKk7rUsmStGD2lsHgySQknAl7sAqAoMpmXrqX1oRhnyMd+BSaw1aiA/WHMjeLHgTso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473711; c=relaxed/simple;
	bh=uEFlV5ye5JUwGIq12bEusiHzsY35WJz9M7dh8l8zZhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czIf71ZZSbc4BTw7OT1gsze0PSkb1CTbdi7FqmPWVsX3gDPUCJFLtN7/61oTWvnBI0E/M9Ms4YSPT8xrhJeBIORNlNH33u8TrE6WwMh4pK7K4UAqoACpd7raLMBOHFzC16MKOhdmNyxkqpwe28vSryBmpHFjl4iRokWa6R2yjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmwEsnYk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso5061115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742473707; x=1743078507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9cOgDku+0Amja1d3cYnnljiqdZbZHTap1QLiTDrlbQ=;
        b=xmwEsnYk13kyGn3kP2wcj2PoCqKENSen0LpMlQr6qX8xyyvwxU3zaleD3tk++S8nTI
         vh1CdCAo/R7Ypvf2Tz4s0HcZoUF+jklBrDKqWaULe6Cfmt3nLo2/F2S8VAui6fWmqmLn
         /wD0RZ5TDAQVmOMKMSR5+7rEyxhDHT52ZokHZv4Csgav4Wf977sxXxBgLlAXjdMNG6pl
         rdQ2notsndvmZsDIqqn1TWuLpz8lPO/r++IVt0ETeTlnMmbj2fuTWsGneE5hD0hR0SKj
         WZLDF0PSpL6ZVbhs8+rYw0C2Dz/VQ059A1cy1FWi2OEWsEayUrmEmuVS3ZLJAq2GaJjD
         hADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742473707; x=1743078507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9cOgDku+0Amja1d3cYnnljiqdZbZHTap1QLiTDrlbQ=;
        b=NGwLGUJs2ouwtqbGpkh1uR231CItEPZiRQHag8Dee1JH8KOkbtOksh46UJ4Fi5ZZgP
         2d7MdIgl1+rbscWbmZmSAtWLb2h8bwPKbnYYLzivPtoeTX232wM/mWyijpKf6FOfh0aP
         Hu+Q2trdg/4QCJhsnn6Re3AW6YjHcWLy8zOu/f1vVuSAjfEs6alLyTcuyEoYIz1mvt2m
         geswqDOOgX/ooF8S4sMpRSMEnNW4XkjnwSi+x4puwrb66azPLQfToolkLLAZnMRgKLm1
         iN5Z2ctbjihhR2i0scpjavrhx3EN4z1QC3V9pdg4taaZH638yOVIiC8uJW3Ba9QzsN6+
         U96g==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1MKh+sQq5YmzsOFLPVQg9TLGoKrov5rUEVgUQilt9R/CPeNqg32ZxoMjJMx1M325Ksnxbx6FivQwoTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUWJ5HXTwGgllUnzidWkEOaYsKDAkmqwN3MiVA6i690/c/Xap
	lQxC1HEzIdLsy9oi2lDmxaxhdjo2+IvLuYFQ0QpqkGcKGjoTSzJ+ciYP9X8PUNo=
X-Gm-Gg: ASbGnct62OU1LLAajDcIFgEPwYdX0nvscaLiTVgXeOhpVGNZ1PVxAcRgKsJATUjUlot
	O+wPvFseC54z7g+xYvg4DyQCAa3tlka4+Vt+Dvrg4Dy9mVxqIi4l3ncenJOIzTex0Gzz3y1Xyot
	WeKKxVTHHkRcJ0qW9wsuiNDsNEynoCgk4TgE2xy9g9I6x9O+zLLHRsht6efTMjChLArdW62E7r4
	daKsi0b8mdmwbk5lCMAqCWiljzuvetiJlrBBNRCdyeK7fYijBe+GARiKklh4Blt5obCaD+Kdzg+
	WzP1I/5QrzLluXcZxMRGPi1utmaSw3h/W6gSJR5ZSbg8bBk5C07lFbEjOM02dJL9
X-Google-Smtp-Source: AGHT+IHYMw/fKseNAgpR6bEDDF/GOdtjD/avJ+5+yhNRO0ILjtoSbBDdWDvP1ili6k6UrKkFRBtFTA==
X-Received: by 2002:a05:600c:b95:b0:43c:fe15:41e1 with SMTP id 5b1f17b1804b1-43d437801e2mr63982575e9.4.1742473707500;
        Thu, 20 Mar 2025 05:28:27 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f376d3sm48539535e9.4.2025.03.20.05.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:28:26 -0700 (PDT)
Message-ID: <b6531c3b-b550-48ae-9a57-29a11d9e5cf3@linaro.org>
Date: Thu, 20 Mar 2025 12:28:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] mtd: spinand: Use more specific naming for the page
 read op
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
 <20250307-winbond-6-14-rc1-octal-v1-6-45c1e074ad74@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250307-winbond-6-14-rc1-octal-v1-6-45c1e074ad74@bootlin.com>
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
> topology in the page read macro name.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/spi/core.c | 2 +-
>  include/linux/mtd/spinand.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 1959e8d9c64be004c71a0d6ac6454fde08e708fa..2ebc802299068ef69068422d1ef6585f63365832 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -372,7 +372,7 @@ static int spinand_load_page_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
> -	struct spi_mem_op op = SPINAND_PAGE_READ_OP(row);
> +	struct spi_mem_op op = SPINAND_PAGE_READ_1S_1S_0_OP(row);
>  
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 545531afe2dac593d112065483afd180226cc533..882b635228860f45e52d516421c1fc3b2c723b9b 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -56,7 +56,7 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_PAGE_READ_OP(addr)					\
> +#define SPINAND_PAGE_READ_1S_1S_0_OP(addr)				\

I now see that when all STR you chose to still put S next to the op
fields. 1_1_0_OP is alright too, it's equivalent to 1S-1S-0. Both are
fine for me:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x13, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
> 


