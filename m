Return-Path: <linux-kernel+bounces-359290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204AE9989CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B50F1C24743
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F81CBEA3;
	Thu, 10 Oct 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHx+bVeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2B1CB50C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570548; cv=none; b=k6qBI++9xycGaYwJbbP1JszTB1+5NyMWA4NYC0cRKzV3AMRLanLbVx77JNc0EKn6ygbbw+odtzPeNqLgfbscd5VYVD3uqvXykJVv/fsXuq/y5d2x/udqJNgjYgvw5q9BgfrOFU9YU6Anye08n4LDy6oOoOLImaf1SO9jX7TDkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570548; c=relaxed/simple;
	bh=msclSngbL0x7WjdyXEOO4YFNUCBUPc1lsaZwzXyP23c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWRJz6z7lQsBBC1fWjcCOUvU5rx11KR+9CjZPAq+hF64BNLpTvZ+C4/j3+bf2EVPKZmZ1mBp/jP5CT4eM8eSFs5JDcDOcJTQSaGgrN2jRYdo7CxwEQQIo2Moi2PBXG6+BOtBFPRQcuOGHywGhoa70J4VQKVoCNwupKqZKL+HLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHx+bVeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5CAC4CEC5;
	Thu, 10 Oct 2024 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728570548;
	bh=msclSngbL0x7WjdyXEOO4YFNUCBUPc1lsaZwzXyP23c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sHx+bVeCXsjod3F5GQOSyPtc9kZVonUZ1CDVs4m4mjacaFTAq8l5/TGN3wmMFULWf
	 FOf4e4ZvaRVTZSDyr63sifFyMN5jHHmepZ1VQzug/c/J+aD4d5rwF3ZA8O4wtHa4Jw
	 zhul5WTnzequFpJ2wdxhJo+gwoYXdbf48ck5ds9eJ3MIr/XIqr/DP4nm7Xoj866gpA
	 VW/9BQjuXV7C0cOKzysL1yY0nyMjCsrFYMRqcVtLeIqqtbeTYb3cJZA+m63UKSrgBL
	 jB61lRXWXIweYXkDOLQVrCdrVoqQIc2X9veOCHOJmJrYnkKRm1HSQDaNoqbOvZnNQ1
	 3s9XDkwnZqPpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A523FCE08E5; Thu, 10 Oct 2024 07:29:07 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:29:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
 <20241010100308.GE17263@noisy.programming.kicks-ass.net>
 <20241010102657.H7HpIbVp@linutronix.de>
 <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010104438.GJ14587@noisy.programming.kicks-ass.net>

On Thu, Oct 10, 2024 at 12:44:38PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 12:26:57PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-10-10 12:03:08 [+0200], Peter Zijlstra wrote:
> > > > 
> > > > I can't deselect CONFIG_PREEMPT_RCU=y. This is because LAZY selects
> > > > PREEMPT_BUILD and PREEMPT_RCU selects itself once PREEMPTION is on.

That is not good!

> > > Oh, the entry isn't user selectable? Fix that perhaps?
> > > 
> > > -	bool
> > > +	bool "Use preemptible RCU"
> > > 
> > > Or something along those lines -- I forever forget how Kconfig works.
> > 
> > Oh. Well, yes. If we do this then it becomes suddenly selectable and
> > half of the series makes sense…
> > But as you said, this complicates things. 
> 
> But then you leave it up to the user, instead of doing something quite
> random. This would allow you to configure PREEMPT_RCU=n despite also
> using PREEMPT_DYNAMIC if that is your thing.

Ahem.  How many users keep track of all of the Kconfig options?  I doubt
that this number is greater than zero.  Part of the goal here needs to
be to minimize the Kconfig futzing users must do.  The default settings
really do matter.

> I fundamentally hate the whole randomness of the earlier proposed
> selection criteria. It only disables PREEMPT_RCU if you use LAZY and not
> also have PREEMPT_RT or PREEMPT_DYNAMIC.

Not at all random.

If you have PREEMPT_RT, you need preemptible RCU, so the defaults should
supply it.

If you have PREEMPT_DYNAMIC, presumably you would like to boot with
preemption enabled, and would like it to act as if you had built the
kernel to be unconditionally preemptible, so again you need preemptible
RCU, and so the defaults should supply it.

If you started off building a non-preemptible kernel, then you are not
using one of the major distros (last I checked).  There is a good chance
that you have a large number of systems, and are thus deeply interested
in minimizing memory cost.  In which case, you need non-preemptible
RCU in the new-age lazy-preemptible kernel.

Hence the choice of non-preemptible RCU as the default in a kernel that,
without lazy preemption, would use non-preemptible RCU.

							Thanx, Paul

