Return-Path: <linux-kernel+bounces-181196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ACA8C78DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F371C22280
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ABC14B978;
	Thu, 16 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slgMkKjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E7514B06E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871774; cv=none; b=SJ17q3wL/+2Zeqr6xzO4Axg6D7+QKeVLeWE5FceJ+zGDph0sRb6EDnp9vwEhNRf1spthEab6R6Clq2Wm+AbSd5eO6fODEkF16H7ZbCk60rZbRWJndWzHzLwgX5m67Z1BTKOuZHj0HqSDZHEL8aRPjt8/p+gmHtnlK6mrZzQVfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871774; c=relaxed/simple;
	bh=3YL+I6hux/NpvqfXdS1XbOhelN2JjPF4ue7vy8gKQ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7iEBaJ9W1oIC/npwuiqULVgBive03qUtvUoJpu5CoWyuHdLotReAEv6P2zqO7DQsmp6Z3rlMkKQyPED9+urbAA/A15tXEA5al12vRAflpx616gUtypKiJ0Du7K9KTL4kpjgwGiG6hqdo/Q0aDsAdZl26Xo+knmvS/LBnUkVxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slgMkKjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C2CC113CC;
	Thu, 16 May 2024 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715871774;
	bh=3YL+I6hux/NpvqfXdS1XbOhelN2JjPF4ue7vy8gKQ14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slgMkKjVSF53e6SmQkWF4tmoTH5HzedtUzudoMcxgxWX6+JLBmwfnwqQONPw1S9Kn
	 PDGMtfzqOe4x+f7UZRM5YzytjplaklB1zv5Flx8LyZ9bLCOaM48jU5PdgPKyRJFjBO
	 W3TYST++Hc1LZFVcANzCGTtgI4lFq3XMQVmFI9gp+tPYL/ag18UQ/lftMjCVY6OFgY
	 2+KprQCUk12r2XzAEBKQ8fh888jz71lUJq8oIYPmPxIdRKeT8+CW1Lm42osmYiqvyh
	 2VLbbwx0oVUADtgM8tb3gzCP57rY3T+pTXGm4s2e0qaKv329OG7cx1vHFVs6auXW8F
	 Vxov3lsyNLVuQ==
Date: Thu, 16 May 2024 17:02:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yun Levi <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <ZkYgG9KYMpUPeJsM@lothringen>
References: <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
 <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
 <ZkYW48dTX2FH5NaD@lothringen>
 <20240516144504.GL22557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516144504.GL22557@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 04:45:04PM +0200, Peter Zijlstra wrote:
> On Thu, May 16, 2024 at 04:23:31PM +0200, Frederic Weisbecker wrote:
> > On Thu, May 16, 2024 at 04:00:03PM +0200, Peter Zijlstra wrote:
> > > > If I make you annoyed I'm sorry in advance but let me clarify please.
> > > > 
> > > > 1. In case of none-HK-TICK-housekeeping cpu (a.k.a nohz_full cpu),
> > > >     It should be on the null_domain. right?
> > > > 
> > > > 2. If (1) is true, when none-HK-TICK is set, should it set none-HK-DOMAIN
> > > >     to prevent on any sched_domain (cpusets filter out none-HK-DOMAIN cpu)?
> > > > 
> > > > 3. If (1) is true, Is HK_SCHED still necessary? There seems to be no use case
> > > >     and the check for this can be replaced by on_null_domain().
> > > 
> > > I've no idea about all those HK knobs, it's all insane if you ask me.
> > > 
> > > Frederic, afaict all the HK_ goo in kernel/sched/fair.c is total
> > > nonsense, can you please explain?
> > 
> > Yes. Lemme unearth this patch:
> > https://lore.kernel.org/all/20230203232409.163847-2-frederic@kernel.org/
> 
> AFAICT we need more cleanups.

Well, we need to start somewhere :-)

> 
> > Because all we need now is:
> > 
> > _ HK_TYPE_KERNEL_NOISE: nohz_full= or isolcpus=nohz
> > _ HK_TYPE_DOMAIN: isolcpus=domain (or classic isolcpus= alone)
> 
> What does this do?

So housekeeping_cpumask(HK_TYPE_KERNEL_NOISE) will return all
the CPUs not in nohz_full=

That is, all the CPUs that do all the housekeeping work on behalf
of nohz_full CPUs (unbound workqueues and timers, etc...).

Then in a similar way housekeeping_cpumask(HK_TYPE_DOMAIN) are all
the CPUs not in isolcpus= (on_null_domain()). Perhaps that one is
confusing and we should just have a simple isolcpus_cpumask instead?

> 
> > _ HK_TYPE_MANAGED_IRQ: isolcpus=managed_irq
> > 
> > And that's it. Then let's remove HK_TYPE_SCHED that is unused. And then
> > lemme comment the HK_TYPE_* uses within sched/* within the same
> > patchset.
> 
> Please, I find this MISC and DOMAIN stuff confusing, wth does it do? It
> can't possibly be right.

MISC is actually part of what is going to become HK_TYPE_KERNEL_NOISE. It's
an artificial microfeature but it's actually the same as _WORKQUEUE, _TICK, _RCU,
_TIMER, etc... All of which intended to be merged together.

> 
> > Just a question, correct me if I'm wrong, we don't want nohz_full= to ever
> > take the idle load balancer duty (this is what HK_TYPE_MISC prevents in
> > find_new_ilb) because the nohz_full CPU going back to userspace concurrently
> > doesn't want to be disturbed by a loose IPI telling it to do idle balancing. But
> > we still want nohz_full CPUs to be part of nohz.idle_cpus_mask so that the
> > idle balancing can be performed on them by a non isolated CPU. Right?
> 
> I'm confused, none of that makes sense. If you're part of a
> load-balancer, you're part of a load-balancer, no ifs buts or other
> nonsense.
> 
> idle load balancer is no different from regular load balancing.
> 
> Fundamentally, you can't disable the tick if you're part of a
> load-balance group, the load-balancer needs the tick.
> 
> The only possible way to use nohz_full is to not be part of a
> load-balancer, and the only way that is so is by having (lots of) single
> CPU partitions.

So you're suggesting that nohz_full should just be part of the whole
ilb machinery by default (that is, not fiddle with ilb internals) and
then it's up to CPU partitioning (through cpuset or isolcpus) to disable
ilb naturally. Right?

Thanks.


