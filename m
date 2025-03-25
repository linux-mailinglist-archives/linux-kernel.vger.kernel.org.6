Return-Path: <linux-kernel+bounces-575270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF94DA6FACA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4BA1888D54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A72566EA;
	Tue, 25 Mar 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REQgcK0X"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452918E34A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904573; cv=none; b=dPBI1kGCcMN68Gg/ziSIhm/gZ3E+S1LKMfOKqp3Em6jEywopriHfdxJU6phhFL+dKwOAC86JTKm879kAeGlPjeelsrczJbq2fatuWAfEiI20UvsvetfpgcgonpMxxCfQrZu96WYsxNaVZ3L68Os35v7dn1PnUYfy5BuJ0aGEz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904573; c=relaxed/simple;
	bh=ljzilcbGRB0nzqLFRAsu1GOab0zvqE7k9vdxvGhd9Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhnAQCeiybpASp1cpa5UfdnyOuihOUqnuDyhxUti8Kb6N3zo4CjcgObr9ILGxiLFQVuLwFtUYQelO3LCtL8P1xd++xDWj3mvOdy90Ae2UgOosEMX52o+/iVNHmAKkNbix7OiIEUN892A2+iJurqxrDvh3GJDXDJ3ViDrP1J4ajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=REQgcK0X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso38723105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742904569; x=1743509369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARk/2qD3B4yeKBJrJ3RO2HvqNw7n1OqVVP/7taXakjQ=;
        b=REQgcK0Xf1+akk4ChZgMjw3fS8tMGtoCH48keizT2P5JgU7N0RsXQE6RCddkJD8ETP
         0dqzNe6XdqOBDHZh3kPVOWu9sdJFOs8krklQOvvE/HxCb5eFq/sTALBRW5LpjRIXmDif
         l2Np4UCuSSTa3SCajKjdxRZweUKkzD0vmuWwHllUjD/5QkhMG8XmLmZpOFbnBSxvxFK+
         eXlW3I09h4GI3Ui+0qKAuHg9MjMX3XIZHLsN18r5EC8af5ZLa7P2Y3nlcE8GzWWTjeFa
         PM6koTYETnzng1kzXxrH3GabZj4UVmgiF3e9H1/seuYN+e1zyJ0oCcFkILLAKjNhB7U4
         55EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742904569; x=1743509369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARk/2qD3B4yeKBJrJ3RO2HvqNw7n1OqVVP/7taXakjQ=;
        b=LpywStbcOnpvRll00zhziT3KuEafOT8PCwMKmMd+/VbxC1KeBn1GG0v3CRUCvMdLIE
         LQO49IqSVWpZtP2UFNZNfBhz2ChuTscFy8amh3s/hWT30ADp9Lk7p70wHdw5HPwtrodS
         EEBiOCHqxqNxkUD4hQ/fXPYOPi9AsaDonyHc1PMRi9dm1NMQdKCWbe0n4uGtSHFhZ1Ge
         5iqUBm1Ph9lMWNe71GV8an//z5f6J8Z2h2H3qEBNEHPG2Trf0zzeGpMBY8uRm7nU9Q3T
         MjfQWfOtqpk2yqPGexilYIrJKFtkrqVlYTQuN5Prtw7Izpqxq3fNvklL58C4hX6zMqif
         78Tg==
X-Gm-Message-State: AOJu0YzGYUNYJ9OqETNzd7BRrYddlbkgT9jtJFAt+H5qL/oRbbOrwTla
	plY3k4N0QmxPfOsqfLAYiQFz1IxA0qv92yl8p1f7+r4ZSMMelJunuB8eVaZmxag=
X-Gm-Gg: ASbGncuH64aCjQH9uJ1+CnIae8YPIgcbxHuTpAPD+PsKY0w1MmLq1bvrMqAe/f2bKfn
	4/osESG2SO5uqgm8DHVmjUiDOp2OQFAV6T8uFDEKEMP/yWL6flsx/vxIvnuM5wkICAw3+1EurMk
	zzSwnUZWdJjWr9D+q1O/ALD6hnc5paw5rRe/16k7x9hwUTQ1/rvSEo7dfVltvl7DgwTB8Rl7Oln
	p14+ARdPiIg+lXIFjzPFFq3jKY7OIypG8Suon8x/Con6S+K3Po/Ztxwk0sfXRq7I9AcQ4BlBVZt
	n/+MLmQN7upqCdlXGPbOOqH7VU5QrM8ZGC+cqQNcocLPzuYZZCKcaLfQkmHvmHGoN3HFYnBKdid
	gXur2hZWP
X-Google-Smtp-Source: AGHT+IFBskiUUo+unot0SkV98dwQ4vT5wISCZj5gpa4ljqIKxNqSBAYOzS1BvS0WNWyEBmzZqIRDIw==
X-Received: by 2002:a05:6000:178c:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-3997f900c60mr12951478f8f.1.1742904569413;
        Tue, 25 Mar 2025 05:09:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39abdaf0c0bsm9161805f8f.63.2025.03.25.05.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:09:28 -0700 (PDT)
Message-ID: <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
Date: Tue, 25 Mar 2025 13:09:28 +0100
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
 <linux-arm-kernel@lists.infradead.org>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/03/2025 12:40, Ghennadi Procopciuc wrote:
> On 3/25/2025 12:53 PM, Daniel Lezcano wrote:
> [ ... ]
>>>> +static int __init nxp_stm_clocksource_init(struct device *dev, const
>>>> char *name,
>>>> +                       void __iomem *base, struct clk *clk)
>>>> +{
>>>> +    struct stm_timer *stm_timer;
>>>> +    int ret;
>>>> +
>>>> +    stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>>>> +    if (!stm_timer)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    stm_timer->base = base;
>>>> +    stm_timer->rate = clk_get_rate(clk);
>>>> +
>>>> +    stm_timer->scs.cs.name = name;
>>>> +    stm_timer->scs.cs.rating = 460;
>>>> +    stm_timer->scs.cs.read = nxp_stm_clocksource_read;
>>>> +    stm_timer->scs.cs.enable = nxp_stm_clocksource_enable;
>>>> +    stm_timer->scs.cs.disable = nxp_stm_clocksource_disable;
>>>> +    stm_timer->scs.cs.suspend = nxp_stm_clocksource_suspend;
>>>> +    stm_timer->scs.cs.resume = nxp_stm_clocksource_resume;
>>>> +    stm_timer->scs.cs.mask = CLOCKSOURCE_MASK(32);
>>>> +    stm_timer->scs.cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>>>> +
>>>> +    ret = clocksource_register_hz(&stm_timer->scs.cs, stm_timer->rate);
>>>> +    if (ret)
>>>> +        return ret;
>>>
>>> clocksource_unregister during remove callback for cleanup?
>>
>> Sorry I don't get it :/
>>
>> There is no cleanup after the clocksource_register_hz() is successful
>>
> 
> I noticed that other drivers, such as
> drivers/clocksource/timer-tegra186.c and
> drivers/clocksource/timer-sun5i.c, perform clocksource_unregister during
> their platform_driver.remove callback. Shouldn't this apply here as well?

The tegra186 registers with one probe several timers and clocksources. 
The timer-nxp probes for each node.

The timer-sun5i.c has the remove callback but it is pointless as it can 
not be compiled as module. So it should not have it.

> [ ... ]
>>
>>>> +static int nxp_stm_clockevent_set_next_event(unsigned long delta,
>>>> struct clock_event_device *ced)
>>>> +{
>>>> +    struct stm_timer *stm_timer = ced_to_stm(ced);
>>>> +    u32 val;
>>>> +
>>>> +    nxp_stm_clockevent_disable(stm_timer);
>>>
>>> While examining the code base, I came across the
>>> drivers/clocksource/timer-imx-gpt.c file, specifically the
>>> mx1_2_set_next_event function, which includes a protection against
>>> missing events. Using a similar approach would allow us to keep the STM
>>> module enabled while only altering the channel's register state. This
>>> risk can also be mitigated by adjusting min_delta_ns based on tick
>>> frequency.
>>
>> How would you validate that ?
>>
> 
> How would I validate that this works?
> 
> If this is the question, I see that the core performs an auto adjustment
> of the minimum delta as part of the clockevents_program_min_delta
> function when CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST is enabled.
> Initially, I would examine how many times dev->set_next_event() returns
> -ETIME. At the end of the function, min_delta_ns should reflect the
> actual minimum delta the device can handle.

That is an area of optimization and I would prefer to keep that as a 
separate change focused on validating this approach.

> [ ... ]
>>>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct device *dev = &pdev->dev;
>>>> +    struct device_node *np = dev->of_node;
>>>> +    struct stm_instances *stm_instances;
>>>> +    const char *name = of_node_full_name(np);
>>>> +    void __iomem *base;
>>>> +    int irq, ret;
>>>> +    struct clk *clk;
>>>> +
>>>> +    stm_instances =
>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>> +    if (!stm_instances) {
>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>> +    if (IS_ERR(base)) {
>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>> +        return PTR_ERR(base);
>>>> +    }
>>>> +
>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>> +    if (irq <= 0) {
>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>> +        return -EINVAL;
>>>> +    }
>>>
>>>   From commit description:
>>>
>>>> The first probed STM is used as a clocksource, the second will be the
>>>> broadcast timer and the rest are used as a clockevent with the
>>>> affinity set to a CPU.
>>>
>>> Why is the interrupt mandatory when the node is probed as a clocksource?
>>
>> It relies on the DT description and it does not hurt to have a
>> consistent code path for clockevent / clocksource even if the interrupt
>> is not requested for the clocksource later.
>>
> 
> If so, in my opinion, it would make sense to use the same STM instance
> for both the clocksource and broadcast clockevent, as both functions can
> be accommodated within a single STM instance, which will help reduce the
> number of STM instances used.

The broadcast timer is stopped when it is unused which is the case for 
the s32 because there are no idle state powering down the local timers. 
They have to have be separated.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

