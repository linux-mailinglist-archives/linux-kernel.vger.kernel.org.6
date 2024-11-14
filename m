Return-Path: <linux-kernel+bounces-409435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD4E9C8CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8821F22BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F8BA53;
	Thu, 14 Nov 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUREshfl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E79476
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593969; cv=none; b=j5YAV6UPaXSNleC/xhr9F0kPG/d4GqkZ0cJz6kwaWy32+2fVdEKi1fcbdsFjM/5kHZ3hCPuAHqlnQig4ImbIyG0uJSinyCcsbbky9qKP9D18ee4+kotIIazpEun2a+Oh/TVz7Np4b5r/mYq0Lz36w+J22jvDMWx2qosoiq/xXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593969; c=relaxed/simple;
	bh=9H65xX/SAhdhNdMl7Krn50tuMTzB+dAKIUIhFUHvMvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkoP2eMguCDMeGFLh6n/IwtpYmxXSVLKUsLmbWTz+cco1Tn6o31JCN+tCLJT9YbKOlTFGBC09DzBmulaHozSrEaqnrYLYREIHOwJr5yj3L5LYF7y1XaamUKyRABFhcRM0gqzToakYbYeid9GHCa2Hqq6dp8N5OEtniu7QbifeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PUREshfl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w/1OWtvmzI6zHMAy/FRY67iv2m/CNvBSTm7nFY1Iwdk=; b=PUREshflcPLS7nc97cthTFj92k
	AspYxQyZIqJKuSOXnuLDXu8PtEj98cRQECspdFgR0k1f7LRsxFE1ivaelpnNdmbQIN2XiNl4dhEIO
	Fc/jSgdfZllXF52hIe3IPvp2xwEdKkPiiLBiX0o7Jarl64iZ63kWONMiug3gCzb6kjKg4UAJoBVvk
	Q/ECLfprl2GdK3v1LmyH6x1lt0Wum8ucMhQBeHUGYn86TWtxslVPCcFPFvcusz5vzkXRYoiVZblJ2
	xKAXsqC/qQn7/Cow9sfBb7nsfm6tw8+QFtmUzIC8mQM3GRfGVgMO9WHHnmfqtWqKSpfp9JHH8uWT9
	efRoCMJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBagp-0000000020a-3ODJ;
	Thu, 14 Nov 2024 14:19:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DD45F300446; Thu, 14 Nov 2024 15:19:18 +0100 (CET)
Date: Thu, 14 Nov 2024 15:19:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, eranian@google.com,
	ak@linux.intel.com, Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 2/2] perf/x86/intel/ds: Simplify the PEBS records
 processing for adaptive PEBS
Message-ID: <20241114141918.GA39245@noisy.programming.kicks-ass.net>
References: <20241113151427.677169-1-kan.liang@linux.intel.com>
 <20241113151427.677169-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113151427.677169-2-kan.liang@linux.intel.com>

On Wed, Nov 13, 2024 at 07:14:27AM -0800, kan.liang@linux.intel.com wrote:

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 4d0f7c49295a..cbf2ab9ed4c8 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2400,12 +2400,38 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  	}
>  }
>  
> +static inline void __intel_pmu_pebs_event_output(struct perf_event *event,
> +						 struct pt_regs *iregs,
> +						 void *record, bool last,
> +						 struct perf_sample_data *data)
> +{
> +	struct x86_perf_regs perf_regs;
> +	struct pt_regs *regs = &perf_regs.regs;
> +	static struct pt_regs dummy_iregs;
> +
> +	if (!iregs)
> +		iregs = &dummy_iregs;
> +
> +	setup_pebs_adaptive_sample_data(event, iregs, record, data, regs);
> +	if (last) {
> +		/*
> +		 * All but the last records are processed.
> +		 * The last one is left to be able to call the overflow handler.
> +		 */
> +		if (perf_event_overflow(event, data, regs))
> +			x86_pmu_stop(event, 0);
> +	} else
> +		perf_event_output(event, data, regs);
> +}

*sigh*... more unification please.

>  static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
> +	void *unprocessed[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct debug_store *ds = cpuc->ds;
>  	struct perf_event *event;
> +	struct pebs_basic *basic;
>  	void *base, *at, *top;
>  	int bit;
>  	u64 mask;
> @@ -2426,30 +2452,63 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  		return;
>  	}
>  
> -	for (at = base; at < top; at += cpuc->pebs_record_size) {
> +	for (at = base; at < top; at += basic->format_size) {
>  		u64 pebs_status;
>  
> -		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
> -		pebs_status &= mask;
> +		basic = at;
> +		if (WARN_ON_ONCE(basic->format_size != cpuc->pebs_record_size))
> +			continue;
> +
> +		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
> +		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
> +			event = cpuc->events[bit];
> +
> +			if (WARN_ON_ONCE(!event) ||
> +			    WARN_ON_ONCE(!event->attr.precise_ip))
> +				continue;
> +
> +			/*
> +			 * Need at least one record to call the overflow handler later.
> +			 * Initialize the unprocessed[] variable with the first record.
> +			 */
> +			if (!counts[bit]++) {
> +				unprocessed[bit] = at;
> +				continue;
> +			}
> +
> +			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
>  
> -		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX)
> -			counts[bit]++;
> +			unprocessed[bit] = at;
> +		}
>  	}
>  
>  	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
> -		if (counts[bit] == 0)
> +		if (!counts[bit])
>  			continue;
>  
>  		event = cpuc->events[bit];
> -		if (WARN_ON_ONCE(!event))
> -			continue;
>  
> -		if (WARN_ON_ONCE(!event->attr.precise_ip))
> -			continue;
> +		if (!iregs) {
> +			/*
> +			 * The PEBS records may be drained in the non-overflow context,
> +			 * e.g., large PEBS + context switch. Perf should treat the
> +			 * last record the same as other PEBS records, and doesn't
> +			 * invoke the generic overflow handler.
> +			 */
> +			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
> +		} else
> +			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], true, data);

*sigh*, this is confusing as all hell. Both are last, but one says
last=false.

> -		__intel_pmu_pebs_event(event, iregs, data, base,
> -				       top, bit, counts[bit],
> -				       setup_pebs_adaptive_sample_data);
> +		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) {
> +			/*
> +			 * Now, auto-reload is only enabled in fixed period mode.
> +			 * The reload value is always hwc->sample_period.
> +			 * May need to change it, if auto-reload is enabled in
> +			 * freq mode later.
> +			 */
> +			intel_pmu_save_and_restart_reload(event, counts[bit]);
> +		} else
> +			intel_pmu_save_and_restart(event);

And this is randomly ignoring the return value where previously we would
abort.

>  	}
>  }

How's this completely untested delta?

---
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2167,24 +2167,33 @@ intel_pmu_save_and_restart_reload(struct
 	return 0;
 }
 
+void (*setup_fn)(struct perf_event *, struct pt_regs *, void *,
+		 struct perf_sample_data *, struct pt_regs *);
+
+static struct pt_regs dummy_iregs;
+
 static __always_inline void
 __intel_pmu_pebs_event(struct perf_event *event,
 		       struct pt_regs *iregs,
-		       struct perf_sample_data *data,
-		       void *base, void *top,
-		       int bit, int count,
-		       void (*setup_sample)(struct perf_event *,
-					    struct pt_regs *,
-					    void *,
-					    struct perf_sample_data *,
-					    struct pt_regs *))
+		       struct pt_regs *regs,
+		       struct perf_event_sample_data *data,
+		       void *at,
+		       setup_fn setup_sample)
+{
+	setup_sample(event, iregs, at, data, regs);
+	perf_event_output(event, data, regs);
+}
+
+static __always_inline void
+__intel_pmu_pebs_last_event(struct perf_event *event,
+			    struct pt_regs *iregs,
+			    struct pt_regs *regs,
+			    struct perf_event_sample_data *data,
+			    void *at,
+			    int count,
+			    setup_fn setup_sample)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
-	void *at = get_next_pebs_record_by_bit(base, top, bit);
-	static struct pt_regs dummy_iregs;
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
 		/*
@@ -2194,21 +2203,12 @@ __intel_pmu_pebs_event(struct perf_event
 		 * freq mode later.
 		 */
 		intel_pmu_save_and_restart_reload(event, count);
-	} else if (!intel_pmu_save_and_restart(event))
-		return;
-
-	if (!iregs)
-		iregs = &dummy_iregs;
-
-	while (count > 1) {
-		setup_sample(event, iregs, at, data, regs);
-		perf_event_output(event, data, regs);
-		at += cpuc->pebs_record_size;
-		at = get_next_pebs_record_by_bit(at, top, bit);
-		count--;
+	} else {
+		intel_pmu_save_and_restart(event);
 	}
 
 	setup_sample(event, iregs, at, data, regs);
+
 	if (iregs == &dummy_iregs) {
 		/*
 		 * The PEBS records may be drained in the non-overflow context,
@@ -2227,6 +2227,34 @@ __intel_pmu_pebs_event(struct perf_event
 	}
 }
 
+static __always_inline void
+__intel_pmu_pebs_events(struct perf_event *event,
+			struct pt_regs *iregs,
+			struct perf_sample_data *data,
+			void *base, void *top,
+			int bit, int count,
+			setup_fn setup_sample) {
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
+	void *at = get_next_pebs_record_by_bit(base, top, bit);
+	int cnt = count;
+
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	while (cnt > 1) {
+		__intel_pmu_pebs_event(event, iregs, regs, data, at, setup_sample);
+		at += cpuc->pebs_record_size;
+		at = get_next_pebs_record_by_bit(at, top, bit);
+		cnt--;
+	}
+
+	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
+}
+
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2261,7 +2289,7 @@ static void intel_pmu_drain_pebs_core(st
 		return;
 	}
 
-	__intel_pmu_pebs_event(event, iregs, data, at, top, 0, n,
+	__intel_pmu_pebs_events(event, iregs, data, at, top, 0, n,
 			       setup_pebs_fixed_sample_data);
 }
 
@@ -2393,43 +2421,21 @@ static void intel_pmu_drain_pebs_nhm(str
 		}
 
 		if (counts[bit]) {
-			__intel_pmu_pebs_event(event, iregs, data, base,
-					       top, bit, counts[bit],
-					       setup_pebs_fixed_sample_data);
+			__intel_pmu_pebs_events(event, iregs, data, base,
+						top, bit, counts[bit],
+						setup_pebs_fixed_sample_data);
 		}
 	}
 }
 
-static inline void __intel_pmu_pebs_event_output(struct perf_event *event,
-						 struct pt_regs *iregs,
-						 void *record, bool last,
-						 struct perf_sample_data *data)
-{
-	struct x86_perf_regs perf_regs;
-	struct pt_regs *regs = &perf_regs.regs;
-	static struct pt_regs dummy_iregs;
-
-	if (!iregs)
-		iregs = &dummy_iregs;
-
-	setup_pebs_adaptive_sample_data(event, iregs, record, data, regs);
-	if (last) {
-		/*
-		 * All but the last records are processed.
-		 * The last one is left to be able to call the overflow handler.
-		 */
-		if (perf_event_overflow(event, data, regs))
-			x86_pmu_stop(event, 0);
-	} else
-		perf_event_output(event, data, regs);
-}
-
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
-	void *unprocessed[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
+	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
 	struct perf_event *event;
 	struct pebs_basic *basic;
 	void *base, *at, *top;
@@ -2452,6 +2458,12 @@ static void intel_pmu_drain_pebs_icl(str
 		return;
 	}
 
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	/*
+	 * Process all but the last event for each counter.
+	 */
 	for (at = base; at < top; at += basic->format_size) {
 		u64 pebs_status;
 
@@ -2467,18 +2479,12 @@ static void intel_pmu_drain_pebs_icl(str
 			    WARN_ON_ONCE(!event->attr.precise_ip))
 				continue;
 
-			/*
-			 * Need at least one record to call the overflow handler later.
-			 * Initialize the unprocessed[] variable with the first record.
-			 */
-			if (!counts[bit]++) {
-				unprocessed[bit] = at;
-				continue;
+			if (counts[bit]++) {
+				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
+						       setup_pebs_adaptive_sample_data)
 			}
 
-			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
-
-			unprocessed[bit] = at;
+			last[bit] = at;
 		}
 	}
 
@@ -2487,28 +2493,8 @@ static void intel_pmu_drain_pebs_icl(str
 			continue;
 
 		event = cpuc->events[bit];
-
-		if (!iregs) {
-			/*
-			 * The PEBS records may be drained in the non-overflow context,
-			 * e.g., large PEBS + context switch. Perf should treat the
-			 * last record the same as other PEBS records, and doesn't
-			 * invoke the generic overflow handler.
-			 */
-			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], false, data);
-		} else
-			__intel_pmu_pebs_event_output(event, iregs, unprocessed[bit], true, data);
-
-		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) {
-			/*
-			 * Now, auto-reload is only enabled in fixed period mode.
-			 * The reload value is always hwc->sample_period.
-			 * May need to change it, if auto-reload is enabled in
-			 * freq mode later.
-			 */
-			intel_pmu_save_and_restart_reload(event, counts[bit]);
-		} else
-			intel_pmu_save_and_restart(event);
+		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
+					    counts[bit], setup_pebs_adaptive_sample_data);
 	}
 }
 

