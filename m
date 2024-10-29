Return-Path: <linux-kernel+bounces-386396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7919B42EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931CB1F23511
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A52022D3;
	Tue, 29 Oct 2024 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tC0dKt7t"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8D7464
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186174; cv=none; b=aY8VFIUrM16MW2DpBCU7c40uNtUddshvFuKYNaqhf+Bjdlq2kEzLarw4gE4Inz9kEtsCSvvq7ifu3Pd1+b2YmciZRxR//kf8sFisPa54bc6zI3tYwW4g6SyrLSZplTGtiMshcAbzAkfCek1IaYfdMgqQ0u7c3E9T4yRgu2c93tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186174; c=relaxed/simple;
	bh=ivbA13vANqI0R2zTovbioWz1L6wkBdGdq78u4L9Bjd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bT/UJ6SfeaIpgLuUhJLSugC+v/m3gMM0tt9cW0z7u1heI0J65/t2yCorgEPFiB3d10cs7hEjMm5IqNIieQM8BH7wgIPDADgXtvLsstVvsPA1nlAJktgj/9WB42rPoH56lUDaXlr8YYgpQURnSX6DS0ZXNbfZgDm9Vz066gK69xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tC0dKt7t; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3424352f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730186171; x=1730790971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcDAqbWqsvymz4STwgK63u6lc06fHWC6bKwW46nTONk=;
        b=tC0dKt7tEN6UnWO6/EsFChMWWa1j8iNWPipFGbM8vt+L8HX7WWaH3pSAigi5mlu5BF
         QXqCLwD3PDN98nBvZwJ/KZb5OQnD9AU0vhtrFp746jz4TfXEagzn5sIuQmWqcp7eU+Da
         NRq98ONxhnrLda9aFWhNxqybRCRKLPcxxiXNgQKN0g5GbMOJG1U3zthRwhwym73dyQFw
         56VTM8XdyaQ0c07HzYjih2L5UQfFE7kljYldf4J+lmckARhAYw5gsGvxot3Cc0rLbvVx
         +EilDjNGbj9wINt2M6iuM8TbB4T+8aQpBuUwbaIuSAw+6Vk60u4houkE0PuZ0GvHYYaa
         3qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730186171; x=1730790971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcDAqbWqsvymz4STwgK63u6lc06fHWC6bKwW46nTONk=;
        b=vnmrNf8rXeHLL7N/GqDp8lrQFKKZb/ACNUgcv3P3th8Yb1KgHXipclT/Yl+1r7SfVN
         i1nTaPOnSxXFB2/ySGHuWGZf4WYF4aTEM9ao+6rbo9Kf3m2yn2bjMy0ijuW7WeW1HTfY
         4YdmJmC1jaWW5nFcXO7rPosaGDG5Ejq3oFPZe8MGBBqvjeIA7bx0UJfxronUl7F7cSvU
         h2FZzoTuP/mr4PsekhiljvkDhtkXOPFsKN6tOL1e9dD6nrnXMc1fSxmUfDVrpvNI6sO9
         e6rTVKZpYUwVPHR/OtVB189ELbA2FFNE3LqiI76PGxdvBTU4q2biajkDzzEnlS8kS+fa
         i6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpwvJOPQAvMoDuazhvHnWhOAWvvndg0YQ1NBqhVSMEhzfHlCHbDfx0orXsUKyPzSA8TLHiWtVOeHmyx5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YznCsjfwF/ZEe/sOyi869X9qVGFZLm86b1H0OxCWtIOCbRIlAx1
	9zd5sY1xtZRQn24XIOJN2TC0l5U3P38fati1/NRC+4tP2GwixGYLuZuD9umUk9E=
X-Google-Smtp-Source: AGHT+IGyPTVVmj2DPxCz2CTebpQz3Rt+6BKUInDdlX4vKTXedS2U3OsrdThrefTQ1j8XH9/JSVrTRg==
X-Received: by 2002:a5d:5711:0:b0:37d:47b0:6adc with SMTP id ffacd0b85a97d-380610f8251mr7858179f8f.4.1730186170958;
        Tue, 29 Oct 2024 00:16:10 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c69esm11636277f8f.13.2024.10.29.00.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 00:16:10 -0700 (PDT)
Message-ID: <239d2425-52f6-4deb-964e-e22d1a1f6637@linaro.org>
Date: Tue, 29 Oct 2024 07:16:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: atmel: add at25sf321b entry
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241018-spi-nor-v1-1-d725bfb701ec@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241018-spi-nor-v1-1-d725bfb701ec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 10:51 AM, Marcus Folkesson wrote:
> Add entry for the at25sf321b 32Mbit SPI flash which is able to provide
> SFDP information.

then we could initialize the flash based on SFDP. If you don't need
locking then probably you won't need a flash entry at all. See
https://docs.kernel.org/driver-api/mtd/spi-nor.html

> 
> Link:
> https://www.renesas.com/en/document/dst/at25sf321b-datasheet?r=1608806
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/mtd/spi-nor/atmel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 45d1153a04a07b7c61f46b117311b24ab695038f..e635559711a4b402d23d49da93efc15e6be571dd 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -238,6 +238,12 @@ static const struct flash_info atmel_nor_parts[] = {
>  		.flags = SPI_NOR_HAS_LOCK,
>  		.no_sfdp_flags = SECT_4K,
>  		.fixups = &at25fs_nor_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x87, 0x01),
> +		.name = "at25sf321b",
> +		.size = SZ_4M,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K,
>  	},
>  };
>  
> 
> ---
> base-commit: 200289db261f0c8131a5756133e9d30966289c3b
> change-id: 20241018-spi-nor-dc29698dea0f
> 
> Best regards,

