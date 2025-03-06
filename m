Return-Path: <linux-kernel+bounces-549909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BBCA55872
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B56161497
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3553272930;
	Thu,  6 Mar 2025 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kNu06Iph"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262A2063EB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295567; cv=none; b=dAyoz+RqTpCAau9R9veFSi5sd8UEbLf6bhEn+9U0iOEzGxxLiE+1WDhCK6wkqG9Wd8H9ejBaRsmkqgGoFxnSX5MUQ3XTKTCPlNpdZ66gSy1Tbgu2BOwHYbSsJESCu82wUKxkqOZQefyW5pXvvRdATxU6rRM4kuLrf2y5vQ7ygaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295567; c=relaxed/simple;
	bh=K6680Ly+CdqgFKJLbqAIT6IRucFrKrGjh8KQm9SZ92A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9EGsry3vAPQE8aDHLkX9skIdNm6BoVvXp12SnA6gy1sH+TuiMOY0zCmZ55MaGovlrNNnann6M/CMd1rAIHSN7CdQGpCR4dAU+py0FWPV5W5yPUqF2arqXFMpJK1KzhBhSOvXEHYo535yB0Q3ELhYtpshs51iQlEJJeqX4+eZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kNu06Iph; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1741295558;
	bh=K6680Ly+CdqgFKJLbqAIT6IRucFrKrGjh8KQm9SZ92A=;
	h=From:To:Cc:Subject:Date:From;
	b=kNu06IphKE8N6+GXF28GsKFSEW5fWF+iJjn5ULwTsejHWyL+DlUwiM2llH3oldkcj
	 DcTAfzGYo6XCIBIh4r5Tl6eSEz3YjbpLpamAeGykRmIMQst+vzVKPBiHG0gnQqTA5T
	 zo3U0SAom3NH/gTcbblVQ3K9Oia3/6zkB1+wE5aHsxOFciDvgvCFNza75AjeY6czTU
	 w5aof1tyIXvb0fudKs0/YKFlts+4aYINj/Avqq6Hb9V7+4/6Er3piAhpMJ1Sj6bDBE
	 xztBmLIIzolR11ONdyWtzb85jc2Igt7gLf4IF6RxGNIeXJwCdGaBsbdPKoVFw831yt
	 Nwx9H+xoA/Quw==
Received: from laptop-mjeanson.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Z82F20sSBz1Tc3;
	Thu,  6 Mar 2025 16:12:38 -0500 (EST)
From: Michael Jeanson <mjeanson@efficios.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rseq: fix segfault on registration when rseq_cs is non-zero
Date: Thu,  6 Mar 2025 16:12:21 -0500
Message-ID: <20250306211223.109455-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rseq_cs field is documented as being set to 0 by user-space prior to
registration, however this is not currently enforced by the kernel. This
can result in a segfault on return to user-space if the value stored in
the rseq_cs field doesn't point to a valid struct rseq_cs.

The correct solution to this would be to fail the rseq registration when
the rseq_cs field is non-zero. However, some older versions of glibc
will reuse the rseq area of previous threads without clearing the
rseq_cs field and will also terminate the process if the rseq
registration fails in a secondary thread. This wasn't caught in testing
because in this case the leftover rseq_cs does point to a valid struct
rseq_cs.

What we can do is clear the rseq_cs field on registration when it's
non-zero which will prevent segfaults on registration and won't break
the glibc versions that reuse rseq areas on thread creation.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rseq.c | 60 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index a7d81229eda0..b7a1ec327e81 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -236,6 +236,29 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	return -EFAULT;
 }
 
+/*
+ * Get the user-space pointer value stored in the 'rseq_cs' field.
+ */
+static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
+{
+	if (!rseq_cs)
+		return -EFAULT;
+
+#ifdef CONFIG_64BIT
+	if (get_user(*rseq_cs, &rseq->rseq_cs))
+		return -EFAULT;
+#else
+	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
+		return -EFAULT;
+#endif
+
+	return 0;
+}
+
+/*
+ * If the rseq_cs field of 'struct rseq' contains a valid pointer to
+ * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
+ */
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
@@ -244,17 +267,16 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
 
-#ifdef CONFIG_64BIT
-	if (get_user(ptr, &t->rseq->rseq_cs))
-		return -EFAULT;
-#else
-	if (copy_from_user(&ptr, &t->rseq->rseq_cs, sizeof(ptr)))
-		return -EFAULT;
-#endif
+	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
+	if (ret)
+		return ret;
+
+	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
+	/* Check that the pointer value fits in the user-space process space. */
 	if (ptr >= TASK_SIZE)
 		return -EINVAL;
 	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
@@ -330,7 +352,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	return !!event_mask;
 }
 
-static int clear_rseq_cs(struct task_struct *t)
+static int clear_rseq_cs(struct rseq __user *rseq)
 {
 	/*
 	 * The rseq_cs field is set to NULL on preemption or signal
@@ -341,9 +363,9 @@ static int clear_rseq_cs(struct task_struct *t)
 	 * Set rseq_cs to NULL.
 	 */
 #ifdef CONFIG_64BIT
-	return put_user(0UL, &t->rseq->rseq_cs);
+	return put_user(0UL, &rseq->rseq_cs);
 #else
-	if (clear_user(&t->rseq->rseq_cs, sizeof(t->rseq->rseq_cs)))
+	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
 		return -EFAULT;
 	return 0;
 #endif
@@ -375,11 +397,11 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	 * Clear the rseq_cs pointer and return.
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
-		return clear_rseq_cs(t);
+		return clear_rseq_cs(t->rseq);
 	ret = rseq_need_restart(t, rseq_cs.flags);
 	if (ret <= 0)
 		return ret;
-	ret = clear_rseq_cs(t);
+	ret = clear_rseq_cs(t->rseq);
 	if (ret)
 		return ret;
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
@@ -453,6 +475,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		int, flags, u32, sig)
 {
 	int ret;
+	u64 rseq_cs;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -507,6 +530,19 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+
+	/*
+	 * If the rseq_cs pointer is non-NULL on registration, clear it to
+	 * avoid a potential segfault on return to user-space. The proper thing
+	 * to do would have been to fail the registration but this would break
+	 * older libcs that reuse the rseq area for new threads without
+	 * clearing the fields.
+	 */
+	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
+	        return -EFAULT;
+	if (rseq_cs && clear_rseq_cs(rseq))
+		return -EFAULT;
+
 #ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * Initialize the in-kernel rseq fields copy for validation of
-- 
2.39.5


