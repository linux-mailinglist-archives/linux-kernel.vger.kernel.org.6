Return-Path: <linux-kernel+bounces-372151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF269A4519
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA891F211BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B6212643;
	Fri, 18 Oct 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HstQepkw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBA210C39
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273096; cv=none; b=l4cLPYwqm+Pyt1jB6PXaAIQ5rvUcFjO5oOG6L0mOIK8hSXageMVjG8ek12j0x7RqEITXNwafbA2M7zOL1M+m5DEJIQdwz19bxVomY7DkE6KDMiIzsiavLzZLfIhnwziXkgykhAtIxnlE+3zekmclHliVV+P/PVny6J/AtowiAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273096; c=relaxed/simple;
	bh=Js51YJf9DS/kJLC2owRJ8+Z9Ht5GnmdzwL6VRpVWxyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXhQDgGqVhRpODtkKPzUry6SzT2VGu03PVg94n52c/OPJWYsO0MbmwNo83h0h4mk+h278/y91QYir191h6W7AzWQrpvTYP8HWUrX1QihGzrB0yvjTv4pcpnZwhw30yXKlFa6lghf1jPL8/suw2bHoczEftc70yvIYEHK08dxiyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HstQepkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF273C4CEC3;
	Fri, 18 Oct 2024 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273095;
	bh=Js51YJf9DS/kJLC2owRJ8+Z9Ht5GnmdzwL6VRpVWxyk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HstQepkwa51FGWUirPMff1xMPiNvXNIYAo36zwOaAAyaqZhNfq4BhBUFXG1/Ra005
	 gFqvFZxV+1dI6VywBHY/1a7Dri9lONtIRa4DXf/ofJGml7LzuM+JJZ0uXjv6FbVlx9
	 Sdd9KXV14BNp85jOTx7eUJFYd8zepFvgXlr8pZo0mR0jtl+UD9U75I24eZs/bIqrSs
	 GJ5PBKUDP86EhMa6uOph3bsuVb1UWLtx3Es8PAzlHYs5pi33s7SD/411LVjI12bFzp
	 SXppLWzu1xrHneR7gQTvz+XYnweEzhMiY+sSr11MfJY08gkToVjTRnje2uC/ogHmV1
	 L//YOos6LpxgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 57581CE0995; Fri, 18 Oct 2024 10:38:15 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:38:15 -0700
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
Message-ID: <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
 <20241017070710.U9bTJFMS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017070710.U9bTJFMS@linutronix.de>

On Thu, Oct 17, 2024 at 09:07:10AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-15 16:11:55 [-0700], Paul E. McKenney wrote:
> > > | config PREEMPT_RCU
> > > | 	bool
> > > | 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> > > | 	select TREE_RCU
> > > | 	help
> > > 
> > > would disable PREEMPT_RCU while the default model is PREEMPT. You argue
> > > that only people on small embedded would do such a thing and they would
> > > like to safe additional memory. 
> > 
> > I am more worried about large datacenter deployments than small embedded
> > systems.  Larger systems, but various considerations often limit the
> > amount of memory on a given system.
> 
> okay.
> 
> > > I don't think this is always the case because the "preemptible" users
> > > would also get this and this is an unexpected change for them.
> > 
> > Is this series now removing PREEMPT_NONE and PREEMPT_VOLUNTARY?
> no, not yet. It is only adding PREEMPT_LAZY as new model, next to
> PREEMPT_NONE and PREEMPT_VOLUNTARY. But is is likely to be on schedule.
> 
> > As conceived last time around, the change would affect only kernels
> > built with one of the other of those two Kconfig options, which will
> > not be users expecting preemption.
> 
> If you continue to use PREEMPT_NONE/ PREEMPT_VOLUNTARY nothing changes
> right now.

Good, thank you!

Presumably PREEMPT_NONE=y && PREEMPT_LAZY=y enables lazy preemption,
but retains non-preemptible RCU.

> > > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> > > index 8cf8a9a4d868c..2183c775e7808 100644
> > > --- a/kernel/Kconfig.preempt
> > > +++ b/kernel/Kconfig.preempt
> > > @@ -121,6 +121,7 @@ config PREEMPT_COUNT
> > >  config PREEMPTION
> > >         bool
> > >         select PREEMPT_COUNT
> > > +       select PREEMPT_RCU if PREEMPT_DYNAMIC
> > >  
> > >  config PREEMPT_DYNAMIC
> > >  	bool "Preemption behaviour defined on boot"
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index 3e079de0f5b43..9e4bdbbca4ff9 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -17,7 +17,7 @@ config TREE_RCU
> > >  	  smaller systems.
> > >  
> > >  config PREEMPT_RCU
> > > -	bool
> > > +	bool "Preemptible RCU"
> > >  	default y if PREEMPTION
> > >  	select TREE_RCU
> > >  	help
> > > @@ -91,7 +91,7 @@ config NEED_TASKS_RCU
> > 
> > If PREEMPT_NONE and PREEMPT_VOLUNTARY are still around, it would be
> > far better to make PREEMPT_RCU depend on neither of those being set.
> > That would leave the RCU Kconfig settings fully automatic, and this
> > automation is not to be abandoned lightly.
> 
> Yes, that was my intention - only to make is selectable with
> LAZY-preemption enabled but without dynamic.
> So you are not complete against it.

Help me out here.  In what situation is it beneficial to make PREEMPT_RCU
visible, given that PREEMPT_NONE, PREEMPT_VOLUNTARY, PREEMPT, and
PREEMPT_FULL already take care of this automatically?

> > >  config TASKS_RCU
> > >  	bool
> > > -	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
> > > +	default NEED_TASKS_RCU && PREEMPTION
> > >  	select IRQ_WORK
> > >  
> > >  config FORCE_TASKS_RUDE_RCU
> > > 
> > > I added TASKS_RCU to the hunk since I am not sure if you wish to follow
> > > PREEMPTION (which is set by LAZY) or PREEMPT_RCU.
> > 
> > TASKS_RCU needs to be selected when there is preemption of any kind,
> > lazy or otherwise, regardless of the settign of PREEMPT_RCU.
> 
> Okay. In that case PREEMPT_AUTO can be removed.

Makes sense to me!

							Thanx, Paul

> > The current substition of vanilla RCU for Tasks RCU works only in
> > kernels that are guaranteed non-preemptible, which does not include
> > kernels built with lazy preemption.
> > 
> > 							Thanx, Paul
> 
> Sebastian

