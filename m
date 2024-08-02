Return-Path: <linux-kernel+bounces-273013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C491F946360
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6677EB22590
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DBD1537CD;
	Fri,  2 Aug 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KvSO2EOC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5A1547C1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624632; cv=none; b=VA57FKa5gRG4pw6jB6ADWEeoqGlokrReqs/VHa0GZXYFjL8+CiOXtC4/5F/0AsCGKmcZMbNPzifFo0mHXfLgxE5MXj2RDESoR8zXPUFVlZfBfzl41+m+2VCWmKWhMRJsXMon0JQN3UHaRdmbiB+F9mdLApztKNK5In8VMhvhzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624632; c=relaxed/simple;
	bh=INfyw6aBf470MV/zONmgoFVaPq/bFAE6pYgqXEXPo8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9yNq7f5WUIWJVnv/QMVdjDyl9J/RHqHz6x1buik2npgbQ4Htl8JIwqy9ZRqHCVG8t3/2BuA5Ftcm+tAvmBmnjb3myxOcnET4ThzUQlo5eDr7xIdH+3PIRXRs76unIH1RWkFYk98LmhZsGPQ522XNatwsPhTAt9znsedwEeMTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KvSO2EOC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WPImwEiflvFURWxUOjz84wTDPACq/v7UmiTC1qbDUO8=; b=KvSO2EOCp+dmaR9MU3s3yYKG2e
	Q8P2w999IjsxeK6Lc5HBOeHeAlRZTBmRM1CDlBapXvj0rPhq2h3A9eJfRl3ztNxCh7j3hrk61+lpt
	uanYt18tgWbFSAhIiSALft3Rdn1wKvb5bK+wq3nYpZ2MyNjqCmQT+EyxQI3QHjgi1LVJUoiZWZF0p
	gNkn+XUivvmZSIVwTnMUno7CWwTpfUVeX/yKmYZo8FPHTIPIBs+SKd0sxMb5My7c5Z0CTPRapSGbi
	8VhKmkP9+GrznBTa9Rychc15ZdHXW6gS7tYy10Y5nwufCWslnTYWUqFZW4kH6j5ysZpHmMaQj746E
	OtS5C4mg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZxM8-00000001Jt1-0bLH;
	Fri, 02 Aug 2024 18:50:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A192930049D; Fri,  2 Aug 2024 20:50:23 +0200 (CEST)
Date: Fri, 2 Aug 2024 20:50:23 +0200
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
Message-ID: <20240802185023.GB12673@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net>
 <20240802184350.GA12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802184350.GA12673@noisy.programming.kicks-ass.net>

On Fri, Aug 02, 2024 at 08:43:50PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 08:38:41PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > > > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
> > > >  	if (reprogram) {
> > > >  		ctx_sched_out(ctx, EVENT_TIME);
> 
> Clearly I should read better...
> 
> > > >  		add_event_to_ctx(event, ctx);
> > > > -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
> > > > +		if (ctx->nr_events == 1) {
> > > > +			/* The first event needs to set ctx->is_active. */
> > > > +			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
> > > > +		} else {
> > > > +			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> > > > +				    get_event_type(event));
> > > > +			ctx_sched_in(ctx, EVENT_TIME);
> > > 
> > > The changelog doesn't mention the time difference much. As my
> > > understanding, the time is shared among PMUs in the same ctx.
> > > When perf does ctx_resched(), the time is deducted.
> > > There is no problem to stop and restart the global time when perf
> > > re-schedule all PMUs.
> > > But if only one PMU is re-scheduled while others are still running, it
> > > may be a problem to stop and restart the global time. Other PMUs will be
> > > impacted.
> 
> So yeah, this stops ctx time but not all PMUs.

But isn't this already the case? We don't have perf_ctx_disable() here
currently. 

Bah, this heat is melting my brain.

