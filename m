Return-Path: <linux-kernel+bounces-273032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D5946393
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEC51F225A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260481547EC;
	Fri,  2 Aug 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7v8xF2G"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B77F6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625928; cv=none; b=Rak4P9XGCeENOA1LReDt+maI4PDJ6E5hdGV2pBBoiJg8NOhHJv6FT1N7+/28r5qY1krzGrkjAQ0UGzHQFcGRjO9aXb+TTQtH72DtBx8IbmR2OxQjdCBy3lGjjGOPRqlVJComizyBhwvGii8U2G7EW2JTVhKKbRkajQu4d3xXA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625928; c=relaxed/simple;
	bh=zGAtBnlADNhuZeKAi4InSlGBAmCdQ04gGx2WWXGPmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b52BrEH4mlLwTdr7JSAlg9qFoFIfcfedVz+/5C4ZX6gu7dLrRF3sYj6WzFFobt0/Gi0ollx89YzIcgb0H8URsswOrr45K5Ts/+8nMDW3niFfoXBcgsWBDdZDNLkp35i2oBRHoE5neXw65GKYf6BTPqYFLBD9YTA7FSEPJJ6sfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A7v8xF2G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L3tWoQ128xb5Yre0eBQXeRssQQvrUitEP99Y3gbl47k=; b=A7v8xF2GbPYqHLF7aAvIcDPNAy
	DTgaBINeWKCfFh8bcd0A1L91mu/7AHl9e1m3j90+yfpXlUkuWNCRRdpRihXkI0igGnH44wQt8aa5w
	b5NNwovhUT8qhCHcRH8Oob30m1AHET2wUzErgxIDSE9RdptwV0pcAflbHMjDpwsXkcKw1tmCtLSx9
	WaeMV8RSwoR0yNZjLR8Sx0Zt9yplN8yC7IAnPODEPKzRJfSs6Gdd3alLF+ySo3exagRi86y1s/nKA
	NjTlvX4kGQkIUZZobZ/C9AZl3RrwvbMBgwTkJnVQKW4a6i36AOQMjVX2z4MUCVPeYBgqEj0Z6Tucv
	0f5kX4Hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZxgR-00000005mDR-1z74;
	Fri, 02 Aug 2024 19:11:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F30230049D; Fri,  2 Aug 2024 21:11:23 +0200 (CEST)
Date: Fri, 2 Aug 2024 21:11:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
Message-ID: <20240802191123.GC12673@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net>
 <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802185023.GB12673@noisy.programming.kicks-ass.net>

On Fri, Aug 02, 2024 at 08:50:23PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 08:43:50PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2024 at 08:38:41PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > > > > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
> > > > >  	if (reprogram) {
> > > > >  		ctx_sched_out(ctx, EVENT_TIME);
> > 
> > Clearly I should read better...
> > 
> > > > >  		add_event_to_ctx(event, ctx);
> > > > > -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
> > > > > +		if (ctx->nr_events == 1) {
> > > > > +			/* The first event needs to set ctx->is_active. */
> > > > > +			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
> > > > > +		} else {
> > > > > +			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> > > > > +				    get_event_type(event));
> > > > > +			ctx_sched_in(ctx, EVENT_TIME);
> > > > 
> > > > The changelog doesn't mention the time difference much. As my
> > > > understanding, the time is shared among PMUs in the same ctx.
> > > > When perf does ctx_resched(), the time is deducted.
> > > > There is no problem to stop and restart the global time when perf
> > > > re-schedule all PMUs.
> > > > But if only one PMU is re-scheduled while others are still running, it
> > > > may be a problem to stop and restart the global time. Other PMUs will be
> > > > impacted.
> > 
> > So yeah, this stops ctx time but not all PMUs.
> 
> But isn't this already the case? We don't have perf_ctx_disable() here
> currently. 
> 
> Bah, this heat is melting my brain.

I think all it wants is to update time and ensure the added event and
the resched all use the same time, which could be done differently.

But I'll have to continue staring at this later.

