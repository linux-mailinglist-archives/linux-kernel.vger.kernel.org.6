Return-Path: <linux-kernel+bounces-386830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9039B4867
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A21F2380E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3B204F9E;
	Tue, 29 Oct 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhj4zKZV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07E7464
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201783; cv=none; b=mfle+LG5fnJaUjW9LSpUZE4hcUulpwGTXdqj0exUM5LWM/nFI8LpOj694gv5SkCgUbv6JT4xSAXbscH1fz/PFNNIe38tI3l6NQathIPyZLSK75VJqrLzhwife69ehy5XA0DdmHkPclYPYF24wHXVMSa9fnDjepzh5IzfgiGADPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201783; c=relaxed/simple;
	bh=xAlHerI/SjbyHMp7C5ErU7dc79CeI9j2Htf4sbM2FKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0sXcsEqLICHDqXnMbQJ2AemlJxBWe5b3/5pD3oF3UuhQ6onhy2cVAYdVduO8XOCJoCL3fcmPYDMy+UwEAA33b5a94HAaBxEKb9w+Yv3k4bx+nEHUBRHtXQA1HwT9J8RTiUIvbrGVjdyNg+0RaAhFYP6rP6W6glNvTmiaHKMJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhj4zKZV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43161c0068bso51039805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730201779; x=1730806579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+M/KQdGIkDYfM7K25gdQMNQDVUPshojJzAQojc78QCM=;
        b=bhj4zKZVLQBhgJelh+LhcF5pQWD7shtmmkPFvvpQj/TCSU8lwpLq9rNYwEm2e80alZ
         aoBPXE3hlUN9f46P461DUzW9RYHIZXyMFDKF4Dx7TiolahSceD2kcN6bI4EWQ0PtHVHs
         FwyCj9u++wEfEZbbRGUTJgdgVtLy27jOqAWta2VoDzvRInDZJrcFhFb2hgzRfJCReL6Y
         dfGfkzr14l/0CM4ayKfC46ttBYoQA08n3afW3Rr49oQhd/Q4sO7tgChPbbYAezU9j34u
         PfA0nlKZKCE2ClO+NDeQKmvR+y0EA/zSrnMtioSfOY2IpoKc5Xjl577fD/aV71gA7Vpk
         w27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201779; x=1730806579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+M/KQdGIkDYfM7K25gdQMNQDVUPshojJzAQojc78QCM=;
        b=K1m51c5R3Sr8PhxPp7NGTESkpcgYqLzjKkqCHnTs5M6ZQgWyIuqm6zWufoOynRvOs4
         +LboIGF2/Zn0KM0ZswpHBd9xClidJeOgGiB8C+4de4UM/2aPWA1t833Pmkocds516KhM
         pKUafE4jJme45/7RvWwY7sNuVgBEjyTPAswzaYzMGuKpkdLsqIP1Qlo6cplfGmIhsQIf
         MKDG6AL183d6qSuhhZt/PjP74z1If21/flbdIYzATlZiCPHFQtNaZ60ubQtBgz7hzPp3
         egshXPna+i/FEfj6F1O2yDIt5NvrCk/+2FW61HBvB5AzaFdkiIn8kfah8Y1HcRrMZU3N
         ENhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC1qlUKTGHCUfvAiDCPIW3wckcsNW0Qm5rfrXQXtNAOk0G4Wyb5naKfew4bvscLuzqsLQ/OU8a5UBqdBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRd75WwrIBoH/N5DYEQkIbCxzyVkFvZlgjB+Rqd1QCXIF9LVA
	LDJ61AeawGRfBvGSQrCWmwdhu2pTIdOZn2f1kwLgle1nr9cJ5zl5r/ZHpjWfRqN/QnPaxq/cJ/R
	A
X-Google-Smtp-Source: AGHT+IEOBrGtnrhp04p9oamxv3IoUL1pQg8omLS9eVTdrvSsB1a4sDi6dykLX3HF4VOaaj5ki/bCvw==
X-Received: by 2002:a05:600c:4e8e:b0:431:3b53:105e with SMTP id 5b1f17b1804b1-4319aca5995mr92471355e9.9.1730201779516;
        Tue, 29 Oct 2024 04:36:19 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360d32bsm141307985e9.46.2024.10.29.04.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:36:19 -0700 (PDT)
Message-ID: <0bbd2514-ff51-4b0c-b3ad-547e4937d9f4@linaro.org>
Date: Tue, 29 Oct 2024 11:36:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: atmel: add at25sf321 entry
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241029-spi-nor-v2-1-e166c3900e19@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241029-spi-nor-v2-1-e166c3900e19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/29/24 11:23 AM, Marcus Folkesson wrote:
> Add entry for the at25sf321 32Mbit SPI flash.
> 
> This flash is populated on a custom board and was tested at
> 10MHz frequency using the "ti,da830-spi" SPI controller.
> 

no sfdp for this one?

> Link:
> https://www.renesas.com/en/document/dst/at25sf321-datasheet?r=1608801
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/partname
> at25sf321
> 
> root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/jedec_id
> 1f8701
> 
> root# cat /sys/class/spi_master/spi1/spi1.1/spi-nor/manufacturer
> atmel
> 

xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp?
or hexdump -Cv if you prefer

> root# cat /sys/kernel/debug/spi-nor/spi1.1/capabilities
> Supported read modes by the flash
>  1S-1S-1S
>   opcode        0x03
>   mode cycles   0
>   dummy cycles  0
>  1S-1S-1S (fast read)
>   opcode        0x0b
>   mode cycles   0
>   dummy cycles  8
> 
> Supported page program modes by the flash
>  1S-1S-1S
>   opcode        0x0
> 
> root# cat /sys/kernel/debug/spi-nor/spi1.1/params
> name            at25sf321
> id              1f 87 01
> size            4.00 MiB
> write size      1
> page size       256
> address nbytes  3
> flags           HAS_16BIT_SR
> 
> opcodes
>  read           0x0b
>   dummy cycles  8
>  erase          0x20
>  program        0x02
>  8D extension   none
> 
> protocols
>  read           1S-1S-1S
>  write          1S-1S-1S
>  register       1S-1S-1S
> 
> erase commands
>  20 (4.00 KiB) [0]
>  d8 (64.0 KiB) [1]
>  c7 (4.00 MiB)
> 
> sector map
>  region (in hex)   | erase mask | flags
>  ------------------+------------+----------
>  00000000-003fffff |     [01  ] |
> ---
> Changes in v2:
> - Change from at25sf321b to at25sf321
> - Link to v1: https://lore.kernel.org/r/20241018-spi-nor-v1-1-d725bfb701ec@gmail.com
> ---
>  drivers/mtd/spi-nor/atmel.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 45d1153a04a07b7c61f46b117311b24ab695038f..8285a16b253d54ae8c4a5302850244d2248aa755 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -238,6 +238,11 @@ static const struct flash_info atmel_nor_parts[] = {
>  		.flags = SPI_NOR_HAS_LOCK,
>  		.no_sfdp_flags = SECT_4K,
>  		.fixups = &at25fs_nor_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x87, 0x01),
> +		.name = "at25sf321",
> +		.size = SZ_4M,
> +		.no_sfdp_flags = SECT_4K,

it seems this flash supports dual and quad reads. Do you care to
add/test these modes?

you'll need mtd-utils

>  	},
>  };
>  
> 
> ---
> base-commit: 200289db261f0c8131a5756133e9d30966289c3b
> change-id: 20241018-spi-nor-dc29698dea0f
> 
> Best regards,

