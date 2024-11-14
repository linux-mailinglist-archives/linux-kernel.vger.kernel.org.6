Return-Path: <linux-kernel+bounces-408858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 727239C8461
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5FF1F220B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282931F583B;
	Thu, 14 Nov 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awWFSXKW"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168F1F5834
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570980; cv=none; b=M63p+5Pn7WWTS8f7FTozFNe3GUwgQBjAUHSHgfGZpxj+x8thIOWQIrPSkIV7tMF5ODMsoyO9XBYm86dCV6YiMAluYeYfpYtsjfF6VNQUjBsNIHP5ueQPp/hZGfJuXfqdC+IeVswMaJ6ZPtu1nuCMddX+8751Wp6igHJI8m3/900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570980; c=relaxed/simple;
	bh=jvr0K0Q5J+bY8+BvzB9nKZv2xyLFb1Xxc0qmLOtROqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcR8fu70R7B1ZPnwnyyl9BX+/+erWLQkrs2NEzj+cLW76xdeK9/RwzXLm51pP4jyPvQQi3E77px5WvlG1FLna8y0L1ZrR0wC6eFzCWB9WZWUGG82oE6yuK9g5h/rtR9yjbEkaM9jYI3MYzcB4nQTusIBzqAE9tOUS1Q3N+SQQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awWFSXKW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314f38d274so4105615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731570977; x=1732175777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTbijnnwDwohrlI2GV45ipkfj8nk/AeJOyyuQggfBrc=;
        b=awWFSXKWwOCjNXAoJyLpRGu12EMIIQgjzVRgQ1LNLV8NkbfAItj5hJBvPPk+OFo5Or
         qDS7ueU5H674fceHlm+lWh59JaeJD9cfp9xySI+dRVcFWfme5Rc9G0X6u5k6X0umUmP8
         SBdy+Lj/ULGqwdAlwkyxetpLiRm4KvJA5x3ZKazZ7sybcEtbxmxQ71xHedxmd5ssnC3j
         fwNXpj5z+1e2ZfWLgI0kofQMiq4glVuVFQe87rxe71kGWtLg2leyzpj2PP0tZKcpx4BD
         M5Sp86udd2hJUGnceC/my1lUEPtxOJndmRHcLEeRvRAChSoKOWWISBbCn2wIxiNo2zfK
         0AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731570977; x=1732175777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTbijnnwDwohrlI2GV45ipkfj8nk/AeJOyyuQggfBrc=;
        b=Ap77Lrx9XJW7/pDbSfzURwoMaQg/C38gCH7rpUR6LCWsijfNphAmjkD6520d0BB2Hd
         2ENKc7/40xYmxcJQkA/FFoQvlTg4AI1KR13sLcpZhK+4m/3NQWfA6QbXy3aOfq0otpsW
         Il97HLXUZIujXj3KAtKdRvLxcWn6JHn6Z9xIpxgIhU3okkRI76gywEn6/5vbs6Yh23g8
         oY8wKPH0l4HOyBf4s1Nl9WxERf9SrT1my1jpu/qgenl/XPdC6AGHeNwPyAum53vIJCpR
         wJ8rozgSgdkBXHowsxo3mjgg8L2AAQaytDQUZ3Ur9TgIj39EQ1rOoaEkZSPWvs8/rohi
         IfWw==
X-Forwarded-Encrypted: i=1; AJvYcCX5YdoGB5Jzfo40z9SLJrtyHdcAUvkfeM+oXbfHtDKi9HwAvWkaOWKdNilBDK47uOOw/EG7m0Jf/GdlPbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8D0M7hnKXcm6GuXgsK14wqnD+GzgYzOVQxuAYvLiqQpVw0eTj
	6RtKkX434dLLkBz72XwKRRlNW7NCfw/q/J6wxkbdGAfKOOWhkPrYRmv9zICt5+c=
X-Google-Smtp-Source: AGHT+IE5fUPLpY4+0oTnUCSYF14S/jOKysuYqJHjX8GawIArDKoykg98bQ0RPo43UOx1Vkuznv8HJw==
X-Received: by 2002:a05:600c:19c7:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-432da7dc2ccmr9473255e9.28.1731570977052;
        Wed, 13 Nov 2024 23:56:17 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432dab80869sm10906885e9.22.2024.11.13.23.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 23:56:16 -0800 (PST)
Message-ID: <80444a81-381b-4a30-b573-dcaf0c06f326@linaro.org>
Date: Thu, 14 Nov 2024 08:56:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: Add support for Airoha
 EN7581 thermal sensor
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 upstream@airoha.com
References: <20241018104839.13296-1-ansuelsmth@gmail.com>
 <6734cc42.df0a0220.4521f.ac78@mx.google.com>
 <487d0de5-6f70-4b82-a22b-5e74ba32da11@linaro.org>
 <673509d0.050a0220.f4111.c090@mx.google.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <673509d0.050a0220.f4111.c090@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 21:19, Christian Marangi wrote:
> On Wed, Nov 13, 2024 at 07:18:04PM +0100, Daniel Lezcano wrote:
>>
>> Hi Ansuel,
>>
>> On 13/11/2024 16:56, Christian Marangi wrote:
>>> On Fri, Oct 18, 2024 at 12:48:04PM +0200, Christian Marangi wrote:
>>>> Add support for Airoha EN7581 thermal sensor and monitor. This is a
>>>> simple sensor for the CPU or SoC Package that provide thermal sensor and
>>>> trip point for hot low and critical condition to fire interrupt and
>>>> react on the abnormal state.
>>>>
>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>
>>> Any news with this series? Everything wrong with the thermal core small
>>> patch?
>>
>> I understand why you are trying to achieve this but usually it is the kernel
>> which overloads the firmware description, not the opposite, no?
>>
>> Either way, we ignore the offset/slope from tzp and use a couple of private
>> variables offset/slope in the driver (iow do not call
>> thermal_zone_get_offset() thermal_zone_get_slope()). Or add the
>> thermal_zone_set_offset() and thermal_zone_set_slope() helpers.
>>
>> I would prefer the first solution as for today I can not see any DT for
>> ARM64 with the coefficients set. So may be we can consider the slope and the
>> offset as a legacy which should be removed from sysfs and the thermal zone
>> device parameters in a near future.
>>
> 
> Hi Daniel,
> 
> Having set OPs is problematic as that would diverge from what is set in
> DT that should always have priority.
> 
> Well yes my idea was trying to make use of them as currently there are
> many driver that set these values but have the slope and offset in
> thermal core always set to 0 and 1.
> 
> Thing is that reading temp with ADC is very common and in some way or
> another you always have a slope and an offset so it makese sense to
> permit to have those values preallocated instead of handling them in
> priv struct.

Right but if we look at the coefficients description, it is a bit fuzzy 
how they are used today.

> Anyway if the idea is to drop that, I will happly move those values
> handling back in the driver. Just need a confirm on that.

Yes, it is probably better to put them private to the driver while we 
sort out how to deal with the coefficients properly. Especially that we 
want to introduce thermal zones with multiple sensors support.

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

