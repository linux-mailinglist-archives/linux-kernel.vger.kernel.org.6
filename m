Return-Path: <linux-kernel+bounces-361967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD8699AF63
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CE2289B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758671EB9E8;
	Fri, 11 Oct 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZnKmUKH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFC1E9078
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689150; cv=none; b=S25X5fE6bwY3NSn5Ui+xjHOxdkzl34Fs6BOtxwgTKrfkkcq1wpD/HMWASaQC9J/8SOSoBp52eAS8xMREjZAYlm952LrlTlo+GhPAWuHzXizQVvFZAK4NBRVrAjQVYZ1kHjEKlx7Kn6AHxyz+dKHC4hDQ1A07zkso8sW6v6VIFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689150; c=relaxed/simple;
	bh=XP+m3UmPjVATfCaJLwYuwjCIQxmOqdjo+gwIbRcdtUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wdpd7Al/2xBW9z8m+m/Dq/zZZCVX/TQJ6LbbP1a/U+1lz4+jG7TZiaDFMeGUHQOLGCfPs/CSOuRmHz+ejPWy3D/x8V0k1qaC9bbWwyoSw0vSYGlH3/JnCa8Uw6zCt4dPLAHvZD6sgNRO9+4DrF4UUNk4/DE/apahc8DkOjay1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZnKmUKH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2939e25402so37487276.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728689147; x=1729293947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvjM0SvpeCxaj9hARcp4o5YDk0ESpiMNhc0SwU/LYEg=;
        b=LZnKmUKH8Wb+qIQszlbB06XOsyE60y3VLcYVY/YsmqX3WKZoEd86tbg+De2tIJJQFY
         kLXkGJI5M3pwdaGeFGCoWMvWVvIFZ5OCkkl6bgWEbRZuZFuYPELw5vp7Y4qQncp9YTwt
         l2exFXXVrhJ0IpLJy4DUZlLBQK223as7B/OEKLwyK8rC1EZDJM+jiFBWoei8Y8LEuRNg
         ftUnGRBfzjuSVqxayvrEwh9mOoAhW/Dz8ZzH2HMjAvVy+eiInHvX2mCXFyuI8lograib
         H2IwvEK+JDyjsGODlgS/BGVDFjM2o/O/aG65W2jZvgxsw3m/wpu4yIKQwrsX5RKymw+W
         Cumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689147; x=1729293947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvjM0SvpeCxaj9hARcp4o5YDk0ESpiMNhc0SwU/LYEg=;
        b=o82XZIE2EibZmtDsLvrQMtv/nw2U+qErtGqnlQuCkPtjNSITaDQXxG0cpXNzuiX0FK
         RPYurBgwnNJNNTphsi3uFllrEvToJMxBCUxojKV0aJcbyvNOAJhhCgNbds7gZuI59mlU
         eX5D8PjicB7Cx0CuZqE2/p2fP5+HCAH49ZUb3mq8xKpeTzeVvdMcYOH9IJKo0Tq7GBHF
         XWZOhVZQEDXizXPH951AwwnYWWpK7QSdGEhOJ6YMJIz4//Q+Bl3doO7AjJ7eDSPEs8qN
         x4h81uZEjZIATDyc6KSHtmxiKjEm5F4c+43DGGOfMiPOhETl82sHLsiaAGRqFW/niGz3
         2OnQ==
X-Gm-Message-State: AOJu0Yx1NiTXOc4Cr0kgprgdFhFIFM06sir5BbsestqZ3k9VXZt0yi11
	H/I7Qarz1zTuphQuH739DiGOfXRD8Q4Pd2XDwK/FT8A0B7DDmOaVrm1189DWnvW+svK3VCTgqNk
	k+HxMq0vLP+RHAiU8w2gBqyJaH+f68cNBW7Ip6ZgtA0hJa62Txrs+txGNPWypT83g87elpzJOZZ
	PPXg/gJK4Fnrc22JON96IYqn+7dMQRXdiVgJqYeRhV3jSU
X-Google-Smtp-Source: AGHT+IGyyGDE/H0C+TeXj4id1783Jm1J4InYkFwFfayEhjnfOWRXeFPVn9dm/UugiLKC8cfYngjI9TxUtOXO
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:d689:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e291a33e840mr16515276.10.1728689146813; Fri, 11 Oct 2024
 16:25:46 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:25:18 -0700
In-Reply-To: <20241011232525.2513424-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011232525.2513424-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011232525.2513424-7-jstultz@google.com>
Subject: [PATCH v13 6/7] sched: Split out __schedule() deactivate task logic
 into a helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>
Content-Type: text/plain; charset="UTF-8"

As we're going to re-use the deactivation logic,
split it into a helper.

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
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: John Stultz <jstultz@google.com>
---
v6:
* Define function as static to avoid "no previous prototype"
  warnings as Reported-by: kernel test robot <lkp@intel.com>
v7:
* Rename state task_state to be more clear, as suggested by
  Metin Kaya
v11:
* Return early to simplify indentation, and drop unused bool
  return (will be introduced later when its needed) as sugggested
  by Qais.
---
 kernel/sched/core.c | 65 +++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 615fc7a7b17c..7f949bb9e2a8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6483,6 +6483,44 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #define SM_PREEMPT		1
 #define SM_RTLOCK_WAIT		2
 
+/*
+ * Helper function for __schedule()
+ *
+ * If a task does not have signals pending, deactivate it
+ * Otherwise marks the task's __state as RUNNING
+ */
+static void try_to_deactivate_task(struct rq *rq, struct task_struct *p,
+				   unsigned long task_state)
+{
+	int flags = DEQUEUE_NOCLOCK;
+
+	if (signal_pending_state(task_state, p)) {
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		return;
+	}
+
+	p->sched_contributes_to_load =
+		(task_state & TASK_UNINTERRUPTIBLE) &&
+		!(task_state & TASK_NOLOAD) &&
+		!(task_state & TASK_FROZEN);
+
+	if (unlikely(is_special_task_state(task_state)))
+		flags |= DEQUEUE_SPECIAL;
+
+	/*
+	 * __schedule()			ttwu()
+	 *   prev_state = prev->state;    if (p->on_rq && ...)
+	 *   if (prev_state)		    goto out;
+	 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+	 *				  p->state = TASK_WAKING
+	 *
+	 * Where __schedule() and ttwu() have matching control dependencies.
+	 *
+	 * After this, schedule() must not care about p->state any more.
+	 */
+	block_task(rq, p, flags);
+}
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6590,32 +6628,7 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		if (signal_pending_state(prev_state, prev)) {
-			WRITE_ONCE(prev->__state, TASK_RUNNING);
-		} else {
-			int flags = DEQUEUE_NOCLOCK;
-
-			prev->sched_contributes_to_load =
-				(prev_state & TASK_UNINTERRUPTIBLE) &&
-				!(prev_state & TASK_NOLOAD) &&
-				!(prev_state & TASK_FROZEN);
-
-			if (unlikely(is_special_task_state(prev_state)))
-				flags |= DEQUEUE_SPECIAL;
-
-			/*
-			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;    if (p->on_rq && ...)
-			 *   if (prev_state)		    goto out;
-			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
-			 *				  p->state = TASK_WAKING
-			 *
-			 * Where __schedule() and ttwu() have matching control dependencies.
-			 *
-			 * After this, schedule() must not care about p->state any more.
-			 */
-			block_task(rq, prev, flags);
-		}
+		try_to_deactivate_task(rq, prev, prev_state);
 		switch_count = &prev->nvcsw;
 	}
 
-- 
2.47.0.rc1.288.g06298d1525-goog


