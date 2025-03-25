Return-Path: <linux-kernel+bounces-575145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F22A6EE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFE3B5146
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0B1F1305;
	Tue, 25 Mar 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8VX076G"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC8EC4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900005; cv=none; b=nBLHVnHuUAcXET3C0oovUxCF55d/uHdJ1oJCJbCKy1ipFI0cf4Jn1QuCY27884BHolA3c3Xd/fcGXkK53flVNTZ3fCp/4puqBIkueArcpbMQgTqyL3zyKqAnkwZbQcCLB9jeQfwiuRKaodiGWmu7JIYwB82drMPWpQ1WjbAgKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900005; c=relaxed/simple;
	bh=uCRwWVRTZ9wFar0Edeu9pLVX+bytZjgPwj7L9nuw9rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svaX1KY6bJRtfQM+N/R2mKBU+QgJh12SOAzp2/J5iYImKTAnBXPbJlOwCkpGxELZ68QkIMALbjZkzc+jYd6yyzRLb7H3tbNPJ/aV40ikGSqZoEPHaxDvnrP1KjOURj0pprgc2fbKl5q+N2oPqOig8qwz0jU169BvjgrkSTGWzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C8VX076G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so37085805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742900002; x=1743504802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMQzkzaFSuyekUR/FYFhcWqSgLmiNobKxeZ/ukBdnew=;
        b=C8VX076G0lrcynPF6EFYiHPLCSXgY4zhZHaLDSo4xFQabEYVLmiVPWcT34882h9dc0
         dae+vtgp1ray8PgaG6FR+8bQjGSlYV30VDFAEpNG4YXMRJvw78gaQTj65lR/XMo6ntIU
         8aDPp83QbNxe0CTmadOkQ33J29Cem/YF0YzEC0jGwpvgwvWTfRqmEeyaBrGBlb4XPD7j
         rKSBERF74bGmU+YG4iTihIxKnp4KZHsCM7B3A5iSLujk65k8TPb9HA7KXGbIB8HoJX2U
         UGYzCjUzX599joWtZSd8RkjKoJCd1en+NtpCQr1wYYBPO7siBYEVxOzsbtGK5smDV1nL
         ezbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900002; x=1743504802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMQzkzaFSuyekUR/FYFhcWqSgLmiNobKxeZ/ukBdnew=;
        b=MXdDWNXJ8YldOYCKlOH76mBXtwlQdL/0rqsXc8LdSKoNfwfBkvOTc0IQhVfz+k6Xhj
         Ux8Q7UTrLHKH5l3wISWvbyyNh1JVUJrq0HRJxknwFKSitLFbAb6wTudcPx1Yet5H0L77
         7+Q9yqO/Tgsjdg+nEYczfAUuf962z7yC/sSWRwjrhCtSnh333qw7bJzcs3mbMm2E7OLm
         8SzeZ/0Cklm7hcdaj9sGKpocHK/Pr2PHFAsgEAsO/CAYz8Uy9YO1VwwiKbHyGz64pbdo
         KgC9+kRZaQH0L3XDyVoPz6FaAJR8HEPWu+AXp79z1R+jQkIUKCIQJe7zbKIl21q7ZqDY
         +egQ==
X-Gm-Message-State: AOJu0YwPswysjG5PfudQ9GRtMNwZPoFnX8SkYxW+sCGw9esSt1vSyEJg
	t3uhmken3ja+5Tf9Ha8Bfd0GGbsI167dowQmiArYqKDDR45DLfL68Yyqi3scXtg=
X-Gm-Gg: ASbGncv9VujSB54MsUbZPHY2xVYeT45uj3lkkM1F+Xx3Kj411zOiY1CoWPvr4RRKlTr
	+z5MIU781gtRgdSwWG/rbGlWKNkV2KzcebUrp8cz5aj98l+5uENBeRmlPBvfXPf3w2PCTZd1h9i
	hATbyOG+q5l4+/OqXnen/RL3M93P1KIqKlZdd9KxIAJx8siljuuZEzCmpSEISPSBU0Ei8Pgx2mm
	VpwYV3N2UnThFezrvbou7axbC8KebXQGGkgibJkYxIKE/kIJt+vqgEhP3ux2ad+1KjHKsA+FAUX
	hOgwhqA0BuyfFxCR6+zjhiMvOR3R0t8goAX9M7slod4tMm+Klp6EVsB/eSLk8f6oGoMJFUSWzjM
	+kpxkjZZH
X-Google-Smtp-Source: AGHT+IEgpp59NjoNSFfPPCPKdn9PH7nepoW9vULCdDgObFyn5ZHMxYqUaIM5iFfr41i+dCjijBMgsA==
X-Received: by 2002:a05:600c:5021:b0:43d:1c3:cb2e with SMTP id 5b1f17b1804b1-43d509f6788mr169590225e9.17.1742900001669;
        Tue, 25 Mar 2025 03:53:21 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d6eab2466sm9876525e9.1.2025.03.25.03.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 03:53:21 -0700 (PDT)
Message-ID: <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
Date: Tue, 25 Mar 2025 11:53:20 +0100
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Ghennadi,

thanks for the review


On 25/03/2025 08:28, Ghennadi Procopciuc wrote:

[ ... ]

>> +static int __init nxp_stm_clocksource_init(struct device *dev, const char *name,
>> +					   void __iomem *base, struct clk *clk)
>> +{
>> +	struct stm_timer *stm_timer;
>> +	int ret;
>> +
>> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>> +	if (!stm_timer)
>> +		return -ENOMEM;
>> +
>> +	stm_timer->base = base;
>> +	stm_timer->rate = clk_get_rate(clk);
>> +
>> +	stm_timer->scs.cs.name = name;
>> +	stm_timer->scs.cs.rating = 460;
>> +	stm_timer->scs.cs.read = nxp_stm_clocksource_read;
>> +	stm_timer->scs.cs.enable = nxp_stm_clocksource_enable;
>> +	stm_timer->scs.cs.disable = nxp_stm_clocksource_disable;
>> +	stm_timer->scs.cs.suspend = nxp_stm_clocksource_suspend;
>> +	stm_timer->scs.cs.resume = nxp_stm_clocksource_resume;
>> +	stm_timer->scs.cs.mask = CLOCKSOURCE_MASK(32);
>> +	stm_timer->scs.cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
>> +
>> +	ret = clocksource_register_hz(&stm_timer->scs.cs, stm_timer->rate);
>> +	if (ret)
>> +		return ret;
> 
> clocksource_unregister during remove callback for cleanup?

Sorry I don't get it :/

There is no cleanup after the clocksource_register_hz() is successful

>> +
>> +	stm_sched_clock = stm_timer;
>> +
>> +	sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
>> +
>> +	dev_set_drvdata(dev, stm_timer);
> 
> Is this used?

Nope, I'll remove it.

>> +
>> +	dev_dbg(dev, "Registered clocksource %s\n", name);
>> +
>> +	return 0;
>> +}

[ ... ]

>> +static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct clock_event_device *ced)
>> +{
>> +	struct stm_timer *stm_timer = ced_to_stm(ced);
>> +	u32 val;
>> +
>> +	nxp_stm_clockevent_disable(stm_timer);
> 
> While examining the code base, I came across the
> drivers/clocksource/timer-imx-gpt.c file, specifically the
> mx1_2_set_next_event function, which includes a protection against
> missing events. Using a similar approach would allow us to keep the STM
> module enabled while only altering the channel's register state. This
> risk can also be mitigated by adjusting min_delta_ns based on tick
> frequency.

How would you validate that ?


>> +	stm_timer->sce.delta = delta;
>> +
>> +	val = nxp_stm_clockevent_read_counter(stm_timer) + delta;
>> +
>> +	writel(val, stm_timer->base + STM_CHANNEL(0) + STM_CMP);
>> +
>> +	nxp_stm_clockevent_enable(stm_timer);
>> +
>> +	return 0;
>> +}
>> +
>> +static int nxp_stm_clockevent_set_periodic(struct clock_event_device *ced)
>> +{
>> +	struct stm_timer *stm_timer = ced_to_stm(ced);
>> +
>> +        return nxp_stm_clockevent_set_next_event(stm_timer->rate, ced);
>> +}
>> +
>> +static int __init nxp_stm_clockevent_broadcast_init(struct device *dev, const char *name, void __iomem *base,
>> +						    int irq, struct clk *clk)
>> +{
>> +	struct stm_timer *stm_timer;
>> +	int ret;
>> +
>> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>> +	if (!stm_timer)
>> +		return -ENOMEM;
>> +
>> +	stm_timer->base = base;
>> +	stm_timer->rate = clk_get_rate(clk);
>> +
>> +	stm_timer->sce.ced.name = name;
>> +	stm_timer->sce.ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> +	stm_timer->sce.ced.set_state_shutdown = nxp_stm_clockevent_shutdown;
>> +	stm_timer->sce.ced.set_state_periodic = nxp_stm_clockevent_set_periodic;
>> +	stm_timer->sce.ced.set_next_event = nxp_stm_clockevent_set_next_event;
>> +	stm_timer->sce.ced.cpumask = cpu_possible_mask;
>> +	stm_timer->sce.ced.rating = 460;
>> +	stm_timer->sce.ced.irq = irq;
>> +
>> +	nxp_stm_clockevent_irq_clr(stm_timer);
>> +
>> +	ret = request_irq(irq, nxp_stm_clockevent_interrupt,
>> +			  IRQF_TIMER | IRQF_NOBALANCING, name, &stm_timer->sce.ced);
>> +	if (ret) {
>> +		dev_err(dev, "Unable to allocate interrupt line: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	clockevents_config_and_register(&stm_timer->sce.ced, stm_timer->rate, 1, 0xffffffff);
>> +
>> +	dev_dbg(dev, "Registered broadcast clockevent %s irq=%d\n", name, irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, const char *name, void __iomem *base,
>> +						  int irq, struct clk *clk, int cpu)
>> +{
> 
> This function duplicates a significant portion of the previous one. To
> avoid code duplication, it would be beneficial to extract the common
> part into a dedicated function.

Sure

>> +	struct stm_timer *stm_timer;
>> +	int ret;
>> +
>> +	stm_timer = devm_kzalloc(dev, sizeof(*stm_timer), GFP_KERNEL);
>> +	if (!stm_timer)
>> +		return -ENOMEM;
>> +
>> +	stm_timer->base = base;
>> +	stm_timer->rate = clk_get_rate(clk);
>> +
>> +	stm_timer->sce.ced.name = name;
>> +	stm_timer->sce.ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> +	stm_timer->sce.ced.set_state_shutdown = nxp_stm_clockevent_shutdown;
>> +	stm_timer->sce.ced.set_state_periodic = nxp_stm_clockevent_set_periodic;
>> +	stm_timer->sce.ced.set_next_event = nxp_stm_clockevent_set_next_event;
>> +	stm_timer->sce.ced.cpumask = cpumask_of(cpu);
>> +	stm_timer->sce.ced.rating = 460;
>> +	stm_timer->sce.ced.irq = irq;
>> +
>> +	nxp_stm_clockevent_irq_clr(stm_timer);
>> +
>> +	ret = request_irq(irq, nxp_stm_clockevent_interrupt,
>> +			  IRQF_TIMER | IRQF_NOBALANCING, name, &stm_timer->sce.ced);
> 
> devm_request_irq instead ?

Yes

>> +	if (ret) {
>> +		dev_err(dev, "Unable to allocate interrupt line: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	per_cpu(stm_timers, cpu) = stm_timer;
>> +
>> +	dev_dbg(dev, "Initialized per cpu clockevent name=%s, irq=%d, cpu=%d\n", name, irq, cpu);
>> +
>> +	return 0;
>> +}
>> +
>> +static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
>> +{
>> +	struct stm_timer *stm_timer = per_cpu(stm_timers, cpu);
>> +	int ret;
>> +
>> +	if (WARN_ON(!stm_timer))
>> +		return -EFAULT;
>> +
>> +	ret = irq_force_affinity(stm_timer->sce.ced.irq, cpumask_of(cpu));
>> +	if (ret)
>> +		return ret;
>> +
>> +	clockevents_config_and_register(&stm_timer->sce.ced, stm_timer->rate, 1, 0xffffffff);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct stm_instances *stm_instances;
>> +	const char *name = of_node_full_name(np);
>> +	void __iomem *base;
>> +	int irq, ret;
>> +	struct clk *clk;
>> +
>> +	stm_instances = (typeof(stm_instances))of_device_get_match_data(dev);
>> +	if (!stm_instances) {
>> +		dev_err(dev, "No STM instances associated with a cpu");
>> +		return -EINVAL;
>> +	}
>> +
>> +	base = devm_of_iomap(dev, np, 0, NULL);
>> +	if (IS_ERR(base)) {
>> +		dev_err(dev, "Failed to iomap %pOFn\n", np);
>> +		return PTR_ERR(base);
>> +	}
>> +
>> +	irq = irq_of_parse_and_map(np, 0);
>> +	if (irq <= 0) {
>> +		dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>> +		return -EINVAL;
>> +	}
> 
>  From commit description:
> 
>> The first probed STM is used as a clocksource, the second will be the
>> broadcast timer and the rest are used as a clockevent with the
>> affinity set to a CPU.
> 
> Why is the interrupt mandatory when the node is probed as a clocksource?

It relies on the DT description and it does not hurt to have a 
consistent code path for clockevent / clocksource even if the interrupt 
is not requested for the clocksource later.

>> +
>> +	clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(clk)) {
>> +		dev_err(dev, "Clock not found\n");
> 
> Missing irq_dispose_mapping ?

Yeah ...

>> +		return PTR_ERR(clk);
>> +	}
>> +
>> +	ret = clk_prepare_enable(clk);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable STM timer clock: %d\n", ret);
>> +		return ret;
>> +	}
> 
> devm_clk_get_enabled instead of devm_clk_get + clk_prepare_enable ?

Yes, good point

>> +
>> +	if (!stm_instances->clocksource && (stm_instances->features & STM_CLKSRC)) {
>> +
>> +		/*
>> +		 * First probed STM will be a clocksource
>> +		 */
>> +		ret = nxp_stm_clocksource_init(dev, name, base, clk);
>> +		if (ret)
>> +			return ret;
>> +		stm_instances->clocksource++;
>> +
>> +	} else if (!stm_instances->clockevent_broadcast &&
>> +		   (stm_instances->features & STM_CLKEVT_BROADCAST)) {
>> +
>> +		/*
>> +		 * Second probed STM will be a broadcast clockevent
>> +		 */
>> +		ret = nxp_stm_clockevent_broadcast_init(dev, name, base, irq, clk);
>> +		if (ret)
>> +			return ret;
>> +		stm_instances->clockevent_broadcast++;
>> +
>> +	} else if (stm_instances->clockevent_per_cpu < num_possible_cpus() &&
>> +		   (stm_instances->features & STM_CLKEVT_PER_CPU)) {
>> +
>> +		/*
>> +		 * Next probed STM will be a per CPU clockevent, until
>> +		 * we probe as much as we have CPUs available on the
>> +		 * system, we do a partial initialization
>> +		 */
>> +		ret = nxp_stm_clockevent_per_cpu_init(dev, name, base, irq, clk,
>> +						      stm_instances->clockevent_per_cpu);
>> +		if (ret)
>> +			return ret;
>> +
>> +		stm_instances->clockevent_per_cpu++;
>> +
>> +		/*
>> +		 * The number of probed STM for per CPU clockevent is
>> +		 * equal to the number of available CPUs on the
>> +		 * system. We install the cpu hotplug to finish the
>> +		 * initialization by registering the clockevents
>> +		 */
>> +		if (stm_instances->clockevent_per_cpu == num_possible_cpus()) {
>> +			ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "STM timer:starting",
>> +						nxp_stm_clockevent_starting_cpu, NULL);
>> +			if (ret < 0)
>> +				return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct stm_instances s32g_stm_instances = { .features = STM_CLKSRC | STM_CLKEVT_PER_CPU };
>> +
>> +static const struct of_device_id nxp_stm_of_match[] = {
>> +	{ .compatible = "nxp,s32g2-stm", &s32g_stm_instances },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
>> +
>> +static struct platform_driver nxp_stm_probe = {
>> +	.probe	= nxp_stm_timer_probe,
>> +	.driver	= {
>> +		.name = "nxp-stm",
>> +		.of_match_table = of_match_ptr(nxp_stm_of_match),
>> +	},
>> +};
>> +module_platform_driver(nxp_stm_probe);
>> +
>> +MODULE_DESCRIPTION("NXP System Timer Module driver");
>> +MODULE_LICENSE("GPL");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

