Return-Path: <linux-kernel+bounces-565848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA1A6700A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0337A31FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC4203716;
	Tue, 18 Mar 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjHRkDco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A761F666B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290923; cv=none; b=Q0Nnv/nfbYgxb481v+uuRSuWayZV6MnmhTLRqbZZHWgCvGWirBI2YzRE2nwqetI7MLQXn1Hb8II4B20P7hsCO9lJkUQPuoCM+qAzR9BzvPt3E+WgAnyMw8suMRnk603WQmRAT/bAQvYblx/N6yvvhazXbQlSSGxSTPFeD0rnSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290923; c=relaxed/simple;
	bh=cZDupBysulvKilI5D3mHkFNmjEi0eARAN+TKzJpQ4a4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Lw5QW/gYMfT8UW92gTgvCVjqDL27P/+A0j5a4WkNd7xWwuERiJRdWOSZDfqG/Uw5irHpseIGlQYVR133bKNhdtdiW9cDDU2QukVSPQeezV7rXKI2sqKay0BSB4U11Ihb84sFi31VaR0WaZWFm9lajRPtZPWaRz5AOYxRf/AvLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjHRkDco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47348C4CEDD;
	Tue, 18 Mar 2025 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742290922;
	bh=cZDupBysulvKilI5D3mHkFNmjEi0eARAN+TKzJpQ4a4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HjHRkDcoWoOC6OCYt1gIOvym0f7cXpwm9VG6boF4p9udmQ+XKrubkpzCW/Psse9lb
	 ek8hZNhFV+qJzVSja4wgRgwoaDxALYaYFHzVooTptpc2Aoy6GtUjXM4rFnNdwApgCt
	 YBWmorsiGPKx9qZBwljy4iO1NWYHiZNE8HFhmupegmwKrKAK+/j41M/tn25ekbmyrz
	 Lk26AduBWfMC1gg+C+izcM1z483uFXE9xcb/pA/+5oqxMK4VgFHBEOe5NXVS7fe4lo
	 87Pjc0Umc6anZbImYTJrSrgROuhn8/Tnt7wieo+c/AEU8x3Hgcv2olpU1srbM6P8Ly
	 Wtg51U0Va8Xlg==
Date: Tue, 18 Mar 2025 18:41:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, joel.granados@kernel.org,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com, Mingzhe
 Yang <mingzhe.yang@ly.com>
Subject: Re: [PATCH RESEND v2 1/3] hung_task: replace blocker_mutex with
 encoded blocker
Message-Id: <20250318184158.e6c1b2d28e2fee311bcd2c30@kernel.org>
In-Reply-To: <20250314144300.32542-2-ioworker0@gmail.com>
References: <20250314144300.32542-1-ioworker0@gmail.com>
	<20250314144300.32542-2-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 22:42:58 +0800
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

Hi Lance,

Thanks for update. I added some comments.

> 
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/hung_task.h | 94 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sched.h     |  2 +-
>  kernel/hung_task.c        | 15 ++++---
>  kernel/locking/mutex.c    |  8 +++-
>  4 files changed, 111 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/hung_task.h
> 
> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> new file mode 100644
> index 000000000000..64ced33b0d1f
> --- /dev/null
> +++ b/include/linux/hung_task.h
> @@ -0,0 +1,94 @@
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
> +	WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK);
> +	WARN_ON_ONCE(READ_ONCE(current->blocker));

The last one needs a comment why it is problem.

WARN_ON_ONCE(READ_ONCE(current->blocker),
	"Task blocker is not cleared. Maybe forgot to clear it somewhere? Type: %d\n",
	current->blocker);

But I don't think this isn't needed to be checked usually.

> +
> +	/*
> +	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
> +	 * without writing anything.
> +	 */
> +	if (lock_ptr & BLOCKER_TYPE_MASK)
> +		return;

You can use WARN_ON_ONCE for 'if' condition.

  if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
	return; 

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
> index dc898ec93463..46eb6717564d 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -25,6 +25,10 @@
>  
>  #include <trace/events/sched.h>
>  
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +#include <linux/hung_task.h>
> +#endif

We don't need this #ifdef, since it is already checked in the
header file.

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

Ditto.

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
> 2.45.2
> 

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

