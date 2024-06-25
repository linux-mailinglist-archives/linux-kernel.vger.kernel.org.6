Return-Path: <linux-kernel+bounces-228442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56664915FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817531C20A99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BE2146A81;
	Tue, 25 Jun 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPbNok2e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A3146A7B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300314; cv=none; b=l8Fm2bUrm0BVw1pZpYS3og81Zu9X5lBTuy8jX8SgYqLeuYBrx28KqlgxsXoEfY5r/5avcdKeIpI2fTvnyiCwnkrkkUIla+VZTwaBSw54CYsRpPTSGEB0BVzQULaSLdNUc7Nk13sp6K2a7M24vM6DgPD6aSoR+g7MoNK6QadM9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300314; c=relaxed/simple;
	bh=7ZjSY3rh8J+ct5ERYhltVYubIGtiCkBKkCZbQVawuPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVBGD6Y4Qcx/QDN2P9IcBeAHlFwWv5Fo6uEWTd755K4lTyeEZCMr5erzhudBniXrAWcosx1DcSMT4AXX2F+lOJZ5vNZVen2RYKlocGOlq2JrHmnAkhFWwdyRyVgi9hvi40y+bD5KNHvMmekWUf4G4sulPmnpGwJpInkO2H0knFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPbNok2e; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719300313; x=1750836313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ZjSY3rh8J+ct5ERYhltVYubIGtiCkBKkCZbQVawuPc=;
  b=FPbNok2eAZukPJJMXSJdWCbKNDtB+W5I1jzyq6IXgEpev551D7hYNy2a
   /0SLqc3N+E8XpzXUHArumzlnZ2GQ4ltiI/Pvo/IcE9sZ9NOcCDna+muBE
   O3ZLoXKlNPd9Dy07yWguN2DqKSKUkNofbMbIJRHqGm2GBkhNyeDz/c5fF
   4NiAyvGz71Eo1P8MX/7HKfMnlR38l2OWfNXI3ZtdpaFyajVZFsFu20+8Q
   2i/+pMY3SNkRCAyKpRo7kav6GP0dT/zKVdvLATqhw+2y9B55vO9DKtE2a
   IxWwXIuXaBjqYYARTb/BDrwoUK4dwnTbobi0kM6BnRRu/VKvu4tI9u88+
   A==;
X-CSE-ConnectionGUID: QjkxS0WmRYWciSA5GD0ZZA==
X-CSE-MsgGUID: ARPoO8IATYeLtTUfX5MBHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20075568"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="20075568"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 00:25:13 -0700
X-CSE-ConnectionGUID: kEDRshYiT5eXMNMDOITXlg==
X-CSE-MsgGUID: lZe8AqqOToiiqwAubTGSAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48523302"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa005.jf.intel.com with ESMTP; 25 Jun 2024 00:25:10 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>,
	Tim Chen <tim.c.chen@intel.com>,
	Yujie Liu <yujie.liu@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2] sched/fair: Record the average duration of a task
Date: Tue, 25 Jun 2024 15:22:09 +0800
Message-Id: <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1719295669.git.yu.c.chen@intel.com>
References: <cover.1719295669.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record the average duration of a task, as there is a requirement
to leverage this information for better task placement.

At first thought the (p->se.sum_exec_runtime / p->nvcsw)
can be used to measure the task duration. However, the
history long past was factored too heavily in such a formula.
Ideally, the old activity should decay and not affect
the current status too much.

Although something based on PELT can be used, se.util_avg might
not be appropriate to describe the task duration:
Task p1 and task p2 are doing frequent ping-pong scheduling on
one CPU, both p1 and p2 have a short duration, but the util_avg
of each task can be up to 50%, which is inconsistent with the
short task duration.

Here's an example to show what the average duration is. Suppose
on CPUx, task p1 and p2 run alternatively:

 --------------------> time

 | p1 runs 1ms | p2 preempt p1 | p1 switch in, runs 0.5ms and blocks |
               ^               ^                                     ^
 |_____________|               |_____________________________________|
                                                                     ^
                                                                     |
                                                                  p1 dequeued

p1's duration is (1 + 0.5)ms. Because if p2 does not preempt p1, p1 can run 1.5ms.
This reflects the nature of a task: how long it wishes to run at most.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/core.c   |  2 ++
 kernel/sched/fair.c   | 12 ++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 90691d99027e..78747d3954fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1339,6 +1339,9 @@ struct task_struct {
 	struct callback_head		cid_work;
 #endif
 
+	u64				prev_sleep_sum_runtime;
+	u64				duration_avg;
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	/* Cache last used pipe for splice(): */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..7399c4143528 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->migration_pending = NULL;
 #endif
 	init_sched_mm_cid(p);
+	p->prev_sleep_sum_runtime = 0;
+	p->duration_avg = 0;
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..445877069fbf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6833,6 +6833,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 static void set_next_buddy(struct sched_entity *se);
 
+static inline void dur_avg_update(struct task_struct *p)
+{
+	u64 dur;
+
+	dur = p->se.sum_exec_runtime - p->prev_sleep_sum_runtime;
+	p->prev_sleep_sum_runtime = p->se.sum_exec_runtime;
+	update_avg(&p->duration_avg, dur);
+}
+
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+	if (task_sleep)
+		dur_avg_update(p);
+
 	hrtick_update(rq);
 }
 
-- 
2.25.1


