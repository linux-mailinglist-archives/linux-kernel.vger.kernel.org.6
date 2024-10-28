Return-Path: <linux-kernel+bounces-384779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F89B2E47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E641F225D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252181D88C4;
	Mon, 28 Oct 2024 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QleFMc70"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C21D88CA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113135; cv=none; b=HcCSrdqJiGUsW5ITuFAUosLlM8IjSkOsLZ8N3bn8WZampYZSRGT7V2V/X1OVjn5tWYtM77VtT+/SA8mLM0D1P3GIiVsB7SXmjZTdO5gyATNdGM1VdMJvuNLt7vGOZILB5GjW425aSQZ3yYfoheyKUvcjVhkld+67ixj1adjgvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113135; c=relaxed/simple;
	bh=xf8aO3lmuXlaz7Und2tf+wW6sDakijPooBImgyyeKJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccMYH4o0cdbY0kZ+40ifoNkoTJTtokSpHJlEnwAAL4YwdYsFxOwT01YMpTsFWA6BGDQxt1/uoBdUxL7HVaiVkpwo9Vy6p1WWcEx4D7Dc9OTvnw90pBopCI2s8Pp+W5j/8cXUV+sVWuDbBziOlqJRxOZq+Vc54qaoeGbHS4zbrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QleFMc70; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VoUzyzaYLgi7lROkPTS8N8+Q9m2MKo5YaCvYU6N/urE=; b=QleFMc70VyA6MUUN/zgg4ovyqo
	qGah9Gnl/a7WhZfIKsGE8WbHP1fkZ8IC1Z9+JmA+/4005IvvFpoXUlV9SyOxGPCh7hBvyo0TTGjlw
	2TaBzvO389LMKOXouu+AShcODwbpEG9aPc7eiFUYoloEx8yq37nBrhqCK1p5l9/NPvXbFie3xfcRg
	LuC1Y0HnvXpFwpLHZobaBFZKQer5kwJeXtO3iEmsinjgrI1+gyZn9XgTKJJF3rEa2l/bPkibfIWUH
	2AYEpD55V8bPr9elc7gGRXrQ+RBd3As+WF+yjXx7tXMeM+XNyPz5bOlaJrWFezFtGTrfZFA+gbmHk
	c04nObAQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5NSU-00000008KjW-3sF7;
	Mon, 28 Oct 2024 10:58:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2803530083E; Mon, 28 Oct 2024 11:58:51 +0100 (CET)
Date: Mon, 28 Oct 2024 11:58:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] sched/idle: Switch to use hrtimer_setup_on_stack()
Message-ID: <20241028105850.GP9767@noisy.programming.kicks-ass.net>
References: <cover.1729864615.git.namcao@linutronix.de>
 <db5daed82f8ba69eb155171ed96f3a5a83cd483b.1729864615.git.namcao@linutronix.de>
 <20241028090927.GI9767@noisy.programming.kicks-ass.net>
 <871q004i2j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q004i2j.ffs@tglx>

On Mon, Oct 28, 2024 at 11:50:44AM +0100, Thomas Gleixner wrote:
> On Mon, Oct 28 2024 at 10:09, Peter Zijlstra wrote:
> > On Mon, Oct 28, 2024 at 08:29:37AM +0100, Nam Cao wrote:
> >> There is a newly introduced function hrtimer_setup_on_stack(), which will
> >> replace hrtimer_init_on_stack(). In addition to what
> >> hrtimer_init_on_stack() does, this new function also sanity-checks and
> >> initializes the callback function pointer.
> >> 
> >> Switch to use the new function.
> >> 
> >> Patch was created by using Coccinelle.
> >> 
> >> Signed-off-by: Nam Cao <namcao@linutronix.de>
> >> ---
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> ---
> >>  kernel/sched/idle.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index d2f096bb274c..631e42802925 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -399,8 +399,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
> >>  	cpuidle_use_deepest_state(latency_ns);
> >>  
> >>  	it.done = 0;
> >> -	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> >> -	it.timer.function = idle_inject_timer_fn;
> >> +	hrtimer_setup_on_stack(&it.timer, idle_inject_timer_fn, CLOCK_MONOTONIC,
> >> +			       HRTIMER_MODE_REL_HARD);
> >
> > WTF is hrtimer_setup_on_stack() ?
> >
> > Do NOT send partial series. How the hell am I supposed to review things
> > if I don't even get to see the implementation of things,eh?
> 
> Can you tone down a bit? This was an oversight and I did not notice when
> going over it. The full thread is in your LKML inbox, so can you just
> move on?

*sigh*.. how am I supposed to know it's an over-sight? Some people are
actively pushing for this broken arse 'model' of posting.

Yes, I can dig out the remaining patches, but that's more work for me.
As you well know, I don't really need more work.

I suppose I'll see a new posting eventually or not, who knows.

