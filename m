Return-Path: <linux-kernel+bounces-296243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B227A95A80F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534031F232EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117417C230;
	Wed, 21 Aug 2024 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMlgJcY3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F91494AD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281700; cv=none; b=rV8Xg979kEmhNarMj/Sms/wPBxgFdTHlUeMcN5c8lBhzGQSU3LUZe1d28L3mriebCZs4CiOpMdc78wsr3r626eDGXtFcqR6BNXbI2PwzGjaG/priqn7nhYqqP13lmIZ21yq2TXwZLGgC9DeOMsLakoH1gsdVK1sDJT4Z/xk7k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281700; c=relaxed/simple;
	bh=AgqgAdjB403q9kHL1IbkP1Vw7tIpC5lcxs9Gbhb4S2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaUcO1TY3naEridec1sHX0kN+eS43dphoOkiGSZnWRZ20y4v7gj6DLoeqYUc4AwgIu9ZS/nDYx4FPBOINyhPliVT7CiHZq3b7+5tA7aRD5XphXtzxSvcWiIZgUcJ2FlJ+AQA8vzu1eYvxjIx8zEP/88afDToh8+DiruRPTjivUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMlgJcY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28508C32781;
	Wed, 21 Aug 2024 23:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724281700;
	bh=AgqgAdjB403q9kHL1IbkP1Vw7tIpC5lcxs9Gbhb4S2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMlgJcY3SpoS0v9p+CbHlBgtWJYDrqeRBv4OVtTpGaZXM5rPLDfzKZ/wpFaJ9Pvyc
	 Pl60a4KkjoYiWQ+nsunG6X4V1tAmm7JZRNZtartlPpHguGCyY5GhKS24jlpWf0Hp+6
	 q11wOsI79wSaA4BsdHYirdcwm7SvFF4smdB/c9y9LkI0UDg82YdPYO6/lN4qL6EfPX
	 Gx6NvrZBMcAK4TN86WfmiUOBFYcdpTdWxNfbkBwbQaxmdUrzhK1sZdJvyOgjlmgdYq
	 XfmPiM2zttHDynGuBtU+5W6g6IK+QS+0bUp9PuEEJpnsIkbV0RKpjyAmxEGPT//3b0
	 7xahAc3IFkIQQ==
Date: Wed, 21 Aug 2024 13:08:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <ZsZzY0v8xxtzV7_L@slm.duckdns.org>
References: <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
 <20240806211002.GA37996@noisy.programming.kicks-ass.net>
 <ZrKW2wZTT3myBI0d@slm.duckdns.org>
 <20240806215535.GA36996@noisy.programming.kicks-ass.net>
 <ZrKfK1BCOARiWRr0@slm.duckdns.org>
 <20240810204542.GA11646@noisy.programming.kicks-ass.net>
 <Zruwioj86jQz8Oq6@slm.duckdns.org>
 <20240813225307.GC10328@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813225307.GC10328@noisy.programming.kicks-ass.net>

Hello,

On Wed, Aug 14, 2024 at 12:53:07AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 13, 2024 at 09:14:18AM -1000, Tejun Heo wrote:
> > Hello, Peter.
> > 
> > On Sat, Aug 10, 2024 at 10:45:42PM +0200, Peter Zijlstra wrote:
> > ...
> > > > It is tricky because the kernel part can't make assumptions about whether
> > > > two tasks are even on the same timeline. In the usual scheduling path, this
> > > > isn't a problem as the decision is made by the BPF scheduler from balance()
> > > > - if it wants to keep running the current task, it doesn't dispatch a new
> > > > one. Otherwise, it dispatches the next task.
> > > 
> > > But I have a question.. don't you clear scx.slice when a task needs to
> > > be preempted? That is, why isn't that condition sufficient to determine
> > > if curr has precedence over the first queued? If curr and it is still
> > > queued and its slice is non-zero, take curr.
> > 
> > scx.slice is used a bit different from other sched classes mostly because
> > there are two layers - the SCX core and the BPF scheduler itself. The BPF
> > scheduler uses scx.slice to tell the SCX core to "don't bother asking about
> > it until the current slice has been exhausted" - ie. it's a way to offload
> > things like tick handling and preemption by higher priority sched classes to
> > SCX core. When scx.slice expires, the BPF scheduler's dispatch() is called
> > which can then decide whether to replenish the slice of the current task or
> > something else should run and so on.
> 
> Right, but can't we flip that on its head and state that when scx.slice
> is non-zero, we should pick current and not bother asking for what's
> next?

I ended up resolving this differently. The existing code distinguishes the
regular and core-sched paths because the current task gets enqueued when
balance_scx() decides to keep running it. With the pending put_prev_task
update, it becomes a lot more straightforward to not queue current when
deciding to keep running it, which makes regular and core-sched paths
identical.

Thanks.

-- 
tejun

