Return-Path: <linux-kernel+bounces-553204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1AA5858A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183183ACDF5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288201DEFCD;
	Sun,  9 Mar 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCqvFoxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA31B4153
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535932; cv=none; b=oKPAk1n6cSZAMKWK3yxDpx+1YZna2JUytvP3NHlEJWlDryGBGH7r1tPv08eSCBqVHvMDN0SIwTrFJ2hMOQUy0FpawxY5gGUgaemQ013BvgDoiea5EzgRzYD01in2xd5iwuWBXRPDMFFSi9pkhN+pNa2hX/CkTEEydH1jiFWfz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535932; c=relaxed/simple;
	bh=ulucObZQF2sH/Yld8B8jJlZ5Fordo5aQl0cNiwrrzGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg4pmVheB5vr6g6KgkjJl9eQLZfOKkREFJ/3alvQRXwW4wKlqgvrM0WKjeasAas38c6S9p5ZPms8oj2yLkzNg0XGtjQjDWvG1YAV7T5HsrmEt6XqYRcl5W5FngSLMLOOFG7M03sK/hVPGCDGIpklkfEt7lbYYZvujndnYwur9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCqvFoxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E812DC4CEE3;
	Sun,  9 Mar 2025 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741535932;
	bh=ulucObZQF2sH/Yld8B8jJlZ5Fordo5aQl0cNiwrrzGQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YCqvFoxFxxtDzv7aI2hDEXAbVjdZyhWWcYPtHAceD69vhY4OG0BQgUUB/Bws2NMEp
	 VPqDppuUuvNiEExq6jg7WaahnpCF/N4MY5rN5D6Q5kpQsRWv5fBAZse0NckUsCtGsl
	 8atXFnqnX+wmuXw/fKH1hkcIE3d4I6i1Qe+IsQrcHPUwt8iFjOatvnUONZZOVfExEn
	 S9082m+S/FeiJVj3cmT1bTxaXjdtCYswyQDtjRkUfTy7nrZiVv3VRUNXv3WQtd4mFq
	 eLMaBbPn6scrSqTCSTD9wZ5iR5uyG2d6hJ842Iq1wbbU3g4mP0vBluZS0KGQRip1ns
	 1t0HJjKOBnP/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80A55CE0C56; Sun,  9 Mar 2025 08:58:51 -0700 (PDT)
Date: Sun, 9 Mar 2025 08:58:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	jstultz@google.com, sboyd@kernel.org, christian@heusel.eu,
	kernel-team@meta.com, Peter Zijlstra <peterz@infradead.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] clocksource: Defer marking clocksources unstable to
 kthread
Message-ID: <d75a8fa5-2b35-4d81-b2d2-ee95a11ce915@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11d36fdd-55c2-4f3b-96b1-dd442f759ba0@paulmck-laptop>
 <87plir32as.ffs@tglx>
 <CALOAHbDhKzaj93PcQReEGk-omw7s5xXVj_X=+by1r6c0G4aV3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDhKzaj93PcQReEGk-omw7s5xXVj_X=+by1r6c0G4aV3A@mail.gmail.com>

On Sun, Mar 09, 2025 at 07:36:05PM +0800, Yafang Shao wrote:
> On Sun, Mar 9, 2025 at 12:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, Mar 06 2025 at 08:06, Paul E. McKenney wrote:
> > > The clocksource watchdog marks clocksources unstable from within a timer
> > > handler.  On x86, this marking involves an on_each_cpu_cond_mask(),
> > > which in turn invokes smp_call_function_many_cond(), which may not be
> > > invoked from a timer handler.  Doing so results in:
> > >
> > > WARNING: CPU: 3 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+0x46b/0x4c0
> > >
> > > Fix this by deferring the marking to the clocksource watchdog kthread.
> > > Note that marking unstable is already deferred, so deferring it a bit
> > > more should be just fine.
> >
> > While this can be done, that's papering over the underlying problem,
> > which was introduced with:
> >
> >   8722903cbb8f ("sched: Define sched_clock_irqtime as static key")
> >
> > That added the static key switch, which is causing the problem. And
> > "fixing" this in the clocksource watchdog is incomplete because the same
> > problem exists during CPU hotplug when the TSC synchronization declares
> > the TSC unstable. It's the exactly same problem as was fixed via:
> >
> >  6577e42a3e16 ("sched/clock: Fix up clear_sched_clock_stable()")
> >
> > So as this got introduced in the 6.14 merge window, the proper fix is to
> > revert commit 8722903cbb8f and send it back to the drawing board. It was
> > clearly never tested with the various possibilities which invoke
> > mark_tsc*_unstable().
> 
> Hello Thomas,
> 
> It has been reverted by the following commit
> b9f2b29b9494 ("sched: Don't define sched_clock_irqtime as static key")
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=b9f2b29b94943b08157e3dfc970baabc7944dbc3

Thank you!  I will drop my commit on my next rebase.

							Thanx, Paul

