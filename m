Return-Path: <linux-kernel+bounces-267550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1539412B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FB61C210AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7219F499;
	Tue, 30 Jul 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yku7b5+v"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2F442C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344343; cv=none; b=sswydX5TWhA7WL5QiNUOD1JMG72AU50pOIPLI0HyA/H1I5TBV1bFRCDTw4Kj9fUUwWoLLPrrbDnBt983zLOZxUd+52FLQqXlkXlInTiKqsvVCVsLfjpVVACs4jJ0RyQMO25vtpEiDHmb28agjIEyS/hwH/5UgjCayFrwsAkwAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344343; c=relaxed/simple;
	bh=NJ5wWQX+MXzcjI3xAU8zMQzGIm1Nwk32FjZNMdSzKqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIcobgZmdJPOR2P+vXVpODgB9aw0PbpZmKfG8y7c4vGdLmeExyXZfaZiHEXS5wvnKhaZywGr7A/mkR6dd0B5gXZixVTM/SEssWl/qKQFeiB69A9pk5qsHUnKPl9WOE5p44FEwVP7evMewpwLoBBHIiQKT5229VUdHH2kkuaOGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yku7b5+v; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280bca3960so27156175e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722344339; x=1722949139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sV4jeBWTzwj/MSeNBURYBG9491IFNxtmxPBAzKA8sQA=;
        b=yku7b5+v+/m7EbIF6+0TPzqdYiU/fCf8PpVsbLh4i1nwsPwrCxGKUOEGWDplfUgCW/
         aSIfL62BYfQWLNOQW8oS6zcDyAqmpEwl2C8CaBtgeBfnPJfJAfLaWmmMEBvU9SMsOEtU
         EQsl5hYJd6GJx5vMQOdqdV6Cs1DNCNzAqSnIvayjAxp1w0Gz3bttqydDyyLkHukS2Wrn
         aQkxYjN9+ALqKHzMM+XV1KMQwK1YnFdPsg5cL9q9+/jmDPocMxiHUus5ZzDytyTpB1P7
         MiHLPjblm8LWT9JPibyKYQpj1d2ROSufTjkiKInLLGM8rGmisocmucsj5VdwpYeJgodJ
         dIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344339; x=1722949139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sV4jeBWTzwj/MSeNBURYBG9491IFNxtmxPBAzKA8sQA=;
        b=dH+kvQJ6QeL/F8B45TTee7o5GMGiWja026/sLu7ObJ999z0wcW0A6kp+UP977eCNdG
         4U7eRaXXEYILGjpZqVAuJGtuS2J429hRLn1UYLlVuyQvhIGpYX5KOl0w4+fV2J9oXHtZ
         wDyfZXjpSi6fAx3QFDj5hivIgd5Q4KrYXSgiiXcCie2DisrtDh2bYqehhZom9mzrIn+T
         rTzF0ZpHJiPfVJSIHW/R0n1evT7S/FfBek3rE2YK1QsCcjCL9m6jgfwsXbsD1AtoZTbi
         rOGaqxvhyneAX0ndK0BrkYKQBqO3iTiikMW9Ez9TCk/HeP6Mzn0S/71wI/i6gYQyzow4
         TtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdE4M7GWjoKRaSX3iJiRjC2vUvJy8UxKStjEVv4exwEwOFgAcY/LaYl6NdmMVNrvACt0w97/9zfyMIa7/kLmPexJPVInLjHYtGndgO
X-Gm-Message-State: AOJu0YwhnsJn8PI+iyQlRp3sPmznIhbh69LbhiX8nem34o38lhHCidOi
	WLg9KUi1wejyAPlpMz0OwjoAqC5Rc+pA2zzfsAzlaVxIM8dQPShMqmfgF+85FzA=
X-Google-Smtp-Source: AGHT+IEJ80Tw++90S7g7P+XpB8UJiHhB+NG+j2W+cdqE3/ULUdJYsOta4GEOWr+gvdHyJczeGBOJxg==
X-Received: by 2002:a5d:6351:0:b0:36b:33ec:ac40 with SMTP id ffacd0b85a97d-36b5ceef045mr6414694f8f.16.1722344339443;
        Tue, 30 Jul 2024 05:58:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36b36857e46sm14761036f8f.67.2024.07.30.05.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 05:58:59 -0700 (PDT)
Message-ID: <f9527614-01ba-4954-88de-8a17ae1a84ba@linaro.org>
Date: Tue, 30 Jul 2024 14:58:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] thermal: Add support of multiple sensors
To: Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613132410.161663-1-abailon@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240613132410.161663-1-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Alexandre,

thanks for your series and my apologizes for taking a so long time to 
review.

I went through the series and at the first glance I'm not sure we want 
to add all the multi specific code in a separate file.

IMO, there is a preparatory work by changing the functions:

thermal_zone_device_register_with_trips() and 
thermal_zone_device_register_tripless()

where we group and move the functions parameters to the 
thermal_zone_device_param.

Then we can add a num_ops field which is will default to zero.

With that we should have put a foundation for multiple ops, so multiple 
sensors.

On 13/06/2024 15:24, Alexandre Bailon wrote:
> Following this comment [1], this updates thermal_of to support multiple
> sensors.
> 
> This series intends to add support of thermal aggregation.
> One use case for it is using the IPA in the case we have
> multiple sensors for one performance domain.
> 
> This has been tested on the mt8195 using s-tui.
> To test and validate, we heat up the CPU and the heat sink.
> At some point, we run benchmark tests with different configurations:
> - Mediatek kernel (IPA + their own thermal aggregation)
> - Mainline kernel
> - Mainline kernel with IPA and aggregation enabled
> With the IPA and the aggregation enabled, we get the best performances
> with the most stable CPU temperature.
> 
> The aggregation is configured and enabled using device tree.
> One thermal zone has to be created with a list of sensors.
> It will take care of registering a thermal zone for each sensors.
> The cooling device will only be registered with the aggregating thermal
> zone.
> 
> There are still something important missing: a way to check that all
> aggregated sensors are part of the same performance domain.
> So far, I don't see how this should be done. Some recommendations would be
> appreciated.
> 
> Changes in v2:
> - Rebased on 6.7
> - Separated generic multi sensor and dt specific code
> - Simplified the code
> - Drop min / max and only do weighted average (seems more adequate for IPA)
> 
> Changes in v3:
> - Rebased on 6.9
> - Reworked the way to register a multi sensor thermal zone
>    - Only one thermal zone to define in device tree
> - Max has been re-added
> - Enabled it on mt8195
> 
> Changes in v4:
> - Rebased on lastest master (fixed the build issue)
> - Dropped the average since I don't have any usecase for it
> 
> [1]: https://patchwork.kernel.org/comment/24723927/
> 
> Alexandre Bailon (4):
>    dt-bindings: thermal: Restore the thermal-sensors property
>    thermal: Add support of multi sensors to thermal_core
>    thermal: Add support of multi sensors to thermal_of
>    ARM64: mt8195: Use thermal aggregation for big and little cpu
> 
>   .../bindings/thermal/thermal-zones.yaml       |   5 +-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 212 ++-----------
>   drivers/thermal/Makefile                      |   1 +
>   drivers/thermal/thermal_core.h                |  15 +
>   drivers/thermal/thermal_multi.c               | 288 ++++++++++++++++++
>   drivers/thermal/thermal_of.c                  | 250 ++++++++++++++-
>   include/uapi/linux/thermal.h                  |   5 +
>   7 files changed, 579 insertions(+), 197 deletions(-)
>   create mode 100644 drivers/thermal/thermal_multi.c
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


