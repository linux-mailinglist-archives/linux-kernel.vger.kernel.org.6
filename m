Return-Path: <linux-kernel+bounces-390280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D819E9B77DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843291F233EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1671990C8;
	Thu, 31 Oct 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o+HouaT8"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B619884B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368122; cv=none; b=hsM4JarXCtFhp5BgzuIf45bQx+BrPj513lpDwTI8SORBvzv44pUmKahxwHB+Y65mmHWqsC2u1UfY0ZoYw/KTrDDK/b2j/5s2E9qEcHXXhdaeLaIRolH9xRUK491trRJXA8hHRxP9KzptzsnUsPpanz/N3KrcUAavY6lUMzx4dlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368122; c=relaxed/simple;
	bh=UXAx2SM0eKCIzmVnsm4W1Sus4LZ9RqGtGfYhUwPLjPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xi+hWuQPZe6Cq1Nt4OCqlbfnRyc1iDdFhZgFxTBZlcs/Jw4nT3D5SqaaXqPuxFecDXl9OpPeLQNlKVykMQL+SLwbFvPUga/wDW0MwWH0B0UFOPR8c8e8J9zuINV3iRwj7FkCxa/bHPR50dsg0mR/2l5xRuO0mbp9KohSqHeF5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o+HouaT8; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730368110; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=54wMrcTPCDlj1SBjpTMecFspoYW2xtj7KKGkL9pyQZc=;
	b=o+HouaT8weZ2viexEIdQZx2HIXxt1yVFz9l9ieIsl/4u7OIZN6Ar69Cft99nDzOaaUxR/EPVZtADA/S9fWjWWrzLXgMt51YbuQ9f0eWkdUnje6/xJEhJaxmtsO4UrnR70J/CtATk4WobXS00Bl0hYhIUjDAkaPUDDmY3878bjjQ=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WII0-IE_1730368103 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 17:48:29 +0800
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
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v2] sched/eevdf: Force propagating min_slice of cfs_rq when a task changing slice
Date: Thu, 31 Oct 2024 17:48:22 +0800
Message-Id: <20241031094822.30531-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
References: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a task changes slice and its cgroup se is already on_rq, the cgroup
se will not be enqueued again, and hence the root->min_slice leaves
unchanged.

Force propagating it when se doesn't need to be enqueued (or dequeued).
Ensure the se hierarchy always get the latest min_slice.

Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
v2:
Add a check about effectiveness of se->run_node. Thanks to the kernel
test robot.
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6512258dc71f..ffac002a8807 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7017,6 +7017,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		if (se != cfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running++;
@@ -7141,6 +7143,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		if (se != cfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running -= h_nr_running;
-- 
2.39.3


