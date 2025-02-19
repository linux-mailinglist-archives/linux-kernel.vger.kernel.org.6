Return-Path: <linux-kernel+bounces-522011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA9A3C4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310613AA831
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191A21FDE10;
	Wed, 19 Feb 2025 16:22:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FA1F4620
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982166; cv=none; b=vFMNcX8GdgKXEKV9O8oqrGl5dn9XpEspOaG7GG5gycrBZhHK/ciyfenF5bvgnRRUzc7/tiXG3509X3i/iCDFxLjtbXS9637U6c8xgEV2ZUjfwdrJfk6CvocPuCs0ku5sTEnpT0Kkq4TTOSq0vd7qh60JY5OgscoiBRBpF8u04DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982166; c=relaxed/simple;
	bh=PSh/3fF365VRVdIYlepfiPt+5JXUEbpp9W7V2QjmLWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn+bo05hI32qiQgMTK04pK74PYaFHkl9i4gFMffytTyRkzvJRDGmoAGdFzZnhjnSOrvgZwdli7B0GuFfSLAnwmskmQvamnWdj44h/h8S0SXkTFVU+XBUjG12UXe9jqhUoZZX1oJbUxdknsWiAMY3xZ5//ZKxNR/uUKwu26RmlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB84AC4CED1;
	Wed, 19 Feb 2025 16:22:44 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:23:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>, Lance Yang
 <ioworker0@gmail.com>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250219112308.5d905680@gandalf.local.home>
In-Reply-To: <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 22:00:49 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The "hung_task" shows a long-time uninterruptible slept task, but most
> often, it's blocked on a mutex acquired by another task. Without
> dumping such a task, investigating the root cause of the hung task
> problem is very difficult.
> 
> Fortunately CONFIG_DEBUG_MUTEXES=y allows us to identify the mutex
> blocking the task. And the mutex has "owner" information, which can
> be used to find the owner task and dump it with hung tasks.
> 
> With this change, the hung task shows blocker task's info like below;
> 

We've hit bugs like this in the field a few times, and it was very
difficult to debug. Something like this would have made our lives much
easier!

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/hung_task.c           |   38 ++++++++++++++++++++++++++++++++++++++
>  kernel/locking/mutex-debug.c |    1 +
>  kernel/locking/mutex.c       |    9 +++++++++
>  kernel/locking/mutex.h       |    6 ++++++
>  4 files changed, 54 insertions(+)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 04efa7a6e69b..d1ce69504090 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -25,6 +25,8 @@
>  
>  #include <trace/events/sched.h>
>  
> +#include "locking/mutex.h"
> +
>  /*
>   * The number of tasks checked:
>   */
> @@ -93,6 +95,41 @@ static struct notifier_block panic_block = {
>  	.notifier_call = hung_task_panic,
>  };
>  
> +
> +#ifdef CONFIG_DEBUG_MUTEXES
> +static void debug_show_blocker(struct task_struct *task)
> +{
> +	struct task_struct *g, *t;
> +	unsigned long owner;
> +	struct mutex *lock;
> +
> +	if (!task->blocked_on)
> +		return;
> +
> +	lock = task->blocked_on->mutex;

This is a catch 22. To look at the task's blocked_on, we need the
lock->wait_lock held, otherwise this could be an issue. But to get that
lock, we need to look at the task's blocked_on field! As this can race.

Another thing is that the waiter is on the task's stack. Perhaps we need to
move this into sched/core.c and be able to lock the task's rq. Because even
something like:

	waiter = READ_ONCE(task->blocked_on);

May be garbage if the task were to suddenly wake up and run.

Now if we were able to lock the task's rq, which would prevent it from
being woken up, then the blocked_on field would not be at risk of being
corrupted.

-- Steve


> +	if (unlikely(!lock)) {
> +		pr_err("INFO: task %s:%d is blocked on a mutex, but the mutex is not found.\n",
> +			task->comm, task->pid);
> +		return;
> +	}
> +	owner = debug_mutex_get_owner(lock);
> +	if (likely(owner)) {
> +		/* Ensure the owner information is correct. */
> +		for_each_process_thread(g, t)
> +			if ((unsigned long)t == owner) {
> +				pr_err("INFO: task %s:%d is blocked on a mutex owned by task %s:%d.\n",
> +					task->comm, task->pid, t->comm, t->pid);
> +				sched_show_task(t);
> +				return;
> +			}
> +	}
> +	pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
> +		task->comm, task->pid);
> +}
> +#else
> +#define debug_show_blocker(t)	do {} while (0)
> +#endif

