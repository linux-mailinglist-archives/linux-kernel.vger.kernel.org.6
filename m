Return-Path: <linux-kernel+bounces-226790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425119143CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3528F1C2137D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87E45034;
	Mon, 24 Jun 2024 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nxcka4nT"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AE3B1BC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214755; cv=none; b=jyvaUiicW7dTi4rbqo40b2rbHm1hvP+JxWauwYEbsynD2jGxP/5/j4yqId5qzo04/kmWb2NfwKS/dZNs4X5fSJNx2gkkz1/4DzEuXjxW3AyqJ7EFUj1Ln4Qb0i1+A1qfnev3DHaN/Zr6AX9oyC0vdjPh3TatF/bdEQsli5bR/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214755; c=relaxed/simple;
	bh=YsL/40V3s6bFnm3J8489rWhjiABcSBUhZZyQf5m3SY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOFo5MK1UZkiEt42CtbYGHbPvWng6N1P7RV47xBAlddSOwdXC+oqbxRopK5sUibIKGlAO9UPwvZajxOtaKCibhPhRzvx5knhTH24yQTr0uotqb99Dz6tTlSXsrW3K2dq78MhXFyOVn7eCFcY7IyY5Yn3EJq/z4OLkgkXCLBjypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nxcka4nT; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719214749; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=y0atFckk7CS6RDAoo0++yRHoJXCWBTg5nMMFJltfLE8=;
	b=Nxcka4nTZ8V16j9Q44dx9BlNrbYrutSgtUWDiKGKfjpr0+um7WrlgrLBpXetNkDewK8tavrfyPrsRs2nXy47C3q+39dgXuHOLxnEaep0f9TS9ZmruAPinKNVmav2dThVqp56Z0pFlOMRsDNLO7oxVTABIW8dGmDjQcElKbVT/iY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W94kn-D_1719214741;
Received: from x31l07247.sqa.na131.tbsite.net(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W94kn-D_1719214741)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 15:39:09 +0800
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
Subject: [PATCH] sched/fair: Make SCHED_IDLE se be preempted in strict hierarchy
Date: Mon, 24 Jun 2024 15:39:00 +0800
Message-Id: <20240624073900.10343-1-dtcccc@linux.alibaba.com>
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
Unify the wakeup logic by {p}se_is_idle only.

Also fix a bug about se_is_idle() definition when
!CONFIG_FAIR_GROUP_SCHED.

Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/fair.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..c91cfaa7d9ee 100644
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
@@ -8408,6 +8399,12 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		goto preempt;
 	if (cse_is_idle != pse_is_idle)
 		return;
+	/*
+	 * Batch tasks do not preempt non-idle tasks (their preemption
+	 * is driven by the tick):
+	 */
+	if (unlikely(pse == &p->se && p->policy == SCHED_BATCH))
+		return;
 
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
-- 
2.39.3


