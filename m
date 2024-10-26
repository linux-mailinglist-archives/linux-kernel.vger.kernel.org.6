Return-Path: <linux-kernel+bounces-383408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214249B1B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40901B2166C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA61D9359;
	Sat, 26 Oct 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0t51q6d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40fcCXJv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C051D54C2
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729982599; cv=none; b=LUUhLi20tolkOZQah9NpWTI5fhagGKFfVI+i6DvZTshYnvmu244TG9LKkfgROllH/xlYwOtEd1IpNx3QkGMQyeQQ5LKjVq+uez8y6vd6cvwUDr0khzh7EqhhlIG+GFKmmQ6xSoncXLrChykRrveoL0BYovxXlTkfbNeL6hJCntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729982599; c=relaxed/simple;
	bh=vhLxCWfVRnIlCW04lKP5OFNtIZcNlsW7/gQo720uVU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiESs44VTLI1c6NFYk1BrZWqZ+Q6LOs6EJ5e/NRhLCpNn6diUNi7sVvxYAIlbSUknrnIiaIQ3HfNlF2dEI/569Jqg6yBKyprMs4TvBnftFrqyrHnxxlUzvcHCaomAs/80N3aiTyVdzjkPXl2adovtUdZ4w3SVb2nts0zRmjqlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0t51q6d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40fcCXJv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729982595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtnyOmz1prCIFDsDlmDa4anKs9JZ0bnBOFrtP0vx7YQ=;
	b=e0t51q6dJd7hEQiBU3jqN9WXT+xczvWVoqe7s76ohGJEooHlw49H+cBEjPSnyfFreq5Ss7
	65dzP/Nci+OvC+457q+vdS6NGD+bSYwOVbyIS5fh0h71iAQQy8xbrqD46xH0zVRSxwr11O
	obSYhCCZ4CbGRQg9tDIch//wOkdj8C3No0kRQ00a5bQP9iVyA0lvm9vNW8G1x1hkkT4nez
	Tug4k+Q3OkvBQzVj3hgCCg063gD+Z+mmapLdZ5bmdG/jDRI4H+15nVvqQlryY3ipTqK2Vt
	lPCB9ZkU0HZnndZUARcxAdVZWGOOfTVzfbY4H1O7Hr6RN3t1R1CJI48VJZ2Pkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729982595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtnyOmz1prCIFDsDlmDa4anKs9JZ0bnBOFrtP0vx7YQ=;
	b=40fcCXJviJYw7eX/eZkzkT7lxs93q9Tgid7JmFD/1RYi98q4ode2leSbpYzuo95GUL2rb1
	XRk/rhsvZc1+QWDQ==
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
Subject: [RFC PATCH 2/3] futex: Add basic infrastructure for local task local hash.
Date: Sun, 27 Oct 2024 00:34:51 +0200
Message-ID: <20241026224306.982896-3-bigeasy@linutronix.de>
In-Reply-To: <20241026224306.982896-1-bigeasy@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
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
The hashmap can be shared with other threads within an application via
	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SHARE);

Once the shared hashmap is enabled, all threads must enable it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h      |   8 +++
 include/linux/sched.h      |   2 +
 include/uapi/linux/prctl.h |   5 ++
 kernel/futex/core.c        | 125 +++++++++++++++++++++++++++++++++++++
 kernel/sys.c               |   4 ++
 5 files changed, 144 insertions(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85c..e92cbea336e8e 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -69,6 +69,7 @@ static inline void futex_init_task(struct task_struct *ts=
k)
 	tsk->pi_state_cache =3D NULL;
 	tsk->futex_state =3D FUTEX_STATE_OK;
 	mutex_init(&tsk->futex_exit_mutex);
+	rcu_assign_pointer(tsk->futex_hash_table, NULL);
 }
=20
 void futex_exit_recursive(struct task_struct *tsk);
@@ -77,6 +78,8 @@ void futex_exec_release(struct task_struct *tsk);
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
+int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
+		     unsigned long arg4, unsigned long arg5);
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
@@ -88,6 +91,11 @@ static inline long do_futex(u32 __user *uaddr, int op, u=
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ade6417609002..8854c6029a9b4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -58,6 +58,7 @@ struct bpf_net_context;
 struct capture_control;
 struct cfs_rq;
 struct fs_struct;
+struct futex_hash_table;
 struct futex_pi_state;
 struct io_context;
 struct io_uring_task;
@@ -1281,6 +1282,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
+	struct futex_hash_table		*futex_hash_table;
 #ifdef CONFIG_COMPAT
 	struct compat_robust_list_head __user *compat_robust_list;
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879b..2475b128ba85d 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,9 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
=20
+/* FUTEX hash management */
+#define PR_FUTEX_HASH			74
+# define PR_FUTEX_HASH_ALLOCATE		1
+# define PR_FUTEX_HASH_SHARE		2
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index de6d7f71961eb..7c97fc96f84a3 100644
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
@@ -55,6 +56,12 @@ static struct {
 #define futex_queues   (__futex_data.queues)
 #define futex_hashsize (__futex_data.hashsize)
=20
+struct futex_hash_table {
+	unsigned int			slots;
+	int				users;
+	spinlock_t			lock;
+	struct  futex_hash_bucket	queues[];
+};
=20
 /*
  * Fault injections for futexes.
@@ -1040,6 +1047,9 @@ static inline void exit_pi_state_list(struct task_str=
uct *curr) { }
=20
 static void futex_cleanup(struct task_struct *tsk)
 {
+	struct futex_hash_table *fht;
+	bool need_free =3D false;
+
 	if (unlikely(tsk->robust_list)) {
 		exit_robust_list(tsk);
 		tsk->robust_list =3D NULL;
@@ -1054,6 +1064,23 @@ static void futex_cleanup(struct task_struct *tsk)
=20
 	if (unlikely(!list_empty(&tsk->pi_state_list)))
 		exit_pi_state_list(tsk);
+
+	rcu_read_lock();
+	fht =3D rcu_dereference(current->futex_hash_table);
+	if (fht) {
+
+		spin_lock(&fht->lock);
+		fht->users--;
+		WARN_ON_ONCE(fht->users < 0);
+		if (fht->users =3D=3D 0)
+			need_free =3D true;
+		spin_unlock(&fht->lock);
+		rcu_assign_pointer(current->futex_hash_table, NULL);
+	}
+	rcu_read_unlock();
+
+	if (need_free)
+		kfree_rcu_mightsleep(fht);
 }
=20
 /**
@@ -1153,6 +1180,104 @@ static void futex_hash_bucket_init(struct futex_has=
h_bucket *fhb)
 	spin_lock_init(&fhb->lock);
 }
=20
+static int futex_hash_allocate(unsigned long arg3, unsigned long arg4,
+			       unsigned long arg5)
+{
+	unsigned int hash_slots =3D arg3;
+	struct futex_hash_table *fht;
+	size_t struct_size;
+	int i;
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
+	if (current->futex_hash_table)
+		return -EALREADY;
+
+	struct_size =3D hash_slots * sizeof(struct futex_hash_bucket);
+	struct_size +=3D sizeof(struct futex_hash_table);
+	fht =3D kmalloc(struct_size, GFP_KERNEL);
+	if (!fht)
+		return -ENOMEM;
+
+	fht->slots =3D hash_slots;
+	fht->users =3D 1;
+	spin_lock_init(&fht->lock);
+
+	for (i =3D 0; i < hash_slots; i++)
+		futex_hash_bucket_init(&fht->queues[i]);
+
+	rcu_assign_pointer(current->futex_hash_table, fht);
+	return 0;
+}
+
+static int futex_hash_share(unsigned long arg3, unsigned long arg4,
+			    unsigned long arg5)
+{
+	struct futex_hash_table *fht;
+	struct task_struct *task;
+	pid_t task_pid;
+	int ret;
+
+	rcu_read_lock();
+	/* XXX maybe auto attach on fork() */
+	task_pid =3D task_tgid_vnr(current);
+	task =3D find_task_by_vpid(task_pid);
+	if (!task) {
+		ret =3D -ESRCH;
+		goto out;
+	}
+
+	fht =3D rcu_dereference(task->futex_hash_table);
+	if (!fht) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	spin_lock(&fht->lock);
+	if (fht->users <=3D 0) {
+		ret  =3D -EINVAL;
+		goto unlock_out;
+	}
+	fht->users++;
+
+	rcu_assign_pointer(current->futex_hash_table, fht);
+	ret =3D 0;
+
+unlock_out:
+	spin_unlock(&fht->lock);
+out:
+	rcu_read_unlock();
+	return ret;
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
+	case PR_FUTEX_HASH_SHARE:
+		ret =3D futex_hash_share(arg3, arg4, arg5);
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


