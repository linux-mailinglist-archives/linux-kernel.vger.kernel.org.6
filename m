Return-Path: <linux-kernel+bounces-366006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B79C99EF96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0478DB212E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9171B21AE;
	Tue, 15 Oct 2024 14:29:31 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01121FC7CF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002571; cv=none; b=mt8joILpysMXyX14HY8aDHQxBAA2ZDvEbV1hhEeHpN4BZOcLk+cU4RuoEJqnWmoMNwC2B5/u5VdwiEsRmXamG9N/uLElUoVqFdpjPp0cN4jotDn0BhoqKyH0rYTYwLB1485u+l1na01p9VW36AjIdfRZpPe37+8xCexiSjbGAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002571; c=relaxed/simple;
	bh=Rr2uBg7XmaP4MLCUH2K4xP2ccL4kGu46qQHyGxhImy4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eOETdS+PB/sFcohv1XktlqAmVKjfJa/ZVbsSq66nDIR1+PWmetaWw6iPk7ITsDbcpm/lloZeulxdNNPJ7W1lTzV+cEzKJQnC1FR1shDasNhow1Zs7aSVJ2by59D2ONUu0Pg5I6q5QIu7F6qO0M4L0niIGC/0lypevzPGxED4Sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XSc0V4TmDz20qQg;
	Tue, 15 Oct 2024 22:28:42 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id D1BCB1A0188;
	Tue, 15 Oct 2024 22:29:25 +0800 (CST)
Received: from huawei.com (7.223.141.1) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:29:24 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH] sched_ext: Fix missing unlock in consume_dispatch_q()
Date: Tue, 15 Oct 2024 22:29:17 +0800
Message-ID: <20241015142917.83397-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200007.china.huawei.com (7.202.181.34)

When the function consume_dispatch_q() returns true, the dsq lock may
remains held and is not unlocked.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 410a4df8a121..4d80aa3de00e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2377,7 +2377,8 @@ static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p
 static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 {
 	struct task_struct *p;
-retry:
+	bool ret = false;
+
 	/*
 	 * The caller can't expect to successfully consume a task if the task's
 	 * addition to @dsq isn't guaranteed to be visible somehow. Test
@@ -2394,19 +2395,20 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 		if (rq == task_rq) {
 			task_unlink_from_dsq(p, dsq);
 			move_local_task_to_local_dsq(p, 0, dsq, rq);
-			raw_spin_unlock(&dsq->lock);
-			return true;
+			ret = true;
+			break;
 		}
 
 		if (task_can_run_on_remote_rq(p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, dsq, task_rq)))
-				return true;
-			goto retry;
+			if (likely(consume_remote_task(rq, p, dsq, task_rq))) {
+				ret = true;
+				break;
+			}
 		}
 	}
 
 	raw_spin_unlock(&dsq->lock);
-	return false;
+	return ret;
 }
 
 static bool consume_global_dsq(struct rq *rq)
-- 
2.33.0


