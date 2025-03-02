Return-Path: <linux-kernel+bounces-540635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A3A4B31D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EC4188F59B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C61E9905;
	Sun,  2 Mar 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELvag68Q"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7E6101C8;
	Sun,  2 Mar 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932717; cv=none; b=Luc0pGfNW1/xJxZ3aDPGHtUGE6DONOSLynjL4tp5gvcI/y6QHArUvvyehyR4Z963czOVfU+/pjub/kg+1HILDYOT9GaccBTaYlILHM8mcQsCuizn12OKoyZOsLmKk37N0uYDcgVEiDdJD6sntxTQmumX6U6IjSvfOPjW4GASoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932717; c=relaxed/simple;
	bh=IueETMcBZ9ZV0L8qSENZ6FOOcKTKO5+OyA9fjyfYfXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4Md1LrNrQxvUtkWnuLC/6Qp6i2hmJDX2mTMatatQzbvjugP/NXHGCUKVJ4pUU/WOL86wr576bWeTFBLqHVut27g1T7tRgGMxl5E2gtrPm20LPx5RjyX5H8BBjimWvFb+8x5wn5oE6VXicCKD0ITppWPOGtEWdgpsWG06+SF4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELvag68Q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2235c5818a3so27164625ad.1;
        Sun, 02 Mar 2025 08:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740932714; x=1741537514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KR5+7ZfSihMRvEHUcRTJ2IqjNlHyIOJzJIu0Ec0jYh4=;
        b=ELvag68QXaztwCh6oT1fV5dNQ4dANJTSR92GAwsablQq3nGpJKoSLnHUIEvE2lwVIQ
         hVzdiyE6pdMqequPm/hPiYTC0N5U76R/Bx9E5dHHg9Q7kWrw8uZ+3QmSC8HeGR4P+9Zp
         ZaaW1r+s6xbRTXtS2+eAWILWUFqZtTvmDC4wborbBmSuSspspnomUBv9R58wbASnB7pB
         js9TYUU5WDmRn3I9AMmV0NPvePmUhypChUYtIcLgLpN4qEddws0NFsYYIAgIG9AxmQdK
         QvSUhrvqF2Ga4fYXDgOUJMy5OKT7E8l65Wbswc8H2ON7/G2H4EFe+qPKqpoq2Hzzxd9j
         b9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932714; x=1741537514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR5+7ZfSihMRvEHUcRTJ2IqjNlHyIOJzJIu0Ec0jYh4=;
        b=q09TB/vNjKrumR63+LEDeObqiRNWJ44x5swBxgNGLZhh03M1aUHFDJ/gUqU3x+3Sr2
         lIuIYm3wMj1sJWKKkcO4hD8yAnWHsFHVpahS8ZxtV7fk0MTqfBuToKwdJlKSOKKXqvPC
         3/PoraojBgp6aS2RssiSsNixYo04oDW9OVK6wr8IDmXZxrq4zE8JhCnLCsYhlHBxXPFC
         7N29WL2GLHd5v75J69nGrYwL1uLusemxw9rL9JlHnnHn0o/q6O7CzSS5P/cycFrzefhM
         W+fwAzC3SGlcgAFAJLufIsujc6lcdXxb3sRkkn8+V3MX5awLzDCLL1CRTFAZv1w/s3QZ
         s4og==
X-Forwarded-Encrypted: i=1; AJvYcCWlEDXSJcF8RDhDWTmnIgl+0y+1W1sHHbs98Y/GFZmCewe57L0LeTmKTc8hp56MzhBqJ3nPnEmBHNZc00E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4i36r6saz/LAoEJPkZApCNvmjhZhJqNjV6axC7FhBisVho7A
	g0fVPdKe6okdcwZ77/7xmArnkT7v4ZoDVCVuf+kdTc8jA/CgK/8K
X-Gm-Gg: ASbGnctlY2md2Ai9/+t6+plD+B5Lk8QSRoV9KpOlasX2mOdO4zXGiigjkkGLvHoE0BM
	m+jlM1w17tH2I6r12qF40B6g7giBVN6wYHHjQ31XFpOBPQC30tGYwLURjhASXNRFd5g2bC9CpOx
	p1M998Op+8Cen8QM/M/My+1TZCv/kU2OJjxwUAiCgJBUtpjsUPwbDGKJvIjISt696oc/dV5puWj
	Osab9U2lbKD6gNTMKGUvhFf9mNnXNiZKOOGZF1J2gxjo+K3jV3bzs1rH5WEQt1W+iaV5+wlK1bn
	1+RRCdR7d/2cKaiyBCA3THafiwFI9OzfmgQJ3ZbKsNxs24HgeDCL1DECPgyNfL+vuI+ojLmrW31
	yijglCbjulKUJ5BK5cw==
X-Google-Smtp-Source: AGHT+IEPIwxkmI0LxsTYCVfAD6i8Q66/kRocIx0iC/MAvDl4KouOlRWJg5n1vXJ1NwFZRcsW1pxyHw==
X-Received: by 2002:a17:903:fa4:b0:223:5c33:56a8 with SMTP id d9443c01a7336-223692585d2mr165857505ad.35.1740932714147;
        Sun, 02 Mar 2025 08:25:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050f3c6sm62628135ad.210.2025.03.02.08.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 08:25:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fadb9614-306a-4fcd-9829-bf3e50490707@roeck-us.net>
Date: Sun, 2 Mar 2025 08:25:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: fix a NULL vs IS_ERR() check in
 xgene_hwmon_probe()
To: xinghuo.chen@foxmail.com, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 jingfelix@hust.edu.cn
References: <tencent_370DBB5BD8EF699EC030ACA74BCB440FFA0A@qq.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <tencent_370DBB5BD8EF699EC030ACA74BCB440FFA0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/25 19:43, xinghuo.chen@foxmail.com wrote:
> From: Xinghuo Chen <xinghuo.chen@foxmail.com>
> 
> The devm_memremap() function returns error pointers on error,
> it doesn't return NULL.
> 
> Signed-off-by: Xinghuo Chen <xinghuo.chen@foxmail.com>

Fixes: c7cefce03e69 ("hwmon: (xgene) access mailbox as RAM")

> ---
>   drivers/hwmon/xgene-hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index 1e3bd129a922..4fe30198bae8 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -706,7 +706,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>   			goto out;
>   		}
>   
> -		if (!ctx->pcc_comm_addr) {
> +		if (IS_ERR(ctx->pcc_comm_addr)) {
>   			dev_err(&pdev->dev,
>   				"Failed to ioremap PCC comm region\n");
>   			rc = -ENOMEM;

While it is correct that devm_memremap() returns an ERR_PTR() on error,
devm_ioremap() returns NULL. So this has to be IS_ERR_OR_NULL().

Guenter


