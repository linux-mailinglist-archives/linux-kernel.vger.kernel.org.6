Return-Path: <linux-kernel+bounces-208692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37517902830
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9D2282233
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BA7148827;
	Mon, 10 Jun 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoTQSO4Y"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0F11C92
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042497; cv=none; b=DxZFOnBQ3HTfbxl+J6PH4EgiYb8NXgdEKJW6qzJZgk8byjA1XeiefGBA1o3Wa9gWgFzD2UmVS4mszjkqe6zjm1B1ly2mN4rQ276t+Ekf4X2pMHkEQSxOJyFCmoomun8kwo01esoQiTzqubN+YpRfRc3NjqSgiEtrxxiddc9W8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042497; c=relaxed/simple;
	bh=g2c7nnmBcEtmWKG2cdatzphUu9nwq1gexVv+zu2DXf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brFEhqEcTONU3t2aNC1povPHox91XMr5n/jp8J3Rjmbuzree5XEzp2L/2hcIrkWMGElxHrB6/9HLsDMg8rCxGJ4msQtxuiW9MnG/kegyZwIuVcfE6VExrrljphX1u1QLkQzPeR4w2aCpr9eC9w1okiTNnziXGHK5O4DG2DBi98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoTQSO4Y; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso254610e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718042493; x=1718647293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goT3FiiTHuDDxuZezrmRBAQweENaqO0vsQeYq6d8HbE=;
        b=uoTQSO4YWzo6jb60hVqRPaIvDykgE6xj3X15sEX5SDM5y7idRfZeGLGMNHjxBtT7CW
         FYe+gEmq5GxDVqpQ1j6bTVKQow7rJTtiTVA8BtafrxlnqBn4GftOPGU/zqEAOhNWfu7I
         +NStxP/R/J0rI5lhd0D3AGWKG3JpYBmzyxmKf5VD6my8Xu1R3EpcF04jxdjGAFw6FoMb
         nwon3kmwnh9bdCVcXI2Cpai6VRkb7WCZsvcc8KW//YK7DCRCD/X7QwDLG1YlGRgtTZoQ
         DHgJ3skQsel6hVsxpCHy5B+dC+OltY3VH4JQSBN0mAVe9QCgL03Ynrib19C1/5UoIXw5
         oFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042493; x=1718647293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goT3FiiTHuDDxuZezrmRBAQweENaqO0vsQeYq6d8HbE=;
        b=EPy2LmLNy1oL3VQQmuwaOPsnKLInVw9+s0b3mcez1mvW2KiQ/Xzs/oBSXYuZIr331u
         6xyxf01v/6o6HG1NUSxuro3fulFQntskOUZkG4w/nD61kCVYZW+mMLXCtSVyynu9FQKq
         m3heF9kOjL/1QvHk4W7hpqF3DNyOROg5MC4HdoDfdh87Jx9qRp1QNACHJqSCkTdQ4nBs
         VO7xdrXIegtsj4Pbm14rgWT1FCQiEEAlb/7s/G7FnfDYXkQChXITtfyBBX8/1is/Mx/j
         bpa/4j+rqBp4ombdtOJawzzDSjescn4dpBGtPNpM3KTBZoaNLsfL8Q4sMwsKii1/W1jq
         Js8g==
X-Gm-Message-State: AOJu0Yx3lXm3yC4FcCHuY7k1qCUhIvd5+XhiKvPmpnark+IuW4gorb2K
	URB+1erbimUh+4pRUjrSVVj+Yx+sWmmvt0CxHCTXY7gsRrQv5Z+j5/5TMw3FfS8=
X-Google-Smtp-Source: AGHT+IFN2Eti8+gZyxEE3H8cpoOyZdBagWhMLrVC2RrY9w7xOb7/ljIQhtyFuW95vPKWpx4yq3PeQw==
X-Received: by 2002:a05:6512:282:b0:52c:901f:e4 with SMTP id 2adb3069b0e04-52c901f022amr813795e87.0.1718042493358;
        Mon, 10 Jun 2024 11:01:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa1desm150904605e9.11.2024.06.10.11.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:01:32 -0700 (PDT)
Message-ID: <e0a9f173-1abf-4faa-9a2d-b8310e72ef28@linaro.org>
Date: Mon, 10 Jun 2024 20:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] thermal: trip: Make thermal_zone_set_trips() use
 trip thresholds
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12458899.O9o76ZdvQC@kreacher> <2340783.ElGaqSPkdT@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2340783.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 18:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify thermal_zone_set_trips() to use trip thresholds instead of
> computing the low temperature for each trip to avoid deriving both
> the high and low temperature levels from the same trip (which may
> happen if the zone temperature falls into the hysteresis range of
> one trip).
> 
> Accordingly, make __thermal_zone_device_update() call
> thermal_zone_set_trips() later, when threshold values have been
> updated for all trips.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Rebase.
> 
> ---
>   drivers/thermal/thermal_core.c |    4 ++--
>   drivers/thermal/thermal_trip.c |   14 ++++----------
>   2 files changed, 6 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -513,13 +513,13 @@ void __thermal_zone_device_update(struct
>   	if (tz->temperature == THERMAL_TEMP_INVALID)
>   		return;
>   
> -	thermal_zone_set_trips(tz);
> -
>   	tz->notify_event = event;
>   
>   	for_each_trip_desc(tz, td)
>   		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);

Would it make sense to use the for_each_trip_desc() loop here and update
low and high on the fly in this loop ?

If a trip point is crossed the way up or down, then 
handle_thermal_trip() returns a value which in turn results in updating 
low and high. If low and high are changed then the we call 
thermal_zone_set_trips() after the loop.

The results for the thermal_zone_set_trips() will be the loop, the low, 
high, prev_low_trip and prev_high_trip variables going away.

The resulting function should be:

void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int 
high)
{
         int ret;

         lockdep_assert_held(&tz->lock);

         if (!tz->ops.set_trips)
                 return;

         /* 
 

          * Set a temperature window. When this window is left the 
driver 

          * must inform the thermal core via thermal_zone_device_update. 
 

          */
         ret = tz->ops.set_trips(tz, low, high);
         if (ret)
                 dev_err(&tz->device, "Failed to set trips: %d\n", ret);
}

But if you consider that is an additional change, then:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> +	thermal_zone_set_trips(tz);
> +
>   	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
>   	list_for_each_entry(td, &way_up_list, notify_list_node)
>   		thermal_trip_crossed(tz, &td->trip, governor, true);
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -88,17 +88,11 @@ void thermal_zone_set_trips(struct therm
>   		return;
>   
>   	for_each_trip_desc(tz, td) {
> -		const struct thermal_trip *trip = &td->trip;
> -		int trip_low;
> +		if (td->threshold < tz->temperature && td->threshold > low)
> +			low = td->threshold;
>   
> -		trip_low = trip->temperature - trip->hysteresis;
> -
> -		if (trip_low < tz->temperature && trip_low > low)
> -			low = trip_low;
> -
> -		if (trip->temperature > tz->temperature &&
> -		    trip->temperature < high)
> -			high = trip->temperature;
> +		if (td->threshold > tz->temperature && td->threshold < high)
> +			high = td->threshold;
>   	}
>   
>   	/* No need to change trip points */
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


