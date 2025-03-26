Return-Path: <linux-kernel+bounces-576714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F703A71376
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706EF177ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D91A707A;
	Wed, 26 Mar 2025 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5bQfAwH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778A82899
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980783; cv=none; b=cu1zhcLR0cN0YKnR5crFmJGirfgGyGfq0tBYGSecg7WrcADjVVF/8HI/ZrkJUNfHNTrgzNUIt20L4Jcxb0jQtX6N7t3XZhqx/iJrPy6tbWwhBRLAA9fzb3mIuZApSKrBq8fog0WA5OdzhRgma010zhDdGbdK3QKe6Nl+NaUED9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980783; c=relaxed/simple;
	bh=SRSKgVUXUp97N5+yTQ0t5LpSZ/wcBBdWg44qqjlKfqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubRPfAQw/yTlYkkfsMWztiMMsW5NdLcTgVdlQXHGrGfHc/F8CO7IqJ6YVptEPSD0nU28+jtge7CAEqFl5IhHTTd29YoFsjGCg+Dp85fTcxxOHBDatXKW+Z0CIr7/TK8xCVIKTno5JjYohmpE1O97Wf+Pj8db5W8W+kYP6D8ZHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z5bQfAwH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso44944755e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742980780; x=1743585580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QKKeBqHLdSDLp7AN8k5GvLjUGTP8nfJ4AzxgzYhyEo=;
        b=z5bQfAwHsuA18Fj4X4TprZsKq/7bIggTvpoMkR0Ih56xkDc+451gqPGlazMX1Wb3mU
         GjZaMSZLCwbAtKz9FgsiQ8v+p2PbnAwrK/r6QaSZyNAVjbvnd4oy5GTeyLrlIwrekQbF
         RoG8tiXoA1/m9UFGBFZKP/J/uwhgmV1aFJ46jzYriC5hJJcZbrK8TnCz0RVOBrZTQu1j
         hp9Wjjys6NeQzdcQikFvY7xHfdGGkFzg4tL+6L/297V/rUP1l2nd0NebDhgGTIWCt4sE
         pHyRE7iuGkePA5Qar5xHxgD23IHinEMxfFrrNs0cOnYzKQnDxtG5JZvD7wSrziac6Fq4
         bUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742980780; x=1743585580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QKKeBqHLdSDLp7AN8k5GvLjUGTP8nfJ4AzxgzYhyEo=;
        b=vo9uFffpUE3mLLGd80nDeLZxgJYgg531KNBCjtSG0Qlb5ZUBfVWYqdTcLpRs7VW1eT
         qMCgUGtpIzDoUd+ixRNFs/l59X1XHhCA3tDEfSFaMeIOE63qkADKUV5xT+L6F0Jmm5SY
         9pcxq3l3UDuQ0YGjHS65qWaAw+KdE78sxa6lDRDG6jVsdP8ciTg1MML8OZtHxQFfkRbx
         +FGOJUVHu7X3/jIzVJWO5tImP/I6wi3JRcWPP4Z+3jV2olqB/XYlODHnCNcAKJyeOhcL
         evYmRFXGLDedOl42AdD848m6yDLmvHIgrctxg4+sEfsqRKcoScUKSbDRE4BViEK25OeV
         KmUw==
X-Gm-Message-State: AOJu0YwraZ+xT+mQdsbA0T4NTc0Z+Xe7ZteU0wBuJODKKL5MH2pev1px
	glv0JiGhx9tZwvgbdbPHA64WK1LIe5VpycX0z/Hva2Vri6y6oafK5rzHZ035gJc=
X-Gm-Gg: ASbGncvYpctjO0oNroMZ47GSMwnadxgxTsp5R/s3qs9JZSvEwtdSTlU6tvZ6sXfKV1a
	1MMmn2aUdjMLWoiH89gkaG0TxnbREQt/4fNHO3tOYIirC5yd3NRs8Bi/ANgJ8iUkBdpFQX4smeN
	yasl9F0RFVBJt4mLqhZTEKv9KYQMj462rG1yW/yamR3CrX+IrOQWi5hJkXZmQl5TuovjXGJQfKc
	yXpW2YIrJdUErrYfq8s3ID0mvhBE63S2GtdHNHZLxbP5ZaQW52Of1ayegKOwZ0HSpG3r/rHbY2X
	o6R6bX3Dcx7aIe3AP65FBqXTT1BwfRMEq73YkRuFkmUcH/hijdrRPjQZScfZdCQPrMaGQ2myw0d
	dRgGtdFg+
X-Google-Smtp-Source: AGHT+IEUd9qei1H5Bs/jDi0MWXCcBq07B1C4ENdBfz4ea7omlBIKstcZNE7pR3Dh914VfRyiP9gQ0w==
X-Received: by 2002:a05:6000:2c2:b0:391:2df9:772d with SMTP id ffacd0b85a97d-3997f90f731mr19613529f8f.13.1742980779647;
        Wed, 26 Mar 2025 02:19:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d74b48b90sm28757745e9.14.2025.03.26.02.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:19:39 -0700 (PDT)
Message-ID: <f1268261-c900-4adc-aefe-795f23faba59@linaro.org>
Date: Wed, 26 Mar 2025 10:19:38 +0100
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
 <e8054f85-2a23-4ceb-8e1c-7cdfe7c87628@linaro.org>
 <a31a575b-8f6d-6317-f172-b4f8b1a5cda7@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a31a575b-8f6d-6317-f172-b4f8b1a5cda7@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2025 08:44, Ghennadi Procopciuc wrote:
> On 3/25/2025 3:54 PM, Daniel Lezcano wrote:
>> On 25/03/2025 14:21, Ghennadi Procopciuc wrote:
>>> On 3/25/2025 2:51 PM, Daniel Lezcano wrote:
>>> [ ... ]
>>>>>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device
>>>>>>>>>> *pdev)
>>>>>>>>>> +{
>>>>>>>>>> +    struct device *dev = &pdev->dev;
>>>>>>>>>> +    struct device_node *np = dev->of_node;
>>>>>>>>>> +    struct stm_instances *stm_instances;
>>>>>>>>>> +    const char *name = of_node_full_name(np);
>>>>>>>>>> +    void __iomem *base;
>>>>>>>>>> +    int irq, ret;
>>>>>>>>>> +    struct clk *clk;
>>>>>>>>>> +
>>>>>>>>>> +    stm_instances =
>>>>>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>>>>>> +    if (!stm_instances) {
>>>>>>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>>>>>> +    if (IS_ERR(base)) {
>>>>>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>>>>>> +        return PTR_ERR(base);
>>>>>>>>>> +    }
>>>>>>>>>> +
>>>>>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>>>>>> +    if (irq <= 0) {
>>>>>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>> +    }
>>>>>>>>>
>>>>>>>>>      From commit description:
>>>>>>>>>
>>>>>>>>>> The first probed STM is used as a clocksource, the second will be
>>>>>>>>>> the
>>>>>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>>>>>> affinity set to a CPU.
>>>>>>>>>
>>>>>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>>>>>> clocksource?
>>>>>>>>
>>>>>>>> It relies on the DT description and it does not hurt to have a
>>>>>>>> consistent code path for clockevent / clocksource even if the
>>>>>>>> interrupt
>>>>>>>> is not requested for the clocksource later.
>>>>>>>>
>>>>>>>
>>>>>>> If so, in my opinion, it would make sense to use the same STM
>>>>>>> instance
>>>>>>> for both the clocksource and broadcast clockevent, as both functions
>>>>>>> can
>>>>>>> be accommodated within a single STM instance, which will help reduce
>>>>>>> the
>>>>>>> number of STM instances used.
>>>>>>
>>>>>> The broadcast timer is stopped when it is unused which is the case for
>>>>>> the s32 because there are no idle state powering down the local
>>>>>> timers.
>>>>>> They have to have be separated.
>>>>>>
>>>>>
>>>>> This wouldn't be the case if the STM is kept running/counting during
>>>>> the
>>>>> clock event setup, with only the clock event interrupt being disabled
>>>>> (CCR.CEN).
>>>>
>>>> Are you asking to use two different channels for the same STM instance,
>>>> one for the clocksource and one for the clockevent ?
>>>>
>>>
>>> I suggested using the CNT register to obtain the count for the clock
>>> source, while using one of the STM channels for the clock event.
>>
>> Ah, ok.
>>
>> I think it is preferable to keep them separated to keep the code
>> modular. Given the number of STM on the platform, it does not hurt
>>
> 
> The S32G2 and S32G3 are SoCs featuring a diverse set of cores. Linux is
> expected to run on Cortex-A53 cores, while other software stacks will
> operate on Cortex-M cores. The number of STM instances has been sized to
> include at most one instance per core. Allocating six instances (1 clock
> source, 1 broadcast clock event, and 4 clock events for all A53 cores)
> to Linux on the S32G2 leaves the M7 software stacks without adequate STM
> coverage.

Given this description I'm wondering why one STM has to be used as a 
clocksource if the STM_07 is already a TS one. And also, we can get rid 
of the broadcast timer as there is no idle state forcing a switch to an 
always-on timer.

IIUC, on the S32g2 there are 4 x Cortex-A53 and 3 x Cortex-M3, that 
means we need 7 timers.

The system has 7 timers + a special one for timestamp.

So if I follow the reasoning, the broadcast timer should not be used 
otherwise one cortex-M3 will end up without a timer.

That leads us to one clocksource for the first per CPU timer initialized 
or alternatively one STM instance == 1 clocksource and 1 clockevent 
which makes things simpler


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

