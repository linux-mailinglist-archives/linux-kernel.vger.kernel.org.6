Return-Path: <linux-kernel+bounces-372097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F69A446B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59EA5B2305E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CB126C18;
	Fri, 18 Oct 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jnpNuxV7"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184482036F7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271669; cv=none; b=LwTyUn8trDSZNr84QPqs8ui8d4O4H3pJJnZDjk0tbjVYFj9bu6cxVkhtB6OOJSSKCx7s1LMKIUreRivx870x55Eh9xuRfj2R9K3AKror900xVInmYCMeYEbaw9UU2mOgfzWJJf9ad4nGJ3d17YJh/CTlDaI5zCQU6DGH4tA0nLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271669; c=relaxed/simple;
	bh=v582Kv78CiKzfRFvXRSis7HJArZdJP5FYjzIkw7hJeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c3F4jylED19v/QkIF5HscKA1KnUu7JcF7DOYANBvAr2hSqHhJmK/NfhcCT6VpOuU+jbkn63lQXGp/3G0Tgfnp75b2Umbh68WRgZtrEM9pz6eIEkcmXdSGLr2fJdTlob96XOtIRhebLSMZ77oxP6rA5TzSR/UaTE2m+frFVCkPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jnpNuxV7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729271657;
	bh=v582Kv78CiKzfRFvXRSis7HJArZdJP5FYjzIkw7hJeY=;
	h=From:To:Cc:Subject:Date:From;
	b=jnpNuxV7Jyuri1Z14QVMVPjZVd0o924aR1aC4ov10vFMyNS0s1YmZsgQmLHdK9RQM
	 Zx5Y4IW/fxZgwu3rwiD7t7gYfW4yV6LLFGuuodyvjWZYc8QgffwqYAPdRDy2s6YXeD
	 fPlDdsKg4/IDe6lckm2NJYBPYUZfcqCMyuhXS58yRENOeOEHS9A5eAJmZPI5cZlIyh
	 W9eWZUozWcah+hTcyARHXf5moI1u6Q1qit5U63fwed2Ptt9Ra+e+NwtJHvfJIR8StZ
	 GlQQtYsVIJAvgiqV58GpGPE4MyR7Wf6AFPJxC+7gbmRX9SdyITuSfaL5NHyEWwFIDr
	 bF81KMyZvDUEg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XVWX86SHWzlGd;
	Fri, 18 Oct 2024 13:14:16 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Florian Weimer <fweimer@redhat.com>,
	Carlos O'Donell <carlos@redhat.com>,
	DJ Delorie <dj@redhat.com>,
	libc-alpha@sourceware.org
Subject: [RFC PATCH] rseq: Validate read-only fields under DEBUG_RSEQ config
Date: Fri, 18 Oct 2024 13:12:19 -0400
Message-Id: <20241018171219.256647-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rseq uapi requires cooperation between users of the rseq fields
to ensure that all libraries and applications using rseq within a
process do not interfere with each other.

This is especially important for fields which are meant to be read-only
from user-space, as documented in uapi/linux/rseq.h:

  - cpu_id_start,
  - cpu_id,
  - node_id,
  - mm_cid.

Storing to those fields from a user-space library prevents any sharing
of the rseq ABI with other libraries and applications, as other users
are not aware that the content of those fields has been altered by a
third-party library.

This is unfortunately the current behavior of tcmalloc: it purposefully
overlaps part of a cached value with the cpu_id_start upper bits to get
notified about preemption, because the kernel clears those upper bits
before returning to user-space. This behavior does not conform to the
rseq uapi header ABI.

This prevents tcmalloc from using rseq when rseq is registered by the
GNU C library 2.35+. It requires tcmalloc users to disable glibc rseq
registration with a glibc tunable, which is a sad state of affairs.

Considering that tcmalloc and the GNU C library are the two first
upstream projects using rseq, and that they are already incompatible due
to use of this hack, adding kernel-level validation of all read-only
fields content is necessary to ensure future users of rseq abide by the
rseq ABI requirements.

Validate that user-space does not corrupt the read-only fields and
conform to the rseq uapi header ABI when the kernel is built with
CONFIG_DEBUG_RSEQ=y. This is done by storing a copy of the read-only
fields in the task_struct, and validating the prior values present in
user-space before updating them. If the values do not match, print
a warning on the console (printk_ratelimited()).

This is a first step to identify misuses of the rseq ABI by printing
a warning on the console. After a giving some time to userspace to
correct its use of rseq, the plan is to eventually terminate offending
processes with SIGSEGV.

This change is expected to produce warnings for the upstream tcmalloc
implementation, but tcmalloc developers mentioned they were open to
adapt their implementation to kernel-level change.

Link: https://lore.kernel.org/all/CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com/
Link: https://github.com/google/tcmalloc/issues/144
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Oskolkov <posk@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: DJ Delorie <dj@redhat.com>
Cc: libc-alpha@sourceware.org
---
 include/linux/sched.h |  3 ++
 kernel/rseq.c         | 87 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..041b7cd96423 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1340,6 +1340,9 @@ struct task_struct {
 	 * with respect to preemption.
 	 */
 	unsigned long rseq_event_mask;
+# ifdef CONFIG_DEBUG_RSEQ
+	struct rseq			rseq_fields;
+# endif
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..46af9b0fe8a2 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -25,6 +25,56 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
+#ifdef CONFIG_DEBUG_RSEQ
+static int rseq_validate_ro_fields(struct task_struct *t)
+{
+	u32 cpu_id_start, cpu_id, node_id, mm_cid;
+	struct rseq __user *rseq = t->rseq;
+
+	/*
+	 * Validate fields which are required to be read-only by
+	 * user-space.
+	 */
+	if (!user_read_access_begin(rseq, t->rseq_len))
+		goto efault;
+	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
+	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
+	unsafe_get_user(node_id, &rseq->node_id, efault_end);
+	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
+	user_read_access_end();
+
+	if (cpu_id_start != t->rseq_fields.cpu_id_start)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq cpu_id_start field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			cpu_id_start, t->rseq_fields.cpu_id_start, t->pid);
+	if (cpu_id != t->rseq_fields.cpu_id)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq cpu_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			cpu_id, t->rseq_fields.cpu_id, t->pid);
+	if (node_id != t->rseq_fields.node_id)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq node_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			node_id, t->rseq_fields.node_id, t->pid);
+	if (mm_cid != t->rseq_fields.mm_cid)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq mm_cid field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			mm_cid, t->rseq_fields.mm_cid, t->pid);
+
+	/* For now, only print a console warning on mismatch. */
+	return 0;
+
+efault_end:
+	user_read_access_end();
+efault:
+	return -EFAULT;
+}
+#else
+static int rseq_validate_ro_fields(struct task_struct *t)
+{
+	return 0;
+}
+#endif
+
 /*
  *
  * Restartable sequences are a lightweight interface that allows
@@ -92,6 +142,11 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
 
+	/*
+	 * Validate read-only rseq fields.
+	 */
+	if (rseq_validate_ro_fields(t))
+		goto efault;
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
@@ -105,6 +160,13 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
 	user_write_access_end();
+#ifdef CONFIG_DEBUG_RSEQ
+	/* Save a copy of the values which are read-only into kernel-space. */
+	t->rseq_fields.cpu_id_start = cpu_id;
+	t->rseq_fields.cpu_id = cpu_id;
+	t->rseq_fields.node_id = node_id;
+	t->rseq_fields.mm_cid = mm_cid;
+#endif
 	trace_rseq_update(t);
 	return 0;
 
@@ -119,6 +181,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
 	    mm_cid = 0;
 
+	/*
+	 * Validate read-only rseq fields.
+	 */
+	if (!rseq_validate_ro_fields(t))
+		return -EFAULT;
 	/*
 	 * Reset cpu_id_start to its initial state (0).
 	 */
@@ -141,6 +208,15 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(mm_cid, &t->rseq->mm_cid))
 		return -EFAULT;
+#ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * Reset the in-kernel rseq fields copy.
+	 */
+	t->rseq_fields.cpu_id_start = cpu_id_start;
+	t->rseq_fields.cpu_id = cpu_id;
+	t->rseq_fields.node_id = node_id;
+	t->rseq_fields.mm_cid = mm_cid;
+#endif
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -423,6 +499,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	current->rseq = rseq;
 	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
+#ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * Initialize the in-kernel rseq fields copy for validation of
+	 * read-only fields.
+	 */
+	if (get_user(current->rseq_fields.cpu_id_start, &rseq->cpu_id_start) ||
+	    get_user(current->rseq_fields.cpu_id, &rseq->cpu_id) ||
+	    get_user(current->rseq_fields.node_id, &rseq->node_id) ||
+	    get_user(current->rseq_fields.mm_cid, &rseq->mm_cid))
+		return -EFAULT;
+#endif
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
-- 
2.39.5


