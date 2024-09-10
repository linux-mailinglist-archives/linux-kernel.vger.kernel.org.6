Return-Path: <linux-kernel+bounces-323935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A486B974573
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5983628B55B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95C1ACDF9;
	Tue, 10 Sep 2024 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sa0atAlT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445241AC89B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006391; cv=none; b=ltpXHF7SLSLjhoGCJ4kr1fu3KrB6ErHuemEqZhIkrdmkq216lyYkvRfXyI63Np7H5XTH3J4NiC7F6vvsWn25jbY6E33Kv40fOsDkySrwDoppRb3HlvXwVWP9gLwpocuggpwHOV54NOmHgyo87qSKuJqsZqZaq1C/agsHIH8cm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006391; c=relaxed/simple;
	bh=iuGtN+f2vomE6D5EDzT6KDxmi1UFJf79tXpaViAx6cM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qOGa9ORsSheHA8+DaLjlVP/STCtc55gWlMSPFj2bLgJMojPRlwXES7FJm/HrKkneV0vW+4RbgjqHFSSiLibVzS7nIqaLpzqGQQZCnxaxVAdh27XH1YH3SBFO115NLRO9BtLjRKNaRP+0h9TfTHM6ioOWTZWfCtVYjGIArATCq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sa0atAlT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4426ad833so38068697b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726006388; x=1726611188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaOcE1n+CT4Z0Nve3QVlepBeUo0bLzyMIk99K97vdS8=;
        b=Sa0atAlTSwRfYHCETmhs+7pbjTBc9nXgwIff5XV66DGOWA/kHKV/0w2uwYLF03Vmlz
         1qZLmzVFgtORXGgPjF/9LWhxPCYc9Fhc+pVYtVkhR+47c+tH6znC7x48yoY68LD9yID6
         16BWrRJdJRDoujARiiCeRAetsyH4af0f7C9iL8PRkjuNqWYLm6OrQraOwkNrlTYCDZQZ
         Hzt38QTrOEOLNc+rRpuz5508/3rH6OC2PRuK4R3eJC8/mTf/Y3goSEL2viE0jZZ48VCN
         0KrW4o7HjKX9AtJZ63+Ccc5fzw5OpORRkVV3CJEZfmbvnL9F8wzKMjrKxfew1o9Fmnvu
         M9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006388; x=1726611188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaOcE1n+CT4Z0Nve3QVlepBeUo0bLzyMIk99K97vdS8=;
        b=As6dR2PnR7XtPTRF6tA+cGMRrWeq+A3c9E5ZSF1siUB3NfskSv7UUqcJYPm3+6VZl5
         NkkBbhoRiK6GRLpOROC/HHorjHbYlakv/TDcaHdkbdhcdcTDtXxw/9F7UaKRXVZgDnWR
         YZFrw+ZAwtQLSIJHhFAslJd4E1DlkeJhoIjij7fL1pi1+ejG2FrF+T5WDL+oPmVTTLxK
         y8XXPSsbXZ0JsXQT8dbql/I2x4CAXVrJRMw/gfQlHvrDRwM1SC1yWrmTbHYCqYJDoljG
         iknAaXGFBJ358V21QP7c88iyoGO4+/amaIFdvbiD2JzuDUhDC0bT6MKJqdln3rtZLflX
         3q5w==
X-Gm-Message-State: AOJu0YwwPbCzXY5hWNTyPV80NMG7jbCdjGZb0jIVKEUJZqYOBeNbQnJ6
	HPzOiNGAjsLAp5fNC4sxysAquWYD9OI3FhvWHEveDSQ0OA7bSZ3IAVR+/r9sYNWXQnraaHvgqLv
	/Iqoh0hy3axR/04y3ic5e2r2M60jiJgGBvYyo9PnEJ6p0VuP95FGqzjcQS2uSdgkuPq4nphoH8e
	rqz22Yo3GB/y2JXFDF4OwiX6EAFJ4jPp0NvOYL71XIpSLH
X-Google-Smtp-Source: AGHT+IEP/sFtVMI7Ur6r7G0JfXZRrrE1jC7YOB31tlWCO/792DIBECsiHyuEvPb3reZgBGOYWPBoTVvtEu9f
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:a2c1:0:b0:e1a:974f:48e1 with SMTP id
 3f1490d57ef6-e1d8c41782bmr1390276.6.1726006387520; Tue, 10 Sep 2024 15:13:07
 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:12:11 -0700
In-Reply-To: <20240910221235.2132138-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910221235.2132138-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910221235.2132138-6-jstultz@google.com>
Subject: [RESEND x2][PATCH v12 5/7] sched: Consolidate pick_*_task to
 task_is_pushable helper
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

This patch consolidates rt and deadline pick_*_task functions to
a task_is_pushable() helper

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
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: split out from larger chain migration patch,
 renamed helper function]
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Split from chain migration patch
* Renamed function
v11:
* Switched to bool (though later in the series it goes
  to a tri-state return) for now to simplify review.
  Will add tri-state handling later in the series when
  its needed. Suggested by Metin and others.
---
 kernel/sched/deadline.c | 10 +---------
 kernel/sched/rt.c       | 11 +----------
 kernel/sched/sched.h    | 10 ++++++++++
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ac60d2819bd1d..d3050f6c2958d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2183,14 +2183,6 @@ static void task_fork_dl(struct task_struct *p)
 /* Only try algorithms three times */
 #define DL_MAX_TRIES 3
 
-static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-	return 0;
-}
-
 /*
  * Return the earliest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise:
@@ -2209,7 +2201,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 496d3e6ab57d2..9f07f09641f7a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1790,15 +1790,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 /* Only try algorithms three times */
 #define RT_MAX_TRIES 3
 
-static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
-{
-	if (!task_on_cpu(rq, p) &&
-	    cpumask_test_cpu(cpu, &p->cpus_mask))
-		return 1;
-
-	return 0;
-}
-
 /*
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
@@ -1812,7 +1803,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2cc31c2457e5..10ef612c078f9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3586,6 +3586,16 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
 }
+
+static inline
+bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
+{
+	if (!task_on_cpu(rq, p) &&
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
+		return true;
+
+	return false;
+}
 #endif
 
 #ifdef CONFIG_RT_MUTEXES
-- 
2.46.0.598.g6f2099f65c-goog


