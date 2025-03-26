Return-Path: <linux-kernel+bounces-576832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B6A714E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DF2174929
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BDD14C5AF;
	Wed, 26 Mar 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQFdw+Ay"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DD19C569
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985083; cv=none; b=XHx5R9qlttVX4otX8w/owGsyGjvnwYXdkAombPdS/QOfU6xbjc9rKwKL7pvFM/Mkf72C57sDgDlMKFqgUO6dEjjYEFQ443ZySthEIKShtYHnQF27KMDtIrw2HFlWmaWJeVFJdYJolUjay4sd8ytIn+WvY+s+drI5q8KZ9A1wQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985083; c=relaxed/simple;
	bh=tWR1QL8yhiO4mvP/Ze7AqtGLVNLAJG932Jste73WvNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTwUE/eq/8iANNFUwi3/vUY25nTZ16vGrPO/DfPsOW98UI55nBOSJl0Bn7V2PukHrYDIt98DgUDpflGRlbtbdp8nYJZcyibEv98KzCmaBb5aFkVVfSzNb76apbAQ18HO/U/Gb+HeNEPdkDAWNi2gmuHU1BESQ+/7A0xs8QCKNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQFdw+Ay; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so33258225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742985080; x=1743589880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bB8LvUt/gLOBzJVAWx0XW5i+JKbkehvPw1Hnii/hCeY=;
        b=uQFdw+AyenrBLUJwY/FOmEUorGC4VMyyeOJiXuqV4IfFLR03lvza/q5KoTJw79A31N
         HWpxv7Z+SahlLmu8bewjbwePgW5TJRdSKEPPjsoQW0C/s1tn65znmGkQlea1xACvUy0J
         6N+/hN/gmHpVtC+x80/44LiaA74NcI1CfICPgWsMkvsnuRhDwEekPApJkfhVIuHT2ZWl
         lix97DdpLtC1sAfa//xuAnZPHYIWlaEqHYUoVF4Kke7YJmWkKBF+La9YCRlTF7dUP7aI
         rPqA8S4nC17hYjnPWY7Tx4hYQRrF2sx+FUGBcHH0XRZFm/0NCGP+DKzghwYlLaG9Gkfo
         eWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742985080; x=1743589880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bB8LvUt/gLOBzJVAWx0XW5i+JKbkehvPw1Hnii/hCeY=;
        b=DXspgmdOKkOc7jRT0XnoJDOQVilBoZUencMrIM9S/NrJV2DeUcZ55wnqggbazoc9/f
         4MFfVDoh436EmNJ+V2JIdO7/f7ezZASy0OWfgnvI0msG7u76V/LF7B3VYAtdmTF7NfV7
         jHDYV/ZePi50cIn78SKfNU3xtcqJFvxPuxF+/TT3bj8sAIwXIPngiTHVO87PYMP57D7s
         1xl5aj7txItT0C8aPPGmodf4vCz3ql9n19fN3PJfTg0W+DCqsjYJvJsnuvrXyOQG2jut
         uGw2eb212ilFX+8VDnNAKIDZpXkUM6nkQSIm8Ukqq2SMKbQoXyPsDGUgv6ap74h8ni67
         4A/w==
X-Gm-Message-State: AOJu0Yym8UuDbzMZ+eDGIJ/nNNqMShha7jLgoY5a/YbMVHuoylb78SNs
	oNqpNUtKgSb7JPpzX7kTB/y+BvtP5HOt5ZeW8BvldadFtVscByqrWoPhl68fgIO5ch+1Kl4VkQN
	5
X-Gm-Gg: ASbGncseXt4KmB4+FUD68N1EOmqZ/Z4iMZRfkVqHCn7iLxFkmZwwgh/Gkqb1U4F6MRE
	qjLHRMLLTz2PUNBaFwPNwFjMczOMq6bbv97jymxV5hPIhY95joRibn620RNPwC4Ef7PVJRV+IOV
	Yw0oWTVC2mFvwgJXaR0ERpMy4ytGmDHSHWAmucGqss561EjGID1FXZo3W6X0/k99WMEoEMCj3A6
	FSc4EBcoBpmWkwI9VMUswW2PFjay2tzCwfud+N+xavuEchhbsJmkHKf7mGKMxAYsnGkabF6EPdb
	qLu5fFfrsDEVk4j5dF/zaZuTHgYDakDrdOb7/ENfEKoY7TAK68ejGA6USb9DasMy7g9ry4AHH26
	/+mynvbdC8XW8BF2szZU=
X-Google-Smtp-Source: AGHT+IFq7//HttPkhTtZsH26VLcgAbxZlTkYoXH35OF69Wj6ocNrllY3UQlBtg1F0RbqvI+UjYJiWg==
X-Received: by 2002:a05:600c:500f:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-43d509f809bmr217231095e9.15.1742985079945;
        Wed, 26 Mar 2025 03:31:19 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f995778sm16523955f8f.11.2025.03.26.03.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 03:31:19 -0700 (PDT)
Message-ID: <16d02edf-181e-42a1-8b0f-cdef61109fbf@linaro.org>
Date: Wed, 26 Mar 2025 11:31:18 +0100
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
 <f1268261-c900-4adc-aefe-795f23faba59@linaro.org>
 <2d7b18bf-31ed-abfc-20db-7f5b54c812af@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2d7b18bf-31ed-abfc-20db-7f5b54c812af@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2025 10:57, Ghennadi Procopciuc wrote:
> On 3/26/2025 11:19 AM, Daniel Lezcano wrote:
>> On 26/03/2025 08:44, Ghennadi Procopciuc wrote:
>>> On 3/25/2025 3:54 PM, Daniel Lezcano wrote:
>>>> On 25/03/2025 14:21, Ghennadi Procopciuc wrote:
>>>>> On 3/25/2025 2:51 PM, Daniel Lezcano wrote:
>>>>> [ ... ]
>>>>>>>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device
>>>>>>>>>>>> *pdev)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    struct device *dev = &pdev->dev;
>>>>>>>>>>>> +    struct device_node *np = dev->of_node;
>>>>>>>>>>>> +    struct stm_instances *stm_instances;
>>>>>>>>>>>> +    const char *name = of_node_full_name(np);
>>>>>>>>>>>> +    void __iomem *base;
>>>>>>>>>>>> +    int irq, ret;
>>>>>>>>>>>> +    struct clk *clk;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    stm_instances =
>>>>>>>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>>>>>>>> +    if (!stm_instances) {
>>>>>>>>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +
>>>>>>>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>>>>>>>> +    if (IS_ERR(base)) {
>>>>>>>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>>>>>>>> +        return PTR_ERR(base);
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +
>>>>>>>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>>>>>>>> +    if (irq <= 0) {
>>>>>>>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>>> +    }
>>>>>>>>>>>
>>>>>>>>>>>       From commit description:
>>>>>>>>>>>
>>>>>>>>>>>> The first probed STM is used as a clocksource, the second
>>>>>>>>>>>> will be
>>>>>>>>>>>> the
>>>>>>>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>>>>>>>> affinity set to a CPU.
>>>>>>>>>>>
>>>>>>>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>>>>>>>> clocksource?
>>>>>>>>>>
>>>>>>>>>> It relies on the DT description and it does not hurt to have a
>>>>>>>>>> consistent code path for clockevent / clocksource even if the
>>>>>>>>>> interrupt
>>>>>>>>>> is not requested for the clocksource later.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> If so, in my opinion, it would make sense to use the same STM
>>>>>>>>> instance
>>>>>>>>> for both the clocksource and broadcast clockevent, as both
>>>>>>>>> functions
>>>>>>>>> can
>>>>>>>>> be accommodated within a single STM instance, which will help
>>>>>>>>> reduce
>>>>>>>>> the
>>>>>>>>> number of STM instances used.
>>>>>>>>
>>>>>>>> The broadcast timer is stopped when it is unused which is the
>>>>>>>> case for
>>>>>>>> the s32 because there are no idle state powering down the local
>>>>>>>> timers.
>>>>>>>> They have to have be separated.
>>>>>>>>
>>>>>>>
>>>>>>> This wouldn't be the case if the STM is kept running/counting during
>>>>>>> the
>>>>>>> clock event setup, with only the clock event interrupt being disabled
>>>>>>> (CCR.CEN).
>>>>>>
>>>>>> Are you asking to use two different channels for the same STM
>>>>>> instance,
>>>>>> one for the clocksource and one for the clockevent ?
>>>>>>
>>>>>
>>>>> I suggested using the CNT register to obtain the count for the clock
>>>>> source, while using one of the STM channels for the clock event.
>>>>
>>>> Ah, ok.
>>>>
>>>> I think it is preferable to keep them separated to keep the code
>>>> modular. Given the number of STM on the platform, it does not hurt
>>>>
>>>
>>> The S32G2 and S32G3 are SoCs featuring a diverse set of cores. Linux is
>>> expected to run on Cortex-A53 cores, while other software stacks will
>>> operate on Cortex-M cores. The number of STM instances has been sized to
>>> include at most one instance per core. Allocating six instances (1 clock
>>> source, 1 broadcast clock event, and 4 clock events for all A53 cores)
>>> to Linux on the S32G2 leaves the M7 software stacks without adequate STM
>>> coverage.
>>
>> Given this description I'm wondering why one STM has to be used as a
>> clocksource if the STM_07 is already a TS one. And also, we can get rid
>> of the broadcast timer as there is no idle state forcing a switch to an
>> always-on timer.
> 
> Indeed, STM_07 can be used as a system clock source, but Linux should
> not assume ownership of it.
> 
>>
>> IIUC, on the S32g2 there are 4 x Cortex-A53 and 3 x Cortex-M3, that
>> means we need 7 timers.
>>
>> The system has 7 timers + a special one for timestamp.
>>
>> So if I follow the reasoning, the broadcast timer should not be used
>> otherwise one cortex-M3 will end up without a timer.
>>
> 
> On the S32G2, there are eight STM timers and STM_TS. Therefore, there
> should be enough instances to accommodate 4xA53 and 3xM7 cores.
> 
>> That leads us to one clocksource for the first per CPU timer initialized
>> or alternatively one STM instance == 1 clocksource and 1 clockevent
>> which makes things simpler
>>
> I'm not sure I understood the entire description. As I see it, two STM
> instances should be used to accommodate one clock source, a broadcast
> clock event, and four clock events—one per core.

What I meant is to do something simpler:

-----------------

cat /proc/interrupts

  16:       7891          0          0          0    GICv3  56 Level 
stm@4011c000
  17:          0       5326          0          0    GICv3  57 Level 
stm@40120000
  18:          3          0      16668          0    GICv3  58 Level 
stm@40124000
  19:          0          0          0       5152    GICv3  59 Level 
stm@40128000

------------------

cat /sys/devices/system/clockevents/clockevent*/current_device

stm@4011c000
stm@40120000
stm@40124000
stm@40128000

------------------

cat /sys/devices/system/clocksource/clocksource0/available_clocksource

stm@4011c000 stm@40120000 stm@40124000 stm@40128000 arch_sys_counter



On the S32G2: 4 STM instances used for one clocksource and one clockevent

On the S32G3: 8 STM instances used for one clocksource and one clockevent


Specific broadcast timer is not needed as the s32g system.


The resulting timer driver code is much simpler.


> E.g.
> STM_0
> 	- clocksource (based on CNT)
> 	- broadcast clock event (channel 0)
> 
> STM_1
> 	- Cortex-A53 0 (channel 0)
> 	- Cortex-A53 1 (channel 1)
> 	- Cortex-A53 2 (channel 2)
> 	- Cortex-A53 3 (channel 3)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

