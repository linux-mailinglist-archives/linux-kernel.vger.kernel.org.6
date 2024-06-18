Return-Path: <linux-kernel+bounces-219869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C693A90D937
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF5E1C24817
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB426F30B;
	Tue, 18 Jun 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XenkW4WI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452555E48
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728164; cv=none; b=ui6+4eKKZJcrZ4xisHWEc8vcFKJyHikbtyuBBmfNhlAVlb3ALQyhrQFvq5w9xHk/NztoJ+hb9rT3iVMPM41Hcqy/w2pUj/9CjMLZbKEzv03PE0bEjuYaj2kx/pPxc+2AFflSnMf7rzXOWXtU6hDRNIz73urhzpdF5ZDE7+zc//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728164; c=relaxed/simple;
	bh=vuW5h/oY0hHvI7hND/3jeKMG7BATBbLvHjWp3v/iu08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxYnO959dZ+nX7ms4Pb94RBDoMxmLE27f+qXSBQbvXwketdhYdjqkwiDIZDlv9wy/Xtf19ntm6Jb/mqW/KAFTl6lDsIGKT5SJCx+cJMYtc6/U8D7VY1VDfPwyRQh5z9b8gZSPV/NXTHimnSO6/oo1S1X2is78PpvdCum037XCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XenkW4WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A114C3277B;
	Tue, 18 Jun 2024 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718728164;
	bh=vuW5h/oY0hHvI7hND/3jeKMG7BATBbLvHjWp3v/iu08=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XenkW4WI8qQpvw4PWBNcQoUDMwxOt0AT51XCUUufyfmoT8njV1lULMb6d4Zv9+KkR
	 AJ6cBMEN2MuHnuE0ss54UKrQqQQbqM5idtsRgdqoWTrkZUcfxIvKDL7hckt4GaMr5P
	 NZTTYdbQajmapzVjcPjX8cR6PAFFdY0trZAXwW94ZFXWwNcuBdbdyF51UND3YOo3f/
	 jOXbNO4YgtSuZVheUCW/oNVN84DDmLjzQ7I1uWg1iv+xLk7xcY5lIQnEjn3YiPWCSs
	 9KmeitmJJhHJPK+GDTMBgb9k4DVBXa9U9B0acM95HC8/42lPTgncqzlatbIvzC7IVJ
	 nWMnyRKXDDfEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 129B4CE05B6; Tue, 18 Jun 2024 09:29:24 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:29:24 -0700
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
Message-ID: <c8c992d4-374a-4b7c-bafd-1e12d5506bc0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
 <8734py6gvq.fsf@oracle.com>
 <c6b5a5e4-e14e-4fbb-84af-75d4035ced32@paulmck-laptop>
 <20240606115325.GD8774@noisy.programming.kicks-ass.net>
 <c32af67a-a107-44d4-981d-53c6ed583d7e@paulmck-laptop>
 <a3560a75-57ca-4c95-a152-2edae47b306d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3560a75-57ca-4c95-a152-2edae47b306d@paulmck-laptop>

On Mon, Jun 17, 2024 at 08:54:49AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 06, 2024 at 06:38:57AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 06, 2024 at 01:53:25PM +0200, Peter Zijlstra wrote:
> > > On Thu, May 30, 2024 at 04:20:26PM -0700, Paul E. McKenney wrote:
> > > 
> > > > My selfish motivation here is to avoid testing this combination unless
> > > > and until someone actually has a good use for it.
> > > 
> > > That doesn't make sense, the whole LAZY thing is fundamentally identical
> > > to FULL, except it sometimes delays the preemption a wee bit. But all
> > > the preemption scenarios from FULL are possible.
> > 
> > As noted earlier in this thread, this is not the case for non-preemptible
> > RCU, which disables preemption across its read-side critical sections.
> > In addition, from a performance/throughput viewpoint, it is not just
> > the possibility of preemption that matters, but also the probability.
> > 
> > > As such, it makes far more sense to only test FULL.
> > 
> > You have considerable work left to do in order to convince me of this one.
> 
> On the other hand, it does make sense to select Tiny SRCU for all !SMP
> kernels, whether preemptible or not.

Except that testing made a liar out of me.  SRCU priority boosting would
be required.  So this one is also strictly for pre-testing lazy
preemption.

As usual, it seemed like a good idea at the time...  ;-)

							Thanx, Paul

>                                       And it also makes sense to test
> (but not *only* test and definitely *not* support) non-preemptible
> RCU running in a preemptible kernel, perhaps as a one-off, perhaps
> longer term.  The point being of course that the increased preemption
> rate of a fully preemptible kernel should uncover bugs that might appear
> in lazy-preemptible kernels only very rarely.
> 
> This might have been what you were getting at, and if so, apologies!
> But in my defense, you did say "only test FULL" above.  ;-)
> 
> 							Thanx, Paul

