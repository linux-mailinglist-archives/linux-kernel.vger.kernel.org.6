Return-Path: <linux-kernel+bounces-229935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA9917632
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5831F21E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF720322;
	Wed, 26 Jun 2024 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XabW/BID"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A820B3E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369323; cv=none; b=Xumu59qbCgZ6F1h88GR/itwAxIQo1jrelBO3oEmncVJjDGFSZJyCtKUS3l9QV8YNbiFCl8WJ1TZZrLRlHMTUz92e0Q1/rwHnzJ/2tBbj18ESPWb6AiIX0BEcoOd4WJVXCqnFEb/6NcXgBScGkumVsdQQ4tqtcGUlkItG7DmnyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369323; c=relaxed/simple;
	bh=9FhJlUh/S9bQsKebZ9U7sUyganMfqSjFkzyxUbkBeyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OyAU/3y6ixp0CGq3/rhTRZOJMi5wxZy0FUD/stMYRebFBtuiMQCvrlVBNO+I5pgJqTj9BkYfgqOn5XoX2uF3Efkgafa+0l6Ed6c5px39YiMAJ/B7F1GzAVDrz4kR6YseBR1tAQNXPcN3rOD6u8qapb3TUwjjn3d0Lo2b9ufEgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XabW/BID; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719369313; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CSq7RSDkinH5vbX0ssESrEiZUD6kjor5NMp+7YfuVRA=;
	b=XabW/BIDmK7LDjVKaaEvhPshEB5RDrXbSeLJrl50lrZ+O9ThmqaN/zjVU0lqQ8PYCQQQYgH+Sk9y9zCfJAbzt5Y6Sf+bY+56wYwvhCha8Kn+IdmyI+Orn/43Q7NZ8CBiTGlPO58Kgp5Stc2vD6tK8KKVBGeHtCpYRQFJP3eAN98=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W9Hbge2_1719369305;
Received: from x31l07247.sqa.na131.tbsite.net(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W9Hbge2_1719369305)
          by smtp.aliyun-inc.com;
          Wed, 26 Jun 2024 10:35:13 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>
Subject: [PATCH v2] sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy
Date: Wed, 26 Jun 2024 10:35:05 +0800
Message-Id: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider the following cgroup:

                       root
                        |
             ------------------------
             |                      |
       normal_cgroup            idle_cgroup
             |                      |
   SCHED_IDLE task_A           SCHED_NORMAL task_B

According to the cgroup hierarchy, A should preempt B. But current
check_preempt_wakeup_fair() treats cgroup se and task separately, so B
will preempt A unexpectedly.
Unify the wakeup logic by {c,p}se_is_idle only. This makes SCHED_IDLE of
a task a relative policy that is effective only within its own cgroup,
similar to the behavior of NICE.

Also fix se_is_idle() definition when !CONFIG_FAIR_GROUP_SCHED.

Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Reviewed-by: Josh Don <joshdon@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
v2:
Use entity_is_task() to check whether pse is a task.
Improve comments and commit log.

v1: https://lore.kernel.org/all/20240624073900.10343-1-dtcccc@linux.alibaba.com/
---
 kernel/sched/fair.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..f0b038de99ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -511,7 +511,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
 
 static int se_is_idle(struct sched_entity *se)
 {
-	return 0;
+	return task_has_idle_policy(task_of(se));
 }
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
@@ -8382,16 +8382,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (test_tsk_need_resched(curr))
 		return;
 
-	/* Idle tasks are by definition preempted by non-idle tasks. */
-	if (unlikely(task_has_idle_policy(curr)) &&
-	    likely(!task_has_idle_policy(p)))
-		goto preempt;
-
-	/*
-	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
-	 * is driven by the tick):
-	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (!sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
@@ -8401,7 +8392,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	pse_is_idle = se_is_idle(pse);
 
 	/*
-	 * Preempt an idle group in favor of a non-idle group (and don't preempt
+	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
 	 * in the inverse case).
 	 */
 	if (cse_is_idle && !pse_is_idle)
@@ -8409,6 +8400,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (cse_is_idle != pse_is_idle)
 		return;
 
+	/*
+	 * Batch tasks do not preempt non-idle tasks (their preemption
+	 * is driven by the tick).
+	 * We've done the check about "only one of the entities is idle",
+	 * so cse must be non-idle if p is a batch task.
+	 */
+	if (unlikely(entity_is_task(pse) && p->policy == SCHED_BATCH))
+		return;
+
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
-- 
2.39.3


