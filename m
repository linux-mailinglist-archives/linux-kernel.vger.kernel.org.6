Return-Path: <linux-kernel+bounces-298505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93A95C82F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FAE1C2111D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140F7145A06;
	Fri, 23 Aug 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVojy20Q"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46132C85
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402204; cv=none; b=e/ghNszOPdnRhkvLPaKh5hZVYjntkuAlP5J6im6FS3F/WHo18/VB8B7sDdPRikV5m/rxTL81EHcSqOmigjnOHuDqVqmJAiSujmyeVXtqodveMSiZbOjPjP3lTzYnvNEYB6zccnYNxSBYqAL/JYzidR7HfHtD3RVwK1lHMpRo9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402204; c=relaxed/simple;
	bh=CQO6aXjYTgho99xY55I8pTEOCfz+/1IGlcZ3POMdPBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGEVnDmj1fXNm1lxtzson9EEaWw+adEESOPlCIntTMn6MU+UbvARn5Dyl7aN2lOnABFzDfLx7meS0q2xuRPJNc3GNxWacs3nNfZlpZImYJ1mg3sLrqYl7rofRHS2u138OZJAKqt4+j6p4i1SJf4JuzPw3oheQU56qr1oWazQBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVojy20Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so13120785e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724402199; x=1725006999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5F0w0rHOjjiCZiykd3yhyISp4GHhaztXbtuC1mBZoDs=;
        b=iVojy20QhEaRjRPHSYcGXMBzK/zTsIvyWiylBUyQIzFM07fK8o1D4VYLr9dibxG696
         aqVEuLYfnGUpibcUgbQiviUXAOLQUqqhEV5l8MuneBE/os8W+2gAM3UMHjZZmurw14mY
         Gyp153E5OPetIjtjJCRqyw1HCMtcAVT3A5B3WIJuYN5y22FqLae32g+CWlJHg9wyGA6g
         1zYpBp/lgU5UMvG6qi8627H2QBRYJZXHG8NopDHeSrywHyqQyfGNx/FDJGMqyhWU/P9b
         /AzDfCKfLs/L9qGuy1G7xflW8NJZG8hp+eLt/8bcjJfj942lnwII6mnhGA9Rc82euAlD
         T2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402199; x=1725006999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F0w0rHOjjiCZiykd3yhyISp4GHhaztXbtuC1mBZoDs=;
        b=evKoK6zMJN/U726P7MgMieCjnu2xWgDjCoilJb/Oe4R3gpk0w/LXfWUlvgyxzYxfbf
         jaE5qYgb7tRPwd7004LJSgBHZ69YgU/QNuRNFuHZNcvbxvdUqlf2FF0+gLhZg8VlY/LD
         +NOZE+NkqNHzc3QttmZgqKzw3psgq15p/a+PdGK8Ji3fDwDXG6amZnm4C7Q4itW4i5yJ
         d7xM1awoHsyokz6ocQGw20gleEaLJvDu/zhzjh0FZwMKEPTsEJUhBgEFfmZelSj9zUOZ
         //OfotHw0R8YIXzFkAjVcxKpMt4+DPf6Jwxmyr5wwCudM47kOiYNus5ZM5FCxcRGGpmH
         yImA==
X-Gm-Message-State: AOJu0YysN4KaR3d3NunR5UYzn6zjRCT8tZw1KpPqhOwLAtlD5pmZUDxw
	7RGZoMXq99/4aVitZKPNRZhe6sqWiqlO0Geq5285oM2SCfzqt9VeYLEaJfBJ7XU=
X-Google-Smtp-Source: AGHT+IFA8GFJN/inu8iTynQOajzCqNNDfchrNyRND/DMhG7RXZZKklf2s7maVtLWaQoZ/pxYPfTMDw==
X-Received: by 2002:adf:b304:0:b0:367:8f81:f9fc with SMTP id ffacd0b85a97d-373119195c8mr983429f8f.50.1724402198776;
        Fri, 23 Aug 2024 01:36:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-373081ffb7csm3592211f8f.82.2024.08.23.01.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:36:38 -0700 (PDT)
Message-ID: <6893580d-53b2-4738-b49b-748f9310cb74@linaro.org>
Date: Fri, 23 Aug 2024 10:36:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] thermal: core: Fix rounding of delay jiffies
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?Peter_K=C3=A4stle?=
 <peter@piie.net>
References: <3331194.44csPzL39Z@rjwysocki.net>
 <1994438.PYKUYFuaPT@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1994438.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 21:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Using round_jiffies() in thermal_set_delay_jiffies() is invalid because
> its argument should be time in the future in absolute jiffies and it
> computes the result with respect to the current jiffies value at the
> invocation time.  Fortunately, in the majority of cases it does not
> make any difference due to the time_is_after_jiffies() check in
> round_jiffies_common().
> 
> While using round_jiffies_relative() instead of round_jiffies() might
> reflect the intent a bit better, it still would not be defensible
> because that function should be called when the timer is about to be
> set and it is not suitable for pre-computation of delay values.
> 
> Accordingly, drop thermal_set_delay_jiffies() altogether, simply
> convert polling_delay and passive_delay to jiffies during thermal
> zone initialization and make thermal_zone_device_set_polling() call
> round_jiffies_relative() on the delay if it is greather than 1 second.

For the record:

In the history, the code was:

+       if (delay > 1000)
+               schedule_delayed_work(&(tz->poll_queue),
+ 
round_jiffies(msecs_to_jiffies(delay)));
+       else
+               schedule_delayed_work(&(tz->poll_queue),
+                                     msecs_to_jiffies(delay));


And the initial commit 21bc42ab852549f4a547d18d77e0e4d1b24ffd96:

"ACPI: thermal: use round_jiffies when thermal zone polling is enabled"

Good catch !

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> Fixes: 17d399cd9c89 ("thermal/core: Precompute the delays from msecs to jiffies")
> Fixes: e5f2cda61d06 ("thermal/core: Move thermal_set_delay_jiffies to static")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -323,11 +323,15 @@ static void thermal_zone_broken_disable(
>   static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>   					    unsigned long delay)
>   {
> -	if (delay)
> -		mod_delayed_work(system_freezable_power_efficient_wq,
> -				 &tz->poll_queue, delay);
> -	else
> +	if (!delay) {
>   		cancel_delayed_work(&tz->poll_queue);
> +		return;
> +	}
> +
> +	if (delay > HZ)
> +		delay = round_jiffies_relative(delay);
> +
> +	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
>   }
>   
>   static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
> @@ -1312,13 +1316,6 @@ void thermal_cooling_device_unregister(s
>   }
>   EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>   
> -static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
> -{
> -	*delay_jiffies = msecs_to_jiffies(delay_ms);
> -	if (delay_ms > 1000)
> -		*delay_jiffies = round_jiffies(*delay_jiffies);
> -}
> -
>   int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	const struct thermal_trip_desc *td;
> @@ -1465,8 +1462,8 @@ thermal_zone_device_register_with_trips(
>   		td->threshold = INT_MAX;
>   	}
>   
> -	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
> -	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> +	tz->polling_delay_jiffies = msecs_to_jiffies(polling_delay);
> +	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
>   	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
>   
>   	/* sys I/F */
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

