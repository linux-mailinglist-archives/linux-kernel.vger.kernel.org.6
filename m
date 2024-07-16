Return-Path: <linux-kernel+bounces-253842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453B9327C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E321C224FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914419AA7D;
	Tue, 16 Jul 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRSsuyxh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A910136643
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137662; cv=none; b=PkT6jJA6JZWXsYBzDAYoi2E6w33myZakmnr4mpAm6o5Dzl6UINbmEArmG+dpl4+fBtrXH25PWnQLTdb55BcQyHZzo1k/C96+35GGKHc22wmGOlZ8eCebezwdy0zB2+iMEsT20weSX5TMExWRgcYOM3LhfxYqUrbXrforNruEkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137662; c=relaxed/simple;
	bh=d4xbkgoKrbNv4annTBHUMlhZ8FjH2o1EguNjxsbJz40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry67PYeUa4Deg7KtB37uKrUtxqyiwJFwwQ4DQDdM76RWLHJN7jIDWsLS4DT11qPaT9+bI/MLONRUrNuWhTLBaYvSW3tvieQ5xqebVAJ7xhTBtfw8e38DRf8vLeKDqSrWwL+puD6Zv68rPgp634LTMuVXBG4+yQw7ecYwfoht3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRSsuyxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FA5C116B1;
	Tue, 16 Jul 2024 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721137661;
	bh=d4xbkgoKrbNv4annTBHUMlhZ8FjH2o1EguNjxsbJz40=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BRSsuyxhVR9SryE7S294jwKpvv8gpIjXZJgDLhO6G9KNW7fXZ9Za90yXGE+o/gxXT
	 n96xZLXyjDub+GXlkhFM9h4IxbxNxagfIT8Z/a3U4nfR8rGvNuXPqPMeb3yAntQgS0
	 w7Wf4UwTrrfPlp3U/sh2TvFN/RODBnIMy7/Ia21wZ7sA8Sgv40wp5aLy4P2Bz0cAxT
	 FyIcsILEZs5SPYHq0hZreMk3pfJDJTWKRmZo7f9AfBMh8pSv4vVkVI6/2yIF+BzJAZ
	 cNGPyXOmKpUK6p5CGkDViJ85ngbKBPqo3uABxSfDpIyII7aSIWYz3wBWtZ4EQEIdOt
	 AFbCSb2z5m6FA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 65212CE0A70; Tue, 16 Jul 2024 06:47:41 -0700 (PDT)
Date: Tue, 16 Jul 2024 06:47:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, neeraj.upadhyay@kernel.org, mingo@kernel.org,
	rostedt@goodmis.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] smp: print only local CPU info when sched_clock goes
 backward
Message-ID: <b108d8bb-8fe7-451c-8729-9439da221d0f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240715134941.7ac59eb9@imladris.surriel.com>
 <20240716090443.GQ14400@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716090443.GQ14400@noisy.programming.kicks-ass.net>

On Tue, Jul 16, 2024 at 11:04:43AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 15, 2024 at 01:49:41PM -0400, Rik van Riel wrote:
> > About 40% of all csd_lock warnings observed in our fleet appear to
> > be due to sched_clock() going backward in time (usually only a little
> > bit), resulting in ts0 being larger than ts2.
> > 
> > When the local CPU is at fault, we should print out a message reflecting
> > that, rather than trying to get the remote CPU's stack trace.
> > 
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  kernel/smp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index f085ebcdf9e7..5656ef63ea82 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -237,6 +237,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> >  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
> >  		return false;
> >  
> > +	if (ts0 > ts2) {
> > +		/* Our own sched_clock went backward; don't blame another CPU. */
> > +		ts_delta = ts0 - ts2;
> > +		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);
> > +		*ts1 = ts2;
> > +		return false;
> > +	}
> 
> So I've seen some chatter about this on IRC and was WTF, seeing this
> patch I'm still WTF. What is going on with those machines?!?!

I wish I knew, but for the record, I completely agree that both your
acronym and interrobang apply to this case.  ;-)

							Thanx, Paul

