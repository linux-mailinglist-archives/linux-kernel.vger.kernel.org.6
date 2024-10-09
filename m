Return-Path: <linux-kernel+bounces-357731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D32379974DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE324B240ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400E11DEFCE;
	Wed,  9 Oct 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwTH/aZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184F1A704B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498250; cv=none; b=ib7kA4wMndNF5wpRoNMftxvU40GIV45//NAW0/G+xEPUcGBTQHnp9k386pQFARYv9F7vrZl61rnEGIoUJtdPs5yWHvt5GyjEO3MLK9W7lc+kmw877bpDETkQsV9I7L8SBKQ89rPUhDtfT4QApTyQYFEfQLsOUPFp21ACDF4/tuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498250; c=relaxed/simple;
	bh=J77gWoDnBw7nZFSHP2X+C92SgL/C4jZE+LJf/Z8Gpi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaeEsrlQKsML9MVgGx78vjOw+5rYaO7Xh9kL7qcbpPrtsmNnfpUq3V+t5wBgum4cYzn+chocF4d6+d8QkC0GayDOa092dAgHkCuYxzWf44YmNBB7ZWL1DtD7jrralOSJz3RPItO7FsOo/ApEOybcn5Mlrfkz84NSJuYlKHDm9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwTH/aZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF81C4CEC3;
	Wed,  9 Oct 2024 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728498250;
	bh=J77gWoDnBw7nZFSHP2X+C92SgL/C4jZE+LJf/Z8Gpi4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jwTH/aZyRd1yiDM5jR6sJwrv3TSApuCRq0xmr8sFhxkwGTi1gVIG9vEiyPH42shtL
	 BM/B79/b4E5zOMeNJlCYvSAiAKy7ebJ84GnvFFvjsUqZC3hMQhGQ12vcM5RR4mdI2y
	 AAb5lbRF1umHiLqQuEFw4Ne5rPGO6wuhz+IcwnUk2kp21BxZCjglGposb6SUJt/dg/
	 RiwT24uM/NSVxfOrnCHbPYf9aKw9nxBy0vXuHYCIg/P6n8grRcTdtRSjPtcak2uEox
	 5IwzQXo/5JZOBk87a4ucNLEKadhAOELeqn+8NEvSx7IKk/bWUpkA+oZXSG4pUgRuQ0
	 ySOS9nX8OCjgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA80DCE08E5; Wed,  9 Oct 2024 11:24:09 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:24:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180117.GS17263@noisy.programming.kicks-ass.net>

On Wed, Oct 09, 2024 at 08:01:17PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2024 at 09:54:06AM -0700, Ankur Arora wrote:
> > PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
> > which allows for dynamic switching of preemption models.
> > 
> > The choice of preemptible RCU or not, however, is fixed at compile
> > time. Given the trade-offs made to have a preemptible RCU, some
> > configurations which have limited preemption might prefer the
> > stronger forward-progress guarantees of PREEMPT_RCU=n.
> > 
> > Accordingly, explicitly limit PREEMPT_RCU=y to PREEMPT_DYNAMIC,
> > PREEMPT, PREEMPT_RT.
> > 
> > This means that (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), which selects
> > PREEMPTION will run with PREEMPT_RCU=n. The combination (PREEMPT_LAZY=y,
> > PREEMPT_DYNAMIC=y), will run with PREEMPT_RCU=y.
> 
> I am completely confused by this. Why do we want this?

In order to support systems that currently run CONFIG_PREEMPT=n that
are adequately but not overly endowed with memory.  If we allow all
RCU readers to be preempted, we increase grace-period latency, and also
increase OOM incidence.  Which we would like to avoid.

But we do want lazy preemption otherwise, for but one thing to reduce
tail latencies and to reduce the need for preemption points.  Thus, we
want a way to allow lazy preemption in general, but to continue with
non-preemptible RCU read-side critical sections.

Or am I once again missing your point?

							Thanx, Paul

> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > ---
> >  kernel/rcu/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 3e079de0f5b4..1bfe7016724f 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -18,7 +18,7 @@ config TREE_RCU
> >  
> >  config PREEMPT_RCU
> >  	bool
> > -	default y if PREEMPTION
> > +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> >  	select TREE_RCU
> >  	help
> >  	  This option selects the RCU implementation that is
> > -- 
> > 2.43.5
> > 

