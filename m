Return-Path: <linux-kernel+bounces-249401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB392EB36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564231C2157F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5291684A8;
	Thu, 11 Jul 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fT4KpS0v"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3B1E531
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710152; cv=none; b=ncOWZMm1O2aLfYxJDruxy/kdTxjpYs/4Mf51TLaSHa9q+xjxWniX/0IAFGTvZiBVP8x4EKJN322ylZZXY2un+7Wh5LS0Wx+DMxv0wTAu1mHPijzGeb0UZVbzIYfz+TElI7c94OSzwiT2y/SSu0saSEPtq0l8CvxWQ9flj7Pbjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710152; c=relaxed/simple;
	bh=ytn6MCNLOHTbSsoVE/5vS2Wi1bcMT3Of3X6JXR9MYzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnT/XOI7Pxs1tiyqhmLGos6cRdPlNnBL0OQjULft2nPlVvRPCOpkx8RknWEywMEMW/+Ra4P4lBrOnCpiYteXQV5Gq8WiILRfQ6wQFaqHUB/227eeqFGfmT45LvC9qqIorskC9eiC0/UyIP8/MftbnGsWtPa8MXcyvZgryRd2qRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fT4KpS0v; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36798ea618bso554102f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720710149; x=1721314949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9dvNcQBnTEKo5779z6bXahpogw3lKW0g8cNRqRNDfY=;
        b=fT4KpS0vs+5wp5Uxv8J7Z4NDrT3HKzNrFKbcL5JrGOsXtcbUjJ59Tq1keAAs9v/WSE
         EqqEv07ycwCksOWpNxWe+Mdqu3svJsSdN3GFYeZ/JmcjvCOo4glXcyN40uWRcqBXnbMD
         Ll79nA7vR2vKN5c/kDKSM/KJiBJF91LMKwcS51Sp/LXR4PBmKM/dLPLkWcu4w+RYAnsa
         qV8LP8p4FazTl5Kfwslc92mhTWZLE2v9uIZ+JjsxrGTTcHAnJyP5QGqRNNzsNI4JtOGG
         yWTnZsY4MlvFIPv5OmqLbx5r9xdQRbzR++V2MvyHrFonOiZ2L74GfTXbVm5rgIeOboVT
         Wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710149; x=1721314949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9dvNcQBnTEKo5779z6bXahpogw3lKW0g8cNRqRNDfY=;
        b=UnN+PRAGbOa1/fQMaa28LBfG/JZlTRIYyB9vM19Jmb2hXb4sClrmnJkDQp7uzwWLyV
         7YAGTJjCjV+ymjwj8nn2NUhVlvHC55L6j/R+1ZMa5AzTyMFXMd5lpkQt0F0Oc0Q1fNs2
         GRpZOGddV6GSuJMjoN05vK+XDulnI4TI84YM6I4C9fhuYW5+E6BKhyyv4m0KkQvKMC8A
         9zv1wRzC8O+xqaDhDJAFP+C5FXc7mKzPOc1iHfgcoWWBqYmoX3IM160M1n+U26uHa34a
         R+k/C8qvHJK9HklBXy+LqJWdLSIKYVsDtV8dJE/Yr3UgkTxq+UK4ruoPILJ27Iw9Y/3V
         u63A==
X-Gm-Message-State: AOJu0Yz5wwxz8AwvFzQrUtwWlF5N3oz+FgwAcwAfQhN/GvgvJs5B1hSC
	pG2IzKqzVTJOO0EXTuXbt5CSYabUPBm0bQsObWBLP+LWGgXka1Xlwq7Wj04s7Ps=
X-Google-Smtp-Source: AGHT+IHwmwu3bRx0O4YEQnb4PenjONpIPFN8JuuvvCEEWdmNgUSd3YYB9OebCozI32YS26uXCptgww==
X-Received: by 2002:adf:e88f:0:b0:364:8568:f843 with SMTP id ffacd0b85a97d-367ceadb1ffmr5532820f8f.59.1720710148951;
        Thu, 11 Jul 2024 08:02:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5271:58fd:a8cb:b4aa? ([2a05:6e02:1041:c10:5271:58fd:a8cb:b4aa])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367cde848e7sm7882574f8f.44.2024.07.11.08.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:02:28 -0700 (PDT)
Message-ID: <fe954bb1-c6d1-4534-8f5e-eb965de19475@linaro.org>
Date: Thu, 11 Jul 2024 17:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Add sanity checks for polling_delay and
 passive_delay
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5802156.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5802156.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/07/2024 14:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If polling_delay is nonzero and passive_delay is greater than
> polling_delay, the thermal zone temperature will be updated less
> often when tz->passive is nonzero, which is not as expected.  Make
> the thermal zone registration fail with -EINVAL in that case as
> this is a clear thermal zone configuration mistake.
> 
> If polling_delay is nonzero and passive_delay is 0, which is regarded
> as a valid thermal zone configuration, the thermal zone will use polling
> except when tz->passive is nonzero.  However, the expected behavior in
> that case is to continue temperature polling with the same delay value
> regardless of tz->passive, so set passive_delay to the polling_delay
> value then.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/4940808.31r3eYUQgx@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1391,6 +1391,14 @@ thermal_zone_device_register_with_trips(
>   	if (num_trips > 0 && !trips)
>   		return ERR_PTR(-EINVAL);
>   
> +	if (polling_delay) {
> +		if (passive_delay > polling_delay)
> +			return ERR_PTR(-EINVAL);
> +
> +		if (!passive_delay)
> +			passive_delay = polling_delay;
> +	}
> +
>   	if (!thermal_class)
>   		return ERR_PTR(-ENODEV);
>   
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


