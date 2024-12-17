Return-Path: <linux-kernel+bounces-448542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE39F4190
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168687A59B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785714600C;
	Tue, 17 Dec 2024 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apzcOOYu"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75A1411EB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408492; cv=none; b=ME5VTPqPif1FcoNPNCj7ghFVcPIU0E2oRLZyaZO3Lr9COFjRGWI3SUbA1vnBLIOSrFPq8GG5jjvEqQfZLZy5RBuuDvnmp7IuneZ5xxpCuVvBXHziYZhq8QiYqNkJ3XB5HqW+m2JQ7dCQQYLSBFDEGAkETwTUby6PO4u3kXdwBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408492; c=relaxed/simple;
	bh=3WAJKSOETCygUGR5wuwCDHhtjs2tGgG+97K84TA9ojs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EyT3d5/YI7R32L6TRFvCVt64rG660Md/3RS6Y3c4nVkxhw8yiMhiv0tgsQf7EzKESsVsYQHO48QAswTjqsZ/KwiOhk0Q7yICdi13bK3YC4Xkugd87hdd1KSWTiN/ZWQOwrdSC2ck1xsB2iMagpm2uEuSWgEyKVrHPQA3KY/sgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apzcOOYu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7e9fb5352dfso4983606a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734408489; x=1735013289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODdlbqnz0Zimn+aQwf+Shd/vpXRf0EHXzVjtEmSRbQc=;
        b=apzcOOYuTtFRG6oCqhTY4Cz4+bJAvaN4dmy/C/ChRTgjy7UVFHG91ppkuqhq1Hvdmw
         LqGB7p4n3s0MYn0ylaqvXLEkE8eZyO8xsDV2xpkFESJ/uVm56IeVa1gwqdrWZ8o/PvAl
         bhBrSsb04dyS/IvHY4EnQvNOakqn++yuULWdbVLh1nOqFgQrGMLTqkPnjh2dguT+qWZL
         wsDBBG585TGLl9o3ZNA8LIKUqGapUqISLj6wp63unayE76mMQCDB9x11w5gjBgpyVJpn
         +Km2jP0hgKxAfojNFV/lMTn09N831HB0hnK3vxf2rbMsGmZJMxcRxqqc1pVECHVnmkHA
         Oksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734408489; x=1735013289;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ODdlbqnz0Zimn+aQwf+Shd/vpXRf0EHXzVjtEmSRbQc=;
        b=Rv6b5RCeq7N+t/1aOMh4aN1+zKBazEu4PXRSIfPqtMErbRZsXInuwWtqajsN6qmGkt
         8lpAeH4xbL/E4SgIcVWSFeSbFzzBuHpkVE56izW3y1YYoHhU7pBe6oCYziiu9kQkjk4F
         d2QkP7KUz1oS5IxpR5oOkJZIpkmn2MJyCrqnkZKCTUH2GcBb5WkDd6yGfjhTlTHnzPkN
         ctuPTTnhC6PNmTSbiT2thP9896M9QCMl8TKuSbwdXns/OUccZJ03BEOWOzapi/mgnoL1
         PH+p2p7gWgFzYaKpQU7dz7urXvqkXLEE1KxGtLqt4v3iGSFA0fSaURQxb/u7JbsHpwRO
         qAtg==
X-Gm-Message-State: AOJu0YwrmTgWu3iVpkWyXzHZ75aqZ2OhFVmC01rthPyshettJ462v3CI
	rjWcRrwMVeGk4yaXJAVdTw1wCRKyhRJaAHp0TK/BpzE8T6zzaw6a6KWuciiD+qG4svpr+NZYrAP
	XPb7FPtN3vE6eO/FIiVengFWXEEOw/NiCNMNBuy0RzTfWgGPZdpVOwbJR8zewvntcdhYSUA4xKR
	A3VCd+JjpfyNIAD+o5wIqXfGUxxZDvWDRobN83AoUPBOk+
X-Google-Smtp-Source: AGHT+IH5ysypSI0pZhatLkY9MN1wWMdEYKdYTf5MmJT0HgTTfF1udFJqnUXAy4bqnGvmRBxxfMwH7FPADD0D
X-Received: from pfbc14.prod.google.com ([2002:a05:6a00:ad0e:b0:725:edbf:59f2])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3948:b0:1db:f642:8d8b
 with SMTP id adf61e73a8af0-1e1dfe38cedmr22792613637.45.1734408489435; Mon, 16
 Dec 2024 20:08:09 -0800 (PST)
Date: Mon, 16 Dec 2024 20:07:35 -0800
In-Reply-To: <CANDhNCo0W6cYhVQm7TQso=E9evhYy2oxSLnVz-KxbOdfomZFgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANDhNCo0W6cYhVQm7TQso=E9evhYy2oxSLnVz-KxbOdfomZFgQ@mail.gmail.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217040803.243420-1-jstultz@google.com>
Subject: [RFC][PATCH] sched/wake_q: Add helper to call wake_up_q after unlock
 with preemption disabled
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bert Karwatzki <spasswolf@web.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A common pattern seen when wake_qs are used to defer a wakeup
until after a lock is released is something like:
  preempt_disable();
  raw_spin_unlock(lock);
  wake_up_q(wake_q);
  preempt_enable();

So create some raw_spin_unlock*_wake() helper functions to clean
this up.

Applies on top of the fix I submitted here:
 https://lore.kernel.org/lkml/20241212222138.2400498-1-jstultz@google.com/

NOTE: I recognise the unlock()/unlock_irq()/unlock_irqrestore()
variants creates its own duplication, which we could use a macro
to generate the similar functions, but I often dislike how those
generation macros making finding the actual implementation
harder, so I left the three functions as is. If folks would
prefer otherwise, let me know and I'll switch it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Andr=C3=A9 Almeida" <andrealmeid@igalia.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: kernel-team@android.com
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
---
 include/linux/sched/wake_q.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/futex/pi.c            |  5 +----
 kernel/locking/mutex.c       | 16 ++++------------
 kernel/locking/rtmutex.c     | 32 +++++---------------------------
 4 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 06cd8fb2f4098..0f28b4623ad45 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -63,4 +63,38 @@ extern void wake_q_add(struct wake_q_head *head, struct =
task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *=
task);
 extern void wake_up_q(struct wake_q_head *head);
=20
+/* Spin unlock helpers to unlock and call wake_up_q with preempt disabled =
*/
+static inline
+void raw_spin_unlock_wake(raw_spinlock_t *lock, struct wake_q_head *wake_q=
)
+{
+	guard(preempt)();
+	raw_spin_unlock(lock);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
+
+static inline
+void raw_spin_unlock_irq_wake(raw_spinlock_t *lock, struct wake_q_head *wa=
ke_q)
+{
+	guard(preempt)();
+	raw_spin_unlock_irq(lock);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
+
+static inline
+void raw_spin_unlock_irqrestore_wake(raw_spinlock_t *lock, unsigned long f=
lags,
+				     struct wake_q_head *wake_q)
+{
+	guard(preempt)();
+	raw_spin_unlock_irqrestore(lock, flags);
+	if (wake_q) {
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+	}
+}
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index d62cca5ed8f4c..daea650b16f51 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1020,10 +1020,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 	 * it sees the futex_q::pi_state.
 	 */
 	ret =3D __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, cu=
rrent, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irq_wake(&q.pi_state->pi_mutex.wait_lock, &wake_q);
=20
 	if (ret) {
 		if (ret =3D=3D 1)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3302e52f0c967..b36f23de48f1b 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -657,10 +657,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 				goto err;
 		}
=20
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-		/* Make sure we do wakeups before calling schedule */
-		wake_up_q(&wake_q);
-		wake_q_init(&wake_q);
+		raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
=20
 		schedule_preempt_disabled();
=20
@@ -710,8 +707,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int st=
ate, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
=20
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	preempt_enable();
 	return 0;
=20
@@ -720,10 +716,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	trace_contention_end(lock, ret);
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
-	wake_up_q(&wake_q);
 	preempt_enable();
 	return ret;
 }
@@ -935,10 +930,7 @@ static noinline void __sched __mutex_unlock_slowpath(s=
truct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
=20
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
=20
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 697a56d3d949b..4a8df1800cbbd 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1292,13 +1292,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt=
_mutex_base *lock,
 	 */
 	get_task_struct(owner);
=20
-	preempt_disable();
-	raw_spin_unlock_irq(&lock->wait_lock);
-	/* wake up any tasks on the wake_q before calling rt_mutex_adjust_prio_ch=
ain */
-	wake_up_q(wake_q);
-	wake_q_init(wake_q);
-	preempt_enable();
-
+	raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
=20
 	res =3D rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
@@ -1642,13 +1636,7 @@ static int __sched rt_mutex_slowlock_block(struct rt=
_mutex_base *lock,
 			owner =3D rt_mutex_owner(lock);
 		else
 			owner =3D NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		if (wake_q) {
-			wake_up_q(wake_q);
-			wake_q_init(wake_q);
-		}
-		preempt_enable();
+		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
=20
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1799,10 +1787,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex=
_base *lock,
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	rt_mutex_post_schedule();
=20
 	return ret;
@@ -1860,11 +1845,7 @@ static void __sched rtlock_slowlock_locked(struct rt=
_mutex_base *lock,
 			owner =3D rt_mutex_owner(lock);
 		else
 			owner =3D NULL;
-		preempt_disable();
-		raw_spin_unlock_irq(&lock->wait_lock);
-		wake_up_q(wake_q);
-		wake_q_init(wake_q);
-		preempt_enable();
+		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
=20
 		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
 			schedule_rtlock();
@@ -1893,10 +1874,7 @@ static __always_inline void __sched rtlock_slowlock(=
struct rt_mutex_base *lock)
=20
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	rtlock_slowlock_locked(lock, &wake_q);
-	preempt_disable();
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-	wake_up_q(&wake_q);
-	preempt_enable();
+	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 }
=20
 #endif /* RT_MUTEX_BUILD_SPINLOCKS */
--=20
2.47.1.613.gc27f4b7a9f-goog


