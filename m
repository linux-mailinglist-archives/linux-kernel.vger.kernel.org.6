Return-Path: <linux-kernel+bounces-285644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07929510C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243B41F2489C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6201AD3FD;
	Tue, 13 Aug 2024 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYHkmVvc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F61AD41D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593468; cv=none; b=IIH9450u379uBvRPF+pzUpipDFbYL0NoDbDRFWaeZdGQqwJYQfKMa6wcIf8FMe0ZtxRcdxWTOCKoltsvt49K9ZkcVBD6sY0Ipt42teWzLHCY92KZlZRxgBUh8Zx1R96KRw8mXwyw3TV1TjJ7UFh2fSU0NABfyTxiLf0lDbwO1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593468; c=relaxed/simple;
	bh=BvC95waQXcsb1i4b0DMFiiD0zUk13irz74Rji2aVYCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IIi3g4/xeiIo5wRqrkVnvf0vfNpHhk6QExAEbseLlqwbzKi5Zo7rcrHT8fX4oAciBbf+1oDM0foGn/fl1ghgFYqsBdDcdiFfnb2RYT81UKfHRdCdx6gRVQDPjzS99h1N8rQxhEFjhDvxXdHJjywd2Y/WEtV1sxrQaWOkEmLqxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYHkmVvc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e4cd64909so10378880276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723593465; x=1724198265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fL8Ldu/Qz0x1BecrGT0Qm9CT1eTbvL8rlTVEwMJhiGI=;
        b=zYHkmVvcj+Zo3TN/G3E/Mbih3OhtagIPJ0fTv+LtTQ8KD7mrGPdVJfp6HmGuPBJwW1
         zWfaLbvvR7SutJuhrDaeeEaCzSV2cx0EZ4WEnZF1wHiSXOOPywiqonWyjPtVCVN0//qc
         1wNlFimFPvzZmmvGaCiRHAKOh8m3+nUmNTWJY6Lclv9rdUlybkOsvadxlUVebiVKPuba
         5M8bQOLFEdsH9BhPUiE8bJVmeJK0/GpISbeeFsuxB5XEPqKtaARIsXCOBxaIvsIpXlpM
         edepKRawSeko6qGqqa7f1vI8Yt4TNWM74CTNsdsmkVl0ymSi6Oj0jhU6dERRVG+6nEnl
         tT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723593465; x=1724198265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL8Ldu/Qz0x1BecrGT0Qm9CT1eTbvL8rlTVEwMJhiGI=;
        b=dJxCUfDfR/JdgK2njjxVlVPaJC7qXGotPNnTFii7PRyVrzZ8L0o6wnvlcn44MxsXdG
         2tGG/V34moADmmxKzwr4g1L3YCVobPSx9TutSDI4iBhw8wwJDa2Q4rK7SVHM71sJXAM0
         pPoQXgdcD8HIZ6bQuLqUgApkN+7SnQ3xVK5ax/2Mjuc6gVV+U57tPfEivDkHFV/A2nMb
         4f03MdwF4niXbaPQbLPIzVQZjYfnECCSgLL/oZ14CVezy7HUw5QQsug99NB+62zwMAu+
         HxiROtVGE9gmgXQbQaVDqwLKVDp1tKQ+/eBjO5bhHhpZGyW95NjrT8pY8RIQEIT++tGL
         UwBQ==
X-Gm-Message-State: AOJu0YyYmZ2VxW30FeLbNWOn4d9YQxRGXENWjYCDzmE1hlJjmNy9rhoz
	F4l3aeDXaZTQ3r8MGHHnDDT4XQrIc2P1P1YIS8tyY18eO18LNcwJErinSmKO5QcOa+uwYZgMmS7
	cTSV7Rgf5rdCIURj1m3En0TyhMKxRe2U3SPFCIIVui3JbvTj9obcJVKMcUNtnPvhH3lYab97KPI
	hmG1pUME7hQcpzd72gz4D6U/8br23u/eIDsBlZhDT2HfTj
X-Google-Smtp-Source: AGHT+IHlNhShMMOD7nU8Bsx1nxE31FVMt+gjlPHs6lFdcxJGmWJiKTN+HXtLgRdLnkn4sIVjZMFpkkAAggRz
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:a223:0:b0:e0b:f1fd:1375 with SMTP id
 3f1490d57ef6-e1155bafbf9mr1890276.10.1723593464501; Tue, 13 Aug 2024 16:57:44
 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:57:22 -0700
In-Reply-To: <20240813235736.1744280-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813235736.1744280-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813235736.1744280-3-jstultz@google.com>
Subject: [PATCH v12 2/7] locking/mutex: Make mutex::wait_lock irq safe
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>
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
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
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
 kernel/locking/ww_mutex.h | 21 +++++++++++----------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 6c94da061ec25..cd248d1767eb3 100644
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
 		wake_up_q(&wake_q);
 		wake_q_init(&wake_q);
@@ -706,9 +707,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -734,7 +735,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
@@ -744,7 +745,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	wake_up_q(&wake_q);
@@ -915,6 +916,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
+	unsigned long flags;
 
 	mutex_release(&lock->dep_map, ip);
 
@@ -941,7 +943,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		}
 	}
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -959,7 +961,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		__mutex_handoff(lock, next);
 
 	preempt_disable();
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 }
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 0a05de8728411..517a971f6a8be 100644
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
 
@@ -408,10 +409,10 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	lock_wait_lock(&lock->base);
+	lock_wait_lock(&lock->base, &flags);
 	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
 	preempt_disable();
-	unlock_wait_lock(&lock->base);
+	unlock_wait_lock(&lock->base, &flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 }
-- 
2.46.0.76.ge559c4bf1a-goog


