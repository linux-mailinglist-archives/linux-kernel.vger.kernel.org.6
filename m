Return-Path: <linux-kernel+bounces-361965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765599AF61
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C4828943F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC521E9073;
	Fri, 11 Oct 2024 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUIe64eR"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0F1E7670
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689147; cv=none; b=pwF5sEFm7JiQRw8aTlKb+MA6rvC1Q9XpcV3yP1K3aH8qZmgIAO83FJZVxmFdDkbmZC4dxLa93YTCgiYcAtuhUWH14gpEF4eEysFM+cB3nbpHCzjS3tvgwBHnRmI4JN4MX/YXW4Aj49jzi3kxEsngiuI/PbgJmAb6Qd7nNmaGH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689147; c=relaxed/simple;
	bh=2MMOxSmQOaj45c8JI7ITrThZt6Tw6kmxdn7MPxX8Zj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pit7BXNQkoyeu9dNWYObOJB+JCwC6inHG9GyUO5OPwX3XvsNYzDGUnzLnyWCUT+fM5TpPMQN9v6xUFRJCK/XtlZpAbX99F1iSj4G0iYnj7L7/rRhJl+bpqGYm4Y7PwfWphsqF3vsJffcbbGNJVGiaXlhJMirk5HM+TSupyELHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUIe64eR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea0069a8b0so2476469a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728689144; x=1729293944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmdfVKli6f+t2i8KGgDxePHnjVWNTK9utMAJ0OxuThg=;
        b=VUIe64eR1CHi4pTsbuiCZdZGQlVO7D8/m6eVKz0E6Sj5zTzCnbbcNfx0W/7aetyCpE
         kuhy0ZmMBCAIeUbZ3mMQc1E9wWLYdn78UQiAB48imUJa6VJ0Jm3EYqXUxP49nevRTQZM
         HTQnDWuCptsxL66yGSobea+n0mjk2DlHoqRvCWSkrEJy1fFWDbYIp0NyEdlBT2I9whBN
         2w0DQFZeJx7R5kywMzDj4RS2SJu9b9AB050wrj51Oc6yBRQZYBLjPTKlaZ0UIEnjy1qr
         ZDuFmOWg/RO7GceF95o3Jkgq3XMwNm8wPKF1mkYwQVuKgFvW9g8/rM80qnMCGBod5EpL
         lr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689144; x=1729293944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmdfVKli6f+t2i8KGgDxePHnjVWNTK9utMAJ0OxuThg=;
        b=EdVo+BgcV9st0I7QaOAgqC3vFd14pAIqlNdBT2/KZ7qPLcXCxPawchTOjDOTaj24hy
         /J80dR1D/rnsVARRjZmGA7gjlFpgOPN1WqIQlzheU/XsqgPD222nrVNRxXnQJZvipOQv
         4kDpQ1iMvyuTilQi1WepTXGLEHyyudBX4Pd5I6+LOj7u4o6tjiNhjcSNUh26EGWMQNXN
         xLoqpPuijMPja60wp6AL7xn4euAmcYVz/sSi4BQsaXFZgYETeea39abQQcPrbn2Mxjgw
         xs5PU/qyMNNUZssYCFpG3a0mEFusDSHyARY3lcDmxKVn1MUIm+8nKnzIEz+x4FBYEJQj
         bjQQ==
X-Gm-Message-State: AOJu0Ywp9/MXtOrat6ko8Fl2OYpNlH7BGlbFGiNO1EGwMbDEhDGzRZS0
	hXdyi8adhgw+uSU7lvELjcXbhXSassYEC6FT306cD75D8Y/fKp05qxMjQHctXkxK4O/fCFSw0Jq
	JWcEuBhLY1BUXBpEOpJ1yLFs6lloYRU3iaFgV234OjiK0VcB0IV3WTffl5gr2E16H1KHQTsmlB7
	sJBtG4nrRGdnD2TH/mbT0ryorHHETJDGM4ks/EmY2Ll/80
X-Google-Smtp-Source: AGHT+IEbAY3tUbeddT/n7uJQtatQtjVyFSsRZDwaIBPWNPSgL5WFmRrvAG+MDLJ1h8NYBadiOpOyoi+88I53
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:9a94:b0:2e2:da81:40c1 with SMTP id
 98e67ed59e1d1-2e2f09f2280mr6662a91.1.1728689142910; Fri, 11 Oct 2024 16:25:42
 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:25:16 -0700
In-Reply-To: <20241011232525.2513424-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011232525.2513424-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011232525.2513424-5-jstultz@google.com>
Subject: [PATCH v13 4/7] sched: Add move_queued_task_locked helper
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
index 43e453ab7e20..615fc7a7b17c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2615,9 +2615,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		move_queued_task_locked(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
@@ -3303,9 +3301,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		rq_pin_lock(src_rq, &srf);
 		rq_pin_lock(dst_rq, &drf);
 
-		deactivate_task(src_rq, p, 0);
-		set_task_cpu(p, cpu);
-		activate_task(dst_rq, p, 0);
+		move_queued_task_locked(src_rq, dst_rq, p);
 		wakeup_preempt(dst_rq, p, 0);
 
 		rq_unpin_lock(dst_rq, &drf);
@@ -6293,10 +6289,7 @@ static bool try_steal_cookie(int this, int that)
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
index 9ce93d0bf452..6c87d812efbe 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2751,9 +2751,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	move_queued_task_locked(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2839,9 +2837,7 @@ static void pull_dl_task(struct rq *this_rq)
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
index 172c588de542..e2506ab33c97 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2088,9 +2088,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	move_queued_task_locked(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2361,9 +2359,7 @@ static void pull_rt_task(struct rq *this_rq)
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
index b1c3588a8f00..b904a5004eae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3768,6 +3768,18 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
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
2.47.0.rc1.288.g06298d1525-goog


