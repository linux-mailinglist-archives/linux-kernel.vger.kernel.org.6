Return-Path: <linux-kernel+bounces-425567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC69DE6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53152820D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A00719F105;
	Fri, 29 Nov 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIe3Ng8Z"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6319E833
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885119; cv=none; b=ozsUa2XLSBXqi3CYhH3r5CIdpmE1UC+Qp1+UdKCaHpSiuBCpl/VHhLfjnvnnYd4+tWaZ44RIb11IwyeAWGaI9u4ELsYPEWmVf5bRU07mqTF4UWldtpsOCxX0Q8uSL/46zm2q4vos4jLBUIigT1YgVa5irCWA5vUNlbtvRfm+Z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885119; c=relaxed/simple;
	bh=wj06W1b4xxDx0jKVLXr6WdYHgEJjM3/1JW0EOYtxvrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxPGLSQQEMDmhy5gzmi5TQKMCnaIxvShRrIwAEqfsbL69Lg+4vlY/AzgyuRw8ztlw0ZkE2NuMVAD2nav9pBZQZG0wpz7UDYVQ08/GCGPbvxH9W3SrKmHTjEnEO4qqNx9G8yrFe93EIDNk81/upRiX0YMOKcghpIqvUo2NorHACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vIe3Ng8Z; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso243502866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732885116; x=1733489916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gTU5eaxq+t1bh+hhq2w9VM3ZRpCzbMVz7+CTMi+lv8=;
        b=vIe3Ng8Zt/C4pDEJ+5xwboD5yi6UBVNHRmkbIMZmzOhRhn4zF8feGe7NrP1Toua0yI
         N8shr0RZbRQrFTdFXwfLfJRbnlrAsuWr/9lRA2r/uLTSQwDENJzHnyzzQMmGOrIibK8y
         Wm3IZxsIf0ncW4UDfihuk0AHdEdMWosXdeBde+geKM3SzTMufqEk/Yh190hDAexwHXHd
         pq391M3v8vpKs+RH4DV1rRqYMqzfqNcunsYy0SdVuyeCpS4bgqUBbvlAj2WoDSGKCbju
         EaRuDjtSDieTcOxphSPmBpzDivbvccbHsXkT/LWJRQZ8fS9N6empZsPRKuKDgI7LvA3p
         iMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885116; x=1733489916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gTU5eaxq+t1bh+hhq2w9VM3ZRpCzbMVz7+CTMi+lv8=;
        b=eWl0pRGsb6gZf/Wlh5JoSvPk9EiBlad54P1pHkbKT2sCT2IlRt6PxaVc4jCig7uaPV
         oBP0L3oX8byB4TIaB5u0oEhjV8jXNbX3Ezjyfjz1c5eZBgG8OHeMe2X0bU4n+RElOn/Z
         AjOmBMK2mrVeTdi9ekp5EMvVLWC5r1Z/uqFIRnWuRs7uc2I5CD4R0kYAGiSlmkYSrL0m
         fteI6Tdcw3WVAtJ7zIBvvGZF+vH/Xt3602E0y0EfxHP88r6017wbukMnwl6gwW5FeONo
         99fUzOHSVZwIfbFX5GGZzcGCYhvs8dbKXmBR1vJDR1frIUGM5JKRhpY//uPZPwiV+Pbn
         9gBA==
X-Forwarded-Encrypted: i=1; AJvYcCWS5p0hmOm4DyuV6efWM/2x4g+ivPJi+o3mifb2o/R4XlUskN/vg9dKQClW/8pp+8KVJnxu2Zf4fGBI1W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7pzEiAlQuSzCpStKFMgqS1zk2MPoit3b68+ZzE592PozcQs3
	/wUKVM27t3KuOs1CiZ7Cb78x7WlfneHcX5H9dttsdqpEycsuq12luW5Ihh8pNuo=
X-Gm-Gg: ASbGncvV3OU4asoFLqgjJD849LWD6Vvmvj1lUBKDmM50hp6FL5drRl0CDW7WPXEO1QZ
	kdIGIoQgPJQ1OZucWjwBqFt76OkEKl8u64Yhm3i3/DsJKE3Sk36drJZVfgYgj7rMhIApoGf1+P2
	eNS1zaJzLBPMWO2JlZE5+I///+ZjHBWHUhffCbUZLCYPwcmUDWdSjJAiOUR1NzyhTxoa5EqsZ7A
	6benT8EQwvNRIiqnmTSfZTDXsdwnqw/3TN9ceFfbQG14c/X1FwWJbd9sbkE0V3iXi6LuXiQPDgQ
	aGxvT1o8uwdk7CdYyuzT3pDe4dRo8Q==
X-Google-Smtp-Source: AGHT+IEj3xJBPhhONybzeuI+/sUVESff66GZgw3Cn0h8ebB5GrfzILpsAe23SpSHPYRXA1/mDRffwA==
X-Received: by 2002:a17:906:318d:b0:aa4:9ab1:1982 with SMTP id a640c23a62f3a-aa580ecfcf0mr901827566b.4.1732885116433;
        Fri, 29 Nov 2024 04:58:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:94bb:9634:af59:23cd? ([2a01:e0a:3cb:7bb0:94bb:9634:af59:23cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d5651sm172920766b.60.2024.11.29.04.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 04:58:36 -0800 (PST)
Message-ID: <41999ad0-30a3-4663-936d-9ce0a00992b8@linaro.org>
Date: Fri, 29 Nov 2024 13:58:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] optee: fix format string for printing optee build_id
To: Sahil Malhotra <sahil.malhotra@nxp.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Cc: Varun Sethi <V.Sethi@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/29/24 12:46, Sahil Malhotra wrote:
> There has been a recent change in OP-TEE to print 8 and 16 character
> commit id for 32bit and 64bit architecture respectively.
> In case if commit id is starting with 0 like 04d1c612ec7beaede073b8c
> it is printing revision as below removing leading 0
> "optee: revision 4.4 (4d1c612ec7beaed)"
> 
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> ---
>  drivers/tee/optee/smc_abi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index e9456e3e74cc..eb51dc18f32d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1272,8 +1272,9 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
>  		  &res.smccc);
>  
>  	if (res.result.build_id)
> -		pr_info("revision %lu.%lu (%08lx)", res.result.major,
> -			res.result.minor, res.result.build_id);
> +		pr_info("revision %lu.%lu (%0*lx)", res.result.major,
> +			res.result.minor, (int)sizeof(res.result.build_id) * 2,
> +			res.result.build_id);
>  	else
>  		pr_info("revision %lu.%lu", res.result.major, res.result.minor);
>  }

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

