Return-Path: <linux-kernel+bounces-329533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB635979297
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1CF1C216C1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615991D1738;
	Sat, 14 Sep 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N158D4T4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64201D094B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333934; cv=none; b=dkrjNN3068uFr7hU1C0v5kpmhnH4cClwTrWbwc2fldxMrweWUpNgmUc8H6h19P0s3cbqPKl0MgYGVvuHySF4jKE9L6d7vUhixH1SJ3KzX3YqR5DC7MykU54Yf0HeX5Vl4tYEaiQC1P/9rrl4KU68vDDphA2qWPloypauUUdud9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333934; c=relaxed/simple;
	bh=WTyN72nXyJm3CyLooephTAgyhPRxNH4t2mRmUMLXA6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbQubL+oOcT5iMU+igaXbTC9FlrScTKhloSReB+FT5+q82oTZ1vHv4FqtISvkCqzoHUGMavGQmlyE3+Cx3Q/CT50G0AFXGCSA9SLn1+zED+f+zNsFpFOAtJSJpuw4xNtIwDqeqwxjVm4bDZ6nM7gAdYcRVlNiMdsJuCRb5B2jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N158D4T4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726333930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAYhCYC5aSRGEy+dnfQ4O0pgrsCcNFr0n6dEsKLcC+0=;
	b=N158D4T4gRuH/29LBLxCa3LUkKPRFEaQSXoVg5IaKsQN2sOpTUYGmufkz8S2DAv70NE4kU
	8+lXMHLdSPEj9cSi3bSdU72sOVGyOHsbwl4RKcqtNghr/3BNFSsr0uY3bo4kX7uD1PyUrs
	uXiOmfmhXPY/CxG7CIAnbr/AUJraeP0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-DoHPLhfuMICsgd8NDwpdKg-1; Sat,
 14 Sep 2024 13:12:05 -0400
X-MC-Unique: DoHPLhfuMICsgd8NDwpdKg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45D8519560B7;
	Sat, 14 Sep 2024 17:12:03 +0000 (UTC)
Received: from [10.2.16.15] (unknown [10.2.16.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3029919560AF;
	Sat, 14 Sep 2024 17:11:59 +0000 (UTC)
Message-ID: <0fd3eede-a782-4e69-ab76-9822ae864dbe@redhat.com>
Date: Sat, 14 Sep 2024 13:11:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] locking/osq_lock: From x_osq_lock/unlock to
 numa-aware lock/unlock.
To: yongli-oc <yongli-oc@zhaoxin.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, yongli@zhaoxin.com, louisqi@zhaoxin.com,
 cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-4-yongli-oc@zhaoxin.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240914085327.32912-4-yongli-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 9/14/24 04:53, yongli-oc wrote:
> According to the contention level, switches from x_osq_lock to
> numa-aware osq_lock.
> The numa-aware lock is a two level osq_lock.
> The Makefile for dynamic numa-aware osq lock.
>
> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
> ---
>   kernel/locking/Makefile      |   1 +
>   kernel/locking/numa.h        |  98 ++++++++
>   kernel/locking/numa_osq.h    |  32 +++
>   kernel/locking/x_osq_lock.c  | 332 +++++++++++++++++++++++++++
>   kernel/locking/zx_numa_osq.c | 433 +++++++++++++++++++++++++++++++++++
>   5 files changed, 896 insertions(+)
>   create mode 100644 kernel/locking/numa.h
>   create mode 100644 kernel/locking/numa_osq.h
>   create mode 100644 kernel/locking/x_osq_lock.c
>   create mode 100644 kernel/locking/zx_numa_osq.c
>
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 0db4093d17b8..00c1d5bb6eb9 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_LOCKDEP) += lockdep_proc.o
>   endif
>   obj-$(CONFIG_SMP) += spinlock.o
>   obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
> +obj-$(CONFIG_LOCK_SPIN_ON_OWNER_NUMA) += x_osq_lock.o zx_numa_osq.o zx_numa.o
>   obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
>   obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
>   obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
> diff --git a/kernel/locking/numa.h b/kernel/locking/numa.h
> new file mode 100644
> index 000000000000..01e5aef3257a
> --- /dev/null
> +++ b/kernel/locking/numa.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_NUMA_LOCK_H
> +#define __LINUX_NUMA_LOCK_H
> +#include "mcs_spinlock.h"
> +
> +struct optimistic_spin_node {
> +	struct optimistic_spin_node *next, *prev;
> +	int numa;
> +	int locked; /* 1 if lock acquired */
> +	int cpu; /* encoded CPU # + 1 value */
> +	u32 serial;
> +};
> +
> +
> +struct _numa_buf {
> +	void *numa_ptr;
> +	struct list_head list;
> +	u32 lockaddr;
> +	u32 highaddr;
> +	u8 idle;
> +	u8 type;
> +	u16 index;
> +};
> +
> +struct cache_padding {
> +	char x[0];
> +} ____cacheline_internodealigned_in_smp;
> +#define CACHE_PADDING(name)	struct cache_padding name
We have struct cacheline_padding and CACHELINE_PADDING() in 
include/linux/cache. What is the point of reinventing the same thing here?
> +
> +struct _numa_lock {
> +	atomic_t tail ____cacheline_aligned_in_smp;
> +	atomic_t addr;
> +	u8 shift;
> +	u8 stopping;
> +	u16 numa_nodes;
> +	u32 accessed;
> +	uint64_t totalaccessed;
> +	u32 nodeswitched;
> +	atomic_t initlock;
> +	atomic_t pending;
> +	union {
> +		struct mcs_spinlock mcs_node;
> +		struct optimistic_spin_node osq_node;
> +	};
> +	CACHE_PADDING(pad);
> +};
> +
> +struct numa_cpu_info {
> +	__u8	x86_model;
> +	/* CPU family */
> +	__u8	x86;
> +	/* CPU vendor */
> +	__u8	x86_vendor;
> +	__u8	x86_reserved;
> +	u32	feature1;
> +};
> +
> +#define NUMAEXPAND 1
> +
> +#define COHORT_START 1
> +#define ACQUIRE_NUMALOCK (UINT_MAX-1)
> +#define NODE_WAIT UINT_MAX
> +#define LOCK_NUMALOCK 1
> +#define UNLOCK_NUMALOCK 0
> +
> +#define NUMALOCKDYNAMIC 0xff
> +#define TURNTONUMAREADY 0xa5a5
> +#define NUMATURNBACKREADY 0x5a5a
> +
> +#define NUMA_LOCKED_VAL 0xf5efef
What are these special bit values for?
> +#define NUMA_UNLOCKED_VAL 0
> +
> +#define NUMASTEERMASK 0xf0000000
> +#define HIGH32BITMASK 0xffffffff00000000
> +#define LOW32MASK 0xffffffff
> +
> +extern int NUMASHIFT;
> +extern int NUMACLUSTERS;
In the kernel, uppercase names are used for macros. Variables should use 
all lowercase names to avoid confusion.
> +extern int zx_numa_lock_total;
> +extern struct _numa_buf *zx_numa_entry;
> +extern atomic_t numa_count;
> +extern int enable_zx_numa_osq_lock;
> +extern u32 zx_numa_lock;
> +extern int dynamic_enable;
> +extern struct kmem_cache *zx_numa_lock_cachep;
> +
> +static inline u32 ptrmask(void *s)
> +{
> +	return (uint64_t)s & LOW32MASK;
> +}
> +inline void *get_numa_lock(int index);
> +
> +int zx_check_numa_dynamic_locked(u32 lockaddr, struct _numa_lock *_numa_lock,
> +		int t);
> +int zx_numa_lock_ptr_get(void *p);
> +void numa_lock_init_data(struct _numa_lock *s, int clusters, u32 lockval,
> +		u32 lockaddr);
> +#endif
> diff --git a/kernel/locking/numa_osq.h b/kernel/locking/numa_osq.h
> new file mode 100644
> index 000000000000..4c99ad60c4e0
> --- /dev/null
> +++ b/kernel/locking/numa_osq.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_NUMA_OSQ_H
> +#define __LINUX_NUMA_OSQ_H
> +
> +#include <linux/osq_lock.h>
> +#include "mcs_spinlock.h"
> +
> +#define OSQLOCKINITED 0
> +#define OSQTONUMADETECT 0x10
> +#define OSQLOCKSTOPPING 0xfc
> +#define OSQ_LOCKED_VAL 0xffff
> +
> +extern u16 osq_keep_times;
> +extern u16 osq_lock_depth;
> +extern int osq_node_max;
> +
> +inline int encode_cpu(int cpu_nr);
> +inline int node_cpu(struct optimistic_spin_node *node);
> +inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val);
> +
> +void zx_osq_lock_stopping(struct optimistic_spin_queue *lock);
> +void zx_osq_numa_start(struct optimistic_spin_queue *lock);
> +void zx_osq_turn_numa_waiting(struct optimistic_spin_queue *lock);
> +
> +bool x_osq_lock(struct optimistic_spin_queue *lock);
> +void x_osq_unlock(struct optimistic_spin_queue *lock);
> +bool x_osq_is_locked(struct optimistic_spin_queue *lock);
> +inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
> +		struct _numa_lock *n);
> +inline bool zx_numa_osq_lock(struct optimistic_spin_queue *qslock,
> +		struct _numa_lock *n);
> +#endif
> diff --git a/kernel/locking/x_osq_lock.c b/kernel/locking/x_osq_lock.c
> new file mode 100644
> index 000000000000..6da8905ae7d6
> --- /dev/null
> +++ b/kernel/locking/x_osq_lock.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * crossing from osq_lock to numa-aware lock
> + */
> +#include <linux/percpu.h>
> +#include <linux/sched.h>
> +#include <linux/osq_lock.h>
> +#include "numa.h"
> +#include "numa_osq.h"
> +
> +u16 osq_lock_depth = 8;
> +u16 osq_keep_times = 32;
> +
> +/*
> + * An MCS like lock especially tailored for optimistic spinning for sleeping
> + * lock implementations (mutex, rwsem, etc).
> + *
> + * Using a single mcs node per CPU is safe because sleeping locks should not be
> + * called from interrupt context and we have preemption disabled while
> + * spinning.
> + */
> +DECLARE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
> +
> +/*
> + * Get a stable @node->next pointer, either for unlock() or unqueue() purposes.
> + * Can return NULL in case we were the last queued and we updated @lock instead.
> + *
> + * If osq_lock() is being cancelled there must be a previous node
> + * and 'old_cpu' is its CPU #.
> + * For osq_unlock() there is never a previous node and old_cpu is
> + * set to OSQ_UNLOCKED_VAL.
> + */
> +static inline struct optimistic_spin_node *
> +osq_wait_next_stop(struct optimistic_spin_queue *lock,
> +	      struct optimistic_spin_node *node,
> +	      int old_cpu)
> +{
> +	u16 curr = encode_cpu(smp_processor_id());
> +	u16 old = old_cpu;
> +
> +	if (lock->numa_enable == OSQLOCKSTOPPING && old == OSQ_UNLOCKED_VAL)
> +		old = OSQ_LOCKED_VAL;
> +
> +	for (;;) {
> +		if (READ_ONCE(lock->tail16) == curr &&
> +		    cmpxchg(&lock->tail16, curr, old) == curr) {
> +
> +			/*
> +			 * We were the last queued, we moved @lock back. @prev
> +			 * will now observe @lock and will complete its
> +			 * unlock()/unqueue().
> +			 */
> +			return NULL;
> +		}
> +
> +		/*
> +		 * We must xchg() the @node->next value, because if we were to
> +		 * leave it in, a concurrent unlock()/unqueue() from
> +		 * @node->next might complete Step-A and think its @prev is
> +		 * still valid.
> +		 *
> +		 * If the concurrent unlock()/unqueue() wins the race, we'll
> +		 * wait for either @lock to point to us, through its Step-B, or
> +		 * wait for a new @node->next from its Step-C.
> +		 */
> +		if (node->next) {
> +			struct optimistic_spin_node *next;
> +
> +			next = xchg(&node->next, NULL);
> +			if (next)
> +				return next;
> +		}
> +
> +		cpu_relax();
> +	}
> +}
> +
> +bool x_osq_lock(struct optimistic_spin_queue *lock)
> +{
> +	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> +	struct optimistic_spin_node *prev, *next;
> +	int cpu = smp_processor_id();
> +	u16 curr = encode_cpu(cpu);
> +	struct optimistic_spin_queue tail;
> +	u16 old;
> +
> +	tail.val = READ_ONCE(lock->val);
> +	if (unlikely(tail.numa_enable == OSQLOCKSTOPPING)) {
> +		zx_osq_turn_numa_waiting(lock);
> +		return x_osq_lock(lock);
> +	}
> +
> +	if (unlikely(tail.numa_enable == NUMALOCKDYNAMIC)) {
> +		struct _numa_lock *_numa_lock = NULL;
> +		struct _numa_lock *node_lock = NULL;
> +
> +		_numa_lock = get_numa_lock(tail.index);
> +		node_lock = (struct _numa_lock *) _numa_lock +
> +					(cpu >> NUMASHIFT);
> +
> +		prefetch(node_lock);
> +		return zx_numa_osq_lock(lock, _numa_lock);
> +	}
> +
> +	node->locked = 0;
> +	node->next = NULL;
> +	node->cpu = curr;
> +
> +	/*
> +	 * We need both ACQUIRE (pairs with corresponding RELEASE in
> +	 * unlock() uncontended, or fastpath) and RELEASE (to publish
> +	 * the node fields we just initialised) semantics when updating
> +	 * the lock tail.
> +	 */
> +
> +	if (likely(tail.numa_enable >= OSQTONUMADETECT)) {
> +		struct optimistic_spin_queue ss;
> +
> +		while (1) {
> +			ss.val = atomic_read(&lock->tail);
> +			if (ss.tail16 == OSQ_LOCKED_VAL) {
> +				zx_osq_turn_numa_waiting(lock);
> +				return x_osq_lock(lock);
> +			}
> +			if (cmpxchg(&lock->tail16, ss.tail16, curr)
> +					== ss.tail16) {
> +				old = ss.tail16;
> +				break;
> +			}
> +			cpu_relax();
> +		}
> +	} else
> +		old = xchg(&lock->tail16, curr);
> +
> +	if (old == OSQ_UNLOCKED_VAL) {
> +		node->serial = 1;
> +		return true;
> +	}
> +
> +	prev = decode_cpu(old);
> +	node->prev = prev;
> +
> +	node->serial = prev->serial + 1;
> +	/*
> +	 * osq_lock()			unqueue
> +	 *
> +	 * node->prev = prev		osq_wait_next()
> +	 * WMB				MB
> +	 * prev->next = node		next->prev = prev // unqueue-C
> +	 *
> +	 * Here 'node->prev' and 'next->prev' are the same variable and we need
> +	 * to ensure these stores happen in-order to avoid corrupting the list.
> +	 */
> +	smp_wmb();
> +
> +	WRITE_ONCE(prev->next, node);
> +
> +	/*
> +	 * Normally @prev is untouchable after the above store; because at that
> +	 * moment unlock can proceed and wipe the node element from stack.
> +	 *
> +	 * However, since our nodes are static per-cpu storage, we're
> +	 * guaranteed their existence -- this allows us to apply
> +	 * cmpxchg in an attempt to undo our queueing.
> +	 */
> +
> +	/*
> +	 * Wait to acquire the lock or cancellation. Note that need_resched()
> +	 * will come with an IPI, which will wake smp_cond_load_relaxed() if it
> +	 * is implemented with a monitor-wait. vcpu_is_preempted() relies on
> +	 * polling, be careful.
> +	 */
> +	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
> +				  vcpu_is_preempted(node_cpu(node->prev))))
> +		return true;
> +
> +	/* unqueue */
> +	/*
> +	 * Step - A  -- stabilize @prev
> +	 *
> +	 * Undo our @prev->next assignment; this will make @prev's
> +	 * unlock()/unqueue() wait for a next pointer since @lock points to us
> +	 * (or later).
> +	 */
> +
> +	for (;;) {
> +		/*
> +		 * cpu_relax() below implies a compiler barrier which would
> +		 * prevent this comparison being optimized away.
> +		 */
> +		if (data_race(prev->next) == node &&
> +		    cmpxchg(&prev->next, node, NULL) == node)
> +			break;
> +
> +		/*
> +		 * We can only fail the cmpxchg() racing against an unlock(),
> +		 * in which case we should observe @node->locked becoming
> +		 * true.
> +		 */
> +		if (smp_load_acquire(&node->locked))
> +			return true;
> +
> +		cpu_relax();
> +
> +		/*
> +		 * Or we race against a concurrent unqueue()'s step-B, in which
> +		 * case its step-C will write us a new @node->prev pointer.
> +		 */
> +		prev = READ_ONCE(node->prev);
> +	}
> +
> +	/*
> +	 * Step - B -- stabilize @next
> +	 *
> +	 * Similar to unlock(), wait for @node->next or move @lock from @node
> +	 * back to @prev.
> +	 */
> +
> +	next = osq_wait_next_stop(lock, node, prev->cpu);
> +	if (!next)
> +		return false;
> +
> +	/*
> +	 * Step - C -- unlink
> +	 *
> +	 * @prev is stable because its still waiting for a new @prev->next
> +	 * pointer, @next is stable because our @node->next pointer is NULL and
> +	 * it will wait in Step-A.
> +	 */
> +
> +	WRITE_ONCE(next->prev, prev);
> +	WRITE_ONCE(prev->next, next);
> +
> +	return false;
> +}
> +
> +
> +
> +void x_osq_unlock(struct optimistic_spin_queue *lock)
> +{
> +	struct optimistic_spin_node *node, *next;
> +	int threadshold = osq_lock_depth;
> +	int cpu = smp_processor_id();
> +	u16 curr = encode_cpu(cpu);
> +	int depth = 0;
> +	u32 count = 0;
> +
> +	if (unlikely(lock->numa_enable == NUMALOCKDYNAMIC)) {
> +		struct _numa_lock *_numa_lock = get_numa_lock(lock->index);
> +
> +		prefetch((struct _numa_lock *) _numa_lock + (cpu >> NUMASHIFT));
> +		return zx_numa_osq_unlock(lock, _numa_lock);
> +	}
> +	/*
> +	 * Fast path for the uncontended case.
> +	 */
> +	if (unlikely(lock->numa_enable == OSQTONUMADETECT)) {
> +		struct optimistic_spin_node *node_last = NULL;
> +		u16 tail = 0;
> +
> +		tail = cmpxchg(&lock->tail16, curr, OSQ_UNLOCKED_VAL);
> +		if (tail == curr)
> +			return;
> +
> +		node = this_cpu_ptr(&osq_node);
> +		node_last = decode_cpu(tail);
> +		depth = node_last->serial - node->serial;
> +		count = READ_ONCE(node->locked);
> +		if (count > osq_keep_times && (dynamic_enable & 0x1))
> +			zx_osq_lock_stopping(lock);
> +	} else if (unlikely(lock->numa_enable == OSQLOCKSTOPPING)) {
> +		if (cmpxchg(&lock->tail16, curr, OSQ_LOCKED_VAL)
> +					== curr) {
> +			zx_osq_numa_start(lock);
> +			return;
> +		}
> +	} else {
> +		struct optimistic_spin_queue t;
> +
> +		t.val = 0;
> +		if (dynamic_enable & 0x1) {
> +			if (atomic_read(&numa_count) < zx_numa_lock_total)
> +				t.numa_enable = OSQTONUMADETECT;
> +		}
> +		if (t.numa_enable == OSQTONUMADETECT) {
> +			if (atomic_cmpxchg_release(&lock->tail, curr,
> +				(t.val | OSQ_UNLOCKED_VAL)) == curr)
> +				return;
> +		} else if (cmpxchg(&lock->tail16, curr,
> +				OSQ_UNLOCKED_VAL) == curr)
> +			return;
> +	}
> +
> +	/*
> +	 * Second most likely case.
> +	 */
> +	node = this_cpu_ptr(&osq_node);
> +	next = xchg(&node->next, NULL);
> +	if (next) {
> +		if (depth > threadshold)
> +			WRITE_ONCE(next->locked, count + 1);
> +		else
> +			WRITE_ONCE(next->locked, 1);
> +		return;
> +	}
> +
> +	next = osq_wait_next_stop(lock, node, OSQ_UNLOCKED_VAL);
> +	if (next) {
> +		if (depth > threadshold)
> +			WRITE_ONCE(next->locked, count + 1);
> +		else
> +			WRITE_ONCE(next->locked, 1);
> +	}
> +}
> +
> +bool x_osq_is_locked(struct optimistic_spin_queue *lock)
> +{
> +	struct optimistic_spin_queue val;
> +
> +	val.val = atomic_read(&lock->tail);
> +	if (val.tail16 == OSQ_UNLOCKED_VAL)
> +		return false;
> +
> +	if (val.tail16 == OSQ_LOCKED_VAL) {
> +		if (val.numa_enable != NUMALOCKDYNAMIC)
> +			return true;
> +		return zx_check_numa_dynamic_locked(ptrmask(lock),
> +					get_numa_lock(val.index), 0);
> +	}
> +
> +	return true;
> +}
These functions are mostly based on the  osq_* functions with some extra 
code stuffed in. Common code should be shared instead of duplicated.
> diff --git a/kernel/locking/zx_numa_osq.c b/kernel/locking/zx_numa_osq.c
> new file mode 100644
> index 000000000000..f4c3dba208d3
> --- /dev/null
> +++ b/kernel/locking/zx_numa_osq.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Dynamic numa-aware osq lock
> + * Author: LiYong <yongli-oc@zhaoxin.com>
> + *
> + */
> +#include <linux/cpumask.h>
> +#include <asm/byteorder.h>
> +#include <linux/percpu.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/osq_lock.h>
> +#include "numa.h"
> +#include "numa_osq.h"
> +
> +int osq_node_max = 256;
> +
> +/*
> + * The pending bit spinning loop count.
> + * This heuristic is used to limit the number of lockword accesses
> + * made by atomic_cond_read_relaxed when waiting for the lock to
> + * transition out of the "== _Q_PENDING_VAL" state. We don't spin
> + * indefinitely because there's no guarantee that we'll make forward
> + * progress.
> + */
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_cpu_node);
> +
> +/*
> + * We use the value 0 to represent "no CPU", thus the encoded value
> + * will be the CPU number incremented by 1.
> + */
> +static inline int decode(int cpu_nr)
> +{
> +	return cpu_nr - 1;
> +}
> +
> +static inline struct optimistic_spin_node *decode_curr(int encoded_cpu_val)
> +{
> +	int cpu_nr = decode(encoded_cpu_val);
> +
> +	return per_cpu_ptr(&osq_cpu_node, cpu_nr);
> +}
> +
> +static int atomic64_cmpxchg_notequal(void *qslock, atomic_t *tail, int curr)
> +{
> +	u64 ss = 0;
> +	u32 addr = ptrmask(qslock);
> +	u64 addrcurr = (((u64)addr) << 32) | curr;
> +
> +	while (1) {
> +		ss = atomic64_read((atomic64_t *) tail);
> +		if ((ss >> 32) != addr)
> +			return NUMA_LOCKED_VAL;
> +		if ((ss & LOW32MASK) == NUMA_LOCKED_VAL)
> +			return NUMA_LOCKED_VAL;
> +		if (atomic64_cmpxchg((atomic64_t *) tail, ss, addrcurr) == ss)
> +			return ss & LOW32MASK;
> +		cpu_relax();
> +	}
> +}
> +
> +void zx_osq_lock_stopping(struct optimistic_spin_queue *lock)
> +{
> +	int s = 0;
> +
> +	s = zx_numa_lock_ptr_get(lock);
> +	if (s < zx_numa_lock_total) {
> +		numa_lock_init_data(zx_numa_entry[s].numa_ptr,
> +			NUMACLUSTERS, NUMA_UNLOCKED_VAL,
> +			ptrmask(lock));
> +
> +		WRITE_ONCE(lock->index, s);
> +		zx_numa_entry[s].type = 1;
> +		smp_mb();/*should set these before enable*/
> +		prefetchw(&lock->numa_enable);
> +		WRITE_ONCE(lock->numa_enable, OSQLOCKSTOPPING);
> +	} else {
> +		prefetchw(&lock->numa_enable);
> +		WRITE_ONCE(lock->numa_enable, OSQLOCKINITED);
> +	}
> +}
> +
> +void zx_osq_numa_start(struct optimistic_spin_queue *lock)
> +{
> +	struct _numa_lock *_numa_lock = get_numa_lock(lock->index);
> +
> +	prefetchw(&lock->numa_enable);
> +	WRITE_ONCE(lock->numa_enable, NUMALOCKDYNAMIC);
> +	smp_mb(); /*should keep lock->numa_enable modified first*/
> +	atomic_set(&_numa_lock->initlock, TURNTONUMAREADY);
> +}
> +
> +
> +void zx_osq_turn_numa_waiting(struct optimistic_spin_queue *lock)
> +{
> +	struct _numa_lock *_numa_lock = get_numa_lock(lock->index);
> +
> +	atomic_inc(&_numa_lock->pending);
> +	while (1) {
> +		int s = atomic_read(&_numa_lock->initlock);
> +
> +		if (s == TURNTONUMAREADY)
> +			break;
> +		cpu_relax();
> +		cpu_relax();
> +		cpu_relax();
> +		cpu_relax();
We don't usually call cpu_relax() multiple times like that as the actual 
delay is CPU dependent and it is hard to get it right for all. Can you 
explain why it is called exactly 4 times here?
> +
> +	}
> +	atomic_dec(&_numa_lock->pending);
> +}
> +
> +
> +
> +
> +static struct optimistic_spin_node *
> +zx_numa_osq_wait_next(struct _numa_lock *lock,
> +		struct optimistic_spin_node *node,
> +		struct optimistic_spin_node *prev, int cpu)
> +{
> +	struct optimistic_spin_node *next = NULL;
> +	int curr = encode_cpu(cpu);
> +	int old;
> +
> +	old = prev ? prev->cpu : OSQ_UNLOCKED_VAL;
> +	for (;;) {
> +		if (atomic_read(&lock->tail) == curr &&
> +		    atomic_cmpxchg_acquire(&lock->tail, curr, old) == curr) {
> +
> +			break;
> +		}
> +		if (node->next) {
> +			next = xchg(&node->next, NULL);
> +			if (next)
> +				break;
> +		}
> +		cpu_relax();
> +	}
> +	return next;
> +}
> +static void zx_numa_turn_osq_waiting(struct optimistic_spin_queue *lock,
> +			struct _numa_lock *_numa_lock)
> +{
> +	struct _numa_lock *numa_lock = _numa_lock + _numa_lock->numa_nodes;
> +	int lockaddr = ptrmask(lock);
> +	u64 s = 0;
> +	struct optimistic_spin_queue tail;
> +
> +	tail.numa_enable = NUMALOCKDYNAMIC;
> +	tail.index = lock->index;
> +	tail.tail16 = OSQ_LOCKED_VAL;
> +	while (1) {
> +		cpu_relax(); cpu_relax(); cpu_relax(); cpu_relax();
> +		s = atomic64_read((atomic64_t *) &numa_lock->tail);
> +		if ((s >> 32) != lockaddr)
> +			break;
> +		if ((s & LOW32MASK) == NUMA_LOCKED_VAL)
> +			break;
> +	}
> +	prefetchw(&lock->tail);
> +	if (atomic_cmpxchg(&lock->tail, tail.val, OSQ_UNLOCKED_VAL)
> +			== tail.val) {
> +		;
> +	}
> +
> +}
> +
> +static int _zx_node_osq_lock_internal(struct optimistic_spin_queue *qslock,
> +	struct optimistic_spin_node *node, struct optimistic_spin_node *prev,
> +	struct _numa_lock *node_lock, int cpu, int *cur_status)
> +{
> +	struct optimistic_spin_node *next = NULL;
> +
> +	for (;;) {
> +		struct optimistic_spin_node *node_prev = NULL;
> +
> +		if (prev->next == node &&
> +		    cmpxchg(&prev->next, node, NULL) == node) {
> +			break;
> +		}
> +		/*load locked first each time*/
> +		*cur_status = smp_load_acquire(&node->locked);
> +
> +		if (*cur_status != NODE_WAIT)
> +			return 0; //goto NODE_UNLOCK;
> +
> +		cpu_relax();
> +		node_prev = READ_ONCE(node->prev);
> +		if (node_prev != prev)
> +			prev = node_prev;
> +	}
> +
> +	next = zx_numa_osq_wait_next(node_lock, node, prev, cpu);
> +	if (!next)
> +		return -1;
> +
> +	WRITE_ONCE(next->prev, prev);
> +	WRITE_ONCE(prev->next, next);
> +
> +	return -1;
> +}
> +
> +static int _zx_node_osq_lock(struct optimistic_spin_queue *qslock,
> +					struct _numa_lock *_numa_lock)
> +{
> +	struct optimistic_spin_node *node = this_cpu_ptr(&osq_cpu_node);
> +	struct optimistic_spin_node *prev = NULL;
> +	int cpu = smp_processor_id();
> +	int curr = encode_cpu(cpu);
> +	int numa = cpu >> _numa_lock->shift;
> +	struct _numa_lock *node_lock = _numa_lock + numa;
> +	int cur_status = 0;
> +	int old = 0;
> +
> +	node->locked = NODE_WAIT;
> +	node->next = NULL;
> +	node->cpu = curr;
> +
> +	old = atomic64_cmpxchg_notequal(qslock, &node_lock->tail, curr);
> +
> +	if (old == NUMA_LOCKED_VAL) {
> +		bool s = true;
> +
> +		zx_numa_turn_osq_waiting(qslock, _numa_lock);
> +		s = osq_lock(qslock);
> +		if (s == true)
> +			return 1;
> +		else
> +			return -1;
> +	}
> +
> +	if (old == 0) {
> +		node->locked = COHORT_START;
> +		return ACQUIRE_NUMALOCK;
> +	}
> +
> +	prev = decode_curr(old);
> +	node->prev = prev;
> +
> +	smp_mb(); /* make sure node set before set pre->next */
> +
> +	WRITE_ONCE(prev->next, node);
> +
> +	while ((cur_status = READ_ONCE(node->locked)) == NODE_WAIT) {
> +		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev))) {
> +			int ddd = _zx_node_osq_lock_internal(qslock, node, prev,
> +						node_lock, cpu, &cur_status);
> +
> +			if (cur_status != NODE_WAIT)
> +				goto NODE_UNLOCK;
> +			if (ddd == -1)
> +				return -1;
> +		}
> +		cpu_relax();
> +	}
> +NODE_UNLOCK:
> +	if (cur_status == ACQUIRE_NUMALOCK)
> +		node->locked = COHORT_START;
> +	return cur_status;
> +}
> +static int _zx_numa_osq_lock(struct optimistic_spin_queue *qslock, int cpu,
> +				struct _numa_lock *_numa_lock)
> +{
> +	int numacpu = cpu >> _numa_lock->shift;
> +	int numacurr = encode_cpu(numacpu);
> +
> +	struct optimistic_spin_node *node = &(_numa_lock + numacpu)->osq_node;
> +	struct _numa_lock *numa_lock = _numa_lock + _numa_lock->numa_nodes;
> +	struct optimistic_spin_node *prevnode = NULL;
> +	int prev = 0;
> +
> +	node->next = NULL;
> +	node->locked = LOCK_NUMALOCK;
> +	node->cpu = numacurr;
> +
> +	prev = atomic_xchg(&numa_lock->tail, numacurr);
> +	if (prev == 0) {
> +		node->locked = UNLOCK_NUMALOCK;
> +		return 0;
> +	}
> +
> +	prevnode = &(_numa_lock + prev - 1)->osq_node;
> +	node->prev = prevnode;
> +	smp_mb(); /*node->prev should be set before next*/
> +	WRITE_ONCE(prevnode->next, node);
> +
> +	while (READ_ONCE(node->locked) == LOCK_NUMALOCK) {
> +		cpu_relax();
> +		cpu_relax();
> +		cpu_relax();
> +		cpu_relax();
> +	}
> +	return 0;
> +}
> +inline bool zx_numa_osq_lock(struct optimistic_spin_queue *qslock,
> +		struct _numa_lock *_numa_lock)
> +{
> +	struct _numa_lock *node_lock = NULL;
> +	int cpu = smp_processor_id();
> +	int numa = cpu >> _numa_lock->shift;
> +	int status = 0;
> +
> +	node_lock = _numa_lock + numa;
> +
> +	if (node_lock->stopping) {
> +		zx_numa_turn_osq_waiting(qslock, _numa_lock);
> +		return osq_lock(qslock);
> +	}
> +
> +	status = _zx_node_osq_lock(qslock, _numa_lock);
> +	if (status == ACQUIRE_NUMALOCK)
> +		status = _zx_numa_osq_lock(qslock, smp_processor_id(),
> +				_numa_lock);
> +
> +	if (status == -1)
> +		return false;
> +	return true;
> +}
> +
> +static int atomic64_checktail_osq(struct optimistic_spin_queue *qslock,
> +	struct _numa_lock *node_lock, int ctail)
> +{
> +	u64 addr = ((u64)ptrmask(qslock)) << 32;
> +	u64 addrtail = addr | ctail;
> +	u64 ss = 0;
> +	bool mark;
> +
> +	ss = atomic64_read((atomic64_t *) &node_lock->tail);
> +	if (node_lock->stopping == 0)
> +		mark = (ss == addrtail &&
> +			atomic64_cmpxchg_acquire(
> +				(atomic64_t *) &node_lock->tail,
> +				addrtail, addr|NUMA_UNLOCKED_VAL) == addrtail);
> +	else
> +		mark = (ss == addrtail &&
> +			atomic64_cmpxchg_acquire(
> +				(atomic64_t *) &node_lock->tail,
> +				addrtail, NUMA_LOCKED_VAL) == addrtail);
> +	return mark;
> +}
> +
> +static void node_lock_release(struct optimistic_spin_queue *qslock,
> +		struct _numa_lock *node_lock, struct optimistic_spin_node *node,
> +		int val, int cpu, int numa_end)
> +{
> +	struct optimistic_spin_node *next = NULL;
> +	int curr = encode_cpu(cpu);
> +
> +	while (1) {
> +		if (atomic64_checktail_osq(qslock, node_lock, curr)) {
> +			if (qslock->numa_enable == NUMALOCKDYNAMIC) {
> +				int index = qslock->index;
> +
> +				if (numa_end == OSQ_UNLOCKED_VAL &&
> +					zx_numa_entry[index].idle == 0) {
> +					cmpxchg(&zx_numa_entry[index].idle,
> +							0, 1);
> +				}
> +			}
> +			return;
> +		}
> +		if (node->next) {
> +			next = xchg(&node->next, NULL);
> +			if (next) {
> +				WRITE_ONCE(next->locked, val);
> +				return;
> +			}
> +		}
> +		cpu_relax();
> +	}
> +}
> +
> +static int numa_lock_release(struct optimistic_spin_queue *qslock,
> +		struct _numa_lock *numa_lock,
> +		struct optimistic_spin_node *node, int cpu)
> +{
> +	struct optimistic_spin_node *next = NULL;
> +	int curr = cpu >> numa_lock->shift;
> +	int numacurr = encode_cpu(curr);
> +
> +	while (1) {
> +		if (atomic_read(&numa_lock->tail) == numacurr &&
> +		    atomic_cmpxchg_acquire(&numa_lock->tail, numacurr,
> +					   OSQ_UNLOCKED_VAL) == numacurr) {
> +			return OSQ_UNLOCKED_VAL;
> +		}
> +
> +		if (node->next) {
> +			next = xchg(&node->next, NULL);
> +			if (next) {
> +				WRITE_ONCE(next->locked, UNLOCK_NUMALOCK);
> +				return 1;
> +			}
> +		}
> +		cpu_relax();
> +	}
> +}
> +
> +inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
> +		 struct _numa_lock *_numa_lock)
> +{
> +	u32 cpu =  smp_processor_id();
> +	struct optimistic_spin_node *node = this_cpu_ptr(&osq_cpu_node);
> +	int numa = cpu >> _numa_lock->shift;
> +	struct _numa_lock *numa_lock = _numa_lock + _numa_lock->numa_nodes;
> +	struct _numa_lock *node_lock = _numa_lock + numa;
> +	struct optimistic_spin_node *numa_node =
> +						&(_numa_lock + numa)->osq_node;
> +	struct optimistic_spin_node *next = NULL;
> +	int cur_count = 0;
> +	int numa_end = 0;
> +
> +	cur_count = READ_ONCE(node->locked);
> +
> +	if (cur_count >= osq_node_max - 1) {
> +		numa_end = numa_lock_release(qslock,
> +				numa_lock, numa_node, cpu);
> +		node_lock_release(qslock, node_lock, node,
> +				ACQUIRE_NUMALOCK, cpu, numa_end);
> +		return;
> +	}
> +
> +	next = xchg(&node->next, NULL);
> +	if (next) {
> +		WRITE_ONCE(next->locked, cur_count + 1);
> +		return;
> +	}
> +
> +	numa_end = numa_lock_release(qslock, numa_lock, numa_node, cpu);
> +	node_lock_release(qslock, node_lock, node, ACQUIRE_NUMALOCK,
> +			cpu, numa_end);
> +}

Overall speaking, there are not enough comments to explain exactly what 
are you trying to achieve with these new functions. It makes them hard 
to review.

Cheers,
Longman


