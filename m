Return-Path: <linux-kernel+bounces-274426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C49477F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF1B1F222FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3C154BE5;
	Mon,  5 Aug 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EvADm3b3"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9018149C58
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848775; cv=none; b=o1REbFxm1uKAuEv75yjyC3qvVH+Fwti5dEg81umTs+U55KqFzyYL6f8Bx1TUEZMCCQ17eeISIJwgCfRUnqnzmqof0pegE5I6h2vMeH4TubD6OLF/ZwRvLpzXaWFkSqWs/zVCl3Y4XgQTmkMHKidmHD1xMlX9BjsdY44GSTb1bpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848775; c=relaxed/simple;
	bh=URnYOkdc3Iuqs2QwYqOoZNJZBnujDqKrXGuALlPjetg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNYtv1w5dMSBACmB9GMKzREeKFmTKyPH98zJc7o4VxOEYLTWdIweXtx9ZePq5tiJyvQ6gEGk7UowCEviwvJmZ2M0bp8/dP09c88JIL1ztd60rBOiJ/RrFEcldXOWMlOFdZr1+nWIQB3xDWDWzLmUGWqDD+3GflnkODG54S8XRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EvADm3b3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=84Q78LrUDPiYL6Ms/QonEFDaxPvC4jQ9HqWHLAg40zU=; b=EvADm3b32fzQWkIkPtQu/Gavtw
	wAMhoHoizwEkcKgaOx5O1Efj4nkBPDXm3HqWMUaW+ODE9Mx/Q8yiog98qmUaTkDB1Ys1mLmRkO1FM
	OyYWQ1KCSZbcz8+rzGuIx5GJuflHuyZIqz3f9Ja/dhTkaykEkVaCSizlEJfQaTFO4jn1WOb4bWsjT
	Sx/N7gOb0N3+EsREW6mABb3yfuBcKEGreNd+Y3rzQvR5Z71Qs53uZYtxoRWaBEkGvNAt2F5t33vU7
	w52hC5r6Em21qTB4dxnfyHVJQJqNPqGCXzgbeoAdyF8AZKogYFvRhuXn33I75TuyopAi85UNPX0WJ
	trWKaPWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1satfD-00000006DKQ-2sLw;
	Mon, 05 Aug 2024 09:05:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CD70830049D; Mon,  5 Aug 2024 11:05:58 +0200 (CEST)
Date: Mon, 5 Aug 2024 11:05:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
Message-ID: <20240805090558.GI37996@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net>
 <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net>
 <20240802191123.GC12673@noisy.programming.kicks-ass.net>
 <20240803103202.GD12673@noisy.programming.kicks-ass.net>
 <CAM9d7cgNZQrJk7-TnMgqvCMpkYkcpBT78Ts_5oTsAzNB9gp+_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgNZQrJk7-TnMgqvCMpkYkcpBT78Ts_5oTsAzNB9gp+_w@mail.gmail.com>

On Sat, Aug 03, 2024 at 10:08:32AM -0700, Namhyung Kim wrote:

> > @@ -2802,9 +2821,10 @@ static int  __perf_install_in_context(void *info)
> >  #endif
> >
> >         if (reprogram) {
> > -               ctx_sched_out(ctx, EVENT_TIME);
> > +               ctx_update_time(cpuctx, ctx);
> 
> So you don't want to stop the context time while adding or enabling a new
> event, right?  Then I'm not sure if it's needed to update the time here as
> it'll be updated in the ctx_sched_out() again.
> 
> Also calling ctx_sched_out() will clear EVENT_TIME when is_active has
> no EVENT_ALL and it'll stop the context time anyway, right?
> 

Hmm, I knew I was missing something. Let me ponder rhat a bit more, and
maybe read some of the history on this thing back to remember what exact
issue was being fixed here.

> 
> 
> >                 add_event_to_ctx(event, ctx);
> > -               ctx_resched(cpuctx, task_ctx, get_event_type(event));
> > +               ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> > +                           get_event_type(event));
> >         } else {
> >                 add_event_to_ctx(event, ctx);
> >         }

