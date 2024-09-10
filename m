Return-Path: <linux-kernel+bounces-323934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5F1974572
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F5D1C24FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A41AC895;
	Tue, 10 Sep 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpvI3ADn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2D1AC431
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006388; cv=none; b=UG5hpmFqABJl0/S5XIiF8bt1BYHX0bd9AprtXOd+1WiR8JJVhnPhd+zHwiTaiDL7p3v/zeNqaFku7NZ9S2PSjt+snaF141MbVG3g0x1o8Bb4iVb4nRhIwQfL/xfoApw3ziju+YfYr/GiItTB0dGHmuvpuVinSBE+P0hnmq6tW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006388; c=relaxed/simple;
	bh=E+tukkaNY2JZnuy2+v/av4ipTY8U4Ethm0a+bNcZjF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sk2iqRNmhf2Rm63wGx3VC3FUtU0pcYvUiJ6MKaLg3haUsdIR0aofbgCa0P6L37rZo+G33R91V9r0Mz+OaOqrPsWOgRnyLsFu6jzR5GLT8Xj2LzltGJFZgbGtyeL8nvAVb0XsPlkMoYQB2UZOWI94RVXG1b44BjIsn9ezhSLxdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpvI3ADn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-207510f3242so6301905ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726006386; x=1726611186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=onUSDzogQBtqDC8fVj674OMJjBr3mjIqAIhlm+dFF6E=;
        b=JpvI3ADn3O8ufqBzSj542wu9Owa5qjxSS7sL3ByPKPrDFOo8DChhQmMfNaVW/jxIvR
         NHnLoxQy0FxfFUUAL3xVq+f9kGRjPMOemlOYOn6uOE/3l3maHULQQQ4zm+v9VVIgPgF8
         m/f+Oit+UtxXlsi4kbnBaQhw4rgu/VsGn0h2VAc9qA5AtoBY0MWXpfZi9CYicXzQFxdk
         MOdAZOo+Z912xlEck1a5pAHjGMImsLnwLTpASyUIdGKGf/aeG/oyLmepVcGUys9nU/iE
         fi6MuOBORM96sfCvQlVXr2R/kPhOlU71H2RLSs9l9JFPglW+c9LksCgdvmZxUVa/PDB1
         oi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006386; x=1726611186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onUSDzogQBtqDC8fVj674OMJjBr3mjIqAIhlm+dFF6E=;
        b=GOgVftEODuZgvMw3OssKPFrGMiMyGhA5aUBxk5xxPj9wIlJiDM+YSEvfPv3l6ivaZZ
         afWBDIeGpUSMKb7akHuK2LVMw5gTyibKv0LukMC+Pc/kGX0CFshiwRYakaHsA7r+FwMj
         +BNDcchyzcJMNCmLhuiaBdztgngInfGttvmkJ781FDkaF53iDwyxoxGpDzvq/IrX/Tme
         dD60FrpLAFvq68LNH+QDrbC6D7NfCK7mxHCjrBaWnDu/axz0KmOJrgWRl8+zA4MjMF5Q
         aGF22urRHtJ9MQoDE6DxK/8YE3q91Yl1SVsTNxXXPvuIRnjCTnPSjO/lMJC6wwkrfThD
         /V3g==
X-Gm-Message-State: AOJu0YzpR+TzaVf3+V38gSYT9kBX5kr6nOiUrlS6fG5XD5+v0gilYnAi
	exg2qiiBvBIAoGoRJWRIazzojv1EMKfTGCKlV6Z4a+2HYlUnmiCo3lFQap2WKCeMqYARDp97fE0
	5QHgzNN3A0HfkpjSaHrBkx+ISe4jKQLOmtHAd2wu2mIsJ5tWNFTJMQ2x2/AtDwcPksjddow6wpb
	6YkzM2kjDR9cZ7YX898AUPo96muxjNnRwgYWwWF/1dyMW8
X-Google-Smtp-Source: AGHT+IE9iRWPyUp5tl475fhm46rIzneMbMp5fy8CbIZM7/8qX3r1UpSo6IrLdE7G6MPxvAfOd8AUuPaTLbQa
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:db0b:b0:202:156:c4c6 with SMTP id
 d9443c01a7336-2074c7e1855mr1920665ad.9.1726006385419; Tue, 10 Sep 2024
 15:13:05 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:12:10 -0700
In-Reply-To: <20240910221235.2132138-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910221235.2132138-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910221235.2132138-5-jstultz@google.com>
Subject: [RESEND x2][PATCH v12 4/7] sched: Add move_queued_task_locked helper
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
2.46.0.598.g6f2099f65c-goog


