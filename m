Return-Path: <linux-kernel+bounces-254773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83612933771
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70431C22639
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6351BF3A;
	Wed, 17 Jul 2024 06:55:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978BF1802E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199326; cv=none; b=kacKZyq9SUxbHRFBwi+lU6Ke+bDvLAIoebc8FXmV5idacOnL7+e1rHXARxr9B8LFrb7McEpNyrfbX/GIGG52zmlUt5+SFEhKxVS6mYNGO1GcX/gsSuDCcuUeZaXKfgpMDmVeyBW64Y4xQxHfzaAYFd08b1srRCqfPbR+ZG0z1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199326; c=relaxed/simple;
	bh=Sf8igZhAdC/C8+41b9Q9Clyrx0vbc6io3As6zl1+oJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCI9kJA/QHqA0euHRox3JsIePJHnFT3W2CWjvLdipk94h0YWPwJt9DbLL6kIgletn9XGMRkPCn9wSOUpDm0axqbDrnIrnrDTt1kzF0kOECbkiTl2bSGm+LqxF1H1g6JaLWUnpY61P8ry1tD52lGY7gzO2edACqMoOkGvTRAs+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB1F1063;
	Tue, 16 Jul 2024 23:55:42 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B83913F762;
	Tue, 16 Jul 2024 23:55:13 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:54:58 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com, viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 3/4] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZpdqwhKrHWEU3g_P@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <20240603082154.3830591-4-beata.michalska@arm.com>
 <aasc2rpfqtqis74hsrgv2nurrz5uumh3pgfuwbwbntlgvtavzh@egisja6opuuz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasc2rpfqtqis74hsrgv2nurrz5uumh3pgfuwbwbntlgvtavzh@egisja6opuuz>

On Wed, Jul 10, 2024 at 10:44:41AM -0700, Vanshidhar Konda wrote:
> I apologize for the late review. This series dropped off my radar. I will test
> this on an AmpereOne system.
> 
> On Mon, Jun 03, 2024 at 09:21:53AM +0100, Beata Michalska wrote:
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
> > arch/arm64/kernel/topology.c | 110 +++++++++++++++++++++++++++++++----
> > 1 file changed, 100 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index e475ec2705e1..2c002d2c3e0b 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -17,6 +17,7 @@
> > #include <linux/cpufreq.h>
> > #include <linux/init.h>
> > #include <linux/percpu.h>
> > +#include <linux/sched/isolation.h>
> > 
> > #include <asm/cpu.h>
> > #include <asm/cputype.h>
> > @@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
> >  * initialized.
> >  */
> > static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> > -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> > -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> > static cpumask_var_t amu_fie_cpus;
> > 
> > +struct amu_cntr_sample {
> > +	u64		arch_const_cycles_prev;
> > +	u64		arch_core_cycles_prev;
> > +	unsigned long	last_update;
> > +};
> > +
> > +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
> > +
> > void update_freq_counters_refs(void)
> 
> Could this be renamed to update_amu_cntr_sample() for more clarity?
I guess it could though to be fair I'd be more inclined to rename the struct
itself: this function updates the cached counter values that are being used
as a most recent ones but also as reference when calculating the delta
between the readings, so I'd say the naming here is pretty accurate.
> 
> > {
> > -	this_cpu_write(arch_core_cycles_prev, read_corecnt());
> > -	this_cpu_write(arch_const_cycles_prev, read_constcnt());
> > +	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> > +
> > +	amu_sample->arch_core_cycles_prev = read_corecnt();
> > +	amu_sample->arch_const_cycles_prev = read_constcnt();
> 
> I think it would be better to update amp_sample->last_update here. update_freq_counters_refs
> is the only way to update the amu_sample. So it should be safer to update the whole structure
> in this method.
Right, so the amu_sample->last_update is actually referring to updating the
scale factor, not the counter values per-se, even though one cannot be updated
without the other; so I'd rather keep those separated: the update time is being
used to determine whether the last known freq scale is still somewhat relevant.
If that would eliminate the confusion I can rename that filed.
> 
> > }
> > 
> > static inline bool freq_counters_valid(int cpu)
> > {
> > +	struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> > +
> > 	if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
> > 		return false;
> > 
> > @@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
> > 		return false;
> > 	}
> > 
> > -	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> > -		     !per_cpu(arch_core_cycles_prev, cpu))) {
> > +	if (unlikely(!amu_sample->arch_const_cycles_prev ||
> > +		     !amu_sample->arch_core_cycles_prev)) {
> > 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
> > 		return false;
> > 	}
> > @@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> > 
> > static void amu_scale_freq_tick(void)
> > {
> > +	struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> > 	u64 prev_core_cnt, prev_const_cnt;
> > 	u64 core_cnt, const_cnt, scale;
> > 
> > -	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +	prev_const_cnt = amu_sample->arch_const_cycles_prev;
> > +	prev_core_cnt = amu_sample->arch_core_cycles_prev;
> > 
> > 	update_freq_counters_refs();
> > 
> > -	const_cnt = this_cpu_read(arch_const_cycles_prev);
> > -	core_cnt = this_cpu_read(arch_core_cycles_prev);
> > +	const_cnt = amu_sample->arch_const_cycles_prev;
> > +	core_cnt = amu_sample->arch_core_cycles_prev;
> > 
> > +	/*
> > +	 * This should not happen unless the AMUs have been reset and the
> > +	 * counter values have not been restored - unlikely
> > +	 */
> > 	if (unlikely(core_cnt <= prev_core_cnt ||
> > 		     const_cnt <= prev_const_cnt))
> > 		return;
> > @@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
> > 
> > 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
> > 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
> > +
> > +	amu_sample->last_update = jiffies;
> 
> Please see the comment above. I think this line could be moved to
> update_freq_counters_refs method.
> 
> > }
> > 
> > static struct scale_freq_data amu_sfd = {
> > @@ -189,6 +207,78 @@ static struct scale_freq_data amu_sfd = {
> > 	.set_freq_scale = amu_scale_freq_tick,
> > };
> > 
> > +static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
> > +{
> > +	return cpumask_available(amu_fie_cpus) &&
> > +		cpumask_test_cpu(cpu, amu_fie_cpus);
> > +}
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
> > static void amu_fie_setup(const struct cpumask *cpus)
> > {
> > 	int cpu;
> > -- 
> > 2.25.1
> > 

