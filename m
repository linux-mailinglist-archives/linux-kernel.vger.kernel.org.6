Return-Path: <linux-kernel+bounces-194098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA598D3691
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30081283FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09B17DE23;
	Wed, 29 May 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvt6kOIi"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6617543
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986358; cv=none; b=LAETFubvt8J4U+p6UZQI1/WH2I5rxmNk4G4Ly+CU4BjUUhglKwHP09I8aEEOYegg2MxMuwyrPkcRXz0r2YsS1CjDn3WZ1Mq54gWKV/jD8Pw7HHI0b4LX+vN7mXwbjeubMpGKR9yymWf66dZcvXX5q4KHgFk8+Fc2AgGBqc0FAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986358; c=relaxed/simple;
	bh=2a+GiEbma0olqhgzz5KinmTnM/ZDeA6fYFyfWEytdww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWBOfpim9w5ANwN4HguxrOy/FgivNOQ+L3LO8H1a4fzaX1T/wo1JZd/VwpA862HkMVHG+ujwRIEfK9J9ZShtB5Vivz/mFj+x506E1/MGHN9zdnxaiM4njVKvRvvaQrTdcrfZ0aS6do7nIap6kPTjhgKha/BJ8Y6Beo89jOdf41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvt6kOIi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295e488248so2434925e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716986355; x=1717591155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w8Kj5fSKUKPQjClpTcmHwKwdnuWgI6rSBHg87abE6XU=;
        b=tvt6kOIibXcMWpw0erHysOOLeTRfLd3PC93YP1PP9Y6SQW60hFrsDxaLwTkHxGWhEt
         VfG4FFDLhSqAaMk+dactb5CLdAnbNgHR/jvBM3UQveR+YCHB748HuPik/c4jdMF1LjPP
         qsK4JPX4/V7+G6MHgRmnnKH+RAkjsaY5yTu3ybm0cpG739OWHNglwmFYT+sgQpn3WVjj
         bMa6coZWhIoEPZaMUE2VnsmqDEJpNSbTVKCkwmwMFBZGPGMY/XXK7scCAYxdi7C5+oyH
         z80XltQofKFQneu7FFeiUTze/jWWWs6fGMeabRZWgogqhMugf12LWhqQ4lPl6m275YD8
         cKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716986355; x=1717591155;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8Kj5fSKUKPQjClpTcmHwKwdnuWgI6rSBHg87abE6XU=;
        b=qVfx69j9tjuBSyiVZCPG1/X1MngAA+KFeGN6XXOfICl21W/3XDQy2+Ca/BAmhUdg/k
         H4e5sTCU388OedEjZJ0J8rByhsIZXFgdWB71VrGjQCdDIyEugx8N1SRJ//BBjCnDb4iZ
         pC78RvKOWDqDQSlIqM7b4Z+ZWTdJgRwoun4MITnLiIWDjYor/SJY8mVGz3LnOdHsJ5Q9
         HhZhMMnbTK6N7JYT3VupaxbR8XtdWZjlFr+S7+XE7YIeP5PIwQwVMU+OP+NLYiSrxBIV
         ohFSd47D++fEX/i84Nyxb4QTxSP8sYDZKqkoZEZVSGnOxC/E9x4xpwvxdpOpleGODShx
         1oOw==
X-Forwarded-Encrypted: i=1; AJvYcCW0nBGKR/y7at0Q6kYnLVoaKX1u2llnqd/IrAsNGoxdlA9WfG/iVntHehBPyTbdnqfm531IGa+Dkqh/yKeRWFtqfSoh2y7jWmfOrFAW
X-Gm-Message-State: AOJu0YxafjoEMSYi3kAPMs76U5SNDLR49YZTJumwr2cp957xBmthmsWn
	e8CfNok0cyz1N4+K9EtNAx8vAfGf26jCV2gczSeBh3rwlHHR8ZyTEO2D1A2UrqI=
X-Google-Smtp-Source: AGHT+IHZEw+8dTxr4Me8+OHgI1CFI+Pk0vxAXieGN74kO0I31mee8hbkWPdpvaFXgBreP9XFaqyA9g==
X-Received: by 2002:a19:a401:0:b0:523:b7ec:a222 with SMTP id 2adb3069b0e04-529667cfceemr8705067e87.51.1716986355414;
        Wed, 29 May 2024 05:39:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e2b2sm721857166b.171.2024.05.29.05.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 05:39:14 -0700 (PDT)
Message-ID: <a4b49a5b-7ed3-464b-b4de-76a38909cd7c@linaro.org>
Date: Wed, 29 May 2024 14:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] ARM64: mt8195: Use thermal aggregation for big and
 little cpu
To: Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240524143150.610949-1-abailon@baylibre.com>
 <20240524143150.610949-7-abailon@baylibre.com>
 <1b691b03-1d2c-48ee-9907-dc043ea1ed5d@linaro.org>
 <6d01d555-9af8-4ec8-8630-0d9a7b48f423@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6d01d555-9af8-4ec8-8630-0d9a7b48f423@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2024 10:19, Alexandre Bailon wrote:
> 
> 
> On 5/27/24 08:56, Krzysztof Kozlowski wrote:
>> On 24/05/2024 16:31, Alexandre Bailon wrote:
>>> This uses the thermal aggregation for the mt8195 to get the maximal
>>> temperature of big and little cpu clusters.
>>>
>>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 212 +++--------------------
>>>   1 file changed, 27 insertions(+), 185 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> index 5d8b68f86ce4..8aa2bf142622 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> @@ -3600,50 +3600,31 @@ dp_tx: dp-tx@1c600000 {
>>>   	};
>>>   
>>>   	thermal_zones: thermal-zones {
>>> -		cpu0-thermal {
>>> +		cpu-little {
>>
>> How is it related to the commit?
> To aggregate all thermal sensors which are in same performance domain, 
> we removes each individual nodes to create only two: cpu-little and cpu-big.

OK...

> We need to remove the other nodes because their trips points and cooling 
> devices would conflict with those we define for the multi sensor thermal 
> zone.
> 
> Best Regards,
> Alexandre
>>
>> Does not look tested. You just introduced warnings.

Yet still I claim it wasn't tested. See SoC maintainer profile documents
and/or writing-schema.

Best regards,
Krzysztof


