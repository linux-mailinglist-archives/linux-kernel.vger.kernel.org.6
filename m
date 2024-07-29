Return-Path: <linux-kernel+bounces-265202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4DC93EDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3281282F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150C82D66;
	Mon, 29 Jul 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECs1oouk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A474058
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236707; cv=none; b=YshDmsGh/YESMPumva8iWqT3Q1705sJBfg66LMe07g5HaLxLxtqllnc1RMbA/LD1EXOHXnxqo1UWYQ1isFiVJSnIHVeHbsoZshZsB6z+MfwjLatnHJlX9lovC6YwCoF1TFBn/cBP7+XBKvQt7Ns6UMWgDG4QgKFyBZMpg9dcJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236707; c=relaxed/simple;
	bh=+WnqdO4kZvaH3M3pMdG2N51px89ilVhw1MS9zBlIZ14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mEgMzZ5u5EPCS8QoFNj/ZrELjbNal4Sek74Uuf+EcbouuQNKHLUZ4MCwFyTY2vo9szdUZklBisAPVA5X/M2sVWu55QU615EPMqOiHIk1pUgjGclcY0pnvsAPaqei7iygtPckblIa8qDBsIk97+6ahhZOcer1s2pWi7diBzM6NdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECs1oouk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722236706; x=1753772706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+WnqdO4kZvaH3M3pMdG2N51px89ilVhw1MS9zBlIZ14=;
  b=ECs1ooukpEDejEc18p45SCQKNVlkVUmGgV3QfGNMXwF4gLU7JC6Gun5q
   y2Dut2ZSe1K6A16s3yJJSKEiaOvmTd38w/5tD9fYWXJOB9jyTM7EB+04h
   BWmc9Cx/J3vNp1ke0Mvf/Ynw3DIWyIAla0mePEdcG1lKELGfthnnPwwxZ
   wXRJUVTG2Jf1lImGejanMFcnlev0vj72zKVsJKaKn7DP4SNwXhmGEjBZD
   q8dk4LUpCM3m+E68VDTDZ7q0aGa4PeIWGH6AIjQJCIDyfpCf1zZztN1Bz
   t+NjQpDRrKWq8AKSrokdpC88R02Uq9Q9mhcAsJoECSN6zgqKYTd8ltgpz
   Q==;
X-CSE-ConnectionGUID: CK7MLvzOS1aqAxUz8EGv/A==
X-CSE-MsgGUID: FB+VVBSwShmuT2W9NZu65Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="12762424"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="12762424"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 00:05:05 -0700
X-CSE-ConnectionGUID: V9AVe14KTO+sdi7qoWp5og==
X-CSE-MsgGUID: lZQYlqPKTy2x1rQuV1iNrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54122815"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa006.jf.intel.com with ESMTP; 29 Jul 2024 00:05:01 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>,
	Qais Yousef <qyousef@layalina.io>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v3] sched/pelt: Use rq_clock_task() for hw_pressure
Date: Mon, 29 Jul 2024 15:00:29 +0800
Message-Id: <20240729070029.407884-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
removed the decay_shift for hw_pressure. This commit uses the
sched_clock_task() in sched_tick() while it replaces the
sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
This could bring inconsistence. One possible scenario I can think of
is in ___update_load_sum():

u64 delta = now - sa->last_update_time

'now' could be calculated by rq_clock_pelt() from
__update_blocked_others(), and last_update_time was calculated by
rq_clock_task() previously from sched_tick(). Usually the former
chases after the latter, it cause a very large 'delta' and brings
unexpected behavior.

Fix this by using rq_clock_task() inside update_hw_load_avg(),
because:
1. hw_pressure doesn't care about invariance.
2. avoid any inconsistence in the future.

Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
Suggested-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2>v3:
  call rq_clock_task() inside update_hw_load_avg() to avoid any
  inconsistence in the future. (Qais Yousef)
  Added comments around update_hw_load_avg(). (Qais Yousef)
v1->v2:
  Added Hongyan's Reviewed-by tag.
  Removed the Reported-by/Closes tags because they are not related
  to this fix.(Hongyan Xia)
---
 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 2 +-
 kernel/sched/pelt.c | 5 +++--
 kernel/sched/pelt.h | 6 +++---
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f655025607..011d447e065f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5462,7 +5462,7 @@ void sched_tick(void)
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
+	update_hw_load_avg(rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..193ac2c702d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(now, rq, hw_pressure) |
+		  update_hw_load_avg(rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fa52906a4478..06a5fa85327c 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -400,9 +400,10 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
  *			capped capacity a cpu due to a HW event.
  */
 
-int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
+int update_hw_load_avg(struct rq *rq, u64 capacity)
 {
-	if (___update_load_sum(now, &rq->avg_hw,
+	/* hw_pressure doesn't care about invariance */
+	if (___update_load_sum(rq_clock_task(rq), &rq->avg_hw,
 			       capacity,
 			       capacity,
 			       capacity)) {
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 2150062949d4..261172c29f8f 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -8,7 +8,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
 #ifdef CONFIG_SCHED_HW_PRESSURE
-int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
+int update_hw_load_avg(struct rq *rq, u64 capacity);
 
 static inline u64 hw_load_avg(struct rq *rq)
 {
@@ -16,7 +16,7 @@ static inline u64 hw_load_avg(struct rq *rq)
 }
 #else
 static inline int
-update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
+update_hw_load_avg(struct rq *rq, u64 capacity)
 {
 	return 0;
 }
@@ -202,7 +202,7 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
-update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
+update_hw_load_avg(struct rq *rq, u64 capacity)
 {
 	return 0;
 }
-- 
2.25.1


