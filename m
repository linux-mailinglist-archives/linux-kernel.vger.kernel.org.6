Return-Path: <linux-kernel+bounces-555461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F76A5B7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501EE3ADCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476F1E9B20;
	Tue, 11 Mar 2025 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgZtG/Ir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FA211C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741666802; cv=none; b=CVP7QjyTLxOMJn7GDFndHMTAP5CPGTruC1zkZ+dk7sHCYkiC5Cwq78bYGioek3qEwlwZx+KMC5v2JBvPCPJThe5os+3FumHPfRWkIC7yrjaz8peZIeiJjatauP0UFbTC6E+tRcc8K6sILdv++hoW0qp5eAyL5VQva2DOpeQtJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741666802; c=relaxed/simple;
	bh=i28TS0T531Y6SmhgzpC5J9RNLZnBYyT6J7kifv4kBpI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jvknudCOA+2Ouq19GcQaNfVUY2bPMv9EJ9Y+KeSN8ctCiYR140fBVSzd9UxsHWLUjqqyMo6a9E6bgrH3ijcI2gBrZoQg3AA3RwsR1KLbD7D6LzQuWUqQpkrBvi8L4pGvtJ7uVfGoz+TmiPKhxJZiVYTPwuF2eiq09qjlLGnQs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgZtG/Ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997FAC4CEE9;
	Tue, 11 Mar 2025 04:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741666801;
	bh=i28TS0T531Y6SmhgzpC5J9RNLZnBYyT6J7kifv4kBpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fgZtG/IrirN1GD8BCEFDFKlkgFneBME5dpY9WCEcDvhgp7xY7iie41eKuGU1GzySV
	 jNgEXjJZGPi1MhO99SFpT4sEdd3xfLw3HkdAcJ2zAElml8Mwycc27BAhq5Uh3RpfSu
	 WUTcg8LjXD0MVPoxM1Md7sUMxjqiI8DSsUkZvJQRt4adld7kZxZYmyFicZd+KKQgzQ
	 ro7gL3nhLpuwtKq99kMc0EmnF6SrL3g1rXhLKTlY/jX0X4JPgXN7UG+mvyADa4/PyU
	 IGKfvp5uUIXGfcNrlN05nOvC115YQ+O6mpdT9tKSbRR7V9OauCxYypb3XmGTTS4Le0
	 UHcGPYuUgIGbA==
Date: Tue, 11 Mar 2025 13:19:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, anna.schumaker@oracle.com,
 boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev,
 leonylgao@tencent.com, linux-kernel@vger.kernel.org, longman@redhat.com,
 mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, tfiga@chromium.org,
 will@kernel.org
Subject: Re: [PATCH 1/1] hung_task: show the blocker task if the task is
 hung on semaphore
Message-Id: <20250311131958.9cc1318bc62ac46d177e024c@kernel.org>
In-Reply-To: <20250306060542.56435-1-ioworker0@gmail.com>
References: <20250303152907.d61151bbdaf0b8a6a8f9978f@kernel.org>
	<20250306060542.56435-1-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 14:05:42 +0800
Lance Yang <ioworker0@gmail.com> wrote:

> Hi Masami,
> 
> Could you give me a quick feedback before sending out the v2?
> 
> It seems unnecessary to make 'blocker' a union. I replaced 'struct mutex
> *blocker_mutex' with 'unsigned long blocker', as only one blocker is active
> at a time, IIUC ;)
> 
> The blocker filed can store both the lock addrees and the lock type, with
> LSB used to encode the type as you suggested, making it easier to extend
> the feature to cover other types of locks.
> 
> Also, once the lock type is determined, we can directly extract the address
> and cast it to a lock pointer ;)

Hi Lance,

Sorry I missed to reply.

> 
> ---
>  include/linux/hung_task.h | 82 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sched.h     |  2 +-
>  kernel/hung_task.c        | 15 ++++---
>  kernel/locking/mutex.c    |  8 +++-
>  4 files changed, 99 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/hung_task.h
> 
> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> new file mode 100644
> index 000000000000..569d2e579f36
> --- /dev/null
> +++ b/include/linux/hung_task.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Detect Hung Task: detecting tasks stuck in D state
> + *
> + * Copyright 2025 Lance Yang <ioworker0@gmail.com>
> + */
> +#ifndef __LINUX_HUNG_TASK_H
> +#define __LINUX_HUNG_TASK_H
> +
> +#include <linux/bug.h>
> +#include <linux/sched.h>
> +#include <linux/compiler.h>
> +
> +/*
> + * @blocker: Combines lock address and blocking type.
> + *
> + * Since lock pointers are at least 4-byte aligned(32-bit) or 8-byte
> + * aligned(64-bit). This leaves the 2 least bits (LSBs) of the pointer
> + * always zero. So we can use these bits to encode the specific blocking
> + * type.
> + *
> + * Type encoding:
> + * 00 - Blocked on mutex        (BLOCKER_TYPE_MUTEX)
> + * 01 - Blocked on semaphore    (BLOCKER_TYPE_SEM)
> + * 10 - Blocked on rw-mutex     (BLOCKER_TYPE_RWMUTEX)

                      ^ RT-Mutex?

> + * 11 - Blocked on rw-semaphore (BLOCKER_TYPE_RWSEM)
> + */
> +#define BLOCKER_TYPE_MUTEX      0x00UL
> +#define BLOCKER_TYPE_SEM        0x01UL
> +#define BLOCKER_TYPE_RWMUTEX    0x02UL

Ditto.

> +#define BLOCKER_TYPE_RWSEM      0x03UL
> +
> +#define BLOCKER_TYPE_MASK       0x03UL
> +
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +static inline void hung_task_set_blocker(void *lock, unsigned long type)
> +{
> +	unsigned long lock_ptr = (unsigned long)lock;
> +
> +	WARN_ON_ONCE(!lock_ptr);
> +	WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK);

If it founds the lock_ptr & BLOCKER_TYPE_MASK is set, it should return
without writing anything. (WARN_ON_ONCE() is OK)

> +	WARN_ON_ONCE(READ_ONCE(current->blocker));
> +
> +	WRITE_ONCE(current->blocker, lock_ptr | type);
> +}
> +
> +static inline void hung_task_clear_blocker(void)
> +{
> +	WARN_ON_ONCE(!READ_ONCE(current->blocker));
> +
> +	WRITE_ONCE(current->blocker, 0UL);
> +}
> +
> +static inline bool hung_task_blocker_is_type(unsigned long blocker,
> +					  unsigned long type)
> +{
> +	WARN_ON_ONCE(!blocker);
> +
> +	return (blocker & BLOCKER_TYPE_MASK) == type;
> +}
> +
> +static inline void *hung_task_blocker_to_lock(unsigned long blocker)
> +{
> +	WARN_ON_ONCE(!blocker);
> +
> +	return (void *)(blocker & ~BLOCKER_TYPE_MASK);
> +}
> +#else
> +#define hung_task_set_blocker(lock, type)       do {} while (0)
> +#define hung_task_clear_blocker()               do {} while (0)
> +static inline bool hung_task_blocker_is_type(unsigned long blocker,
> +					     unsigned long type)
> +{
> +	return false;
> +}
> +static inline void *hung_task_blocker_to_lock(unsigned long blocker)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +#endif /* __LINUX_HUNG_TASK_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1419d94c8e87..f27060dac499 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1218,7 +1218,7 @@ struct task_struct {
>  #endif
>  
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -	struct mutex			*blocker_mutex;
> +	unsigned long			blocker;
>  #endif
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index ccd7217fcec1..f7fa832261c8 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -25,6 +25,10 @@
>  
>  #include <trace/events/sched.h>
>  
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +#include <linux/hung_task.h>
> +#endif
> +
>  /*
>   * The number of tasks checked:
>   */
> @@ -98,16 +102,17 @@ static struct notifier_block panic_block = {
>  static void debug_show_blocker(struct task_struct *task)
>  {
>  	struct task_struct *g, *t;
> -	unsigned long owner;
> -	struct mutex *lock;
> +	unsigned long owner, blocker;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
>  
> -	lock = READ_ONCE(task->blocker_mutex);
> -	if (!lock)
> +	blocker = READ_ONCE(task->blocker);
> +	if (!blocker || !hung_task_blocker_is_type(blocker, BLOCKER_TYPE_MUTEX))
>  		return;
>  
> -	owner = mutex_get_owner(lock);
> +	owner = mutex_get_owner(
> +		(struct mutex *)hung_task_blocker_to_lock(blocker));

Yeah, others look good to me.

Thank you!


> +
>  	if (unlikely(!owner)) {
>  		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
>  			task->comm, task->pid);
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 6a543c204a14..642d6398e0dd 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -42,6 +42,10 @@
>  # define MUTEX_WARN_ON(cond)
>  #endif
>  
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +#include <linux/hung_task.h>
> +#endif
> +
>  void
>  __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
>  {
> @@ -189,7 +193,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  		   struct list_head *list)
>  {
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -	WRITE_ONCE(current->blocker_mutex, lock);
> +	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
>  #endif
>  	debug_mutex_add_waiter(lock, waiter, current);
>  
> @@ -207,7 +211,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
>  
>  	debug_mutex_remove_waiter(lock, waiter, current);
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -	WRITE_ONCE(current->blocker_mutex, NULL);
> +	hung_task_clear_blocker();
>  #endif
>  }
>  
> -- 
> 
> Thanks,
> Lance


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

