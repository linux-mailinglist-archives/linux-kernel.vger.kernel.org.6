Return-Path: <linux-kernel+bounces-300901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830595EA48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6525E1C21354
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1389312BF02;
	Mon, 26 Aug 2024 07:23:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D846B12BEBE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657037; cv=none; b=BWXkGmTlPXq/VhbQ98lVvrhObtsDcQhffEydMsZHglsWwiI5mMCLvMDb+f82izI2zXsPf0jCBW+mKXkjpFDg1K1ERuCGW8ou6D8hhVegi3bnzmZIBq2aSH637zqS+xyVO+GRD0HguZV7FwOC5iLBjia5t89tX2tDtnPvpweyosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657037; c=relaxed/simple;
	bh=40KCpo4a/KT+N/jHw0w/ATGM1OP+/u7YqRjVvp7FewI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mePKtqJ1m7ZMxn3vOZsmFzUp1E6M3rbJ8YQ8V6njCApAJ6/sfHUPtYONyKlpqLm5sj7gaeZLWSdHGNyHiNKOYY4BJV7Wne/983GZWmdjFDugwIzueaFm3ZBrmOy5I1DK6HeOwiyVSMZP4pepknP3Ev5t4NvDIrC9pxDLen1/B88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E17E2339;
	Mon, 26 Aug 2024 00:24:14 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F8F13F66E;
	Mon, 26 Aug 2024 00:23:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:23:34 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	vanshikonda@os.amperecomputing.com, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 3/4] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZswtdoRmwFHXdweK@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <20240603082154.3830591-4-beata.michalska@arm.com>
 <e2bf18e6-30cc-c85d-5fd4-c2be83922597@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2bf18e6-30cc-c85d-5fd4-c2be83922597@hisilicon.com>

On Wed, Aug 14, 2024 at 02:46:16PM +0800, Jie Zhan wrote:
> Hi Beata,
Hi Jie,
> 
> On 03/06/2024 16:21, Beata Michalska wrote:
> > With the Frequency Invariance Engine (FIE) being already wired up with
> > sched tick and making use of relevant (core counter and constant
> > counter) AMU counters, getting the current frequency for a given CPU,
> > can be achieved by utilizing the frequency scale factor which reflects
> > an average CPU frequency for the last tick period length.
> > 
> > The solution is partially based on APERF/MPERF implementation of
> > arch_freq_get_on_cpu.
> > 
> > Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >   arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
> >   1 file changed, 100 insertions(+), 10 deletions(-)
> ...
> > +
> > +#define AMU_SAMPLE_EXP_MS	20
> > +
> > +unsigned int arch_freq_get_on_cpu(int cpu)
> > +{
> > +	struct amu_cntr_sample *amu_sample;
> > +	unsigned int start_cpu = cpu;
> > +	unsigned long last_update;
> > +	unsigned int freq = 0;
> > +	u64 scale;
> > +
> > +	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
> > +		return 0;
> > +
> > +retry:
> > +	amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> > +	last_update = amu_sample->last_update;
> > +
> > +	/*
> > +	 * For those CPUs that are in full dynticks mode,
> > +	 * and those that have not seen tick for a while
> > +	 * try an alternative source for the counters (and thus freq scale),
> > +	 * if available, for given policy:
> > +	 * this boils down to identifying an active cpu within the same freq
> > +	 * domain, if any.
> > +	 */
> > +	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> > +	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> One question here.
> 
> The 2nd condition, providing the addtional code in patch 4, would be:
> (!idle_cpu(cpu) && time_is_before_jiffies(last_update +
> msecs_to_jiffies(AMU_SAMPLE_EXP_MS)))
> That means trying another cpu in the same freq domain if this cpu is running
> and not having a tick recently.
> 
> In this case, if it fails to find an alternative cpu in the following code,
> can it just jump to the calculation
> part and return an 'old' frequency rather than return 0?
> The freq here won't be older than the freq when the cpu went idle last time
> -- yet the freq before last idle
> is returned if the cpu were idle (patch 4).
To be fair, I will be dropping the idle_cpu check from this condition so that
we do keep the cap on the validity of the scale factor: meaning if the cpu
remains idle for longer than assumed 20ms we will either look for alternative
or return 0. I'm not entirely convinced returning somewhat stale information on
the freq for CPUs that remain idle for a while will be useful.

One note here: as per discussion in [1] this functionality will be moved to new
sysfs attribute so it will no longer be used via scaling_cur_freq.


> 
> > +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > +		int ref_cpu = cpu;
> > +
> > +		if (!policy)
> > +			goto leave;
> > +
> > +		if (!policy_is_shared(policy)) {
> > +			cpufreq_cpu_put(policy);
> > +			goto leave;
> > +		}
> > +
> > +		do {
> > +			ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
> > +						    start_cpu, false);
> start_cpu is only used here. looks like we can s/start_cpu/cpu/ and remove
> its definition above?
It is indeed but it is needed for the cpumask_next_wrap to know when to stop
the iteration after wrapping.

---
[1] https://lore.kernel.org/all/20240603081331.3829278-1-beata.michalska@arm.com/
---

BR
Beata
> > +
> > +		} while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
> > +
> > +		cpufreq_cpu_put(policy);
> > +
> > +		if (ref_cpu >= nr_cpu_ids)
> > +			/* No alternative to pull info from */
> > +			goto leave;
> > +
> > +		cpu = ref_cpu;
> > +		goto retry;
> > +	}
> > +	/*
> > +	 * Reversed computation to the one used to determine
> > +	 * the arch_freq_scale value
> > +	 * (see amu_scale_freq_tick for details)
> > +	 */
> > +	scale = arch_scale_freq_capacity(cpu);
> > +	freq = scale * arch_scale_freq_ref(cpu);
> > +	freq >>= SCHED_CAPACITY_SHIFT;
> > +leave:
> > +	return freq;
> > +}
> > +
> >   static void amu_fie_setup(const struct cpumask *cpus)
> >   {
> >   	int cpu;
> 

