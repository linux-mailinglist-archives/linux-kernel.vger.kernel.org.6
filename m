Return-Path: <linux-kernel+bounces-246634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDA692C492
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA7F1F23662
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501918562D;
	Tue,  9 Jul 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRriDddW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB4185614
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557154; cv=none; b=d3NbQRuB91TSicd+Qbej+kgfmR1FyabAG43daPMqPY6UxLbrC6THZqYD1u2F95KjWD/F9fMOTSQl3rJ6N23t1PipcY39hxucypDNp/HDIUqt4HSFu0OPaflJ6zIrlQ9pQiWm9aNlsDoeEnePyqEyzKhs1PF6dRLfIin1R02rBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557154; c=relaxed/simple;
	bh=8WwFP5CCf9stN1FiTOlKvBC5zqi6xiZP0UDWiU8fL0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5E24m11nQhScZI/e+oVaEUAsxkCdTJfWiK5PxYrAG2t6wyxAqBCoDrkT554sqmjYXWpzcqz6517uXs5QYYl+SNkfFyMniZqlzXnaItgxca3swqcMYNWQd3YvH/F3PHa6JRE4te6XQiRCsmJa9k2KxDiUlIivFReS3F+HVfca2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRriDddW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso84516a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557151; x=1721161951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLvTAbNH73dBrl7bNnyR5edCKfFkbAVRdkATgKgoksk=;
        b=kRriDddWYlXlgFyqUDT6O5yMU+O7f1xMIClEigxPga0u5tVetcpX++Fzf+1h8JqwKP
         N9tM1fOmvduAZytY50/dsUiDsgpF24s824T5by2S3pCsYK6vb818TlFyLIw9YZ5svr/M
         nu30flUOuGbxaqVQU1EAoPYCt0zKUJnDEYMiI1M1nTZmqSkaUteWWMwYkxKfgBA3HziE
         WnyEM83I2Ab/0fb3if1Xmij1qaEkjbiOOZubR8NUqrMdANVhPzMkXa8k+TWJlqoBiwCV
         8yr2YJc48Lb56KA7Ejs2W0qzViJ9ACKL89BNJMLfXjIdel8JIpyFPS/ocKOr/94R+qLK
         kF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557151; x=1721161951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLvTAbNH73dBrl7bNnyR5edCKfFkbAVRdkATgKgoksk=;
        b=KHOiDssZOWURzFsslrVFyYV5ucLru5yk0aXCgo0SliyYrN1xzuoVNFfNaepBmhzOuX
         25VuybLLVgDR5ZL/xHVGr6/MchOwnqiLVcuzdr5AYFwQ99NTLHAIYMKO3udwcpSkwha7
         u7rq2XcA8IOGyJFnlAfyUXzGaDk8XO0aTES3jtlk3UegXrW/ClsaFp9PYKL9FoqT3qwN
         dgpGWAI6kLCPeE76fPrrLYD4jdb44v49/7z1N00xjB/AnFFAELnD/wScVpFxX0c5NQGV
         tS9b2kmEzW+4kDoZTlxwAKBgP7KGlrSNIfrDtzSYDgbU1sFoM5BpbOrfdFV3HNx7Wkg1
         iu+Q==
X-Gm-Message-State: AOJu0YwfOETly6t5c9XANuH2FcvEkKF6wxGR4eh18w05XLfnoouXVc7I
	KYhfWL0OsKN8lQDHgeVcYGFthpe+m2X87Q5j8EoFfyqZq1dlpyr0Qe5XjKJovs1rYENKtqwRReP
	uQSZaX478SLIM6qXfkzEQqkfqc778MVM6YLqPDjRiFReaOqwOf3cESgDxI9km/Ih6SdUC+JBoLT
	qXHqDfQTtVn/hfdbeom5ePVt2DcOflACiRvNX3Y31CsrbF
X-Google-Smtp-Source: AGHT+IGMvCZToZeHj65S2vUnjRIIe0nCFMOuJ9QbdPNkwAiB09LaXZrmLtpISjk6zta7Lvx8LztCl8RRgrDp
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a65:67da:0:b0:70e:1058:e16c with SMTP id
 41be03b00d2f7-77dfededd53mr8536a12.1.1720557148168; Tue, 09 Jul 2024 13:32:28
 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:45 -0700
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-3-jstultz@google.com>
Subject: [PATCH v11 2/7] locking/mutex: Make mutex::wait_lock irq safe
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>, Metin Kaya <metin.kaya@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Juri Lelli <juri.lelli@redhat.com>

mutex::wait_lock might be nested under rq->lock.

Make it irq safe then.

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
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
v3:
* Re-added this patch after it was dropped in v2 which
  caused lockdep warnings to trip.
v7:
* Fix function definition for PREEMPT_RT case, as pointed out
  by Metin Kaya.
* Fix incorrect flags handling in PREEMPT_RT case as found by
  Metin Kaya
---
 kernel/locking/mutex.c    | 18 ++++++++++--------
 kernel/locking/ww_mutex.h | 22 +++++++++++-----------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 4269da1f3ef5..6d843a0978a5 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -578,6 +578,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
 	struct ww_mutex *ww;
+	unsigned long flags;
 	int ret;
 
 	if (!use_ww_ctx)
@@ -620,7 +621,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		return 0;
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -681,7 +682,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		/* Make sure we do wakeups before calling schedule */
 		if (!wake_q_empty(&wake_q)) {
 			wake_up_q(&wake_q);
@@ -707,9 +708,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -735,7 +736,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
@@ -745,7 +746,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	wake_up_q(&wake_q);
@@ -916,6 +917,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
+	unsigned long flags;
 
 	mutex_release(&lock->dep_map, ip);
 
@@ -942,7 +944,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		}
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -960,7 +962,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable();
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 }
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 7189c6631d90..9facc0ddfdd3 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -70,14 +70,14 @@ __ww_mutex_has_waiters(struct mutex *lock)
 	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
 }
 
-static inline void lock_wait_lock(struct mutex *lock)
+static inline void lock_wait_lock(struct mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct mutex *lock)
+static inline void unlock_wait_lock(struct mutex *lock, unsigned long *flags)
 {
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, *flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
@@ -144,14 +144,14 @@ __ww_mutex_has_waiters(struct rt_mutex *lock)
 	return rt_mutex_has_waiters(&lock->rtmutex);
 }
 
-static inline void lock_wait_lock(struct rt_mutex *lock)
+static inline void lock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
 {
-	raw_spin_lock(&lock->rtmutex.wait_lock);
+	raw_spin_lock_irqsave(&lock->rtmutex.wait_lock, *flags);
 }
 
-static inline void unlock_wait_lock(struct rt_mutex *lock)
+static inline void unlock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
 {
-	raw_spin_unlock(&lock->rtmutex.wait_lock);
+	raw_spin_unlock_irqrestore(&lock->rtmutex.wait_lock, *flags);
 }
 
 static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
@@ -380,6 +380,7 @@ static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	DEFINE_WAKE_Q(wake_q);
+	unsigned long flags;
 
 	ww_mutex_lock_acquired(lock, ctx);
 
@@ -408,10 +409,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	lock_wait_lock(&lock->base);
+	lock_wait_lock(&lock->base, &flags);
 	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
-	unlock_wait_lock(&lock->base);
-
+	unlock_wait_lock(&lock->base, &flags);
 	wake_up_q(&wake_q);
 }
 
-- 
2.45.2.993.g49e7a77208-goog


