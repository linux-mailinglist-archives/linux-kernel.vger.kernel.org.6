Return-Path: <linux-kernel+bounces-377135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949819ABA40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60E41C22B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08841CEE9D;
	Tue, 22 Oct 2024 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRhkBJjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055D126C05
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641252; cv=none; b=fr9ZfmLYD+XoyZwWLEB1vC4IKk6BK5VOvR+Y0Z1drSV6yvfl9W819ZZEooNkImXPJCbIH11QMPmGcJZn+dM8Doz1/w+l9+lb47XHaR+XvN0PW7gNSUjGelGjxxzquniD1dZDAVWyTtXBKHj2ttJZRdzDVsu1oKC7q+JnoiyDcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641252; c=relaxed/simple;
	bh=tb4eDPBX3jqdSdEcLPI9dm8xCPevHbtQmzIMqJwNgec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQjIa0vHrk5R9yQ7L3Qm2uB6SoA4xLRmP0Xz44q5km1eiFF6M4QjEC1PdwThWioDVLaHSewhDkC9Q4ASdAZcjLTbK6Ob4ORiHV/fnzNRb6F9RoV8D4fpaZtwzn/X5BIPMRPSN+6t8oZ378j3KELwglV09YL47aVwbuHyBxXsHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRhkBJjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2F1C4CEC3;
	Tue, 22 Oct 2024 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729641251;
	bh=tb4eDPBX3jqdSdEcLPI9dm8xCPevHbtQmzIMqJwNgec=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BRhkBJjSQKsHAyxOmdM2Q41zaKjktt2irjwrHmuEphpJ7t16a0ZTRUpnl4rzPWrjj
	 5p7XNIberV7h4WoIpkKGBY94UxLfuULfhtJUw7rcFOH/UKHTuLoUTsHD05wNsV/ktR
	 jxjnsIjewGnBmz5WFuGAZWt2cshjibxzY01dnMoqaqHbd+bgye/rHUbExYHXbqE5rz
	 EfzUjmFx3aCTMpcIx1pq3MlEQyYTLln/1AMnWQbjnxFwMmr2Lp7e+A50ZwfbsiXnjG
	 p9GtwrFDJ4j1LDHOElTyMMHj6WoIYBJ2SkxZHUlH5Vw/0aL6B8EjSWWNdkdI/5ALjZ
	 goZrk1ZyH7+Rw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3D3F7CE0A48; Tue, 22 Oct 2024 16:54:11 -0700 (PDT)
Date: Tue, 22 Oct 2024 16:54:11 -0700
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
Message-ID: <88b90ca8-9d73-4691-b391-43891a057c77@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
 <20241017070710.U9bTJFMS@linutronix.de>
 <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>
 <20241021112755.m7dWNbc0@linutronix.de>
 <a71a7154-7cd4-44da-be41-5f2831fbfbbe@paulmck-laptop>
 <20241022140933.XfxSIpDu@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022140933.XfxSIpDu@linutronix.de>

On Tue, Oct 22, 2024 at 04:09:33PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-21 09:48:03 [-0700], Paul E. McKenney wrote:
> > > We have now NONE, VOLUNTARY, PREEMPT, PREEMPT_RT (as in choose one).
> > > 
> > > This series changes it to NONE, VOLUNTARY, PREEMPT, LAZY, LAZIEST.
> > > Ignore LAZIEST. PREEMPT_RT is a on/ off bool.
> > 
> > In terms of preemptibility, isn't the order from least to most preemptible
> > NONE, VOLUNTARY, LAZIEST, LAZY, PREEMPT, and PREEMPT_RT?  After all,
> > PREEMPT will preempt more aggressively than will LAZY which in turn
> > preempts more aggressively than LAZIEST.
> > 
> > And I finally do see the later patch in Peter's series that removes
> > PREEMPT_RT from the choice.  Plus I need to look more at LAZIEST in
> > order to work out whether Peter's suckage is our robustness.  ;-)
> 
> For LAZIEST PeterZ added "do we want this?". I haven't tested this but
> since there is no forced preemption at all, it should be what is NONE
> without cond_resched() & friends. So I don't know if it stays, I don't
> think so.

I don't know of a compelling reason for it to.

> > > Based on my understanding so far, you have nothing to worry about.
> > > 
> > > With NONE + VOLUNTARY removed in favor of LAZY or without the removal
> > > (yet)  you ask yourself what happens to those using NONE, go to LAZY and
> > > want to stay with !PREEMPT_RCU, right?
> > > With LAZY and !PREEMPT_DYNAMIC there is still PREEMPT_RCU as of now.
> > > And you say people using !PREEMPT_DYNAMIC + LAZY are the old NONE/
> > > VOLUNTARY users and want !PREEMPT_RCU.
> > 
> > Yes.
> > 
> > > This could be true but it could also attract people from PREEMPT which
> > > expect additional performance gain due to LAZY and the same "preemption"
> > > level. Additionally if PREEMPT gets removed because LAZY turns out to be
> > > superior then PREEMPT_DYNAMIC makes probably no sense since there is
> > > nothing to switch from/ to.
> > 
> > We definitely have users that would migrate from NONE to LAZY.  Shouldn't
> > their needs outweigh the possible future users that might (or might not)
> > find that (1) LAZY might be preferable to PREEMPT for some users and
> > (2) That those users would prefer that RCU be preemptible?
> 
> Yes. I have no idea which of those two (PREEMPT_RCU vs !PREEMPT_RCU) is
> to be preferred. Therefore I'm suggesting to make configurable here.

As Ankur noted, the original intent was to move people from both
PREEMPT_NONE and PREEMPT_VOLUNTARY to lazy preemption.  This strongly
suggests setting the value of PREEMPT_RCU to n.  Not just the default,
but the value.  We need to have a definite non-speculative case for
forcing people to once again worry about RCU preemptibility, and I know
of no such case.

> If you have a benchmark for memory consumption or anything else of
> interest, I could throw it a box or two to get some numbers. I've been
> looking at free memory at boot and this was almost the same (+- noise).

Unfortunately, the benchmark is the fleet and all of the various
non-public applications that run on it.  :-(

> > > Therefore I would suggest to make PREEMPT_RCU 
> > > - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> > > - selected for LAZY && PREEMPT_DYNAMIC
> > > - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
> > >   !PREEMPT_DYNAMIC)
> > > 
> > > Does this make sense to you?
> > 
> > Not really.  At the very least, default no.
> > 
> > Unless LAZIEST makes the most sense for us (which will take time to
> > figure out), in which case make PREMPT_RCU:
> > 
> > - hard-defined =n for LAZIEST.
> > - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> > - selected for LAZY && PREEMPT_DYNAMIC
> > - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
> >   !PREEMPT_DYNAMIC)
> > 
> > Or am I still missing some aspect of this series?
> 
> no, that is perfect.

And assuming LAZIEST is not to be with us much longer, this becomes:

- hard-defined to "no" for LAZY && !PREEMPT_DYNAMIC, just like
  NONE or VOLUNTARY with !PREEMPT_DYNAMIC.
- selected for LAZY && PREEMPT_DYNAMIC
- the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
  !PREEMPT_DYNAMIC)

Fair enough?

							Thanx, Paul

