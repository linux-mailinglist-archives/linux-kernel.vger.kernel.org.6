Return-Path: <linux-kernel+bounces-544403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728BA4E0BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2207A988E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7974207DEB;
	Tue,  4 Mar 2025 14:23:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08AF207DF5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098231; cv=none; b=iAWC89oKji8+lpKGVCgBjwIyZyLCErO2tmEiQmKk7qpFxWoEGRnlJ1ceV3R/csYwo0dd592+CS4E5A+ZGwcvyilxT87hbpVt22FMeKvdnbkGgdBygL60HaEw7qy70aMQ22wXugJgmGcWsEyOfZPRdH0yGJHNK86yrn1+kfNNKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098231; c=relaxed/simple;
	bh=+/4CvG4LsmN5Sf5U9c6W1i9TGVpKsEVoSEJ4l2pow9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efQSGha87g25eZFguSxpdtF2776pC4rWogeJB7ka1tb3VLQx8njc4vTyPCEDQ0fXYrNLlbOz6+ye4k7rsLs0YzaE/BMhBP1Qanz9PFLcjyXv13ojyNixPMFw6Ct2QVxVBCP+jxmEStcZX8FyrhH1jHKH2vvKmq2+MAcT54c1JmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11748FEC;
	Tue,  4 Mar 2025 06:24:03 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B135F3F66E;
	Tue,  4 Mar 2025 06:23:47 -0800 (PST)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] sched/uclamp: Solve under-utilization problem
Date: Tue,  4 Mar 2025 14:23:15 +0000
Message-Id: <94048802c665752e92d1d354fdc38dd95ffe4a03.1741091349.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741091349.git.hongyan.xia2@arm.com>
References: <cover.1741091349.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With sum aggregation, a heavily uclamp_max-throttled task may throttle
the whole rq, resulting in low OPP.

For example, two tasks having the same priority and both tasks are
always-running tasks. One task has no uclamp values but the other has
uclamp_max of 1. Then, under sum aggregation, the CPU will run at 512 +
1 = 513 OPP, which means the task without uclamp_max only gets 513 / 2 =
256 utilization, even though the CPU still can run faster.

With this patch, we do not throttle a uclamp_max too hard such that it
impacts other tasks. This is done by tracking the highest uclamp_factor
and any uclamp_max tasks cannot throttle more than this factor allows.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c  | 12 ++++++++++++
 kernel/sched/pelt.c  | 33 +++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  2 ++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 944953b90297..966ca63da3fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7159,6 +7159,18 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (p) {
 		util_bias_dequeue(rq, p);
 		propagate_negative_bias(p);
+		if (p->pid == rq->max_uclamp_factor_pid) {
+			/*
+			 * If the task with the highest uclamp_factor gets
+			 * dequeued, the correct thing to do is to set pid and
+			 * factor to the second highest. However, the overhead
+			 * isn't really necessary because the second highest
+			 * will set these fields the next time it gets updated
+			 * anyway.
+			 */
+			rq->max_uclamp_factor_pid = -1;
+			rq->max_uclamp_factor = 0;
+		}
 	}
 
 	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index f38abe6f0b8b..e96ca045af2e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -271,8 +271,8 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 static void util_bias_update(struct task_struct *p)
 {
 	unsigned int util, uclamp_min, uclamp_max;
-	struct rq *rq;
-	int old, new;
+	struct rq *rq = task_rq(p);
+	int old, new, clamped_util, prio = p->prio - MAX_RT_PRIO;
 
 	util = READ_ONCE(p->se.avg.util_avg);
 	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
@@ -284,12 +284,37 @@ static void util_bias_update(struct task_struct *p)
 	if (uclamp_max == SCHED_CAPACITY_SCALE)
 		uclamp_max = UINT_MAX;
 	old = READ_ONCE(p->se.avg.util_avg_bias);
-	new = (int)clamp(util, uclamp_min, uclamp_max) - (int)util;
+	clamped_util = (int)clamp(util, uclamp_min, uclamp_max);
+	if (p->se.on_rq && prio >= 0) {
+		/* We only do this for fair class priorities. */
+		u64 uclamp_factor = sched_prio_to_wmult[prio];
+
+		/* This has to be a 64-bit multiplication. */
+		uclamp_factor *= clamped_util;
+		if (rq->max_uclamp_factor_pid == p->pid) {
+			rq->max_uclamp_factor = uclamp_factor;
+		} else if (uclamp_factor > rq->max_uclamp_factor) {
+			rq->max_uclamp_factor = uclamp_factor;
+			rq->max_uclamp_factor_pid = p->pid;
+		} else {
+			u32 weight = sched_prio_to_weight[prio];
+
+			/*
+			 * We cannot throttle too much if some other task is
+			 * running at high utilization. We should prioritize
+			 * giving that task enough utilization and respect
+			 * task priority, before enforcing uclamp_max.
+			 */
+			uclamp_max = max(uclamp_max,
+				(rq->max_uclamp_factor * weight) >> 32);
+			clamped_util = (int)clamp(util, uclamp_min, uclamp_max);
+		}
+	}
+	new = clamped_util - (int)util;
 
 	WRITE_ONCE(p->se.avg.util_avg_bias, new);
 	if (!p->se.on_rq)
 		return;
-	rq = task_rq(p);
 	WRITE_ONCE(rq->cfs.avg.util_avg_bias,
 		   READ_ONCE(rq->cfs.avg.util_avg_bias) + new - old);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 654eede62979..0dc90208ad73 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1086,6 +1086,8 @@ struct rq {
 	u64			nr_switches;
 
 #ifdef CONFIG_UCLAMP_TASK
+	u64			max_uclamp_factor;
+	pid_t			max_uclamp_factor_pid;
 #endif
 
 	struct cfs_rq		cfs;
-- 
2.34.1


