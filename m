Return-Path: <linux-kernel+bounces-357729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35869974CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4C31F2165D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F01E0DD6;
	Wed,  9 Oct 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZuuHnP6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130C52F9E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497915; cv=none; b=s8Hu0dYp4jYSdBj3l+4uIWLLnIUjHYi/YtLi+sRhAhWbvfqqgPkmd71R8AEiXMWim34HK+UAWNZq57TgSj9t02uZecuhXJIKAJFG00vM6UxQBCHq08O+1DxciKl/xBNIa7DqrQYskIKrYVzag78w5+k57EK7t8oh2cE3TTpMkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497915; c=relaxed/simple;
	bh=ubfgbSmXZnXhZQyJ48GyGMJI0+96vVFdEcci0YqlrKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9D0vMQ96LQ+QneJP5bd82X75aMnaNCO1YPngd3b41zlRYrgTXPZjzUbXeejdjIJQmiVrW0F3mK/HvH4ZOtpwtCye2UoitcWm9gXVvx9C6TZk7uMF1mwfjotUEoS2bitnqdJnh3kxmA6pxcRCUrniJLpw7MteDhLS+X2mXB1BX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZuuHnP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F828C4CEC3;
	Wed,  9 Oct 2024 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497914;
	bh=ubfgbSmXZnXhZQyJ48GyGMJI0+96vVFdEcci0YqlrKw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AZuuHnP6cWW95Pmw7F9zHKQDML1J0zh3AreTPl8H7Eatc/t7t9N/O8fS8Hia653HE
	 P3bUE7THhe27S+OJ1l2qKZSuRRjBYqZCoweQXvhXYmQ6Zwha3l7wosA/0vDJI98j9g
	 LlcV+AQ0OMhy+k+ruotCwtXYBjT2yeCsTCxz/JxIPs5lGFoWo8PCjPw2Nzqq3ZqdGj
	 5dTDYIcmADfZtXgN9HTme+s3dx0wlZqC2iAIGseBOd1AYy9hqbzVE+rD8Zey001Iqo
	 tPLedUpsyL0gleVAG6fAZyVruWmbLVa6tNi2b6DuZGXhk9ze4aWy5E97Cf4FX+/pII
	 /zkeQRuT8Zp6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1B175CE08E5; Wed,  9 Oct 2024 11:18:34 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:18:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	riel@surriel.com, leobras@redhat.com, tglx@linutronix.de,
	qiyuzhu2@amd.com
Subject: Re: locking/csd-lock: Switch from sched_clock() to
 ktime_get_mono_fast_ns()
Message-ID: <663ad810-3318-43af-8607-17ff7fe26e4a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>
 <20241009180708.GU17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180708.GU17263@noisy.programming.kicks-ass.net>

On Wed, Oct 09, 2024 at 08:07:08PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2024 at 10:57:24AM -0700, Paul E. McKenney wrote:
> > Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
> > to check for excessive CSD-lock wait times.  This works, but does not
> > guarantee monotonic timestamps. 
> 
> It does if you provide a sane TSC

What is this "sane TSC" of which you speak?  ;-)

More seriously, the raw reads from the TSC that are carried out by
sched_clock() are not guaranteed to be monotonic due to potential
instruction reordering and the like.  This is *not* a theoretical
statement -- we really do see this on the fleet.  Very rarely for any
given system, to be sure, but not at all rare across the full set of them.

This results in false-positive CSD-lock complaints claiming almost 2^64
nanoseconds of delay, which are not good complaints to have.

> > Therefore, switch from sched_clock()
> > to ktime_get_mono_fast_ns(), which does guarantee monotonic timestamps,
> > at least in the absence of calls from NMI handlers, which are not involved
> > in this code path.
> 
> That can end up using HPET in the case of non-sane TSC.

That is true.  However...

> In the good case they're equal, in the bad case you're switching from
> slightly dodgy time to super expensive time. Is that what you want?

If TSC is not sane, we don't want to be using the system at all.
In fact, the super-expensive time will more often than not result in
the system being automatically taken out of service due to the excessive
application-level latencies.

But in the good case where the TSC is sane, we need successive reads
from the TSC to be ordered in order to avoid the false-positive
complaints.  Yes, this does add a bit of overhead, but the CPU isn't
doing anything useful anyway, so not a problem.  This same lack of
concern might also apply to HPET reads.

Should I upgrade the commit log?  Or am I missing your point?

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Leonardo Bras <leobras@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index f25e20617b7eb..27dc31a146a35 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -246,7 +246,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> >  		return true;
> >  	}
> >  
> > -	ts2 = sched_clock();
> > +	ts2 = ktime_get_mono_fast_ns();
> >  	/* How long since we last checked for a stuck CSD lock.*/
> >  	ts_delta = ts2 - *ts1;
> >  	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
> > @@ -321,7 +321,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
> >  	int bug_id = 0;
> >  	u64 ts0, ts1;
> >  
> > -	ts1 = ts0 = sched_clock();
> > +	ts1 = ts0 = ktime_get_mono_fast_ns();
> >  	for (;;) {
> >  		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
> >  			break;

