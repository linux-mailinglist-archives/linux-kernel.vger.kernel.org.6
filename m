Return-Path: <linux-kernel+bounces-538149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3542A49507
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC6C189586D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A3E25B688;
	Fri, 28 Feb 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PPeerhcZ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F62580CC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734973; cv=none; b=oiwE+y6PgqhbkdGY837P4uNNmY4NmRw4H1J6tVftQELn0+QZP0OjaKXzp0nM3/tvj4gAPGpnJV29T69QTOgP270yH8joX3CKlfSUY79pc5mg7uXw/AiYGMCfZhmOoHjG3m+Mu/8Pg3x4vyX3rTXHevVTfqRLOiX8VNCYHbnJ7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734973; c=relaxed/simple;
	bh=HnV1jt5OPbzcl8Zf8JhAfO9ALAwWsVsONLj0GssGnJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRDe0PMH0Pig7Jkm1UOL0LJy9a+SXfkJ5PNX2VfW5Ft83nkQx8Iceb3UKqvtmao/cezITi6cDFsfZdYDchrKvrj10NXjZXYp6b3nPjCiDjbwHPeTxUVM72qamue4PNTb9uHcB2jwu0F9uJ+pE42WSlMsz61SRfZ6qjK+Vjw7jrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PPeerhcZ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec61d0f65so388848066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740734969; x=1741339769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xi+7sGpT69/lANgMUWz8/8EU1lRH971cs0FJlKGXLWE=;
        b=PPeerhcZ5Ws7L/h0E59oN4Zhyc4g6fQ3ZkQb1G39/9aO8HrdCAwF5FN1lBpPpwPZ+z
         3slC2nnPjmj7y+1dkGydaFpcTENWKDWJHk0wUI8nant7bQyOoDZqjXrVKmz31eNAD3c8
         JQmZLcqUonecZnEuyzfvJDcYtZwUbDlGxBr2EFJryCfdil3KB1a7wdbnxdETlGL+yP1F
         MdlAWmdnQv781o6zoiPUg/mXycV+2GRZmakTVIu3lj2BlBxe4FxMNhV6rx7epH1LENYZ
         l63Si8MG1ODdTwLYVE9ktDSj3oeNWX7cJPOgit9RB04ABOB3KDcR7hnQD9je9AcFtHbt
         dz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740734969; x=1741339769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi+7sGpT69/lANgMUWz8/8EU1lRH971cs0FJlKGXLWE=;
        b=obuAa+8NXA4P90esJXFWQ2GGO4Ln8o1ornMa9IKIeaFpf1M+ScdP4hKtKuJo51ZpFL
         1evjFGbq3zMIs+WJoQRbDkLakfJ1HnAa7wEmHmqQfvqeTb1cWDQTr3aBrldUTPpb5tzq
         RI+9TUMSDtpR2nw7gyvRagx3+OK7pvy86AQy9LEsUTfkbArHMsABie86ZnFEUBMuhaQ2
         XVOiiIhZ1trguI91+DY+FflyPLMf555A28UtphpYOqxrkumc0wXS9jSmMRw9I+ox/Amg
         hS4ENZm993papgftEynYbE88frDvSc0wsuSO0250sxFrdyBvu6r/VQR0dmWW6Ync0mKN
         J2TA==
X-Forwarded-Encrypted: i=1; AJvYcCVq3qDONwPwlreur3u6u2OFuh4xXbUJqcfionl61df6S4UELdRk+5rMI/hsqC33aiC6kikdApnhCs+/3nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtyGT4ou8WqgWy05LKAbm+U+Kv50Bg+PrTVUG7JXDRvx55yd+V
	/wMiaxxmB7uhFHomnlWca1BS3iWiEWH5aU0SwbSyd6okBP8r3gVxqklsOflap4M=
X-Gm-Gg: ASbGnctKDoj7QzFhUVKZ+j0Mkd5QtWz+1Y/Vq1bzKPcQXJoJxQgQMuuqSjqQEoDINzk
	65XrhpA8XE5uhvepIXuGhXNtzVhRmXwA91m7L0+JzJ0N046ckgbo24TQlC4oGklKuFHG1xTMch3
	Z3HEZgq+QaY+WNgXwKT6Fk+58NPZTlbpWTJaHfQg8wbhH0WQOwN/enChA9w2zbiouEKYW3SYLEP
	YahN9qDm+mh1Q4S3ZaldHJrXY1rsTmlfp3YIUcugL9/4ap4lgeNFc7SVUYsl9rcBs66pDlE7xzG
	1u2frL/3Cqj0ZYFmZwq71hYIVMoue4bzbPE=
X-Google-Smtp-Source: AGHT+IEfVyttsNVaqFTwGlRNWn1VvhncC0bqlOAdRmlzfyt8y60wXR2u9ff1D1N8THUpzyw8SfSlkA==
X-Received: by 2002:a17:906:c149:b0:abc:a40:4194 with SMTP id a640c23a62f3a-abf25da22ddmr260249766b.8.1740734968478;
        Fri, 28 Feb 2025 01:29:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7bb85asm258530166b.162.2025.02.28.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 01:29:27 -0800 (PST)
Message-ID: <109244f2-89af-4e08-9723-db6c6b0b26d1@tuxon.dev>
Date: Fri, 28 Feb 2025 11:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: soc: atmel: fix the args passed to AT91_SOC
 for sam9x7 SoC
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 varshini.rajendran@microchip.com, javier.carrasco.cruz@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Dharma Balasubiramani <dharma.b@microchip.com>
References: <20250220055302.284558-1-manikandan.m@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250220055302.284558-1-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Manikandan,

On 20.02.2025 07:53, Manikandan Muralidharan wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Fix the arguments passed to the AT91_SOC for sam9x7 SoC
> updating the SoC revision is skipped since the DBGU Chip ID Register
> in sam9x7 SoC does not store the current version of the device.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> [manikandan.m@microchip.com: update CIDR Macros, skip updating the SoC
> revision]
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
> changes in v2:
> - update the version_mask to 0 for sam9x7 SoC to skip upating the SoC revision
> - add AT91_CIDR_VALUE_MASK to mask bits 0 to 30 as per the datasheet
> - update the SAM9X7_CIDR_MATCH macro
> ---
>  drivers/soc/atmel/soc.c | 42 +++++++++++++++++++++++------------------
>  drivers/soc/atmel/soc.h |  4 ++--
>  2 files changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> index 298b542dd1c0..3e0b8ba4f8ba 100644
> --- a/drivers/soc/atmel/soc.c
> +++ b/drivers/soc/atmel/soc.c
> @@ -26,6 +26,7 @@
>  #define AT91_CIDR_VERSION_MASK_SAMA7G5	GENMASK(3, 0)
>  #define AT91_CIDR_EXT			BIT(31)
>  #define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)
> +#define AT91_CIDR_VALUE_MASK		GENMASK(30, 0)

I would keep it as AT91_CIDR_MASK_SAM9X7 to match with the already existing
AT91_CIDR_MASK_SAMA7G5

>  #define AT91_CIDR_MASK_SAMA7G5		GENMASK(27, 5)
>  
>  static const struct at91_soc socs[] __initconst = {
> @@ -102,26 +103,26 @@ static const struct at91_soc socs[] __initconst = {
>  		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
>  #endif
>  #ifdef CONFIG_SOC_SAM9X7
> -	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> -		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
> +		 0, SAM9X70_EXID_MATCH,
>  		 "sam9x70", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> -		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
> +		 0, SAM9X72_EXID_MATCH,
>  		 "sam9x72", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
> +		 0, SAM9X75_EXID_MATCH,
>  		 "sam9x75", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
> +		 0, SAM9X75_D1M_EXID_MATCH,
>  		 "sam9x75 16MB DDR2 SiP", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
> +		 0, SAM9X75_D5M_EXID_MATCH,
>  		 "sam9x75 64MB DDR2 SiP", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
> +		 0, SAM9X75_D1G_EXID_MATCH,
>  		 "sam9x75 125MB DDR3L SiP ", "sam9x7"),
> -	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
> -		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
> +	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
> +		 0, SAM9X75_D2G_EXID_MATCH,
>  		 "sam9x75 250MB DDR3L SiP", "sam9x7"),
>  #endif
>  #ifdef CONFIG_SOC_SAMA5
> @@ -370,8 +371,10 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
>  
>  	soc_dev_attr->family = soc->family;
>  	soc_dev_attr->soc_id = soc->name;
> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X",
> -					   AT91_CIDR_VERSION(cidr, soc->version_mask));
> +	if (soc->version_mask)
> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X",
> +						   AT91_CIDR_VERSION(cidr, soc->version_mask));
> +
>  	soc_dev = soc_device_register(soc_dev_attr);
>  	if (IS_ERR(soc_dev)) {
>  		kfree(soc_dev_attr->revision);
> @@ -382,8 +385,11 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
>  
>  	if (soc->family)
>  		pr_info("Detected SoC family: %s\n", soc->family);
> -	pr_info("Detected SoC: %s, revision %X\n", soc->name,
> -		AT91_CIDR_VERSION(cidr, soc->version_mask));
> +	if (soc->version_mask)
> +		pr_info("Detected SoC: %s, revision %X\n", soc->name,
> +			AT91_CIDR_VERSION(cidr, soc->version_mask));
> +	else
> +		pr_info("Detected SoC: %s\n", soc->name);

I'll update it as while applying as follows. Please check and let me know
if all good with you:

@@ -386,8 +389,10 @@ struct soc_device * __init at91_soc_init(const struct
at91_soc *socs)

        if (soc->family)
                pr_info("Detected SoC family: %s\n", soc->family);
-       pr_info("Detected SoC: %s, revision %X\n", soc->name,
-               AT91_CIDR_VERSION(cidr, soc->version_mask));
+       pr_info("Detected SoC: %s", soc->name);
+       if (soc->version_mask)
+               pr_info(", revision %X", AT91_CIDR_VERSION(cidr,
soc->version_mask));
+       pr_info("\n");


Thank you,
Claudiu

>  
>  	return soc_dev;
>  }
> diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
> index 2c78e54255f7..2503a80856bc 100644
> --- a/drivers/soc/atmel/soc.h
> +++ b/drivers/soc/atmel/soc.h
> @@ -44,7 +44,7 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
>  #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
>  #define SAM9X60_CIDR_MATCH		0x019b35a0
> -#define SAM9X7_CIDR_MATCH		0x09750020
> +#define SAM9X7_CIDR_MATCH		0x09750030
>  #define SAMA7G5_CIDR_MATCH		0x00162100
>  
>  #define AT91SAM9M11_EXID_MATCH		0x00000001
> @@ -69,11 +69,11 @@ at91_soc_init(const struct at91_soc *socs);
>  
>  #define SAM9X70_EXID_MATCH		0x00000005
>  #define SAM9X72_EXID_MATCH		0x00000004
> +#define SAM9X75_EXID_MATCH		0x00000000
>  #define SAM9X75_D1G_EXID_MATCH		0x00000018
>  #define SAM9X75_D2G_EXID_MATCH		0x00000020
>  #define SAM9X75_D1M_EXID_MATCH		0x00000003
>  #define SAM9X75_D5M_EXID_MATCH		0x00000010
> -#define SAM9X75_EXID_MATCH		0x00000000
>  
>  #define SAMA7G51_EXID_MATCH		0x3
>  #define SAMA7G52_EXID_MATCH		0x2


