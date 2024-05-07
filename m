Return-Path: <linux-kernel+bounces-170660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5DA8BDA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023E1287475
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599746F06E;
	Tue,  7 May 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wvU7jLF"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29D6CDBA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057706; cv=none; b=rqymENQYbngs7i7LBxCfiLmyCcV6Q4YdC3RB6BAiO4vVbkOLK4epgfQiTtkwBPA2yhZXwQiXzONPoh7dAWBi4DXFM7DGuHEkziQt72V0wOAPUbyOYblyavuetBvgZoXpgK4HUFGEsGvtUvSADQvCwpMdeOCrotq/ynTexKhSEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057706; c=relaxed/simple;
	bh=WOTPWSz2YlNs0MD/3Y+/7eM8LrVBYFxCR8h+6Ap+srY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YQr2fIC4z2QHKtJGcL4iHTM7tuwRfNqcG5PgFQRFvNvf0po8x6egAqhH/8fBJIxzULlDVY7gdYwtZFqEVwLN8JfnoCrGrbhFCpz60034IWWNG7j4en2FM6ETeD1I8rD+Btz693Oe9jx2QmW2lcpO9PrnFQ3/04V5DDy/obEKOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wvU7jLF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so4156384276.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715057704; x=1715662504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkplDeMhqyzSjhNDkkKbm0Zp7QOfiWk6J51tAdtVLaQ=;
        b=3wvU7jLFFl0a4pvtq5g7vWKoEg1Xe9Ddi4iPVTeQzQMcNCEbLj2yzAD97i9B8TBwKE
         IVWkk+e1N+FHzFLbrsI73joOsVZBJKBbL/obMvNW0nrnBB8e4wERhDlqzatFapDQZjA8
         tvHowSHFWBjblienuKvsMA2hjwgbmXH6YVt5AdHovaHh3YszMR8iYZWD5U8hY4UcvCze
         fneCFmU2rk8b76K8wo0ep9/mwzyYitgEOVqvJNcoX+qrhqhDjmZPhNzSRi+jLyy7c2CU
         ykRTOXE4wvzaDnsT4Q+Jdfkfc8Ok/sRfGluPbRDabFRa/4/cuiMdgXrkW6Rqet6eqd7z
         ASuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057704; x=1715662504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkplDeMhqyzSjhNDkkKbm0Zp7QOfiWk6J51tAdtVLaQ=;
        b=EXZ9ldBFeexld4TO7+Lyo/TM0KKVke49sPivqZQIohxJbX297lzRGR1WX/75cg+J/3
         l7CcaGUOPWBOptwO+nXZj3+fzyIK9IBOjjXPL55hQOCuXWwO2XOB9fAWjp/JtatjShG5
         vs1qQvMe3GAm+tjo0l8RqubmYnFQy8Io4uBBiv+DJlEo0RZLNi7YIdf0DmXFkfgVbRJp
         JJXfHNNlOF0u0G6Rh8Jj0EodmyvZtQRd0BV08ZK7zlEEgnH4BXun67dzOxo2MHqHoAPN
         TX4nQaYe3eWr8anbsZPRtPcG0kYV92WsSJ5JszfGSdhrgBHdGDsez8kcd22gvWBKrZU/
         uyqg==
X-Gm-Message-State: AOJu0YzKHF7RXaar7nI2nB56j/UV+yjhVAdFwFlFIFjkWBhPv8cbmKsD
	Oq+zQcOEDISrjROFriCqtvrNpdtojij88w35tQ0J/e2oVOBEm2o3hpcVfzJM5fTfulJvuQG3D+Z
	P5gFyiY98q5o1A/4voiITj+6M0PA8s6cW7QD3AwI2D16vtDhG31ptJTu3WJqWhIEGbMdzUhLv9f
	L6rWz4POeK/YctAVNnS4RgAiyeeEmCz2/4yK27iQirQCWf
X-Google-Smtp-Source: AGHT+IGZP+zsLmo6nICRW9xaiUj6SsVuJj0XGFWgzUQ1D8XCVkb812YDE6NQv66ac3EXtScHVNn/bpW6TVUe
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:c504:0:b0:de4:654f:9ad0 with SMTP id
 v4-20020a25c504000000b00de4654f9ad0mr1516343ybe.6.1715057703421; Mon, 06 May
 2024 21:55:03 -0700 (PDT)
Date: Mon,  6 May 2024 21:54:33 -0700
In-Reply-To: <20240507045450.895430-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507045450.895430-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507045450.895430-5-jstultz@google.com>
Subject: [PATCH v10 4/7] sched: Add move_queued_task_locked helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Connor O'Brien" <connoro@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
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
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v8:
* Renamed from push_task_chain to do_push_task so it makes
  more sense without proxy-execution
v10:
* Changed name to move_queued_task_locked as suggested by Valentin
---
 kernel/sched/core.c     |  4 +---
 kernel/sched/deadline.c |  8 ++------
 kernel/sched/rt.c       |  8 ++------
 kernel/sched/sched.h    | 11 +++++++++++
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..48f0d4b381d5 100644
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
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..eaedc69c5e30 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2443,9 +2443,7 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	move_queued_task_locked(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2531,9 +2529,7 @@ static void pull_dl_task(struct rq *this_rq)
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
index 3261b067b67e..975cb49a64dc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2106,9 +2106,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	move_queued_task_locked(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2379,9 +2377,7 @@ static void pull_rt_task(struct rq *this_rq)
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
index ae50f212775e..2d41ebe200c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3480,5 +3480,16 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
+#ifdef CONFIG_SMP
+static inline
+void move_queued_task_locked(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
+{
+	lockdep_assert_rq_held(rq);
+	lockdep_assert_rq_held(dst_rq);
+	deactivate_task(rq, task, 0);
+	set_task_cpu(task, dst_rq->cpu);
+	activate_task(dst_rq, task, 0);
+}
+#endif
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


