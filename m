Return-Path: <linux-kernel+bounces-358025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C5997960
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15230B2344E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85B1E47B0;
	Wed,  9 Oct 2024 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+SIp+2U"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974A1E5734
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518051; cv=none; b=JtL6imrCchs0e3fuF0fjo2dM2Ia1n1j92TY2fOCsBbt152xra9a28s8csx8AFC6aR46xdzLf3NYr0QfhfQpBuXzaEqG2zg2Uh0bZppScnqlRikgfD2gxOqki2Et0ttDOAziY43cza04mDlSLeBV8isDfhIscJKCQODlIY5RJmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518051; c=relaxed/simple;
	bh=moY4NQ1Ek778wz1VUeLgby72X65guazhLvsdhuFDRSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BoPBfkPyOmqjQ8MwKxLJWdCgY1rNYyMLyMvqaL4zZbN/nvV4iP2978Ix0/5AfWLUtxp8BItqb1GoAW60FY2CCxXW1TZBvygIzXx4bqCzffSE63zMbQetPNcAXVtptYzg91Ul4okk2qS3jmauJPNzghxKDTe/Oq+V7u65PXCveAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+SIp+2U; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e920cf6so9661357b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518048; x=1729122848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpB2MwCiWtWgLWM22p+fNa/AIK9cQ7Ikbmej176eYbE=;
        b=T+SIp+2U6vrjpQJfT/+ok8e0ZN5FJeVL9Za5Dkquk8TimjmUOc/5jhHLVOLWVeRyvg
         /8vW/x9kAoDZwav4AHIGqhCzEMjFWJ1eeiCzA4lAhfAHiPSqNpHqXohZlGyviv46TwQw
         Z6kSg5t6Ymjh+JhLfs4GuJK13og/PN6UMRh/dFI5Bma8ARJ/vlEojnD2H+uTiT9VfkrE
         REEyFG32/3M/q8zRjkXdjQ+Ynd064bKwSM+8JBt2thaSYHomkjjgTkQWyqi8zjiipfuJ
         puSLxtMsUMrA4qjg+2hFqvY2X3HVkUfoYmpruERypp749AuhtKWJI25vvG9Dn0a2KrMx
         TA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518048; x=1729122848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpB2MwCiWtWgLWM22p+fNa/AIK9cQ7Ikbmej176eYbE=;
        b=bIJe278yxIv5Kg7JmPOUpX09KOdAJyaH8Y5/f9/5qfBEnTvheVYhsR3uC7A1rUeqU3
         TWT49aUbZksHOAdHNPJjbw2O35YPP9Zwklv8PnM/WioHdu6xsu5oY/akjnR+mkx+kr5y
         bdKGlg2z6U+jTCO5f7/LN0P5pdjuB4nB1Crd7vBGmjH/2IMUuiNwjVI5nBJlHlxy8XCf
         66br3EMkr+HMauBYw6/UxDUWQr+Zmii43zrdP1jL0PJan2gxNmJqjUjW/3ao/GrrtENn
         qe5PZI99zkEhdABDZ5dWjN0BXsuzM4XkQ/chXcD7NEOl8b8X5CITS4P+FNsLFna3msH5
         KqlA==
X-Gm-Message-State: AOJu0YydfqQMae94OmFMiBcONqTfardIyXzOeVeu0z6RpATAFwc+4ihp
	Lao7hSDVLpB34JPib62mwt6vGLYO5tmJaShPNJti4O6p7sYRQNAnNOICp0+K6bP/h1BSY018qS2
	ND+ELcyrAIM909+nYHnZnSX0LAUe8asrb+XY4FmmHB/NFPfc2pOm8+h7PkV+WdPsYLXWAdR1wne
	n9N2uPIbA7mVd73Ks0CMVni3JDpEasYq180RAexmn/pNHX
X-Google-Smtp-Source: AGHT+IGX8NveZU9T8x0Rzl8JIZyuf0qLsTVzOfMJ7zQIiakopm9ZUh72qIm4wD+zP/PCXHyEw2vPzG8QT92z
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:4046:b0:6e2:1eba:ac07 with SMTP
 id 00721157ae682-6e32216f5b0mr508167b3.5.1728518048131; Wed, 09 Oct 2024
 16:54:08 -0700 (PDT)
Date: Wed,  9 Oct 2024 16:53:38 -0700
In-Reply-To: <20241009235352.1614323-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009235352.1614323-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009235352.1614323-6-jstultz@google.com>
Subject: [RESEND x3][PATCH v12 5/7] sched: Consolidate pick_*_task to
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
	Metin Kaya <metin.kaya@arm.com>, Christian Loehle <christian.loehle@arm.com>, 
	John Stultz <jstultz@google.com>
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
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
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
index 6c87d812efbe..56260a80a268 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2487,14 +2487,6 @@ static void task_fork_dl(struct task_struct *p)
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
@@ -2513,7 +2505,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
-		if (pick_dl_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e2506ab33c97..c5c22fc51824 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1773,15 +1773,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
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
@@ -1795,7 +1786,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 		return NULL;
 
 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (pick_rt_task(rq, p, cpu))
+		if (task_is_pushable(rq, p, cpu))
 			return p;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b904a5004eae..cb74a577c89d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3779,6 +3779,16 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
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
2.47.0.rc0.187.ge670bccf7e-goog


