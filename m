Return-Path: <linux-kernel+bounces-329270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28E978F68
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E73284C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12FD149E1A;
	Sat, 14 Sep 2024 09:20:50 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05F1CEAAC
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305649; cv=none; b=txOMGVZmWoP/LEd+1dOTZDRr+zr3WWdDJLmNCq8TyqBo/9RdcWKSjbalXxCe9iFkflcamJhnhI7mFg9EU7I6aFSz8rq7J81N99KMnIqWUs5C0+6SkRO1I/773sl2P1HY6MqV7bZmkNziiLq9446N2sFX+FWFXzZAmLS6tk4jMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305649; c=relaxed/simple;
	bh=6DfMR0CDEBFsqTiYCu5LHo3m9XDvAvzajLB1ByfGLSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgoKwlB7agFeoSDMycC6DIG2qzp6gowlans54YmTebETnD9gQLAN2p22mgcGQ9q0jtmeAA6xV2wHEsdZfsj9qxrsG8vSaFZhifz7x2zhPDI4mj6A9fRsq95JmnsAM6swdT3ltvVtaw5aoFIFQlFTEevyri4MX7gG2pmM5XH9oXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726305640-1eb14e31a8106400001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id 6WnxCA286oUk5s89 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 14 Sep 2024 17:20:40 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:40 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:39 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Sat, 14 Sep 2024 17:20:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 16:53:28 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH 3/4] locking/osq_lock: From x_osq_lock/unlock to numa-aware lock/unlock.
Date: Sat, 14 Sep 2024 16:53:26 +0800
X-ASG-Orig-Subj: [PATCH 3/4] locking/osq_lock: From x_osq_lock/unlock to numa-aware lock/unlock.
Message-ID: <20240914085327.32912-4-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/14/2024 5:20:37 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1726305640
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 25992
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130433
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

According to the contention level, switches from x_osq_lock to
numa-aware osq_lock.
The numa-aware lock is a two level osq_lock.
The Makefile for dynamic numa-aware osq lock.

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 kernel/locking/Makefile      |   1 +
 kernel/locking/numa.h        |  98 ++++++++
 kernel/locking/numa_osq.h    |  32 +++
 kernel/locking/x_osq_lock.c  | 332 +++++++++++++++++++++++++++
 kernel/locking/zx_numa_osq.c | 433 +++++++++++++++++++++++++++++++++++
 5 files changed, 896 insertions(+)
 create mode 100644 kernel/locking/numa.h
 create mode 100644 kernel/locking/numa_osq.h
 create mode 100644 kernel/locking/x_osq_lock.c
 create mode 100644 kernel/locking/zx_numa_osq.c

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17b8..00c1d5bb6eb9 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_LOCKDEP) +=3D lockdep_proc.o
 endif
 obj-$(CONFIG_SMP) +=3D spinlock.o
 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) +=3D osq_lock.o
+obj-$(CONFIG_LOCK_SPIN_ON_OWNER_NUMA) +=3D x_osq_lock.o zx_numa_osq.o zx_n=
uma.o
 obj-$(CONFIG_PROVE_LOCKING) +=3D spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) +=3D rtmutex_api.o
diff --git a/kernel/locking/numa.h b/kernel/locking/numa.h
new file mode 100644
index 000000000000..01e5aef3257a
--- /dev/null
+++ b/kernel/locking/numa.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_NUMA_LOCK_H
+#define __LINUX_NUMA_LOCK_H
+#include "mcs_spinlock.h"
+
+struct optimistic_spin_node {
+	struct optimistic_spin_node *next, *prev;
+	int numa;
+	int locked; /* 1 if lock acquired */
+	int cpu; /* encoded CPU # + 1 value */
+	u32 serial;
+};
+
+
+struct _numa_buf {
+	void *numa_ptr;
+	struct list_head list;
+	u32 lockaddr;
+	u32 highaddr;
+	u8 idle;
+	u8 type;
+	u16 index;
+};
+
+struct cache_padding {
+	char x[0];
+} ____cacheline_internodealigned_in_smp;
+#define CACHE_PADDING(name)	struct cache_padding name
+
+struct _numa_lock {
+	atomic_t tail ____cacheline_aligned_in_smp;
+	atomic_t addr;
+	u8 shift;
+	u8 stopping;
+	u16 numa_nodes;
+	u32 accessed;
+	uint64_t totalaccessed;
+	u32 nodeswitched;
+	atomic_t initlock;
+	atomic_t pending;
+	union {
+		struct mcs_spinlock mcs_node;
+		struct optimistic_spin_node osq_node;
+	};
+	CACHE_PADDING(pad);
+};
+
+struct numa_cpu_info {
+	__u8	x86_model;
+	/* CPU family */
+	__u8	x86;
+	/* CPU vendor */
+	__u8	x86_vendor;
+	__u8	x86_reserved;
+	u32	feature1;
+};
+
+#define NUMAEXPAND 1
+
+#define COHORT_START 1
+#define ACQUIRE_NUMALOCK (UINT_MAX-1)
+#define NODE_WAIT UINT_MAX
+#define LOCK_NUMALOCK 1
+#define UNLOCK_NUMALOCK 0
+
+#define NUMALOCKDYNAMIC 0xff
+#define TURNTONUMAREADY 0xa5a5
+#define NUMATURNBACKREADY 0x5a5a
+
+#define NUMA_LOCKED_VAL 0xf5efef
+#define NUMA_UNLOCKED_VAL 0
+
+#define NUMASTEERMASK 0xf0000000
+#define HIGH32BITMASK 0xffffffff00000000
+#define LOW32MASK 0xffffffff
+
+extern int NUMASHIFT;
+extern int NUMACLUSTERS;
+extern int zx_numa_lock_total;
+extern struct _numa_buf *zx_numa_entry;
+extern atomic_t numa_count;
+extern int enable_zx_numa_osq_lock;
+extern u32 zx_numa_lock;
+extern int dynamic_enable;
+extern struct kmem_cache *zx_numa_lock_cachep;
+
+static inline u32 ptrmask(void *s)
+{
+	return (uint64_t)s & LOW32MASK;
+}
+inline void *get_numa_lock(int index);
+
+int zx_check_numa_dynamic_locked(u32 lockaddr, struct _numa_lock *_numa_lo=
ck,
+		int t);
+int zx_numa_lock_ptr_get(void *p);
+void numa_lock_init_data(struct _numa_lock *s, int clusters, u32 lockval,
+		u32 lockaddr);
+#endif
diff --git a/kernel/locking/numa_osq.h b/kernel/locking/numa_osq.h
new file mode 100644
index 000000000000..4c99ad60c4e0
--- /dev/null
+++ b/kernel/locking/numa_osq.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_NUMA_OSQ_H
+#define __LINUX_NUMA_OSQ_H
+
+#include <linux/osq_lock.h>
+#include "mcs_spinlock.h"
+
+#define OSQLOCKINITED 0
+#define OSQTONUMADETECT 0x10
+#define OSQLOCKSTOPPING 0xfc
+#define OSQ_LOCKED_VAL 0xffff
+
+extern u16 osq_keep_times;
+extern u16 osq_lock_depth;
+extern int osq_node_max;
+
+inline int encode_cpu(int cpu_nr);
+inline int node_cpu(struct optimistic_spin_node *node);
+inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val);
+
+void zx_osq_lock_stopping(struct optimistic_spin_queue *lock);
+void zx_osq_numa_start(struct optimistic_spin_queue *lock);
+void zx_osq_turn_numa_waiting(struct optimistic_spin_queue *lock);
+
+bool x_osq_lock(struct optimistic_spin_queue *lock);
+void x_osq_unlock(struct optimistic_spin_queue *lock);
+bool x_osq_is_locked(struct optimistic_spin_queue *lock);
+inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
+		struct _numa_lock *n);
+inline bool zx_numa_osq_lock(struct optimistic_spin_queue *qslock,
+		struct _numa_lock *n);
+#endif
diff --git a/kernel/locking/x_osq_lock.c b/kernel/locking/x_osq_lock.c
new file mode 100644
index 000000000000..6da8905ae7d6
--- /dev/null
+++ b/kernel/locking/x_osq_lock.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * crossing from osq_lock to numa-aware lock
+ */
+#include <linux/percpu.h>
+#include <linux/sched.h>
+#include <linux/osq_lock.h>
+#include "numa.h"
+#include "numa_osq.h"
+
+u16 osq_lock_depth =3D 8;
+u16 osq_keep_times =3D 32;
+
+/*
+ * An MCS like lock especially tailored for optimistic spinning for sleepi=
ng
+ * lock implementations (mutex, rwsem, etc).
+ *
+ * Using a single mcs node per CPU is safe because sleeping locks should n=
ot be
+ * called from interrupt context and we have preemption disabled while
+ * spinning.
+ */
+DECLARE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
+
+/*
+ * Get a stable @node->next pointer, either for unlock() or unqueue() purp=
oses.
+ * Can return NULL in case we were the last queued and we updated @lock in=
stead.
+ *
+ * If osq_lock() is being cancelled there must be a previous node
+ * and 'old_cpu' is its CPU #.
+ * For osq_unlock() there is never a previous node and old_cpu is
+ * set to OSQ_UNLOCKED_VAL.
+ */
+static inline struct optimistic_spin_node *
+osq_wait_next_stop(struct optimistic_spin_queue *lock,
+	      struct optimistic_spin_node *node,
+	      int old_cpu)
+{
+	u16 curr =3D encode_cpu(smp_processor_id());
+	u16 old =3D old_cpu;
+
+	if (lock->numa_enable =3D=3D OSQLOCKSTOPPING && old =3D=3D OSQ_UNLOCKED_V=
AL)
+		old =3D OSQ_LOCKED_VAL;
+
+	for (;;) {
+		if (READ_ONCE(lock->tail16) =3D=3D curr &&
+		    cmpxchg(&lock->tail16, curr, old) =3D=3D curr) {
+
+			/*
+			 * We were the last queued, we moved @lock back. @prev
+			 * will now observe @lock and will complete its
+			 * unlock()/unqueue().
+			 */
+			return NULL;
+		}
+
+		/*
+		 * We must xchg() the @node->next value, because if we were to
+		 * leave it in, a concurrent unlock()/unqueue() from
+		 * @node->next might complete Step-A and think its @prev is
+		 * still valid.
+		 *
+		 * If the concurrent unlock()/unqueue() wins the race, we'll
+		 * wait for either @lock to point to us, through its Step-B, or
+		 * wait for a new @node->next from its Step-C.
+		 */
+		if (node->next) {
+			struct optimistic_spin_node *next;
+
+			next =3D xchg(&node->next, NULL);
+			if (next)
+				return next;
+		}
+
+		cpu_relax();
+	}
+}
+
+bool x_osq_lock(struct optimistic_spin_queue *lock)
+{
+	struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
+	struct optimistic_spin_node *prev, *next;
+	int cpu =3D smp_processor_id();
+	u16 curr =3D encode_cpu(cpu);
+	struct optimistic_spin_queue tail;
+	u16 old;
+
+	tail.val =3D READ_ONCE(lock->val);
+	if (unlikely(tail.numa_enable =3D=3D OSQLOCKSTOPPING)) {
+		zx_osq_turn_numa_waiting(lock);
+		return x_osq_lock(lock);
+	}
+
+	if (unlikely(tail.numa_enable =3D=3D NUMALOCKDYNAMIC)) {
+		struct _numa_lock *_numa_lock =3D NULL;
+		struct _numa_lock *node_lock =3D NULL;
+
+		_numa_lock =3D get_numa_lock(tail.index);
+		node_lock =3D (struct _numa_lock *) _numa_lock +
+					(cpu >> NUMASHIFT);
+
+		prefetch(node_lock);
+		return zx_numa_osq_lock(lock, _numa_lock);
+	}
+
+	node->locked =3D 0;
+	node->next =3D NULL;
+	node->cpu =3D curr;
+
+	/*
+	 * We need both ACQUIRE (pairs with corresponding RELEASE in
+	 * unlock() uncontended, or fastpath) and RELEASE (to publish
+	 * the node fields we just initialised) semantics when updating
+	 * the lock tail.
+	 */
+
+	if (likely(tail.numa_enable >=3D OSQTONUMADETECT)) {
+		struct optimistic_spin_queue ss;
+
+		while (1) {
+			ss.val =3D atomic_read(&lock->tail);
+			if (ss.tail16 =3D=3D OSQ_LOCKED_VAL) {
+				zx_osq_turn_numa_waiting(lock);
+				return x_osq_lock(lock);
+			}
+			if (cmpxchg(&lock->tail16, ss.tail16, curr)
+					=3D=3D ss.tail16) {
+				old =3D ss.tail16;
+				break;
+			}
+			cpu_relax();
+		}
+	} else
+		old =3D xchg(&lock->tail16, curr);
+
+	if (old =3D=3D OSQ_UNLOCKED_VAL) {
+		node->serial =3D 1;
+		return true;
+	}
+
+	prev =3D decode_cpu(old);
+	node->prev =3D prev;
+
+	node->serial =3D prev->serial + 1;
+	/*
+	 * osq_lock()			unqueue
+	 *
+	 * node->prev =3D prev		osq_wait_next()
+	 * WMB				MB
+	 * prev->next =3D node		next->prev =3D prev // unqueue-C
+	 *
+	 * Here 'node->prev' and 'next->prev' are the same variable and we need
+	 * to ensure these stores happen in-order to avoid corrupting the list.
+	 */
+	smp_wmb();
+
+	WRITE_ONCE(prev->next, node);
+
+	/*
+	 * Normally @prev is untouchable after the above store; because at that
+	 * moment unlock can proceed and wipe the node element from stack.
+	 *
+	 * However, since our nodes are static per-cpu storage, we're
+	 * guaranteed their existence -- this allows us to apply
+	 * cmpxchg in an attempt to undo our queueing.
+	 */
+
+	/*
+	 * Wait to acquire the lock or cancellation. Note that need_resched()
+	 * will come with an IPI, which will wake smp_cond_load_relaxed() if it
+	 * is implemented with a monitor-wait. vcpu_is_preempted() relies on
+	 * polling, be careful.
+	 */
+	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
+				  vcpu_is_preempted(node_cpu(node->prev))))
+		return true;
+
+	/* unqueue */
+	/*
+	 * Step - A  -- stabilize @prev
+	 *
+	 * Undo our @prev->next assignment; this will make @prev's
+	 * unlock()/unqueue() wait for a next pointer since @lock points to us
+	 * (or later).
+	 */
+
+	for (;;) {
+		/*
+		 * cpu_relax() below implies a compiler barrier which would
+		 * prevent this comparison being optimized away.
+		 */
+		if (data_race(prev->next) =3D=3D node &&
+		    cmpxchg(&prev->next, node, NULL) =3D=3D node)
+			break;
+
+		/*
+		 * We can only fail the cmpxchg() racing against an unlock(),
+		 * in which case we should observe @node->locked becoming
+		 * true.
+		 */
+		if (smp_load_acquire(&node->locked))
+			return true;
+
+		cpu_relax();
+
+		/*
+		 * Or we race against a concurrent unqueue()'s step-B, in which
+		 * case its step-C will write us a new @node->prev pointer.
+		 */
+		prev =3D READ_ONCE(node->prev);
+	}
+
+	/*
+	 * Step - B -- stabilize @next
+	 *
+	 * Similar to unlock(), wait for @node->next or move @lock from @node
+	 * back to @prev.
+	 */
+
+	next =3D osq_wait_next_stop(lock, node, prev->cpu);
+	if (!next)
+		return false;
+
+	/*
+	 * Step - C -- unlink
+	 *
+	 * @prev is stable because its still waiting for a new @prev->next
+	 * pointer, @next is stable because our @node->next pointer is NULL and
+	 * it will wait in Step-A.
+	 */
+
+	WRITE_ONCE(next->prev, prev);
+	WRITE_ONCE(prev->next, next);
+
+	return false;
+}
+
+
+
+void x_osq_unlock(struct optimistic_spin_queue *lock)
+{
+	struct optimistic_spin_node *node, *next;
+	int threadshold =3D osq_lock_depth;
+	int cpu =3D smp_processor_id();
+	u16 curr =3D encode_cpu(cpu);
+	int depth =3D 0;
+	u32 count =3D 0;
+
+	if (unlikely(lock->numa_enable =3D=3D NUMALOCKDYNAMIC)) {
+		struct _numa_lock *_numa_lock =3D get_numa_lock(lock->index);
+
+		prefetch((struct _numa_lock *) _numa_lock + (cpu >> NUMASHIFT));
+		return zx_numa_osq_unlock(lock, _numa_lock);
+	}
+	/*
+	 * Fast path for the uncontended case.
+	 */
+	if (unlikely(lock->numa_enable =3D=3D OSQTONUMADETECT)) {
+		struct optimistic_spin_node *node_last =3D NULL;
+		u16 tail =3D 0;
+
+		tail =3D cmpxchg(&lock->tail16, curr, OSQ_UNLOCKED_VAL);
+		if (tail =3D=3D curr)
+			return;
+
+		node =3D this_cpu_ptr(&osq_node);
+		node_last =3D decode_cpu(tail);
+		depth =3D node_last->serial - node->serial;
+		count =3D READ_ONCE(node->locked);
+		if (count > osq_keep_times && (dynamic_enable & 0x1))
+			zx_osq_lock_stopping(lock);
+	} else if (unlikely(lock->numa_enable =3D=3D OSQLOCKSTOPPING)) {
+		if (cmpxchg(&lock->tail16, curr, OSQ_LOCKED_VAL)
+					=3D=3D curr) {
+			zx_osq_numa_start(lock);
+			return;
+		}
+	} else {
+		struct optimistic_spin_queue t;
+
+		t.val =3D 0;
+		if (dynamic_enable & 0x1) {
+			if (atomic_read(&numa_count) < zx_numa_lock_total)
+				t.numa_enable =3D OSQTONUMADETECT;
+		}
+		if (t.numa_enable =3D=3D OSQTONUMADETECT) {
+			if (atomic_cmpxchg_release(&lock->tail, curr,
+				(t.val | OSQ_UNLOCKED_VAL)) =3D=3D curr)
+				return;
+		} else if (cmpxchg(&lock->tail16, curr,
+				OSQ_UNLOCKED_VAL) =3D=3D curr)
+			return;
+	}
+
+	/*
+	 * Second most likely case.
+	 */
+	node =3D this_cpu_ptr(&osq_node);
+	next =3D xchg(&node->next, NULL);
+	if (next) {
+		if (depth > threadshold)
+			WRITE_ONCE(next->locked, count + 1);
+		else
+			WRITE_ONCE(next->locked, 1);
+		return;
+	}
+
+	next =3D osq_wait_next_stop(lock, node, OSQ_UNLOCKED_VAL);
+	if (next) {
+		if (depth > threadshold)
+			WRITE_ONCE(next->locked, count + 1);
+		else
+			WRITE_ONCE(next->locked, 1);
+	}
+}
+
+bool x_osq_is_locked(struct optimistic_spin_queue *lock)
+{
+	struct optimistic_spin_queue val;
+
+	val.val =3D atomic_read(&lock->tail);
+	if (val.tail16 =3D=3D OSQ_UNLOCKED_VAL)
+		return false;
+
+	if (val.tail16 =3D=3D OSQ_LOCKED_VAL) {
+		if (val.numa_enable !=3D NUMALOCKDYNAMIC)
+			return true;
+		return zx_check_numa_dynamic_locked(ptrmask(lock),
+					get_numa_lock(val.index), 0);
+	}
+
+	return true;
+}
diff --git a/kernel/locking/zx_numa_osq.c b/kernel/locking/zx_numa_osq.c
new file mode 100644
index 000000000000..f4c3dba208d3
--- /dev/null
+++ b/kernel/locking/zx_numa_osq.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Dynamic numa-aware osq lock
+ * Author: LiYong <yongli-oc@zhaoxin.com>
+ *
+ */
+#include <linux/cpumask.h>
+#include <asm/byteorder.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/osq_lock.h>
+#include "numa.h"
+#include "numa_osq.h"
+
+int osq_node_max =3D 256;
+
+/*
+ * The pending bit spinning loop count.
+ * This heuristic is used to limit the number of lockword accesses
+ * made by atomic_cond_read_relaxed when waiting for the lock to
+ * transition out of the "=3D=3D _Q_PENDING_VAL" state. We don't spin
+ * indefinitely because there's no guarantee that we'll make forward
+ * progress.
+ */
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_cpu_=
node);
+
+/*
+ * We use the value 0 to represent "no CPU", thus the encoded value
+ * will be the CPU number incremented by 1.
+ */
+static inline int decode(int cpu_nr)
+{
+	return cpu_nr - 1;
+}
+
+static inline struct optimistic_spin_node *decode_curr(int encoded_cpu_val=
)
+{
+	int cpu_nr =3D decode(encoded_cpu_val);
+
+	return per_cpu_ptr(&osq_cpu_node, cpu_nr);
+}
+
+static int atomic64_cmpxchg_notequal(void *qslock, atomic_t *tail, int cur=
r)
+{
+	u64 ss =3D 0;
+	u32 addr =3D ptrmask(qslock);
+	u64 addrcurr =3D (((u64)addr) << 32) | curr;
+
+	while (1) {
+		ss =3D atomic64_read((atomic64_t *) tail);
+		if ((ss >> 32) !=3D addr)
+			return NUMA_LOCKED_VAL;
+		if ((ss & LOW32MASK) =3D=3D NUMA_LOCKED_VAL)
+			return NUMA_LOCKED_VAL;
+		if (atomic64_cmpxchg((atomic64_t *) tail, ss, addrcurr) =3D=3D ss)
+			return ss & LOW32MASK;
+		cpu_relax();
+	}
+}
+
+void zx_osq_lock_stopping(struct optimistic_spin_queue *lock)
+{
+	int s =3D 0;
+
+	s =3D zx_numa_lock_ptr_get(lock);
+	if (s < zx_numa_lock_total) {
+		numa_lock_init_data(zx_numa_entry[s].numa_ptr,
+			NUMACLUSTERS, NUMA_UNLOCKED_VAL,
+			ptrmask(lock));
+
+		WRITE_ONCE(lock->index, s);
+		zx_numa_entry[s].type =3D 1;
+		smp_mb();/*should set these before enable*/
+		prefetchw(&lock->numa_enable);
+		WRITE_ONCE(lock->numa_enable, OSQLOCKSTOPPING);
+	} else {
+		prefetchw(&lock->numa_enable);
+		WRITE_ONCE(lock->numa_enable, OSQLOCKINITED);
+	}
+}
+
+void zx_osq_numa_start(struct optimistic_spin_queue *lock)
+{
+	struct _numa_lock *_numa_lock =3D get_numa_lock(lock->index);
+
+	prefetchw(&lock->numa_enable);
+	WRITE_ONCE(lock->numa_enable, NUMALOCKDYNAMIC);
+	smp_mb(); /*should keep lock->numa_enable modified first*/
+	atomic_set(&_numa_lock->initlock, TURNTONUMAREADY);
+}
+
+
+void zx_osq_turn_numa_waiting(struct optimistic_spin_queue *lock)
+{
+	struct _numa_lock *_numa_lock =3D get_numa_lock(lock->index);
+
+	atomic_inc(&_numa_lock->pending);
+	while (1) {
+		int s =3D atomic_read(&_numa_lock->initlock);
+
+		if (s =3D=3D TURNTONUMAREADY)
+			break;
+		cpu_relax();
+		cpu_relax();
+		cpu_relax();
+		cpu_relax();
+
+	}
+	atomic_dec(&_numa_lock->pending);
+}
+
+
+
+
+static struct optimistic_spin_node *
+zx_numa_osq_wait_next(struct _numa_lock *lock,
+		struct optimistic_spin_node *node,
+		struct optimistic_spin_node *prev, int cpu)
+{
+	struct optimistic_spin_node *next =3D NULL;
+	int curr =3D encode_cpu(cpu);
+	int old;
+
+	old =3D prev ? prev->cpu : OSQ_UNLOCKED_VAL;
+	for (;;) {
+		if (atomic_read(&lock->tail) =3D=3D curr &&
+		    atomic_cmpxchg_acquire(&lock->tail, curr, old) =3D=3D curr) {
+
+			break;
+		}
+		if (node->next) {
+			next =3D xchg(&node->next, NULL);
+			if (next)
+				break;
+		}
+		cpu_relax();
+	}
+	return next;
+}
+static void zx_numa_turn_osq_waiting(struct optimistic_spin_queue *lock,
+			struct _numa_lock *_numa_lock)
+{
+	struct _numa_lock *numa_lock =3D _numa_lock + _numa_lock->numa_nodes;
+	int lockaddr =3D ptrmask(lock);
+	u64 s =3D 0;
+	struct optimistic_spin_queue tail;
+
+	tail.numa_enable =3D NUMALOCKDYNAMIC;
+	tail.index =3D lock->index;
+	tail.tail16 =3D OSQ_LOCKED_VAL;
+	while (1) {
+		cpu_relax(); cpu_relax(); cpu_relax(); cpu_relax();
+		s =3D atomic64_read((atomic64_t *) &numa_lock->tail);
+		if ((s >> 32) !=3D lockaddr)
+			break;
+		if ((s & LOW32MASK) =3D=3D NUMA_LOCKED_VAL)
+			break;
+	}
+	prefetchw(&lock->tail);
+	if (atomic_cmpxchg(&lock->tail, tail.val, OSQ_UNLOCKED_VAL)
+			=3D=3D tail.val) {
+		;
+	}
+
+}
+
+static int _zx_node_osq_lock_internal(struct optimistic_spin_queue *qslock=
,
+	struct optimistic_spin_node *node, struct optimistic_spin_node *prev,
+	struct _numa_lock *node_lock, int cpu, int *cur_status)
+{
+	struct optimistic_spin_node *next =3D NULL;
+
+	for (;;) {
+		struct optimistic_spin_node *node_prev =3D NULL;
+
+		if (prev->next =3D=3D node &&
+		    cmpxchg(&prev->next, node, NULL) =3D=3D node) {
+			break;
+		}
+		/*load locked first each time*/
+		*cur_status =3D smp_load_acquire(&node->locked);
+
+		if (*cur_status !=3D NODE_WAIT)
+			return 0; //goto NODE_UNLOCK;
+
+		cpu_relax();
+		node_prev =3D READ_ONCE(node->prev);
+		if (node_prev !=3D prev)
+			prev =3D node_prev;
+	}
+
+	next =3D zx_numa_osq_wait_next(node_lock, node, prev, cpu);
+	if (!next)
+		return -1;
+
+	WRITE_ONCE(next->prev, prev);
+	WRITE_ONCE(prev->next, next);
+
+	return -1;
+}
+
+static int _zx_node_osq_lock(struct optimistic_spin_queue *qslock,
+					struct _numa_lock *_numa_lock)
+{
+	struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_cpu_node);
+	struct optimistic_spin_node *prev =3D NULL;
+	int cpu =3D smp_processor_id();
+	int curr =3D encode_cpu(cpu);
+	int numa =3D cpu >> _numa_lock->shift;
+	struct _numa_lock *node_lock =3D _numa_lock + numa;
+	int cur_status =3D 0;
+	int old =3D 0;
+
+	node->locked =3D NODE_WAIT;
+	node->next =3D NULL;
+	node->cpu =3D curr;
+
+	old =3D atomic64_cmpxchg_notequal(qslock, &node_lock->tail, curr);
+
+	if (old =3D=3D NUMA_LOCKED_VAL) {
+		bool s =3D true;
+
+		zx_numa_turn_osq_waiting(qslock, _numa_lock);
+		s =3D osq_lock(qslock);
+		if (s =3D=3D true)
+			return 1;
+		else
+			return -1;
+	}
+
+	if (old =3D=3D 0) {
+		node->locked =3D COHORT_START;
+		return ACQUIRE_NUMALOCK;
+	}
+
+	prev =3D decode_curr(old);
+	node->prev =3D prev;
+
+	smp_mb(); /* make sure node set before set pre->next */
+
+	WRITE_ONCE(prev->next, node);
+
+	while ((cur_status =3D READ_ONCE(node->locked)) =3D=3D NODE_WAIT) {
+		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev))) {
+			int ddd =3D _zx_node_osq_lock_internal(qslock, node, prev,
+						node_lock, cpu, &cur_status);
+
+			if (cur_status !=3D NODE_WAIT)
+				goto NODE_UNLOCK;
+			if (ddd =3D=3D -1)
+				return -1;
+		}
+		cpu_relax();
+	}
+NODE_UNLOCK:
+	if (cur_status =3D=3D ACQUIRE_NUMALOCK)
+		node->locked =3D COHORT_START;
+	return cur_status;
+}
+static int _zx_numa_osq_lock(struct optimistic_spin_queue *qslock, int cpu=
,
+				struct _numa_lock *_numa_lock)
+{
+	int numacpu =3D cpu >> _numa_lock->shift;
+	int numacurr =3D encode_cpu(numacpu);
+
+	struct optimistic_spin_node *node =3D &(_numa_lock + numacpu)->osq_node;
+	struct _numa_lock *numa_lock =3D _numa_lock + _numa_lock->numa_nodes;
+	struct optimistic_spin_node *prevnode =3D NULL;
+	int prev =3D 0;
+
+	node->next =3D NULL;
+	node->locked =3D LOCK_NUMALOCK;
+	node->cpu =3D numacurr;
+
+	prev =3D atomic_xchg(&numa_lock->tail, numacurr);
+	if (prev =3D=3D 0) {
+		node->locked =3D UNLOCK_NUMALOCK;
+		return 0;
+	}
+
+	prevnode =3D &(_numa_lock + prev - 1)->osq_node;
+	node->prev =3D prevnode;
+	smp_mb(); /*node->prev should be set before next*/
+	WRITE_ONCE(prevnode->next, node);
+
+	while (READ_ONCE(node->locked) =3D=3D LOCK_NUMALOCK) {
+		cpu_relax();
+		cpu_relax();
+		cpu_relax();
+		cpu_relax();
+	}
+	return 0;
+}
+inline bool zx_numa_osq_lock(struct optimistic_spin_queue *qslock,
+		struct _numa_lock *_numa_lock)
+{
+	struct _numa_lock *node_lock =3D NULL;
+	int cpu =3D smp_processor_id();
+	int numa =3D cpu >> _numa_lock->shift;
+	int status =3D 0;
+
+	node_lock =3D _numa_lock + numa;
+
+	if (node_lock->stopping) {
+		zx_numa_turn_osq_waiting(qslock, _numa_lock);
+		return osq_lock(qslock);
+	}
+
+	status =3D _zx_node_osq_lock(qslock, _numa_lock);
+	if (status =3D=3D ACQUIRE_NUMALOCK)
+		status =3D _zx_numa_osq_lock(qslock, smp_processor_id(),
+				_numa_lock);
+
+	if (status =3D=3D -1)
+		return false;
+	return true;
+}
+
+static int atomic64_checktail_osq(struct optimistic_spin_queue *qslock,
+	struct _numa_lock *node_lock, int ctail)
+{
+	u64 addr =3D ((u64)ptrmask(qslock)) << 32;
+	u64 addrtail =3D addr | ctail;
+	u64 ss =3D 0;
+	bool mark;
+
+	ss =3D atomic64_read((atomic64_t *) &node_lock->tail);
+	if (node_lock->stopping =3D=3D 0)
+		mark =3D (ss =3D=3D addrtail &&
+			atomic64_cmpxchg_acquire(
+				(atomic64_t *) &node_lock->tail,
+				addrtail, addr|NUMA_UNLOCKED_VAL) =3D=3D addrtail);
+	else
+		mark =3D (ss =3D=3D addrtail &&
+			atomic64_cmpxchg_acquire(
+				(atomic64_t *) &node_lock->tail,
+				addrtail, NUMA_LOCKED_VAL) =3D=3D addrtail);
+	return mark;
+}
+
+static void node_lock_release(struct optimistic_spin_queue *qslock,
+		struct _numa_lock *node_lock, struct optimistic_spin_node *node,
+		int val, int cpu, int numa_end)
+{
+	struct optimistic_spin_node *next =3D NULL;
+	int curr =3D encode_cpu(cpu);
+
+	while (1) {
+		if (atomic64_checktail_osq(qslock, node_lock, curr)) {
+			if (qslock->numa_enable =3D=3D NUMALOCKDYNAMIC) {
+				int index =3D qslock->index;
+
+				if (numa_end =3D=3D OSQ_UNLOCKED_VAL &&
+					zx_numa_entry[index].idle =3D=3D 0) {
+					cmpxchg(&zx_numa_entry[index].idle,
+							0, 1);
+				}
+			}
+			return;
+		}
+		if (node->next) {
+			next =3D xchg(&node->next, NULL);
+			if (next) {
+				WRITE_ONCE(next->locked, val);
+				return;
+			}
+		}
+		cpu_relax();
+	}
+}
+
+static int numa_lock_release(struct optimistic_spin_queue *qslock,
+		struct _numa_lock *numa_lock,
+		struct optimistic_spin_node *node, int cpu)
+{
+	struct optimistic_spin_node *next =3D NULL;
+	int curr =3D cpu >> numa_lock->shift;
+	int numacurr =3D encode_cpu(curr);
+
+	while (1) {
+		if (atomic_read(&numa_lock->tail) =3D=3D numacurr &&
+		    atomic_cmpxchg_acquire(&numa_lock->tail, numacurr,
+					   OSQ_UNLOCKED_VAL) =3D=3D numacurr) {
+			return OSQ_UNLOCKED_VAL;
+		}
+
+		if (node->next) {
+			next =3D xchg(&node->next, NULL);
+			if (next) {
+				WRITE_ONCE(next->locked, UNLOCK_NUMALOCK);
+				return 1;
+			}
+		}
+		cpu_relax();
+	}
+}
+
+inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
+		 struct _numa_lock *_numa_lock)
+{
+	u32 cpu =3D  smp_processor_id();
+	struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_cpu_node);
+	int numa =3D cpu >> _numa_lock->shift;
+	struct _numa_lock *numa_lock =3D _numa_lock + _numa_lock->numa_nodes;
+	struct _numa_lock *node_lock =3D _numa_lock + numa;
+	struct optimistic_spin_node *numa_node =3D
+						&(_numa_lock + numa)->osq_node;
+	struct optimistic_spin_node *next =3D NULL;
+	int cur_count =3D 0;
+	int numa_end =3D 0;
+
+	cur_count =3D READ_ONCE(node->locked);
+
+	if (cur_count >=3D osq_node_max - 1) {
+		numa_end =3D numa_lock_release(qslock,
+				numa_lock, numa_node, cpu);
+		node_lock_release(qslock, node_lock, node,
+				ACQUIRE_NUMALOCK, cpu, numa_end);
+		return;
+	}
+
+	next =3D xchg(&node->next, NULL);
+	if (next) {
+		WRITE_ONCE(next->locked, cur_count + 1);
+		return;
+	}
+
+	numa_end =3D numa_lock_release(qslock, numa_lock, numa_node, cpu);
+	node_lock_release(qslock, node_lock, node, ACQUIRE_NUMALOCK,
+			cpu, numa_end);
+}
--=20
2.34.1


