Return-Path: <linux-kernel+bounces-285647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95C9510CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B02B1F226BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064851AE023;
	Tue, 13 Aug 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1ThMih6"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3E1AD9F1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593473; cv=none; b=Uxjz9+wDQE8qoNefUsCqDnJBmvA4y71xVc8z4WSkCPTkPMsHAXCCBA40tcjP9jPsaUhGua0DzyF27xIrivjOr1bNkAUhBNnV3eRc/KTc01PXWlz0xUKCfsZImKR8dVHFGqNRnTLGeekRb5udtlrojyao/oT9wfhNBm6fzr27rt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593473; c=relaxed/simple;
	bh=DWPs4SV/XxvHTKnZdzeb2EqzpKCgSM2b8oASo6TlIYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLo4yv+SDC456WvzRSTSTDOXazKib2upX1TFqC+ZjZo5K+tihEKC8mo38tdutG/xudJIMxxakIsfsSFnsK8v1F6Rj/nLpGakm/M9r/p2A3tBrQGPV0Xzw9291UAF7kyTtJnAQhZUsVCl+X0p8AMU67DFQHCqqm9C17i8jkt2aL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1ThMih6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7c6a4d99dbdso313208a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723593470; x=1724198270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl6Cv9KbJgnFMZ+eqlvTgNbykAVOBDxOPbqb8q1hJSU=;
        b=u1ThMih6Nf0ARAnx49WLfiZz+P5dc1yPkhoWvyNB+pgB3/vzmaR4plKHIjdaA76pHj
         v3lSW9tME8FN0ZXgA1qFtr6rI3fREs7ArlgKERUbswFoYz202v+HFVF39yRByAZOlTxh
         6BSWYqA1Z+sOL9z5UYS5gZb+wFolWf35toxULVW2SgFlgcDMXU28pG+UYeumgxNITXbm
         evf7MIby/MkUFCuEDAwKfp8m9nn6IRzN67A/qyYiynBmna8mb6Co8tsckfjSd2bA9fRm
         1QRDahkNKvDrN8XUWCIdLXMwv4+jeIV5awoowjHAb246lJpb8KpSf7FQRVKwoGklsg5z
         tPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723593470; x=1724198270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl6Cv9KbJgnFMZ+eqlvTgNbykAVOBDxOPbqb8q1hJSU=;
        b=LVPbvB1XWzOb1bz53YlDAndhwRH3/wN9nYrxx3wBP2kigjgssjiHvukGtTjdQ2RZlw
         OmTHMGmXmw6DWzrnI6iV+2HZOKLyreYf/8uZsZcqeN4cZJS0fD0AqsfR/fIhZLwCZ82O
         libdvfrtGIJLohfaZVUrWS2gtwAENlaVO+T6WZXWRwm6JCmW3nJiRxEGMKz3vKkgVJwR
         dvjS5l8ewX2tDUCAswjcVJIk7wsy0S8mPEKSfIuYdOEM/wPyY4v3cEHEhaEXkO9uLiUk
         tzqSoCcrMhizJnboOqk+01jVaZY0hUPVj8ao9d6ZDJg5/kQ/hgXjWINcPLOer5TnXQrE
         cXmw==
X-Gm-Message-State: AOJu0YxStpHd1TeRXNh4E+3IlR2Zoiw+7t+qfO7ykMMcHbxNFSOIe51q
	WN6q0NRZEoKHccPw0OX6+w6/TI726R576K54EWXdzWzV4X/CB8/jQwPpUYI+GWv2qdV+Ht0qPtC
	mv2q0fkWu+ghINjqyKnj0bJCQWCc2WL346rmF7GkZMap80jqU/e1vTTG0bR7bgUgInS0rmciyyG
	j1GQe4iS2nP0E39hF9l3SK0kRg9zS/wAUzd4zrqNiUElWH
X-Google-Smtp-Source: AGHT+IEuk1xrYp3foQ30kItvLXgk4yK7S0eafIUSvl/h7h7U6O903kP6ixKLiAvteNTkzy2ZQ/R2/41nQIm9
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:1625:0:b0:7bc:eab6:5469 with SMTP id
 41be03b00d2f7-7c6a56b0893mr541a12.3.1723593468653; Tue, 13 Aug 2024 16:57:48
 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:57:24 -0700
In-Reply-To: <20240813235736.1744280-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813235736.1744280-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813235736.1744280-5-jstultz@google.com>
Subject: [PATCH v12 4/7] sched: Add move_queued_task_locked helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Connor O'Brien <connoro@google.com>

Switch logic that deactivates, sets the task cpu,
and reactivates a task on a different rq to use a
helper that will be later extended to push entire
blocked task chains.

This patch was broken out from a larger chain migration
patch originally by Connor O'Brien.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v8:
* Renamed from push_task_chain to do_push_task so it makes
  more sense without proxy-execution
v10:
* Changed name to move_queued_task_locked as suggested by Valentin
v11:
* Also use new helper in __migrate_swap_task() and
  try_steal_cookie() as suggested by Qais Yousef
* Nit cleanups suggested by Metin
---
 kernel/sched/core.c     | 13 +++----------
 kernel/sched/deadline.c |  8 ++------
 kernel/sched/rt.c       |  8 ++------
 kernel/sched/sched.h    | 12 ++++++++++++
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5b..b2cc20ed14de6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2526,9 +2526,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		move_queued_task_locked(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
@@ -3214,9 +3212,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		rq_pin_lock(src_rq, &srf);
 		rq_pin_lock(dst_rq, &drf);
 
-		deactivate_task(src_rq, p, 0);
-		set_task_cpu(p, cpu);
-		activate_task(dst_rq, p, 0);
+		move_queued_task_locked(src_rq, dst_rq, p);
 		wakeup_preempt(dst_rq, p, 0);
 
 		rq_unpin_lock(dst_rq, &drf);
@@ -6152,10 +6148,7 @@ static bool try_steal_cookie(int this, int that)
 		if (sched_task_is_throttled(p, this))
 			goto next;
 
-		deactivate_task(src, p, 0);
-		set_task_cpu(p, this);
-		activate_task(dst, p, 0);
-
+		move_queued_task_locked(src, dst, p);
 		resched_curr(dst);
 
 		success = true;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f59e5c19d9445..ac60d2819bd1d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2447,9 +2447,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	move_queued_task_locked(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2535,9 +2533,7 @@ static void pull_dl_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				move_queued_task_locked(src_rq, this_rq, p);
 				dmin = p->dl.deadline;
 				resched = true;
 			}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 310523c1b9e3f..496d3e6ab57d2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2105,9 +2105,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	move_queued_task_locked(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2378,9 +2376,7 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				move_queued_task_locked(src_rq, this_rq, p);
 				resched = true;
 			}
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc6803617..d2cc31c2457e5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3575,6 +3575,18 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
+#ifdef CONFIG_SMP
+static inline
+void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_struct *task)
+{
+	lockdep_assert_rq_held(src_rq);
+	lockdep_assert_rq_held(dst_rq);
+
+	deactivate_task(src_rq, task, 0);
+	set_task_cpu(task, dst_rq->cpu);
+	activate_task(dst_rq, task, 0);
+}
+#endif
 
 #ifdef CONFIG_RT_MUTEXES
 
-- 
2.46.0.76.ge559c4bf1a-goog


