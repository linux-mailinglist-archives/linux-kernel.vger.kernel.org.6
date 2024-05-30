Return-Path: <linux-kernel+bounces-196020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A98D5626
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A671F27F38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1821145B24;
	Thu, 30 May 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFUyn2LC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4B2E83C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110923; cv=none; b=ctTnO/KouhEMZ/ldo6Q/AKaJiNlnucZVfsImAwxPAM6QYdlRxcoMcTi2PQWCAMocV524QHec7C/YuzAFsMDcbfzNi4Ww8NiwmfERHegNaNezS/i1elxGOFSKTATRXeJNbcYEgxqrKw3cOeQ00jLqrWJpD/FrUbWokeGlzK6uKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110923; c=relaxed/simple;
	bh=sFM5M7qWz/n/MrwT6ILlj0hsZ3huyyn9R8FgilUz+TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gliQDLHLdd6bTy9RcHUuDkpEcHNJx33gh96mso4GZuBypyZ3H+QtAqaMluYHmSJmVLHN06ikuFQ1xoBFLQnS4d3TLwdTeJducrF0FQi4mkiUxJsYTlG1GvuS5jg4Hg9WG14gD9ZkO/MueBqbRYkQqrZPIwnwY2Fx/wFWTStrnwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFUyn2LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFA8C2BBFC;
	Thu, 30 May 2024 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717110922;
	bh=sFM5M7qWz/n/MrwT6ILlj0hsZ3huyyn9R8FgilUz+TY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fFUyn2LCNPc10Zw6sn18vlI1LuQaRS1RaqNGg1z8Q+0Mk4Pa+HlptS6jM9l2+Tj/B
	 MqKb+0OqREU1djwefCHwJ5WI2I/4mJ8LCtnmS07UKitjO7Ay6Pi7YpZOiqdGr6AXh5
	 G8KOudRsTYNiKCa6VOXpvNcgvOr15L80yCjniAU12agErpuj6LdrtDRXctCQLqv+uh
	 Wg00UcipGVtkYygaUYGltV3rrZ26bvE+8IPGghnVqhfmpMx9KrRtzD2OE3y4c7ZJso
	 Bv4h6yuWi44BcPhQqNKc6lQ9clBD5/fEs24GtTNfA8PEfwFDe0dLAe9T3qrP2DbOrr
	 +9syjnezEpg0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AB4A4CE095C; Thu, 30 May 2024 16:15:21 -0700 (PDT)
Date: Thu, 30 May 2024 16:15:21 -0700
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
Message-ID: <2b02c501-389e-468b-b6ec-0320fa7c9e7e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
 <b629f8c9-8900-4317-9ea3-08a8dba7d896@paulmck-laptop>
 <87v82u52a1.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v82u52a1.fsf@oracle.com>

On Thu, May 30, 2024 at 04:05:26PM -0700, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Wed, May 29, 2024 at 10:14:04AM +0200, Peter Zijlstra wrote:
> >> On Mon, May 27, 2024 at 05:35:02PM -0700, Ankur Arora wrote:
> >> > The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
> >> > works at cross purposes: the RCU read side critical sections disable
> >> > preemption, while preempt=full schedules eagerly to minimize
> >> > latency.
> >> >
> >> > Warn if the user is switching to full preemption with PREEMPT_RCU=n.
> >> >
> >> > Cc: Ingo Molnar <mingo@redhat.com>
> >> > Cc: Peter Zijlstra <peterz@infradead.org>
> >> > Cc: Juri Lelli <juri.lelli@redhat.com>
> >> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >> > Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
> >> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> > ---
> >> >  kernel/sched/core.c | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> > index d7804e29182d..df8e333f2d8b 100644
> >> > --- a/kernel/sched/core.c
> >> > +++ b/kernel/sched/core.c
> >> > @@ -8943,6 +8943,10 @@ static void __sched_dynamic_update(int mode)
> >> >  		break;
> >> >
> >> >  	case preempt_dynamic_full:
> >> > +		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> >> > +			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
> >> > +				PREEMPT_MODE);
> >> > +
> >>
> >> Yeah, so I don't believe this is a viable strategy.
> >>
> >> Firstly, none of these RCU patches are actually about the whole LAZY
> >> preempt scheme, they apply equally well (arguably better) to the
> >> existing PREEMPT_DYNAMIC thing.
> >>
> >> Secondly, esp. with the LAZY thing, you are effectively running FULL at
> >> all times. It's just that some of the preemptions, typically those of
> >> the normal scheduling class are somewhat delayed. However RT/DL classes
> >> are still insta preempt.
> >>
> >> Meaning that if you run anything in the realtime classes you're running
> >> a fully preemptible kernel. As such, RCU had better be able to deal with
> >> it.
> >>
> >> So no, I don't believe this is right.
> >
> > At one point, lazy preemption selected PREEMPT_COUNT (which I am
> > not seeing in this version, perhaps due to blindness on my part).
> > Of course, selecting PREEMPT_COUNT would result in !PREEMPT_RCU kernel's
> > rcu_read_lock() explicitly disabling preemption, thus avoiding preemption
> > (including lazy preemption) in RCU read-side critical sections.
> 
> That should be still happening, just transitively. PREEMPT_AUTO selects
> PREEMPT_BUILD, which selects PREEMPTION, and that in turn selects
> PREEMPT_COUNT.

Ah, I gave up too soon.  Thank you!

							Thanx, Paul

