Return-Path: <linux-kernel+bounces-293164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8E957B86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7681F1F235CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20083E49D;
	Tue, 20 Aug 2024 02:38:20 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FF1F5F6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121500; cv=none; b=rmwhJqp/ujr8Y3o8PSjIeQS5Y4fh16af+S9gRGW3dmLdAP2L6gt2k8CPNXKm9J/xyg3HRl/7ryHwKB5yRcvpIdJ8AP3t4nD/v7p/UwMt73EgaQsdcURGgUEnGcKV9wVKls+orVoo8nQ42CBfSF3AeQol1Cm/Zj0t96jxDLBtmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121500; c=relaxed/simple;
	bh=5XK/S6t98Ogzv8H59JHW1xX6ZINBsHMMDZmTDahWc/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cznw28B6nH1//eTU9gkjot6vjH8CvuRw2939ulq+c66Uyw3eT5FgXJV5Pvm9q52lRTN5QxoAA7pSTwKQSzZP1iHme6pwV4kNhYFV7s4VjJ0x2XJCkO/fyrSZhUG4jkZON5poKu89t7JMuAygck430wrBb342SrN1sGj3/EOjt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wntmq5mbqz1S8Jg;
	Tue, 20 Aug 2024 10:33:15 +0800 (CST)
Received: from kwepemg200002.china.huawei.com (unknown [7.202.181.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 692121400FD;
	Tue, 20 Aug 2024 10:38:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200002.china.huawei.com
 (7.202.181.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 10:38:14 +0800
From: Yipeng Zou <zouyipeng@huawei.com>
To: <tj@kernel.org>, <void@manifault.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>
CC: <zouyipeng@huawei.com>
Subject: [PATCH] sched_ext: Allow dequeue_task_scx to fail
Date: Tue, 20 Aug 2024 10:45:31 +0800
Message-ID: <20240820024531.12781-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200002.china.huawei.com (7.202.181.29)

Since dequeue_task() allowed to fail, there is a compile error:

kernel/sched/ext.c:3630:19: error: initialization of ‘bool (*)(struct rq*, struct task_struct *, int)’ {aka ‘_Bool (*)(struct rq *, struct task_struct *, int)’} from incompatible pointer type ‘void (*)(struct rq*, struct task_struct *, int)’
  3630 |  .dequeue_task  = dequeue_task_scx,
       |                   ^~~~~~~~~~~~~~~~

Allow dequeue_task_scx to fail too.

Fixes: 863ccdbb918a ("sched: Allow sched_class::dequeue_task() to fail")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 571a7ea0b5cb..b9bf9ee5ed01 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2033,11 +2033,11 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 	}
 }
 
-static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
+static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
 {
 	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
 		WARN_ON_ONCE(task_runnable(p));
-		return;
+		return true;
 	}
 
 	ops_dequeue(p, deq_flags);
@@ -2072,6 +2072,7 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+	return true;
 }
 
 static void yield_task_scx(struct rq *rq)
-- 
2.34.1


