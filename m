Return-Path: <linux-kernel+bounces-264091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C12F93DEF3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9021F222EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E06F2E0;
	Sat, 27 Jul 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VmNcrTiY"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3754D8BC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078145; cv=none; b=i9K7Vanb9cOLVJG1488SMxjNm6o5ERK1rgzDM2AWo4nUE4Ex+FlY6TSYnHWAz+oQD1JY8iJd8wT32QO0gxNXO/6NDIrWfkER8iRQ8dLPpI3Wqv5vN8thOk108n1XN+p0pYXI0kaC6Lzwg0I6mn/t+uz7otgIZnEzjcZg7t7RR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078145; c=relaxed/simple;
	bh=AusR2py2b2TRuwPprHkpWBQD3DFbwMOr/saRKPYpEiQ=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=myOq2uI3lUVWd5uIsiSlKqfbY18GG6koWMOJiTJNFBtc0UD7mJsKZp1tWhzW8xJj29UjZP+ujoktL3iK24mP9lT9zUAAYjkAWn/vA5q71rpQ4sB5N0hS6jiJmF6H27WSGbwMokGMEL1EaEitlzL7Nn8L/IEDM7FE1YDfUze0HmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VmNcrTiY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=GEYq0WT0f8wEWJeuTVZAcjZJLXV5clrhaBXbfYQp8uw=; b=VmNcrTiYGi6zQh4baBY+HNO137
	w7pipouNodq3ubvglYHyBRkT3J6aE+Q5iTHyaTcf4eCwstlICtXvU/QoeJmjiLiSiXjsR8KKsdcz0
	Xa0QsQS12AzsjMuKQ/SfJdIkZhgUoPDr5sGIxWlfC0qdn5tsCPjnlZalbYWrv18YPSTGaomV884iQ
	Cslz1vcBthY4Z75gaPEi7Nn9Ow9Us5i5vw08OWfyPZPFL503dnT14y8gtnlS8SKThpJIor+QFwF1u
	ibfkOYFyGzmrqTtrjxljW/REMGDQEknQaxgvmjxkLeS/IdIfyUDS2JzK7CE72Poje55iLF1TbZ1jj
	xOqCzgOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBf-00000004QMZ-2MAE;
	Sat, 27 Jul 2024 11:02:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 92671300820; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105028.395297941@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:34 +0200
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
Subject: [PATCH 02/24] sched/eevdf: Remove min_vruntime_copy
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Since commit e8f331bcc270 ("sched/smp: Use lag to simplify
cross-runqueue placement") the min_vruntime_copy is no longer used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |    5 ++---
 kernel/sched/sched.h |    4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -780,8 +780,7 @@ static void update_min_vruntime(struct c
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	u64_u32_store(cfs_rq->min_vruntime,
-		      __update_min_vruntime(cfs_rq, vruntime));
+	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -12876,7 +12875,7 @@ static void set_next_task_fair(struct rq
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
-	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
+	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,10 +599,6 @@ struct cfs_rq {
 	u64			min_vruntime_fi;
 #endif
 
-#ifndef CONFIG_64BIT
-	u64			min_vruntime_copy;
-#endif
-
 	struct rb_root_cached	tasks_timeline;
 
 	/*



