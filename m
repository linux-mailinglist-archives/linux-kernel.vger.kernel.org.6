Return-Path: <linux-kernel+bounces-575340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA413A6FFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD1D17A6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB526772D;
	Tue, 25 Mar 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAkcAUxi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A425A62E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905834; cv=none; b=HNTwG/4DCaJ0XK3wGngmrSKvac169QiwNC3oG9HXJBCMV3s95JNtL3bpZV5G+tjEbPnYfU9pogCfqobSm6Tjy9pUY6jAv156m1FwM+ZXhEyy3gYh4u8wp96FEMwl5z2EVQSJDm5jR5ZlwexsGYlabO7KW7y1mz2LQTaLa3uEt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905834; c=relaxed/simple;
	bh=2FQkQy8F48v0kwvvmmEiDNrD3XQsRtCKKA0DgUqJCPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FET1KrI1pU8/r0UVFOLMOoRQk+6UqLW3dk+28L+1yLK98qA77F9iY4dgrXtk5UVmPsgbdt3y2RCqCcJQefBKrnXhAtx039T8SUXnziQosjin+5Mxz3s+0bIICdiP/ZOKCT4e5jdxCrprZYruaM8i5Qz2wMi8uqKiGBox3cNvctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAkcAUxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32367C4CEE4;
	Tue, 25 Mar 2025 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905834;
	bh=2FQkQy8F48v0kwvvmmEiDNrD3XQsRtCKKA0DgUqJCPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IAkcAUxiwAVkDX91WD4WAbpZ/pjLxaCI73yzBO98n/JPN/C7f4Vm99zoNAvi0Q+TM
	 hDa5bTbHNw22kGjCcY2lKzNL7U340KHn39gesTGo2IwDbpkjdjrHaslEGkVL/SF8u0
	 KKEjiboCgRwkRPLcOHEdXrZ+VlRPztgx9aNrOCYMiTLeoK151wj5+RwBd9ENZMnNnh
	 qdhNXLzl2hHK0pJccisCyirUdVJuWTNMQ1dgjhbTD8wh0N32jNAKJ7m4S5Cw7alkhn
	 UX37HrRDY03nsWwvrPpMt3sz4Kp9NvY0UH1DClVfkNp0wUF5Ay98GVr2CaZbiE1qjG
	 T8TI5FxdlQ5NA==
Message-ID: <9ca80442-15c8-4f2d-ac11-8096b2cd83ad@kernel.org>
Date: Tue, 25 Mar 2025 13:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <bb7e4740-9608-4534-9c19-3ac066e2aa8f@kernel.org>
 <1bf2d9ad-325e-4b1d-8440-ddbc90eabc67@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <1bf2d9ad-325e-4b1d-8440-ddbc90eabc67@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 13:23, Daniel Lezcano wrote:
> 
> [Added s32@ list which I miss from the initial series]
> 
> On 25/03/2025 08:30, Krzysztof Kozlowski wrote:
>> On 24/03/2025 11:00, Daniel Lezcano wrote:
>>> +
>>> +static int __init nxp_stm_clocksource_init(struct device *dev, const char *name,
>>> +					   void __iomem *base, struct clk *clk)
>>> +{
>>> +	struct stm_timer *stm_timer;
>>> +	int ret;
>>> +
>>> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>>> +	if (!stm_timer)
>>> +		return -ENOMEM;
>>> +
>>> +	stm_timer->base = base;
>>> +	stm_timer->rate = clk_get_rate(clk);
>>> +
>>> +	stm_timer->scs.cs.name = name;
>>
>> You are aware that all node names will have exactly the same name? All
>> of them will be called "timer"?
> 
>  From the caller const char *name = of_node_full_name(np);

Ah, right, it's the full name.

> 
> The names are:
> 
> "clocksource: Switched to clocksource stm@4011c000"
> 
> Or:
> 
>   17:      24150          0          0          0    GICv3  57 Level 
> stm@40120000

This all will be timer@, but anyway I get your point.

>   18:          0      22680          0          0    GICv3  58 Level 
> stm@40124000
>   19:          0          0      24110          0    GICv3  59 Level 
> stm@40128000
>   20:          0          0          0      21164    GICv3  60 Level 
> stm@4021c000
> 
> And:
> 
> cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> stm@4011c000
> 
> cat /sys/devices/system/clockevents/clockevent*/current_device
> stm@40120000
> stm@40124000
> stm@40128000
> stm@4021c000

Ack

> 
> [ ... ]
> 
>>> +
>>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *np = dev->of_node;
>>> +	struct stm_instances *stm_instances;
>>> +	const char *name = of_node_full_name(np);
>>> +	void __iomem *base;
>>> +	int irq, ret;
>>> +	struct clk *clk;
>>> +
>>> +	stm_instances = (typeof(stm_instances))of_device_get_match_data(dev);
>>
>> No, you *cannot* drop the const. It's there on purpose. Match data
>> should be const because it defines per variant differences. That's why
>> the prototype of of_device_get_match_data() has such return type.
>> You just want some global singleton, not match data.
>>
>>> +	if (!stm_instances) {
>>> +		dev_err(dev, "No STM instances associated with a cpu");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	base = devm_of_iomap(dev, np, 0, NULL);
>>> +	if (IS_ERR(base)) {
>>> +		dev_err(dev, "Failed to iomap %pOFn\n", np);
>>
>> You need to clean up the downstream code to match upstream. All of these
>> should be return dev_err_probe().
> 
> Oh right, thanks for the reminder
> 
>>> +		return PTR_ERR(base);
>>> +	}
>>> +
>>> +	irq = irq_of_parse_and_map(np, 0);
>>> +	if (irq <= 0) {
>>> +		dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	clk = devm_clk_get(dev, NULL);
>>> +	if (IS_ERR(clk)) {
>>> +		dev_err(dev, "Clock not found\n");
>>
>> And this is clearly incorrect - spamming logs. Syntax is:
>> return dev_err_probe
>>
>>> +		return PTR_ERR(clk);
>>> +	}
>>> +
>>> +	ret = clk_prepare_enable(clk);
>>
>> Drop, devm_clk_get_enabled.
>>
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to enable STM timer clock: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (!stm_instances->clocksource && (stm_instances->features & STM_CLKSRC)) {
>>> +
>>> +		/*
>>> +		 * First probed STM will be a clocksource
>>> +		 */
>>> +		ret = nxp_stm_clocksource_init(dev, name, base, clk);
>>> +		if (ret)
>>> +			return ret;
>>> +		stm_instances->clocksource++;
>>
>> That's racy. Devices can be brought async, ideally. This should be
>> rather idr or probably entire structure protected with a mutex.
> 
> Mmh, interesting. I never had to think about this problem before
> 
> Do you know at what moment the probing is parallelized ?

You don't have PROBE_PREFER_ASYNCHRONOUS, so currently this will be
still sync, but I don't think we want it to be that way forever. I think
new drivers should not rely on implicit sync, because converting it
later to async will be difficult. It's easier to design it now or even
choose async explicitly (after testing).

BTW, PREEMPT_RT and all fast-boot-use-cases would be only happier with
probe being async.


Best regards,
Krzysztof

