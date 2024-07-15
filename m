Return-Path: <linux-kernel+bounces-252312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F619931178
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A158A1F23023
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70988186E51;
	Mon, 15 Jul 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPdJIqLs"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7E186E34
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036496; cv=none; b=di/DscjAWmpJZ8puytv+8E5XtuaVq6O+vO1wKFiMoY52vpi2pX2RGpE1B25j6HcaHCfBBNwGej4G1W53ELMUNHLUgmKjMz/U0anyhl+2dJSZIVClkDeEeNKOi20NderawlKsPwUb98csOHwe2vJ8sJJf6k7s5DXLqj6/6ZGnlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036496; c=relaxed/simple;
	bh=2QIjhysmqOLRkWLcuEaszDiXxoKcbQXrijp7Huy0A/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdaIuI1NV+UZvqOHutXmxJrj9A4QNslKVMkKqPRWEm075Ym9lBBuvrpFSjpNBF8Xa1HmxNRv7TlBA3M5hyHlrYF1Fr7ibamJjEMZ4yGiI5JRwPK1EkbwT/coZFJ+cZCqYCh7UyYeXkEkqxSkNiO4u1hDb1upPNh5bP7qC+mziWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPdJIqLs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso27651995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721036493; x=1721641293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHE4l0k8/7T78Ojpyx4d9zMjrV9vqM25M9k+Cb+8n74=;
        b=LPdJIqLskKgah6zmgZZyB0GjMxhIbiNBw/Q0vR+/kXdueZiMFj9LrpD8IXDc0hgJ8c
         Rfv+LjVZYr9IfzxAEwVO43ak+mM9yzUYqRI6dROBPqg1ccOyWQcz/r9qrCLIEj+/l0h0
         6DB+wT5er2WoVnlZ1glPWy5q1QqrFSqUoGfqBg+qWh6pIF9+SxF9f+bc09BkcJ1kVBH7
         znxXYKxZgbxOq7vZOBmd9np0JiWQHJxOvLCoiqtDv3plR4u6urTuCdProjMzZvg3GgHt
         eoOBfD+OdKTiU5+FuAiw02XAeFbRryLSMQUo61WjVhXjf87WJZx5CzE0r51FmXNZMJhj
         0yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721036493; x=1721641293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHE4l0k8/7T78Ojpyx4d9zMjrV9vqM25M9k+Cb+8n74=;
        b=ZkgeEvoMt/sY9RR8zSzlyh16e36qdR+woBZ5ccs4GavlSRmsaEctqeCmLF0JmoFntb
         TcfTtlw/aJZg5eqV7J1jFaFHoOSqEawCxwiug8Rfoo1K9fTJfJ+pzY93Yg5fDWPVEuVK
         tb97yZgOHRUnbY2o49/3l9vpqRZZjjrrOdJPRESoKviMKNhz4+YpnSD9k4MDcIL1j8UF
         vB9tgoctLQLyenQldZ209c5cFq3EUt6UujOb4cp+1u85h0eGd6BOULu0TQ+c+w7GBqJN
         T8mylMjez8UjHf1pEtnE8XTeaiarMkoe5PpOwQfTe5hXglGkQ6nBt+NJVS4dL6Lt9QP/
         ZMmA==
X-Forwarded-Encrypted: i=1; AJvYcCVSbavIy+keLUCS54xU5dzVXOJqRjX1xEapnh5beuIF/vMw50jqVEI2fY/ZX6+/0GsklOkdCVWNYaXPXJF4YykNrk4gAIrbZTELPAho
X-Gm-Message-State: AOJu0Yy/eCT7853UDOnjR5+MebXSavDkcNCCVFAvhw9doB7Xif1SsW4t
	sLxqf8OY9Fdx6HHSfivqfP3zm9GKrMTEb9xOFt5XuEUJeVYFF8VwfshduofgMvY=
X-Google-Smtp-Source: AGHT+IGhU9bRZWIhRj8ltuVwAL0IJFfi4kPMozw+e1xRw050BOveYMhuHTQtu3BGvJFH7Lref3Apiw==
X-Received: by 2002:a05:600c:428b:b0:426:5f7d:add3 with SMTP id 5b1f17b1804b1-426708f9d5amr125080585e9.36.1721036493329;
        Mon, 15 Jul 2024 02:41:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e709:abf9:48b3:5079? ([2a05:6e02:1041:c10:e709:abf9:48b3:5079])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4279f25a962sm112632815e9.12.2024.07.15.02.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 02:41:32 -0700 (PDT)
Message-ID: <9a07ad5b-5dd5-4bda-893d-8faabdf1acad@linaro.org>
Date: Mon, 15 Jul 2024 11:41:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: return -EAGAIN on uninitialized read
 temp
To: neil.armstrong@linaro.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Rhyland Klein <rklein@nvidia.com>,
 Anton Vorontsov <cbouatmailru@gmail.com>, Jenny TC <jenny.tc@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
 <a50eb87a-4dcc-4272-b897-fb8170bfe58b@linaro.org>
 <0516a900-0911-47f3-888e-57d014986e3b@kernel.org>
 <b63ac8c6-213b-4307-8d33-48badee7881d@linaro.org>
 <1c981a21-8735-4bf6-9964-233b3a742f44@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1c981a21-8735-4bf6-9964-233b3a742f44@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/07/2024 11:30, Neil Armstrong wrote:
> On 05/07/2024 10:08, Daniel Lezcano wrote:
>> On 05/07/2024 07:56, Krzysztof Kozlowski wrote:
>>> On 04/07/2024 18:41, Daniel Lezcano wrote:
>>>> On 04/07/2024 10:52, Neil Armstrong wrote:
>>>>> If the thermal core tries to update the temperature from an
>>>>> uninitialized power supply, it will swawn the following warning:
>>>>> thermal thermal_zoneXX: failed to read out thermal zone (-19)
>>>>>
>>>>> But reading from an uninitialized power supply should not be
>>>>> considered as a fatal error, but the thermal core expects
>>>>> the -EAGAIN error to be returned in this particular case.
>>>>>
>>>>> So convert -ENODEV as -EAGAIN to express the fact that reading
>>>>> temperature from an uninitialized power supply shouldn't be
>>>>> a fatal error, but should indicate to the thermal zone it should
>>>>> retry later.
>>>>>
>>>>> It notably removes such messages on Qualcomm platforms using the
>>>>> qcom_battmgr driver spawning warnings until the aDSP firmware
>>>>> gets up and the battery manager reports valid data.
>>>>
>>>> Is it possible to have the aDSP firmware ready first ?
>>>
>>> I don't think so. ADSP firmware is a file, so as every firmware it can
>>> be loaded from rootfs, not initramfs (unlike this driver), or even 
>>> missing.
>>
>> Ok, said differently, can't we initialize the thermal zone after the 
>> firmware is loaded ?
> 
> This is the goal, but this can't be a fix but a proper rework.

Right, it is a design issue and we are finding this problem in several 
drivers using the thermal zone. Unfortunately that forces the thermal 
core to do cumbersome mechanisms because of this and obviously it is a 
friction for thermal core cleanups / rework. IOW, bad driver design => 
thermal core impacted.

> I think changing power_supply_core.c is not the right solution.

 From my POV, it is the right solution but I agree it could take a cycle 
or more to fix.

> qcom_battmgr_bat_get_property() should return -EAGAIN instead of
> -ENODEV.

Yes, we can do that in the first place and come back to solve this 
firmware / async issue in a more generic way later


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


