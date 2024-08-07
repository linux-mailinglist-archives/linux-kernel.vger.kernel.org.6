Return-Path: <linux-kernel+bounces-277562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D13094A2F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E11A1C2082C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF01C9DE1;
	Wed,  7 Aug 2024 08:30:28 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BAF18D640
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019428; cv=none; b=ce5ceWVK2MO1GnOW30hOtU4dSz4yosMsz+mV0+tKgHZRwaBOFe0wn/UPl3Iha3wVMCk5nZs7qu+zFlOO5FwmSxeIeKZ76flIhkss3tKtayce4Dfpmal037A1GiYFKTMxznoeXg9bliGBpssihP1b0duKUzfQpKlQKM90Z9GbFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019428; c=relaxed/simple;
	bh=gGk5wm9gtj1Ytlzpy/Kax2dthhGudqsxdNr4CcOB0Iw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XL1ASfivF2LKQEbCza2Bj1yuyjySFQuaonmX6+wXh6QWv+81ePY30a6gLA9G35jMG253HmFTCCB2o/LL6S9kKYP8OsFWr4QGbZGHyqj5lDA+tLm45HySy7i7wCdDLY1gsttXW1dtqG+RRUWtTPGgj0yOrIveMDqr41VqPzVDzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wf3Ck28g9zQpKD;
	Wed,  7 Aug 2024 16:25:54 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id DBEEA180101;
	Wed,  7 Aug 2024 16:30:20 +0800 (CST)
Received: from huawei.com (7.221.49.203) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Aug
 2024 16:30:19 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Daniel
 Bristot de Oliveira <bristot@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH] sched/deadline: Fix imbalanced task reference
Date: Wed, 7 Aug 2024 16:30:15 +0800
Message-ID: <20240807083015.1385303-1-zhangqiao22@huawei.com>
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

When starting a deadline inactive_timer, the task_struct refs will
be incremented only if dl_server is not set. But when canceling the
inactive_timer, the task refs will be decremented whether dl_server is
set or not, leading to a task reference imbalance issue.

This patch fixes the imbalanced reference by adding a '!dl_server()'
checker before calling put_task_struct().

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/deadline.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f59e5c19d944..40aafc27f02b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -320,6 +320,15 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 		__sub_running_bw(dl_se->dl_bw, dl_rq);
 }
 
+static inline
+void dl_cancel_inactive_timer(struct task_struct *p)
+{
+	struct sched_dl_entity *dl_se = &p->dl;
+
+	if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1 && !dl_server(dl_se))
+		put_task_struct(p);
+}
+
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	struct rq *rq;
@@ -340,8 +349,7 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		dl_cancel_inactive_timer(p);
 	}
 	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
 	__add_rq_bw(new_bw, &rq->dl);
@@ -490,10 +498,7 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
-			if (!dl_server(dl_se))
-				put_task_struct(dl_task_of(dl_se));
-		}
+		dl_cancel_inactive_timer(dl_task_of(dl_se));
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -1975,8 +1980,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		dl_cancel_inactive_timer(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
 	rq_unlock(rq, &rf);
@@ -2731,8 +2735,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
  */
 static void switched_to_dl(struct rq *rq, struct task_struct *p)
 {
-	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-		put_task_struct(p);
+	dl_cancel_inactive_timer(p);
 
 	/*
 	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
-- 
2.33.0


