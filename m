Return-Path: <linux-kernel+bounces-372160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D518D9A452A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C29A1F210BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D96204021;
	Fri, 18 Oct 2024 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucGXBLkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C8C14F136
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273384; cv=none; b=JPF4xBXk8x24eVWwwoSfsssHbYcCAY7WtZ/SUrvy23cJLNEdWgtrzaLKk7HRLBGIX7e0L1qJU9HCJpOXX7TM1VSJ3c3kh8BQmNXtIBKMPJdcOjnykDle9kWRCvelBJ13GWOgaaH+u9QfdvZ6PKTRVbaVchHTBqH8EMAbhAu81C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273384; c=relaxed/simple;
	bh=XdcCZe8l4b5G9qvR3xzXUwFKkGASXXkTBgtp6GI8Mw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDbBk32s2TsneHLHVlTDYn3RtMImZSGGlRThj3pqnBrUufSYMrz02GWn9FJ/Y6wREzR6iSFcB+DavYEQQRhfvAFeMLwhiAPau3HR87TkW6vEWAhScOT6aJvqp1By3mgLE8X1MUbyWuv5nQndfDwH/XvyAP6cGN4yhIosHQlHzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucGXBLkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67363C4CEC3;
	Fri, 18 Oct 2024 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273383;
	bh=XdcCZe8l4b5G9qvR3xzXUwFKkGASXXkTBgtp6GI8Mw0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ucGXBLkYup6N8mw+Her5u9hTThc2SoY/QDFrtU9vBXzmXC2VrxP3aq/85k43nrV7/
	 l05SF56B5SvF2qC0ySXtl+iIjHQPFhYYPlBD0xtUvl6v8A5bU+mF0BVaFBsR8iz9Z0
	 Uc6xqXSVIvYouWQPulaXDfhIGqDwwQRBZWZXDU47LpSTrvNzGquVsyFzygrq5MvV20
	 FejPBtaQ9MLhyO3CRP6GyXNOEUiE0BmgDkRCGrHN+Jiz7BBhI5RaplDrr2RvRo4JTs
	 vQhGNrA631zb4H+iICC2VkM1XhWCu/+/enkc/pWnPEGC6u6pt1TpEJx9DfUjN8XM0P
	 liyahLfC8rBlA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCE01CE0995; Fri, 18 Oct 2024 10:43:02 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:43:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <0c04a986-91d0-4f6d-bd4e-ca00d1cd710a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <87ed4hrp45.fsf@oracle.com>
 <20241017080439.9od9eoBO@linutronix.de>
 <871q0emji1.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q0emji1.fsf@oracle.com>

On Thu, Oct 17, 2024 at 03:50:46PM -0700, Ankur Arora wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> > On 2024-10-15 15:13:46 [-0700], Ankur Arora wrote:
> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >>
> >> >>
> >> >> As for PREEMPT_LAZY, you seem to be suggesting a more intrusive change
> >> >> than just keeping non-preemptible RCU when the Kconfig options are
> >> >> consistent with this being expected.  If this is the case, what are the
> >> >> benefits of this more-intrusive change?
> >> >
> >> > As far as I understand you are only concerned about PREEMPT_LAZY and
> >> > everything else (PREEMPT_LAZY + PREEMPT_DYNAMIC or PREEMPT_DYNAMIC
> >> > without PREEMPT_LAZY) is fine.
> >> > In the PREEMPT_LAZY + !PREEMPT_DYNAMIC the suggested change
> >> >
> >> > | config PREEMPT_RCU
> >> > | 	bool
> >> > | 	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> >> > | 	select TREE_RCU
> >> > | 	help
> >> >
> >> > would disable PREEMPT_RCU while the default model is PREEMPT. You argue
> >>
> >> With PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n, isn't the default model
> >> PREEMPT_LAZY, which has PREEMPTION=y, but PREEMPT=n?
> >
> > Correct.
> >
> >> > that only people on small embedded would do such a thing and they would
> >> > like to safe additional memory.
> >> >
> >> > I don't think this is always the case because the "preemptible" users
> >> > would also get this and this is an unexpected change for them.
> >>
> >> Can you clarify this? The intent with lazy is to be preemptible but
> >> preempt less often. In that it is meant to be quite different from
> >> CONFIG_PREEMPT.
> >
> > A wake up with PREEMPT may not always lead to a preemption but will lead
> > to preemption once the time slice is up. With LAZY this changes to the
> > point that a preemption point will be delayed to the sched tick. Tasks
> > which are not based on the fail class (SCHED_DL, FIFO, …) will receive a
> > wake up right away.
> 
> >> > I don't think this is always the case because the "preemptible" users
> >> > would also get this and this is an unexpected change for them.
> 
> Yes. My point was that "preemptible" is a mechanism.
> 
> The policy about how often preemption happens is determined by the
> chosen model PREEMPT_NONE/PREEMPT_VOLUNTARY/PREEMPT_LAZY/PREEMPT/
> PREEMPT_RT.
> 
> > If in the long term NONE and VOL goes away you could argue that everyone
> > using LAZY + !DYNAMIC is one of those.
> 
> > If additionally PREEMPT goes away then you can not.
> 
> Sure. But, that's just begging the question.
> 
> We want _NONE and _VOLUNTARY to go away because keeping cond_resched()
> around incurs a cost.

When you say "go away", do you mean for your use cases?  Or globally?

> > Therefore I would prefer to have the RCU model to be
> > selectable rather than forced. While !PREEMPT_RCU may save memory, it
> > also disable preemption for the read section.
> 
> When a user chooses one of PREEMPT_NONE/_VOLUNTARY/_LAZY, the implication
> is that on the throughput -- latency axis, they care about optimizing
> for throughput.
> 
> PREEMPT_RCU=n is clearly oriented towards that.

Agreed!

> That said, I'm agnostic about making the RCU model selectable. Paul
> is the best judge of that.

I am not seeing any reason to make it once again be selectable, and
plenty of reasons to keep it automatic.

If I am missing some motivation to bother users with the need to make
this decision, please let me know what that motivation might be.

							Thanx, Paul

