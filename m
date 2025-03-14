Return-Path: <linux-kernel+bounces-561038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA081A60CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF37A189E5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C01EA7EF;
	Fri, 14 Mar 2025 09:09:56 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982401DEFE0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943396; cv=none; b=YoeHKaEqI+u6Qm1kYiOuICLRQ0T0v+u98xx5hSxA/PRW7/gyMCPHZWUj0qQ4I+Lt3PTa/QRqRmfT/YbNsVcqHo6sdnTBmdG8d2uCFwz3r4msDkRmSaTYtnjqPwVHoVTVUhfLS0BsfNKlVRLauWKFGj1o7+1jO6LPQ4Ho6htz5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943396; c=relaxed/simple;
	bh=Uds1QcsZVy0+KkvuuWrkarVc42cjMONHMK+RtQ67jI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ieh1XFhqkfyAKK1Ip2VeCqyXgItj7DZ38O9lnEP80Y/N6EycYQGCStnM/GD+itTSergzqU/OrJzuTexfiFTZAmlmJKhxS7E8/ZakafpMQiMg0/uu7MY+xX4f2+WWMieGxH4ox7OYpko+1H9aODrjCHHR4hhH06lXxQxLIq+KsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 52E99PrD003079;
	Fri, 14 Mar 2025 17:09:25 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ZDdpj4Mwsz2KGhk8;
	Fri, 14 Mar 2025 17:09:17 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 14 Mar 2025 17:09:23 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.co>, <linux-kernel@vger.kernel.org>,
        <hongyan.xia2@arm.com>, <qyousef@layalina.io>, <ke.wang@unisoc.com>,
        <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] sched/util_est: Do not sub the delayed-task's util-est
Date: Fri, 14 Mar 2025 17:09:09 +0800
Message-ID: <20250314090909.8404-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
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
X-MAIL:SHSQR01.spreadtrum.com 52E99PrD003079

In cpu_util_without, When the task is in rq, we should
sub the task's util_est, however, the delayed_task->on_rq
is true, however, the delayed_task's util had been sub
when sleep, so there is no need to sub the delayed task's
util-est. So add the checking of delayed-task.

On the other hand, as said in [1], the logic of util_est's
enqueue/dequeue could be simplified.
So simplify it by aligning with the conditions of uclamp.

[1]https://lore.kernel.org/all/CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com/

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c798d2795243..bebf40a0fa4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6930,7 +6930,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * Let's add the task's estimated utilization to the cfs_rq's
 	 * estimated utilization, before we update schedutil.
 	 */
-	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
+	if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
 		util_est_enqueue(&rq->cfs, p);
 
 	if (flags & ENQUEUE_DELAYED) {
@@ -7168,7 +7168,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
+	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
@@ -8037,7 +8037,8 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 		 */
 		if (dst_cpu == cpu)
 			util_est += _task_util_est(p);
-		else if (p && unlikely(task_on_rq_queued(p) || current == p))
+		else if (p && unlikely(current == p ||
+			 (task_on_rq_queued(p) && !p->se.sched_delayed)))
 			lsub_positive(&util_est, _task_util_est(p));
 
 		util = max(util, util_est);
-- 
2.25.1


