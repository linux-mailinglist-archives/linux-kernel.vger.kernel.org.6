Return-Path: <linux-kernel+bounces-273005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E1946348
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506DA1C217EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E9136320;
	Fri,  2 Aug 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZvhFO22"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF81C69D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623930; cv=none; b=HHaK0EdyRq3mPxMs4zEuxtPDZq/EGr0uIl1yzu/Zzlz5OZw73LpaAxuImzyGBHrVYTgCySMxHgiVQ79DhGjQFqAIzNNWtbpbNVHRn1P3AJ85U6N4uyOl+jCTBd61DY2xOZ4LX6Zv8dMt4H4NyqPzySNvR8ZdOe0qY/lb34L6htQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623930; c=relaxed/simple;
	bh=ZR2pYKKl8luyxuHiVZyyRHfP+/Jxkshx87A1xC5vFBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUHXnQS3xW+J07WF3yEFJ2G0nfd3jZ3RUKom7sjcz9JV0P8EunZI0lNutac1uXc1Warp2kSrWyMvSST1hW/23nBBvSZas1CIxuwmQ6Sr4N418kzReSUlYHggW2tj+mlg92M+YPPoIxvby+PCvqbnzDpTcQL9CmOPjDR7UqTpaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BZvhFO22; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XN9nr7I1tfglz8RcDAjNcRiG6nKpWdRkiBcEZVcFUN8=; b=BZvhFO22c0HFtnF9mhZYSVoSqz
	sg+KhB1oN+LNIXG5YdNcJo24OZahv5J6Rnlh2K2paOJPoVp9F/x4W5HLD6PaJEHrhULG3R8lAbW3R
	Iv3+1yYNvcGFcfU/LnQGMvY6M6frYyZ9CQ2jPtrshiXcEZfcsPvdanfpMPx8FS5T82kkod4uzwjD2
	qBUfiq55+Lkm0WULFBh4LNhxaJPSDpK92KtzlSO/16rdsfUyO1UGpWBDK5uStczumtHJuQtrqwhMv
	kf5nU8WWAaHOlQtMp7uRPcVAF9ey6HoLSPfJ/dY8B/Jv/HRQkM/741n75BGEUbFfqtfXL6mPbKvRw
	PNiE/JAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZxAo-00000001JPe-2wKz;
	Fri, 02 Aug 2024 18:38:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA8E230049D; Fri,  2 Aug 2024 20:38:41 +0200 (CEST)
Date: Fri, 2 Aug 2024 20:38:41 +0200
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
Message-ID: <20240802183841.GG37996@noisy.programming.kicks-ass.net>
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

ctx_sched_in(EVENT_TIME) will onlt start time if it wasn't already
running. Also note that none of the sched_out calls have EVENT_TIME on.
So it will not stop time, only start time if if wasn't already running.

At the same time, that's likely only the case when nr_events==1, and in
that case it already calls the full fat version.

Anyway, this exception is part of the reason I don't like any of this
much. I'm staring to see if there's not something saner hiding inside
all this.

