Return-Path: <linux-kernel+bounces-361458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD299A884
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F891F25973
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA0198E63;
	Fri, 11 Oct 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCtV48F8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0A188CB1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662355; cv=none; b=eIqVw+UIwuaKgYCAY7YMN5ixrBv3Y7WPBrX9eG8hov5uUblG669xClyMrUhp9ZP4SI6YHbm/x9K5Zs8bj26Ra4cBNTNa4IVNj0oYfN7eS5zvp7kiZiTuC3ImfziOdY2oeB5HocodaZfo+vzPTVR6e6WM+TAOFxFrl3w0aCAKBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662355; c=relaxed/simple;
	bh=fxbL2LvbjbB4QchIrtmiKO7zfTJqaN6zFcSprNoYthE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv3WxyWc+v1r+AHryBAYOBCK/wfsG7DmRvjsY7GYJerBziAAXuGROpHr+J3/5oM37Nircrj2xV/qjlFoR5cLwSroLgtthw56zhwU6lG7a9DX9rloyoBdOBVHPyG7Sv1M/ICQviMmWJixBz3Z9nH7ERSM2k2Cp70W6q0WQHkY7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCtV48F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD27C4CEC3;
	Fri, 11 Oct 2024 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662355;
	bh=fxbL2LvbjbB4QchIrtmiKO7zfTJqaN6zFcSprNoYthE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TCtV48F8xoC5vfbGYq72U8q/lG9aeoahKnpR481NQhM3FvDHYF1kgoo9XwcbYl1Wy
	 lDrP8bCs71zzo3Ko3WmcW24uebsl8aJzNiI0zXPfvjfmC3MCh6n494DkGJAQ63J/n8
	 vTKlHuk++K3jPl1CszOKTo2Zn/O4o6FQ2eoQxXqg0t8uj5aHhJXswM14MDI22u74w6
	 SLayqVF1325eN/7PiAI+6Mu6LzsEdi2tTsFIIROhQrRY48R1B9Yr6yu4psW/FQix9X
	 r5g6Gb2K4W9w5wrnXOPMMKHYK2iAJQWHMLijF6VJrbrDUAi/oFlb1TOAjCq9rwHjV2
	 Jzckjfs4QZzXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DE7ABCE0B78; Fri, 11 Oct 2024 08:59:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:59:14 -0700
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
Message-ID: <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011144341.mQKXkGkm@linutronix.de>

On Fri, Oct 11, 2024 at 04:43:41PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-11 06:59:44 [-0700], Paul E. McKenney wrote:
> > > > If you have PREEMPT_DYNAMIC, presumably you would like to boot with
> > > > preemption enabled, and would like it to act as if you had built the
> > > > kernel to be unconditionally preemptible, so again you need preemptible
> > > > RCU, and so the defaults should supply it.
> > > > 
> > > > If you started off building a non-preemptible kernel, then you are not
> > > > using one of the major distros (last I checked).  There is a good chance
> > > > that you have a large number of systems, and are thus deeply interested
> > > > in minimizing memory cost.  In which case, you need non-preemptible
> > > > RCU in the new-age lazy-preemptible kernel.
> > > > 
> > > > Hence the choice of non-preemptible RCU as the default in a kernel that,
> > > > without lazy preemption, would use non-preemptible RCU.
> > > 
> > > I *think* I slowly begin to understand. So we have LAZY and DYNAMIC
> > > enabled then and PREEMPT_RCU depends on the default choice which is
> > > either FULL (yes, please) or NONE/VOLUNTARY (no, thank you). But then if
> > > you change the model at runtime (or boottime) from (default) NONE to
> > > FULL you don't have preemptible RCU anymore.
> > 
> > Almost.  If you are able to change the model at boot time or at run time,
> > then you *always* have preemptible RCU.
> 
> Okay, this eliminates PREEMPT_DYNAMIC then.
> With PeterZ current series, PREEMPT_LAZY (without everything else
> enabled) behaves as PREEMPT without the "forced" wake up for the fair
> class. It is preemptible after all, with preempt_disable() actually
> doing something. This might speak for preemptible RCU.
> And assuming in this condition you that "low memory overhead RCU" which
> is not PREEMPT_RCU. This might require a config option.

The PREEMPT_DYNAMIC case seems to work well as-is for the intended users,
so I don't see a need to change it.  In particular, we already learned
that we need to set PREEMPT_DYNAMIC=n.  Yes, had I caught this in time, I
would have argued against changing the default, but this was successfully
slid past me.

As for PREEMPT_LAZY, you seem to be suggesting a more intrusive change
than just keeping non-preemptible RCU when the Kconfig options are
consistent with this being expected.  If this is the case, what are the
benefits of this more-intrusive change?

> > > If you would like to add some relief to memory constrained systems,
> > > wouldn't BASE_SMALL be something you could hook to? With EXPERT_RCU to
> > > allow to override it?
> > 
> > Does BASE_SMALL affect anything but log buffer sizes?  Either way, we
> > would still need to avoid the larger memory footprint of preemptible
> > RCU that shows up due to RCU readers being preempted.
> 
> It only reduces data structures where possible. So lower performance is
> probably due to things like futex hashmap (and others) are smaller.

Which is still counterproductive for use cases other than small deep
embedded systems.

> > Besides, we are not looking to give up performance vs BASE_SMALL's
> > "may reduce performance" help text.
> > 
> > Yes, yes, it would simplify things to just get rid of non-preemptible RCU,
> > but that is simply not in the cards at the moment.
> 
> Not sure what the time frame is here. If we go for LAZY and remove NONE
> and VOLUNTARY then making PREEMPT_RCU would make sense to lower the
> memory footprint (and not attaching to BASE_SMALL).
> 
> Is this what you intend or did misunderstand something here?

My requirement is that LAZY not remove/disable/whatever non-preemptible
RCU.  Those currently using non-preemptible RCU should continue to be able
to be able to use it, with or without LAZY.  So why is this requirement
a problem for you?  Or am I missing your point?

							Thanx, Paul

