Return-Path: <linux-kernel+bounces-514509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30BA357E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823571891A50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5C20C000;
	Fri, 14 Feb 2025 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7zuQgxf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D62080C8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518059; cv=none; b=Mm6p0VE+5CzeHHNOcb8uWhr47Ro8vPsKtJNE2YRoydzTgC5MaYpaH5BllCymq94S/l3wE92b2DtrekagxWFMqxW2f2+FohGcm3VTYBKKam9qMevY06K93S591AphdOABtKo66ulG13fRxmDO1pw1r9BjhNfjnZohlx7I9hx7glA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518059; c=relaxed/simple;
	bh=a7kJ8j1jEvuz2YzSHbabkizHAC80oIWnpGDwLIh+8kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvUMBJoAYwE78sERBr/djploysqCGlagYCheeE9HCg88+/2KE2m5q8A+691PmvQ9AYEzenNWBYM5hmw/CXe8pysEGxKdXlOFxFbONL/OYb9HHbdr7oUi1PI0w0DkAeZj60oJjldEXUuNHBHIgRtG+azCu+mOPH4WkAJ75zKlMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7zuQgxf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43937d315abso2619485e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739518056; x=1740122856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1im5jr/ddqcNKC9+Jp3mOIVJm986PTE6Kc8N1Bsp3/Q=;
        b=u7zuQgxfqRTKn8pXfaO6wVn+9nH+tFwSqM4cnLEFl9dHwfiCxPzpRoI4DWipaelgoz
         Gxd02hiYFtJ44THXn9ASTPJHiPDNDkjX1CHUuhAmFK62A2M04N/gEeIxyVLCPeKb/RL9
         doXrWTj4eJXwT95NHtrLg828q3U/irgQEeJeP6V6GhFaiYBPrDK7obx41V3H0OgvsrXO
         1ybKWM7Tjgmv1hPB4gZDaGgfsHoIEodmUmjeAaW9H2/jiUuwSr4bCC/O604ZXUj4/nrl
         rvfLaVcZ4hUIQeUYzYesMt1okGyABXGYLAWVzAwB8G7jo4/Z5sCIeEZYASU9Flvn+H6z
         DyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518056; x=1740122856;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1im5jr/ddqcNKC9+Jp3mOIVJm986PTE6Kc8N1Bsp3/Q=;
        b=BlLCbVuI28gc1NF0jb+/Ah6G3JAHjf2JYJ51lePG9aVEHmu1CCKYwSiladkUOBzT29
         c/WDDefzDH83pYd5VzxJx2dFAN9eAwn9+lgkW8mVB0gECNRyXrWaWxm9XvA+6CG0ENl+
         R0+08FIFDFYrhhmvBkFWgUaYJPbhffwYg+jUhYg2xn7YMiaBOXjZJ/L3m7FoKeNfCRHq
         t2qchUDJx0h8QBtSPIyo3Qa6zlg+GvigrOkTEvDi/ZddlpXnELwfUhQAK5z7Mds4qsw+
         GxCH0K2I7LfdBxXsa1D2dK3R0iqPJ/Lquv1s6DN4kvEtmG98A8Vqw33tlT+/yT9UL7TB
         etFA==
X-Forwarded-Encrypted: i=1; AJvYcCWkWWc6Bb2eeDG0QWylDu7Pk/gkZx4AzkPH8a0Wti5UNTpcf8ISn05ju6TDnV8cSRVdF6oYxZJWaV/KFlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXGqRf8PCV5nSZC7AD0YmT++3x9sGvHJXwam1i237TJWgBd3Z
	delAdNS0Tl+2q2h3qma+BcsBnOQMP4+DZzbldt0eU5i1jVKolnbD2s2RKOif3BE=
X-Gm-Gg: ASbGnctdvbvlx5Rr+ntRiNudiPvGhjPHxLtv6WxL9L0I3m1gcyAhQ8w40pGL68QeVhZ
	tOlYxMbsONABE61MqFkBP6LzmNTlXj0MEcvxAUPWaIi1zySsKFph1mp3p7Jg1wrltzISgZE/83Q
	y6F+oV22tdHUdspvw8/qHuMJGJH8fi31KA8ZbaaPUPValWkuHicATYgsU2+wWcSz3Y91TPADZsr
	SzGDhQU/i3WcMYmaPpblYUpJrr8BiVt7ttbcTuCpOr2aRpzTzdddhBq5s6L908GiVVtQ7NGyZYT
	UbtW741bhqF5loxhgxloFQ/jnTRKediYlt0=
X-Google-Smtp-Source: AGHT+IH7/enHB0b8VVnakGnUMLsCMc5nvCM/CivMMVM9hZIt2oCyvx+f5hyUkTWYb1OSJ6o/r0eM1w==
X-Received: by 2002:a5d:64ef:0:b0:38d:e472:e6a0 with SMTP id ffacd0b85a97d-38f2c7f7e07mr886032f8f.9.1739518056271;
        Thu, 13 Feb 2025 23:27:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm3764464f8f.89.2025.02.13.23.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:27:35 -0800 (PST)
Message-ID: <81b449b3-32fe-4f7c-bcb7-8c0f080ff667@linaro.org>
Date: Fri, 14 Feb 2025 08:27:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/3] iommu: omap: Simplify returning syscon PTR_ERR
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
 <20250212-syscon-phandle-args-iommu-v1-2-c3fab486b426@linaro.org>
 <dd1b7ca0-ef9f-4b9d-bca1-8a72c22231bb@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <dd1b7ca0-ef9f-4b9d-bca1-8a72c22231bb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 12:30, Robin Murphy wrote:
> On 2025-02-12 8:19 pm, Krzysztof Kozlowski wrote:
>> No need to store PTR_ERR into temporary, local 'ret' variable.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/iommu/omap-iommu.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>> index 04a7deaaba25cb270eb6eeaf6a21030440f78a5e..bce27805805010ae473aa8dbd9e0cb903dd79bba 100644
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -1123,7 +1123,6 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>>   					      struct omap_iommu *obj)
>>   {
>>   	struct device_node *np = pdev->dev.of_node;
>> -	int ret;
>>   
>>   	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
>>   		return 0;
>> @@ -1132,8 +1131,7 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>>   		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
>>   	if (IS_ERR(obj->syscfg)) {
>>   		/* can fail with -EPROBE_DEFER */
> 
> This comment is no longer correct or useful, since it's alluding to the 
> check which you removed in the previous patch. I'd just clean up the 


I wouldn't call it useful ever, but I assume someone wants to note for
themself how syscon lookup works...

> whole lot in patch #1 as it's all closely related, and also turn this 
> return into a dev_err_probe() to capture the spirit of the other errors 
> being replaced, perhaps something like "No valid ti,syscon-mmuconfig 
> available" - that way it adds some value for debugging probe deferral 
> issues more than broken DTs.

Ack


Best regards,
Krzysztof

