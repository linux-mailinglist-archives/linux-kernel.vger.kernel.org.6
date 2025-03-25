Return-Path: <linux-kernel+bounces-575367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5AA70191
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5B2188B505
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB68264629;
	Tue, 25 Mar 2025 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4ssI7pc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F81EBA1C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907106; cv=none; b=TVfNoCA641NI7jr8o0GtHttU4N+bhTU71+iXfFzO8IIJ+amIcTgYbJqjV/SOmdxF9BXenRLE88NKnqFy2esOhcE4zB9hxTC3Zrg2uLE5lQ1LGBSUPwjZtfjjb2YoRrM92DkUkHdkFBx+YBoGU8idcKPntGHg0UMthdoRaJBxI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907106; c=relaxed/simple;
	bh=U5iQrvSO5f5vLYmVeezXhJin4yQqUUq7t1+v3UPOdzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN5bf16beq5nd/6qyy/7enIWcchJZC6mvDt77twqrTlTt3lGrFyiooYOsXKnkBSK1m3tjfVVQhhjyZPNYTIBY40wU0LaYURGOFcqsdkI9ZrpCQySzfZmsvkLsrFCwx/wwNTxvXzMysDZtJpJltKbReC2WrAl4P6rpa0xsrr7i94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f4ssI7pc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so33687255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742907100; x=1743511900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRtKNqVWmSbvH/hB6VfWt31wHPCJGfHZAtYU9DtK8OA=;
        b=f4ssI7pclByZlvN7VtW+rV6w9/g9iS8V6AXXLgPzU7SBGr+JYlh6DX1XvwFaxVrCL/
         NaTQ9Uq0Iyx0vqG/LcvSrvx2NOnjR7y4DAcoJgt7UmtF3qv7XpjXAoGEJZn3sYyXpnjQ
         w7LVfrx45ILAbCYf6+G+1BZnhUzaVqHBUKWiL1p7vdHXG9D9OLNs00bmcoEZxHKE5X8V
         W4d3jY50Swli+a4mNyWz5VldAYWQxpZnldlQgGS/KM6omD2MQEg0dcZQwQn2s9Bt9J61
         q2RaKxqDHLjiFddTXYh0GN8eJryYwW8spjEs61k9xfC2fBOEmLdg/9wSSqhZEqI9fT6F
         TRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907100; x=1743511900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRtKNqVWmSbvH/hB6VfWt31wHPCJGfHZAtYU9DtK8OA=;
        b=Vypee5ZxL5hvZMQ1tS/8qp98z6xZP1scrF1OM5L7HaJCMEDoAZNbEmL5Z3V0EJpP7c
         nTla1N0wrJte86dn4W2wlHsFU+nYhzlffTTo3mvMHaIYyAoHu0wkOBxzfycx0+cuk0it
         P5ymcYzE4jNFkZbzUJNnR/SBryZpsEIS9i1Xxdwz5XqkbSqJRUcLlrs+yR5kJlyaJUi7
         EOGGkmx/32YsK/dcfA2MjU49px0uTYGQ0PbzofQSMwX7o8rYgg3UkzVOmWRdwbYdP+LH
         wdeE3PeZthf7cz5HPnTj7NLxia8PxK71yEabAgNU5an3dTwRnwUQ6nF8sHWvgaq8OJA4
         X0CQ==
X-Gm-Message-State: AOJu0YwEHEGGLux3N5shLk0hbWHzwY2zc3ywJh/bTl84W7x5LeJH+rvd
	kqaaGfYi1JAN4nmuJO8meuqJ/eF0hqN0HoSMAPukDgsE4mI1t1qAKrw/ngaXUeY=
X-Gm-Gg: ASbGncuNbEIkH48srp2nqS9SO98WNxDg98omDlmXIEWqKeoO5iT9SLbZNg2UIky7Is+
	Uoj6Uke+AA5p80Wepks4W2aQl3ynklOjE/Vuyyg+3vle97mrdPkEEyc6733RwyPSAvEcRuICM1C
	JaTdnS+9FSOvaRYR//eLa0JzYbKayV3WeS0AFxoWll2NqXREK7G19yFEczmxkvOm64SFk2RqFhz
	+Oc+0Tjq7dzmFOInOk64HY3de+FUiunFJe6DwwmU47OBbHq7oAAmY7FXBmV9WYceiKQ27LssSTU
	TKAkWGIeB/ganVszhLtyGXfasDx5cKZJ6bD0v8cfE5o8OVWJH2DZ+kLfT10xrT2zKj4YyFZsGRW
	JLBknLdJ7
X-Google-Smtp-Source: AGHT+IGuAoH/p1nMSeqv3bOifmTrMP/PnwzxrZnxOY/n0urwwA3R2/apocnxV/A6G60e0FGXp9uPtA==
X-Received: by 2002:a05:600c:1f92:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43d502e338emr131930175e9.5.1742907100288;
        Tue, 25 Mar 2025 05:51:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e960sm149122515e9.29.2025.03.25.05.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:51:39 -0700 (PDT)
Message-ID: <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
Date: Tue, 25 Mar 2025 13:51:37 +0100
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/03/2025 13:21, Ghennadi Procopciuc wrote:
> On 3/25/2025 2:09 PM, Daniel Lezcano wrote:
>> On 25/03/2025 12:40, Ghennadi Procopciuc wrote:
>>> On 3/25/2025 12:53 PM, Daniel Lezcano wrote:
>>> [ ... ]
>>>>>> +static int __init nxp_stm_clocksource_init(struct device *dev, const
>>>>>> char *name,
>>>>>> +                       void __iomem *base, struct clk *clk)
>>>>>> +{
>>>>>> +    struct stm_timer *stm_timer;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>>>>>> +    if (!stm_timer)
>>>>>> +        return -ENOMEM;
>>>>>> +
>>>>>> +    stm_timer->base = base;
>>>>>> +    stm_timer->rate = clk_get_rate(clk);
>>>>>> +
>>>>>> +    stm_timer->scs.cs.name = name;
>>>>>> +    stm_timer->scs.cs.rating = 460;
>>>>>> +    stm_timer->scs.cs.read = nxp_stm_clocksource_read;
>>>>>> +    stm_timer->scs.cs.enable = nxp_stm_clocksource_enable;
>>>>>> +    stm_timer->scs.cs.disable = nxp_stm_clocksource_disable;
>>>>>> +    stm_timer->scs.cs.suspend = nxp_stm_clocksource_suspend;
>>>>>> +    stm_timer->scs.cs.resume = nxp_stm_clocksource_resume;
>>>>>> +    stm_timer->scs.cs.mask = CLOCKSOURCE_MASK(32);
>>>>>> +    stm_timer->scs.cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>>>>>> +
>>>>>> +    ret = clocksource_register_hz(&stm_timer->scs.cs,
>>>>>> stm_timer->rate);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>
>>>>> clocksource_unregister during remove callback for cleanup?
>>>>
>>>> Sorry I don't get it :/
>>>>
>>>> There is no cleanup after the clocksource_register_hz() is successful
>>>>
>>>
>>> I noticed that other drivers, such as
>>> drivers/clocksource/timer-tegra186.c and
>>> drivers/clocksource/timer-sun5i.c, perform clocksource_unregister during
>>> their platform_driver.remove callback. Shouldn't this apply here as well?
>>
>> The tegra186 registers with one probe several timers and clocksources.
>> The timer-nxp probes for each node.
>>
>> The timer-sun5i.c has the remove callback but it is pointless as it can
>> not be compiled as module. So it should not have it.
>>
> 
> Ok.
> 
>>> [ ... ]
>>>>
>>>>>> +static int nxp_stm_clockevent_set_next_event(unsigned long delta,
>>>>>> struct clock_event_device *ced)
>>>>>> +{
>>>>>> +    struct stm_timer *stm_timer = ced_to_stm(ced);
>>>>>> +    u32 val;
>>>>>> +
>>>>>> +    nxp_stm_clockevent_disable(stm_timer);
>>>>>
>>>>> While examining the code base, I came across the
>>>>> drivers/clocksource/timer-imx-gpt.c file, specifically the
>>>>> mx1_2_set_next_event function, which includes a protection against
>>>>> missing events. Using a similar approach would allow us to keep the STM
>>>>> module enabled while only altering the channel's register state. This
>>>>> risk can also be mitigated by adjusting min_delta_ns based on tick
>>>>> frequency.
>>>>
>>>> How would you validate that ?
>>>>
>>>
>>> How would I validate that this works?
>>>
>>> If this is the question, I see that the core performs an auto adjustment
>>> of the minimum delta as part of the clockevents_program_min_delta
>>> function when CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST is enabled.
>>> Initially, I would examine how many times dev->set_next_event() returns
>>> -ETIME. At the end of the function, min_delta_ns should reflect the
>>> actual minimum delta the device can handle.
>>
>> That is an area of optimization and I would prefer to keep that as a
>> separate change focused on validating this approach.
>>
> 
> This suggestion supports the argument presented below.
> 
>>> [ ... ]
>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>>>>>> +{
>>>>>> +    struct device *dev = &pdev->dev;
>>>>>> +    struct device_node *np = dev->of_node;
>>>>>> +    struct stm_instances *stm_instances;
>>>>>> +    const char *name = of_node_full_name(np);
>>>>>> +    void __iomem *base;
>>>>>> +    int irq, ret;
>>>>>> +    struct clk *clk;
>>>>>> +
>>>>>> +    stm_instances =
>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>> +    if (!stm_instances) {
>>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>> +    if (IS_ERR(base)) {
>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>> +        return PTR_ERR(base);
>>>>>> +    }
>>>>>> +
>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>> +    if (irq <= 0) {
>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>>> +        return -EINVAL;
>>>>>> +    }
>>>>>
>>>>>    From commit description:
>>>>>
>>>>>> The first probed STM is used as a clocksource, the second will be the
>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>> affinity set to a CPU.
>>>>>
>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>> clocksource?
>>>>
>>>> It relies on the DT description and it does not hurt to have a
>>>> consistent code path for clockevent / clocksource even if the interrupt
>>>> is not requested for the clocksource later.
>>>>
>>>
>>> If so, in my opinion, it would make sense to use the same STM instance
>>> for both the clocksource and broadcast clockevent, as both functions can
>>> be accommodated within a single STM instance, which will help reduce the
>>> number of STM instances used.
>>
>> The broadcast timer is stopped when it is unused which is the case for
>> the s32 because there are no idle state powering down the local timers.
>> They have to have be separated.
>>
> 
> This wouldn't be the case if the STM is kept running/counting during the
> clock event setup, with only the clock event interrupt being disabled
> (CCR.CEN).

Are you asking to use two different channels for the same STM instance, 
one for the clocksource and one for the clockevent ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

