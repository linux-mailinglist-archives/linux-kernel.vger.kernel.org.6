Return-Path: <linux-kernel+bounces-358026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D909997961
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322651C22093
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739C1E7C30;
	Wed,  9 Oct 2024 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAUdylXl"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F21E7C04
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518052; cv=none; b=lVaf3PL7wAY05ECcSRx8cgu+T28teKflFSqtDjuuVjnCn6QJ5tZXZjgMOLLc99aReaGq0ra/H4Q2/hkf+RDLoJ5G/6oDeKF8s227e/yRighdSW1uSD8JjGfkhxGvdlZLtuQ19IJhujvgKGVwtI016a/yPXQTQMnr/g3yv03k+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518052; c=relaxed/simple;
	bh=AE8vWtD7YuusQJSMDRV04MJHzf8s1iQY3NQEKTovBOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LS4gBJhgk5QKsyYE/yBt3ebcehfM5Hc287RkJVF4ybMXFYAJRPQxjFOOZxyIgDrH9OS8KqKq7daGZcCd6smAgd0R4ycYqz7iYogSRSHA4/IfQCLhL07SfR5TXGL/TUre+icdAqnCnlnZ5McPJPE4TbtWk2rROQc6w+MNjWxDGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAUdylXl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2d287f944so9980937b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518050; x=1729122850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vP8hxfgbNrW6URwzs/8mBQFJ1xBf7gx8e2oXr/ZyYy0=;
        b=GAUdylXlO7HHOdt22yJUial4H/KncTluHroemWPNRYh3OZOZ1IakOGSvdl3W4nYBno
         igbTilpdFS2mh05WMICKnjxh/ApJFTYrIlgLT3a5rox2e854SXyP4vzoHT9VjoWmiVHX
         4DmuZIhS5MpgWO9cvNGcVyV+sNBqS/U9sjx7o2gPT2CodKDcaiSNs0Jrzy0cwBqZxT8L
         6FNuYVx2wWeP/hLc0vyZp1MhpxfeQ07zb7FCs4oD+z+CH2m3DxwTNAOjDKdT4uPb9glh
         RqEVrQWMa4i9i/YZf5pTPfJMVP+VJJWKGifxiGXQGhDWd7wqH6M5AC61YY5lGHHej0yb
         l0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518050; x=1729122850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vP8hxfgbNrW6URwzs/8mBQFJ1xBf7gx8e2oXr/ZyYy0=;
        b=O5UX+8/fE95oGPLENfV5NBq5cw9bHOVjHxgUYuqnT4GSenuKQNx9BezoX8U/E1npI7
         NbvNIbiGJCjtdOfCLEg8uPDEVw1JuD21Gi25h00ykLTcU/cDZDCRYJPoQG8bFYJZ01QU
         tt65Ik34fnsNUUeR+CbyvxBTriHlsm/W+1Ho0CVjctvJm8SbVBmKh034hkwS8/oSDKto
         xwoOSlWj/Hldxa7FZ2927TwJUtV8f/3W/qmOb4bYK9ng/oHm5es4JeBAqmRBeDuUEgbz
         Rx6zJgDD8+GrHgIJVtcuSEtFBjWhZkDmPVtfsd7GgmZ0xbRlTXIZu0OZi16ieoi/j5Nl
         o/Xw==
X-Gm-Message-State: AOJu0YxJ/QTFvMsJQdGAEcJqNQPgaV+L2zKjgwdmdLVRR6EMPY37gZqm
	6GIcLfjwlE0cML2O9BBqO0AI7Eyn6HwyD4lVkr9NEeoKRTV6qUPPgkmpC+53PQhhJSiA4Ya2ErP
	84VnVG3YEHA4dVYkVSfrXINqqLfEr3gYWhwSZZpdy5oLESDu8F0riWPOAkwcGl466l3eTpMZu5D
	Abaq428xHZE+MEHQlL5eKH3X0E5AeWNX0b6zgkVJ2X9+eK
X-Google-Smtp-Source: AGHT+IFanyTxLA7sGW+NUKMuNDYnasPzWbgAysZe8zIprKS3J+xlqO+7mRBGtIPyy31q3XcyId04KMDcYyMS
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:b317:0:b0:e0e:4841:3a7e with SMTP id
 3f1490d57ef6-e2907154b4fmr47837276.7.1728518049783; Wed, 09 Oct 2024 16:54:09
 -0700 (PDT)
Date: Wed,  9 Oct 2024 16:53:39 -0700
In-Reply-To: <20241009235352.1614323-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009235352.1614323-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009235352.1614323-7-jstultz@google.com>
Subject: [RESEND x3][PATCH v12 6/7] sched: Split out __schedule() deactivate
 task logic into a helper
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
2.47.0.rc0.187.ge670bccf7e-goog


