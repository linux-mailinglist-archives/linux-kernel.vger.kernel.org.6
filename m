Return-Path: <linux-kernel+bounces-406190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A169C5BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715051F22CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDB2200CB3;
	Tue, 12 Nov 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NJt+aY49"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B351FDF9D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425402; cv=none; b=gh6DHmgboc4bpQcGqFy9O2JtwjOdd6pgpr4hiLvbHMR7fKLfFf+Nh/JFSFYDKUOx4mANcadYelHLquIxfCZqrdtT0qxbBtwpom7dtrDOnRMju0/j1VMnE0/XJJ9Bkpyg85YHEb8KGbUSnegtJc+52bGsS2LwKKWahja/vDwNAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425402; c=relaxed/simple;
	bh=V//pXDUrXxtw0cD7yTV2zkIlIu/ftKOvvv/3KOLZbhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ek3jqPXxHo3CdyVzh1XEGG5iGgQ7Hkv6Pj4ok3Aof8/5PAXOrpFaMzv9airJt2rCOycOUj25H+EgIJ1SJVhQ/UXPSv7/t/Id7s6mS8DBTe3KBhKJWR0zrdoYzdMBn0u2ZcvwKDUbS++oheer3oFnXwJtzIzHqbfzfP5OBg3uze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NJt+aY49; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731425398;
	bh=V//pXDUrXxtw0cD7yTV2zkIlIu/ftKOvvv/3KOLZbhA=;
	h=From:To:Cc:Subject:Date:From;
	b=NJt+aY49O2GeSGy6vHTl/XGrVt7ozqEt434Q6V917x8FvraS028DUphfquhWhIIrP
	 Lx48H5NdaQXUDpwSwZ9sJ6k3LMBV2y/hohvFMAfra9rXTdr4jG1PRjbjL0w4T9QH7J
	 kW3gv9KRzlKFrpEZIculz1IjU0D+vcP7gYJzAuGJitdJ+a2ZELgfE5blm1Vv4tBr2P
	 0XGdMaQHie0wpNlbaFilrUvrxzAk/Wc6iWSgLOB+R62iQhoEbMBZAUnhe4iaUwiCGw
	 6pFx0qBEY3X5Wz6RLO7j5+NTX+1osMxHX9eadDLYi0nyzm4WSX8cLz2e1Zt2ePyplT
	 dMGzb3cw5xB6g==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xnr2F510mz18Rr;
	Tue, 12 Nov 2024 10:29:57 -0500 (EST)
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
Subject: [PATCH v2 1/1] rseq: Validate read-only fields under DEBUG_RSEQ config
Date: Tue, 12 Nov 2024 10:28:26 -0500
Message-Id: <20241112152826.2031532-1-mathieu.desnoyers@efficios.com>
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

Changes since v1:
- Include pr_warn ratelimit updates from Peter.
- Introduce rseq_set_ro_fields().
---
 include/linux/sched.h |  9 ++++
 kernel/rseq.c         | 98 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bb343136ddd0..7825a61775ab 100644
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
+	char				rseq_fields[sizeof(struct rseq)];
+# endif
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..e04bb30a2eb8 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -13,6 +13,7 @@
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 #include <linux/types.h>
+#include <linux/ratelimit.h>
 #include <asm/ptrace.h>
 
 #define CREATE_TRACE_POINTS
@@ -25,6 +26,78 @@
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
+	static DEFINE_RATELIMIT_STATE(_rs,
+				      DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
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
+	if ((cpu_id_start != rseq_kernel_fields(t)->cpu_id_start ||
+	    cpu_id != rseq_kernel_fields(t)->cpu_id ||
+	    node_id != rseq_kernel_fields(t)->node_id ||
+	    mm_cid != rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
+
+		pr_warn("Detected rseq corruption for pid: %d, name: %s\n"
+			"\tcpu_id_start: %u ?= %u\n"
+			"\tcpu_id:       %u ?= %u\n"
+			"\tnode_id:      %u ?= %u\n"
+			"\tmm_cid:       %u ?= %u\n",
+			t->pid, t->comm,
+			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
+			cpu_id, rseq_kernel_fields(t)->cpu_id,
+			node_id, rseq_kernel_fields(t)->node_id,
+			mm_cid, rseq_kernel_fields(t)->mm_cid);
+	}
+
+	/* For now, only print a console warning on mismatch. */
+	return 0;
+
+efault_end:
+	user_read_access_end();
+efault:
+	return -EFAULT;
+}
+
+static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
+			       u32 node_id, u32 mm_cid)
+{
+	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
+	rseq_kernel_fields(t)->cpu_id = cpu_id;
+	rseq_kernel_fields(t)->node_id = node_id;
+	rseq_kernel_fields(t)->mm_cid = mm_cid;
+}
+#else
+static int rseq_validate_ro_fields(struct task_struct *t)
+{
+	return 0;
+}
+
+static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
+			       u32 node_id, u32 mm_cid)
+{
+}
+#endif
+
 /*
  *
  * Restartable sequences are a lightweight interface that allows
@@ -92,6 +165,11 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
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
@@ -105,6 +183,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
 	user_write_access_end();
+	rseq_set_ro_fields(t, cpu_id, cpu_id, node_id, mm_cid);
 	trace_rseq_update(t);
 	return 0;
 
@@ -119,6 +198,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
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
@@ -141,6 +225,9 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(mm_cid, &t->rseq->mm_cid))
 		return -EFAULT;
+
+	rseq_set_ro_fields(t, cpu_id_start, cpu_id, node_id, mm_cid);
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -423,6 +510,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
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


