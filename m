Return-Path: <linux-kernel+bounces-358107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70269997A40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B6B1C21BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446E527446;
	Thu, 10 Oct 2024 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOsMUZRP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D13B66C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728524752; cv=none; b=czWH73xGxFue4g7mo5msZTtc8fP55eQy7mOFtau1A/jS9zvXdkuAtw86usMluEA3mIMuyYPGEnP4E5Vqs+5hysAMCSsrMzryDoQpcLr9Z7MK0Nc8Kukx9iY7f5YZc9EjKlUHlNvZOcy6/Btqp2gKXBu3ZGZI8kVF6O7Ddr4c6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728524752; c=relaxed/simple;
	bh=+567s1J+tkFYek+s05uOAF1f4xezsjVVs3hVLYMspQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNHGSqS0s9tKL8tB2q4qT/rVm9EazRVANSVbwrvn3YHQfGlx8arfx6AR+ojS2fcjSZrsgCgPo+0HoFeVmCMHBKRV9hw3L9afF/l379/W/6tuc2xl8Y1Skeij4aVuwDnDzk3NlqmV67UE67nbc1HZwzG5/0E7Am1EMO+0uQ5i2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOsMUZRP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728524749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vJ3L7UNjRJqtMbV6PyQFveasfPHAEGSmGfF+EhlxxfM=;
	b=aOsMUZRPsdTXu/ZGW0ccXqUM0FCHCQcAB6fxs0T1jtPiwsnqtP2ic7DzWqVkrOdG3Ei+3y
	uzjAy3YsE8XGDkuHm7FB7jfM6MZ0kpNA8txysa8JKA2j6/+7d0bfEzgikWXW9dtGuGWL3a
	3HJQGr85gmLV7mraiJkciVxiC105ECI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-PDNCtnSoNWefGxt62t_oRQ-1; Wed,
 09 Oct 2024 21:45:01 -0400
X-MC-Unique: PDNCtnSoNWefGxt62t_oRQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05ADB19560B4;
	Thu, 10 Oct 2024 01:44:59 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.16.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F17E7300018D;
	Thu, 10 Oct 2024 01:44:54 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] sched/core: Disable page allocation in task_tick_mm_cid()
Date: Wed,  9 Oct 2024 21:44:32 -0400
Message-ID: <20241010014432.194742-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With KASAN and PREEMPT_RT enabled, calling task_work_add() in
task_tick_mm_cid() may cause the following splat.

[   63.696416] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   63.696416] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 610, name: modprobe
[   63.696416] preempt_count: 10001, expected: 0
[   63.696416] RCU nest depth: 1, expected: 1

This problem is caused by the following call trace.

  sched_tick() [ acquire rq->__lock ]
   -> task_tick_mm_cid()
    -> task_work_add()
     -> __kasan_record_aux_stack()
      -> kasan_save_stack()
       -> stack_depot_save_flags()
        -> alloc_pages_mpol_noprof()
         -> __alloc_pages_noprof()
	  -> get_page_from_freelist()
	   -> rmqueue()
	    -> rmqueue_pcplist()
	     -> __rmqueue_pcplist()
	      -> rmqueue_bulk()
	       -> rt_spin_lock()

The rq lock is a raw_spinlock_t. We can't sleep while holding
it. IOW, we can't call alloc_pages() in stack_depot_save_flags().

The task_tick_mm_cid() function with its task_work_add() call was
introduced by commit 223baf9d17f2 ("sched: Fix performance regression
introduced by mm_cid") in v6.4 kernel.

Fortunately, there is a kasan_record_aux_stack_noalloc() variant that
calls stack_depot_save_flags() while not allowing it to allocate
new pages.  To allow task_tick_mm_cid() to use task_work without
page allocation, a new TWAF_NO_ALLOC flag is added to enable calling
kasan_record_aux_stack_noalloc() instead of kasan_record_aux_stack()
if set. The task_tick_mm_cid() function is modified to add this new flag.

The possible downside is the missing stack trace in a KASAN report due
to new page allocation required when task_work_add_noallloc() is called
which should be rare.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/task_work.h |  5 ++++-
 kernel/sched/core.c       |  4 +++-
 kernel/task_work.c        | 15 +++++++++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index cf5e7e891a77..2964171856e0 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -14,11 +14,14 @@ init_task_work(struct callback_head *twork, task_work_func_t func)
 }
 
 enum task_work_notify_mode {
-	TWA_NONE,
+	TWA_NONE = 0,
 	TWA_RESUME,
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
 	TWA_NMI_CURRENT,
+
+	TWA_FLAGS = 0xff00,
+	TWAF_NO_ALLOC = 0x0100,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..0259301e572e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10458,7 +10458,9 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 		return;
 	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
 		return;
-	task_work_add(curr, work, TWA_RESUME);
+
+	/* No page allocation under rq lock */
+	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5d14d639ac71..c969f1f26be5 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -55,15 +55,26 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
+	int flags = notify & TWA_FLAGS;
 
+	notify &= ~TWA_FLAGS;
 	if (notify == TWA_NMI_CURRENT) {
 		if (WARN_ON_ONCE(task != current))
 			return -EINVAL;
 		if (!IS_ENABLED(CONFIG_IRQ_WORK))
 			return -EINVAL;
 	} else {
-		/* record the work call stack in order to print it in KASAN reports */
-		kasan_record_aux_stack(work);
+		/*
+		 * Record the work call stack in order to print it in KASAN
+		 * reports.
+		 *
+		 * Note that stack allocation can fail if TWAF_NO_ALLOC flag
+		 * is set and new page is needed to expand the stack buffer.
+		 */
+		if (flags & TWAF_NO_ALLOC)
+			kasan_record_aux_stack_noalloc(work);
+		else
+			kasan_record_aux_stack(work);
 	}
 
 	head = READ_ONCE(task->task_works);
-- 
2.46.2


