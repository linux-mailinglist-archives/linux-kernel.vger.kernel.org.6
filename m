Return-Path: <linux-kernel+bounces-521519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84531A3BE64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692961895E81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FAB1E0DCD;
	Wed, 19 Feb 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dWM/VX4j"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6681DFD9D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969115; cv=none; b=idCOFuk8iNA0AEs84cH5X87/rXV3vHu1fwzFSKUyMUBGM7LyuZEqPbiUXDQF6duMcyNukSrbo/KX5FgPYIzPcL4zQAF1fdB9z4UzkODne9dfZOGYhN2s7JNp7xKHY0P4RHwhIILJ+PYgIt84At2ADrSF5s8gtKP0hoAczPsgEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969115; c=relaxed/simple;
	bh=P+gV28lKZRdfBrqRS0IUOyxV12AN6CkJXtnoB0Q4LhU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b1uAfoTZ3zn+docgNlzWVdSUvlcvnlaNjwMHMpaOSWwmqjSz44t7bgJ6rUdWRJLYq45S6cOw+742Bg3rkAeV+Xa6KpV06/lrkOOodK+qcClz30ThqO+B9luswIpCrnZp5OzNgzuWofzOS00Db1CaGdjeU7ni/JXLcnUPGwKvChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dWM/VX4j; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbd96bef64so97031066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739969110; x=1740573910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8aWk9ACxeOktVt7eviYGo7lrFquCo7Eax3iBYmtuH50=;
        b=dWM/VX4jF8QeQNKpWe2OLTFW8wbKTbTTiIMq1bsxMfuTG2YipiwIiZUaQ6GxkdVdZ2
         l8UdB1AuEhi5QNzq9ILiAp/HYh98lZCyPCiLlPAJZO6NI3k4YV5G9YAgUamcJZ7nxbw1
         qOCCHwIFrZkqF9FH/T2SX/EVAvHc8zuyIQBnNrqkSs2CtT4z43xntwrWw/gJA6w91DgR
         gZ8LnN1d7K4THpjnYEpXDq8YdK4emLB3jEjw3/7nlQK1HQwuQeRSTNgrONi4zHtg9brU
         I1kZNvW7LQafC94NMLgj61QeMiZzw/hqD3DGCsMlLnUfPCFz7l+mxh1iH7JJ513C4dMs
         qq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969110; x=1740573910;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aWk9ACxeOktVt7eviYGo7lrFquCo7Eax3iBYmtuH50=;
        b=GAj4MiGcDVcSfeiDrydErPI8RSN8gN6i/Bbpd50wwKgMvr6B9xkIB3y/4KZlkAwBE0
         obapo+eyyKeHwswU+Tvv5ZzQnGphkQ2bdWOAr5DmSiZPwrP3kdWq7f0r4iSiK8Xm6UAM
         sXNOpPw0O5LuAEGbCoZY/Gr58wkDMFwq4VUS0Po77Kdaub09OoQmMxQ61Gf6GzfbCkAd
         I1NWXLCH0Sshb9M3P/SYCRBfzJ+YCGRwRKkkRfotatNGCBLJ/kjL8D4KKZbFvzLlSO3H
         0eUMf4JTC+b6F6+6lcCuJhvU28fBVbwWCCyKwpZzwc/SBgC8QD0rCs6DcqhrRDGC2zxr
         bhLA==
X-Forwarded-Encrypted: i=1; AJvYcCUDxrUQNgCKZdYaLrrZNyYPA44RF+F+rjh5nVYTQJ2XhsyuDEVomNuP8tGwA4qx3FBDDfS0OUxnjCFBF6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKYwCgQDUx+i5pkQAkaT22vHK2T5r6X/kyMaf6geOrhZTcSZ2
	wWZbvoXaawT9Xf7QS+piNrD5NmtIMoXRQK8i1Y8bVJH9jCF+YPtshzq0PWmueXpq/NC3EJ5nZq/
	9
X-Gm-Gg: ASbGncuiajApvXevK7lZWMGSvJwtFqvNwtnIByFBBF9GKF9cnBxG4VmdwZTUhkYuzVn
	3PInV63GvM8ckTU37lzT+USMqE2umvkYF0e1rcBM4p6hCRV1W1CMfwn0pAoJhHZ2qEs7p/CypT2
	WxYM4NbTQWf0LNll5WvWEINqbOmZAPkAQrXiS1LQqrYen1DLXP2tayxXGtkJKCCfm6ESFPYAlVF
	DYOpHI6ieFkVj8TYAgmJs9bvPiEaZrN9IZfHyVwadVD3syVsZN7vPZke8kodq7I4mM4l46omIGM
	xrr0PQQgpxb2ihsadGtH0xY=
X-Google-Smtp-Source: AGHT+IFYOVix0/dEDuKvIlQRX7Je/rbWqPWV9hEJk5Bq1TOCsIV+uU9vL3eEn13Z0cJvKpMHBrX2xQ==
X-Received: by 2002:a17:907:72cf:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-abb70db0230mr1396162866b.31.1739969109935;
        Wed, 19 Feb 2025 04:45:09 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb836ee14dsm771388866b.47.2025.02.19.04.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:45:09 -0800 (PST)
Message-ID: <8d83ea72-bb81-4c63-bf69-28cf5848ae20@tuxon.dev>
Date: Wed, 19 Feb 2025 14:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Jonathan Cameron <jic23@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, dakr@kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
 <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
Content-Language: en-US
In-Reply-To: <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Daniel, Jonathan,

On 15.02.2025 15:51, Claudiu Beznea wrote:
> Hi, Greg,
> 
> On 15.02.2025 15:25, Greg KH wrote:
>> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>>> clocks are managed through PM domains. These PM domains, registered on
>>> behalf of the clock controller driver, are configured with
>>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>>> clocks are enabled/disabled using runtime PM APIs. The power domains may
>>> also have power_on/power_off support implemented. After the device PM
>>> domain is powered off any CPU accesses to these domains leads to system
>>> aborts.
>>>
>>> During probe, devices are attached to the PM domain controlling their
>>> clocks and power. Similarly, during removal, devices are detached from the
>>> PM domain.
>>>
>>> The detachment call stack is as follows:
>>>
>>> device_driver_detach() ->
>>>   device_release_driver_internal() ->
>>>     __device_release_driver() ->
>>>       device_remove() ->
>>>         platform_remove() ->
>>> 	  dev_pm_domain_detach()
>>>
>>> During driver unbind, after the device is detached from its PM domain,
>>> the device_unbind_cleanup() function is called, which subsequently invokes
>>> devres_release_all(). This function handles devres resource cleanup.
>>>
>>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
>>> cleanup process triggers the action or reset function for disabling runtime
>>> PM. This function is pm_runtime_disable_action(), which leads to the
>>> following call stack of interest when called:
>>>
>>> pm_runtime_disable_action() ->
>>>   pm_runtime_dont_use_autosuspend() ->
>>>     __pm_runtime_use_autosuspend() ->
>>>       update_autosuspend() ->
>>>         rpm_idle()
>>>
>>> The rpm_idle() function attempts to resume the device at runtime. However,
>>> at the point it is called, the device is no longer part of a PM domain
>>> (which manages clocks and power states). If the driver implements its own
>>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
>>> driver - while also relying on the power domain subsystem for power
>>> management, rpm_idle() will invoke the driver's runtime PM API. However,
>>> since the device is no longer part of a PM domain at this point, the PM
>>> domain's runtime PM APIs will not be called. This leads to system aborts on
>>> Renesas SoCs.
>>>
>>> Another identified case is when a subsystem performs various cleanups
>>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
>>> A known example is the thermal subsystem, which may call driver-specific
>>> APIs to disable the thermal device. The relevant call stack in this case
>>> is:
>>>
>>> device_driver_detach() ->
>>>   device_release_driver_internal() ->
>>>     device_unbind_cleanup() ->
>>>       devres_release_all() ->
>>>         devm_thermal_of_zone_release() ->
>>> 	  thermal_zone_device_disable() ->
>>> 	    thermal_zone_device_set_mode() ->
>>> 	      struct thermal_zone_device_ops::change_mode()
>>>
>>> At the moment the driver-specific change_mode() API is called, the device
>>> is no longer part of its PM domain. Accessing its registers without proper
>>> power management leads to system aborts.
>>>
>>> Open a devres group before calling the driver probe, and close it
>>> immediately after the driver remove function is called and before
>>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
>>> reset functions are executed immediately after the driver remove function
>>> completes. Additionally, it prevents driver-specific runtime PM APIs from
>>> being called when the device is no longer part of its power domain.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>
>>> Hi,
>>>
>>> Although Ulf gave its green light for the approaches on both IIO [1],
>>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
>>> approaches in [1], [2] as he considered it may lead to dificult to
>>> maintain code and code opened to subtle bugs (due to the potential of
>>> mixing devres and non-devres calls). He pointed out a similar approach
>>> that was done for the I2C bus [4], [5].
>>>
>>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
>>> patch tries to revive it by proposing a similar approach that was done
>>> for the I2C bus.
>>>
>>> Please let me know you input.
>>
>> I'm with Jonathan here, the devres stuff is getting crazy here and you
>> have drivers mixing them and side affects happening and lots of
>> confusion.  Your change here is only going to make it even more
>> confusing, and shouldn't actually solve it for other busses (i.e. what
>> about iio devices NOT on the platform bus?)
> 
> You're right, other busses will still have this problem.
> 
>>
>> Why can't your individual driver handle this instead?
> 
> Initially I tried it at the driver level by using non-devres PM runtime
> enable API but wasn't considered OK by all parties.
> 
> I haven't thought about having devres_open_group()/devres_close_group() in
> the driver itself but it should work.

Are you OK with having the devres_open_group()/devres_close_group() in the
currently known affected drivers (drivers/iio/adc/rzg2l_adc.c and the
proposed drivers/thermal/renesas/rzg3s_thermal.c [1]) ?

Thank you,
Claudiu

[1]
https://lore.kernel.org/all/20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com

> 
> Thank you,
> Claudiu
> 
>>
>> thanks,
>>
>> greg k-h
> 


