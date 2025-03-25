Return-Path: <linux-kernel+bounces-574670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1A7A6E84E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42931889073
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93616EB4C;
	Tue, 25 Mar 2025 02:24:25 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1242F5B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742869465; cv=none; b=fG3BCsjh3hj9p4CWQ15Wd8XMmm2wz/ZlEybfroyedjqIvposuXihxPwfZGrJd6Eg9M59oeE2peBL0/FhpStWAi/mmfuZF+6RTNYURuYohf4DGrk740pcK6JI22Q7g8GCskBn1jZtDa5kKEuFI7Ttgi4w3SyGVMRjM1wc8u/qMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742869465; c=relaxed/simple;
	bh=gIwipyV+DqlwG9NY1oE+yWi4jiO9m0GTBzS1aLIXF3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M0gYNMnALsbYxpFS3jzeeuMV9CC4YvIGQsm5azNA9RrYm+ZPI9LX2TiGZj7SOFoEZ1nr3J2UOVPazPWINNQZDcZTCKatWTQHLgAoLgVlaXhpVvPdGoefhLIfuXh1MUqKMzQisOivgUW647BPyrJGim5yAuZREq4sL1JmsHlDTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 52P1lsRQ087290
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:47:54 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 52P1ldqT086144;
	Tue, 25 Mar 2025 09:47:39 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ZMCTS5ymvz2KchH9;
	Tue, 25 Mar 2025 09:47:08 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 25 Mar 2025 09:47:35 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <dietmar.eggemann@arm.com>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <hongyan.xia2@arm.com>, <qyousef@layalina.io>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <linux-kernel@vger.kernel.org>, <xuewen.yan94@gmail.com>
Subject: [PATCH v2] sched/uclamp: Align uclamp and util_est and call before freq update
Date: Tue, 25 Mar 2025 09:47:33 +0800
Message-ID: <20250325014733.18405-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 52P1ldqT086144

When task's uclamp is set, we hope that the CPU frequency
can increase as quickly as possible when the task is enqueued.
Because the cpu frequency updating happens during the enqueue_task(),
so the rq's uclamp needs to be updated before the task is enqueued,
just like util_est.
So, aline the uclamp and util_est and call before freq update.

For sched-delayed tasks, the rq uclamp/util_est should only be updated
when they are enqueued upon being awakened.
So simply the logic of util_est's enqueue/dequeue check.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
v2:
- simply the util-est's en/dequeue check;
---
Previous discussion:
https://lore.kernel.org/all/CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com/
https://lore.kernel.org/all/84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com/T/#u
https://lore.kernel.org/all/CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com/T/#u
https://lore.kernel.org/all/aa8baf67-a8ec-4ad8-a6a8-afdcd7036771@arm.com/
---
 kernel/sched/core.c | 17 ++++++++++-------
 kernel/sched/fair.c |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 042351c7afce..72fbe2031e54 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1747,7 +1747,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	}
 }
 
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags)
 {
 	enum uclamp_id clamp_id;
 
@@ -1763,7 +1763,8 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	if (p->se.sched_delayed)
+	/* Only inc the delayed task which being woken up. */
+	if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
 		return;
 
 	for_each_clamp_id(clamp_id)
@@ -2031,7 +2032,7 @@ static void __init init_uclamp(void)
 }
 
 #else /* !CONFIG_UCLAMP_TASK */
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
@@ -2067,12 +2068,14 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	p->sched_class->enqueue_task(rq, p, flags);
 	/*
-	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
-	 * ->sched_delayed.
+	 * Can be before ->enqueue_task() because uclamp considers the
+	 * ENQUEUE_DELAYED task before its ->sched_delayed gets cleared
+	 * in ->enqueue_task().
 	 */
-	uclamp_rq_inc(rq, p);
+	uclamp_rq_inc(rq, p, flags);
+
+	p->sched_class->enqueue_task(rq, p, flags);
 
 	psi_enqueue(p, flags);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c798d2795243..c92fee07fb7b 100644
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
-- 
2.25.1


