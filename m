Return-Path: <linux-kernel+bounces-196023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491178D562E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D201F22FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0460917E441;
	Thu, 30 May 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou7/XSLz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224F4D8C3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111233; cv=none; b=is5ceSs1sXBcck5t30nc1vHgUTzpdKbeppdFLPxiwH2Tlixv+YIHN4HDnDdg9x+xe6oqOEDgujwXLYvGa95BYKAcFK1VNdkA9m4wgwx7EgboTkoKQn8rrtASW0V09DR/hvTE2j4c/u6I+wCDkJ/82Q8IMoRsRZIBofFJdeNXB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111233; c=relaxed/simple;
	bh=XhvThE/+JuRA8Pp1EUt7hg24P1MzvKOA3s/VoNCpliI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH+6DPYSis3+t0c9lfALHOaV3ewb76FfGOHrFHMSY+d/5kgxmkFwfkqiOYnwmzWQQxoziRE3LZt8Gu2JqcQNr5H5LxzE5jr7KxaaRALTonaa/aWrEaZdoll9MnXuLd7pOi9cNjjehdet06lS8ctOkUglN8+yqJjBYsetrxSnjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou7/XSLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E270C2BBFC;
	Thu, 30 May 2024 23:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717111232;
	bh=XhvThE/+JuRA8Pp1EUt7hg24P1MzvKOA3s/VoNCpliI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ou7/XSLzeOe50jbGtA1OMlu+yEZAuk6jmIQrFbGuivXe+aY+7rbXn1QqS3SQ8ljnB
	 UNWIPewZ0+3cCfqml/oLg34UXKnOp2qkUg9E+ezH7ZhpJ0ERRkRmCVqUB75uNRg2+B
	 5DIzFeKnJgaeJgQDnV43QLVlwnrkNQwT9q6ZTuFZXjNmH2VMYCTcDtcax6EXu9eMVO
	 swDk32c/rOIy7R6sxVQ81zCzT2Au/FMzw0HezWh/cf9CYkASVc+eBvZz4F++BfTe47
	 kwYN4iq9H+7aFvX/QpRFiY8iGS+qctmsb02I7H6uFaFZAidjbKYkJwxcLdgpg/o4pk
	 Iy4TMMTuX2GYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96EFFCE095C; Thu, 30 May 2024 16:20:26 -0700 (PDT)
Date: Thu, 30 May 2024 16:20:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, torvalds@linux-foundation.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 16/35] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
Message-ID: <c6b5a5e4-e14e-4fbb-84af-75d4035ced32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
 <8734py6gvq.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734py6gvq.fsf@oracle.com>

On Thu, May 30, 2024 at 04:04:41PM -0700, Ankur Arora wrote:
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Mon, May 27, 2024 at 05:35:02PM -0700, Ankur Arora wrote:
> >> The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
> >> works at cross purposes: the RCU read side critical sections disable
> >> preemption, while preempt=full schedules eagerly to minimize
> >> latency.
> >>
> >> Warn if the user is switching to full preemption with PREEMPT_RCU=n.
> >>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Juri Lelli <juri.lelli@redhat.com>
> >> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >> Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  kernel/sched/core.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index d7804e29182d..df8e333f2d8b 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -8943,6 +8943,10 @@ static void __sched_dynamic_update(int mode)
> >>  		break;
> >>
> >>  	case preempt_dynamic_full:
> >> +		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> >> +			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
> >> +				PREEMPT_MODE);
> >> +
> >
> > Yeah, so I don't believe this is a viable strategy.
> >
> > Firstly, none of these RCU patches are actually about the whole LAZY
> > preempt scheme, they apply equally well (arguably better) to the
> > existing PREEMPT_DYNAMIC thing.
> 
> Agreed.
> 
> > Secondly, esp. with the LAZY thing, you are effectively running FULL at
> > all times. It's just that some of the preemptions, typically those of
> > the normal scheduling class are somewhat delayed. However RT/DL classes
> > are still insta preempt.
> 
> Also, agreed.
> 
> > Meaning that if you run anything in the realtime classes you're running
> > a fully preemptible kernel. As such, RCU had better be able to deal with
> > it.
> 
> So, RCU can deal with (PREEMPT_RCU=y, PREEMPT_AUTO=y, preempt=none/voluntary/full).
> Since that's basically what PREEMPT_DYNAMIC already works with.
> 
> The other combination, (PREEMPT_RCU=n, PREEMPT_AUTO,
> preempt=none/voluntary) would generally be business as usual, except, as
> you say, it is really PREEMPT_RCU=n, preempt=full in disguise.
> 
> However, as Paul says __rcu_read_lock(), for PREEMPT_RCU=n is defined as:
> 
> static inline void __rcu_read_lock(void)
> {
>         preempt_disable();
> }
> 
> So, this combination -- though non standard -- should also work.
> 
> The reason for adding the warning was because Paul had warned in
> discussions earlier (see here for instance:
> https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/)
> 
> that the PREEMPT_FULL=y and PREEMPT_RCU=n is basically useless. But at
> least in my understanding that's primarily a performance concern not a
> correctness concern. But, Paul can probably speak to that more.
> 
>   "PREEMPT_FULL=y plus PREEMPT_RCU=n appears to be a useless
>   combination.  All of the gains from PREEMPT_FULL=y are more than lost
>   due to PREEMPT_RCU=n, especially when the kernel decides to do something
>   like walk a long task list under RCU protection.  We should not waste
>   people's time getting burned by this combination, nor should we waste
>   cycles testing it."

My selfish motivation here is to avoid testing this combination unless
and until someone actually has a good use for it.  I do not think that
anyone will ever need it, but perhaps I am suffering from a failure
of imagination.  If so, they hit that WARN, complain and explain their
use case, and at that point I start testing it (and fixing whatever bugs
have accumulated in the meantime).  But until that time, I save time by
avoiding testing it.

							Thanx, Paul

