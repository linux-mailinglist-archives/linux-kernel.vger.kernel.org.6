Return-Path: <linux-kernel+bounces-347110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A898CDF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83409282164
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA711940BE;
	Wed,  2 Oct 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S77LzS7D"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478A8172D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855117; cv=none; b=mc/DU0sFNddhxaPs3g5uPjiQidl54GHl37LD59Uc5BEkMbqPemB+miW+Udwf01yH+ctTSmTiqYv/5jpNcHIVat1bJQcaOacbDUibmJy7zI0ixALznSUcYgIKiBG6eDz7c3bAnwYYt1oFCS2/BMW6euzqVwSYutgUeq5LG96hnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855117; c=relaxed/simple;
	bh=P7T4X2QOQmn/6AJQHqJ0PxbUiZ8NKgqZP340whTGLWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nfbw6gJZ+gWUv6T05DNZkli8H54h257f8IJYbuCO/Ve2nUeQgc715NWsx9rWEFfSn5Yg0PMcV3OkwtedYx0wbk2gzLCsIxmB0fX62gyG1PeN7NTBAw3F0SyRqT1JZizwA8YFr5IFDfJmlHw8L7Cqo/fgFOGUg4brW6qYZantiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S77LzS7D; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso1029974666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727855114; x=1728459914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNRdu4560cxyW4H48SPNRuOsXYe3wo5Kz8Tevusjh/Q=;
        b=S77LzS7D6MEln44nyEtM2+FncfpE+uCCZqYSJziLogBkTyj55qGuHCFNd3GJ58i28M
         d2JpxZIXc80yxs0nVOLSGzsg6b8WWslT2X9iTaGenJfYl/VZvLAHi5vWDsdJ0qr6ZuH7
         /Zl/Odqs5uuAt5PFSMIyEAa+oyVDihTNGTGhwusQLC+9K9rcz9VS3idCBdTSwD7mtC01
         nMdl2ILW2e+HBzcuy3LBoC0L+2PDpU9Vh0m3YTHuehg9fTfKcrPFUO0f0l7MfzE/9OIQ
         ovBf3f4QiineCjBczD3WTRe4dDGUwj0GVPDRgRS61MHUv9RSfPTQHKDg1D5/qS9wVlmR
         N+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855114; x=1728459914;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNRdu4560cxyW4H48SPNRuOsXYe3wo5Kz8Tevusjh/Q=;
        b=Qj4pmTvZ/iXUkFuAVR+UFQadg4fe89HcUrPKhecr/gE6TA/YadsL8fWavrqA5tsxcQ
         /HJKM4n+XAtxYF0Dz0VGQBnUL9ElWPX60almdH54xuPpaYlrKbvuJH+mtV+PdXbfByBg
         EpFzwLk7s2kSpHZVcxk3gAAhmT1oLwQHep4dNlmwkyqqcYqEF4zfDZkyJGYAg+t2HVh1
         dvhdx4K+x4ASc2wKcRFRLsWKYaD0ckQTPtiur+o0PeDXNyDjCijuJnW5/LnuJRGwRDEE
         0icSKGjiPQi/5MroqvaX+QKPGdhDTNaBIADSaU2CxLl2imQLzo0lZ0RqYENUBVYgja7J
         9Aqg==
X-Forwarded-Encrypted: i=1; AJvYcCVNy2unLUashS4d58UoVCliw2iPm6nghcEwp7SDyC//o+oeZww3SwUd7lxCpLW2WOFh2GXOloESs8xbvwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseK5aM1M4BtQ9I3i5TmDN+ObfWINhMmgL5FLpsphuYZvt636Y
	J1p/NI41KN/ElVgx+32fclb2uI5XHFk4/rwrSn9ZWNORo+VyW7PUJdw8kIk1wlM=
X-Google-Smtp-Source: AGHT+IHVRBvw4u/Hgc+95QlfN8nSdnQa/vKgvNfz2NepqXg9A9A3Xuj0DuZM4kdWAhwKx81HVNgdGA==
X-Received: by 2002:a17:907:97c4:b0:a93:d6dc:d047 with SMTP id a640c23a62f3a-a98f836ee86mr222771766b.49.1727855113507;
        Wed, 02 Oct 2024 00:45:13 -0700 (PDT)
Received: from [10.11.12.174] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c59bdsm815585666b.50.2024.10.02.00.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:45:13 -0700 (PDT)
Message-ID: <5e7e0aa4-74b0-4262-8e8b-de86be54f0bc@linaro.org>
Date: Wed, 2 Oct 2024 10:45:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/6] mtd: spi-nor: add support for Macronix Octal
 flash
To: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org
Cc: chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-7-alvinzhou.tw@gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20240926141956.2386374-7-alvinzhou.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.09.2024 17:19, AlvinZhou wrote:
> From: AlvinZhou <alvinzhou@mxic.com.tw>
> 
> Adding manufacturer ID 0xC2 at the end of ID table
> to allow manufacturer fixup to be applied for any
> Macronix flashes instead of needing to list each
> flash ID in the ID table.
> 
> Such as macronix_nor_set_octal_dtr function in the
> manufacturer fixup can be applied to any Macronix
> Octal Flashes without the need to add the specific
> ID in the ID table.
> 
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index f039819a5252..1a8ccebdfe0e 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[] = {
>  		.name = "mx25l3255e",
>  		.size = SZ_4M,
>  		.no_sfdp_flags = SECT_4K,
> -	}
> +	},
> +	/* Need the manufacturer fixups, Keep this last */

you have a capital letter in the middle of the sentence.

I'll replace the comment with:

/*

 * This spares us of adding new flash entries for flashes that can be
 * initialized solely based on the SFDP data, but still need the
 * manufacturer hooks to set parameters that can't be discovered at SFDP
 * parsing time.
 */

Which brings me to why you really set this. I remember SFDP contains
tables with sequence of commands for enabling/disabling Octal DTR mode.
Would you please remember me, why you didn't use those SFDP tables and
implemented your own enable/disable methods?

> +	{ .id = SNOR_ID(0xc2) }
>  };
>  
>  static int macronix_nor_octal_dtr_en(struct spi_nor *nor)

