Return-Path: <linux-kernel+bounces-181252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AF88C798F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1818285C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A842814D431;
	Thu, 16 May 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1TaLr3k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4FC14D2A8
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873580; cv=none; b=BJL7/D3CPZy4wbe0llXRm7Nd6f2GlI1A4SwiE8D2f4BB+B03dv6SjCpgpegv5Yv6IsOpXPyPLKt6LAEqBoLBm5xqqcR2B8vk5cKHvBNtZRvx5TOdxqEojUgIryKJZAkmwOcRS8Yv0YT2lsv0eir3+gXdb9HvRSYwJL+wFPGCaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873580; c=relaxed/simple;
	bh=srVdnYXyT4tc0ys+RBcE/24kZDqVhwuTNm17oGZxacE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcaIAA8w3nLSlTzjAqNmp+jl7iY1/TgkSGwoZY2JmkVpdE2/d34yf4PWafZt8CyuOwTicYcW981lyYWaCzakdSwaPpH4uhqeN8psJG8AGUAV1FCPbRjCP6tf+MhSP6LbrLg3IjILU/x2EwCBUEBHTeRUtF9Y/aQxKE/+klS+d34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1TaLr3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E01C113CC;
	Thu, 16 May 2024 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715873579;
	bh=srVdnYXyT4tc0ys+RBcE/24kZDqVhwuTNm17oGZxacE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1TaLr3k80zEv75xK/NkWx1OBTq58CmAqVlpgACvQf1BuVh47walBQpUebuieTNQx
	 e4lJ13bmuWS+IPJVmH8D4CBrk51PjU8gLvHt2BYmDGcox7j9Y6tOEoO6nGSmpoE+oM
	 IlPh0FHcwhfpOTwWUmUXbeByVEuUSRHxPa1U9Xejud9/nUd3MaClJekcYB32CyTcQt
	 /lw0O5WLiS46y+wGtnJUgh1SB5yJRt/Yir5GdLod/BrjyN3iVWwx72iTU4YcB0DnHp
	 uYNt5x0YMa8PSN2Gqp+guf2usZFdVqxt7wtR3+908mFEEIE8b8p3yoSP5NvEeakybY
	 uzfwb9L+kDKLg==
Date: Thu, 16 May 2024 17:32:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yun Levi <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <ZkYnKAd1Qy+yvjDY@lothringen>
References: <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
 <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
 <ZkYW48dTX2FH5NaD@lothringen>
 <20240516144504.GL22557@noisy.programming.kicks-ass.net>
 <ZkYgG9KYMpUPeJsM@lothringen>
 <20240516151953.GM22557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516151953.GM22557@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 05:19:53PM +0200, Peter Zijlstra wrote:
> On Thu, May 16, 2024 at 05:02:51PM +0200, Frederic Weisbecker wrote:
> 
> > > I'm confused, none of that makes sense. If you're part of a
> > > load-balancer, you're part of a load-balancer, no ifs buts or other
> > > nonsense.
> > > 
> > > idle load balancer is no different from regular load balancing.
> > > 
> > > Fundamentally, you can't disable the tick if you're part of a
> > > load-balance group, the load-balancer needs the tick.
> > > 
> > > The only possible way to use nohz_full is to not be part of a
> > > load-balancer, and the only way that is so is by having (lots of) single
> > > CPU partitions.
> > 
> > So you're suggesting that nohz_full should just be part of the whole
> > ilb machinery by default (that is, not fiddle with ilb internals) and
> > then it's up to CPU partitioning (through cpuset or isolcpus) to disable
> > ilb naturally. Right?
> 
> Yes, but stronger, as long as the CPU is part of a load-balance domain,
> it must not disable the tick while running anything.
> 
> that is, NOHZ_FULL must not become active unless it's running on a
> single CPU partition.

I like the idea but I'm afraid to introduce regressions while doing so,
with people currently using nohz_full without proper partionning...

