Return-Path: <linux-kernel+bounces-204257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753BF8FE647
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EB21C259AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C119598B;
	Thu,  6 Jun 2024 12:13:32 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89641667E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676012; cv=none; b=Sq21LrnPBoWoyuueqUFbHfCQMgc/XuWe94z8KJsMZEANTLl58ZRS39rQ5wv/H0XVQ9HrwxNEdr01DLsA8rFj4UxdLggy6XIWpJlwW4vRCrzddNkT411yafx8E1dxAgm77X/T+PBH9MCFtSeLT2jls05MwT0Djlr4wcUyp1912e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676012; c=relaxed/simple;
	bh=tPvfH57TFgOP+d7fqdIVp6YeHGR7Kb6r3bxVdfQgS8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRqmGJdJxPrZIV+YZv+8D0ZtnI/rWGyhp4pYqLuTYYVKTm7u54BJ7kXUVpNhlCKSz7XM8x4l5g6cHNBugQLnk04jlXKlvdO1sUkcdWJ3NaIUqqsy72xLSKVn4C+711OeK6ToDgfOg5EovwHqs2mCQ83yYf1AZTH/6zPYJ3F9eB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vw36B5K6yzwPF4;
	Thu,  6 Jun 2024 20:09:22 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C048818006D;
	Thu,  6 Jun 2024 20:13:20 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500001.china.huawei.com
 (7.192.104.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 20:13:20 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH] sched: Initialize the vruntime of a new task when it is first enqueued
Date: Thu, 6 Jun 2024 20:11:33 +0800
Message-ID: <20240606121133.2218723-1-zhangqiao22@huawei.com>
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

When create a new task, we initialize vruntime of the new task
at sched_cgroup_fork(). However, the timing of executing this
action is too early and may not be accurate.

Because it use current cpu to init the vruntime, but the new
task actually runs on the cpu which be assigned at wake_up_new_task().

To optimize this case, we pass ENQUEUE_INITIAL flag to
activate_task() in wake_up_new_task(), in this way,
when place_entity is called in enqueue_entity(), the
vruntime of the new task will be initialized. At the same
time, place_entity in task_fork_fair() is useless, remove it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

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
index efce2d36a783..bb5f376fd51e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12702,23 +12702,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
  */
 static void task_fork_fair(struct task_struct *p)
 {
-	struct sched_entity *se = &p->se, *curr;
-	struct cfs_rq *cfs_rq;
-	struct rq *rq = this_rq();
-	struct rq_flags rf;
-
-	rq_lock(rq, &rf);
-
 	set_task_max_allowed_capacity(p);
-
-	cfs_rq = task_cfs_rq(current);
-	curr = cfs_rq->curr;
-	if (curr) {
-		update_rq_clock(rq);
-		update_curr(cfs_rq);
-	}
-	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
-	rq_unlock(rq, &rf);
 }
 
 /*
-- 
2.18.0.huawei.25


