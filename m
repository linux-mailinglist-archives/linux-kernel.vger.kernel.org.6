Return-Path: <linux-kernel+bounces-557979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CDAA5E00E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5FA3A64DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196FB257426;
	Wed, 12 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9GLKYdM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xXQlNBe+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE179253B53
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792608; cv=none; b=fY4zGmPXBYs1joddhRzRg6xUmRWPTR91MXZfQmP/OphJjry8W0HLwXy03FsbEY9uJ9zSck2V/8lr7DnlV+4nkCADMwyGhC9A98w0CI1zy3qiAQmsFaA7hyM3kPl3vBQz231SoFQ7uSmUmk7ljxyel4I/rGfvev2mL5QZdLoigbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792608; c=relaxed/simple;
	bh=R3gHjKOYjiHI+nWj8KdJ6SDQDLV0UGcgUWWlLGdWqsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCTojFCVZyCqbVSTd11WhGOyoOd6D55pVq6zE6RFjeamntpHliVsuN5ubeJK4NhaFWTNyJ5gx8SyPbSvZ2lRqnobXEigiA/ud/6RyxXUsazugHCObcx1Jh9RUFauYcXfnYYeH+Ek7lsM59K9s0n+DctjNwJY6cH4Pc4XcJLKNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9GLKYdM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xXQlNBe+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfbVJC9+YYu7wzBs4EaJxNoG3If5jAkcHBmcz824GVc=;
	b=D9GLKYdMowU/RlIHnOlAP8dAJtuAXhDrWwbVKsBH9u7yKO7+2/2Runhj9vDR3Wo9V8TiNc
	wempx080+cW1QAki/2no3KtPiI3UVVDYGW3bnHeLp6qdDYJsVn8MNjhLV6g57XppmcEeX9
	/JjcJQEBzU7iJJlFAn8IcStRF5kKnIaGAZat/tTBCIjtU7wWahGKmxGccslSdrBIfT7Vwc
	5zbamEclRRBvVlmPK4cwHV3L+D73jRdwY9ICZ6OAfLAruDR23RBPfAtSP/F6Y88veuXSCI
	fKGZKNEppF1AgD3qC1F/uaaCzVBaO2HVykR5IJpLSZpF/4gh+RSba4bJcgInUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfbVJC9+YYu7wzBs4EaJxNoG3If5jAkcHBmcz824GVc=;
	b=xXQlNBe+Petp0yX2bFIFyQPlmU6nR0+KVai3j9AbUOKS+ClB+UEcouI5c0ciqsI6oFNaIn
	elU5RB75XR4HE8CQ==
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
Subject: [PATCH v10 07/21] futex: Add basic infrastructure for local task local hash.
Date: Wed, 12 Mar 2025 16:16:20 +0100
Message-ID: <20250312151634.2183278-8-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The futex hashmap is system wide and shared by random tasks. Each slot
is hashed based on its address and VMA. Due to randomized VMAs (and
memory allocations) the same logical lock (pointer) can end up in a
different hash bucket on each invocation of the application. This in
turn means that different applications may share a hash bucket on the
first invocation but not on the second an it is not always clear which
applications will be involved. This can result in high latency's to
acquire the futex_hash_bucket::lock especially if the lock owner is
limited to a CPU and not be effectively PI boosted.

Introduce a task local hash map. The hashmap can be allocated via
	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, 0)

The `0' argument allocates a default number of 16 slots, a higher number
can be specified if desired. The current upper limit is 131072.
The allocated hashmap is used by all threads within a process.
A thread can check if the private map has been allocated via
	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);

Which return the current number of slots.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h      | 20 ++++++++
 include/linux/mm_types.h   |  6 ++-
 include/uapi/linux/prctl.h |  5 ++
 kernel/fork.c              |  2 +
 kernel/futex/core.c        | 99 ++++++++++++++++++++++++++++++++++++--
 kernel/sys.c               |  4 ++
 6 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85c..943828db52234 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -77,6 +77,15 @@ void futex_exec_release(struct task_struct *tsk);
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3);
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
@@ -88,6 +97,17 @@ static inline long do_futex(u32 __user *uaddr, int op, u=
32 val,
 {
 	return -EINVAL;
 }
+static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3)
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
index 0234f14f2aa6b..769cd77364e2d 100644
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
@@ -937,7 +938,10 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
-
+#ifdef CONFIG_FUTEX
+		unsigned int			futex_hash_mask;
+		struct futex_hash_bucket	*futex_hash_bucket;
+#endif
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5c6080680cb27..55b843644c51a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,9 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
=20
+/* FUTEX hash management */
+#define PR_FUTEX_HASH			77
+# define PR_FUTEX_HASH_SET_SLOTS	1
+# define PR_FUTEX_HASH_GET_SLOTS	2
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index e27fe5d5a15c9..95d48dbc90934 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1287,6 +1287,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
+	futex_mm_init(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLO=
CKS)
 	mm->pmd_huge_pte =3D NULL;
 #endif
@@ -1364,6 +1365,7 @@ static inline void __mmput(struct mm_struct *mm)
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
+	futex_hash_free(mm);
 	mmdrop(mm);
 }
=20
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index c6c5cde78e0cb..1feb7092635d0 100644
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
 struct futex_hash_bucket *__futex_hash(union futex_key *key)
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
 	return &futex_queues[hash & futex_hashmask];
 }
=20
@@ -1129,6 +1152,76 @@ static void futex_hash_bucket_init(struct futex_hash=
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
+	if (hash_slots =3D=3D 0)
+		hash_slots =3D 16;
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
+	return futex_hash_allocate(0);
+}
+
+static int futex_hash_get_slots(void)
+{
+	if (current->mm->futex_hash_bucket)
+		return current->mm->futex_hash_mask + 1;
+	return 0;
+}
+
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3)
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
 	unsigned long hashsize, i;
diff --git a/kernel/sys.c b/kernel/sys.c
index cb366ff8703af..e509ad9795103 100644
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
@@ -2811,6 +2812,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, ar=
g2, unsigned long, arg3,
 			return -EINVAL;
 		error =3D arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_FUTEX_HASH:
+		error =3D futex_hash_prctl(arg2, arg3);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error =3D -EINVAL;
--=20
2.47.2


