Return-Path: <linux-kernel+bounces-443403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD269EEF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F251896697
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193223E6FC;
	Thu, 12 Dec 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Tamm4X9R"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF123E6DA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019118; cv=none; b=pxFS8RbDnxrDSWchWsQcuvGQCPWQIeMWsl24L7Yku1olhuSxR3ILpNXrENv0AlfjxkHsFiWpjApfg6SOg7fa3DmPTeZxlyHU4R4827X6pKCXaiHwJNYk2NHePXZ2a178zc7li5yuM+MGIcY8pJcgp+Bdo0h3ktpn2bJFOWzJ9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019118; c=relaxed/simple;
	bh=zBd7T5NIB7hPfbFNSDI7driw6ROkkz34gb/RY0wBpY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y2tqHJMwxpa9TPzDCJAPre/46BF3t4kUEVmZmpcaQ1gICWm0QHlmI+EIhDomrPGUEcPX8KB/6VdzFbpjgBOROQdh4jHuWI7epoFwuHWg/EjpQcHpyEXcbRjCnDk3R2vbQxahidoTpE+bFupqAFL0Sw3kRBLiqC5Y0bdolAgAKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Tamm4X9R; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1734018587;
	bh=zBd7T5NIB7hPfbFNSDI7driw6ROkkz34gb/RY0wBpY8=;
	h=From:To:Cc:Subject:Date:From;
	b=Tamm4X9R/C9DxvSVzG43R5KeZIwLyhKonLyjBSrZ0uoNGQZigr3Hz/qmCB0uIruB7
	 c9fxHG5ZISmQlLQlQhK5xkRDJw7Hk1egmRxDSjD+q5UM2eY4a6APE4+nlMQskfB55i
	 hAa8Y6SMmmS8O08wyEFdh7OrfpEwE9UKeCDzrGOnil4IQ5TB1BLe1NMGLzpnz/fKx6
	 kxVPLQ5+AJiTGYoDuzo9cRpiFoUZYyiKx3eASTDRtr9I/vhIJgidbOS3Wk3/dePSJf
	 fFGy18dAjpfi6dpkp/iXpupH+tNTwl4nCpwH/s77j1r/5s0+erSPrFxuAY8HYcfIjI
	 jWT6Pv4e1xriQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Y8H3H4VXczVVJ;
	Thu, 12 Dec 2024 10:49:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] sched: Compact RSEQ concurrency IDs with reduced threads and affinity
Date: Thu, 12 Dec 2024 10:49:43 -0500
Message-Id: <20241212154943.148632-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a process reduces its number of threads or clears bits in its CPU
affinity mask, the mm_cid allocation should eventually converge towards
smaller values.

However, the change introduced by:

commit 7e019dcc470f "sched: Improve cache locality of RSEQ concurrency
IDs for intermittent workloads"

adds a per-mm/CPU recent_cid which is never unset unless a thread
migrates.

This is a tradeoff between:

A) Preserving cache locality after a transition from many threads to few
   threads, or after reducing the hamming weight of the allowed CPU mask.

B) Making the mm_cid upper bounds wrt nr threads and allowed CPU mask
   easy to document and understand.

C) Allowing applications to eventually react to mm_cid compaction after
   reduction of the nr threads or allowed CPU mask, making the tracking
   of mm_cid compaction easier by shrinking it back towards 0 or not.

D) Making sure applications that periodically reduce and then increase
   again the nr threads or allowed CPU mask still benefit from good
   cache locality with mm_cid.

Introduce the following changes:

* After shrinking the number of threads or reducing the number of
  allowed CPUs, reduce the value of max_nr_cid so expansion of CID
  allocation will preserve cache locality if the number of threads or
  allowed CPUs increase again.

* Only re-use a recent_cid if it is within the max_nr_cid upper bound,
  else find the first available CID.

Fixes: 7e019dcc470f "sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads"
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/mm_types.h |  7 ++++---
 kernel/sched/sched.h     | 24 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..d56948a74254 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -843,10 +843,11 @@ struct mm_struct {
 		 */
 		unsigned int nr_cpus_allowed;
 		/**
-		 * @max_nr_cid: Maximum number of concurrency IDs allocated.
+		 * @max_nr_cid: Maximum number of allowed concurrency
+		 *              IDs allocated.
 		 *
-		 * Track the highest number of concurrency IDs allocated for the
-		 * mm.
+		 * Track the highest number of allowed concurrency IDs
+		 * allocated for the mm.
 		 */
 		atomic_t max_nr_cid;
 		/**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645f..7df01dc796dc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3657,10 +3657,27 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
 {
 	struct cpumask *cidmask = mm_cidmask(mm);
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid = __this_cpu_read(pcpu_cid->recent_cid);
+	int cid, max_nr_cid, allowed_max_nr_cid;
 
+	/*
+	 * After shrinking the number of threads or reducing the number
+	 * of allowed cpus, reduce the value of max_nr_cid so expansion
+	 * of cid allocation will preserve cache locality if the number
+	 * of threads or allowed cpus increase again.
+	 */
+	max_nr_cid = atomic_read(&mm->max_nr_cid);
+	while ((allowed_max_nr_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed), atomic_read(&mm->mm_users))),
+			max_nr_cid > allowed_max_nr_cid) {
+		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into max_nr_cid. */
+		if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, allowed_max_nr_cid)) {
+			max_nr_cid = allowed_max_nr_cid;
+			break;
+		}
+	}
 	/* Try to re-use recent cid. This improves cache locality. */
-	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
+	cid = __this_cpu_read(pcpu_cid->recent_cid);
+	if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
+	    !cpumask_test_and_set_cpu(cid, cidmask))
 		return cid;
 	/*
 	 * Expand cid allocation if the maximum number of concurrency
@@ -3668,8 +3685,9 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
 	 * and number of threads. Expanding cid allocation as much as
 	 * possible improves cache locality.
 	 */
-	cid = atomic_read(&mm->max_nr_cid);
+	cid = max_nr_cid;
 	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
+		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into cid. */
 		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
 			continue;
 		if (!cpumask_test_and_set_cpu(cid, cidmask))
-- 
2.39.5


