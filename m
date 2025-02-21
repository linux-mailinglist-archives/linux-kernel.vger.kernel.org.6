Return-Path: <linux-kernel+bounces-526497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C83A3FF7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D28916D668
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC42512DA;
	Fri, 21 Feb 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bCtL4Bf1"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995D1F03F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165258; cv=none; b=F11nx9EHpY+TMYIy+1+84VgJXiMNXBzdpPsQB6YpTL34vvpxsk7ZusU8SR94gx0yUKTr/0Wvhbub/0eZiYInUzJBEWD5dXYzw3CxQf+Wm3u2W1+DoynmLqXzk7+X9DhzO+Af+voucMUvhElm2TNqa7YP+anstzUUur/hN92HbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165258; c=relaxed/simple;
	bh=5bPUxY6tK5e4i8Befc9RDIZINH0161GA9EJpRJJhNh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdNxNRw5k3K+5OqBlbw1rLrIQ/561xSxZDvhvm1p+z9A0N71JQbaDuvhbUu5r+lBWGRiDMMOHUXe8ao4/b7ojXqLPfy0Crq/8JWK3ovWiw2p6PT6g7yNXODJaTKibquUQ7FAK+W1fD9eEQhxDk+HMaAd8rn6+6DrouD9z8fzmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bCtL4Bf1; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1740165247;
	bh=5bPUxY6tK5e4i8Befc9RDIZINH0161GA9EJpRJJhNh4=;
	h=From:To:Cc:Subject:Date:From;
	b=bCtL4Bf1xtH9mj6d/LjXe1AUTFSmSMyGqZyHsGKlDdRtGRMVTT2vvbJ2rwZzcxOFE
	 6iQVk9T6+nht4jm1y8JvyHerjVFjcOVkHNb74QlORYVOBr2Otra3bScSzyCA9EApj1
	 o3jv+anpGHY9pvLiVM7Acvmry8kEJJkwQOP71nPX03KkTCUp1tsBXdQN8yzQa0kJnv
	 CvoSp1gjkpWwf5OTpvTrlmBsyRau+V/iOowMlL8XjxYVPYKVbjpSwR1Ps4j36Ut0Bo
	 9oNOZNdEzMOuWrloVxrpDprbgsjAVhG5ZppbOwBwP1ZNVy+FW3F5DlR4reXcYCumzY
	 ykSxLD0ZiBTUg==
Received: from laptop-mjeanson.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Z00DH2qXKzb54;
	Fri, 21 Feb 2025 14:14:07 -0500 (EST)
From: Michael Jeanson <mjeanson@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rseq: update kernel fields in lockstep with CONFIG_DEBUG_RSEQ
Date: Fri, 21 Feb 2025 14:13:50 -0500
Message-ID: <20250221191401.464648-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_DEBUG_RSEQ an in-kernel copy of the read-only fields is
kept synchronized with the user-space fields. Ensure the updates
are done in lockstep in case we error out on a write to user-space.

Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rseq.c | 85 +++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 2cb16091ec0a..5bdb96944e1f 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -26,6 +26,11 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
+static struct rseq __user *rseq_user_fields(struct task_struct *t)
+{
+	return (struct rseq __user *) t->rseq;
+}
+
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)
 {
@@ -78,24 +83,24 @@ static int rseq_validate_ro_fields(struct task_struct *t)
 	return -EFAULT;
 }
 
-static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
-			       u32 node_id, u32 mm_cid)
-{
-	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
-	rseq_kernel_fields(t)->cpu_id = cpu_id;
-	rseq_kernel_fields(t)->node_id = node_id;
-	rseq_kernel_fields(t)->mm_cid = mm_cid;
-}
+/*
+ * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
+ * state.
+ */
+#define unsafe_rseq_set_field(t, field, value, error_label)		\
+	do {								\
+		unsafe_put_user(value, &rseq_user_fields(t)->field, error_label);	\
+		rseq_kernel_fields(t)->field = value;			\
+	} while (0)
+
 #else
 static int rseq_validate_ro_fields(struct task_struct *t)
 {
 	return 0;
 }
 
-static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
-			       u32 node_id, u32 mm_cid)
-{
-}
+#define unsafe_rseq_set_field(t, field, value, error_label)		\
+	unsafe_put_user(value, &rseq_user_fields(t)->field, error_label)
 #endif
 
 /*
@@ -173,17 +178,18 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
-	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
-	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
-	unsafe_put_user(node_id, &rseq->node_id, efault_end);
-	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
+
+	unsafe_rseq_set_field(t, cpu_id_start, cpu_id, efault_end);
+	unsafe_rseq_set_field(t, cpu_id, cpu_id, efault_end);
+	unsafe_rseq_set_field(t, node_id, node_id, efault_end);
+	unsafe_rseq_set_field(t, mm_cid, mm_cid, efault_end);
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
 	user_write_access_end();
-	rseq_set_ro_fields(t, cpu_id, cpu_id, node_id, mm_cid);
 	trace_rseq_update(t);
 	return 0;
 
@@ -195,6 +201,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
+	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
 	    mm_cid = 0;
 
@@ -202,38 +209,36 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 * Validate read-only rseq fields.
 	 */
 	if (rseq_validate_ro_fields(t))
-		return -EFAULT;
-	/*
-	 * Reset cpu_id_start to its initial state (0).
-	 */
-	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
-		return -EFAULT;
-	/*
-	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
-	 * in after unregistration can figure out that rseq needs to be
-	 * registered again.
-	 */
-	if (put_user(cpu_id, &t->rseq->cpu_id))
-		return -EFAULT;
-	/*
-	 * Reset node_id to its initial state (0).
-	 */
-	if (put_user(node_id, &t->rseq->node_id))
-		return -EFAULT;
+		goto efault;
+
+	if (!user_write_access_begin(rseq, t->rseq_len))
+		goto efault;
+
 	/*
-	 * Reset mm_cid to its initial state (0).
+	 * Reset all fields to their initial state.
+	 *
+	 * All fields have an initial state of 0 except cpu_id which is set to
+	 * RSEQ_CPU_ID_UNINITIALIZED, so that any user coming in after
+	 * unregistration can figure out that rseq needs to be registered
+	 * again.
 	 */
-	if (put_user(mm_cid, &t->rseq->mm_cid))
-		return -EFAULT;
-
-	rseq_set_ro_fields(t, cpu_id_start, cpu_id, node_id, mm_cid);
+	unsafe_rseq_set_field(t, cpu_id_start, cpu_id_start, efault_end);
+	unsafe_rseq_set_field(t, cpu_id, cpu_id, efault_end);
+	unsafe_rseq_set_field(t, node_id, node_id, efault_end);
+	unsafe_rseq_set_field(t, mm_cid, mm_cid, efault_end);
 
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
+	user_write_access_end();
 	return 0;
+
+efault_end:
+	user_write_access_end();
+efault:
+	return -EFAULT;
 }
 
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
-- 
2.43.0


