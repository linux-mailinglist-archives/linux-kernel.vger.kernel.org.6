Return-Path: <linux-kernel+bounces-565546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F1FA66A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3047A9411
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FF01DE2BC;
	Tue, 18 Mar 2025 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdCwR2kY"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC638FA6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279235; cv=none; b=mvctZP0Pv3dyXEdwunfIMH5nq6iShecg/i1NDtD1tmvaVGb7QT3rNj5U3txFndN8TwELI7v9VgcdD5DYH5aHLLVVWq4ggf83BqBorDzd50G4+uAeHpO7zY+jKJgEjzLZmImwBppE4ErLCWGW8Q0EeNpD6EvAcnqTeJkrHeQZIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279235; c=relaxed/simple;
	bh=5HaFRYGLb2yyCH/U67X4Itm+rNjsL1DRvnAdXGz//J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V35GhDXBl9Lnd3mbhRpaDnq/7uJlNI2aNdUP9rOfyNEKTQmsxaFxB8Qwl4C4tvY8VVi6AD/GGhdZ1OTDica0A4dXM/+LDMELVv5RZBSgJaf5tXUxYJRHWP9mQq4PbGO5AyJjJJQ7UAbnFIKvEDh9D48Pw+3LtTGVX6vRz5JHWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SdCwR2kY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso7338545a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742279232; x=1742884032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RS+d+wLLTpLukrshu1KgCi2J/6kgXfG5Xv9HH4pKDHM=;
        b=SdCwR2kYq4rscnVS/MJ8inNR2j5Q5fyotR3ds2lRYxL3R42d+r0v7g0HKwGsGUPeXA
         7Kbb6WS+UTk84yu0W8qP9ow5fkoaocD4o5eYfDuZ4hFeVK300XQZIH4gojpXjNCL5ocN
         SXpRHLkcAAD1ErTBsb9cJzCXzCUSZ71KlJhp+lQrMIunqtic3yfOjLjkvZBpcIK7tKG3
         ayuj/Tk/47e0cF70gd8MWvMktKVD4miI1GQCb+iaw/XF+0QJ6kVhoUKpCGbuOKwk9a+E
         uwFsaKay+0jtH36q8b0qzw+v5BlJheeJ1o3armffHdHSZujestQNT/pCfNfwNDI1dhyw
         tVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742279232; x=1742884032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS+d+wLLTpLukrshu1KgCi2J/6kgXfG5Xv9HH4pKDHM=;
        b=uqechDCTxKp8fnrD4nY+x71WL+GUrjFm/bq1lMBD20hCfKgRA+hVVBENG6wmkDdWGj
         zh4h7LPa9F3BZc5hX3zaxN9v4dtrSVxjolzmtIBZc7E+oIJERkuD2kU/njhfdzRpgbXW
         oo7ZjV9nEtVjusgYSxI/OhCj3aaoEMkoMRIvh3ikeKCjZqMhDG27DaKQDdFAwNFw+bRQ
         quRyVz5AMH4BW82mmVkp1SOsC/sXGLSqPcMH193xSb3SD7jZbjpn3/mveI5LUqbjd/7A
         vRHGWZWinpjjElZVsmtGOXOfaGe4eeQP0/+U6rjExfxGv74vwuNKoHt0VKBdPNV6bcZr
         8apw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Pdc/1sExBHwf87dE0gaYZX6fES1quQkK//D1CAdqalsi9TQ+gc5CYeKY2SFAgJh+rcXTUKSARejxPJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoVCFiM75c2r+WfQI1KWfq30Ypi27j35d+I/A0GB+jnwQbCT7
	j4r8wVKvtKqTDVxnEtDwOyH5Mf86b26FwHJ6qFKXzdBoWB1IvJ1I8t+NARSxYVY=
X-Gm-Gg: ASbGncugmpz4F0McX2GZZnOzln1nJGZpVGUhzKCk+3jkP4dHv9MlEE6fkZiYAvtJ8je
	ENSxDmwsaJM6ohR6MsJwlZbgAO3eaPEwEem5Srox3q1yNy4cGSfNg4sAQw3q+PG466OFOVsQ439
	45wjUKJWJcR91TJjeoj59riPGb47vTOd9whTULKs4/HIXLRTtBQUaTDd/hX6pMI4KgQJigAR0b/
	ztsOeyiC61Xxb2mGM748sJzXjoSgCJn2cPO/d5y6KabKYdDiRoUaQmr//x8HISF4Mu9vRxpcHZG
	Pq3Xb49gUHQ1eU6pKVQWh223xDaqoQ/kJMx1V71b7/WDPlS3pp/ZcQ==
X-Google-Smtp-Source: AGHT+IEmbxfd59IWAvU+zhGTYt7uPPYn9mbPs0auwfyns4/IDUqNsQ9RKkZ6UgHGj0ak+k4BmthPIg==
X-Received: by 2002:a05:6402:354d:b0:5e5:bdfe:6c16 with SMTP id 4fb4d7f45d1cf-5eb1deab100mr2062814a12.3.1742279231656;
        Mon, 17 Mar 2025 23:27:11 -0700 (PDT)
Received: from [192.168.0.62] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816974b63sm7143534a12.28.2025.03.17.23.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 23:27:11 -0700 (PDT)
Message-ID: <e2e890a9-ebc4-45fb-92eb-502be027e807@linaro.org>
Date: Tue, 18 Mar 2025 08:27:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: xmc: add support for XM25QH128C and
 XM25QH256C
To: Jakub Czapiga <czapiga@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250317182107.2060739-1-czapiga@google.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20250317182107.2060739-1-czapiga@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jakub,

Do you have access to these flashes? Can you test them?

We have a minimum testing requirement before updating or adding new
flashes, here it is:
https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements

It's true that we don't have yet locking tests described, but
contributions to the documentation is welcomed!

On 17.03.2025 20:21, Jakub Czapiga wrote:
> Both chips support SFDP (JESD216).
> XM25QH128C only supports 3-bit Block-Protection with Top-Bottom
> configuration bit.
> XM25QH256C supports 4-bit Block-Protection with Top-Bottom configuration
> bit on SR(6).
> 
> Signed-off-by: Jakub Czapiga <czapiga@google.com>
> ---
>  drivers/mtd/spi-nor/xmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> index d5a06054b0dd..963a44c3909a 100644
> --- a/drivers/mtd/spi-nor/xmc.c
> +++ b/drivers/mtd/spi-nor/xmc.c
> @@ -19,7 +19,17 @@ static const struct flash_info xmc_nor_parts[] = {
>  		.name = "XM25QH128A",
>  		.size = SZ_16M,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> -	},
> +	}, {
> +		.id = SNOR_ID(0x20, 0x40, 0x18),
> +		.name = "XM25QH128C",

for the next version, drop the name and add it just as a comment above
the flash entry definition

> +		.size = SZ_16M,

if flash supports SFDP, drop the size parameter, it will trigger SFDP
parsing.

> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +	}, {
> +		.id = SNOR_ID(0x20, 0x40, 0x19),
> +		.name = "XM25QH256C",
> +		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_TB_SR_BIT6,

same here. After switching to flash init based on SFDP, please do the
tests mentioned above.

Cheers,
ta

