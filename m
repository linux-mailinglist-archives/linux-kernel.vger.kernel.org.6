Return-Path: <linux-kernel+bounces-369289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3D9A1B57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5E31C21138
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAB1C1AC8;
	Thu, 17 Oct 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kmE8RUCy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z97onf52"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20918E04E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148841; cv=none; b=lBsp1krd6tzxiyc1XqiNsWC74c4p8Ur6ezeSrhjdLRvuizeb38AGjbjOQb9hB4iOrm3muebahzxQx4ZKUNp4KWOL680a5Wz53xC45bMchWJxKujD0kcGQVMjpt98hk7Y2cxYnrRtoXJ1PMnAOys1eaPLKhCEzmYWf+MW4mnhhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148841; c=relaxed/simple;
	bh=sIGqqdWlmhjVGI/u89kG3FIvtMw1rrXgFC9g3MqsmpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4m/OL/p2OJbQvdJ6V2kZqor8KJI1NLq9fTOHUef0a4GepbidySwSCbXzthrGXFaS0u2aKzIGEZ7Jr9kEbMqDAMBhsM6+aOSdDw/IUXlqkoXj2WEY5+bNX+5cHfMlDlwyCGyuMB8AlLMIAJd6CBnnLj5/UzYIFso1C6/dVBHJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kmE8RUCy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z97onf52; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 09:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729148831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7DoTdKA3nDK8yE5XNgt+32K3vKfokW3R0/yLlbmoGAM=;
	b=kmE8RUCy7XtJYq7seJLu+EpMgRCm0SLRmSz4i0wW5DTKiLvvKXVJNcqXubGXzJvl+HNcsp
	xtkTy3gsNWNviOEjQXLPxsrk4hYZOiGIad5RPoTBeaLw8py3DXZporwampud2VP27XWgSA
	0GMt/Cudu48r06gksSOChgTI4ta3o5o8edmifna4t8TmzKsCOT0PnxOkkGVmvokuX5kSVN
	fVsVkllbXctNesR1gJ2yb/dv8Dc36Uy5P+h+XlLOM7Qyxyu7UuLZeSKegXpalL1lQFZowb
	zXHaSGAf+P96FGwD+un607CZE43b/oMfs/dp4E0Na5+DKZZe4A2+00ARMwKDQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729148831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7DoTdKA3nDK8yE5XNgt+32K3vKfokW3R0/yLlbmoGAM=;
	b=Z97onf52XQAy+W8UxRgIIV8LNK2jwWrTgcN0yTHbLQUFMXwRjNzS63+lf3G3s6gtBl/xAF
	srRzC4WrPQSieyDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241017070710.U9bTJFMS@linutronix.de>
References: <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>

On 2024-10-15 16:11:55 [-0700], Paul E. McKenney wrote:
> > | config PREEMPT_RCU
> > | 	bool
> > | 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> > | 	select TREE_RCU
> > | 	help
> > 
> > would disable PREEMPT_RCU while the default model is PREEMPT. You argue
> > that only people on small embedded would do such a thing and they would
> > like to safe additional memory. 
> 
> I am more worried about large datacenter deployments than small embedded
> systems.  Larger systems, but various considerations often limit the
> amount of memory on a given system.

okay.

> > I don't think this is always the case because the "preemptible" users
> > would also get this and this is an unexpected change for them.
> 
> Is this series now removing PREEMPT_NONE and PREEMPT_VOLUNTARY?
no, not yet. It is only adding PREEMPT_LAZY as new model, next to
PREEMPT_NONE and PREEMPT_VOLUNTARY. But is is likely to be on schedule.

> As conceived last time around, the change would affect only kernels
> built with one of the other of those two Kconfig options, which will
> not be users expecting preemption.

If you continue to use PREEMPT_NONE/ PREEMPT_VOLUNTARY nothing changes
right now.

> > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> > index 8cf8a9a4d868c..2183c775e7808 100644
> > --- a/kernel/Kconfig.preempt
> > +++ b/kernel/Kconfig.preempt
> > @@ -121,6 +121,7 @@ config PREEMPT_COUNT
> >  config PREEMPTION
> >         bool
> >         select PREEMPT_COUNT
> > +       select PREEMPT_RCU if PREEMPT_DYNAMIC
> >  
> >  config PREEMPT_DYNAMIC
> >  	bool "Preemption behaviour defined on boot"
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 3e079de0f5b43..9e4bdbbca4ff9 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -17,7 +17,7 @@ config TREE_RCU
> >  	  smaller systems.
> >  
> >  config PREEMPT_RCU
> > -	bool
> > +	bool "Preemptible RCU"
> >  	default y if PREEMPTION
> >  	select TREE_RCU
> >  	help
> > @@ -91,7 +91,7 @@ config NEED_TASKS_RCU
> 
> If PREEMPT_NONE and PREEMPT_VOLUNTARY are still around, it would be
> far better to make PREEMPT_RCU depend on neither of those being set.
> That would leave the RCU Kconfig settings fully automatic, and this
> automation is not to be abandoned lightly.

Yes, that was my intention - only to make is selectable with
LAZY-preemption enabled but without dynamic.
So you are not complete against it.

> >  config TASKS_RCU
> >  	bool
> > -	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
> > +	default NEED_TASKS_RCU && PREEMPTION
> >  	select IRQ_WORK
> >  
> >  config FORCE_TASKS_RUDE_RCU
> > 
> > I added TASKS_RCU to the hunk since I am not sure if you wish to follow
> > PREEMPTION (which is set by LAZY) or PREEMPT_RCU.
> 
> TASKS_RCU needs to be selected when there is preemption of any kind,
> lazy or otherwise, regardless of the settign of PREEMPT_RCU.

Okay. In that case PREEMPT_AUTO can be removed.

> The current substition of vanilla RCU for Tasks RCU works only in
> kernels that are guaranteed non-preemptible, which does not include
> kernels built with lazy preemption.
> 
> 							Thanx, Paul

Sebastian

