Return-Path: <linux-kernel+bounces-561196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C3A60EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CD21B60DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284581F1908;
	Fri, 14 Mar 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OfqEPd3A"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D301E5B8E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947638; cv=none; b=PGB5K39FszuDj7WESbeJVLONZ1badwcekLD3HYCP2nFiOC5oiCUpPXGW1bw5PgnGm+I7f4rpU82+12j5APf5faKZvUXytOb2ZCRbnCnniXtwKW1bH1BkwGXxL0jnxCZ2JBkZRLQAXd3t83G0GEX0kOy8zcWlC1DhrkGCba1Ekgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947638; c=relaxed/simple;
	bh=EVShpRzSReSQ+rvH1eHBy+eE953WNBHxzg0OHshDCBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9sXQUC7LJLav5k2Q240/P6F75Q2JuoeuLE4ry/avTVt5qa7iV4ejZeU8/bvp6xDq7gkks89j7OOqvLWowtirrpE+Lno9IZ70ibVf3qHz5lGJrmohMWy15Bc+sZtKun264v1pFZvlEOoomunNrHKZ8tPtZOKEAuVhuOutvZDYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OfqEPd3A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CTEVSnLa/Rgb1tuT5weERSf/jo2RrEUNQyXfIodzW9w=; b=OfqEPd3Ati4jjdXdhkEWD1sY6S
	Cs5l57qZnGx9lDxMUSBkOrw1TTTnzi7UttoP2cghsGA2feFitT/vKZelS0tRNxIK0bh7Mrfl/xtNO
	l4qZ1uqDfPWCrN9z1VWChbO50tLEqBqHIvgv2ogMRqKkd7CVnjKjR/pU04QL3XGCnb/FRID7huIp7
	cDKhTE7ggjwcS+JxAhtuTanksjtT+VzltKPSvvI+NJDeNI4NsOA5SRX2Y8hoT8YAVe7yCSwjUcxlW
	E7ryvv5cI1oR7VO8cHIkdcnXzgRphpXui3jiKTqLhkiO21BhpbUdRf1pbLQS5hnWXWTPKdDUJgqj6
	Y11jh6Yw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt29Y-0000000GIgl-0aHf;
	Fri, 14 Mar 2025 10:20:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D9E6300599; Fri, 14 Mar 2025 11:20:31 +0100 (CET)
Date: Fri, 14 Mar 2025 11:20:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
	linux-kernel@vger.kernel.org, eranian@google.com,
	thomas.falcon@intel.com
Subject: Re: [PATCH V2 3/3] perf/x86/intel: Support auto counter reload
Message-ID: <20250314102031.GL19344@noisy.programming.kicks-ass.net>
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
 <20241010192844.1006990-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010192844.1006990-4-kan.liang@linux.intel.com>

On Thu, Oct 10, 2024 at 12:28:44PM -0700, kan.liang@linux.intel.com wrote:

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 726ef13c2c81..d3bdc7d18d3f 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2851,6 +2851,54 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>  	cpuc->fixed_ctrl_val |= bits;
>  }
>  
> +static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int msr_b, msr_c;
> +
> +	if (!mask && !cpuc->acr_cfg_b[idx])
> +		return;
> +
> +	if (idx < INTEL_PMC_IDX_FIXED) {
> +		msr_b = MSR_IA32_PMC_V6_GP0_CFG_B;
> +		msr_c = MSR_IA32_PMC_V6_GP0_CFG_C;
> +	} else {
> +		msr_b = MSR_IA32_PMC_V6_FX0_CFG_B;
> +		msr_c = MSR_IA32_PMC_V6_FX0_CFG_C;
> +		idx -= INTEL_PMC_IDX_FIXED;
> +	}
> +
> +	if (cpuc->acr_cfg_b[idx] != mask) {
> +		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
> +		cpuc->acr_cfg_b[idx] = mask;
> +	}
> +	/* Only need to update the reload value when there is a valid config value. */
> +	if (mask && cpuc->acr_cfg_c[idx] != reload) {
> +		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
> +		cpuc->acr_cfg_c[idx] = reload;
> +	}
> +}
> +
> +static void intel_pmu_enable_acr(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* The PMU doesn't support ACR */
> +	if (!hybrid(event->pmu, acr_cntr_mask64))
> +		return;

In which case we shouldn't have been able to create such an event,
right?

But you need this because you do the cleanup here. Hmm, perhaps use a
static_call() to elide the whole call if the hardware doesn't support
this?

> +
> +	if (!is_acr_event_group(event) || !event->attr.config2) {
> +		/*
> +		 * The disable doesn't clear the ACR CFG register.
> +		 * Check and clear the ACR CFG register.
> +		 */
> +		intel_pmu_config_acr(hwc->idx, 0, 0);
> +		return;
> +	}
> +
> +	intel_pmu_config_acr(hwc->idx, hwc->config1, -hwc->sample_period);
> +}
> +
>  static void intel_pmu_enable_event(struct perf_event *event)
>  {
>  	u64 enable_mask = ARCH_PERFMON_EVENTSEL_ENABLE;
> @@ -2866,8 +2914,11 @@ static void intel_pmu_enable_event(struct perf_event *event)
>  			enable_mask |= ARCH_PERFMON_EVENTSEL_BR_CNTR;
>  		intel_set_masks(event, idx);
>  		__x86_pmu_enable_event(hwc, enable_mask);
> +		intel_pmu_enable_acr(event);
>  		break;
>  	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
> +		intel_pmu_enable_acr(event);
> +		fallthrough;
>  	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
>  		intel_pmu_enable_fixed(event);
>  		break;

This order is somewhat inconsistent. The GP events get enable,acr, while
the FIXED ones get acr,enable.

> @@ -3687,6 +3738,12 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  		c2->weight = hweight64(c2->idxmsk64);
>  	}
>  
> +	if (is_acr_event_group(event)) {
> +		c2 = dyn_constraint(cpuc, c2, idx);
> +		c2->idxmsk64 &= event->hw.dyn_mask;
> +		c2->weight = hweight64(c2->idxmsk64);
> +	}
> +
>  	return c2;
>  }
>  
> @@ -3945,6 +4002,78 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
>  	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
>  }
>  
> +static bool intel_pmu_is_acr_group(struct perf_event *event)
> +{
> +	if (!hybrid(event->pmu, acr_cntr_mask64))
> +		return false;

Why the above check? Aaaah, because the function does two distinct
things. Perhaps split?

> +	/* The group leader has the ACR flag set */
> +	if (is_acr_event_group(event))
> +		return true;
> +
> +	/* The acr_mask is set */
> +	if (event->attr.config2)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int intel_pmu_acr_check_reloadable_event(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	int num = 0;
> +
> +	/*
> +	 * The acr_mask(config2) indicates the event can be reloaded by
> +	 * other events. Apply the acr_cntr_mask.
> +	 */
> +	if (leader->attr.config2) {
> +		leader->hw.dyn_mask = hybrid(leader->pmu, acr_cntr_mask64);
> +		num++;
> +	} else
> +		leader->hw.dyn_mask = ~0ULL;

Here..

> +	for_each_sibling_event(sibling, leader) {
> +		if (sibling->attr.config2) {
> +			sibling->hw.dyn_mask = hybrid(sibling->pmu, acr_cntr_mask64);
> +			num++;
> +		} else
> +			sibling->hw.dyn_mask = ~0ULL;

.. here ..

> +	}
> +
> +	if (event->attr.config2) {
> +		event->hw.dyn_mask = hybrid(event->pmu, acr_cntr_mask64);
> +		num++;
> +	} else
> +		event->hw.dyn_mask = ~0ULL;

.. and here, the else branch lost its {}.

Also, you managed to write the exact same logic 3 times, surely that can
be a helper function?

> +
> +	if (num > hweight64(hybrid(event->pmu, acr_cntr_mask64)))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * Update the dyn_mask of each event to guarantee the event is scheduled
> + * to the counters which be able to cause a reload.
> + */
> +static void intel_pmu_set_acr_dyn_mask(struct perf_event *event, int idx,
> +				       struct perf_event *last)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	u64 mask = hybrid(event->pmu, acr_cntr_cause_mask);
> +
> +	/* The event set in the acr_mask(config2) can causes a reload. */
> +	if (test_bit(idx, (unsigned long *)&leader->attr.config2))
> +		event->hw.dyn_mask &= mask;
> +	for_each_sibling_event(sibling, leader) {
> +		if (test_bit(idx, (unsigned long *)&sibling->attr.config2))
> +			event->hw.dyn_mask &= mask;
> +	}
> +	if (test_bit(idx, (unsigned long *)&last->attr.config2))
> +		event->hw.dyn_mask &= mask;
> +}
> +
>  static int intel_pmu_hw_config(struct perf_event *event)
>  {
>  	int ret = x86_pmu_hw_config(event);
> @@ -4056,6 +4185,50 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
>  	}
>  
> +	if (intel_pmu_is_acr_group(event)) {

This is where you want to check 2 things:

 - does hardare suport ACR, if not, fail
 - is event ACR, check constraints.

Current code obscures this distinction.

> +		struct perf_event *sibling, *leader = event->group_leader;
> +		int event_idx = 0;
> +
> +		/* Not support perf metrics */
> +		if (is_metric_event(event))
> +			return -EINVAL;
> +
> +		/* Not support freq mode */
> +		if (event->attr.freq)
> +			return -EINVAL;
> +
> +		/* PDist is not supported */
> +		if (event->attr.config2 && event->attr.precise_ip > 2)
> +			return -EINVAL;
> +
> +		/* The reload value cannot exceeds the max period */
> +		if (event->attr.sample_period > x86_pmu.max_period)
> +			return -EINVAL;
> +		/*
> +		 * It's hard to know whether the event is the last one of
> +		 * the group. Reconfigure the dyn_mask of each X86 event
> +		 * every time when add a new event.
> +		 * It's impossible to verify whether the bits of
> +		 * the event->attr.config2 exceeds the group. But it's
> +		 * harmless, because the invalid bits are ignored. See
> +		 * intel_pmu_update_acr_mask(). The n - n0 guarantees that
> +		 * only the bits in the group is used.
> +		 *
> +		 * Check whether the reloadable counters is enough and
> +		 * initialize the dyn_mask.
> +		 */
> +		if (intel_pmu_acr_check_reloadable_event(event))
> +			return -EINVAL;
> +
> +		/* Reconfigure the dyn_mask for each event */
> +		intel_pmu_set_acr_dyn_mask(leader, event_idx++, event);
> +		for_each_sibling_event(sibling, leader)
> +			intel_pmu_set_acr_dyn_mask(sibling, event_idx++, event);
> +		intel_pmu_set_acr_dyn_mask(event, event_idx, event);
> +
> +		leader->hw.flags |= PERF_X86_EVENT_ACR;
> +	}
> +
>  	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
>  	    (event->attr.type == PERF_TYPE_HW_CACHE))
>  		return 0;
> @@ -4159,6 +4332,49 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	return 0;
>  }
>  
> +static void intel_pmu_update_acr_mask(struct cpu_hw_events *cpuc, int n, int *assign)
> +{
> +	struct perf_event *event;
> +	int n0, i, off;
> +
> +	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
> +		n0 = cpuc->n_events - cpuc->n_txn;
> +	else
> +		n0 = cpuc->n_events;
> +
> +	for (i = n0; i < n; i++) {
> +		event = cpuc->event_list[i];
> +		event->hw.config1 = 0;
> +
> +		/* Convert the group index into the counter index */
> +		for_each_set_bit(off, (unsigned long *)&event->attr.config2, n - n0)
> +			set_bit(assign[n0 + off], (unsigned long *)&event->hw.config1);

Atomic set_bit() is required?

> +	}
> +}
> +
> +static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
> +{
> +	struct perf_event *event;
> +	int ret = x86_schedule_events(cpuc, n, assign);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (cpuc->is_fake)
> +		return ret;
> +
> +	event = cpuc->event_list[n - 1];

ISTR seeing this pattern before somewhere and then argued it was all
sorts of broken. Why is it sane to look at the last event here?

> +	/*
> +	 * The acr_mask(config2) is the event-enabling order.
> +	 * Update it to the counter order after the counters are assigned.
> +	 */
> +	if (event && is_acr_event_group(event))
> +		intel_pmu_update_acr_mask(cpuc, n, assign);
> +
> +	return 0;
> +}
> +
> +
>  /*
>   * Currently, the only caller of this function is the atomic_switch_perf_msrs().
>   * The host perf context helps to prepare the values of the real hardware for
> @@ -5305,7 +5521,7 @@ static __initconst const struct x86_pmu intel_pmu = {
>  	.set_period		= intel_pmu_set_period,
>  	.update			= intel_pmu_update,
>  	.hw_config		= intel_pmu_hw_config,
> -	.schedule_events	= x86_schedule_events,
> +	.schedule_events	= intel_pmu_schedule_events,
>  	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
>  	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
>  	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,

How about only setting that function if the PMU actually support ACR ?

