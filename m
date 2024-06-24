Return-Path: <linux-kernel+bounces-227023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3318E91475D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638F71C233DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C9137755;
	Mon, 24 Jun 2024 10:24:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9C2136E1A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224647; cv=none; b=hGLFf8XF4TZs0CHNNoNs990uUfzC9l61StSDblBSadGgtDE9/bJ2gwVV4EOsT0jTqx/TYuPwh9Yvhr/qgpYobyPX9ClG0e4HmT5T6VqP3Kkt3YgIc7a+moX5qw9BXH9/qIT0tzXxRh5eko2NgLkK88OKJRQ1lTc4Cs6PLge4MOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224647; c=relaxed/simple;
	bh=zr1bNmbnSH/iHggyquhCm1tAbo6P9Nb6vXtmFOhx/8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8XLUMU0flbyNhF058M80rSu3fYpCWu9EVZpRYHoJHYYgz7G8q8fzOGvIP3xr5Uw8oDW5YqwdoYtCTHENmVmjWXbTHcRt9nQwkjIOIJ38EBzZy5G6pwB5tBlo6/kTHzvEOzKyyZziIRuDbv8GLg5Zj6aXFA7ZqoTWlKoKrGHKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07A87FEC;
	Mon, 24 Jun 2024 03:24:30 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2FA3F766;
	Mon, 24 Jun 2024 03:24:02 -0700 (PDT)
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
	Pierre Gondois <pierre.gondois@arm.com>,
	Youssef Esmat <youssefesmat@google.com>,
	linux-kernel@vger.kernel.org,
	Hongyan Xia <Hongyan.Xia2@arm.com>
Subject: [PATCH 1/7] Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0"
Date: Mon, 24 Jun 2024 11:23:50 +0100
Message-Id: <816d80b45081ead13927c86be998c21db03b5ddf.1719223916.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719223916.git.hongyan.xia2@arm.com>
References: <cover.1719223916.git.hongyan.xia2@arm.com>
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
index 41b58387023d..2f8ed6561a9f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8028,10 +8028,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -8093,7 +8094,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -8105,7 +8106,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -8113,7 +8114,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > -1) {
+		if (prev_spare_cap > 0) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.34.1


