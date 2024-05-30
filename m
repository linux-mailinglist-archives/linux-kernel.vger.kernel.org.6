Return-Path: <linux-kernel+bounces-195787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7552E8D51D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD5283CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279214CE05;
	Thu, 30 May 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAAEJizx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49C1BDDC
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093976; cv=none; b=UlqJzemGUdOB0zviLCFgGc1Y+xIS0fsVZDq+u+GC8MHFHZbL8rdI8arVZZvgT3jvzUONFJes93XWAE2lw0A74RXoRko77I34MNbqtSbwrb1lzxue/5knHcAeY0shbnKGtnQ3FOIMOQPH1mzp6/MQ4veEVrrdp9U/RjjHgZ2WALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093976; c=relaxed/simple;
	bh=gNqTWo2XHLxvBsJqH+AAZXFzbYlY/JjkMwxPP5WTT94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/dwoAU63eN5WoUQ34m+l+zFVdL4cB4AvsTn2MS24dfKVjCcl4JaopbcaRiD2DqNCO+fBe0n1DvYG5LyTJpofYKt7/vvSQwtJ6YnB1LJvr59B5OcG/l+ivP50L8NmEF87EMnURNMrCDhFv7cWMGI4kYUrEBl04CtYknGXCF1Ioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAAEJizx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EBDC2BBFC;
	Thu, 30 May 2024 18:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717093976;
	bh=gNqTWo2XHLxvBsJqH+AAZXFzbYlY/JjkMwxPP5WTT94=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mAAEJizxIWZn+AdcqNLKayKsKHntMJb8L/lOEfC8IzjYLoALtSdORxDZf1mGCuOrc
	 zkmyfbHDWXMtIMIOoKmknVjoq7E+0YnusqyBAeuePnowPj0baYZQQZh5nqo6/qMW4D
	 jSiECPbmN5wHUAaUyYNqCUt2N5D699AxaX7m/g2MZ4ZOR2YN4Rn0Y5cFu2Oi8as6Ms
	 Wwy7/yJN0DcLhf45tQvQmByQzixH96XPK0VvaAgJ/pg4x2OrqhFFyEOQy83rbRxeAd
	 MJ9ChikIN0+VKuCHAdX9qL8UQq60q+15qegKou/bJap1beC8eneufUGPFBaQPLht2n
	 VV1T9GmWX3yfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3C588CE075F; Thu, 30 May 2024 11:32:55 -0700 (PDT)
Date: Thu, 30 May 2024 11:32:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, torvalds@linux-foundation.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 16/35] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
Message-ID: <b629f8c9-8900-4317-9ea3-08a8dba7d896@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529081404.GI26599@noisy.programming.kicks-ass.net>

On Wed, May 29, 2024 at 10:14:04AM +0200, Peter Zijlstra wrote:
> On Mon, May 27, 2024 at 05:35:02PM -0700, Ankur Arora wrote:
> > The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
> > works at cross purposes: the RCU read side critical sections disable
> > preemption, while preempt=full schedules eagerly to minimize
> > latency.
> > 
> > Warn if the user is switching to full preemption with PREEMPT_RCU=n.
> > 
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > ---
> >  kernel/sched/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d7804e29182d..df8e333f2d8b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8943,6 +8943,10 @@ static void __sched_dynamic_update(int mode)
> >  		break;
> >  
> >  	case preempt_dynamic_full:
> > +		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> > +			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
> > +				PREEMPT_MODE);
> > +
> 
> Yeah, so I don't believe this is a viable strategy.
> 
> Firstly, none of these RCU patches are actually about the whole LAZY
> preempt scheme, they apply equally well (arguably better) to the
> existing PREEMPT_DYNAMIC thing.
> 
> Secondly, esp. with the LAZY thing, you are effectively running FULL at
> all times. It's just that some of the preemptions, typically those of
> the normal scheduling class are somewhat delayed. However RT/DL classes
> are still insta preempt.
> 
> Meaning that if you run anything in the realtime classes you're running
> a fully preemptible kernel. As such, RCU had better be able to deal with
> it.
> 
> So no, I don't believe this is right.

At one point, lazy preemption selected PREEMPT_COUNT (which I am
not seeing in this version, perhaps due to blindness on my part).
Of course, selecting PREEMPT_COUNT would result in !PREEMPT_RCU kernel's
rcu_read_lock() explicitly disabling preemption, thus avoiding preemption
(including lazy preemption) in RCU read-side critical sections.

Ankur, what am I missing here?

							Thanx, Paul

