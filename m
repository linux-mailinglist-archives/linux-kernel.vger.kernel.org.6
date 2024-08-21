Return-Path: <linux-kernel+bounces-295548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E825959CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF825B249B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40861A285C;
	Wed, 21 Aug 2024 13:03:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E119ABC8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245382; cv=none; b=FiyyH1UhYa8PHxNQWnX5vfRm88/BPuXN8rOk0tELZF+Sy1q4jtQKYBc0myBb8K4Pcb6bG3p+YabcXP0l2VzEcZL5VUMMDitkt16X+4FHOuLVCLyCW72ikVnFypVZafFPG64t/rTbulXe4bdVdq+cwS+vPIOUmNmw4AoyRBUHToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245382; c=relaxed/simple;
	bh=xGxOHx7G4PRiGRZH3TXgjYgMgCLRh2eDsS1k6doL6DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mH0JG3gnn70zol+/ME8InWRWpQDyMswBKp2FdIxMcxwqG3bnBUdp3OJX/Jb6nNLntWIfmoX9TrKeb6/ruUhwn/N2KSr+oHc2rIf/ggK4VRsjadPf4A32OsE4H493bgSdObcYse7hEQP1mvbVCggVDQPaZ9n1d+WaHQBmLzybebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED415DA7;
	Wed, 21 Aug 2024 06:03:24 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F66C3F66E;
	Wed, 21 Aug 2024 06:02:57 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Warn against unbalanced util_est during dequeue
Date: Wed, 21 Aug 2024 14:02:52 +0100
Message-Id: <752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latest tip/sched/core seems to have an unbalanced util_est issue. As
I am debugging it, I found the logic util_est_dequeue() doesn't make
much sense. It guards against util_est underflow like this:

enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));

However, this is misleading because when the number of tasks drops to 0,
util_est should be exactly 0, no more, no less, because
util_est_update() is done after util_est_dequeue() and there is no
change of util_est between util_est_enqueue() and dequeue(). Even if the
current logic guards against underflow, it doesn't guard against
overflow and may cause problems to go un-noticed.

Do not guard against underflow and add a warning to check that util_est
should be exactly 0 when queue is empty.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fea057b311f6..574ef19df64b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4950,7 +4950,7 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 
 	/* Update root cfs_rq's estimated utilization */
 	enqueued  = cfs_rq->avg.util_est;
-	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
+	enqueued -= _task_util_est(p);
 	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
@@ -7176,10 +7176,14 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	util_est_dequeue(&rq->cfs, p);
 
 	if (dequeue_entities(rq, &p->se, flags) < 0) {
+		if (!rq->cfs.h_nr_running)
+			SCHED_WARN_ON(rq->cfs.avg.util_est);
 		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
 		return false;
 	}
 
+	if (!rq->cfs.h_nr_running)
+		SCHED_WARN_ON(rq->cfs.avg.util_est);
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	hrtick_update(rq);
 	return true;
-- 
2.34.1


