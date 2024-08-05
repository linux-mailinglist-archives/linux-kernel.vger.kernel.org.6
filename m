Return-Path: <linux-kernel+bounces-274833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F25947D5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6791F21E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27514885C;
	Mon,  5 Aug 2024 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wEnNf31T"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724413C9B8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869924; cv=none; b=UD6npobxU/z+Du46eJzLCaeyHu7lJvsNmkxb+fGw7rsyLSfyeIyOgcoyhps2ASUiBPm/idi3+mx4Q0wS+yqtpylpat8xg6E2lwSvgNlnOhHL7CLXJF/bqvAw+zNvFX0qtt6Ene0SrqtazJYAffFz4r3XISD8J4Gd4uMqawKOxAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869924; c=relaxed/simple;
	bh=Ytn1DDqDvguWY3GcpK51RS63eGa7WFpNlcpwcE+0Q7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bREjJUrfp67qegScaTLVlInltW/Zop3Cg7ODbXk6nW080rp4Yor2GLb3inhD84s+JXY4XG1JR/FtB7S6vRASjqOPUViLB7fDOKV7mAMrXra1KuE5+y+LKN8teDDxzoWrqZXKn0x4HJhhMeZWCyp5A7+ldggsZdKNDkT+ll7Kiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wEnNf31T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wB+aSUJWkaajUkUiu66Jm44Q6cDYnpekCsT2iKiBTvg=; b=wEnNf31TItezsNOufcRVUtBfII
	un8YIb+pUZPMHvoiKmam5qS1briri7HYZCgVvFGd2nxqfI6+xStAk+dqZWhjQRXlAG2tFS8wJ7mrX
	SZt2zqG+4JPLdnv68IkJ40LBwsLGK4UaHLc5Yy0/RAp/SyTJOiG02HvPmQMIP5wrQbwy0f+Wl/geG
	LeDVObEA02NinwR5j9jJssSa/pktOBIp7N6BEQV94dob07bwA2YpZ2GVLijGUw8DiedxTIwBs46ce
	XSRFTQSn4Mqvmpk37RsWjmiZCZNoJzRabiVvEQWFqwOi77D5XipEXIH29FfEyDhUwxOaMSfbYDpWl
	pss9+bXg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sazAL-00000004MbS-0GPW;
	Mon, 05 Aug 2024 14:58:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE8E730049D; Mon,  5 Aug 2024 16:58:27 +0200 (CEST)
Date: Mon, 5 Aug 2024 16:58:27 +0200
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
Message-ID: <20240805145827.GE12673@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240805092058.GK37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805092058.GK37996@noisy.programming.kicks-ass.net>

On Mon, Aug 05, 2024 at 11:20:58AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
> > >  	if (reprogram) {
> > >  		ctx_sched_out(ctx, EVENT_TIME);
> > >  		add_event_to_ctx(event, ctx);
> > > -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
> > > +		if (ctx->nr_events == 1) {
> > > +			/* The first event needs to set ctx->is_active. */
> > > +			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
> > > +		} else {
> > > +			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> > > +				    get_event_type(event));
> > > +			ctx_sched_in(ctx, EVENT_TIME);
> > 
> > The changelog doesn't mention the time difference much. As my
> > understanding, the time is shared among PMUs in the same ctx.
> > When perf does ctx_resched(), the time is deducted.
> > There is no problem to stop and restart the global time when perf
> > re-schedule all PMUs.
> > But if only one PMU is re-scheduled while others are still running, it
> > may be a problem to stop and restart the global time. Other PMUs will be
> > impacted.
> 
> So afaict, since we hold ctx->lock, nobody can observe EVENT_TIME was
> cleared for a little while.
> 
> So the point was to make all the various ctx_sched_out() calls have the
> same timestamp. It does this by clearing EVENT_TIME first. Then the
> first ctx_sched_in() will set it again, and later ctx_sched_in() won't
> touch time.
> 
> That leaves a little hole, because the time between
> ctx_sched_out(EVENT_TIME) and the first ctx_sched_in() gets lost.
> 
> This isn't typically a problem, but not very nice. Let me go find an
> alternative solution for this. The simple update I did saturday is
> broken as per the perf test.

OK, took a little longer than I would have liked, nor is it entirely
pretty, but it seems to pass 'perf test'.

Please look at: queue.git perf/resched

I'll try and post it all tomorrow.


