Return-Path: <linux-kernel+bounces-575595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E47A70491
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8531166A21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426825B691;
	Tue, 25 Mar 2025 15:06:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D1C25B687
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915183; cv=none; b=nUvQQSnZ+QU6xnTdF8+H8T8wXzJw3qDtFqVa6NVYQaMfNVVSrP/LxxeOgg78snydBF3Rr1A35EWpoTaQU1nKkb4juOMJuXifmfrueLa0SfSwyvPnrc2nr3+l1buhsP9fPPY0QEMktVKFh6IwE5O2RR+YRSv4A8QR4YW53OVsO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915183; c=relaxed/simple;
	bh=PvyYpzUXhELSq3ybRCk73kUVLP1N1ZA9qdunL3naoMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqatePV8N8e9Xy64gqd0fTXZl6aT0wOQzbbtLUwwsmgvI/tQM9ef7JXtpF3t363jd3RgYUrsPaL2/DUaiFBjcmZYKhRDceqddimpScFF+MvrOq8cRXH7aD7NkPTJEeUKKlQPEto7GBuE5sOx3a3nVBt5ktv3HgHWsLf5ZMUH6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94421756;
	Tue, 25 Mar 2025 08:06:23 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.14.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF1043F58B;
	Tue, 25 Mar 2025 08:06:14 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Chritian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
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
Subject: [PATCH] sched/fair: Allow decaying util_est when util_avg > CPU capa
Date: Tue, 25 Mar 2025 16:05:41 +0100
Message-Id: <20250325150542.1077344-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 10a35e6812aa ("sched/pelt: Skip updating util_est when
utilization is higher than CPU's capacity")
prevents util_est from being updated if util_avg is higher than the
underlying CPU capacity to avoid overestimating the task when the CPU
is capped (due to thermal issue for instance). In this scenario, the
task will miss its deadlines and start overlapping its wake-up events
for instance. The task will appear as always running when the CPU is
just not powerful enough to allow having a good estimation of the
task.

commit b8c96361402a ("sched/fair/util_est: Implement faster ramp-up
EWMA on utilization increases")
sets ewma to util_avg when ewma > util_avg, allowing ewma to quickly
grow instead of slowly converge to the new util_avg value when a task
profile changes from small to big.

However, the 2 conditions:
- Check util_avg against max CPU capacity
- Check whether util_est > util_avg
are placed in an order such as it is possible to set util_est to a
value higher than the CPU capacity if util_est > util_avg, but
util_est is prevented to decay as long as:
CPU capacity < util_avg < util_est.

Just remove the check as either:
1.
There is idle time on the CPU. In that case the util_avg value of the
task is actually correct. It is possible that the task missed a
deadline and appears bigger, but this is also the case when the
util_avg of the task is lower than the maximum CPU capacity.
2.
There is no idle time. In that case, the util_avg value might aswell
be an under estimation of the size of the task.
It is possible that undesired frequency spikes will appear when the
task is later enqueued with an inflated util_est value, but the
frequency spike might aswell be deserved. The absence of idle time
prevents from drawing any conclusion.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c798d2795243..de7687e579c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4918,13 +4918,6 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (last_ewma_diff < UTIL_EST_MARGIN)
 		goto done;
 
-	/*
-	 * To avoid overestimation of actual task utilization, skip updates if
-	 * we cannot grant there is idle time in this CPU.
-	 */
-	if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
-		return;
-
 	/*
 	 * To avoid underestimate of task utilization, skip updates of EWMA if
 	 * we cannot grant that thread got all CPU time it wanted.
-- 
2.25.1


