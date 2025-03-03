Return-Path: <linux-kernel+bounces-541457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117FAA4BD1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB20171672
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7E1FAC58;
	Mon,  3 Mar 2025 10:53:47 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FD1F8AE2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999227; cv=none; b=Q6oKQ6SqtxmbSPnXAuU9CS26Of00ogxwWturH9VDXBlMeMI3dO/bqhP/1sbhlA6J5op4vAskqj3s1OVlc3mCM0s4aCI2dU2iwcr335d2XnTmAbJLd/d1JXNV/rjZlKJ+kDN7kQP9pHgShY6KeoGCJWPphnswVsAjtLZ3zCaxP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999227; c=relaxed/simple;
	bh=ajaYSo1Ace+j6quvrpngCRHOZEge52pf4Olu9YPWJIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oa/x5V+ESZAFdFrj5kB2BSlqztSc0F8ecr3XYrhzt5qTUQWJUoNOkEDDQ99UriTFLlP9EYeHYAOw9ybmiB2qavQan738+Eg/V2fhdBUJs4/d6ny/b0OpKj5hrtREupPi+cfnREYQYo7dN/pEWAc3atqEMsL+SoWiCV3IqxBkDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 523ArVvd092780;
	Mon, 3 Mar 2025 18:53:31 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z5wXZ23DHz2K8nM6;
	Mon,  3 Mar 2025 18:48:46 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 3 Mar 2025 18:53:29 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2 3/3] sched: Do not consider the delayed task when cpu is about to enter idle
Date: Mon, 3 Mar 2025 18:52:41 +0800
Message-ID: <20250303105241.17251-4-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105241.17251-1-xuewen.yan@unisoc.com>
References: <20250303105241.17251-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 523ArVvd092780

When there are one task with sched-delayed and one task
which is descheduling, Using nr-running to determine
CPU idle may be incorrect.
For example:
task-A is sched_delayed, task-B is descheduling:
1. before schedule():
   rq-nr-running=2, task-A->on_rq=1; task-B->on_rq=1;
2. after block_task(B):
   rq-nr-running=1, task-A->on_rq=1; task-B->on_rq=0;
3. after pick_next_task(), because the task-A would be dequeued:
   rq-nr-running=0, task-A->on_rq=0; task-B->on_rq=0;

In ttwu_queue_cond, it hope the nr-running to be 0 after
the step 2, however, now the nr-running is not 0.
So sub the nr-delayed-task when checking the rq-nr-running.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 5 -----
 kernel/sched/sched.h | 5 +++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67189907214d..6569f220c2fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3963,7 +3963,7 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 	 * p->on_cpu can be whatever, we've done the dequeue, so
 	 * the wakee has been accounted out of ->nr_running.
 	 */
-	if (!cpu_rq(cpu)->nr_running)
+	if (!(cpu_rq(cpu)->nr_running - cfs_h_nr_delayed(cpu_rq(cpu))))
 		return true;
 
 	return false;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8797f6872155..29ee1ce17036 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7181,11 +7181,6 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	return true;
 }
 
-static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
-{
-	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
-}
-
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..3996b0c5c332 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3609,6 +3609,11 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 }
 #endif
 
+static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
+{
+	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
+}
+
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
-- 
2.25.1


