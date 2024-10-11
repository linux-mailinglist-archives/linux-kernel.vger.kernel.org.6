Return-Path: <linux-kernel+bounces-361248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C196B99A59D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740A91F25833
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31007219C97;
	Fri, 11 Oct 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuReRlm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB012194A7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655185; cv=none; b=D1v+1+7y3786T5rcGG4XXO9LA96i4z3Zo6+QzCsjfBQS/XssXzKrGA0Wv3sktVIkYKKv68b5qVf1ldfRk7tx4Z7zCZLtIPeUHH45bXKnTXCYPH16TRYHVATk3v9XBW+K/q/MMwrsBYesQ66kJa1yaKhk5iM+2bT+SZ564JnXshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655185; c=relaxed/simple;
	bh=fxi9dweGK7yusXiGVV1jf2qwGdV9pOLNYbaVO8P3GlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS+tCCNMexwhp0jMPScoZHlj9Mru/QsavFHoxsiB0//QV4mcq1qR0F6OMYf3SJ7Jdc+QbTkOgTqsc02s1JwdSzUCvJxVKP4ullOJTXC4VHRVPL8fVCxcl02g+JrEkMYQxl4CqCSmayPNX9dg8pnAP9MpDPB+Mcwmrto+kW243bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuReRlm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F136C4CEC3;
	Fri, 11 Oct 2024 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728655185;
	bh=fxi9dweGK7yusXiGVV1jf2qwGdV9pOLNYbaVO8P3GlE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XuReRlm3ArsBrH5jOATEwAMKC/xQY58YK6PUyei+l9h8B9nP1esHtcSYNmYtPH8Uy
	 KvD0gderXvNb8JkEZG5kaulu0jwIMziXaMRr7oTXAgP0J3LrGZv0eCBjdRagbAG0mc
	 9svZpmMmfCuLkkwVuRdr/aX6bZoqnVeOalW1rQA5nDsv7bz5gG8FUdYXtoNLcgy+w+
	 jFFMgdVIbKVayurtRtMbpNGvrePY1EBqRcrrrJJjit3s5Er0Ano/mJehnhauMP7/vu
	 dD8QB1OfMKkPoIQGR28mheOw6LI9x3LGoThlexsX1PVDccJhhTOlsptGivUnrS8/FC
	 YFTMJhiERVx3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E91D5CE0B68; Fri, 11 Oct 2024 06:59:44 -0700 (PDT)
Date: Fri, 11 Oct 2024 06:59:44 -0700
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
Message-ID: <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011081847.r2x73XIr@linutronix.de>

On Fri, Oct 11, 2024 at 10:18:47AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-10 07:29:07 [-0700], Paul E. McKenney wrote:
> > If you have PREEMPT_RT, you need preemptible RCU, so the defaults should
> > supply it.
> > 
> > If you have PREEMPT_DYNAMIC, presumably you would like to boot with
> > preemption enabled, and would like it to act as if you had built the
> > kernel to be unconditionally preemptible, so again you need preemptible
> > RCU, and so the defaults should supply it.
> > 
> > If you started off building a non-preemptible kernel, then you are not
> > using one of the major distros (last I checked).  There is a good chance
> > that you have a large number of systems, and are thus deeply interested
> > in minimizing memory cost.  In which case, you need non-preemptible
> > RCU in the new-age lazy-preemptible kernel.
> > 
> > Hence the choice of non-preemptible RCU as the default in a kernel that,
> > without lazy preemption, would use non-preemptible RCU.
> 
> I *think* I slowly begin to understand. So we have LAZY and DYNAMIC
> enabled then and PREEMPT_RCU depends on the default choice which is
> either FULL (yes, please) or NONE/VOLUNTARY (no, thank you). But then if
> you change the model at runtime (or boottime) from (default) NONE to
> FULL you don't have preemptible RCU anymore.

Almost.  If you are able to change the model at boot time or at run time,
then you *always* have preemptible RCU.

> If you would like to add some relief to memory constrained systems,
> wouldn't BASE_SMALL be something you could hook to? With EXPERT_RCU to
> allow to override it?

Does BASE_SMALL affect anything but log buffer sizes?  Either way, we
would still need to avoid the larger memory footprint of preemptible
RCU that shows up due to RCU readers being preempted.

Besides, we are not looking to give up performance vs BASE_SMALL's
"may reduce performance" help text.

Yes, yes, it would simplify things to just get rid of non-preemptible RCU,
but that is simply not in the cards at the moment.

							Thanx, Paul

