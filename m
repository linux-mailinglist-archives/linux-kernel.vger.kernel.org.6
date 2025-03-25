Return-Path: <linux-kernel+bounces-575474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F991A70316
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44C7167AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889402571C1;
	Tue, 25 Mar 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vt4XbQFv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567F1DBB13
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910871; cv=none; b=edbRRBDNY2CJMtYzKsv2Rt0Zs0rSuznMJ+Y6zyAZAH2UBIp6/Cc0yhNEQQRjjz4anvm2LB8O9NtqkXTm7lUgf3+diUvIbIOcnlhZQG9lwWtPDkOIvR9t5qs6WsoPszgGRaF467GiD9cBs33ANWD3+cjLnMu5Zsq6LkdSqzDjBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910871; c=relaxed/simple;
	bh=vJ/5K4BDlhH3touEnlZQ3URo0OwsWOG2R2AtkPZJaJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGWbeqHzCV+a/nNjqeG6FrpVYi/ja3lOIx3QqBcXUExNzF0hn17FApQVoIZAsV972E2RDnCsGThgqWZA1F6abrlGCOlTxLObEpNK8Lgzzw/fwo/vZJmYvVTVzY26i85MIdBknpHiqlhdK03kx8TmiTkQ1kGO9R5B6Eh0LisS49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vt4XbQFv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0782d787so39998865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742910868; x=1743515668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijCZlw8abnNdrfWlLDyC8qGCl0jM46CNzFHxUo7UrwI=;
        b=vt4XbQFvfyLcujnSqO/uAJcJ7LvUxmexxZHmwkRE8pB6wPy6mLAQf1tpLjsqgqly8D
         juXMSETRU0uECM2swPqkXp4gbYobMB7qdXuLpwP8+UyowW9PftCC+Kg7oLhhA1xDdkOE
         l3EBXn4xp2eN03ahQ+9VGHvte7vMMTfUI0RRzWMI0yGF3hRs9NZbVPKvI8QofkLLL7oq
         wpV1+9MieNZytvSqLtKI42sw9TG9y9bMQmAoUZ4/pRNKaNSITBijawZYqBWp+dz35voM
         zm7m3tfgYO/k3KEyiKRLyP4tYwbgcrIg2X7pzg4lm7to98fuvJ8dVxu66a0c2APMjPoI
         xiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910868; x=1743515668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijCZlw8abnNdrfWlLDyC8qGCl0jM46CNzFHxUo7UrwI=;
        b=Vg8H3siSstIgY8/nJOBTrOzPRzScogRENZ71EGsuRkoNm6LTgAQNSc0XOie83sh6cv
         6McOBj7WMYoN6kpUzs0zmdjDwE5TBYCoyDYewq3WvsOE4xjRKuq7e3uUhOeAsJ693bka
         OZrTMlrMGeatFnEQaDvZ7iYJk8/IKUWFQXL7AUBvmp8LyP3sNMK3FI8f6oPuuI7U2qc1
         ynIdeReRNbIy6q4ayQmKZGVJ3uhV0vIvB0lD3jDrHiBJjM3aubqgKJEczzxSiwQO7q1t
         peJQxlwqAsYch8FIQqHwX+hvTupPEosTmasYvWTPHdqXJwGpDtQbCFdVQ+grKLpB/yCA
         dU1g==
X-Gm-Message-State: AOJu0YyMZH4v3cccH2rwyFPI6skxJBfdjR7JhlzxquHO9iFBd/RzIq7K
	cm+TluQ+alXrxMzqPNE7qJkH2BmKyP0pLc6k4T1FosahEeog9gVSJnLJoffElVxihmnBrQtUGMG
	L
X-Gm-Gg: ASbGnctFQEnVFtrhopbaJhTAScNchBquMOf160Nbg29fN/dcWXEr8szC7roH8k96MTI
	QhOJRtGFUUPY1p1XaKJndMVJvPAkI5CSP/FgozKc4jszH3p7DmD2kWAt20nhf69ooWTCXGUzmmC
	kf0KPYn3Q2FMNqOrE8i2iPn3UUFepFXNq9CQNeN8ySunpaaeA3ULCT66m3z+XQKpZMkIxzjf7Of
	IfDGo1Sivx/C0szO/6JEW/dz0H44Uua8zwl8QWtuftO0Pkj453fivIkalG2nELcozbK1dNbflTy
	1rtlWmDZWn7vitH5OYwRTUVo6H+fgZhcfBa8wQj49oEJmHwMBmbjkqngEAve/jHU3W0NX3YF0l7
	C/2N0j0VGCwvavkHSGgI=
X-Google-Smtp-Source: AGHT+IFxtTjkR1rjlcOGc3o02TWz8/EihwAEdC3O1L0fXu9zmvxKQn66+P0PWx+0RFvFRJ5mc4A03Q==
X-Received: by 2002:a05:6000:1fa4:b0:391:952:c758 with SMTP id ffacd0b85a97d-3997f8f78a9mr13996895f8f.6.1742910868103;
        Tue, 25 Mar 2025 06:54:28 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d4fd18505sm150051955e9.11.2025.03.25.06.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 06:54:27 -0700 (PDT)
Message-ID: <e8054f85-2a23-4ceb-8e1c-7cdfe7c87628@linaro.org>
Date: Tue, 25 Mar 2025 14:54:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP S32 Linux Team <s32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
 <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
 <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
 <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
 <50d2c651-746e-4ddd-4036-f72742a622f8@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <50d2c651-746e-4ddd-4036-f72742a622f8@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/03/2025 14:21, Ghennadi Procopciuc wrote:
> On 3/25/2025 2:51 PM, Daniel Lezcano wrote:
> [ ... ]
>>>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>>>>>>>> +{
>>>>>>>> +    struct device *dev = &pdev->dev;
>>>>>>>> +    struct device_node *np = dev->of_node;
>>>>>>>> +    struct stm_instances *stm_instances;
>>>>>>>> +    const char *name = of_node_full_name(np);
>>>>>>>> +    void __iomem *base;
>>>>>>>> +    int irq, ret;
>>>>>>>> +    struct clk *clk;
>>>>>>>> +
>>>>>>>> +    stm_instances =
>>>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>>>> +    if (!stm_instances) {
>>>>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>>>>> +        return -EINVAL;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>>>> +    if (IS_ERR(base)) {
>>>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>>>> +        return PTR_ERR(base);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>>>> +    if (irq <= 0) {
>>>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>>>>> +        return -EINVAL;
>>>>>>>> +    }
>>>>>>>
>>>>>>>     From commit description:
>>>>>>>
>>>>>>>> The first probed STM is used as a clocksource, the second will be
>>>>>>>> the
>>>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>>>> affinity set to a CPU.
>>>>>>>
>>>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>>>> clocksource?
>>>>>>
>>>>>> It relies on the DT description and it does not hurt to have a
>>>>>> consistent code path for clockevent / clocksource even if the
>>>>>> interrupt
>>>>>> is not requested for the clocksource later.
>>>>>>
>>>>>
>>>>> If so, in my opinion, it would make sense to use the same STM instance
>>>>> for both the clocksource and broadcast clockevent, as both functions
>>>>> can
>>>>> be accommodated within a single STM instance, which will help reduce
>>>>> the
>>>>> number of STM instances used.
>>>>
>>>> The broadcast timer is stopped when it is unused which is the case for
>>>> the s32 because there are no idle state powering down the local timers.
>>>> They have to have be separated.
>>>>
>>>
>>> This wouldn't be the case if the STM is kept running/counting during the
>>> clock event setup, with only the clock event interrupt being disabled
>>> (CCR.CEN).
>>
>> Are you asking to use two different channels for the same STM instance,
>> one for the clocksource and one for the clockevent ?
>>
> 
> I suggested using the CNT register to obtain the count for the clock
> source, while using one of the STM channels for the clock event.

Ah, ok.

I think it is preferable to keep them separated to keep the code 
modular. Given the number of STM on the platform, it does not hurt

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

