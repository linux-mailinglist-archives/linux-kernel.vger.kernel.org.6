Return-Path: <linux-kernel+bounces-264111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D3093DF0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24974286C6D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0013AA4C;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i57wwRoU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA2763EE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078149; cv=none; b=CD1Oj8VTnjKg26YjWuySBNxrI91GeJufrxsuzWlAIipdgo8G9xM9CSQVLzGWpUm9d96FDLaLMnmgWZkqNhdnYz5GTj6oBlAAldFlgtQkhV8lzv6eouSU+L9whqjMWlotwZqyw8Ye9GT1fKCMD8uaO0l/a4daFxf0LT6qI23mAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078149; c=relaxed/simple;
	bh=W7ixlBVpjk3Ug3BVDum/bSfV7lclGNSQIxdbcrz6DBI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m1HWq3kgvFV53jKgKcn/cVmPmSjGGrZhP/HCfAaInTs1a/uRUjum3JLWEUfHw8JVN/zImg94otrWoSQ6Bp3JfVjl61gGR/p4VWvMjYVWyQC8e0mhvNBMCZ9dTNGUxJbYFQZyAzrKmNJ1M+raUcPSbLZTdbkYZRmNO74tZTT9VCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i57wwRoU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Zafh4zVDUAS/FH2BtZM4nOsdVxbLhzdki+RYH2NkTR8=; b=i57wwRoUpYQrtEV06H3CCV7tqU
	IE+v6U57JWNB5MxyZ4WE+CCyw8u/bcn+LZhPsuDZpaAttlKtEB5s/8r7t2oSXPNADQiq4hf2oAHwS
	pqV5PCpnp9iDmPAdc0PlFi/AFzEEm17SO06Q3yPMhlAuA79JaLBHr3kcgOOVxdQo4Iv+wGeMFnH12
	+l+5WGvZTNEzTXm2MPQU0j2GV2qJjn2tVsVy6kke9m6tudhX+k0G/L0AwkfEMqITUzoyNn4TE2V7a
	P6SB9N4bAssowPiTNugh4Q/KLQUVrUeb9eNeW84RAI+DJ5zAEpb/7qptz4w21uBlZi/czKmrGCwf7
	lzjdJ8Cg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-0000000BGJS-1d2B;
	Sat, 27 Jul 2024 11:02:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CB99C3061AB; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.888107381@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:46 +0200
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
Subject: [PATCH 14/24] sched/fair: Implement ENQUEUE_DELAYED
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Doing a wakeup on a delayed dequeue task is about as simple as it
sounds -- remove the delayed mark and enjoy the fact it was actually
still on the runqueue.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5290,6 +5290,9 @@ static inline int cfs_rq_throttled(struc
 static inline bool cfs_bandwidth_used(void);
 
 static void
+requeue_delayed_entity(struct sched_entity *se);
+
+static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool curr = cfs_rq->curr == se;
@@ -5922,8 +5925,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
-		if (se->on_rq)
+		if (se->on_rq) {
+			SCHED_WARN_ON(se->sched_delayed);
 			break;
+		}
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
@@ -6773,6 +6778,22 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+static void
+requeue_delayed_entity(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	/*
+	 * se->sched_delayed should imply both: se->on_rq == 1.
+	 * Because a delayed entity is one that is still on
+	 * the runqueue competing until elegibility.
+	 */
+	SCHED_WARN_ON(!se->sched_delayed);
+	SCHED_WARN_ON(!se->on_rq);
+
+	se->sched_delayed = 0;
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -6787,6 +6812,11 @@ enqueue_task_fair(struct rq *rq, struct
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 
+	if (flags & ENQUEUE_DELAYED) {
+		requeue_delayed_entity(se);
+		return;
+	}
+
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
@@ -6804,8 +6834,11 @@ enqueue_task_fair(struct rq *rq, struct
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
-		if (se->on_rq)
+		if (se->on_rq) {
+			if (se->sched_delayed)
+				requeue_delayed_entity(se);
 			break;
+		}
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, flags);
 



