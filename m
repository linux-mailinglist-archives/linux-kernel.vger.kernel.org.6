Return-Path: <linux-kernel+bounces-543603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05277A4D756
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F551759E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9320110F;
	Tue,  4 Mar 2025 08:57:21 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98699201110
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078641; cv=none; b=idUkDu4maC0YIhJ6RiGkdySYYlwVz67Yt26POJJUV3U85Dba9rLffqRiLpTd+xexX0TfpBZ1iT6r1X0k5bhBQ2V8lvwHwgPClZn8TKlNSNsHiuParVxNJhqzrPreaB9tvAOF+55wCKTy+FpCpb5v2YqLZg11TKXY82w3B3hZZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078641; c=relaxed/simple;
	bh=PW9+ImeZbNLV3m7gl577wCl+VBWu9CgnuSmZcWbx58o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1T6DTBOUY8nxVgOpciP42zkhYZ+qXfjimnuZDfEBU3c3jD33i6MzMOiwQcEgVu9+Y3j0kd0PnjkixPcKMj7/uB5ElaN9t1VS3wmZrqd0cOmLZIJlO/p2J5Xvpc2yWGcM9iMvyVLCUmOEmitbEagLbY8bk8ixN7Ttfa6LX0XGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 5248v19M011461;
	Tue, 4 Mar 2025 16:57:01 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z6Tvd5fYxz2KBLRT;
	Tue,  4 Mar 2025 16:52:13 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 4 Mar 2025 16:56:59 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] sched/stats: Add missing schedstats update for sched_delayed tasks
Date: Tue, 4 Mar 2025 16:55:53 +0800
Message-ID: <20250304085553.3367-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 5248v19M011461

Because sched-delayed tasks do not leave the runqueue，
if they are woken up and re-queued before becoming eligible,
the wait and sleep-related information in schedstat is not updated.

So add the dequeue/enqueue update for the sched-delayed queue.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 29ee1ce17036..b0a786e2c074 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5340,8 +5340,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (flags & ENQUEUE_MIGRATED)
 		se->exec_start = 0;
 
-	check_schedstat_required();
-	update_stats_enqueue_fair(cfs_rq, se, flags);
+	if (!se->sched_delayed) {
+		check_schedstat_required();
+		update_stats_enqueue_fair(cfs_rq, se, flags);
+	}
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
@@ -5458,6 +5460,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		    !entity_eligible(cfs_rq, se)) {
 			update_load_avg(cfs_rq, se, 0);
 			set_delayed(se);
+			update_stats_dequeue_fair(cfs_rq, se, flags);
 			return false;
 		}
 	}
@@ -5477,7 +5480,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
-	update_stats_dequeue_fair(cfs_rq, se, flags);
+	/* Do not update twice for delayed task */
+	if (!se->sched_delayed)
+		update_stats_dequeue_fair(cfs_rq, se, flags);
 
 	update_entity_lag(cfs_rq, se);
 	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
@@ -6933,6 +6938,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	if (flags & ENQUEUE_DELAYED) {
 		requeue_delayed_entity(se);
+		check_schedstat_required();
+		update_stats_enqueue_fair(cfs_rq_of(se), se, flags);
 		return;
 	}
 
-- 
2.25.1


