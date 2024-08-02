Return-Path: <linux-kernel+bounces-273008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E2A946352
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4828283157
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702A136326;
	Fri,  2 Aug 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bX4LxhI2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC74C61B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624240; cv=none; b=bdHhfZ72pvR9JjRQ79GPe9LbCTaZr7AerGW6KhrQFuGKTetGYM/hfUiKDlYg8WfI5lMIXCcTLYoS1Sanl/sXLwTiMW2s2llMoLElPqBY+n5PxaRUoIyHBoCeubJUjaMkdxiLEmEIYjSmPDxnSQqbKqxbLQdNxfuC/UIjXiHZGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624240; c=relaxed/simple;
	bh=vkILObDDaBAmPEQPh/MIbVznqs1IupGG0nSX5dATWW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSCFD+wLJmJiQ+qVfl/mTw4nSPTDfpqRfpyIHjt2HO4SDtPEk46AFOuldmJiniro59evMq0IOWz1k5JBn/l6x2vYG0ebVzhf2jotS966n8z4F3gQtkdDbTmcmfIqbqkALb4gezoxSOxfclumcvB/WFRsUbaBsLuMwHHbThTmNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bX4LxhI2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wfGBToXbAaJrKPiw+VN3Q+SYbknO7OxHUxIQS22J6l0=; b=bX4LxhI2h2bcI65SZMgdqe8ffS
	xqdKsu2cpT8DD1ldb35k8g/mF7LIbRhh4/VRtrZVCPFI0XgnvU1S0/wCJga7rVvOT2tZBukLSCrYi
	kvXD608JLimhUYrSfIypVcZvamZ8+8v69TEgMCfy76LVMWa0iScQwPs3zczuGllnL2tNbHmH2PbAw
	bTH6jtRW8Vjt9Pb9UVXGZaI9oBqwDKoRrCy7ZK0reQVHnL+16TFWBKnVOO3tzDP/BUlf5RXysalnm
	nxmwTOkcQm6mJhwCsyhRq6PHfYOv7L7hRLh+yY9r+V77+H8HIqbPg5WUzdz3JKPlcKDoxgJbcd8Du
	wMetNBNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZxFn-00000005lvd-2mhA;
	Fri, 02 Aug 2024 18:43:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BE5FE30049D; Fri,  2 Aug 2024 20:43:50 +0200 (CEST)
Date: Fri, 2 Aug 2024 20:43:50 +0200
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
Message-ID: <20240802184350.GA12673@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802183841.GG37996@noisy.programming.kicks-ass.net>

On Fri, Aug 02, 2024 at 08:38:41PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
> > >  	if (reprogram) {
> > >  		ctx_sched_out(ctx, EVENT_TIME);

Clearly I should read better...

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

So yeah, this stops ctx time but not all PMUs.

