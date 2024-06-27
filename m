Return-Path: <linux-kernel+bounces-232383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92391A7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB88C1C21568
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F791940AA;
	Thu, 27 Jun 2024 13:36:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CD19306F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495372; cv=none; b=VZkUhQbjXQoS1ZsnbHoLxtfzZw41+OUysSI5AQY9PN/F7unzTQaSZPi7P3yUSOGCQDYNt3p0mmUY3fwz53vEi543BswVJbs0o+VKpfr7/qbS82FWBDg9i4TIRpOAhVTYF5julSNzH3HMJN+M0V9+WFCmCRB0xQC7XLDBuS75UX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495372; c=relaxed/simple;
	bh=Dr001Wah9ESPtevHFhB9490WtU/Ek+CTOlsKztX2X2E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JsDDwtztRJJ2N5QIIM83GbwB9DqfDlQJ3JQw/ivKrNIXmJQNgHYHWTooZFxwCd2ohtL4flfuNTKzpGslAnAb92Zp23fM44SoARTkzn/g05YafWw900Png/lxXQtr/fQ212da/PxSxbqu+54RYea4+4WwdnaHUi0SFjy2hUseof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W902Q0yK8znY36;
	Thu, 27 Jun 2024 21:35:58 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FE6B180087;
	Thu, 27 Jun 2024 21:36:06 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500001.china.huawei.com
 (7.192.104.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 27 Jun
 2024 21:36:05 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <Markus.Elfring@web.de>,
	<linux-kernel@vger.kernel.org>
CC: Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH v2] sched: Initialize the vruntime of a new task when it is first enqueued
Date: Thu, 27 Jun 2024 21:33:59 +0800
Message-ID: <20240627133359.1370598-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500001.china.huawei.com (7.192.104.163)

When creating a new task, we initialize vruntime of the newly task at
sched_cgroup_fork(). However, the timing of executing this action is too
early and may not be accurate.

Because it uses current CPU to init the vruntime, but the new task
actually runs on the cpu which be assigned at wake_up_new_task().

To optimize this case, we pass ENQUEUE_INITIAL flag to activate_task()
in wake_up_new_task(), in this way, when place_entity is called in
enqueue_entity(), the vruntime of the new task will be initialized.

In addition, place_entity() in task_fork_fair() was introduced for two
reasons:
1. Previously, the __enqueue_entity() was in task_new_fair(),
in order to provide vruntime for enqueueing the newly task, the
vruntime assignment equation "se->vruntime = cfs_rq->min_vruntime" was
introduced by commit e9acbff6484d ("sched: introduce se->vruntime").
This is the initial state of place_entity().

2. commit 4d78e7b656aa ("sched: new task placement for vruntime") added
child_runs_first task placement feature which based on vruntime, this
also requires the new task's vruntime value.

After removing the child_runs_first and enqueue_entity() from
task_fork_fair(), this place_entity() no longer makes sense, so remove
it also.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
v2:
Improve comments and commit log.

v1: https://lore.kernel.org/lkml/20240606121133.2218723-1-zhangqiao22@huawei.com/
---
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 15 ---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..b4ff595a2dc8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4897,7 +4897,7 @@ void wake_up_new_task(struct task_struct *p)
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
-	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..bb5f376fd51e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12702,22 +12702,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
  */
 static void task_fork_fair(struct task_struct *p)
 {
-	struct sched_entity *se = &p->se, *curr;
-	struct cfs_rq *cfs_rq;
-	struct rq *rq = this_rq();
-	struct rq_flags rf;
-
-	rq_lock(rq, &rf);
-	update_rq_clock(rq);
-
 	set_task_max_allowed_capacity(p);
-
-	cfs_rq = task_cfs_rq(current);
-	curr = cfs_rq->curr;
-	if (curr)
-		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
-	rq_unlock(rq, &rf);
 }
 
 /*
-- 
2.18.0.huawei.25


