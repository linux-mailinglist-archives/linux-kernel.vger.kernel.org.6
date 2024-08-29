Return-Path: <linux-kernel+bounces-307807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598F965326
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8BF1C21B59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE11BD4E9;
	Thu, 29 Aug 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5p94RgA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8281BB688
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971950; cv=none; b=GsFAL+diW9oMmM53zG79O/cTokqwObABOHcNidvgups9CHFgYcKjuhz3Pk5CXm/R2M1af1ehyZaYNJtzrhtaFnnNS0yWY5VDzZ3iy7yJSxIUVQoq6tdje4QZbEAWPJ6vcl5jkWoGI5+aNK7CXvcJkxM0c96KtSynOgExcs82fIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971950; c=relaxed/simple;
	bh=1NGfddd6xEbb6zi2+jf2FIoq+IWLXniDi22yNQZivow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsZzbtFzUEADgOGU7XbbCeLXvB+3uGkuGi2tCLxZygW+xo1S/IfQ00mvbJq6nz20LiGJsiLrG++Trq3ppKoF4x9KsTZULqaPnwcUXCFO0jeNT41DPzCHioTLZ3Q+kjdd0pzqORxrncMR7JPGNF4B6YFrS8f47JBOaJ7KiIMysJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5p94RgA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6cf78470a56so26228447b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724971948; x=1725576748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1h2vc6eYWkYIktomIdYy7ZxAiy8FNYkJM4vYV9+GFE=;
        b=t5p94RgA1MwPMsLdC6xa9o0lyYspz/IvfRm+VSNvMGWwdo7ESoYNEc16iUnh/wG5Gw
         mmEJL9Q2WJb0TyVDyClyD5ohR90ir2HXEsZsM+Dy8tmKLspm+YmkTj1e1Z0WlCwiC623
         b3CSnxeMdiniKr3af4gsCs7TDdtbFnQgZXx9CgVZTgBkgh7UNKv9rr5STUFQkvz5s+fh
         LPBHwF4WtI39SwVB/o20Jsq74V2g0nczUJQyy8/tM1cch1QAHj8VO6XPBjDTdSfKlXAT
         LQbhRa3O3yruCSEpmV3hXdSnYjk8VCDvJ8y2MXYYnr9vyqjZP6QwoxPaYi0yG3hL85JD
         LTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724971948; x=1725576748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1h2vc6eYWkYIktomIdYy7ZxAiy8FNYkJM4vYV9+GFE=;
        b=Pc472foJsCBoQQkAlV1Ms/8VTiS6Exlktj2cWK7Q92IZaq1l1oCW9IP47NSRxVTnMK
         pnagRSlfNF3Oe9hqxSDCatysiFKIXUXU6l3Yph4LnCij22sfaDcE5xBM31qsEt3smPVR
         81Ai/9ljRHiO1rr+4r2p8gf860lYC7OyedTJEOtNHiT1bHxWqscUpoH+g8eqnZAa7OsC
         ypEqf4OjteERqV/EsZdcfanoQtmldDIv+3Te9V8nS+JSkwYoVaJEBn7tHzLu1UqRvfos
         MRyIjHUFcjgFdk4pzl5t2Nj3pUEe9kbyfShdlAcJ/1MKg4+G3hpYenKL4aJt6ElxfXxC
         9s2A==
X-Gm-Message-State: AOJu0Yztwe86fauvJ3ZmhlWKVQO/8gwwBKZeArafvwB1l2VHsEo1fByM
	7oSPOYONQHJmQWYzizqsdK6i8J5VpXoxE75FYqlXwLwCGzPv1buANBriu4xF+JisUUYSz8skMYi
	6nMwS2rfN4puZaW56bx3qyjsUdcAPukstEx7W7KXNP38SvfX7I6SFK8z/n59jKarv3nuVNh00JP
	tZVAMKMduz14/fR9uxs+t8kPyZ91YymKhiNXq6ul6peANg
X-Google-Smtp-Source: AGHT+IFOlSMuRWRv+B4Ekr3h4flnxoDPQj6t3LjQeuT+Peu25gNgg+G4DG6Hn59OsIILbk6lQwelVCPB5voc
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:4a88:b0:699:fc36:65ad with SMTP
 id 00721157ae682-6d40f92498cmr6367b3.3.1724971947271; Thu, 29 Aug 2024
 15:52:27 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:52:05 -0700
In-Reply-To: <20240829225212.6042-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829225212.6042-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829225212.6042-6-jstultz@google.com>
Subject: [RESEND][PATCH v12 5/7] sched: Consolidate pick_*_task to
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
2.46.0.469.g59c65b2a67-goog


