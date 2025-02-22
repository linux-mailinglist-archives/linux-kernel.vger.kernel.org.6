Return-Path: <linux-kernel+bounces-526860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC3A40485
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5395423F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BC4158868;
	Sat, 22 Feb 2025 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILfhrlLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3F15854A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186442; cv=none; b=l2AOUeb2vkOS2tmxoOc6JKlgxwU70PWtZCz+rWmXcQZvueL975JbjvZvHrloVz/05pKKJ7yuWQPrB0Sb3qnTyuxZvTA4u+q9o+6wnaanvn9NUVDfmwUOAWWvvA0VMDguZInnj10/9Lw1bsDIw1l1s991UQz185XV812EjJ3tdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186442; c=relaxed/simple;
	bh=4gE1676LhnF/YSQbPLtKiMaeqgI2oV2+K5nL9bFnICo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lpLIEMOjvDMpW5C559mUn03eTRG7/ip3dWALSgHnDG24YcfuZ9+0fYwrLyCsIiS7Tx65q8xAu4r8QYD9AR7nxz5XyeijBRx4LHrlwRW7WkG4RwiCHnsolYlJx8ZDubDiWcdaI1vSA5Lis7J4UajTXrc3/gNyHtuMKWRMxNrB5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILfhrlLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31831C4CED6;
	Sat, 22 Feb 2025 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740186442;
	bh=4gE1676LhnF/YSQbPLtKiMaeqgI2oV2+K5nL9bFnICo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILfhrlLndQmAH7bIF77ASvz1uItUzkYmQd7xzlwGDPONO/Fw3RaBEU7S0ACMpZCJG
	 TQ5w5uFbe5emdbeTxaJxqR2Swe37k1ZecsjFPqZipiW8Ar5eIPYHhs1u6stEw+h3WN
	 etnXItU7C01cVp0EaMeTgINABheMlGSeAZYdv5Q3SZIeG3Yed38zY9K2v3gjTZLP/u
	 9jTajl36+5gyjX4ZDk+WjLnft3uWJ1jry14LpLQ6kxRJgpXeI9FmZpnf+Vo3mGWVOO
	 LPUxbLj0mhZQhuJUWElXet78DNMLPH9HGhpRTy/8tNx2edShs2T/fmi+jOjqgl2bwt
	 AsmMdAvOrIQUg==
Date: Sat, 22 Feb 2025 10:07:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados
 <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>,
 Lance Yang <ioworker0@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, Steven
 Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250222100716.23c55ef04d48d313211bef21@kernel.org>
In-Reply-To: <63fc7bff-168e-478b-a3fc-4897f2ee9d69@redhat.com>
References: <174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com>
	<174014820133.967666.5855819828684207404.stgit@mhiramat.tok.corp.google.com>
	<20250221185939.GB7373@noisy.programming.kicks-ass.net>
	<63fc7bff-168e-478b-a3fc-4897f2ee9d69@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 15:29:57 -0500
Waiman Long <llong@redhat.com> wrote:

> 
> On 2/21/25 1:59 PM, Peter Zijlstra wrote:
> > On Fri, Feb 21, 2025 at 11:30:01PM +0900, Masami Hiramatsu (Google) wrote:
> >> +static void debug_show_blocker(struct task_struct *task)
> >> +{
> >> +	struct task_struct *g, *t;
> >> +	unsigned long owner;
> >> +	struct mutex *lock;
> >> +
> >> +	lock = READ_ONCE(task->blocker_mutex);
> >> +	if (!lock)
> >> +		return;
> >> +
> >> +	owner = mutex_get_owner(lock);
> >> +	if (likely(owner)) {
> >> +		/* Ensure the owner information is correct. */
> >> +		for_each_process_thread(g, t)
> >> +			if ((unsigned long)t == owner) {
> >> +				pr_err("INFO: task %s:%d is blocked on a mutex owned by task %s:%d.\n",
> >> +					task->comm, task->pid, t->comm, t->pid);
> >> +				sched_show_task(t);
> >> +				return;
> >> +			}
> >   - that for_each_process_thread() scope needs { }

OK, let me add it.

> >
> >   - that for_each_process_thread() loop needs RCU or tasklist_lock
> 
> The call chain should be
> 
> check_hung_uninterruptible_tasks()
>    -> check_hung_task()
>      -> debug_show_blocker()
> 
> check_hung_uninterruptible_tasks() takes rcu_read_lock() before calling 
> check_hung_task(). Perhaps add a statement like
> 
>      RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");

Agreed. It needs to add  assertion.

> 
> >
> >   - there is no saying that the owner you read with mutex_get_owner() is
> >     still the owner by the time you do the compare, there can have been
> >     owner changes.
> 
> Maybe change "owned by" to "likely owned by" :-)

Indeed :-)

Thank you!

> 
> Cheers,
> Longman
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

