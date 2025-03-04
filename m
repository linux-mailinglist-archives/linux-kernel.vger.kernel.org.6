Return-Path: <linux-kernel+bounces-544395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD3A4E0E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E683AFC32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B12066D6;
	Tue,  4 Mar 2025 14:23:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F8205E36
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098212; cv=none; b=jWBBZcCu9nBN5xTRPHEWWj53Vzaqt5L7X6X1IUNjKnOBrOGIsghNjFuXfFxWtc74B9ACn3gGHgBhcRKOjfIx3PXBTJmPbnns5nTLuvqywi/pg3jGZzuvqZo/TCgAOroFx22ioyBneKW/d08FDMEqf+kymY5XjuDsThxGPjUuk+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098212; c=relaxed/simple;
	bh=Hq2UWhVleNV3rRPtc00pqkqQi0ddlRTPYKZ0ga1YvZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLbqO4ompGwNPGuIiDuwgcKh5n8Gg/CB8nREj6gPjg90sNwnSrwd7i6KihgVsHgx1xJwhtmGSIZrqE5ZWpfHgDaYkI83FEKuIqjtQ8F+YiDHwGtlRGXIJtP10BmqPACyUEnv0i3kcBaeRn3Gg+wl3X8a0i82mMqBu/BU4kbmfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1618B1007;
	Tue,  4 Mar 2025 06:23:43 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B74E3F66E;
	Tue,  4 Mar 2025 06:23:27 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Hongyan Xia <Hongyan.Xia2@arm.com>
Subject: [PATCH v2 1/8] Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0"
Date: Tue,  4 Mar 2025 14:23:08 +0000
Message-Id: <4d7dc8f07bede735d307969ca58ed145ff2254eb.1741091349.git.hongyan.xia2@arm.com>
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
index 857808da23d8..71fc86eafbd9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8417,10 +8417,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -8482,7 +8483,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -8494,7 +8495,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -8502,7 +8503,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > -1) {
+		if (prev_spare_cap > 0) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.34.1


