Return-Path: <linux-kernel+bounces-384822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB49B2ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B4A28701C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F111D47A6;
	Mon, 28 Oct 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zB8tT5T3"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD71D31B8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114649; cv=none; b=Lsk7s6imfAYzDv4nk9K6vA1fcmzUGjwerCnd2/1nDro3JBdtsSFB+raJyAOo/a+lT8RmA+vbWDDuX+3ChHpqQg2+w7gSyauujUDj7r6QvWIX+Rt++edCXR29LQQF+y4RckCcL/gcH9ip1ug/p4549lq0CKl4DX6ECuAp+EwfdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114649; c=relaxed/simple;
	bh=OucdZC060IUL/sm8antyDtOyqKVTT8W8wH7gc66OPJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwtyestrKlL3QyHUUrQiNV4ZBAwg2eyPZXY0xrvsryKZWrwL/LKvs9BSUvZlqyUeedb7plO8v/1S187bdnDzmSCrF+7TJiHKJ2qzAeSoGGOHPrQetIV8uGSxDiFO5C8sBbuFnPGGFlK7ZaQYHJb/HD6LeAvbX5a75447ffXORuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zB8tT5T3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5502684e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730114645; x=1730719445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJJbPGU65AhhUIO8bz7yn184UqOJUlvgFCxYhC4bO60=;
        b=zB8tT5T3/8Mzneq/eRg18KypAjfEc86x1a+P+PSWN22bFtFn/mZVhZqHm/P36ECNlb
         v092UCXSWHZkafYrbbBkGmXqXvow1Rft+1RHxpdPyI23vv0FMNof9+4/wvvhbpRg/bHz
         2FDZykGaWn60MLRGsKTmnSsHbQoovikaKLMaggg6nG4pNl54EiEJ706es0bRz/tAteIr
         y5ERjHj986dHHMd9+D3v5fiPQdm5kgXKoxEa/Hfxw7m+o7dil5u0BVsqjugRae9f34rG
         3bQGDAi/ebn8GO5wc2MBpU0ZkH7obxeGP8kIT24lm5vHoGf9rQBmwbhi5cxEeZIBFgxq
         YwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730114645; x=1730719445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJJbPGU65AhhUIO8bz7yn184UqOJUlvgFCxYhC4bO60=;
        b=ggNKxe082Dyg8tnMLPGQTPp+HgrVFx3zmAzPkKzxuI7EYGAB1ye+xG7uHI1UakHBbO
         nFL8QsMMzfu0HrWQeUn5VGQFHYRtrmxlOa2rJIVmMi5KcRvDTOvpvgwJfHvD6fue9NUz
         JiOtviQHkaDTqxUGZVT6bSDpVSGa6/WKzE+12pyTCtj2WCUevV5Hwfz8xwJVyaugZy4I
         AYWbBXELBWHvyQXGmP4EiXyFYjkMksf+uxKqARGuXIfSQfIzN831I7CQs4r+Hk76zhNj
         dHlXuaQPZwt8H7HoY+CCu7GSvctVj9CoBcgiVxa2Nme64MTJVTNXw/HdbfnXrrfgFkjM
         y3/A==
X-Gm-Message-State: AOJu0YwGtHxxspvDsUzkZ34nPhBwxwe4V5YusEPGNQJF5N3PEB2HF3hD
	6b/y9z5NtWdCL8/rluhSVEQBEzhixUqylsqymTyymuPbhW1pF4q7O8cO51+Bxeg=
X-Google-Smtp-Source: AGHT+IGLiSIAISzevLLOUIE76KOJqCg/OoYL8vVQijw6yuxou4BSnghLLrEm4/v7x/wuFbPvQ450+A==
X-Received: by 2002:a05:6512:1392:b0:536:73b5:d971 with SMTP id 2adb3069b0e04-53b34c5f886mr3246487e87.38.1730114645508;
        Mon, 28 Oct 2024 04:24:05 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43193573cd4sm106753715e9.5.2024.10.28.04.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:24:05 -0700 (PDT)
Message-ID: <5a535983-6a78-4449-b57b-176869fd55d8@linaro.org>
Date: Mon, 28 Oct 2024 12:24:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: fix child node refcount
 handling
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241013-timer-ti-dm-systimer-of_node_put-v1-1-0cf0c9a37684@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241013-timer-ti-dm-systimer-of_node_put-v1-1-0cf0c9a37684@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Javier,

thanks for spotting the issue


On 13/10/2024 12:14, Javier Carrasco wrote:
> of_find_compatible_node() increments the node's refcount, and it must be
> decremented again with a call to of_node_put() when the pointer is no
> longer required to avoid leaking memory.
> 
> Add the missing calls to of_node_put() in dmtimer_percpu_quirck_init()
> for the 'arm_timer' device node.
> 
> Cc: stable@vger.kernel.org
> Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/clocksource/timer-ti-dm-systimer.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
> index c2dcd8d68e45..23be1d21ce21 100644
> --- a/drivers/clocksource/timer-ti-dm-systimer.c
> +++ b/drivers/clocksource/timer-ti-dm-systimer.c
> @@ -691,8 +691,10 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
>   	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
>   	if (of_device_is_available(arm_timer)) {
>   		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
> +		of_node_put(arm_timer);
>   		return 0;
>   	}
> +	of_node_put(arm_timer);

Best practice would be to group of_node_put into a single place.

	bool available;

	[ ... ]

	available = of_device_is_available(arm_timer);
	of_node_put(arm_timer);

	if (available) {
		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
		return 0;
	}


>   	if (pa == 0x4882c000)           /* dra7 dmtimer15 */
>   		return dmtimer_percpu_timer_init(np, 0);
> 
> ---
> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> change-id: 20241013-timer-ti-dm-systimer-of_node_put-d42735687698
> 
> Best regards,


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

