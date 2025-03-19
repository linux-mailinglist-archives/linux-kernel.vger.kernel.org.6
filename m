Return-Path: <linux-kernel+bounces-568108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E760A68E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2DA3BF18E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA514B092;
	Wed, 19 Mar 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7C5V1tQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60232744E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392271; cv=none; b=dEY6VbK0wUy//S1gTjXtXSSgTHZIV4ODSCNDm0nRpyJXYGcM7U+lVfLql7NptpZiKvRRKxVI0Np6KUUpTwrAmiz2HZte3x6YFhHy0FhGTzC5RE7yWoHbCXuSTl8bxzrpk9+Y3czXAA9eMIhuQaD45a6u2eb7irBG93p21NxdZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392271; c=relaxed/simple;
	bh=b2bTok1RrzvyUQS4kuZJlEeyeze8GUwKgLWDvT4ARro=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QwEVrgmmZ+3a+0o95JfwkEhvQ2Onabl3oHCjTbBEBdKOcaUfRZdV4Wb9xFoolBN4xeeMW2xcB88QEekow8Sxw7j6+iupWJZfvxwPXDKpPzRg705lKgqTGRyTRyoFWMwr2xqyPLSvRwNC2c7nIcynYPufzSSopfbimpSAUJEq2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7C5V1tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E26EC4CEE9;
	Wed, 19 Mar 2025 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742392271;
	bh=b2bTok1RrzvyUQS4kuZJlEeyeze8GUwKgLWDvT4ARro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7C5V1tQlsn2Xo6crH/4/onp58IaOUMPZt44yme2Fpze8RX3O1zlBcfH/WDLlS4fF
	 f3pofU/Z2sHHKU3dd1lavi8AHQMBtDjYMXYS1LTf1WFTHEBriesgzpDWzi0ySryNy0
	 nfacIRiHRvAJ0gostl+rNARD51KATMrW9YZK4BBG3FrzVlhoiUAicP9OWWG+eyrsQ1
	 n4ae1ycRldhR6Db24wiEraAYiV17diY9NjiyAWZlKCC485zagQgpj3Pg/T3BCKQRZD
	 Us6Tv0uq7VX/CcDV74qR4XEZcRHMsu3wwH8QfBK7Aw19GshQ8q4jqdYNOxwmgPMaK6
	 Fv5U3GlmZJl1Q==
Date: Wed, 19 Mar 2025 22:51:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, joel.granados@kernel.org,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com,
 jstultz@google.com, Mingzhe Yang <mingzhe.yang@ly.com>
Subject: Re: [PATCH v3 1/3] hung_task: replace blocker_mutex with encoded
 blocker
Message-Id: <20250319225105.55bc3df7d2ee57d61bc92dbb@kernel.org>
In-Reply-To: <20250319081138.25133-2-ioworker0@gmail.com>
References: <20250319081138.25133-1-ioworker0@gmail.com>
	<20250319081138.25133-2-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 16:11:36 +0800
Lance Yang <ioworker0@gmail.com> wrote:

> This patch replaces 'struct mutex *blocker_mutex' with 'unsigned long
> blocker', as only one blocker is active at a time.
> 
> The blocker filed can store both the lock addrees and the lock type, with
> LSB used to encode the type as Masami suggested, making it easier to extend
> the feature to cover other types of locks.
> 
> Also, once the lock type is determined, we can directly extract the address
> and cast it to a lock pointer ;)

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/hung_task.h | 93 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sched.h     |  2 +-
>  kernel/hung_task.c        | 12 ++---
>  kernel/locking/mutex.c    |  5 ++-
>  4 files changed, 104 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/hung_task.h
> 
> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> new file mode 100644
> index 000000000000..c772bca6775b
> --- /dev/null
> +++ b/include/linux/hung_task.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Detect Hung Task: detecting tasks stuck in D state
> + *
> + * Copyright (C) 2025 Tongcheng Travel (www.ly.com)
> + * Author: Lance Yang <mingzhe.yang@ly.com>
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
> + * 10 - Blocked on rt-mutex     (BLOCKER_TYPE_RTMUTEX)
> + * 11 - Blocked on rw-semaphore (BLOCKER_TYPE_RWSEM)
> + */
> +#define BLOCKER_TYPE_MUTEX      0x00UL
> +#define BLOCKER_TYPE_SEM        0x01UL
> +#define BLOCKER_TYPE_RTMUTEX    0x02UL
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
> +	WARN_ON_ONCE(READ_ONCE(current->blocker));
> +
> +	/*
> +	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
> +	 * without writing anything.
> +	 */
> +	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
> +		return;
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
> +static inline void hung_task_set_blocker(void *lock, unsigned long type)
> +{
> +}
> +static inline void hung_task_clear_blocker(void)
> +{
> +}
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
> index dc898ec93463..75dc1048f2c1 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -22,6 +22,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/sysctl.h>
> +#include <linux/hung_task.h>
>  
>  #include <trace/events/sched.h>
>  
> @@ -98,16 +99,17 @@ static struct notifier_block panic_block = {
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
> +
>  	if (unlikely(!owner)) {
>  		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
>  			task->comm, task->pid);
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 6a543c204a14..e9ef70a6cb5f 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -29,6 +29,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/debug_locks.h>
>  #include <linux/osq_lock.h>
> +#include <linux/hung_task.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/lock.h>
> @@ -189,7 +190,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  		   struct list_head *list)
>  {
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -	WRITE_ONCE(current->blocker_mutex, lock);
> +	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
>  #endif
>  	debug_mutex_add_waiter(lock, waiter, current);
>  
> @@ -207,7 +208,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
>  
>  	debug_mutex_remove_waiter(lock, waiter, current);
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -	WRITE_ONCE(current->blocker_mutex, NULL);
> +	hung_task_clear_blocker();
>  #endif
>  }
>  
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

