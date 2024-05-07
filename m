Return-Path: <linux-kernel+bounces-171310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50468BE280
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DC128BF59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE615D5D8;
	Tue,  7 May 2024 12:50:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7915B98F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086246; cv=none; b=B3Cx5Rzyrfe8ydrgievjVO74O957fDLN9iaP7e8fKoilmRludsSajIuM5OnOz8xjI+Jt1GMqwSFomobT1HMqYwYP/cpKpyqXQEWueTz2DXO2mQQvApc4v4/8oPdl9FvBdBj2I5RqDVH1oPLfj2op6nf0X4qsuM2++kYeZcQZprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086246; c=relaxed/simple;
	bh=x1+k2VVwyMidazrUOXCE1ixNy96bzakjLfcXmD4JUA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlF7EBHxZIRnuo9qVsPYS/CmTy6Ft8Ji4+N2UFEvBWrIgyGEeS88tMNfDNP4KQ1NnwFnXoO7s5XlUJLQFr2zbEPdklkudqLwopQUhOgyqHT8LixmDLtNEKYQj9zlqlQaitWSyhbVeLCZvswZ9+u/MCA2vDQ3wEq4K1it/UGzwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8BDC106F;
	Tue,  7 May 2024 05:51:09 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC1DC3F793;
	Tue,  7 May 2024 05:50:41 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org,
	Hongyan Xia <Hongyan.Xia2@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: [RFC PATCH v3 1/6] Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0"
Date: Tue,  7 May 2024 13:50:24 +0100
Message-Id: <caacc75509f501da22bd194d0e37348fdf6f7242.1715082714.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715082714.git.hongyan.xia2@arm.com>
References: <cover.1715082714.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyan Xia <Hongyan.Xia2@arm.com>

That commit creates further problems because 0 spare capacity can be
either a real indication that the CPU is maxed out, or the CPU is
UCLAMP_MAX throttled, but we end up giving all of them a chance which
can results in bogus energy calculations. It also tends to schedule
tasks on the same CPU and requires load balancing patches. Sum
aggregation solves these problems and this patch is not needed.

This reverts commit 6b00a40147653c8ea748e8f4396510f252763364.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9eb63573110c..ef5bb576ac65 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8022,10 +8022,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_actual_cap, util;
-		long prev_spare_cap = -1, max_spare_cap = -1;
+		unsigned long cur_delta, max_spare_cap = 0;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long cur_delta, base_energy;
+		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
+		unsigned long base_energy;
 		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
@@ -8087,7 +8088,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -8099,7 +8100,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -8107,7 +8108,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > -1) {
+		if (prev_spare_cap > 0) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.34.1


