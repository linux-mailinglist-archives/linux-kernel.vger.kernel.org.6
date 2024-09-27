Return-Path: <linux-kernel+bounces-342279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685A988D0C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DDF2830F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAF11B85F1;
	Fri, 27 Sep 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMkHoKFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BB1B81BB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727480923; cv=none; b=tRYb06gpTU32HgE9JHio2/iCwF57nkvYibhj0tj2/mDT8kfUV/Rru4wAK1Cs2vfIRaInwVR4TeESPrVEAGPk2S6Fec8jz43UyqxKxMzImQy7Log96FAiPstLG++2j48pfADOQ9FfV5N28S5OJY4uX7Aut5NumTN4xsBdfjyHFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727480923; c=relaxed/simple;
	bh=JHiBsL6UpYqsaJnHMTg5W9XcS2pPO3KTsr52zVG7ooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox6agyMVhwJeawSX4525G2e5LI8GM02AyL4MA3sPoL9fBePEpOD/9e1zOChQus4y85Tg10a0zKLV19iDUrvNbkBVpSiSr9wqr70tepNRd2SdfVHkdEwVijUwf8ngokTTWqWKt8LXFOR6e1lAgp4GeG1LmHnWl59pbCNnbp/eJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMkHoKFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1174C4CECF;
	Fri, 27 Sep 2024 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727480923;
	bh=JHiBsL6UpYqsaJnHMTg5W9XcS2pPO3KTsr52zVG7ooo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMkHoKFNfQzoq24uj/QmyR2IegUwid/BKHyXSdu8yvPs8/5PD+2ZJijD0up9d8IYP
	 i78oyVmxauw1jzRUMWaFNDa6cFvUMF7Ro92aJlH5Bcl8km/bqMao9g6X86wlQg2rSx
	 U7ncbTfUYM1b1aeKoo3r4Q1od4qfsSEqTRqFG5H692+A4R5aOuL6b1z7QVHiRXLxtp
	 Nzsz12Xxvga28ew6wHNZUZdSFw3e5b9f1FXp2s1ZhuNv31R35mqqMPYiIgH510zp1x
	 6YYMQ5X1mGCl+ffhkz772bN2pfvwGqFRg2TLatTNEXaWkLEx/EZp9BWBaSo/87R7cY
	 sTEhD43ncTtaQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched/core: Add ENQUEUE_RQ_SELECTED to indicate whether ->select_task_rq() was called
Date: Fri, 27 Sep 2024 13:46:12 -1000
Message-ID: <20240927234838.152112-3-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927234838.152112-1-tj@kernel.org>
References: <20240927234838.152112-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During ttwu, ->select_task_rq() can be skipped if only one CPU is allowed or
migration is disabled. sched_ext schedulers may perform operations such as
direct dispatch from ->select_task_rq() path and it is useful for them to
know whether ->select_task_rq() was skipped in the ->enqueue_task() path.

Currently, sched_ext schedulers are using ENQUEUE_WAKEUP for this purpose
and end up assuming incorrectly that ->select_task_rq() was called for tasks
that are bound to a single CPU or migration disabled.

Make select_task_rq() indicate whether ->select_task_rq() was called by
setting WF_RQ_SELECTED in *wake_flags and make ttwu_do_activate() map that
to ENQUEUE_RQ_SELECTED for ->enqueue_task().

This will be used by sched_ext to fix ->select_task_rq() skip detection.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 8 ++++++--
 kernel/sched/sched.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e70b57a5693e..aeb595514461 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3522,10 +3522,12 @@ int select_task_rq(struct task_struct *p, int cpu, int *wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
-	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
+	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p)) {
 		cpu = p->sched_class->select_task_rq(p, cpu, *wake_flags);
-	else
+		*wake_flags |= WF_RQ_SELECTED;
+	} else {
 		cpu = cpumask_any(p->cpus_ptr);
+	}
 
 	/*
 	 * In order not to call set_task_cpu() on a blocking task we need
@@ -3659,6 +3661,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		rq->nr_uninterruptible--;
 
 #ifdef CONFIG_SMP
+	if (wake_flags & WF_RQ_SELECTED)
+		en_flags |= ENQUEUE_RQ_SELECTED;
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 	else
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588a8f00..6085ef50febf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2292,6 +2292,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_SYNC			0x10 /* Waker goes to sleep after wakeup */
 #define WF_MIGRATED		0x20 /* Internal use, task got migrated */
 #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
+#define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -2334,6 +2335,7 @@ extern const u32		sched_prio_to_wmult[40];
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
+ * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
  *
  */
 
@@ -2360,6 +2362,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_INITIAL		0x80
 #define ENQUEUE_MIGRATING	0x100
 #define ENQUEUE_DELAYED		0x200
+#define ENQUEUE_RQ_SELECTED	0x400
 
 #define RETRY_TASK		((void *)-1UL)
 
-- 
2.46.2


