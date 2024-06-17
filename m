Return-Path: <linux-kernel+bounces-217895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C870390B5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804D91F21DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3577345C;
	Mon, 17 Jun 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfVw62D2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E096BFAA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639690; cv=none; b=h6ByMkanba5mlMQYg8JiRdO7H2XVYAwUwSaqc1dJzaw52KjZnl2D3w35k+ETBRWhUWUs/UTg3kIwgI/jBtXRPzu6obhprH903do0c08CZgXOKW3VlRCSy3pQ3y6lvYq6UkRwnIsmeirKCOrtx5EsP3sthSmoU+kceSE9ET5ZOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639690; c=relaxed/simple;
	bh=aqvoUEjYW4RZE7fxt5CI3kgvpjBcVCSQRYCT2VNghOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiCbjbBj8y0+ItPd9TgoAI61co4zoafnj+a7KHir3Q+zUi0SxWt+pMVxMJJsEu5EiytgsXMpkn0xn5uzRxTOA2LEvDpRCU06Xcn3fCvFBTbq9rXkqG5cCGUGtc593++rytsEy8QSOH6hGb4aaWMXM1RLeLwg61cqLTaRegiyOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfVw62D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98B6C3277B;
	Mon, 17 Jun 2024 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718639689;
	bh=aqvoUEjYW4RZE7fxt5CI3kgvpjBcVCSQRYCT2VNghOc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lfVw62D2a8dlFC8lFR+Bi5Jfom4TmZ4sw5QzuCUTGrEhqNAVMKyzHs+lQjARx4GcL
	 nCdxiMVNoZ+idTvpT2WeNuZE4KdtWGYsg+e0uz/Mh+88MdjsCENkZuHDTntpRhD94G
	 vukHpR4XbIFnWuq64qX46fcVWmqxkq/QVrc7w/lfhkeMyxbIxrxEkc+9ZQWsL6WhCr
	 vxN48QTrWmc5UD9WOrJ/42ZcwXWSaMxEx78dCDm3WTrYmTRMPhw5gh3xJ1cWJ6OtYc
	 mUcF6uET377n0dR3tKI4TCzVuckRgOS3frASY1wSUoB3uhzjAQ572ggtMbtEcAShcF
	 9iyoScvh8RrDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 85A18CE09F5; Mon, 17 Jun 2024 08:54:49 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:54:49 -0700
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
Message-ID: <a3560a75-57ca-4c95-a152-2edae47b306d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
 <8734py6gvq.fsf@oracle.com>
 <c6b5a5e4-e14e-4fbb-84af-75d4035ced32@paulmck-laptop>
 <20240606115325.GD8774@noisy.programming.kicks-ass.net>
 <c32af67a-a107-44d4-981d-53c6ed583d7e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32af67a-a107-44d4-981d-53c6ed583d7e@paulmck-laptop>

On Thu, Jun 06, 2024 at 06:38:57AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 06, 2024 at 01:53:25PM +0200, Peter Zijlstra wrote:
> > On Thu, May 30, 2024 at 04:20:26PM -0700, Paul E. McKenney wrote:
> > 
> > > My selfish motivation here is to avoid testing this combination unless
> > > and until someone actually has a good use for it.
> > 
> > That doesn't make sense, the whole LAZY thing is fundamentally identical
> > to FULL, except it sometimes delays the preemption a wee bit. But all
> > the preemption scenarios from FULL are possible.
> 
> As noted earlier in this thread, this is not the case for non-preemptible
> RCU, which disables preemption across its read-side critical sections.
> In addition, from a performance/throughput viewpoint, it is not just
> the possibility of preemption that matters, but also the probability.
> 
> > As such, it makes far more sense to only test FULL.
> 
> You have considerable work left to do in order to convince me of this one.

On the other hand, it does make sense to select Tiny SRCU for all !SMP
kernels, whether preemptible or not.  And it also makes sense to test
(but not *only* test and definitely *not* support) non-preemptible
RCU running in a preemptible kernel, perhaps as a one-off, perhaps
longer term.  The point being of course that the increased preemption
rate of a fully preemptible kernel should uncover bugs that might appear
in lazy-preemptible kernels only very rarely.

This might have been what you were getting at, and if so, apologies!
But in my defense, you did say "only test FULL" above.  ;-)

							Thanx, Paul

