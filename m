Return-Path: <linux-kernel+bounces-204384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174CA8FE806
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C210B24832
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA408196428;
	Thu,  6 Jun 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1swoBkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F969195F10
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681138; cv=none; b=CP2HAdEkQuBN7xQN9qsUA2bddmHEEmgr0pJx+yWxuFk0oIh1M0BIBZVhkOU0+B7heyr1BpjSCkxS3a6M0fIocvMEuWjinRa31SPUGRpjiyCf5bDxAYR22stUZ2NOcQOM19ID8BXKMHFmRY9SROVBHsVID/1uYYXn0eiNqGO2kmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681138; c=relaxed/simple;
	bh=OfYPy15oCpZ5u0l2eprzf6tcT5+des7BOL1pBwVACTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQmOqWTy8n10pd/iHpq3/BeF8u1yvyrlLYAf/cXkLNTASjGG1EPLaBt+vSGdRuaAp3DQH2fGTcqk+XfnMG4Meoqut+A9vytwSfsMyjHENMwamTgRH0zBt6H3OlA8hoa0yTbAPk5ggS5nl5oavx0IkeCQt1dsTUW4RFipulxx9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1swoBkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F2DC2BD10;
	Thu,  6 Jun 2024 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717681137;
	bh=OfYPy15oCpZ5u0l2eprzf6tcT5+des7BOL1pBwVACTY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=b1swoBkNY+DRnc4G1ENj/4D1TH40f/ecFxp5gNbRKzB2jPyJNJgLPQT2HgJTKzGaC
	 PDHzzrTFv9EtJejMI1WIBeNu7nSC5XqQwubuG4MK9eQy0L8/6jjzC8vG8MTdvYIu5P
	 X9g4n/SQBQTND4v/3WNQmR0oiLrWZUVrEItgwEWOS6iw+02NN2vwZKgQ1dM4sR/WMs
	 eH8zSI/hDvjs4KnjoVCvyd0Yk6FfpHPTVvGBRKYB+7j129N024gxPYeJ+KZAxJXirG
	 pVamZZ1WmTpqBycSm/McaTWbMtARTQpxoPvyfJveWWV6puBgTLofPFP8NOLdrtyopg
	 DO7zk+YqKYJFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46585CE15DD; Thu,  6 Jun 2024 06:38:57 -0700 (PDT)
Date: Thu, 6 Jun 2024 06:38:57 -0700
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
Message-ID: <c32af67a-a107-44d4-981d-53c6ed583d7e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
 <8734py6gvq.fsf@oracle.com>
 <c6b5a5e4-e14e-4fbb-84af-75d4035ced32@paulmck-laptop>
 <20240606115325.GD8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606115325.GD8774@noisy.programming.kicks-ass.net>

On Thu, Jun 06, 2024 at 01:53:25PM +0200, Peter Zijlstra wrote:
> On Thu, May 30, 2024 at 04:20:26PM -0700, Paul E. McKenney wrote:
> 
> > My selfish motivation here is to avoid testing this combination unless
> > and until someone actually has a good use for it.
> 
> That doesn't make sense, the whole LAZY thing is fundamentally identical
> to FULL, except it sometimes delays the preemption a wee bit. But all
> the preemption scenarios from FULL are possible.

As noted earlier in this thread, this is not the case for non-preemptible
RCU, which disables preemption across its read-side critical sections.
In addition, from a performance/throughput viewpoint, it is not just
the possibility of preemption that matters, but also the probability.

> As such, it makes far more sense to only test FULL.

You have considerable work left to do in order to convince me of this one.

							Thanx, Paul

