Return-Path: <linux-kernel+bounces-366907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25A499FC24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FCB2856B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533C1D63D3;
	Tue, 15 Oct 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtoLHznz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB6173357
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033916; cv=none; b=b5POzyiK0wGlGucSrRUN3sV8UTyO3V7LOzP4+ZJoCoUJ4TNEbjK3VmyvjdAdIsTY6g1uBDQx+4yj0WEVbEWnZY7/iQ3mMhXtD7x4gURbtnAkk7MHaTL2DgIo68yqxpyhjhJ3X4GZP7D+GOAibuE6v6+ZInZ+Gajs9MDz3ckW5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033916; c=relaxed/simple;
	bh=AKRFhZybKjssG0d+1VenCoKLk7N1SUw95q9UnCoVcGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDvTIPC88h+OknN8vfoKBX83258LKh6xxxOsZXBuJb+Zq/PUzP6vbw0Rv01F/IQ8thCCHin0Dkw3BK+rtJSmqEOikjv5vEvaA4W7qef4OT+5bUDxDUDMvX65VVq1Ulalbqe/6a84Vr717gnDlk3lQQUQ/lnVp1ZX79jlO4X6L+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtoLHznz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A7CC4CEC6;
	Tue, 15 Oct 2024 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729033915;
	bh=AKRFhZybKjssG0d+1VenCoKLk7N1SUw95q9UnCoVcGo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dtoLHznzr77RUD8cSBMcrwJcELGWQUtFYmN39J3MrWTXC4lvba3IcUQAsfanwrqYy
	 Xavor8Li07G+2iS6MK4zBS/HVmHPrRBu2Mgo6dfwdc2NcyvChXoC1OuDBK5deuyzbo
	 5V+JHdkXRudnZZNUqYzypKP3p5ius8B4SaMmW++vqBGKfYxre8iJS4z6WNK0xNysy7
	 PaAp3iBgsn93F9m9bVbDfLD0PVab6+hxgYk/v1eB3n4pdgl7eP5OevRru3HJItUgEa
	 LNbMiByzO9m2ouyMuWLTqgFA1sCYst4rUGeT4XtN4NJQQndUgQoHtc2CnT3yBYEB6c
	 FuGz/kkLN5Hfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 21427CE098E; Tue, 15 Oct 2024 16:11:55 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:11:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015112224.KdvzKo80@linutronix.de>

On Tue, Oct 15, 2024 at 01:22:24PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-11 08:59:14 [-0700], Paul E. McKenney wrote:
> > On Fri, Oct 11, 2024 at 04:43:41PM +0200, Sebastian Andrzej Siewior wrote:
> >
> > > Okay, this eliminates PREEMPT_DYNAMIC then.
> > > With PeterZ current series, PREEMPT_LAZY (without everything else
> > > enabled) behaves as PREEMPT without the "forced" wake up for the fair
> > > class. It is preemptible after all, with preempt_disable() actually
> > > doing something. This might speak for preemptible RCU.
> > > And assuming in this condition you that "low memory overhead RCU" which
> > > is not PREEMPT_RCU. This might require a config option.
> > 
> > The PREEMPT_DYNAMIC case seems to work well as-is for the intended users,
> > so I don't see a need to change it.  In particular, we already learned
> > that we need to set PREEMPT_DYNAMIC=n.  Yes, had I caught this in time, I
> > would have argued against changing the default, but this was successfully
> > slid past me.
> > 
> > As for PREEMPT_LAZY, you seem to be suggesting a more intrusive change
> > than just keeping non-preemptible RCU when the Kconfig options are
> > consistent with this being expected.  If this is the case, what are the
> > benefits of this more-intrusive change?
> 
> As far as I understand you are only concerned about PREEMPT_LAZY and
> everything else (PREEMPT_LAZY + PREEMPT_DYNAMIC or PREEMPT_DYNAMIC
> without PREEMPT_LAZY) is fine. 
> In the PREEMPT_LAZY + !PREEMPT_DYNAMIC the suggested change
> 
> | config PREEMPT_RCU
> | 	bool
> | 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> | 	select TREE_RCU
> | 	help
> 
> would disable PREEMPT_RCU while the default model is PREEMPT. You argue
> that only people on small embedded would do such a thing and they would
> like to safe additional memory. 

I am more worried about large datacenter deployments than small embedded
systems.  Larger systems, but various considerations often limit the
amount of memory on a given system.

> I don't think this is always the case because the "preemptible" users
> would also get this and this is an unexpected change for them.

Is this series now removing PREEMPT_NONE and PREEMPT_VOLUNTARY?
As conceived last time around, the change would affect only kernels
built with one of the other of those two Kconfig options, which will
not be users expecting preemption.

> > > > > If you would like to add some relief to memory constrained systems,
> > > > > wouldn't BASE_SMALL be something you could hook to? With EXPERT_RCU to
> > > > > allow to override it?
> > > > 
> > > > Does BASE_SMALL affect anything but log buffer sizes?  Either way, we
> > > > would still need to avoid the larger memory footprint of preemptible
> > > > RCU that shows up due to RCU readers being preempted.
> > > 
> > > It only reduces data structures where possible. So lower performance is
> > > probably due to things like futex hashmap (and others) are smaller.
> > 
> > Which is still counterproductive for use cases other than small deep
> > embedded systems.
> 
> Okay, so that option is gone.

It was worth a look, so thank you!

> > > > Besides, we are not looking to give up performance vs BASE_SMALL's
> > > > "may reduce performance" help text.
> > > > 
> > > > Yes, yes, it would simplify things to just get rid of non-preemptible RCU,
> > > > but that is simply not in the cards at the moment.
> > > 
> > > Not sure what the time frame is here. If we go for LAZY and remove NONE
> > > and VOLUNTARY then making PREEMPT_RCU would make sense to lower the
> > > memory footprint (and not attaching to BASE_SMALL).
> > > 
> > > Is this what you intend or did misunderstand something here?
> > 
> > My requirement is that LAZY not remove/disable/whatever non-preemptible
> > RCU.  Those currently using non-preemptible RCU should continue to be able
> > to be able to use it, with or without LAZY.  So why is this requirement
> > a problem for you?  Or am I missing your point?
> 
> Those who were using non-preemptible RCU, whish to use LAZY_PREEPMT +
> !PREEMPT_DYNAMIC should be able to disable PREEMPT_RCU only in this case. 
> Would the following work?
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 8cf8a9a4d868c..2183c775e7808 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -121,6 +121,7 @@ config PREEMPT_COUNT
>  config PREEMPTION
>         bool
>         select PREEMPT_COUNT
> +       select PREEMPT_RCU if PREEMPT_DYNAMIC
>  
>  config PREEMPT_DYNAMIC
>  	bool "Preemption behaviour defined on boot"
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 3e079de0f5b43..9e4bdbbca4ff9 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -17,7 +17,7 @@ config TREE_RCU
>  	  smaller systems.
>  
>  config PREEMPT_RCU
> -	bool
> +	bool "Preemptible RCU"
>  	default y if PREEMPTION
>  	select TREE_RCU
>  	help
> @@ -91,7 +91,7 @@ config NEED_TASKS_RCU

If PREEMPT_NONE and PREEMPT_VOLUNTARY are still around, it would be
far better to make PREEMPT_RCU depend on neither of those being set.
That would leave the RCU Kconfig settings fully automatic, and this
automation is not to be abandoned lightly.

>  config TASKS_RCU
>  	bool
> -	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
> +	default NEED_TASKS_RCU && PREEMPTION
>  	select IRQ_WORK
>  
>  config FORCE_TASKS_RUDE_RCU
> 
> I added TASKS_RCU to the hunk since I am not sure if you wish to follow
> PREEMPTION (which is set by LAZY) or PREEMPT_RCU.

TASKS_RCU needs to be selected when there is preemption of any kind,
lazy or otherwise, regardless of the settign of PREEMPT_RCU.

The current substition of vanilla RCU for Tasks RCU works only in
kernels that are guaranteed non-preemptible, which does not include
kernels built with lazy preemption.

							Thanx, Paul

