Return-Path: <linux-kernel+bounces-357884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28EC997755
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA21F2330E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CAF1DFE2B;
	Wed,  9 Oct 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKEP63dP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B82119
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508604; cv=none; b=SLe5fQ4JKU0ZRd4q+hHXWJKyxOHWlkgMiPGtSJrwPxKXAlfNRji26AY2AQjG/6pYGS5KeoDREU8PoRz9aNRyWu5ZDYSpAPkm67Z+30GzZfR4SsYnUxUsxtrX1EOCYoqsDFOSu4qLfeqOBYhpXb6biaVBe71Ad9Jze2KFYrp5p5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508604; c=relaxed/simple;
	bh=7G+T1tfPJ0HruFMvHxklqYC1ScQTpI3Nxa5ICttD+bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw3k63R6ZyBHpong56qWvyz3D+dCCgavmf5JvnpqFEqEzJlf7EDTW/K/6mqBYs0cCtGktmhe4NZYL5K+UBRCLZz2UBXM6Ao032hpMW4NuOgERArK93/1OCRmg4RY1EGc7zXr2+yiOkCuLoj/sh1guCLJTAUUi16giReyR1Z7wCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKEP63dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B75C4CEC3;
	Wed,  9 Oct 2024 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728508604;
	bh=7G+T1tfPJ0HruFMvHxklqYC1ScQTpI3Nxa5ICttD+bU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KKEP63dPyR5Ll7b9AeeQ2+55nGcF0j8pXxUWG+cjiPWgpeyJcggWTC6pCRAGirsf6
	 AaONGBzFZVO+u8I/KDfxgZEbF1dkkFs+ZivIsGXGZiKcRqyOWZY/Dp9aQ7jZhVeNRL
	 S7q5tlsYnpUeLiKK98+ewKrMVHZK/QquIxIumRF0xkHgLVXWVMvOI+wEIhETdPIfPa
	 vN+kVcFYV2tagoaBBurKcfUN2PAe0SEr/UqJimNe7m5vZaYk765S/Lc9E9Nm8twlD8
	 Av4lK5fbNrVSuqnNYuIxDPgDsMozjt7Qm4i/GuWWZJMf3sG3nEslkl/oVCLWPalV3X
	 aH+jUmtqhlRXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 004D2CE090D; Wed,  9 Oct 2024 14:16:43 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:16:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <28bcac6a-6aee-456a-8022-5eef9ec08eaa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241009205218.GW17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009205218.GW17263@noisy.programming.kicks-ass.net>

On Wed, Oct 09, 2024 at 10:52:18PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2024 at 11:24:09AM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 09, 2024 at 08:01:17PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 09, 2024 at 09:54:06AM -0700, Ankur Arora wrote:
> > > > PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
> > > > which allows for dynamic switching of preemption models.
> > > > 
> > > > The choice of preemptible RCU or not, however, is fixed at compile
> > > > time. Given the trade-offs made to have a preemptible RCU, some
> > > > configurations which have limited preemption might prefer the
> > > > stronger forward-progress guarantees of PREEMPT_RCU=n.
> > > > 
> > > > Accordingly, explicitly limit PREEMPT_RCU=y to PREEMPT_DYNAMIC,
> > > > PREEMPT, PREEMPT_RT.
> > > > 
> > > > This means that (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), which selects
> > > > PREEMPTION will run with PREEMPT_RCU=n. The combination (PREEMPT_LAZY=y,
> > > > PREEMPT_DYNAMIC=y), will run with PREEMPT_RCU=y.
> > > 
> > > I am completely confused by this. Why do we want this?
> > 
> > In order to support systems that currently run CONFIG_PREEMPT=n that
> > are adequately but not overly endowed with memory.  If we allow all
> > RCU readers to be preempted, we increase grace-period latency, and also
> > increase OOM incidence.  Which we would like to avoid.
> > 
> > But we do want lazy preemption otherwise, for but one thing to reduce
> > tail latencies and to reduce the need for preemption points.  Thus, we
> > want a way to allow lazy preemption in general, but to continue with
> > non-preemptible RCU read-side critical sections.
> > 
> > Or am I once again missing your point?
> 
> Even without this patch this is allowed, right? It's just a default
> that's changed. If people want to run PREEMPT_RCU=n, they can select it.
> 
> I just don't see a point in making this change.

Because we don't need a bunch of people surprised by this change in
behavior.

							Thanx, Paul

