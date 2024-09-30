Return-Path: <linux-kernel+bounces-343478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB853989B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01DA1C21315
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5A156C6C;
	Mon, 30 Sep 2024 07:25:02 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774111547DE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681100; cv=none; b=cmDhoddAlqArY25XuunCLQMXQ3ivhcefltuyqe6rYsfmCCM8u6rU8Qaks+vxUiq9meXdA/Zm5H3/l0IQi2oz03UI5bRKGOwVhivmyTXBBJeXYlBSDvTh8QhByXcJOcTW75STj/r8W+pzvJuP0wR7r5jAzghpsrJx3y9RrpW7fWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681100; c=relaxed/simple;
	bh=Kvlndkv6kk1spb79//clXXqherHHgt0ZsgOV1iZv2Xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSoR40YHXTkq79IHX9JxTxi1PrgKo1cU6kE0GL4Ar7XPSpDAORSJayiEHdRhMdmlLCtVAQH19K2w3jR6bmVNCObzDSMfVWFmWX275qxjxLx++lwKuweV3E1eWL3EW/0C94aKVRKW1JvmniG7NqrccjiJoDpwS4RTPhrD93+MxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727681087-086e236b08040d0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id icbYHQtRPVxRk3OS (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 30 Sep 2024 15:24:47 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 15:24:46 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 15:24:46 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 30 Sep 2024 15:24:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 15:23:55 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH v2 3/3] locking/osq_lock: Turn from 2-byte osq_lock/unlock to numa lock/unlock.
Date: Mon, 30 Sep 2024 15:23:55 +0800
X-ASG-Orig-Subj: [PATCH v2 3/3] locking/osq_lock: Turn from 2-byte osq_lock/unlock to numa lock/unlock.
Message-ID: <20240930072355.2892-4-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930072355.2892-1-yongli-oc@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240930072355.2892-1-yongli-oc@zhaoxin.com>
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
X-Moderation-Data: 9/30/2024 3:24:44 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1727681087
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 44984
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131164
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

    According to the contention level, switches from osq_lock to
    numa-aware osq_lock.
    The numa.h is definition for numa-aware lock.
    The numa_osq.h is definition for osq to numa switching.
    The x_osq_lock.c is the crossing from two bytes osq lock to
    numa-aware lock.
    The zx_numa_osq.c lock is a two level osq_lock.
    zx_numa.c:
    The numa-aware lock kernel memory cache preparation, and a
    workqueue to turn numa-aware lock back to osq lock.
    The /proc interface. Enable dynamic switch by
    echo 1 > /proc/zx_numa_lock/dynamic_enable

    The new Makefile for dynamic numa-aware osq lock.

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 kernel/locking/Makefile      |   3 +
 kernel/locking/numa.h        |  90 ++++++
 kernel/locking/numa_osq.h    |  29 ++
 kernel/locking/x_osq_lock.c  | 371 ++++++++++++++++++++++++
 kernel/locking/zx_numa.c     | 540 +++++++++++++++++++++++++++++++++++
 kernel/locking/zx_numa_osq.c | 497 ++++++++++++++++++++++++++++++++
 6 files changed, 1530 insertions(+)
 create mode 100644 kernel/locking/numa.h
 create mode 100644 kernel/locking/numa_osq.h
 create mode 100644 kernel/locking/x_osq_lock.c
 create mode 100644 kernel/locking/zx_numa.c
 create mode 100644 kernel/locking/zx_numa_osq.c

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17b8..297bfad88fda 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -21,7 +21,10 @@ ifeq ($(CONFIG_PROC_FS),y)
 obj-$(CONFIG_LOCKDEP) +=3D lockdep_proc.o
 endif
 obj-$(CONFIG_SMP) +=3D spinlock.o
+obj-$(CONFIG_LOCK_SPIN_ON_OWNER_NUMA) +=3D x_osq_lock.o zx_numa_osq.o zx_n=
uma.o
+else
 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) +=3D osq_lock.o
+endif
 obj-$(CONFIG_PROVE_LOCKING) +=3D spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) +=3D rtmutex_api.o
diff --git a/kernel/locking/numa.h b/kernel/locking/numa.h
new file mode 100644
index 000000000000..790c27ed18e5
--- /dev/null
+++ b/kernel/locking/numa.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_NUMA_LOCK_H
+#define __LINUX_NUMA_LOCK_H
+#include <linux/cache.h>
+#include "mcs_spinlock.h"
+
+struct optimistic_spin_node {
+	struct optimistic_spin_node *next, *prev;
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
+	CACHELINE_PADDING(pad);
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
+#define TURNTONUMAREADY 0xa
+
+#define NUMA_LOCKED_VAL 0xffffff
+#define NUMA_UNLOCKED_VAL 0
+
+#define HIGH32BITMASK 0xffffffff00000000
+#define LOW32MASK 0xffffffff
+
+extern int numa_shift;
+extern int numa_clusters;
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
ck);
+int zx_numa_lock_ptr_get(void *p);
+void numa_lock_init_data(struct _numa_lock *s, int clusters, u32 lockval,
+		u32 lockaddr);
+#endif
diff --git a/kernel/locking/numa_osq.h b/kernel/locking/numa_osq.h
new file mode 100644
index 000000000000..5c4675abc4fc
--- /dev/null
+++ b/kernel/locking/numa_osq.h
@@ -0,0 +1,29 @@
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
+inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
+		struct _numa_lock *n);
+inline bool zx_numa_osq_lock(struct optimistic_spin_queue *qslock,
+		struct _numa_lock *n);
+#endif
diff --git a/kernel/locking/x_osq_lock.c b/kernel/locking/x_osq_lock.c
new file mode 100644
index 000000000000..82cde1f6355b
--- /dev/null
+++ b/kernel/locking/x_osq_lock.c
@@ -0,0 +1,371 @@
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
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node=
);
+/*
+ * We use the value 0 to represent "no CPU", thus the encoded value
+ * will be the CPU number incremented by 1.
+ */
+inline int encode_cpu(int cpu_nr)
+{
+	return cpu_nr + 1;
+}
+
+inline int node_cpu(struct optimistic_spin_node *node)
+{
+	return node->cpu - 1;
+}
+
+inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
+{
+	int cpu_nr =3D encoded_cpu_val - 1;
+
+	return per_cpu_ptr(&osq_node, cpu_nr);
+}
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
+ * If the osq is in OSQLOCKSTOPPING state,
+ * the tail will be set to OSQ_LOCKED_VAL to stop the queue.
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
+bool osq_lock(struct optimistic_spin_queue *lock)
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
+		return osq_lock(lock);
+	}
+
+	if (unlikely(tail.numa_enable =3D=3D NUMALOCKDYNAMIC)) {
+		struct _numa_lock *_numa_lock =3D NULL;
+		struct _numa_lock *node_lock =3D NULL;
+
+		_numa_lock =3D get_numa_lock(tail.index);
+		node_lock =3D (struct _numa_lock *) _numa_lock +
+					(cpu >> numa_shift);
+
+		prefetch(node_lock);
+		return zx_numa_osq_lock(lock, _numa_lock);
+	}
+
+	node->locked =3D 0;
+	node->next =3D NULL;
+	node->cpu =3D curr;
+	node->serial =3D 0;
+
+	/*
+	 * if ss.tail16 is OSQ_LOCKED_VAL, keeps the LOCKED state
+	 * and waiting numa-aware lock ready.
+	 */
+
+	if (likely(tail.numa_enable >=3D OSQTONUMADETECT)) {
+		struct optimistic_spin_queue ss;
+
+		while (1) {
+			ss.val =3D atomic_read(&lock->tail);
+			if (ss.tail16 =3D=3D OSQ_LOCKED_VAL) {
+				zx_osq_turn_numa_waiting(lock);
+				return osq_lock(lock);
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
+	// Record osq serial number for the lock.
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
+/*
+ * In osq_unlock(), changes the osq state for switching, then unlock next.
+ * OSQTONUMADETECT: Starts to detect lock contention when first osq tail r=
eached
+ *	after dynamic enable.
+ * OSQLOCKSTOPPING: If lock contention keeps more than osq_lock_depth
+ *	osq_keep_times, set the osq to STOPPING state and get
+ *	numa-aware lock memory entry.
+ * NUMALOCKDYNAMIC: numa-aware lock initialized and ready.
+ */
+
+void osq_unlock(struct optimistic_spin_queue *lock)
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
+		prefetch((struct _numa_lock *) _numa_lock + (cpu >> numa_shift));
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
+		//Get the contention level
+		depth =3D node_last->serial - node->serial;
+		count =3D READ_ONCE(node->locked);
+		if (count > osq_keep_times && (dynamic_enable & 0x1))
+			zx_osq_lock_stopping(lock);
+	} else if (unlikely(lock->numa_enable =3D=3D OSQLOCKSTOPPING)) {
+		if (cmpxchg(&lock->tail16, curr, OSQ_LOCKED_VAL)
+					=3D=3D curr) {
+			//All osq stopped, start to run as numa-aware lock.
+			zx_osq_numa_start(lock);
+			return;
+		}
+	} else {
+		struct optimistic_spin_queue t;
+
+		/*
+		 * After dynamic enable, when osq reaches tail, set the osq
+		 * to DETECT mode to detect the contention.
+		 */
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
+bool osq_is_locked(struct optimistic_spin_queue *lock)
+{
+	struct optimistic_spin_queue val;
+
+	val.val =3D atomic_read(&lock->tail);
+	if (val.tail16 =3D=3D OSQ_UNLOCKED_VAL)
+		return false;
+
+	if (val.tail16 =3D=3D OSQ_LOCKED_VAL) {
+
+		//state changing
+		if (val.numa_enable !=3D NUMALOCKDYNAMIC)
+			return true;
+
+		return zx_check_numa_dynamic_locked(ptrmask(lock),
+					get_numa_lock(val.index));
+	}
+
+	return true;
+}
diff --git a/kernel/locking/zx_numa.c b/kernel/locking/zx_numa.c
new file mode 100644
index 000000000000..31d247261474
--- /dev/null
+++ b/kernel/locking/zx_numa.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Dynamic numa-aware osq lock
+ * Crossing from numa-aware lock to osq_lock
+ * Numa lock memory initialize and /proc interface
+ * Author: LiYong <yongli-oc@zhaoxin.com>
+ *
+ */
+#include <linux/cpumask.h>
+#include <asm/byteorder.h>
+#include <asm/kvm_para.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/osq_lock.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#include <linux/reboot.h>
+
+#include "numa.h"
+#include "numa_osq.h"
+
+int enable_zx_numa_osq_lock;
+struct delayed_work zx_numa_start_work;
+struct delayed_work zx_numa_cleanup_work;
+
+atomic_t numa_count;
+struct _numa_buf *zx_numa_entry;
+int zx_numa_lock_total =3D 256;
+LIST_HEAD(_zx_numa_head);
+LIST_HEAD(_zx_numa_lock_head);
+
+struct kmem_cache *zx_numa_entry_cachep;
+struct kmem_cache *zx_numa_lock_cachep;
+int numa_shift;
+int numa_clusters;
+static atomic_t lockindex;
+int dynamic_enable;
+
+static const struct numa_cpu_info numa_cpu_list[] =3D {
+	/*feature1=3D1, a numa node includes two clusters*/
+	//{1, 23, X86_VENDOR_AMD, 0, 1},
+	{0x5b, 7, X86_VENDOR_CENTAUR, 0, 1},
+	{0x5b, 7, X86_VENDOR_ZHAOXIN, 0, 1}
+};
+
+inline void *get_numa_lock(int index)
+{
+	if (index >=3D 0 && index < zx_numa_lock_total)
+		return zx_numa_entry[index].numa_ptr;
+	else
+		return NULL;
+}
+
+static int zx_get_numa_shift(int all_cpus, int clusters)
+{
+	int cpus =3D (int) all_cpus/clusters;
+	int count =3D 0;
+
+	while (cpus) {
+		cpus >>=3D 1;
+		count++;
+	}
+	return count-1;
+}
+
+void numa_lock_init_data(struct _numa_lock *s, int clusters,
+			u32 lockval, u32 lockaddr)
+{
+	int j =3D 0;
+
+	for (j =3D 0; j < clusters + NUMAEXPAND; j++) {
+		atomic_set(&(s + j)->tail, lockval);
+		atomic_set(&(s + j)->addr, lockaddr);
+		(s + j)->shift =3D numa_shift;
+		(s + j)->stopping =3D 0;
+		(s + j)->numa_nodes =3D clusters;
+		(s + j)->accessed =3D 0;
+		(s + j)->totalaccessed =3D 0;
+		(s + j)->nodeswitched =3D 0;
+		atomic_set(&(s + j)->initlock, 0);
+		atomic_set(&(s + j)->pending, 0);
+	}
+}
+/*
+ * The lockaddr of zx_numa_enry is key value to know which index is occupi=
ed.
+ */
+int zx_numa_lock_ptr_get(void *p)
+{
+	int i =3D 0;
+	int index =3D 0;
+
+	if (atomic_read(&numa_count) >=3D zx_numa_lock_total)
+		return zx_numa_lock_total;
+
+	index =3D atomic_inc_return(&lockindex);
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		if (index >=3D zx_numa_lock_total)
+			index =3D 0;
+		if (cmpxchg(&zx_numa_entry[index].lockaddr,
+					0, ptrmask(p)) =3D=3D 0) {
+			while (1) {
+				struct _numa_lock *node_lock =3D
+					zx_numa_entry[index].numa_ptr;
+				struct _numa_lock *numa_lock =3D node_lock +
+						node_lock->numa_nodes;
+
+				if (atomic_read(&numa_lock->tail) =3D=3D
+								NUMA_LOCKED_VAL)
+					break;
+				cpu_relax();
+
+			}
+			atomic_inc(&numa_count);
+			zx_numa_entry[index].highaddr =3D ((u64)p) >> 32;
+			atomic_set(&lockindex, index);
+			return index;
+		}
+		index++;
+		if (atomic_read(&numa_count) >=3D zx_numa_lock_total)
+			break;
+	}
+	return zx_numa_lock_total;
+}
+
+int zx_check_numa_dynamic_locked(u32 lockaddr,
+		struct _numa_lock *_numa_lock)
+{
+	struct _numa_lock *node_lock =3D NULL;
+	u64 s =3D -1;
+	int i =3D 0;
+
+	//in switching if the pending is not 0
+	if (atomic_read(&_numa_lock->pending) !=3D 0)
+		return 1;
+
+	for (i =3D 0; i < _numa_lock->numa_nodes + 1; i++) {
+		node_lock =3D _numa_lock + i;
+		cpu_relax();
+		s =3D atomic64_read((atomic64_t *) &node_lock->tail);
+		if ((s >> 32) !=3D lockaddr)
+			continue;
+		if ((s & LOW32MASK) =3D=3D NUMA_LOCKED_VAL
+				|| (s & LOW32MASK) =3D=3D NUMA_UNLOCKED_VAL)
+			continue;
+		break;
+	}
+
+	if (i =3D=3D _numa_lock->numa_nodes + 1)
+		return 0;
+	return i+1;
+}
+
+static int zx_numa_lock64_try_to_freeze(u32 lockaddr, struct _numa_lock *_=
numa_lock,
+			int index)
+{
+	struct _numa_lock *node_lock =3D NULL;
+	u64 addr =3D ((u64)lockaddr) << 32;
+	u64 s =3D 0;
+	u64 ff =3D 0;
+	int i =3D 0;
+
+	//check and set the tail to LOCKED from first node to last node,
+	//if, all node tail are LOCKED, try to set the NUMA node to LOCKED
+	for (i =3D 0; i < _numa_lock->numa_nodes+1; i++) {
+		node_lock =3D _numa_lock + i;
+		cpu_relax();
+
+		s =3D atomic64_read((atomic64_t *)&node_lock->tail);
+		if ((s & HIGH32BITMASK) !=3D addr)
+			continue;
+
+		if ((s & LOW32MASK) =3D=3D NUMA_LOCKED_VAL)
+			continue;
+
+		if ((s & LOW32MASK) =3D=3D NUMA_UNLOCKED_VAL) {
+			ff =3D atomic64_cmpxchg((atomic64_t *)&node_lock->tail,
+				(addr|NUMA_UNLOCKED_VAL), NUMA_LOCKED_VAL);
+			if (ff =3D=3D (addr|NUMA_UNLOCKED_VAL))
+				continue;
+		}
+		break;
+	}
+	//All node's tail and numa node's tail are LOCKED, set numa lock memory
+	//referenced by index to un-occupied.
+	if (i =3D=3D _numa_lock->numa_nodes + 1) {
+		zx_numa_entry[index].idle =3D 0;
+		zx_numa_entry[index].type =3D 0;
+		zx_numa_entry[index].highaddr =3D 0;
+		xchg(&zx_numa_entry[index].lockaddr, 0);
+	}
+
+	return i;
+}
+
+static void zx_numa_lock_stopping(struct _numa_lock *_numa_lock)
+{
+	struct _numa_lock *node_lock =3D NULL;
+	int i =3D 0;
+
+	for (i =3D 0; i < _numa_lock->numa_nodes+1; i++) {
+		node_lock =3D _numa_lock + i;
+		WRITE_ONCE(node_lock->stopping, 1);
+	}
+}
+
+static void zx_numa_cleanup(struct work_struct *work)
+{
+	int i =3D 0;
+	int checktimes =3D 2;
+
+	//reboot or power off state
+	if (READ_ONCE(enable_zx_numa_osq_lock) =3D=3D 0xf)
+		return;
+
+	//If dynamic enable and numa-aware lock count is 0, reschedule the
+	//workqueue.
+	if (atomic_read(&numa_count) =3D=3D 0) {
+		if (READ_ONCE(dynamic_enable) !=3D 0)
+			schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
+		return;
+	}
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		int s =3D 0;
+		u32 lockaddr =3D READ_ONCE(zx_numa_entry[i].lockaddr);
+		u32 type =3D zx_numa_entry[i].type;
+		struct _numa_lock *buf =3D  zx_numa_entry[i].numa_ptr;
+		int nodes =3D 0;
+
+		if (lockaddr =3D=3D 0 || type =3D=3D 3 || zx_numa_entry[i].idle =3D=3D 0=
)
+			continue;
+		nodes =3D buf->numa_nodes;
+		if (zx_numa_entry[i].idle < checktimes) {
+			//check if all node is idle
+			s =3D zx_check_numa_dynamic_locked(lockaddr, buf);
+			if (s !=3D 0) {
+				zx_numa_entry[i].idle =3D 1;
+				continue;
+			}
+			zx_numa_entry[i].idle++;
+		}
+
+		if (zx_numa_entry[i].idle =3D=3D checktimes) {
+			//set each node to stopping mode
+			zx_numa_lock_stopping(buf);
+			zx_numa_entry[i].idle++;
+
+		}
+
+		if (zx_numa_entry[i].idle =3D=3D checktimes+1) {
+			while (1) {
+				//try to freezed all nodes
+				if (zx_numa_lock64_try_to_freeze(lockaddr, buf,
+						i) =3D=3D nodes + 1) {
+					//all node has been locked
+					atomic_dec(&numa_count);
+					break;
+				}
+				cpu_relax();
+			}
+		}
+	}
+	schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
+}
+
+static int create_numa_buffer_list(int clusters, int len)
+{
+	int i =3D 0;
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		struct _numa_lock *s =3D (struct _numa_lock *)kmem_cache_alloc(
+				zx_numa_lock_cachep, GFP_KERNEL);
+		if (!s) {
+			while (i > 0) {
+				kmem_cache_free(zx_numa_lock_cachep,
+						zx_numa_entry[i-1].numa_ptr);
+				i--;
+			}
+			return 0;
+		}
+		memset((char *)s, 0,
+			len * L1_CACHE_BYTES * (clusters + NUMAEXPAND));
+		numa_lock_init_data(s, clusters, NUMA_LOCKED_VAL, 0);
+		zx_numa_entry[i].numa_ptr =3D s;
+		zx_numa_entry[i].lockaddr =3D 0;
+		zx_numa_entry[i].highaddr =3D 0;
+		zx_numa_entry[i].idle =3D 0;
+		zx_numa_entry[i].type =3D 0;
+	}
+
+	for (i =3D 0; i < zx_numa_lock_total; i++) {
+		zx_numa_entry[i].index =3D i;
+		list_add_tail(&(zx_numa_entry[i].list), &_zx_numa_lock_head);
+	}
+	return 1;
+}
+
+static int zx_numa_lock_init(int numa)
+{
+	int align =3D max_t(int, L1_CACHE_BYTES, ARCH_MIN_TASKALIGN);
+	int d =3D 0;
+	int status =3D 0;
+
+	atomic_set(&lockindex, 0);
+	atomic_set(&numa_count, 0);
+
+	if (sizeof(struct _numa_lock) & 0x3f)
+		d =3D (int)((sizeof(struct _numa_lock) + L1_CACHE_BYTES) /
+			  L1_CACHE_BYTES);
+	else
+		d =3D (int)(sizeof(struct _numa_lock) / L1_CACHE_BYTES);
+
+	zx_numa_entry_cachep =3D kmem_cache_create(
+		"zx_numa_entry",
+		sizeof(struct _numa_buf) * zx_numa_lock_total, align,
+		SLAB_PANIC | SLAB_ACCOUNT, NULL);
+
+	zx_numa_lock_cachep =3D kmem_cache_create(
+		"zx_numa_lock",
+		d * L1_CACHE_BYTES * (numa + NUMAEXPAND), align,
+		SLAB_PANIC | SLAB_ACCOUNT, NULL);
+
+
+	if (zx_numa_entry_cachep && zx_numa_lock_cachep) {
+		zx_numa_entry =3D (struct _numa_buf *)kmem_cache_alloc(
+				zx_numa_entry_cachep, GFP_KERNEL);
+		if (zx_numa_entry) {
+			memset((char *)zx_numa_entry, 0,
+				sizeof(struct _numa_buf) * zx_numa_lock_total);
+			create_numa_buffer_list(numa, d);
+			status =3D 1;
+		}
+	}
+
+	pr_info("enable dynamic numa-aware osq_lock, clusters %d\n",
+		numa);
+	return status;
+}
+
+
+#define numa_lock_proc_dir "zx_numa_lock"
+#define numa_entry_total 8
+struct proc_dir_entry *numa_lock_proc;
+struct proc_dir_entry *numa_lock_enable;
+struct proc_dir_entry *numa_proc_entry[numa_entry_total];
+
+static ssize_t numa_lock_proc_read(struct file *file,
+		char __user *usrbuf, size_t len, loff_t *off)
+{
+	int id =3D (long) pde_data(file_inode(file));
+	char kbuffer[128];
+	ssize_t retval =3D 0;
+	size_t n =3D 0;
+
+	memset(kbuffer, 0, sizeof(kbuffer));
+	if (id =3D=3D 0)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(dynamic_enable));
+	else if (id =3D=3D 1)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(osq_lock_depth));
+	else if (id =3D=3D 2)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(osq_keep_times));
+	else if (id =3D=3D 3)
+		n =3D sprintf(kbuffer, "%d\n", READ_ONCE(osq_node_max));
+	else if (id =3D=3D 4)
+		n =3D sprintf(kbuffer, "%d\n", atomic_read(&numa_count));
+	retval =3D simple_read_from_buffer(usrbuf, len, off, kbuffer, n);
+
+	return retval;
+}
+
+static ssize_t numa_lock_proc_write(struct file *file,
+		const char __user *buffer, size_t count, loff_t *f_pos)
+{
+	int id =3D (long) pde_data(file_inode(file));
+	char kbuffer[128];
+	unsigned long new =3D 0;
+	int err =3D 0;
+
+	memset(kbuffer, 0, sizeof(kbuffer));
+	if (copy_from_user(kbuffer, buffer, count))
+		return count;
+	kbuffer[count] =3D '\0';
+	err =3D kstrtoul(kbuffer, 10, &new);
+	if (err !=3D 0)
+		return count;
+
+	if (id =3D=3D 0) {
+		int last =3D READ_ONCE(dynamic_enable);
+
+		if (new < 0 || new >=3D 2 || last =3D=3D new)
+			return count;
+
+		if (last =3D=3D 0)
+			schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
+		prefetchw(&dynamic_enable);
+		WRITE_ONCE(dynamic_enable, new);
+		return count;
+	}
+
+	if (READ_ONCE(dynamic_enable) !=3D 0) {
+		pr_info("dynamic %d: change setting should disable dynamic\n",
+			dynamic_enable);
+		return count;
+	}
+	if (id =3D=3D 1 && new > 4 && new <=3D 32)
+		WRITE_ONCE(osq_lock_depth, new);
+	else if (id =3D=3D 2 && new >=3D 16 && new <=3D 2048)
+		WRITE_ONCE(osq_keep_times, new);
+	else if (id =3D=3D 3 && new > 4 && new <=3D 2048)
+		WRITE_ONCE(osq_node_max, new);
+	return count;
+}
+static int numa_lock_proc_show(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
+static int numa_lock_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, numa_lock_proc_show, NULL);
+}
+static const struct proc_ops numa_lock_proc_fops =3D {
+	.proc_open =3D numa_lock_proc_open,
+	.proc_read =3D numa_lock_proc_read,
+	.proc_write =3D numa_lock_proc_write
+};
+
+static int numalock_proc_init(void)
+{
+	int index =3D 0;
+	int i =3D 0;
+
+	numa_lock_proc =3D proc_mkdir(numa_lock_proc_dir, NULL);
+	if (numa_lock_proc =3D=3D NULL) {
+		pr_info("%s proc create %s failed\n", __func__,
+				numa_lock_proc_dir);
+		return -EINVAL;
+	}
+
+	numa_lock_enable =3D proc_create_data("dynamic_enable", 0666,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	if (!numa_lock_enable) {
+		pr_info("%s proc_create_data %s failed!\n", __func__,
+				"dynamic_enable");
+		return -ENOMEM;
+	}
+
+	for (i =3D 0; i < numa_entry_total; i++)
+		numa_proc_entry[i] =3D NULL;
+
+	numa_proc_entry[0] =3D  proc_create_data("osq_lock_depth", 0664,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	numa_proc_entry[1] =3D  proc_create_data("osq_keep_times", 0664,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	numa_proc_entry[2] =3D  proc_create_data("osq_node_max", 0664,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	numa_proc_entry[3] =3D  proc_create_data("numa_osq_lock", 0444,
+		numa_lock_proc, &numa_lock_proc_fops, (void *)(long)index++);
+	return 0;
+}
+
+static void numalock_proc_exit(void)
+{
+	int i =3D 0;
+
+	for (i =3D 0; i < numa_entry_total; i++) {
+		if (numa_proc_entry[i])
+			proc_remove(numa_proc_entry[i]);
+	}
+	if (numa_lock_enable)
+		proc_remove(numa_lock_enable);
+	if (numa_lock_proc)
+		remove_proc_entry(numa_lock_proc_dir, NULL);
+
+}
+
+static int numalock_shutdown_notify(struct notifier_block *unused1,
+		unsigned long unused2, void *unused3)
+{
+	if (READ_ONCE(enable_zx_numa_osq_lock) =3D=3D 1) {
+		WRITE_ONCE(dynamic_enable, 0);
+		WRITE_ONCE(enable_zx_numa_osq_lock, 0xf);
+	}
+	return NOTIFY_DONE;
+}
+static struct notifier_block numalock_shutdown_nb =3D {
+	.notifier_call =3D numalock_shutdown_notify,
+};
+static int __init zx_numa_base_init(void)
+{
+	int cpu =3D num_possible_cpus();
+	int i =3D 0;
+
+	WRITE_ONCE(enable_zx_numa_osq_lock, 0);
+	if (kvm_para_available())
+		return 0;
+	if (cpu >=3D 65534 || cpu < 16 || (cpu & 0x7) !=3D 0)
+		return 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(numa_cpu_list); i++) {
+		if (boot_cpu_data.x86_vendor =3D=3D numa_cpu_list[i].x86_vendor &&
+			boot_cpu_data.x86 =3D=3D numa_cpu_list[i].x86 &&
+			boot_cpu_data.x86_model =3D=3D numa_cpu_list[i].x86_model) {
+
+			if (numa_cpu_list[i].feature1 =3D=3D 1)
+				numa_clusters =3D nr_node_ids + nr_node_ids;
+			numa_shift =3D zx_get_numa_shift(num_possible_cpus(),
+					numa_clusters);
+
+			if (zx_numa_lock_init(numa_clusters) =3D=3D 0)
+				return -ENOMEM;
+			register_reboot_notifier(&numalock_shutdown_nb);
+			numalock_proc_init();
+			INIT_DELAYED_WORK(&zx_numa_cleanup_work,
+				zx_numa_cleanup);
+			prefetchw(&enable_zx_numa_osq_lock);
+			WRITE_ONCE(enable_zx_numa_osq_lock, 1);
+			return 0;
+		}
+	}
+	return 0;
+}
+
+static void __exit zx_numa_lock_exit(void)
+{
+	numalock_proc_exit();
+	prefetchw(&dynamic_enable);
+	WRITE_ONCE(dynamic_enable, 0);
+}
+
+late_initcall(zx_numa_base_init);
+module_exit(zx_numa_lock_exit);
+MODULE_AUTHOR("LiYong <yongli-oc@zhaoxin.com>");
+MODULE_DESCRIPTION("zx dynamic numa-aware osq lock");
+MODULE_LICENSE("GPL");
+
diff --git a/kernel/locking/zx_numa_osq.c b/kernel/locking/zx_numa_osq.c
new file mode 100644
index 000000000000..9fc329f33c36
--- /dev/null
+++ b/kernel/locking/zx_numa_osq.c
@@ -0,0 +1,497 @@
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
+/*
+ * Exchange the tail to get the last one in the queue.
+ * If the high 32 bits of tail is not equal to the osq lock addr, or
+ * the low 32 bits is NUMA_LOCKED_VAL, the queue is in LOCKED state.
+ */
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
+/*
+ * Get numa-aware lock memory and set the osq to STOPPING state.
+ * Look for the zx_numa_entry array, get a free one and set each node's ad=
dr
+ * to the address of the osq lock, then set the struct optimistic_spin_que=
ue's
+ * index to s.
+ *
+ * From the index, lock()/unlock() gets the position of struct _numa_lock,
+ * atomic check the struct _numa_lock's addr with the  struct optimistic_s=
pin_queue
+ * lock's address, equal means the link is valid. if the addr is not equal=
,
+ * the link is broken by the numa_cleanup workqueue since idle.
+ */
+void zx_osq_lock_stopping(struct optimistic_spin_queue *lock)
+{
+	int s =3D 0;
+
+	s =3D zx_numa_lock_ptr_get(lock);
+	if (s < zx_numa_lock_total) {
+		numa_lock_init_data(zx_numa_entry[s].numa_ptr,
+			numa_clusters, NUMA_UNLOCKED_VAL,
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
+/*
+ * Set numa_enable to NUMALOCKDYNAMIC to start by numa-aware lock,
+ * then set _numa_lock->initlock to TURNTONUMAREADY, breaks the
+ * loop of zx_osq_turn_numa_waiting.
+ */
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
+/*
+ * Waiting numa-aware lock ready
+ */
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
+
+	}
+	atomic_dec(&_numa_lock->pending);
+}
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
+/*
+ * If the numa_lock tail is in LOCKED state or the high 32 bits addr
+ * is not equal to the osq lock, the numa-aware lock is stopped, and
+ * break the loop to osq_lock()
+ * if not, exchange the tail to enqueue.
+ */
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
+		cpu_relax();
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
+		/*
+		 * cpu_relax() below implies a compiler barrier which would
+		 * prevent this comparison being optimized away.
+		 */
+		if (data_race(prev->next) =3D=3D node &&
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
+		/*
+		 * Or we race against a concurrent unqueue()'s step-B, in which
+		 * case its step-C will write us a new @node->prev pointer.
+		 */
+		node_prev =3D READ_ONCE(node->prev);
+		if (node_prev !=3D prev)
+			prev =3D node_prev;
+	}
+
+	/*
+	 * Step - B -- stabilize @next
+	 *
+	 * Similar to unlock(), wait for @node->next or move @lock from @node
+	 * back to @prev.
+	 */
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
+	while (READ_ONCE(node->locked) =3D=3D LOCK_NUMALOCK)
+		cpu_relax();
+
+	return 0;
+}
+/*
+ * Two level osq_lock
+ * Check current node's tail then check the numa tail, the queue goes to
+ * run or wait according the two tail's state.
+ */
+
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
+/*
+ * Check the end of the queue on current node.
+ * Keep the addr of the node_lock when set the queue to UNLOCKED.
+ * If the node is stopping, the node_lock will be set LOCKED.
+ */
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
+/*
+ * Set current node's tail to ACQUIRE_NUMALOCK to check the numa tail busy=
 or
+ * UNLOCKED
+ */
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
+				//starts numa_lock idle checking in cleanup workqueue.
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
+/*
+ * Unlocks the queue waiting on the next NUMA node
+ */
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
+/*
+ * Two level osq_unlock.
+ */
+inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
+		 struct _numa_lock *_numa_lock)
+{
+	u32 cpu =3D  smp_processor_id();
+	struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_cpu_node);
+	int numa =3D cpu >> _numa_lock->shift;
+	struct _numa_lock *numa_lock =3D _numa_lock + _numa_lock->numa_nodes;
+	struct _numa_lock *node_lock =3D _numa_lock + numa;
+	struct optimistic_spin_node *numa_node =3D
+			&(_numa_lock + numa)->osq_node;
+	struct optimistic_spin_node *next =3D NULL;
+	int cur_count =3D 0;
+	int numa_end =3D 0;
+
+	cur_count =3D READ_ONCE(node->locked);
+
+	/*
+	 * Turns to the queue waiting on the next node if unlocked times more
+	 * than osq_node_max on current node.
+	 */
+	if (cur_count >=3D osq_node_max - 1) {
+		//Unlocks the queue on next node.
+		numa_end =3D numa_lock_release(qslock,
+				numa_lock, numa_node, cpu);
+		node_lock_release(qslock, node_lock, node,
+				ACQUIRE_NUMALOCK, cpu, numa_end);
+		return;
+	}
+	/*
+	 * Unlocks the next on current node.
+	 */
+	next =3D xchg(&node->next, NULL);
+	if (next) {
+		WRITE_ONCE(next->locked, cur_count + 1);
+		return;
+	}
+	/*
+	 * The queue on current node reaches end.
+	 */
+	numa_end =3D numa_lock_release(qslock, numa_lock, numa_node, cpu);
+	node_lock_release(qslock, node_lock, node, ACQUIRE_NUMALOCK,
+			cpu, numa_end);
+}
--=20
2.34.1


