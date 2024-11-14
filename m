Return-Path: <linux-kernel+bounces-409592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567809C8EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1342E28875B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFF1A4AB3;
	Thu, 14 Nov 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvVx9TOC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6E18873A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599480; cv=none; b=M5qvxsvq5/G1g31GFGQ9rWoJ2zkVMbH3iHQsARMsgQkHTlE8pqbVhmGKku78rhLU5KaRDq5UBT3uglUi4LRtPapSozPvT9++ePrrxWEy2MByak4V3sUy1AYogaKjMYa64zB8erMBT8/sTDXMlks19UwquT/kG/PC+Qrs0s5YtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599480; c=relaxed/simple;
	bh=r42Qg9JjsJGXJh1iogyjag/TiqwpcdnzR/8E18L1XgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMTDh3ngNcz68Og9oblkHiQZCk+7qXgxuREldlQHIthV/JjA+0B9lih1K7zwkulKgrx43k204dnus06Yqm41IQsX5uiMOBSnRX0D5TFvPuOHnTn3VQgmqWZJX835fCoUxjnsNcD4+7VbjLdJ7vPq2g0pyzqaWnVVJipIfC/kXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvVx9TOC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731599479; x=1763135479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r42Qg9JjsJGXJh1iogyjag/TiqwpcdnzR/8E18L1XgY=;
  b=BvVx9TOCp49TnSBpWPjMIDZEKXeMN0NdIU1AvhIghXROYwWv9lWwgay8
   WWbasGjUNWWkDVer18h/8C04j0ia6N4qMwHLbh8wfNvGywaZlDYCvweJL
   hsvRwHiLRrntYB3x/xEnfnT/UPDVYhtyYNpFASpb0fSxuCFe1LOuFAxNd
   l6pJLESgm84612QgrYMEHsWtw4JEPmu8OV5JEgQCp8JskBqMbBVdXhYqQ
   OO8ryutSo5Qfa1TG7bHg/TOtoHU5THKXAVzDHngRhhn4G88CLqqhYAvQf
   peV4QE6oJeW2+Xnvju/0CGTmzLiU7/89dIzYK7DLLiZ+tB9D36JCk64G9
   Q==;
X-CSE-ConnectionGUID: ip3fuH8WSAqkc9HNK3FFiA==
X-CSE-MsgGUID: sHYGc+OPQUGVfzKMvtcGwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="35475971"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="35475971"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 07:51:18 -0800
X-CSE-ConnectionGUID: uDfv7xhGS1KnO+JydQ6Z/A==
X-CSE-MsgGUID: V7gLTQ1eSOy0WIjEzDFWyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="88666831"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 07:51:18 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 921F720B5703;
	Thu, 14 Nov 2024 07:51:16 -0800 (PST)
Message-ID: <6fe713dc-7a1f-46db-aaea-5a8f9b413b23@linux.intel.com>
Date: Thu, 14 Nov 2024 10:51:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/intel/ds: Simplify the PEBS records
 processing for adaptive PEBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, eranian@google.com,
 ak@linux.intel.com, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20241113151427.677169-1-kan.liang@linux.intel.com>
 <20241113151427.677169-2-kan.liang@linux.intel.com>
 <20241114141918.GA39245@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241114141918.GA39245@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-14 9:19 a.m., Peter Zijlstra wrote:
> On Wed, Nov 13, 2024 at 07:14:27AM -0800, kan.liang@linux.intel.com wrote:
> 
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 4d0f7c49295a..cbf2ab9ed4c8 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2400,12 +2400,38 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  	}
>>  }
>>  
>> +static inline void __intel_pmu_pebs_event_output(struct perf_event *event,
>> +						 struct pt_regs *iregs,
>> +						 void *record, bool last,
>> +						 struct perf_sample_data *data)
>> +{
>> +	struct x86_perf_regs perf_regs;
>> +	struct pt_regs *regs = &perf_regs.regs;
>> +	static struct pt_regs dummy_iregs;
>> +
>> +	if (!iregs)
>> +		iregs = &dummy_iregs;
>> +
>> +	setup_pebs_adaptive_sample_data(event, iregs, record, data, regs);
>> +	if (last) {
>> +		/*
>> +		 * All but the last records are processed.
>> +		 * The last one is left to be able to call the overflow handler.
>> +		 */
>> +		if (perf_event_overflow(event, data, regs))
>> +			x86_pmu_stop(event, 0);
>> +	} else
>> +		perf_event_output(event, data, regs);
>> +}
> 
> *sigh*... more unification please.
> 
>>  static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
>>  {
>>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>> +	void *unprocessed[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  	struct debug_store *ds = cpuc->ds;
>>  	struct perf_event *event;
>> +	struct pebs_basic *basic;
>>  	void *base, *at, *top;
>>  	int bit;
>>  	u64 mask;
>> @@ -2426,30 +2452,63 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>  		return;
>>  	}
>>  
>> -	for (at = base; at < top; at += cpuc->pebs_record_size) {
>> +	for (at = base; at < top; at += basic->format_size) {
>>  		u64 pebs_status;
>>  
>> -		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
>> -		pebs_status &= mask;
>> +		basic = at;
>> +		if (WARN_ON_ONCE(basic->format_size != cpuc->pebs_record_size))
>> +			continue;
>> +
>> +		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
>> +		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
>> +			event = cpuc->events[bit];
>> +
>> +			if (WARN_ON_ONCE(!event) ||
>> +			    WARN_ON_ONCE(!event->attr.precise_ip))
>> +				continue;
>> +
>> +			/*
>> +			 * Need at least one record to call the overflow handler later.
>> +			 * Initialize the unprocessed[] variable with the first record.
>> +			 */
>> +			if (!counts[bit]++) {
>> +				unprocessed[bit] = at;
>> +				continue;
>> +			}
>> +
>> +			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
>>  
>> -		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX)
>> -			counts[bit]++;
>> +			unprocessed[bit] = at;
>> +		}
>>  	}
>>  
>>  	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
>> -		if (counts[bit] == 0)
>> +		if (!counts[bit])
>>  			continue;
>>  
>>  		event = cpuc->events[bit];
>> -		if (WARN_ON_ONCE(!event))
>> -			continue;
>>  
>> -		if (WARN_ON_ONCE(!event->attr.precise_ip))
>> -			continue;
>> +		if (!iregs) {
>> +			/*
>> +			 * The PEBS records may be drained in the non-overflow context,
>> +			 * e.g., large PEBS + context switch. Perf should treat the
>> +			 * last record the same as other PEBS records, and doesn't
>> +			 * invoke the generic overflow handler.
>> +			 */
>> +			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
>> +		} else
>> +			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], true, data);
> 
> *sigh*, this is confusing as all hell. Both are last, but one says
> last=false.
> 
>> -		__intel_pmu_pebs_event(event, iregs, data, base,
>> -				       top, bit, counts[bit],
>> -				       setup_pebs_adaptive_sample_data);
>> +		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) {
>> +			/*
>> +			 * Now, auto-reload is only enabled in fixed period mode.
>> +			 * The reload value is always hwc->sample_period.
>> +			 * May need to change it, if auto-reload is enabled in
>> +			 * freq mode later.
>> +			 */
>> +			intel_pmu_save_and_restart_reload(event, counts[bit]);
>> +		} else
>> +			intel_pmu_save_and_restart(event);
> 
> And this is randomly ignoring the return value where previously we would
> abort.

I should give more explains regarding this. Sorry for the confusion.
It's safe to ignore the return value.
The !intel_pmu_save_and_restart() only happens when !hwc->event_base
or the period_left > 0.
- The !hwc->event_base is impossible for the PEBS event
which is only available on GP and fixed counters.
- The period_left should be always <=0. The check only happens for the
non AUTO_RELOAD event and single PEBS. It means that the event must
overflowed. So the period_left should be < 0 after the x86_pmu_update().

> 
>>  	}
>>  }
> 
> How's this completely untested delta?
> 

Thanks. The delta looks good. I will do more tests to double check.
But I probably do two changes as below.

- I will split the patches into two patches.
The first patch is a cleanup patch which factor out the common
__intel_pmu_pebs_events() and __intel_pmu_pebs_last_event(), which
impact all generations. The second patch is to simplify the adaptive
PEBS processing.

- I will move the above intel_pmu_save_and_restart() related codes to
the end where all samples are processed. In the current delta patch,
it's moved to right before processing the last sample.
For the current usage, it doesn't matter when perf updates and reset
event counts. Because all counters stop when draining the PEBS buffer.
However, it does matter for the new counters snapshotting feature.
Because the event counts are from the PEBS records.
https://lore.kernel.org/lkml/20240731143835.771618-4-kan.liang@linux.intel.com/

Thanks,
Kan
> ---
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2167,24 +2167,33 @@ intel_pmu_save_and_restart_reload(struct
>  	return 0;
>  }
>  
> +void (*setup_fn)(struct perf_event *, struct pt_regs *, void *,
> +		 struct perf_sample_data *, struct pt_regs *);
> +
> +static struct pt_regs dummy_iregs;
> +
>  static __always_inline void
>  __intel_pmu_pebs_event(struct perf_event *event,
>  		       struct pt_regs *iregs,
> -		       struct perf_sample_data *data,
> -		       void *base, void *top,
> -		       int bit, int count,
> -		       void (*setup_sample)(struct perf_event *,
> -					    struct pt_regs *,
> -					    void *,
> -					    struct perf_sample_data *,
> -					    struct pt_regs *))
> +		       struct pt_regs *regs,
> +		       struct perf_event_sample_data *data,
> +		       void *at,
> +		       setup_fn setup_sample)
> +{
> +	setup_sample(event, iregs, at, data, regs);
> +	perf_event_output(event, data, regs);
> +}
> +
> +static __always_inline void
> +__intel_pmu_pebs_last_event(struct perf_event *event,
> +			    struct pt_regs *iregs,
> +			    struct pt_regs *regs,
> +			    struct perf_event_sample_data *data,
> +			    void *at,
> +			    int count,
> +			    setup_fn setup_sample)
>  {
> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct x86_perf_regs perf_regs;
> -	struct pt_regs *regs = &perf_regs.regs;
> -	void *at = get_next_pebs_record_by_bit(base, top, bit);
> -	static struct pt_regs dummy_iregs;
>  
>  	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
>  		/*
> @@ -2194,21 +2203,12 @@ __intel_pmu_pebs_event(struct perf_event
>  		 * freq mode later.
>  		 */
>  		intel_pmu_save_and_restart_reload(event, count);
> -	} else if (!intel_pmu_save_and_restart(event))
> -		return;
> -
> -	if (!iregs)
> -		iregs = &dummy_iregs;
> -
> -	while (count > 1) {
> -		setup_sample(event, iregs, at, data, regs);
> -		perf_event_output(event, data, regs);
> -		at += cpuc->pebs_record_size;
> -		at = get_next_pebs_record_by_bit(at, top, bit);
> -		count--;
> +	} else {
> +		intel_pmu_save_and_restart(event);
>  	}
>  
>  	setup_sample(event, iregs, at, data, regs);
> +
>  	if (iregs == &dummy_iregs) {
>  		/*
>  		 * The PEBS records may be drained in the non-overflow context,
> @@ -2227,6 +2227,34 @@ __intel_pmu_pebs_event(struct perf_event
>  	}
>  }
>  
> +static __always_inline void
> +__intel_pmu_pebs_events(struct perf_event *event,
> +			struct pt_regs *iregs,
> +			struct perf_sample_data *data,
> +			void *base, void *top,
> +			int bit, int count,
> +			setup_fn setup_sample) {
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct x86_perf_regs perf_regs;
> +	struct pt_regs *regs = &perf_regs.regs;
> +	void *at = get_next_pebs_record_by_bit(base, top, bit);
> +	int cnt = count;
> +
> +	if (!iregs)
> +		iregs = &dummy_iregs;
> +
> +	while (cnt > 1) {
> +		__intel_pmu_pebs_event(event, iregs, regs, data, at, setup_sample);
> +		at += cpuc->pebs_record_size;
> +		at = get_next_pebs_record_by_bit(at, top, bit);
> +		cnt--;
> +	}
> +
> +	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
> +}
> +
>  static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -2261,7 +2289,7 @@ static void intel_pmu_drain_pebs_core(st
>  		return;
>  	}
>  
> -	__intel_pmu_pebs_event(event, iregs, data, at, top, 0, n,
> +	__intel_pmu_pebs_events(event, iregs, data, at, top, 0, n,
>  			       setup_pebs_fixed_sample_data);
>  }
>  
> @@ -2393,43 +2421,21 @@ static void intel_pmu_drain_pebs_nhm(str
>  		}
>  
>  		if (counts[bit]) {
> -			__intel_pmu_pebs_event(event, iregs, data, base,
> -					       top, bit, counts[bit],
> -					       setup_pebs_fixed_sample_data);
> +			__intel_pmu_pebs_events(event, iregs, data, base,
> +						top, bit, counts[bit],
> +						setup_pebs_fixed_sample_data);
>  		}>  	}
>  }
>  
> -static inline void __intel_pmu_pebs_event_output(struct perf_event *event,
> -						 struct pt_regs *iregs,
> -						 void *record, bool last,
> -						 struct perf_sample_data *data)
> -{
> -	struct x86_perf_regs perf_regs;
> -	struct pt_regs *regs = &perf_regs.regs;
> -	static struct pt_regs dummy_iregs;
> -
> -	if (!iregs)
> -		iregs = &dummy_iregs;
> -
> -	setup_pebs_adaptive_sample_data(event, iregs, record, data, regs);
> -	if (last) {
> -		/*
> -		 * All but the last records are processed.
> -		 * The last one is left to be able to call the overflow handler.
> -		 */
> -		if (perf_event_overflow(event, data, regs))
> -			x86_pmu_stop(event, 0);
> -	} else
> -		perf_event_output(event, data, regs);
> -}
> -
>  static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
> -	void *unprocessed[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
> +	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct debug_store *ds = cpuc->ds;
> +	struct x86_perf_regs perf_regs;
> +	struct pt_regs *regs = &perf_regs.regs;
>  	struct perf_event *event;
>  	struct pebs_basic *basic;
>  	void *base, *at, *top;
> @@ -2452,6 +2458,12 @@ static void intel_pmu_drain_pebs_icl(str
>  		return;
>  	}
>  
> +	if (!iregs)
> +		iregs = &dummy_iregs;
> +
> +	/*
> +	 * Process all but the last event for each counter.
> +	 */
>  	for (at = base; at < top; at += basic->format_size) {
>  		u64 pebs_status;
>  
> @@ -2467,18 +2479,12 @@ static void intel_pmu_drain_pebs_icl(str
>  			    WARN_ON_ONCE(!event->attr.precise_ip))
>  				continue;
>  
> -			/*
> -			 * Need at least one record to call the overflow handler later.
> -			 * Initialize the unprocessed[] variable with the first record.
> -			 */
> -			if (!counts[bit]++) {
> -				unprocessed[bit] = at;
> -				continue;
> +			if (counts[bit]++) {
> +				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
> +						       setup_pebs_adaptive_sample_data)
>  			}
>  
> -			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
> -
> -			unprocessed[bit] = at;
> +			last[bit] = at;
>  		}
>  	}
>  
> @@ -2487,28 +2493,8 @@ static void intel_pmu_drain_pebs_icl(str
>  			continue;
>  
>  		event = cpuc->events[bit];
> -
> -		if (!iregs) {
> -			/*
> -			 * The PEBS records may be drained in the non-overflow context,
> -			 * e.g., large PEBS + context switch. Perf should treat the
> -			 * last record the same as other PEBS records, and doesn't
> -			 * invoke the generic overflow handler.
> -			 */
> -			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
> -		} else
> -			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], true, data);
> -
> -		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) {
> -			/*
> -			 * Now, auto-reload is only enabled in fixed period mode.
> -			 * The reload value is always hwc->sample_period.
> -			 * May need to change it, if auto-reload is enabled in
> -			 * freq mode later.
> -			 */
> -			intel_pmu_save_and_restart_reload(event, counts[bit]);
> -		} else
> -			intel_pmu_save_and_restart(event);
> +		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
> +					    counts[bit], setup_pebs_adaptive_sample_data);
>  	}
>  }
>  
> 


