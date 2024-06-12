Return-Path: <linux-kernel+bounces-212045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4053905A76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1254E284BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9241836DC;
	Wed, 12 Jun 2024 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMslw1kM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650818309D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215855; cv=none; b=RDe8it6FlKUiSgbqLYBCOAuU8B10snYMj5Ots2oGISsSOtJMA5mBsS4Rbk2IGN/itjiis6JNz8TK/zxIqzzmXVXQR+bCCtTcJoVVbpUqrj9L8Nd+myEYtpsOZSrpG3utEIB3HcYzOwLMGDgNdk8SyY9Czk5to3sgSNPkTRSY5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215855; c=relaxed/simple;
	bh=SqV7Q9/x2YZSDMfPGfsV1yJAT7awWqzlHlOMVv8cLh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmUoMnsMk0e+vGv9duXErvGz0ggSemn3K9PKisSPolyQQAmANP8fPW/p0ww3zVdqfPLoc0CF/CQkglTW9H6F8QkEH5In1R4vKQc9Pz7Rwe9PxmisHSUAS9oFwdkIrhwtpXZKioZZdQbYffcAupzLhvpN7ErzKfZmHdXPjC4E7d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMslw1kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE48DC116B1;
	Wed, 12 Jun 2024 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718215854;
	bh=SqV7Q9/x2YZSDMfPGfsV1yJAT7awWqzlHlOMVv8cLh8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gMslw1kMWn30pa75ei+/+bMEaMAwzg+JqSBQqRr3YbO7ctXDF9g2rYJBLan25UjHS
	 lRvR3ecW/zowY/zpOO8slFFdh6+vA6qkx5GbSfAWBOBla0CtDcGfVoDWD9A7I4zDia
	 vMpsuNdm821GYoNYAttWud6d5zbGyofE4SjmWnkcNy9LIL+SorLt+1F4KbQpyIVSa3
	 wqvrDhhMyCi/c019QeenkpYrtnDQsKWn5HgCugXmFsWM9Qv2TjCYUHgYW4CvX97s/q
	 BiDgbjZdb4jq0nll+K22zOWbms56nRD7lpy2ujq2Wzw/RBKZaM30TuERof/a5yAeXn
	 FdxDXVGISLoRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7EDB7CE0DEA; Wed, 12 Jun 2024 11:10:54 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:10:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, torvalds@linux-foundation.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
Message-ID: <652b1be3-e154-4902-b7aa-f9151ed5cf75@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-14-ankur.a.arora@oracle.com>
 <20240528162725.GH26599@noisy.programming.kicks-ass.net>
 <87ttif641i.fsf@oracle.com>
 <20240606115101.GC8774@noisy.programming.kicks-ass.net>
 <87ikymw1g2.fsf@oracle.com>
 <20240606173218.GH8774@noisy.programming.kicks-ass.net>
 <87frtnt02l.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frtnt02l.fsf@oracle.com>

On Sat, Jun 08, 2024 at 05:46:26PM -0700, Ankur Arora wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Thu, Jun 06, 2024 at 08:11:41AM -0700, Ankur Arora wrote:
> >> Peter Zijlstra <peterz@infradead.org> writes:
> >> > On Thu, May 30, 2024 at 02:29:45AM -0700, Ankur Arora wrote:
> >> >> Peter Zijlstra <peterz@infradead.org> writes:
> >> >> > On Mon, May 27, 2024 at 05:34:59PM -0700, Ankur Arora wrote:
> >> >> >> Reuse sched_dynamic_update() and related logic to enable choosing
> >> >> >> the preemption model at boot or runtime for PREEMPT_AUTO.
> >> >> >>
> >> >> >> The interface is identical to PREEMPT_DYNAMIC.
> >> >> >
> >> >> > Colour me confused, why?!? What are you doing and why aren't just just
> >> >> > adding AUTO to the existing DYNAMIC thing?
> >> >>
> >> >> You mean have a single __sched_dynamic_update()? AUTO doesn't use any
> >> >> of the static_call/static_key stuff so I'm not sure how that would work.
> >> >
> >> > *sigh*... see the below, seems to work.
> >>
> >> Sorry, didn't mean for you to have to do all that work to prove the
> >> point.
> >
> > Well, for a large part it was needed for me to figure out what your
> > patches were actually doing anyway. Peel away all the layers and this is
> > what remains.
> >
> >> I phrased it badly. I do understand how lazy can be folded in as
> >> you do here:
> >>
> >> > +	case preempt_dynamic_lazy:
> >> > +		if (!klp_override)
> >> > +			preempt_dynamic_disable(cond_resched);
> >> > +		preempt_dynamic_disable(might_resched);
> >> > +		preempt_dynamic_enable(preempt_schedule);
> >> > +		preempt_dynamic_enable(preempt_schedule_notrace);
> >> > +		preempt_dynamic_enable(irqentry_exit_cond_resched);
> >> > +		preempt_dynamic_key_enable(preempt_lazy);
> >> > +		if (mode != preempt_dynamic_mode)
> >> > +			pr_info("Dynamic Preempt: lazy\n");
> >> > +		break;
> >> >  	}
> >>
> >> But, if the long term goal (at least as I understand it) is to get rid
> >> of cond_resched() -- to allow optimizations that needing to call cond_resched()
> >> makes impossible -- does it make sense to pull all of these together?
> >
> > It certainly doesn't make sense to add yet another configurable thing. We
> > have one, so yes add it here.
> >
> >> Say, eventually preempt_dynamic_lazy and preempt_dynamic_full are the
> >> only two models left. Then we will have (modulo figuring out how to
> >> switch over klp from cond_resched() to a different unwinding technique):
> >>
> >> static void __sched_dynamic_update(int mode)
> >> {
> >>         preempt_dynamic_enable(preempt_schedule);
> >>         preempt_dynamic_enable(preempt_schedule_notrace);
> >>         preempt_dynamic_enable(irqentry_exit_cond_resched);
> >>
> >>         switch (mode) {
> >>         case preempt_dynamic_full:
> >>                 preempt_dynamic_key_disable(preempt_lazy);
> >>                 if (mode != preempt_dynamic_mode)
> >>                         pr_info("%s: full\n", PREEMPT_MODE);
> >>                 break;
> >>
> >> 	case preempt_dynamic_lazy:
> >> 		preempt_dynamic_key_enable(preempt_lazy);
> >> 		if (mode != preempt_dynamic_mode)
> >> 			pr_info("Dynamic Preempt: lazy\n");
> >> 		break;
> >>         }
> >>
> >>         preempt_dynamic_mode = mode;
> >> }
> >>
> >> Which is pretty similar to what the PREEMPT_AUTO code was doing.
> >
> > Right, but without duplicating all that stuff in the interim.
> 
> Yeah, that makes sense. Joel had suggested something on these lines
> earlier [1], to which I was resistant.
> 
> However, the duplication (and the fact that the voluntary model
> was quite thin) should have told me that (AUTO, preempt=voluntary)
> should just be folded under PREEMPT_DYNAMIC.
> 
> I'll rework the series to do that.
> 
> That should also simplify RCU related choices which I think Paul will
> like. Given that the lazy model is meant to eventually replace
> none/voluntary, so PREEMPT_RCU configuration can just be:
> 
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -18,7 +18,7 @@ config TREE_RCU
> 
>  config PREEMPT_RCU
>         bool
> -       default y if PREEMPTION
> +       default y if PREEMPTION && !PREEMPT_LAZY

Given that PREEMPT_DYNAMIC selects PREEMPT_BUILD which in turn selects
PREEMPTION, this should work.

> Or, maybe we should instead have this:
> 
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -18,7 +18,7 @@ config TREE_RCU
> 
>  config PREEMPT_RCU
>         bool
> -       default y if PREEMPTION
> +       default y if PREEMPT || PREEMPT_RT
>         select TREE_RCU
> 
> Though this would be a change in behaviour for current PREEMPT_DYNAMIC
> users.

Which I believe to be a no-go.  I believe that PREEMPT_DYNAMIC users
really need their preemptible kernels to include preemptible RCU.

If PREEMPT_LAZY causes PREEMPT_DYNAMIC non-preemptible kernels to become
lazily preemptible, that is a topic to discuss with PREEMPT_DYNAMIC users.
On the other hand, if PREEMPT_LAZY does not cause PREEMPT_DYNAMIC
kernels to become lazily preemptible, then I would expect there to be
hard questions about removing cond_resched() and might_sleep(), or,
for that matter changing their semantics.  Which I again must leave
to PREEMPT_DYNAMIC users.

							Thanx, Paul

> [1] https://lore.kernel.org/lkml/fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org/
> 
> Thanks
> --
> ankur

