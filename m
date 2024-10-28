Return-Path: <linux-kernel+bounces-384905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D473E9B2FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645A11F210CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CA1D958E;
	Mon, 28 Oct 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Os1mNJ49";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XiRmyz0X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4771D95AA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117974; cv=none; b=PwWIRQfo03yEGGXvAuO5RUkkbaQDpupxnn3X7RsZZI1U2rx2jkfL5a0dnX33Tjgmz5cH4kd7niV5HbWLq9anQfh8+PdSEDanffHuNTg3Ec/XgihM47a/dpGlI3Ii7qH/ou4Tr1MXLVUewFGjCaAnlzPROevnlAJvpnUFdJ9Xqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117974; c=relaxed/simple;
	bh=GDJFWglKeGAlkLsRllnwFDvntBAGxnxH7K5IBtlijRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5o6CymnwpZUdasTN3Ry6jxE3xk+Wv2KAQErDRXqepQ9JuSG3TCFO6u7dosSdtt95/MhECz5cyzZP6TqRcRB91sXp+h4nSkNbwZdFz5krLQLcmTYQmB4WN07Ke7cJn5HBUAMG08m4uTeBXihYGfUcHl+aZWSSxw7Ax4SwFeJd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Os1mNJ49; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XiRmyz0X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730117969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr/K1ud3LEQQNYRmQNSOFkLG2DMCqjIqeeSROXeSODM=;
	b=Os1mNJ49LJJsB+l2C16/ZpM0Ex3j3ntam63H90/6VnGEeeD48YiP+kJJrwYy8Vs3WlkZyu
	wA+Tp5MKMPjfcwma1N21Jn6cuJngR5aY+73jXNIpqNTNL5hzF8JM5gjmTsC/nDbg79PDuR
	JSY72o9D9ulkl6hsLMlPmSc/YDM5CyO2X+1uyPf/DLprNhBhms4E5jQxBABm80IkpE0q/V
	R7w2oPluKdiiPzCTEwfGvAsjuK0CABp2SQt6HzJDb2ISvbIRoA/cwU2rNPpUMOfvZ333Uq
	FP4WaiiR59iRzquo+rdFBU1im9ooREtMMdy9Ipdtuj7hlJZR9CgqIGclSKHQNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730117969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mr/K1ud3LEQQNYRmQNSOFkLG2DMCqjIqeeSROXeSODM=;
	b=XiRmyz0Xgte/RVsCr5uj3U8iw9+EnfKe2TLaFL0Cn4y3hXXzf0DHiNBzD+ue3EVYkyPkil
	hkcfYBLnBrb/dzCA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH v2 2/4] futex: Add basic infrastructure for local task local hash.
Date: Mon, 28 Oct 2024 13:13:56 +0100
Message-ID: <20241028121921.1264150-3-bigeasy@linutronix.de>
In-Reply-To: <20241028121921.1264150-1-bigeasy@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
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
	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_ALLOCATE, 0)

The `0' argument allocates a default number of 4 slots, a higher number
can be specified if desired. The current uppoer limit is 16.
The allocated hashmap is used by all threads within a process.
A thread can check if the private map has been allocated via
	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_IS_SHARED);

Which return the current number of slots.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h        |  7 ++++
 include/linux/sched/signal.h |  4 +++
 include/uapi/linux/prctl.h   |  5 +++
 kernel/fork.c                |  1 +
 kernel/futex/core.c          | 65 ++++++++++++++++++++++++++++++++++++
 kernel/sys.c                 |  4 +++
 6 files changed, 86 insertions(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85c..dad50173f70c4 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -77,6 +77,8 @@ void futex_exec_release(struct task_struct *tsk);
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
+		     unsigned long arg4, unsigned long arg5);
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
@@ -88,6 +90,11 @@ static inline long do_futex(u32 __user *uaddr, int op, u=
32 val,
 {
 	return -EINVAL;
 }
+static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
+				   unsigned long arg4, unsigned long arg5)
+{
+	return -EINVAL;
+}
 #endif
=20
 #endif
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index c8ed09ac29ac5..3b8c8975cd493 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -14,6 +14,8 @@
 #include <linux/mm_types.h>
 #include <asm/ptrace.h>
=20
+struct futex_hash_bucket;
+
 /*
  * Types defining task->signal and task->sighand and APIs using them:
  */
@@ -246,6 +248,8 @@ struct signal_struct {
 						 * and may have inconsistent
 						 * permissions.
 						 */
+	unsigned int			futex_hash_mask;
+	struct futex_hash_bucket	*futex_hash_bucket;
 } __randomize_layout;
=20
 /*
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879b..e912ce82de41f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,9 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
=20
+/* FUTEX hash management */
+#define PR_FUTEX_HASH			74
+# define PR_FUTEX_HASH_ALLOCATE		1
+# define PR_FUTEX_HASH_IS_SHARED	2
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af25..0d2b0a5299bbc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -949,6 +949,7 @@ static inline void free_signal_struct(struct signal_str=
uct *sig)
 {
 	taskstats_tgid_free(sig);
 	sched_autogroup_exit(sig);
+	kfree(sig->futex_hash_bucket);
 	/*
 	 * __mmdrop is not safe to call from softirq context on x86 due to
 	 * pgd_dtor so postpone it to the async context
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index de6d7f71961eb..14e4cb5ccd722 100644
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
@@ -1153,6 +1154,70 @@ static void futex_hash_bucket_init(struct futex_hash=
_bucket *fhb)
 	spin_lock_init(&fhb->lock);
 }
=20
+static int futex_hash_allocate(unsigned long arg3, unsigned long arg4,
+			       unsigned long arg5)
+{
+	unsigned int hash_slots =3D arg3;
+	struct futex_hash_bucket *fhb;
+	int i;
+
+	if (!thread_group_leader(current))
+		return -EINVAL;
+
+	if (current->signal->futex_hash_bucket)
+		return -EALREADY;
+
+	if (hash_slots =3D=3D 0)
+		hash_slots =3D 4;
+	if (hash_slots < 2)
+		hash_slots =3D 2;
+	if (hash_slots > 16)
+		hash_slots =3D 16;
+	if (!is_power_of_2(hash_slots))
+		hash_slots =3D rounddown_pow_of_two(hash_slots);
+
+	fhb =3D kmalloc_array(hash_slots, sizeof(struct futex_hash_bucket), GFP_K=
ERNEL);
+	if (!fhb)
+		return -ENOMEM;
+
+	current->signal->futex_hash_mask =3D hash_slots - 1;
+
+	for (i =3D 0; i < hash_slots; i++)
+		futex_hash_bucket_init(&fhb[i]);
+
+	current->signal->futex_hash_bucket =3D fhb;
+	return 0;
+}
+
+static int futex_hash_is_shared(unsigned long arg3, unsigned long arg4,
+				unsigned long arg5)
+{
+	if (current->signal->futex_hash_bucket)
+		return current->signal->futex_hash_mask + 1;
+	return 0;
+}
+
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
+		     unsigned long arg4, unsigned long arg5)
+{
+	int ret;
+
+	switch (arg2) {
+	case PR_FUTEX_HASH_ALLOCATE:
+		ret =3D futex_hash_allocate(arg3, arg4, arg5);
+		break;
+
+	case PR_FUTEX_HASH_IS_SHARED:
+		ret =3D futex_hash_is_shared(arg3, arg4, arg5);
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


