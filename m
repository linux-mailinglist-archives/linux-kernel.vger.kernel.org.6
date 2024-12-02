Return-Path: <linux-kernel+bounces-427668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4269E07C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE79CB652C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F40203703;
	Mon,  2 Dec 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVrZklnq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F62040B8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148500; cv=none; b=V6ziGiOvcpRg9ejqmIWFFi5o+dX0IkvotQKwBnROqcMepYcSlb43U6gz3EJeNs5VHDqNJ4Xf3BONbJsyEO358J0lOJzDpuyCfxKx1vmeZ8iXYKYkAOA7Je78R075WkJrzWF+YB28+gM9ySHTbvpetVPrtBUEK1315NFtemzei1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148500; c=relaxed/simple;
	bh=Hij2+sULPq2Tuzp6PTd3JydwnzDKFySOX4zpMIHuJJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l73AT+b4S476Q/lJ+xj28ilt/NiFlwquqmRqi3zpMcwqckRTJ65pWz67nNH/z2/RHywxkjG7PcNYRISJU/DOUCfChZ92T8bm9AqTjxO/ObPVnUhFcEXyTN9JlkMep8b4eXv3gZiCxTrtpjWP9leP/bCzNIjO1dDR78vc+aruJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVrZklnq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733148497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmnCD0l9UZTLjIVb+9EMwI4IkQHmNiDDiH/3BqQlf3c=;
	b=QVrZklnq7W60t7Fcxmaxvv5lNqsy7wvNVExeyr79C7wT9yNu14bWhM/J+QhaIUwWbqpCWC
	hx3RxEgC1MUJodqkganQj1xj77yf/nUtCUPYaLIGyWfk9Z7PW/bkzMgAsmm8TA1LoIhRRh
	5ZoDcyJGaSifNwuuoXAPljykxAm+8O4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-5YW4fO_OOduglG3zpZ3YlA-1; Mon,
 02 Dec 2024 09:08:13 -0500
X-MC-Unique: 5YW4fO_OOduglG3zpZ3YlA-1
X-Mimecast-MFC-AGG-ID: 5YW4fO_OOduglG3zpZ3YlA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE5801954AFF;
	Mon,  2 Dec 2024 14:08:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F93195605A;
	Mon,  2 Dec 2024 14:08:06 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 2/2] sched: Move task_mm_cid_work to RCU callback
Date: Mon,  2 Dec 2024 15:07:35 +0100
Message-ID: <20241202140735.56368-3-gmonaco@redhat.com>
In-Reply-To: <20241202140735.56368-1-gmonaco@redhat.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently, the task_mm_cid_work function is called in a task work
triggered by a scheduler tick. This can delay the execution of the
task for the entire duration of the function.

This patch runs the task_mm_cid_work in the RCU callback thread rather
than in the task context before returning to userspace.

The main advantage of this change is that the function can be offloaded
to a different CPU and even preempted by RT tasks.

On a busy system, this may mean the function gets called less often, but
the current behaviour already doesn't provide guarantees.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/sched.h |  1 -
 kernel/sched/core.c   | 17 ++++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..5d141c310917 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1374,7 +1374,6 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 57b50b5952fa..0fc1a972fd4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10520,17 +10520,15 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
 }
 
-static void task_mm_cid_work(struct callback_head *work)
+static void task_mm_cid_work(struct rcu_head *rhp)
 {
 	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
+	struct task_struct *t = container_of(rhp, struct task_struct, rcu);
 	struct cpumask *cidmask;
 	struct mm_struct *mm;
 	int weight, cpu;
 
-	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
-
-	work->next = work;	/* Prevent double-add */
+	rhp->next = rhp;	/* Prevent double-add */
 	if (t->flags & PF_EXITING)
 		return;
 	mm = t->mm;
@@ -10574,23 +10572,20 @@ void init_sched_mm_cid(struct task_struct *t)
 		if (mm_users == 1)
 			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
 }
 
 void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 {
-	struct callback_head *work = &curr->cid_work;
+	struct rcu_head *rhp = &curr->rcu;
 	unsigned long now = jiffies;
 
 	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
+	    rhp->next != rhp)
 		return;
 	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
 		return;
 
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
+	call_rcu(rhp, task_mm_cid_work);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
-- 
2.47.0


