Return-Path: <linux-kernel+bounces-264097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D0093DEF9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D969284574
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA67D3E4;
	Sat, 27 Jul 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CN3niHGc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33D4D8BA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078146; cv=none; b=HMe3HCpS+w1YfEdxCShTcwgL2ldAVj0ZnG5IgCotAb3Osov7G7MkjNOmKSmXi2PThxEQ+ZVAlQirkywCYCMmQN5HajytJwFsDupcRAsAsHC6gGlN9OGal6iEnf4GrKAit/TrZGWXLTXWEFsrwHTyoMwt/hd7mb2Try3eyrjfiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078146; c=relaxed/simple;
	bh=/zltB2EK2a6pfqmWxiWhbdjIPYlwOWl743k4KtsH9c8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=c8OGIvTwrYmJvYZX+7F7/G4E/UHfepH00NG3NJcjlQOFjINKLGmonTW3h0ajjlujD1GscZYjcXueZZCvw90MCGV2k+jwsbVRSEI/Ig38izE2CzJqNLqthDaHz3EokFQVrkd3rlEaSNlklVUAGdQf0KlGfFCJ95thAAi5oGxi6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CN3niHGc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=HBhWBQhAOUn18prUd0sfKay2l2ePtm4YMSYD6/f8bCc=; b=CN3niHGcpkYouJ81CdwRBR99D8
	ve7jMLksCiNf1+vuldGmF5xhvfMZBYnXX8JCx87MQg1HIyEW7GxRJRPYpLl63NqfUFDRbuTcG/KuH
	3D5/aHdk9tORr0MOSdGPvNNnCgVoh0RCQ7T85dm4Y0y17Ft+ZUqI+TKhIxULhGvxM38oFpgLJudMi
	n/DPCapqPHpFOfvPcsIcinFWG3bdNYxbi4zP+cCOEf6kHHEEBD/7iFdi35pliSSHbDYPJydAARl3z
	yPq1R5+4M0jsSofu/LUf5Ga15LJV9K6wpiq4RvNFMGqwyS5VNBLBu1cYdqSwhJpJkA7QAnv3SGDbp
	HAWEBl3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBh-00000004QMw-1rrD;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EA93730624A; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105030.625119246@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 20/24] sched/fair: Avoid re-setting virtual deadline on migrations
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

During OSPM24 Youssef noted that migrations are re-setting the virtual
deadline. Notably everything that does a dequeue-enqueue, like setting
nice, changing preferred numa-node, and a myriad of other random crap,
will cause this to happen.

This shouldn't be. Preserve the relative virtual deadline across such
dequeue/enqueue cycles.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    6 ++++--
 kernel/sched/fair.c     |   23 ++++++++++++++++++-----
 kernel/sched/features.h |    4 ++++
 3 files changed, 26 insertions(+), 7 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -542,8 +542,10 @@ struct sched_entity {
 	u64				min_vruntime;
 
 	struct list_head		group_node;
-	unsigned int			on_rq;
-	unsigned int			sched_delayed;
+	unsigned char			on_rq;
+	unsigned char			sched_delayed;
+	unsigned char			rel_deadline;
+					/* hole */
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5270,6 +5270,12 @@ place_entity(struct cfs_rq *cfs_rq, stru
 
 	se->vruntime = vruntime - lag;
 
+	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {
+		se->deadline += se->vruntime;
+		se->rel_deadline = 0;
+		return;
+	}
+
 	/*
 	 * When joining the competition; the existing tasks will be,
 	 * on average, halfway through their slice, as such start tasks
@@ -5382,6 +5388,8 @@ static __always_inline void return_cfs_r
 static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	bool sleep = flags & DEQUEUE_SLEEP;
+
 	if (flags & DEQUEUE_DELAYED) {
 		/*
 		 * DEQUEUE_DELAYED is typically called from pick_next_entity()
@@ -5391,19 +5399,18 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 		SCHED_WARN_ON(!se->sched_delayed);
 		se->sched_delayed = 0;
 	} else {
-		bool sleep = flags & DEQUEUE_SLEEP;
-
+		bool delay = sleep;
 		/*
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
 		 * states must not suffer spurious wakeups, excempt them.
 		 */
 		if (flags & DEQUEUE_SPECIAL)
-			sleep = false;
+			delay = false;
 
-		SCHED_WARN_ON(sleep && se->sched_delayed);
+		SCHED_WARN_ON(delay && se->sched_delayed);
 		update_curr(cfs_rq);
 
-		if (sched_feat(DELAY_DEQUEUE) && sleep &&
+		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
@@ -5434,6 +5441,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 	clear_buddies(cfs_rq, se);
 
 	update_entity_lag(cfs_rq, se);
+	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
+		se->deadline -= se->vruntime;
+		se->rel_deadline = 1;
+	}
+
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
@@ -13024,6 +13036,7 @@ static void switched_from_fair(struct rq
 	 * over the excursion into the new class.
 	 */
 	p->se.vlag = 0;
+	p->se.rel_deadline = 0;
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -10,6 +10,10 @@ SCHED_FEAT(PLACE_LAG, true)
  */
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 /*
+ * Preserve relative virtual deadline on 'migration'.
+ */
+SCHED_FEAT(PLACE_REL_DEADLINE, true)
+/*
  * Inhibit (wakeup) preemption until the current task has either matched the
  * 0-lag point or until is has exhausted it's slice.
  */



