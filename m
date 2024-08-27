Return-Path: <linux-kernel+bounces-303368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5B960B43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF341C22C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949CD1BD006;
	Tue, 27 Aug 2024 13:06:01 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E001A08DB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763961; cv=none; b=heRz2Cvbdo2ophyLeuXyUpJNDgZWlYwWcj/GaqhGPC9Fnmms6GG33eX3Sks1KZzupahhEjgvD/isZTErODQQuOMe5+A5Fb85QMzuUH9C2yG9zl1gj8ZjsMZaLtB6RtqQOlF6SdvXiqd2uj6zmdIRPaiYXVDsZgMlZytpeRwYKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763961; c=relaxed/simple;
	bh=vEbG/glkP0u3S22rw7AvTp9c6OSP3qNDcLC3b1bQvhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aOnbjcSylIdrUY9ZXN4gKUiaittB/MSgxOY5YoZxYG61ScSPwW0plfrcYqfqdX3rfcmfkKDJU+22hLWqbo5aevpHBNPSnUcMXQnUwMFAUD7xfCp59Vj1zdS3CQG7S4rmQPE+wOWqGdllklbGZxtkzg4TpMkEeIF0OKs4cXv3iYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WtSSt3SXwz2Cnpv;
	Tue, 27 Aug 2024 21:05:18 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FE86140136;
	Tue, 27 Aug 2024 21:05:28 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 21:05:28 +0800
Message-ID: <d172ace3-7ddf-559d-c9c9-631cf5b42e4b@hisilicon.com>
Date: Tue, 27 Aug 2024 21:05:28 +0800
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
To: Beata Michalska <beata.michalska@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <vincent.guittot@linaro.org>,
	<vanshikonda@os.amperecomputing.com>, <sumitg@nvidia.com>,
	<yang@os.amperecomputing.com>, <lihuisong@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <20240603082154.3830591-4-beata.michalska@arm.com>
 <e2bf18e6-30cc-c85d-5fd4-c2be83922597@hisilicon.com>
 <ZswtdoRmwFHXdweK@arm.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <ZswtdoRmwFHXdweK@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 26/08/2024 15:23, Beata Michalska wrote:
> On Wed, Aug 14, 2024 at 02:46:16PM +0800, Jie Zhan wrote:
>> Hi Beata,
> Hi Jie,
>> On 03/06/2024 16:21, Beata Michalska wrote:
>>> With the Frequency Invariance Engine (FIE) being already wired up with
>>> sched tick and making use of relevant (core counter and constant
>>> counter) AMU counters, getting the current frequency for a given CPU,
>>> can be achieved by utilizing the frequency scale factor which reflects
>>> an average CPU frequency for the last tick period length.
>>>
>>> The solution is partially based on APERF/MPERF implementation of
>>> arch_freq_get_on_cpu.
>>>
>>> Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
>>> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
>>> ---
>>>    arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
>>>    1 file changed, 100 insertions(+), 10 deletions(-)
>> ...
>>> +
>>> +#define AMU_SAMPLE_EXP_MS	20
>>> +
>>> +unsigned int arch_freq_get_on_cpu(int cpu)
>>> +{
>>> +	struct amu_cntr_sample *amu_sample;
>>> +	unsigned int start_cpu = cpu;
>>> +	unsigned long last_update;
>>> +	unsigned int freq = 0;
>>> +	u64 scale;
>>> +
>>> +	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
>>> +		return 0;
>>> +
>>> +retry:
>>> +	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
>>> +
>>> +	last_update = amu_sample->last_update;
>>> +
>>> +	/*
>>> +	 * For those CPUs that are in full dynticks mode,
>>> +	 * and those that have not seen tick for a while
>>> +	 * try an alternative source for the counters (and thus freq scale),
>>> +	 * if available, for given policy:
>>> +	 * this boils down to identifying an active cpu within the same freq
>>> +	 * domain, if any.
>>> +	 */
>>> +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
>>> +	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>> One question here.
>>
>> The 2nd condition, providing the addtional code in patch 4, would be:
>> (!idle_cpu(cpu) && time_is_before_jiffies(last_update +
>> msecs_to_jiffies(AMU_SAMPLE_EXP_MS)))
>> That means trying another cpu in the same freq domain if this cpu is running
>> and not having a tick recently.
>>
>> In this case, if it fails to find an alternative cpu in the following code,
>> can it just jump to the calculation
>> part and return an 'old' frequency rather than return 0?
>> The freq here won't be older than the freq when the cpu went idle last time
>> -- yet the freq before last idle
>> is returned if the cpu were idle (patch 4).
> To be fair, I will be dropping the idle_cpu check from this condition so that
> we do keep the cap on the validity of the scale factor: meaning if the cpu
> remains idle for longer than assumed 20ms we will either look for alternative
> or return 0. I'm not entirely convinced returning somewhat stale information on
> the freq for CPUs that remain idle for a while will be useful.
>
> One note here: as per discussion in [1] this functionality will be moved to new
> sysfs attribute so it will no longer be used via scaling_cur_freq.
>
>
>>> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>> +		int ref_cpu = cpu;
>>> +
>>> +		if (!policy)
>>> +			goto leave;
>>> +
>>> +		if (!policy_is_shared(policy)) {
>>> +			cpufreq_cpu_put(policy);
>>> +			goto leave;
>>> +		}
>>> +
>>> +		do {
>>> +			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
>>> +						    start_cpu, false);
>> start_cpu is only used here. looks like we can s/start_cpu/cpu/ and remove
>> its definition above?
> It is indeed but it is needed for the cpumask_next_wrap to know when to stop
> the iteration after wrapping.
>
> ---
> [1] https://lore.kernel.org/all/20240603081331.3829278-1-beata.michalska@arm.com/
> ---
>
> BR
> Beata
>
Sure, thanks. Looking forward to the next version.

Jie


