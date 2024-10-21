Return-Path: <linux-kernel+bounces-374789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CA9A7006
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559A4B210F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3D1E7C32;
	Mon, 21 Oct 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+VYqa+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481E1C7B81
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529284; cv=none; b=uKJi2HgYej/Tr44ySACn8R9XggwG8lte9LqaJNF1t3cYzGpcIwyl1IEC/fTmCMMJsAMoVOVz1Swd4STsVuIDRA7Qmc1xkIUDfWGYRS1ML0cPimnPSSEzjku6/sgMoGyjCy5Fc8AQBkO5+z+dZ6FgfC3sh2tqCAKIqCWdZff7T4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529284; c=relaxed/simple;
	bh=5NnBU2Ai6e6DvESDM4ffFKsUHcu7Qz3Puk15NxCcewQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRBYtmkExLpUVdwBt1DS48q63H6D+ZQQ0TRXcryeVUcGMUAkNbFEjyRE5UpeyKN+rT+lkAbE/7HGfw5muE9OCXge8/bLL+x8LBhZr1c8PAG87SSpuRXTyZjUAhPrmzI+M2qvxX7ZQ38DavOQOgZRJ7gN+1dN3EM4VDrMkXQ70wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+VYqa+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA32C4CEC3;
	Mon, 21 Oct 2024 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529284;
	bh=5NnBU2Ai6e6DvESDM4ffFKsUHcu7Qz3Puk15NxCcewQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=G+VYqa+37hpm72UQZLUjE1UuP171yXiQb3W3N86uxbEROIYmmqYLAUa0RZZl47ECo
	 pYwjo5Am7ZPX5uVlZJE6429mhxIvQKILaT2vI5XwKjhxJkbilna71riqdyn6mmT1n1
	 l7M+7AUSPIsmGXEsvEveJ6Gc+SgBRNvfYe6ZZDad3I7mTFGGjCWBozPxpwH+TRv+vc
	 sDXXKUeitUqTqD9foYQKe8DNR3sIt7CP4ZKOrtvBXIBXyBg1LW48FQcQrD9zmlCAGW
	 FqVofMd8Rlfxhk5ybFn3h9KPm7PcK50d2fj0CHAYIIaCqk7/wP+lI57mH6JQCj1oZF
	 UD+uLg1jIP9Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BE156CE0DFD; Mon, 21 Oct 2024 09:48:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 09:48:03 -0700
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
Message-ID: <a71a7154-7cd4-44da-be41-5f2831fbfbbe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
 <20241017070710.U9bTJFMS@linutronix.de>
 <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>
 <20241021112755.m7dWNbc0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021112755.m7dWNbc0@linutronix.de>

On Mon, Oct 21, 2024 at 01:27:55PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-18 10:38:15 [-0700], Paul E. McKenney wrote:
> > > > > I don't think this is always the case because the "preemptible" users
> > > > > would also get this and this is an unexpected change for them.
> > > > 
> > > > Is this series now removing PREEMPT_NONE and PREEMPT_VOLUNTARY?
> > > no, not yet. It is only adding PREEMPT_LAZY as new model, next to
> > > PREEMPT_NONE and PREEMPT_VOLUNTARY. But is is likely to be on schedule.
> > > 
> > > > As conceived last time around, the change would affect only kernels
> > > > built with one of the other of those two Kconfig options, which will
> > > > not be users expecting preemption.
> > > 
> > > If you continue to use PREEMPT_NONE/ PREEMPT_VOLUNTARY nothing changes
> > > right now.
> > 
> > Good, thank you!
> > 
> > Presumably PREEMPT_NONE=y && PREEMPT_LAZY=y enables lazy preemption,
> > but retains non-preemptible RCU.
> 
> PREEMPT_NONE=y && PREEMPT_LAZY=y is exclusive. Either NONE or LAZY.

Ah, I was thinking in terms of the previous lazy-preemption patch series,
and just now got around to looking at the new one.  Apologies for my
confusion!

> > > > If PREEMPT_NONE and PREEMPT_VOLUNTARY are still around, it would be
> > > > far better to make PREEMPT_RCU depend on neither of those being set.
> > > > That would leave the RCU Kconfig settings fully automatic, and this
> > > > automation is not to be abandoned lightly.
> > > 
> > > Yes, that was my intention - only to make is selectable with
> > > LAZY-preemption enabled but without dynamic.
> > > So you are not complete against it.
> > 
> > Help me out here.  In what situation is it beneficial to make PREEMPT_RCU
> > visible, given that PREEMPT_NONE, PREEMPT_VOLUNTARY, PREEMPT, and
> > PREEMPT_FULL already take care of this automatically?
> 
> We have now NONE, VOLUNTARY, PREEMPT, PREEMPT_RT (as in choose one).
> 
> This series changes it to NONE, VOLUNTARY, PREEMPT, LAZY, LAZIEST.
> Ignore LAZIEST. PREEMPT_RT is a on/ off bool.

In terms of preemptibility, isn't the order from least to most preemptible
NONE, VOLUNTARY, LAZIEST, LAZY, PREEMPT, and PREEMPT_RT?  After all,
PREEMPT will preempt more aggressively than will LAZY which in turn
preempts more aggressively than LAZIEST.

And I finally do see the later patch in Peter's series that removes
PREEMPT_RT from the choice.  Plus I need to look more at LAZIEST in
order to work out whether Peter's suckage is our robustness.  ;-)

> Based on my understanding so far, you have nothing to worry about.
> 
> With NONE + VOLUNTARY removed in favor of LAZY or without the removal
> (yet)  you ask yourself what happens to those using NONE, go to LAZY and
> want to stay with !PREEMPT_RCU, right?
> With LAZY and !PREEMPT_DYNAMIC there is still PREEMPT_RCU as of now.
> And you say people using !PREEMPT_DYNAMIC + LAZY are the old NONE/
> VOLUNTARY users and want !PREEMPT_RCU.

Yes.

> This could be true but it could also attract people from PREEMPT which
> expect additional performance gain due to LAZY and the same "preemption"
> level. Additionally if PREEMPT gets removed because LAZY turns out to be
> superior then PREEMPT_DYNAMIC makes probably no sense since there is
> nothing to switch from/ to.

We definitely have users that would migrate from NONE to LAZY.  Shouldn't
their needs outweigh the possible future users that might (or might not)
find that (1) LAZY might be preferable to PREEMPT for some users and
(2) That those users would prefer that RCU be preemptible?

> Therefore I would suggest to make PREEMPT_RCU 
> - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> - selected for LAZY && PREEMPT_DYNAMIC
> - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
>   !PREEMPT_DYNAMIC)
> 
> Does this make sense to you?

Not really.  At the very least, default no.

Unless LAZIEST makes the most sense for us (which will take time to
figure out), in which case make PREMPT_RCU:

- hard-defined =n for LAZIEST.
- selectable for LAZY && !PREEMPT_DYNAMIC, default yes
- selected for LAZY && PREEMPT_DYNAMIC
- the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
  !PREEMPT_DYNAMIC)

Or am I still missing some aspect of this series?

							Thanx, Paul

