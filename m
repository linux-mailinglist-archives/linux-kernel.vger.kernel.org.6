Return-Path: <linux-kernel+bounces-386413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1B9B4326
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647931C21DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8A202641;
	Tue, 29 Oct 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G69VEQLh"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63220262C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187187; cv=none; b=aTfgLNKh4U5Xbbm9tJ7x/SGED+zaWkGLyZE1QY2wmyKXDwKhuHhEFgXcEdhstOClq5+v7Cd0AeY2hmAoZ+LBaa7SM+r2FXDGOIoAjYKGA0pApAazJGkQRlWJq3lc3byxVYeIVRxXxsUwvn0q9q40XMviw5YP/reMCsYMhftW33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187187; c=relaxed/simple;
	bh=6sSUXtJmXWATI34LDjL0Ug60zK04CeMFAMXF1weyJRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc7LkVyLLPp32yjG6dAj1i1b3ftTEA6AaECKwrcnG1xTe5xG6X3C7sZmYYgc9P4oyTuHUCGohfe1oS6/egyxLii8VsgEfslv0fBDijDp3sgGpGkyuALJOD7ohdJllhivrvTmYikVgGMz1gywoRdW3QIa6ucinuXnNC+zYoKel8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G69VEQLh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so3324966f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730187183; x=1730791983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=or0vKRrASb5HvCrI2JbfkMljC9btgFadJzS9plKVN/E=;
        b=G69VEQLhx7ZDD1IvaA15EXB+Rfp+QZKnEFnKwgPox3Y6HyP3XOmdURRvYm1+d5LKiy
         kB2B6q8p6kSe40f7/uT/ejC9Hevb76V0JiwA33cipYRO/UlzmFNhgp+YbGbCtMmrAeHq
         C9wRKt5Ggmn9+LrvFthN/Pkxj3nK7gDhA5Fr/NFLxCf0wrxEyHSM+QU1ro4x19TYD99y
         B5Rwdlc256d2KZFiWdxi9BOGQr8GTecXy3vUg4mFvMb18vQYwZ90pdg9AhyepHZmtuWZ
         8le2Vv+bqFg/Z25Vf2/BfBpQ9ntKWQa9ig9LKgPHICVdAW0F1ynPJ9WvK7BhUX7qTZbK
         eDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187183; x=1730791983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or0vKRrASb5HvCrI2JbfkMljC9btgFadJzS9plKVN/E=;
        b=uYvC9Oj3rrBqIlNbESt9ir/zfSG+2JSdm4tw529FfJSsvLxAC9008hFL+5IMLbGD9v
         rb26hvBVP31S6lFMObbM/cThJSlhqQ6BIIJR0IY1oAl6zjDv8qZC8SmK2TKTV+hwZJUd
         ghp13VWYy4E4R7YxPeqvjhhNc5CaEhLAvkmSMc1zJIMsh8BsL63emCDn20kroQE2di4l
         qMmLr96MFhbTsKz0o14LdpDJNJ+SpHcU7pWK5OZi13Tp9085bGE/Fu1waZj4LNrWVtkZ
         c3RQzRyv/ErOx6N+xrOu2GhYUmumJtch+ipt6l/OBLjhk8+fDNfKle9MiCWbyI3bpiar
         f6ng==
X-Forwarded-Encrypted: i=1; AJvYcCU3oxfzqUyL3pMvC0bL66dsnNE+VLM7yZZh6F5vLcp4GbKquwU5t7Akjjmdzy9WOFDAF+Xr6j2ifBc42mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMm1kmwLzReVTA5Ulqnick2gZFE2uObqn6UP3D1rZXlosUeiCG
	akivFBC+CCEFhXPwmYmU1qu29GdcARBywCbjruYY6eruVodrRVPb4YOLt1XFeJc=
X-Google-Smtp-Source: AGHT+IFK3d9LU0pbDWJ6yIXSAn0RE4ez5L+HbHspFy6HdA/OMdwAxqljsgdqjbowDbh55t60Gd/E3Q==
X-Received: by 2002:a5d:488f:0:b0:37c:d179:2f73 with SMTP id ffacd0b85a97d-3806111f422mr7802502f8f.13.1730187183188;
        Tue, 29 Oct 2024 00:33:03 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b4a3cesm11579197f8f.63.2024.10.29.00.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 00:33:02 -0700 (PDT)
Message-ID: <f4a5e5a4-9a0d-4b3c-8fe3-80e684fff758@linaro.org>
Date: Tue, 29 Oct 2024 07:33:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: macronix: enable dual and quad read for
 MX25U25635F
To: Parth Pancholi <parth105105@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024114021.17567-1-parth105105@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241024114021.17567-1-parth105105@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/24 12:40 PM, Parth Pancholi wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> The MX25U25635F supports dual and quad read operations. Set the
> corresponding flags to enable these features in accordance with
> the hardware capabilities. This change also enables dual and quad
> read operations on the MX25U25645G, which shares the same ID and
> has a superset of the functionality provided by the MX25U25635F.
> 
> Link: https://www.macronix.com/Lists/Datasheet/Attachments/8663/MX25U25635F,%201.8V,%20256Mb,%20v1.5.pdf

Looks like the flash defines SFDP tables "Table 13. Parameter Table (0):
JEDEC Flash Parameter Tables".

We have some minimum testing requirements, please see them on
https://docs.kernel.org/driver-api/mtd/spi-nor.html

> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index ea6be95e75a5..be55558c8ad0 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -129,7 +129,7 @@ static const struct flash_info macronix_nor_parts[] = {
>  		.id = SNOR_ID(0xc2, 0x25, 0x39),
>  		.name = "mx25u25635f",
>  		.size = SZ_32M,

if we want to switch to SFDP initialized params then we can remove the size

> -		.no_sfdp_flags = SECT_4K,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,

and this line as well.

>  		.fixup_flags = SPI_NOR_4B_OPCODES,

If the flash defines the 4bait table (I don't see it in datasheet
though), then this line as well. We may remove the entire entry and rely
solely on the generic flash driver.

>  	}, {
>  		.id = SNOR_ID(0xc2, 0x25, 0x3a),

