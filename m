Return-Path: <linux-kernel+bounces-234038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A591C13E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BC51C21005
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280D61C007C;
	Fri, 28 Jun 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBUKDczh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B551E53A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585598; cv=none; b=g0MATWP397LomBzKu7mUWu2a67HdMl/okLgWkOGsq+BX+8CtincrtY20CwnIYGY3t3jf9dI1LFeMCNiq/U+RRtlTBun8xXsdxkZUCYzzrkC1bVTKf4Ens0H3Bu+g32E06eHnm63zP3YdziRwvTSv6pMEBBtkWFJyvGqV4MrgFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585598; c=relaxed/simple;
	bh=Zkc0OU91HUSJKg9h2HoiHVtFijVhqu/DfMdfPlf7dRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M14l+659pER+9iIJevr+ipKR3zv1HghumFT32/B7ovJvMTkK1nJijX8vhir/n48LWokn/tvbwrNR83keS/cZ2tzF7LQcrB+VLoKZy55psyjZkm4hDPd5JxfE2d7kkhp9g6UAldxMukcZvHP318cgGQG/mH5wzGoJ2UVau1PdoMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBUKDczh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so5836105e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719585594; x=1720190394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fX1MMnIpDBOm77iDLoe1RG1qLzLS5Do9mpyDQwOVT4=;
        b=mBUKDczhZciHkQUM2cLJ3nUm9wdmNJZKTe8kgmEVTpNbfTXkem+hmQzEJJ41F6/FJd
         VdrQ/91S1jsYeOQTF5fCUNo6b1eNRAC1QzbAHR7CVK830OiYdWOgzAO3mMdiSEMnTGmw
         xA5eooNyQ+Oa8KsBzxPVirqfuvVWHOW4RkLAPqFHUliulIEA34P2wbhKR67muIho0OzH
         3ip3ibF+aDQoGE1k9Q4zg5bxQS/EByXlu54KwT5Vc/53Fly4qUEcSCbtWlBJP5S7vBPp
         dhk0xgcZW254ijzVynpALLORYjWBYtTaeqzf4CgxIcgkHR3FkWhiHLOndtXDwg02i5rs
         kxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585594; x=1720190394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fX1MMnIpDBOm77iDLoe1RG1qLzLS5Do9mpyDQwOVT4=;
        b=U3Wn48f7nDndyb6AtuqCGzdWxjyohDJI/wNCvAfG9c1vqX6nd+nKzr3HtPz+EB2fnV
         6niJJQ0mFhiCq9V7rYEKAv6xxqoirV9TqYwGJzIdaCHShBauC1ZYfezNP7/mnVeXn81f
         NYfFzTwSDD4679vpCVMYlkE4J6ZMUo+d9fP8SCQdpePw14U77Sd6U4jSq/nO6zblMpPs
         hYjRC9i22OMDUU61lJiqW/Q7ugHIzLnkMpWGQXMIWSjM7d6S3FU8xY+LgxHFaFr84pN+
         NVH6gebuvVIUrBn6oigSxhDsdGHtnfmfLDXoSqtdsMESREFjZUYMfskESntdR6+OAuXW
         gPeg==
X-Gm-Message-State: AOJu0Yx4zsrjbq6vj06RlOB/VKlon5h29C7r9BxrisDaUJXmh+XRhQAl
	48Y+VPts8HideL7NBd8C1tbEgZMgDit9ifQxcKch4zs8CxLlQcXtleBOM8TqEXA=
X-Google-Smtp-Source: AGHT+IFiwW/g9bMvX363nZWYpupjIfTEXXcoSHzUKGy6GKc+YaQcE+dP2/YqcheNmOHdUbTm/7lcFw==
X-Received: by 2002:a05:600c:4da1:b0:425:65c5:9af4 with SMTP id 5b1f17b1804b1-42565c59c70mr28348295e9.41.1719585594358;
        Fri, 28 Jun 2024 07:39:54 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b061006sm37150835e9.22.2024.06.28.07.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 07:39:53 -0700 (PDT)
Message-ID: <aa4df0e5-bbd4-46f7-8e58-b42a8c909327@linaro.org>
Date: Fri, 28 Jun 2024 15:39:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Add generic functions for accessing the SPI-NOR chip.
To: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Erez Geva <ErezGeva2@gmail.com>
References: <20240628140328.279792-1-erezgeva@nwtime.org>
 <20240628140328.279792-2-erezgeva@nwtime.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240628140328.279792-2-erezgeva@nwtime.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Erez,

On 6/28/24 3:03 PM, Erez Geva wrote:
> From: Erez Geva <ErezGeva2@gmail.com>
> 
> Functions:
> 
>  - Send a opcode
> 
>  - Read a register
> 
>  - Write a register
> 

Please describe your changes. You may want to re-read:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#submitting-patches-the-essential-guide-to-getting-your-code-into-the-kernel

> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> ---
>  drivers/mtd/spi-nor/core.c | 130 +++++++++++++++++++++++++++----------
>  drivers/mtd/spi-nor/core.h |  27 +-------
>  2 files changed, 99 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 028514c6996f..0f267da339a4 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -354,53 +354,134 @@ int spi_nor_write_any_volatile_reg(struct spi_nor *nor, struct spi_mem_op *op,
>  }
>  
>  /**
> - * spi_nor_write_enable() - Set write enable latch with Write Enable command.
> + * _nor_send_cmd() - Send instruction without address or data to the chip.
>   * @nor:	pointer to 'struct spi_nor'.
> + * @opcode:	Command to send
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -int spi_nor_write_enable(struct spi_nor *nor)
> +static inline int _nor_send_cmd(struct spi_nor *nor, u8 opcode)

and my review stops here. Why did you think it is good to introduce a
_nor* method and not an spi_nor* one?

I'm not going to review the rest of the patches. Please send a v2 that
convinces me to spend more than 2 minutes on it.

Cheers,
ta

