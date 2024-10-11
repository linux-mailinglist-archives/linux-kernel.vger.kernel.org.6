Return-Path: <linux-kernel+bounces-361128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8699A3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5BC1C2258F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCD218584;
	Fri, 11 Oct 2024 12:32:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF512178F2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649968; cv=none; b=B1DJgnMpYXyjMkMjQE4ggqE/znsYsWOsFLyfTTojIsy+48vYf247E05SANYSQzI6FPDpUzTrSf1rvsxq3WT80fFkXXBY37TO5W7yo4ahTRH09x3Q0kT8qo8IRTUB0ApEfg3vkVlR2o3/lfnWtDCtwvIxHD4LHv+oLGvlpoL+2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649968; c=relaxed/simple;
	bh=ys+GKF2df3/9xfmVx3qNMei1OJBfqQN3jCZN6DqV/DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yckm/JdQhkFwLtw206snveDV38YdtirZuBKHPvdFxpvi0HKGrgOeRX2H0yuwvbz/DRVrbuJQX6NMUjvGm9fiLZ1/N3mV0JY86HusTrmz0Wj5vh9zSM2zoTMdhyOJcxoIQaTXiWHK2TiRwXhCbAQt8g7q4v25XRR7IrqmZs2YTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7819ADA7;
	Fri, 11 Oct 2024 05:33:15 -0700 (PDT)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.129.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E734E3F64C;
	Fri, 11 Oct 2024 05:32:42 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Hongyan Xia <hongyan.xia2@arm.com>,
	Chritian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 1/1] sched/fair: Update blocked averages on tick
Date: Fri, 11 Oct 2024 14:32:22 +0200
Message-Id: <20241011123222.1282936-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011123222.1282936-1-pierre.gondois@arm.com>
References: <20241011123222.1282936-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Energy Aware Scheduler (EAS) relies on CPU/tasks utilization
signals. On an idle CPU, the blocked load is updated during
load balancing.

sd->balance_interval increases with the number of CPUs in the domain.
On an Arm DynamIQ system, sched domains containing CPUs with the same
capacity do not exist. On a Pixel6 with 4 little, 2 mid, 2 big CPUs:
- sd->min_interval = 8
- sd->min_interval = 16

The balance interval is doubled if the system is balanced, meaning
that a balanced system will likely update blocked load every 16ms.

The find_energy_efficient_cpu() function might thus relies on outdated
util signals to place tasks, leading to bad energy placement.

Update blocked load on sched tick if:
- the rq is idle
- the load balancer will not be triggered.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..2f03bd10ac7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9841,15 +9841,12 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif
 
-static void sched_balance_update_blocked_averages(int cpu)
+static void update_blocked_averages(struct rq *rq)
 {
 	bool decayed = false, done = true;
-	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
-	rq_lock_irqsave(rq, &rf);
-	update_blocked_load_tick(rq);
 	update_rq_clock(rq);
+	update_blocked_load_tick(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
 	decayed |= __update_blocked_fair(rq, &done);
@@ -9857,6 +9854,18 @@ static void sched_balance_update_blocked_averages(int cpu)
 	update_blocked_load_status(rq, !done);
 	if (decayed)
 		cpufreq_update_util(rq, 0);
+}
+
+static void sched_balance_update_blocked_averages(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct cfs_rq *cfs_rq;
+	struct rq_flags rf;
+
+	cfs_rq = &rq->cfs;
+
+	rq_lock_irqsave(rq, &rf);
+	update_blocked_averages(rq);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -12877,6 +12886,8 @@ void sched_balance_trigger(struct rq *rq)
 
 	if (time_after_eq(jiffies, rq->next_balance))
 		raise_softirq(SCHED_SOFTIRQ);
+	else if (idle_cpu(rq->cpu))
+		update_blocked_averages(rq);
 
 	nohz_balancer_kick(rq);
 }
-- 
2.25.1


