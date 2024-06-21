Return-Path: <linux-kernel+bounces-224429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB691224B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F77328981D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E7171664;
	Fri, 21 Jun 2024 10:22:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA07171095
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965333; cv=none; b=c/EJRQ8sMxmqmKhdmBEi3S685mUB4vKhoFkpw+yO2gEeMxPTCjP8Ir/HbEfflDoVhZapvUbPSqXqRCIwF8YtTjjIsjLjhFRxYaFg0cKg4nEo3OGUFmSctKvszphmMF4jq1fb7XHneepgsozOCblPT8UichiIgz6hNLl3eZY7DNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965333; c=relaxed/simple;
	bh=n9SaKTUmqIJE/U4/Sgk/iC5P36tqEZkn6Qgrv1losIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeG+N4ds+jMYbNiZXgQBWlZW8RApkaleCDzGuTw9zvI7ogdKcpYqJ3D2xDLsAsousgzePS34g7ONLN43Mwcz9WBa18Dg2TJPCMfKr+36oVSzEVLBL9QV0LMHW0AM67RIxVQk7mzjf6o76HXl8J3LheKcyVvbJJU4JfJJioKgous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 695A9FEC;
	Fri, 21 Jun 2024 03:22:35 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8FF3F6A8;
	Fri, 21 Jun 2024 03:22:08 -0700 (PDT)
Message-ID: <e2fdb89d-7594-4025-8e20-299dddc80497@arm.com>
Date: Fri, 21 Jun 2024 12:22:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, vincent.donnefort@arm.com,
 qyousef@layalina.io, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <0763f870-e30c-46cf-aefa-b879f2ebdba4@arm.com>
 <CAB8ipk_TjqoNetBZ7dbjRxuBHAP=nz9=ZNomnjnaCEikLQSK2A@mail.gmail.com>
 <64115627-c6c7-416b-99f9-0df22cbdca6b@arm.com>
 <CAB8ipk-86-oJJ2XhJ2y5=ek3QwmMe0OJ+ry9FddmXrrChqu6+A@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAB8ipk-86-oJJ2XhJ2y5=ek3QwmMe0OJ+ry9FddmXrrChqu6+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 12:37, Xuewen Yan wrote:
> On Fri, Jun 7, 2024 at 6:30 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 07/06/2024 10:20, Xuewen Yan wrote:
>>> Hi Dietmar
>>>
>>> On Fri, Jun 7, 2024 at 3:19 PM Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 06/06/2024 09:06, Xuewen Yan wrote:
>>>>> Because the effective_cpu_util() would return a util which
>>>>> maybe bigger than the actual_cpu_capacity, this could cause
>>>>> the pd_busy_time calculation errors.
>>>>
>>>> Doesn't return effective_cpu_util() either scale or min(scale, util)
>>>> with scale = arch_scale_cpu_capacity(cpu)? So the util sum over the PD
>>>> cannot exceed eenv->cpu_cap?
>>>
>>> In effective_cpu_util, the scale = arch_scale_cpu_capacity(cpu);
>>>  Although there is the clamp of eenv->pd_cap, but let us consider the
>>> following simple scenario:
>>> The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
>>> of cpufreq-limit,
>>
>> Ah, this is due to:
>>
>> find_energy_efficient_cpu()
>>
>>    ...
>>    for (; pd; pd = pd->next)
>>        ...
>>        cpu_actual_cap = get_actual_cpu_capacity(cpu)
>>
>>        for_each_cpu(cpu, cpus)
>>            ...
>>            eenv.pd_cap += cpu_actual_cap
>>
>> and:
>>
>> get_actual_cpu_capacity()
>>
>>    ...
>>    capacity = arch_scale_cpu_capacity(cpu)
>>
>>    capacity -= max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu))
>>
>> which got introduced by f1f8d0a22422 ("sched/cpufreq: Take cpufreq
>> feedback into account").
> 
> I don't think it was introduced by f1f8d0a22422, because f1f8d0a22422
> just replaced the cpu_thermal_cap with get_actual_cpu_capacity(cpu).
> The eenv.cpu_cap was  introduced by 3e8c6c9aac42 ("sched/fair: Remove
> task_util from effective utilization in feec()").

Yes, you're right. 3e8c6c9aac42 changed it from per-CPU to per-PD
capping.

In case we want to go back to per-CPU then we should remove the
eenv->pd_cap capping in eenv_pd_busy_time().

-->8--

@@ -7864,16 +7864,15 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
                                     struct cpumask *pd_cpus,
                                     struct task_struct *p)
 {
-       unsigned long busy_time = 0;
        int cpu;
 
        for_each_cpu(cpu, pd_cpus) {
                unsigned long util = cpu_util(cpu, p, -1, 0);
 
-               busy_time += effective_cpu_util(cpu, util, NULL, NULL);
+               util = effective_cpu_util(cpu, util, NULL, NULL);
+               util = min(util, eenv->cpu_cap);
+               eenv->pd_busy_time += util;
        }
-
-       eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
 }



I'm wondering whether we would need the:

if (dst_cpu >= 0)
    busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);

in compute_energy() anymore since we only get a candidate CPU in feec()
after checking with util_fits_cpu() if cpu can accommodate p :

feec()

    ...

    for_each_cpu()

        util = cpu_util(cpu, p, cpu, ...)
        cpu_cap = capacity_of()

        ...

        fits = util_fits_cpu(util, ..., cpu);
        if (!fits)
            continue

        /* check if candidate CPU */

