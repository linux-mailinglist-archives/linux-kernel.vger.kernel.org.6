Return-Path: <linux-kernel+bounces-404623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC35B9C45D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC96B222F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394301AB6DA;
	Mon, 11 Nov 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hED607/a"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901921A76CD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353322; cv=none; b=E6OufM/jiqe2Aw9ziNwKfWSflCEwoxAL7zbWFog9bynE6PE3BdqLXHPi6szevyiGLYt8aCG6jFYNZycmbqdIhwGqzKLZKzSI9D1/dZClLQ0wEs6E5ywx4JcFGveYo5N3G6qi1yRvELuDdL1dYCKpHYohronmk50GDzt3T6Yfz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353322; c=relaxed/simple;
	bh=u5XpHZob1QsIjrwVs1ylpobG7jCaNOzlajxCwqWob4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5Zbd5OUGDQVb7XRbHJuWQdYFcQeSLNSAaYFrlRelKCWMQw3lcwfY8Xvp49keWdg87p8b8gvW2VTPyRyg3Rk/ALcEZoZPOUiFbXZoiJ4FBTeCoxYGDvSH9tK1RtL39Rc9cYaFbfqlrdPaylI7hF6TFtf6sVImbTTeUJwPkYpgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hED607/a; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731353312;
	bh=u5XpHZob1QsIjrwVs1ylpobG7jCaNOzlajxCwqWob4w=;
	h=From:To:Cc:Subject:Date:From;
	b=hED607/aD5Wf8yQgJYoKoqj6tQG6nOD3v8FabMZLrsdirMazf662HpIxuc9ow/VZn
	 Y4jBOV02WfNTgzYxC3FsDmH5EIa4pU7ZWo41a2mUmCW+mXxY5LoFdM2Nxj7+MESpCq
	 G//qjRpkYf2cB5A84ciY93GJAiJyUiNm2RwD7C36MNJT6vloy1NP0hoD3IDK3POlf5
	 jGk4TtgMuO8pq7k9flDWYWip7lD8u0z/p/qVv5v65YYjRkQeiZsgkpj5scM7o14ba/
	 siADf1SB4Ypo/gS9/Vs85CshSdR2/lO4xdmruHmETTjCxcObNXhXR8YzsJjJxNE6j8
	 oNGpc/heIwt5A==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XnKN00tJlzwwT;
	Mon, 11 Nov 2024 14:28:32 -0500 (EST)
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
Subject: [PATCH v1 1/1] rseq: Validate read-only fields under DEBUG_RSEQ config
Date: Mon, 11 Nov 2024 14:22:14 -0500
Message-Id: <20241111192214.1988000-1-mathieu.desnoyers@efficios.com>
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
Changes since v0:
- Structure ending with a flexible array cannot be placed
  within another structure (if not last member). Fix this by
  declaring the kernel copy place holder as a char array instead.
---
 include/linux/sched.h |  9 +++++
 kernel/rseq.c         | 92 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bb343136ddd0..b7c42cea2aac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1364,6 +1364,15 @@ struct task_struct {
 	 * with respect to preemption.
 	 */
 	unsigned long rseq_event_mask;
+# ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * This is a place holder to save a copy of the rseq fields for
+	 * validation of read-only fields. The struct rseq has a
+	 * variable-length array at the end, so it cannot be used
+	 * directly. Reserve a size large enough for the known fields.
+	 */
+	char 				rseq_fields[sizeof(struct rseq)];
+# endif
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..c3be2e498891 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -25,6 +25,61 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
+#ifdef CONFIG_DEBUG_RSEQ
+static struct rseq *rseq_kernel_fields(struct task_struct *t)
+{
+	return (struct rseq *) t->rseq_fields;
+}
+
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
+	if (cpu_id_start != rseq_kernel_fields(t)->cpu_id_start)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq cpu_id_start field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start, t->pid);
+	if (cpu_id != rseq_kernel_fields(t)->cpu_id)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq cpu_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			cpu_id, rseq_kernel_fields(t)->cpu_id, t->pid);
+	if (node_id != rseq_kernel_fields(t)->node_id)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq node_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			node_id, rseq_kernel_fields(t)->node_id, t->pid);
+	if (mm_cid != rseq_kernel_fields(t)->mm_cid)
+		printk_ratelimited(KERN_WARNING
+			"Detected rseq mm_cid field corruption. Value: %u, expecting: %u (pid=%d).\n",
+			mm_cid, rseq_kernel_fields(t)->mm_cid, t->pid);
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
@@ -92,6 +147,11 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
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
@@ -105,6 +165,13 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
 	user_write_access_end();
+#ifdef CONFIG_DEBUG_RSEQ
+	/* Save a copy of the values which are read-only into kernel-space. */
+	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
+	rseq_kernel_fields(t)->cpu_id = cpu_id;
+	rseq_kernel_fields(t)->node_id = node_id;
+	rseq_kernel_fields(t)->mm_cid = mm_cid;
+#endif
 	trace_rseq_update(t);
 	return 0;
 
@@ -119,6 +186,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
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
@@ -141,6 +213,15 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(mm_cid, &t->rseq->mm_cid))
 		return -EFAULT;
+#ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * Reset the in-kernel rseq fields copy.
+	 */
+	rseq_kernel_fields(t)->cpu_id_start = cpu_id_start;
+	rseq_kernel_fields(t)->cpu_id = cpu_id;
+	rseq_kernel_fields(t)->node_id = node_id;
+	rseq_kernel_fields(t)->mm_cid = mm_cid;
+#endif
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -423,6 +504,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	current->rseq = rseq;
 	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
+#ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * Initialize the in-kernel rseq fields copy for validation of
+	 * read-only fields.
+	 */
+	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
+	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
+	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
+	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
+		return -EFAULT;
+#endif
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
-- 
2.39.5


