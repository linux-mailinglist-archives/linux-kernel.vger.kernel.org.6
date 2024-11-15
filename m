Return-Path: <linux-kernel+bounces-411083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E445A9CF352
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C525B43172
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D21D90DF;
	Fri, 15 Nov 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LSvhrEYH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TEkA5z9b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094B14A088
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691247; cv=none; b=cLD0/AKYCFoAgU1W2IaMj3lsL4zRGUhzlTfcUn+6eZPodGeTi1M9keR4yl7r4tjdyiY3Sr074nrXntymJfFCKQ4i8QH7hOyA/KiyNp9r0I9Vjdw0suGTK7XpBB3OiV2YCdCToG5UZ9Q5wloFK8n1QFLtNLg5/Shj211sh/U2R8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691247; c=relaxed/simple;
	bh=nQQQxnCsPJwoktUeagLS9DBMcP0e0q44VUVtsdV9pdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJf21xk/A3JzoYsaR+OOK/sRb02pr+98WpCRU440E3Avqw0zR6CrHOSyIsqjVylbcdzZnKnbhd5HhhJQmG+DZ/E1wBygrSt6TcrPlXaD6vYlegoQAbC+btbMsRPt3ooYXbxvat1GE/R/r0aBiijjHz52cFF8i4+Sxo504uX/Q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LSvhrEYH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TEkA5z9b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV7ViqGRPlSOuEQVPkYCiJqU4ia+4PXg5K8Jz4/iAvM=;
	b=LSvhrEYHs2hcaIhQzmfectuW+KWYh9ViDSpwK8L8Huc5A2etStWF3TC6TJhybhFfSFk+/e
	NjNy/Gj3xCccXPaEDG4X+hS5mn/AAn5SFFGBWGoTDTf16Zly4LgfI837oe0INxav4xdhx9
	wxh+LBSXOhV8w2ZZ+G6OVFfZLR/jdtZBHG8ak882/x9a/O9IK3tAu1ION7BZd2cOTUgrFY
	+J8F7R9ZBmy0C5NqErVTNv5GLCcQSDppabikaLauzqLyboLbfYobdKMn+6z+vfi/uO8il6
	TNzep5eptmpL5ecoeZNN1H0v6Y7Rkk3+fkzRZOgTm4ByopA+TuhE8mvIL0xo3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV7ViqGRPlSOuEQVPkYCiJqU4ia+4PXg5K8Jz4/iAvM=;
	b=TEkA5z9bRfjcVBUWC/3ApOOyhV51kH7Dbiye0rBm25axi2vo3fc4XCqICUHXtof3Drii23
	G8q2igTOotTtYYBg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH v3 2/9] futex: Add basic infrastructure for local task local hash.
Date: Fri, 15 Nov 2024 17:58:43 +0100
Message-ID: <20241115172035.795842-3-bigeasy@linutronix.de>
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The futex hashmap is system wide and shared by random tasks. Each slot
is hashed based on its address and VMA. Due to randomized VMAs the same
logical lock (pointer) can end up in a different hash bucket on each
invocation of the application. This in turn means that different
applications may share a hash bucket on each invocation and it is not
always clear which applications will be involved. This can result in
high latency's to acquire the futex_hash_bucket::lock especially if the
lock owner is limited to a CPU and not be effectively PI boosted.

Introduce a task local hash map. The hashmap can be allocated via
	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, 0)

The `0' argument allocates a default number of 4 slots, a higher number
can be specified if desired. The current uppoer limit is 128.
The allocated hashmap is used by all threads within a process.
A thread can check if the private map has been allocated via
	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);

Which return the current number of slots.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h      | 22 +++++++++
 include/linux/mm_types.h   |  3 ++
 include/uapi/linux/prctl.h |  5 ++
 kernel/fork.c              |  2 +
 kernel/futex/core.c        | 98 ++++++++++++++++++++++++++++++++++++--
 kernel/sys.c               |  4 ++
 6 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85c..61e81b866d34e 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -77,6 +77,16 @@ void futex_exec_release(struct task_struct *tsk);
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
+		     unsigned long arg4, unsigned long arg5);
+int futex_hash_allocate_default(void);
+void futex_hash_free(struct mm_struct *mm);
+
+static inline void futex_mm_init(struct mm_struct *mm)
+{
+	mm->futex_hash_bucket =3D NULL;
+}
+
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
@@ -88,6 +98,18 @@ static inline long do_futex(u32 __user *uaddr, int op, u=
32 val,
 {
 	return -EINVAL;
 }
+static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
+				   unsigned long arg4, unsigned long arg5)
+{
+	return -EINVAL;
+}
+static inline int futex_hash_allocate_default(void)
+{
+	return 0;
+}
+static inline void futex_hash_free(struct mm_struct *mm) { }
+static inline void futex_mm_init(struct mm_struct *mm) { }
+
 #endif
=20
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bca..2d25be28fa35f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -30,6 +30,7 @@
 #define INIT_PASID	0
=20
 struct address_space;
+struct futex_hash_bucket;
 struct mem_cgroup;
=20
 /*
@@ -898,6 +899,8 @@ struct mm_struct {
 		int mm_lock_seq;
 #endif
=20
+		unsigned int			futex_hash_mask;
+		struct futex_hash_bucket	*futex_hash_bucket;
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879b..2f45e2d291fe4 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,9 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
=20
+/* FUTEX hash management */
+#define PR_FUTEX_HASH			74
+# define PR_FUTEX_HASH_SET_SLOTS	1
+# define PR_FUTEX_HASH_GET_SLOTS	2
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 22f43721d031d..a83cf4d87ae57 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1279,6 +1279,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
+	futex_mm_init(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLO=
CKS)
 	mm->pmd_huge_pte =3D NULL;
 #endif
@@ -1356,6 +1357,7 @@ static inline void __mmput(struct mm_struct *mm)
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
+	futex_hash_free(mm);
 	mmdrop(mm);
 }
=20
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index de6d7f71961eb..2f5087fde57ef 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -39,6 +39,7 @@
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
+#include <linux/prctl.h>
=20
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -107,18 +108,40 @@ late_initcall(fail_futex_debugfs);
=20
 #endif /* CONFIG_FAIL_FUTEX */
=20
+static inline bool futex_key_is_private(union futex_key *key)
+{
+	/*
+	 * Relies on get_futex_key() to set either bit for shared
+	 * futexes -- see comment with union futex_key.
+	 */
+	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
+}
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
  *
  * We hash on the keys returned from get_futex_key (see below) and return =
the
- * corresponding hash bucket in the global hash.
+ * corresponding hash bucket in the global hash. If the FUTEX is private a=
nd
+ * a local hash table is privated then this one is used.
  */
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
-	u32 hash =3D jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
-			  key->both.offset);
+	struct futex_hash_bucket *fhb;
+	u32 hash;
=20
+	fhb =3D current->mm->futex_hash_bucket;
+	if (fhb && futex_key_is_private(key)) {
+		u32 hash_mask =3D current->mm->futex_hash_mask;
+
+		hash =3D jhash2((u32 *)key,
+			      offsetof(typeof(*key), both.offset) / 4,
+			      key->both.offset);
+		return &fhb[hash & hash_mask];
+	}
+	hash =3D jhash2((u32 *)key,
+		      offsetof(typeof(*key), both.offset) / 4,
+		      key->both.offset);
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
=20
@@ -1153,6 +1176,75 @@ static void futex_hash_bucket_init(struct futex_hash=
_bucket *fhb)
 	spin_lock_init(&fhb->lock);
 }
=20
+void futex_hash_free(struct mm_struct *mm)
+{
+	kvfree(mm->futex_hash_bucket);
+}
+
+static int futex_hash_allocate(unsigned int hash_slots)
+{
+	struct futex_hash_bucket *fhb;
+	int i;
+
+	if (current->mm->futex_hash_bucket)
+		return -EALREADY;
+
+	if (!thread_group_leader(current))
+		return -EINVAL;
+
+	if (hash_slots < 2)
+		hash_slots =3D 2;
+	if (hash_slots > 131072)
+		hash_slots =3D 131072;
+	if (!is_power_of_2(hash_slots))
+		hash_slots =3D rounddown_pow_of_two(hash_slots);
+
+	fhb =3D kvmalloc_array(hash_slots, sizeof(struct futex_hash_bucket), GFP_=
KERNEL_ACCOUNT);
+	if (!fhb)
+		return -ENOMEM;
+
+	current->mm->futex_hash_mask =3D hash_slots - 1;
+
+	for (i =3D 0; i < hash_slots; i++)
+		futex_hash_bucket_init(&fhb[i]);
+
+	current->mm->futex_hash_bucket =3D fhb;
+	return 0;
+}
+
+int futex_hash_allocate_default(void)
+{
+	return futex_hash_allocate(16);
+}
+
+static int futex_hash_get_slots(void)
+{
+	if (current->mm->futex_hash_bucket)
+		return current->mm->futex_hash_mask + 1;
+	return 0;
+}
+
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
+		     unsigned long arg4, unsigned long arg5)
+{
+	int ret;
+
+	switch (arg2) {
+	case PR_FUTEX_HASH_SET_SLOTS:
+		ret =3D futex_hash_allocate(arg3);
+		break;
+
+	case PR_FUTEX_HASH_GET_SLOTS:
+		ret =3D futex_hash_get_slots();
+		break;
+
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 static int __init futex_init(void)
 {
 	unsigned int futex_shift;
diff --git a/kernel/sys.c b/kernel/sys.c
index 4da31f28fda81..0dcbb8ce9f19d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -52,6 +52,7 @@
 #include <linux/user_namespace.h>
 #include <linux/time_namespace.h>
 #include <linux/binfmts.h>
+#include <linux/futex.h>
=20
 #include <linux/sched.h>
 #include <linux/sched/autogroup.h>
@@ -2784,6 +2785,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, ar=
g2, unsigned long, arg3,
 	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
 		error =3D RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
 		break;
+	case PR_FUTEX_HASH:
+		error =3D futex_hash_prctl(arg2, arg3, arg4, arg5);
+		break;
 	default:
 		error =3D -EINVAL;
 		break;
--=20
2.45.2


