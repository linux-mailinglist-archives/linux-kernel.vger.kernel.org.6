Return-Path: <linux-kernel+bounces-241049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE492764D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3527B284BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B031AE0BC;
	Thu,  4 Jul 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3dM8Qt7"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362326289
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097382; cv=none; b=q1tYPbh2GIVmYT2y88Tr82gjtNAxb2OBeIY8uFqpJ7xGBLOaLNo/k1zVf2O6XCZ400lYZtnyG+5o59f6WWIZo0WLki95IytDpzZKE5tdBFiB6fvhBE2OzQBsTh+aZj+0DnMKoCXU9St/hoL0r818VDrq64dcq+0l9VP7L4rI/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097382; c=relaxed/simple;
	bh=exJox3KQ3MMkdvd6XQeDEvXG1KuYn0SK4E07dtYhXxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+/ewieM/m5UN58H6WN/RRsmGWFN2x1SQ8Vyo4je6fDmyjqGt2NjYSq0xIC8UkuEMojReefwEOP9SfN/RhBuILiwzxmMf9b2LuaMPoGoaCqVu0Nb7pFWuPcRdNWPxejrgLZmSpNa86MfTg599UNrOxAekU4pv189Ti8cwf1xl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3dM8Qt7; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee88c4443eso6618551fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720097378; x=1720702178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jhrGdgbtl/EAxHEWycyaBWRSWOYn+emA6jFnHuWHk0=;
        b=L3dM8Qt7k/POPsrN/bo5n9xTeKlXQhyH71gYWasdfd/nj6EKeRe/2CElifRn95Xrc1
         RK3IHejAvn+qU8lRgqLF3Fmk8xfXw9Rnf6fHtsvzIgv+0DgTQjilPnaa2aQK0oB4gDiM
         mj6cP5DAxjlzIZYIQcY/w4OYipUKhkdiwfW/1l3P+pY74k1f3SLwP4dlVExzlCvhuzwV
         9bAQzaEZ3reQ6828peeBo4FOPD7WsK+wonJ6qEnxAfGp62aezqxlLCEB9v2kZbo06HM/
         peknnmbfmes9iN117yTBAnsK2uhUOcdN3/TUTiyGiV/CKCCAa8ghVemCum5Z6odZOx/+
         I5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097378; x=1720702178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jhrGdgbtl/EAxHEWycyaBWRSWOYn+emA6jFnHuWHk0=;
        b=qHeT4hDw2MbfcwZsXmKSdjnWoO/mrDWoYkmYy5GOKIgduO8r58jY+PrmG2CZxYi7u0
         YiKNIFsM+XYppsmeBzeKtbrqlnysS5HM/aOSKFIQcA6sWA+Q54YlxxLYWcCdFgc3FAjO
         hbwFNvHZIc070skX8bsFDSKaPVLWZeMTkMdW32NW6SYRWEhMezmEFDjBapoZTYRjk7BG
         cXSgN7ecl8zsip1tJ+ZIZKOZHtOoGN06f25HMH6vKErStQ7UQrgigdbRENJapMzEX4Ie
         dUCF1d1QRl4ilZHqXLE69/VnZkd4ICWjJ1LHDvO0/cZhb8szs0Ww9B9fAizXM5YC4Blo
         ZKmg==
X-Gm-Message-State: AOJu0YzFiUeKquFSF1I7TfLJGyEYs/l6Gsm/GsExj223xB1WgNTctb7e
	DIpV1fVGltghBNX812CghS+Jrlsexz+3eDdF/Aja16rdxYbdysSwAT8gPnOZ74Y=
X-Google-Smtp-Source: AGHT+IHIMFOB9feXOQjGGITO/U4j4h3jWvZfWaPNcSBazi8f377ZQnji5V/nTQwZKs31DVSNM6gsYg==
X-Received: by 2002:a05:651c:d3:b0:2ee:56b0:38e3 with SMTP id 38308e7fff4ca-2ee8f9ae2bdmr10258691fa.24.1720097378360;
        Thu, 04 Jul 2024 05:49:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4264a1f2391sm23876455e9.25.2024.07.04.05.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 05:49:37 -0700 (PDT)
Message-ID: <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
Date: Thu, 4 Jul 2024 14:49:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6064157.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/07/2024 13:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> if zone temperature is invalid") caused __thermal_zone_device_update()
> to return early if the current thermal zone temperature was invalid.
> 
> This was done to avoid running handle_thermal_trip() and governor
> callbacks in that case which led to confusion.  However, it went too
> far because monitor_thermal_zone() still needs to be called even when
> the zone temperature is invalid to ensure that it will be updated
> eventually in case thermal polling is enabled and the driver has no
> other means to notify the core of zone temperature changes (for example,
> it does not register an interrupt handler or ACPI notifier).
> 
> Also if the .set_trips() zone callback is expected to set up monitoring
> interrupts for a thermal zone, it needs to be provided with valid
> boundaries and that can only be done if the zone temperature is known.
> 
> Accordingly, to ensure that __thermal_zone_device_update() will
> run again after a failing zone temperature check, make it call
> monitor_thermal_zone() regardless of whether or not the zone
> temperature is valid and make the latter schedule a thermal zone
> temperature update if the zone temperature is invalid even if
> polling is not enabled for the thermal zone (however, if this
> continues to fail, give up after some time).

Rafael,

do we agree that we should fix somehow the current issue in this way 
because we are close to the merge window, but the proper fix is not 
doing that ?


> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org
> Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   13 ++++++++++++-
>   drivers/thermal/thermal_core.h |    9 +++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -300,6 +300,14 @@ static void monitor_thermal_zone(struct
>   		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>   	else if (tz->polling_delay_jiffies)
>   		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
> +	else if (tz->temperature == THERMAL_TEMP_INVALID &&
> +		 tz->recheck_delay_jiffies <= THERMAL_MAX_RECHECK_DELAY) {
> +		thermal_zone_device_set_polling(tz, tz->recheck_delay_jiffies);
> +		/* Double the recheck delay for the next attempt. */
> +		tz->recheck_delay_jiffies += tz->recheck_delay_jiffies;
> +		if (tz->recheck_delay_jiffies > THERMAL_MAX_RECHECK_DELAY)
> +			dev_info(&tz->device, "Temperature unknown, giving up\n");
> +	}
>   }
>   
>   static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
> @@ -430,6 +438,7 @@ static void update_temperature(struct th
>   
>   	tz->last_temperature = tz->temperature;
>   	tz->temperature = temp;
> +	tz->recheck_delay_jiffies = 1;
>   
>   	trace_thermal_temperature(tz);
>   
> @@ -514,7 +523,7 @@ void __thermal_zone_device_update(struct
>   	update_temperature(tz);
>   
>   	if (tz->temperature == THERMAL_TEMP_INVALID)
> -		return;
> +		goto monitor;
>   
>   	tz->notify_event = event;
>   
> @@ -536,6 +545,7 @@ void __thermal_zone_device_update(struct
>   
>   	thermal_debug_update_trip_stats(tz);
>   
> +monitor:
>   	monitor_thermal_zone(tz);
>   }
>   
> @@ -1438,6 +1448,7 @@ thermal_zone_device_register_with_trips(
>   
>   	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>   	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> +	tz->recheck_delay_jiffies = 1;
>   
>   	/* sys I/F */
>   	/* Add nodes that are always present via .groups */
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -67,6 +67,8 @@ struct thermal_governor {
>    * @polling_delay_jiffies: number of jiffies to wait between polls when
>    *			checking whether trip points have been crossed (0 for
>    *			interrupt driven systems)
> + * @recheck_delay_jiffies: delay after a failed thermal zone temperature check
> + * 			before attempting to check it again
>    * @temperature:	current temperature.  This is only for core code,
>    *			drivers should use thermal_zone_get_temp() to get the
>    *			current temperature
> @@ -108,6 +110,7 @@ struct thermal_zone_device {
>   	int num_trips;
>   	unsigned long passive_delay_jiffies;
>   	unsigned long polling_delay_jiffies;
> +	unsigned long recheck_delay_jiffies;
>   	int temperature;
>   	int last_temperature;
>   	int emul_temperature;
> @@ -133,6 +136,12 @@ struct thermal_zone_device {
>   	struct thermal_trip_desc trips[] __counted_by(num_trips);
>   };
>   
> +/*
> + * Maximum delay after a failing thermal zone temperature check before
> + * attempting to check it again (in jiffies).
> + */
> +#define THERMAL_MAX_RECHECK_DELAY	(30 * HZ)
> +
>   /* Default Thermal Governor */
>   #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
>   #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


