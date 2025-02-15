Return-Path: <linux-kernel+bounces-516243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 318A8A36EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7691895234
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2B13FD72;
	Sat, 15 Feb 2025 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="EsTOF6wc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C12753FC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739627473; cv=none; b=msFj6xLPRiP3pBiYtWlF77lm5O0q616BhHXgiHUg25vOszfTje0QkFr/CesvdCFV3C7TQELdPMLGzmFoYb1HLL0Q255Z3ERh0stPVH+FTAOy3hyW1whl579rmYz87mKAyl00MIMVuA+GmpT/Ms6tYxkBWpZYKn+x0wsOszig9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739627473; c=relaxed/simple;
	bh=7QYxIZYVkBPVcBRtZV1bHOD2EOWvDuyh0f+6TKXwhHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgV64avPKTxJuPl8mKM+7sB+dkDkop0F8s5MgfCofkEcSJZ8Fk98Ra/h8zXm3QECHadE4mwAdItlQagJbyhC1DRpJD2MfHqwcz5dPpIik52X20he0dXQ6oRnKQy9Iwly0t64sFknUi/X2wqPejb8auxwtSVD9YRJsH84MWPhYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=EsTOF6wc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso5311588a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739627469; x=1740232269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGe5zFm2hqgl1riWslKYEhwYCtjiJiuO8PGs9H4DGXM=;
        b=EsTOF6wcqyEIbbjf4/cFsaGtRww4IxDHiYF8o/x0pzLFYsYdDndZ0iPNiIVo98fbFt
         3RgmKKoKGBS/WeQ5NgjRp3T30PIVhuee68uHjTEcZUMWVUR0VZQwan/ann3KtskweLPU
         R9m8UaZQrHFjJMExKdXoyk76yKt4hv0ZwWHm5qBkkL8ALryXjowqATomEf/yVSw/JZCt
         s6p/f6egzCfmRGlFgKwr2T2usJS+vuX/ZgoEzD+9AJB9pB39op1EQ65XDpYR8lOSfF+A
         HLcHLLvXE+WyX2AR7FMOKBBzhvaiGaMmEp68U/DvS/ZUxmdGICUzIR75ueTmb21iDL9l
         Z/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739627469; x=1740232269;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGe5zFm2hqgl1riWslKYEhwYCtjiJiuO8PGs9H4DGXM=;
        b=bJSzO9jE6Jy2g1CM4eeklt8cAUvY02EwT1/+SjA56GY3BPrtWgp2Q0PlBC5pps4YNX
         2BXYQVKFkJi9/C7LR7OavimdwTDX9vYzPVScbUUtVqeHEarVTpsj+hIRDPlB2NfpDL9n
         2EDM68T+ph6vTehQ+GfqCxlv7kQsa5xxlPwHBsMjf7XAc82E1ERRpYOncYYffgRk1Qae
         0ANLrCLnzHP8r2e09tZEAl4JaO+BkLn4BWL/Z/wRqjNoTJynbkEgtZ1Hp7OGilIzKkmn
         kMhxX9DvzGXXgjUZYSVE52eS0CDScDN+Hcxyz9U38nI7xEa1gMEcMzwrI5jJV9vU41sn
         L3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhnKht2XDeEJ/0LdPQaqX+4vfB0DqOioz32Pu70illMa+2DOUQ9lrpXe9vE+w/euXl83Sif6+4k/m7Ik4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyuSZsAK0U3PNKpvCsbIr05OQfsE/DjLL3iGjIsRnXhRq6kb0d
	X7W6viVrDpXtDdM0oQ5sBSOfrMkdJ5KIO4xe/HLsI4ETkKk/Fi04o3A9gNtlPYY=
X-Gm-Gg: ASbGncuYfzjuetn98yB8p2Te7vPc0VI6F4/ocmyq/QETyzu+ylVBG3E87Cm+vmyTdJn
	Fn2sUh+BVwSJT1AB6sQS/8q0+9qH2nBvz+XI/0Ktq5pdX/8/VgBlLzoT5kTNfZMdWlL3EdqyIAY
	nPYjc1cGIGqFvuKXaslxy7ej7+RtnTsuqnvAU8E5FW62lmlJraUZ/uIHdKs90RbItZuJe5ZuDxf
	nhbbFem7TFvKryeeYzv23bMUTGAR6JlscigOBfTtXrUiclQEbYW24QdQVj01UxoBYh67X7cD45h
	Sqz/zFPUH36ZKxpKtRlbFTyW
X-Google-Smtp-Source: AGHT+IHAE3K34tunCi2jsOlYrjn2E1aFkpBBzksorxYjrR1g/vjBHfziIANjKfKbdmU98ZykDePgDg==
X-Received: by 2002:a05:6402:1d52:b0:5dc:88fe:dcd1 with SMTP id 4fb4d7f45d1cf-5e036071a81mr3271834a12.12.1739627469583;
        Sat, 15 Feb 2025 05:51:09 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece271223sm4598233a12.59.2025.02.15.05.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 05:51:08 -0800 (PST)
Message-ID: <4bf01946-90e3-4169-91fa-10d9f90310e9@tuxon.dev>
Date: Sat, 15 Feb 2025 15:51:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, dakr@kernel.org, jic23@kernel.org,
 ulf.hansson@linaro.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com>
 <2025021539-untrained-prompter-a48f@gregkh>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <2025021539-untrained-prompter-a48f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Greg,

On 15.02.2025 15:25, Greg KH wrote:
> On Sat, Feb 15, 2025 at 03:08:49PM +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
>> clocks are managed through PM domains. These PM domains, registered on
>> behalf of the clock controller driver, are configured with
>> GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
>> clocks are enabled/disabled using runtime PM APIs. The power domains may
>> also have power_on/power_off support implemented. After the device PM
>> domain is powered off any CPU accesses to these domains leads to system
>> aborts.
>>
>> During probe, devices are attached to the PM domain controlling their
>> clocks and power. Similarly, during removal, devices are detached from the
>> PM domain.
>>
>> The detachment call stack is as follows:
>>
>> device_driver_detach() ->
>>   device_release_driver_internal() ->
>>     __device_release_driver() ->
>>       device_remove() ->
>>         platform_remove() ->
>> 	  dev_pm_domain_detach()
>>
>> During driver unbind, after the device is detached from its PM domain,
>> the device_unbind_cleanup() function is called, which subsequently invokes
>> devres_release_all(). This function handles devres resource cleanup.
>>
>> If runtime PM is enabled in driver probe via devm_pm_runtime_enable(), the
>> cleanup process triggers the action or reset function for disabling runtime
>> PM. This function is pm_runtime_disable_action(), which leads to the
>> following call stack of interest when called:
>>
>> pm_runtime_disable_action() ->
>>   pm_runtime_dont_use_autosuspend() ->
>>     __pm_runtime_use_autosuspend() ->
>>       update_autosuspend() ->
>>         rpm_idle()
>>
>> The rpm_idle() function attempts to resume the device at runtime. However,
>> at the point it is called, the device is no longer part of a PM domain
>> (which manages clocks and power states). If the driver implements its own
>> runtime PM APIs for specific functionalities - such as the rzg2l_adc
>> driver - while also relying on the power domain subsystem for power
>> management, rpm_idle() will invoke the driver's runtime PM API. However,
>> since the device is no longer part of a PM domain at this point, the PM
>> domain's runtime PM APIs will not be called. This leads to system aborts on
>> Renesas SoCs.
>>
>> Another identified case is when a subsystem performs various cleanups
>> using device_unbind_cleanup(), calling driver-specific APIs in the process.
>> A known example is the thermal subsystem, which may call driver-specific
>> APIs to disable the thermal device. The relevant call stack in this case
>> is:
>>
>> device_driver_detach() ->
>>   device_release_driver_internal() ->
>>     device_unbind_cleanup() ->
>>       devres_release_all() ->
>>         devm_thermal_of_zone_release() ->
>> 	  thermal_zone_device_disable() ->
>> 	    thermal_zone_device_set_mode() ->
>> 	      struct thermal_zone_device_ops::change_mode()
>>
>> At the moment the driver-specific change_mode() API is called, the device
>> is no longer part of its PM domain. Accessing its registers without proper
>> power management leads to system aborts.
>>
>> Open a devres group before calling the driver probe, and close it
>> immediately after the driver remove function is called and before
>> dev_pm_domain_detach(). This ensures that driver-specific devm actions or
>> reset functions are executed immediately after the driver remove function
>> completes. Additionally, it prevents driver-specific runtime PM APIs from
>> being called when the device is no longer part of its power domain.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Hi,
>>
>> Although Ulf gave its green light for the approaches on both IIO [1],
>> [2] and thermal subsystems [3], Jonathan considered unacceptable the
>> approaches in [1], [2] as he considered it may lead to dificult to
>> maintain code and code opened to subtle bugs (due to the potential of
>> mixing devres and non-devres calls). He pointed out a similar approach
>> that was done for the I2C bus [4], [5].
>>
>> As the discussions in [1], [2] stopped w/o a clear conclusion, this
>> patch tries to revive it by proposing a similar approach that was done
>> for the I2C bus.
>>
>> Please let me know you input.
> 
> I'm with Jonathan here, the devres stuff is getting crazy here and you
> have drivers mixing them and side affects happening and lots of
> confusion.  Your change here is only going to make it even more
> confusing, and shouldn't actually solve it for other busses (i.e. what
> about iio devices NOT on the platform bus?)

You're right, other busses will still have this problem.

> 
> Why can't your individual driver handle this instead?

Initially I tried it at the driver level by using non-devres PM runtime
enable API but wasn't considered OK by all parties.

I haven't thought about having devres_open_group()/devres_close_group() in
the driver itself but it should work.

Thank you,
Claudiu

> 
> thanks,
> 
> greg k-h


