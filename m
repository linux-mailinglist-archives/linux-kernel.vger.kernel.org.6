Return-Path: <linux-kernel+bounces-532421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A88A44D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2573A4275E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272121766A;
	Tue, 25 Feb 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BHrXhyu1"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C7DF59
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515121; cv=none; b=ZV0g+dGGbwXdKa8HWUZ6XVsB51uAI5jTM32olZMJbzvNCvsed3VvGEVgBXUhyotRUN/Lu1p1cNI3kBJ2bez8Rk/kdTSG4I6PNY5srVJZuR1Vz9mK51bJJM4Of4ew4R9iGAqGbI5CTzewi9CeJe2ZzC9mBHgrO7kjy7wjl/+EhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515121; c=relaxed/simple;
	bh=+AXwTOe1fNXbIfy3G6xxCA9w9PU2Jg87wXlnjFL4Nwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=symTVmTsGSG4c7vhDGGqIVwNap0YEgNmJhdonLZxilMl4CtmrHe8G9FdFB1XWjVmu7bfO292yrad3mTcbmY9aMvOrEs1mk2fnItTh0+88YGFNwsfE4ulpFRpeCqmhrxh8ArBoZYh1CFFWqB6FmU3U1RVxAJOsUvGtE5fgR+V20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BHrXhyu1; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1740515118;
	bh=+AXwTOe1fNXbIfy3G6xxCA9w9PU2Jg87wXlnjFL4Nwo=;
	h=From:To:Cc:Subject:Date:From;
	b=BHrXhyu1rjNdDlUJDPxKZw2bD2N/oT11iOJx7lkciF8OXG3RpxaqqstfjoQv72G7B
	 Gbt/yQCFQvmQ68P6p/8NY2WHZ4MOYpylotI3C/TD339d1YKPnnQCwRYS4pKje+JGPW
	 IRGc2NGowBieVrNS8QKeWasN4qpHKyJZisC9QtHE/5m2Fo46mIAuSHSYs87RY59S9n
	 jOjt5k2TSUogUK0Zjo5kXdjhvVZ6UeUCehNxCVx/SPczvIBT0XfZOJO1iQaoW6fMeL
	 KvpNojsCQxg3zfl34KOd5095dQZ6GnylFYkCfLja0sAOUuRUQrwaIUVdW2EinFuNub
	 L0xflUWTCrbtw==
Received: from laptop-mjeanson.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Z2TcZ0dhfzTxM;
	Tue, 25 Feb 2025 15:25:18 -0500 (EST)
From: Michael Jeanson <mjeanson@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] rseq: update kernel fields in lockstep with CONFIG_DEBUG_RSEQ
Date: Tue, 25 Feb 2025 15:24:46 -0500
Message-ID: <20250225202500.731245-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_DEBUG_RSEQ=y, an in-kernel copy of the read-only fields is
kept synchronized with the user-space fields. Ensure the updates are
done in lockstep in case we error out on a write to user-space.

Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rseq.c | 80 +++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 2cb16091ec0a..a7d81229eda0 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -78,24 +78,24 @@ static int rseq_validate_ro_fields(struct task_struct *t)
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
+#define rseq_unsafe_put_user(t, value, field, error_label)		\
+	do {								\
+		unsafe_put_user(value, &t->rseq->field, error_label);	\
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
+#define rseq_unsafe_put_user(t, value, field, error_label)		\
+	unsafe_put_user(value, &t->rseq->field, error_label)
 #endif
 
 /*
@@ -173,17 +173,18 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
-	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
-	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
-	unsafe_put_user(node_id, &rseq->node_id, efault_end);
-	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
+
+	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
+	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
+	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
+	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
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
 
@@ -195,6 +196,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
+	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
 	    mm_cid = 0;
 
@@ -202,38 +204,36 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
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
+	rseq_unsafe_put_user(t, cpu_id_start, cpu_id_start, efault_end);
+	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
+	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
+	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
 
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


