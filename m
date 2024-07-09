Return-Path: <linux-kernel+bounces-246636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732C92C494
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862C81F2372D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE71527B6;
	Tue,  9 Jul 2024 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRBJ/T71"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4B185639
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557157; cv=none; b=atBUWVONEb8cJ8cP/+z5/yAHhUusu5E8JBLfHE9m1j4bNbet9u9X2awhwxGLxC99Tj9Ee5WR98s2uAp30UwDT3/2dcbj8IoXqjIllaLR7Z/0hY2dRN1ttrUg2YblgEnQvQJr52wJShVSTVwbLevODJ7KdIVXs4e+bYNIRuuQLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557157; c=relaxed/simple;
	bh=oQTA8x65GQzVtig5DcSmr8Ibwy1iNnjZMuGwkCWZtXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p9I+hxd2ZGI/Y1N5J0SFbIaNq8b6C2M0bi3CRCyXmF8hZ8fEiMS4smwR2qmX5m/D74bncYs8fcx+V5muTGkAHZGfgGTvzpi26LjsHfLB0dAsnl4/bK4jgj4JyceM4ybVbNxvvQXxTna3Tpq2fzOzvzyZF5dX9B7C+6bG1FiDesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRBJ/T71; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c1a9e8d3b0so5116937a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557155; x=1721161955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SK4jF2z7xl5uoUAgslE/9jLcJAWwxsMsuk73k7nd2+0=;
        b=WRBJ/T71/bmxhqzlCuBznydgPqvt2TJHsKCxdgkM2qdivlftAxd1eFPDDIGduugl9Q
         X7pG/R3zrhsdKOMnLjD6a63+FlZVOben5hGUDcrPf7kL8XH7JxcxDDRZiyDHGIby2U6q
         CbQlIuj5SZ3wzZQbSI8wORhH2tIEYyiADBHZQ7KNPEs73mY95PHoWMWaKkSuLE9AJrCd
         2xZXSresuRsVqnfb0H9EqgEsOcYIbiZHNEFSp8EAAsnjOTKhTfDmELP2KyIM7b/iV6ub
         MZQnktuXmSNs6fafUF0jx0OISkJurkXsd3Lj9gGaWg9EWjzJVOgW6I7d2QFHL/lC0Ozr
         TMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557155; x=1721161955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SK4jF2z7xl5uoUAgslE/9jLcJAWwxsMsuk73k7nd2+0=;
        b=Kp/Uh3AfDr80Z3Ex9WSuZgGIEFM+fXupc/1iBEQmChomCkv+97OdyJfZBtkPQwImff
         huOogw5HcQuz/2j+Og/qME2BBfq1/9j5wMpQC+EMQ1L0PTbh/LInt572beP+ALvwYaWv
         ZuBrhdNL+n3d4Sc5eaXV34cFRCSeETYYaKy7PgPSD9tCB1Cm/NDzPb9fLNnnjRUuadd+
         WPgYymQrPpD8DkDwGSl7F23zyZpOkMBYqBbj69kQRJedeCQ6+lMstFSQLbSoTwAytsfS
         fIH+LFSUreqYSdV9OHr/+aoMmduJ3yrGBVxzUMGKNpVlxS2mIBEz4lFM8gzJpEovV7bx
         ErrA==
X-Gm-Message-State: AOJu0YysZaGBb04YCMtq1Fg29WYV1uqo9guyubtgySkMc3DZZrPokvHl
	YuP3e2RG5iWm3QIvD04yDk3UxBipHAnb1Ikx0xj7173Fb7pU3LpX3wEhXMHCAEGVLLCeikqUiHC
	thGV3+b1JHOA2eB2X73xjJnD4Nq0UNhA4bWfmwMWU6Ev5qOzcoDQk/rjMnup2tsf0sHorPhQLOx
	yF0NNklEzsYZUmQ7ZolqAAKwIMrxOvuvHInd3pk7mdsJkI
X-Google-Smtp-Source: AGHT+IEvefeNpWBJ9CbUI1hgDOI+7IfAEHN9pnRIlIhRJhJ/mWxMB3uWM2sWWUIxs6D5KtBnBELcK4gb6kAm
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:e610:b0:2c9:6903:a427 with SMTP id
 98e67ed59e1d1-2ca35be7eb9mr87390a91.1.1720557154317; Tue, 09 Jul 2024
 13:32:34 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:47 -0700
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-5-jstultz@google.com>
Subject: [PATCH v11 4/7] sched: Add move_queued_task_locked helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	John Stultz <jstultz@google.com>, Metin Kaya <metin.kaya@arm.com>
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
Cc: Youssef Esmat <youssefesmat@google.com>
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
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch]
Signed-off-by: John Stultz <jstultz@google.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
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
index bcf2c4cc0522..5e63dbcbc1f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2712,9 +2712,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		move_queued_task_locked(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
@@ -3414,9 +3412,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		rq_pin_lock(src_rq, &srf);
 		rq_pin_lock(dst_rq, &drf);
 
-		deactivate_task(src_rq, p, 0);
-		set_task_cpu(p, cpu);
-		activate_task(dst_rq, p, 0);
+		move_queued_task_locked(src_rq, dst_rq, p);
 		wakeup_preempt(dst_rq, p, 0);
 
 		rq_unpin_lock(dst_rq, &drf);
@@ -6369,10 +6365,7 @@ static bool try_steal_cookie(int this, int that)
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
index c75d1307d86d..3e05e239f5f6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2442,9 +2442,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	move_queued_task_locked(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2530,9 +2528,7 @@ static void pull_dl_task(struct rq *this_rq)
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
index aa4c1c874fa4..55bb33f367ad 100644
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
index a831af102070..a24286059a6a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3479,5 +3479,17 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
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
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.45.2.993.g49e7a77208-goog


