Return-Path: <linux-kernel+bounces-268213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCF9421BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B448BB22F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4018DF91;
	Tue, 30 Jul 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YVXCbvoc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5518CC0D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372060; cv=none; b=KKvdWAGtR3NELUl/G+iGc/Ynpi1sdWllgpCLFY4YENbcBkTvW3f+/oA+/28vxI9JU++1itIVUd4c4n8ZbeO1t6jy6wHo6RK/lE9GBPzd5e7gj040Y/MEB5DpAMRF/OCVMNFeg+irxXb9ke9k1pRM36rQ8JEmf+66XTRpKKDCV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372060; c=relaxed/simple;
	bh=aGnf5mUV/jrJCzJUDIo5muTdsV1n/LpW/ri+glN9RZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCJOX2aHecNae6Y76zRNrrFAOESDFpRLZnvNjdU4lJ/3vy4zVpsC3cFHNZCxyVT7EwmKFBEghBqSPvuyQKEO6ZBouBtEeO/Piy8n+Dm0PdSuZ/kRPA4j5wSAqcm5PVFIbXaGi5SBfsSvIkPn/2HGjyR2yLMR4PCG90CJAcEwehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YVXCbvoc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fd6PQji+XcGmpFLCdC04neniE9LX1dzyzIHk7IMPYds=; b=YVXCbvochBCAKkrQyIEA6ciwPJ
	Gfcfp5PMfJ/UM6PeXR+J64CxH2jKYMFbDnOlWaup+knfaAlRF+n4vMMomF2PbcptcXRtmwa9wt5pX
	zbA85TZFmI7ODeEAk/8XOiR3NJ2WDBldQzkwQdr6YMdskFuKbOU6n5+1TQoDcsLCXg8WBlRrHJ02L
	Ov7j3gLd9BTSugdi3TjCEUIJVsQR5ahNn5aREDJ+7QxiTw0OxxOZ/9V9mCO7gHmm0RHt3Db22xvbf
	kjK1TjFb6VejTx/X1U9hEwwC48F9XpyrFPawKjMVOJqdUznExmJ72tCQcvvm9X2gyXLylPSspkV+T
	bJb11TDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYteL-0000000554a-2FjL;
	Tue, 30 Jul 2024 20:40:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 229F73003EA; Tue, 30 Jul 2024 22:40:48 +0200 (CEST)
Date: Tue, 30 Jul 2024 22:40:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH] perf/core: Optimize event reschedule for a PMU
Message-ID: <20240730204048.GU33588@noisy.programming.kicks-ass.net>
References: <20240730191925.469649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730191925.469649-1-namhyung@kernel.org>

On Tue, Jul 30, 2024 at 12:19:25PM -0700, Namhyung Kim wrote:
> @@ -2728,13 +2727,62 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  		perf_ctx_enable(task_ctx, false);
>  }
>  
> +static void __perf_pmu_resched(struct pmu *pmu,
> +			       struct perf_event_context *task_ctx,
> +			       enum event_type_t event_type)
> +{
> +	bool cpu_event = !!(event_type & EVENT_CPU);
> +	struct perf_event_pmu_context *epc = NULL;
> +	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
> +
> +	/*
> +	 * If pinned groups are involved, flexible groups also need to be
> +	 * scheduled out.
> +	 */
> +	if (event_type & EVENT_PINNED)
> +		event_type |= EVENT_FLEXIBLE;
> +
> +	event_type &= EVENT_ALL;
> +
> +	perf_pmu_disable(pmu);
> +	if (task_ctx) {
> +		if (WARN_ON_ONCE(!cpc->task_epc || cpc->task_epc->ctx != task_ctx))
> +			goto out;
> +
> +		epc = cpc->task_epc;
> +		__pmu_ctx_sched_out(epc, event_type);
> +	}
> +
> +	/*
> +	 * Decide which cpu ctx groups to schedule out based on the types
> +	 * of events that caused rescheduling:
> +	 *  - EVENT_CPU: schedule out corresponding groups;
> +	 *  - EVENT_PINNED task events: schedule out EVENT_FLEXIBLE groups;
> +	 *  - otherwise, do nothing more.
> +	 */
> +	if (cpu_event)
> +		__pmu_ctx_sched_out(&cpc->epc, event_type);
> +	else if (event_type & EVENT_PINNED)
> +		__pmu_ctx_sched_out(&cpc->epc, EVENT_FLEXIBLE);
> +
> +	__pmu_ctx_sched_in(&cpc->epc, EVENT_PINNED);
> +	if (task_ctx)
> +		 __pmu_ctx_sched_in(epc, EVENT_PINNED);
> +	__pmu_ctx_sched_in(&cpc->epc, EVENT_FLEXIBLE);
> +	if (task_ctx)
> +		 __pmu_ctx_sched_in(epc, EVENT_FLEXIBLE);
> +
> +out:
> +	perf_pmu_enable(pmu);
> +}

I so dislike duplication...

So lets see, ctx_resched() has pmu_ctx iterations in:

  perf_ctx_{en,dis}able()
  ctx_sched_{in,out}()

Can't we punch a 'struct pmu *pmu' argument through those callchains and
short-circuit the iteration when !NULL?

The alternative would be to lift the iteration I suppose.

