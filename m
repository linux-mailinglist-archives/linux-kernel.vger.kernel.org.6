Return-Path: <linux-kernel+bounces-285952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6B9514C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F26B22D76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BA136E18;
	Wed, 14 Aug 2024 06:46:24 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DADBA46
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617983; cv=none; b=iwWZf0IMZBHB9nkkKSkAanK0/NhHjkEWJ6hc4xVwmrbYtZl7o9iqvMCvh9gJbVwsATfQnS1y4ULNBdR1Y+xWiSbUI9HsyL2mW43icedCdIKM7ImM3r1pWKJ87PRbZEoNWIGlKj3Pre0cSlVNOeJGMfvgmfBeugobdCn+pGBcWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617983; c=relaxed/simple;
	bh=99kZ/8rZOL3uGrPIkD4Q+tyeSMmegSQ7O+frQfyNfBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uUwQcnzbLcjBXJ8Mv5tBvlI3U2P/l6a00hHlvzax3dx7Foc1QHygiSzzlo646T6fzTj2i2s0CVT/u3/Ksv+PnOifEJrwxzWr1tA3yaGw/rL6MRdY2i0AwgGGCvUpNzoVVY/kYdH5WofqS+WjgY6ISS+xr/Lfa7UzsDVMJQ0B0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WkJYw6sZ5z1S7s8;
	Wed, 14 Aug 2024 14:41:24 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 19A371402E1;
	Wed, 14 Aug 2024 14:46:17 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 14:46:16 +0800
Message-ID: <e2bf18e6-30cc-c85d-5fd4-c2be83922597@hisilicon.com>
Date: Wed, 14 Aug 2024 14:46:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 3/4] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ionela.voinescu@arm.com>,
	<sudeep.holla@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>,
	<vincent.guittot@linaro.org>, <vanshikonda@os.amperecomputing.com>
CC: <sumitg@nvidia.com>, <yang@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <20240603082154.3830591-4-beata.michalska@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20240603082154.3830591-4-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)

Hi Beata,

On 03/06/2024 16:21, Beata Michalska wrote:
> With the Frequency Invariance Engine (FIE) being already wired up with
> sched tick and making use of relevant (core counter and constant
> counter) AMU counters, getting the current frequency for a given CPU,
> can be achieved by utilizing the frequency scale factor which reflects
> an average CPU frequency for the last tick period length.
>
> The solution is partially based on APERF/MPERF implementation of
> arch_freq_get_on_cpu.
>
> Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
>   1 file changed, 100 insertions(+), 10 deletions(-)
...
> +
> +#define AMU_SAMPLE_EXP_MS	20
> +
> +unsigned int arch_freq_get_on_cpu(int cpu)
> +{
> +	struct amu_cntr_sample *amu_sample;
> +	unsigned int start_cpu = cpu;
> +	unsigned long last_update;
> +	unsigned int freq = 0;
> +	u64 scale;
> +
> +	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
> +		return 0;
> +
> +retry:
> +	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> +
> +	last_update = amu_sample->last_update;
> +
> +	/*
> +	 * For those CPUs that are in full dynticks mode,
> +	 * and those that have not seen tick for a while
> +	 * try an alternative source for the counters (and thus freq scale),
> +	 * if available, for given policy:
> +	 * this boils down to identifying an active cpu within the same freq
> +	 * domain, if any.
> +	 */
> +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> +	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
One question here.

The 2nd condition, providing the addtional code in patch 4, would be:
(!idle_cpu(cpu) && time_is_before_jiffies(last_update + 
msecs_to_jiffies(AMU_SAMPLE_EXP_MS)))
That means trying another cpu in the same freq domain if this cpu is 
running and not having a tick recently.

In this case, if it fails to find an alternative cpu in the following 
code, can it just jump to the calculation
part and return an 'old' frequency rather than return 0?
The freq here won't be older than the freq when the cpu went idle last 
time -- yet the freq before last idle
is returned if the cpu were idle (patch 4).

> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +		int ref_cpu = cpu;
> +
> +		if (!policy)
> +			goto leave;
> +
> +		if (!policy_is_shared(policy)) {
> +			cpufreq_cpu_put(policy);
> +			goto leave;
> +		}
> +
> +		do {
> +			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
> +						    start_cpu, false);
start_cpu is only used here. looks like we can s/start_cpu/cpu/ and 
remove its definition above?
> +
> +		} while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
> +
> +		cpufreq_cpu_put(policy);
> +
> +		if (ref_cpu >= nr_cpu_ids)
> +			/* No alternative to pull info from */
> +			goto leave;
> +
> +		cpu = ref_cpu;
> +		goto retry;
> +	}
> +	/*
> +	 * Reversed computation to the one used to determine
> +	 * the arch_freq_scale value
> +	 * (see amu_scale_freq_tick for details)
> +	 */
> +	scale = arch_scale_freq_capacity(cpu);
> +	freq = scale * arch_scale_freq_ref(cpu);
> +	freq >>= SCHED_CAPACITY_SHIFT;
> +leave:
> +	return freq;
> +}
> +
>   static void amu_fie_setup(const struct cpumask *cpus)
>   {
>   	int cpu;


