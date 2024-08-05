Return-Path: <linux-kernel+bounces-274451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBD94783B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37AC1C210E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF615250F;
	Mon,  5 Aug 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SPFPbf5o"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9B150990
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849666; cv=none; b=P93f/CkTSqEvFy3GYzaSnqMhrO1rQrZRB8EBsY3t22qPfA8u3iGcVDPffw1qNyglf+f7VQ1Zrobq2cXAU0zVLKtzucGsk6gmfKoIEM5i62n+noTXv+5cYbRLV+kx2pZuNeezxExXR8WdgN4cpmQmuhj9ppGN2RVqVhe+75Wi6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849666; c=relaxed/simple;
	bh=ZGqefai0OS0zHsEh8Ul0oOs2R9Ynkl04eNCt3vmq4ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm66sXRe+l6D/EdEZdlF0Bw5xLZjDKj7cDt2eWJQb3l69kOl/Zc7znync4JDFJpSbsqwHbNM8MFPJtNl/2ywPLXafikbFBAv+saFDxW/p2DPnGo7qiExkuOAlyoZtlvpzdLlOC1pTmWBDzglsmI8q7zlMs91iiEdM8p2NaQE8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SPFPbf5o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k++1pO7oYAupqj3ZMrXq1xBMzAca0TnS5jPhUC431Gs=; b=SPFPbf5oRXVI+Web31gnAunFBl
	5X+Zr8bP+HFID2P/2BTbCpmuB8saBdHoShxb7ZSm4Bs4keTrfOcXPKA82rjUnpHLWTcMRkEcOCvx+
	FgdyyPmUVVmEDLFRPtwnGxXdLWDda2pCR0Aepl4anLJbo572qho5pQ909gV0EEOyM7qTsNUYEGgZV
	vF8YZz9Dhr3horNhwWD+MeMfzbkHuJO+r7XJk9CKLIMptpQ2zQft5ePlDNe6izmMEOWLcSFh4ErTh
	mYRx87fXxaetW2yaLgwdDY2FlSso9LMhq3KjTbsEJkNld00SkATi1PL7fNepzL7qWgUSQhZz//hRI
	B1TzAN0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1satti-000000045wj-2fjQ;
	Mon, 05 Aug 2024 09:20:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 446C830049D; Mon,  5 Aug 2024 11:20:58 +0200 (CEST)
Date: Mon, 5 Aug 2024 11:20:58 +0200
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
Message-ID: <20240805092058.GK37996@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>

On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
> >  	if (reprogram) {
> >  		ctx_sched_out(ctx, EVENT_TIME);
> >  		add_event_to_ctx(event, ctx);
> > -		ctx_resched(cpuctx, task_ctx, get_event_type(event));
> > +		if (ctx->nr_events == 1) {
> > +			/* The first event needs to set ctx->is_active. */
> > +			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
> > +		} else {
> > +			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> > +				    get_event_type(event));
> > +			ctx_sched_in(ctx, EVENT_TIME);
> 
> The changelog doesn't mention the time difference much. As my
> understanding, the time is shared among PMUs in the same ctx.
> When perf does ctx_resched(), the time is deducted.
> There is no problem to stop and restart the global time when perf
> re-schedule all PMUs.
> But if only one PMU is re-scheduled while others are still running, it
> may be a problem to stop and restart the global time. Other PMUs will be
> impacted.

So afaict, since we hold ctx->lock, nobody can observe EVENT_TIME was
cleared for a little while.

So the point was to make all the various ctx_sched_out() calls have the
same timestamp. It does this by clearing EVENT_TIME first. Then the
first ctx_sched_in() will set it again, and later ctx_sched_in() won't
touch time.

That leaves a little hole, because the time between
ctx_sched_out(EVENT_TIME) and the first ctx_sched_in() gets lost.

This isn't typically a problem, but not very nice. Let me go find an
alternative solution for this. The simple update I did saturday is
broken as per the perf test.

