Return-Path: <linux-kernel+bounces-299189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B933A95D152
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD12285616
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64128185E65;
	Fri, 23 Aug 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mx2jumNl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62683BBC0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426765; cv=none; b=HwPEN2LffoEV5rJhqmWizkSp/M1YvCc9vm07x4bRC59k0BYBZzaxn1rVVPoow3NhsRsOElicDLeC7IEieunJmarTMDDWzAQyfrDpnlQVYEOh6+ax1ThPQ3DzwblNLGpq9UZf+JzIv+TxAW3Q/dwdpQRunOlOmNlZRePhX3AdsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426765; c=relaxed/simple;
	bh=40xzc0rDfi/YHMEoLZ/6a8YV/4eZmwxoThfNAdLjQr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYKwZSx0w4os27tg2OStNr7Wf/tuoNSr0S2gQZKZWZ9Fup0df77aO1SeQ36QJkaJ5r3GM9RWFJiInUg6GiFvv/e7/KjB+z9otdLHDlV79Mn6a3f8pCSiSk+HRacP/vv8uNfJagyd1An1EinwAzbOBqz0FXvU5TiRezCvYpJ3z0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mx2jumNl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428fb103724so16828425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724426762; x=1725031562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcJcPtbVTGAk4jHug8Qq03JOqULGW8onave0/ZyYRBE=;
        b=Mx2jumNlXRbqynIqlLsfpwqjvDn6aluLSzoBTBVK4xvst+62zmaTQw0BZciHB+hHrq
         MuzuVaZwvtaK8dQ2SERZaTXtRN4YA6/CNA4drb60VolHnEJkMhvHRwHgOvvBGPu2jUgd
         JupK9yOTlwhisd29D1a/jzzSRguzI51bKuJk+dABMMjmBr+1QIZALZP0ohy9Hd7hr07/
         jgjlvQyfYueToasKw0nHo/qP0kKMWwK431wBOwveICxan/xAHBVKGsxJ25Dyq0QeTzL9
         ZXhGnOdKDd7XaKIQGipP7zPrRJ0HqrGqc6A7r2uBNfg8GtACAQ5+Gt3OEH00YRh9gyLT
         WKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426762; x=1725031562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcJcPtbVTGAk4jHug8Qq03JOqULGW8onave0/ZyYRBE=;
        b=tgu2SWJKOqA/HkRXUMN2T1lJIUep5oQA0Kh+XHoYlYeOI5WRT+6oDjWwgBWjP8yio1
         iHXCF7zA+rNc4xhDqL2EPcHrf6YSHlMnqViPTx7XthaZCjOdMCiv3AXLBnu1LStUn+fX
         1nBTvDYd+pGUBde8ELW9oqbIqS2F2sfvb5sdhh+D1Hj4jglrCh05lnIN158KvlY/unk4
         LIxNdCEM8UJHUiE3CpVYjoNEHC7iJQkKYg2y+wR0IAgxLh4EIO9GdYJJKrblK/4n/pnd
         rNl+ltTk/ryStZfGpl/htdcgLNltJ6KX16BOzwRsp+k4CyXATj4XSo5rbuVr/euls8W6
         CAFQ==
X-Gm-Message-State: AOJu0YyzBJpGsboD7ULH1NZ6nEeAi0sH8hX1BaROQlAWOARlENdq8mdB
	TM9QKT/k2niaDNUsFTjglq9G0ffn1AJK+1JLlYyKB5r/PUUzlTMOyyPCL3v4+so=
X-Google-Smtp-Source: AGHT+IEglaidphj6YCI5Ggh/8tdcG5dxMQyyLpOGgdQahrMZbwx36OryhnvkWMkDH29pRguBWF3xbg==
X-Received: by 2002:a05:600c:138c:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42ac3899e98mr38917085e9.6.1724426761575;
        Fri, 23 Aug 2024 08:26:01 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-373081457c5sm4354299f8f.42.2024.08.23.08.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:26:01 -0700 (PDT)
Message-ID: <cb8bbde9-1b13-4c63-960d-5846a319f5ea@linaro.org>
Date: Fri, 23 Aug 2024 17:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] thermal: sysfs: Add sanity checks for trip
 temperature and hysteresis
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?Peter_K=C3=A4stle?=
 <peter@piie.net>
References: <3331194.44csPzL39Z@rjwysocki.net>
 <7719509.EvYhyI6sBW@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7719509.EvYhyI6sBW@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 21:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add sanity checks for new trip temperature and hysteresis values to
> trip_point_temp_store() and trip_point_hyst_store() to prevent trip
> point thresholds from falling below THERMAL_TEMP_INVALID.
> 
> However, still allow user space to pass THERMAL_TEMP_INVALID as the
> new trip temperature value to invalidate the trip if necessary.
> 
> Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_sysfs.c |   38 ++++++++++++++++++++++++++------------
>   1 file changed, 26 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -111,18 +111,25 @@ trip_point_temp_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	if (temp != trip->temperature) {
> -		if (tz->ops.set_trip_temp) {
> -			ret = tz->ops.set_trip_temp(tz, trip, temp);
> -			if (ret)
> -				goto unlock;
> -		}
> +	if (temp == trip->temperature)
> +		goto unlock;
>   
> -		thermal_zone_set_trip_temp(tz, trip, temp);
> +	if (temp != THERMAL_TEMP_INVALID &&
> +	    temp <= trip->hysteresis + THERMAL_TEMP_INVALID) {

It seems to me the condition is hard to understand.

   temp <= trip->hysteresis + THERMAL_TEMP_INVALID

	  ==>

   temp - trip->hysteresis <= THERMAL_TEMP_INVALID


Could be the test below simpler to understand ?

	if (trip->hysteresis &&
	    temp - trip->hysteresis < THERMAL_TEMP_INVALID))

I think more sanity check may be needed also.

	if (temp < THERMAL_TEMP_INVALID)

> +		ret = -EINVAL;
> +		goto unlock;
> +	}
>   
> -		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +	if (tz->ops.set_trip_temp) {
> +		ret = tz->ops.set_trip_temp(tz, trip, temp);
> +		if (ret)
> +			goto unlock;
>   	}
>   
> +	thermal_zone_set_trip_temp(tz, trip, temp);
> +
> +	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +
>   unlock:
>   	mutex_unlock(&tz->lock);
>   
> @@ -152,15 +159,22 @@ trip_point_hyst_store(struct device *dev
>   
>   	mutex_lock(&tz->lock);
>   
> -	if (hyst != trip->hysteresis) {
> -		thermal_zone_set_trip_hyst(tz, trip, hyst);
> +	if (hyst == trip->hysteresis)
> +		goto unlock;
>   
> -		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +	if (hyst + THERMAL_TEMP_INVALID >= trip->temperature) {
> +		ret = -EINVAL;
> +		goto unlock;
>   	}
>   
> +	thermal_zone_set_trip_hyst(tz, trip, hyst);
> +
> +	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +
> +unlock:
>   	mutex_unlock(&tz->lock);
>   
> -	return count;
> +	return ret ? ret : count;
>   }
>   
>   static ssize_t
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

