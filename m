Return-Path: <linux-kernel+bounces-444006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E99EFF35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E172281427
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C281DC07D;
	Thu, 12 Dec 2024 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtpmvQDJ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA31898FB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042107; cv=none; b=NgYhdT7dC5dh/sjijkpYgDVxlAUqAucklJBs38yqkjl3IaHVAMbn+wjB9uT/xUqfkaddiMSRqChXb4My9qYG7chFi/vSZ0MvhWHdLnVZCaza86vdGUVGYiEyHv6ODAfVpXZ5j879TYhbJ5Xc25a5R0NSoouDJOUIlVbLZ8YWAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042107; c=relaxed/simple;
	bh=V6FMZ7ioP0vNk4aJJm/g31gyQ2HLySVPxZfp/chprss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hbqiKGktnnFmoiGLBMHpxv733RFbwvgi+RV/QkY/jsDXeKffOEHqTublsW9xTSixglAR1H+5d/dnhueyKUTTp8u1qKiQ6KGZDmHLw0kp2tXXs9h9Jzq91720CCfXQjtat473OVPGFqrk5ooKWa8FdRxUQmu6/2/Hz7JSMwWLObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtpmvQDJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-729046e1283so432093b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734042105; x=1734646905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5GhVzS8goU7s3tTksfKULA1xC2PbflGLIcaAH9yyqBw=;
        b=TtpmvQDJPSXMO9SH8DmXrs/QW8q388zGPffyH9lWUKLh3uXzfir/xkn2Pbbr3/lMte
         Uw/Ei4XnRgCm9mP40Q50z5oNph4NwPFyFErhJvRWq+Qjg/+gZw43+zR2JO+RqoADTY5B
         kl1ZVGR0Py6KZeu4JZ1qyYENs2+S5iMl6oe6yjBvZ/fjBIxA5+R/d5Nyyduo6yQfxkVV
         E92WWxmuoWoYwUiT29uvEQhGFjnleqc2eF13mrjcRunYrFzKOdPd78M19gMTBqgVrods
         M+Zk1WNrqYKqQ6fx8xeftHpUVC2fXUhFQ0V6+f4FCbZP3uikONgj4AU1LiqEGwJ/W957
         S1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042105; x=1734646905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GhVzS8goU7s3tTksfKULA1xC2PbflGLIcaAH9yyqBw=;
        b=T04Yls2vt2zRsUu5+CGfhcOZ7oP51fXdrsqU5pAlHPJBAVTTXbAz8g6g7NB8zsdbja
         GFgzBuS/aK0OzXzSF8PyWFaNDzpf1LkM9BKY/wLb7sQYtBt8YrZTCJd6is0FqAnTwb1d
         Hv4YcYTi7+xK4VrdGHKfX4HxZ8I/6H7QMQhLV3C2e/2WbglNpj4kGriaS14CHOaitogz
         chrF1lL4gOWlHr+wSF7Dc/iCxV2TJGzZxRmEfIXNM6eCP/Ryeba9n+eNBjwc9Binl46B
         KVnH94MnCzRlUiPNgHNA/FsbEWYkovqpybSeOw1an4m5hZoj4K/xMxzoUoX1/OWEK1Ba
         xHyw==
X-Gm-Message-State: AOJu0YyIi0gIhoPWoQADlNPSYd2tkdhMoAnHFfQleUInbBY9+IEdVCw5
	3qu+kR3Eu4u0WIgu11qnW3XDMXWpWn6QnSdkToOyMBUP9CsbOJ06EjJEYkCdcgVyqImlu0FaEGi
	zH8VIYVGMkgnXsB05NNjUiPsQfBsmVaUClhD7aUNHpVxGKgfbZtdLPLjL5y/M8bU/BBd/K8XlYP
	iugdh/egonUg1sDYwW6gLWRv09wDXa7Cb+abzt6Al6Gisq
X-Google-Smtp-Source: AGHT+IEzqgC1HlDDGkUIhUJndc2DDikgtBHeBew+E7ym34sXAgkgVftU6bLUIK9Yfpa9YEO4MRU5uZ5+IGNE
X-Received: from pfay32.prod.google.com ([2002:a05:6a00:1820:b0:725:d2c1:3f5f])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b56:b0:727:3c37:d5f9
 with SMTP id d2e1a72fcca58-7290c26863dmr323501b3a.26.1734042104600; Thu, 12
 Dec 2024 14:21:44 -0800 (PST)
Date: Thu, 12 Dec 2024 14:21:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212222138.2400498-1-jstultz@google.com>
Subject: [RFC][PATCH] locking/rtmutex: Make sure we wake anything on the
 wake_q when we release the lock->wait_lock
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bert Karwatzki <spasswolf@web.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Bert reported seeing occasional boot hangs when running with
PREEPT_RT and bisected it down to commit 894d1b3db41c
("locking/mutex: Remove wakeups from under mutex::wait_lock").

It looks like I missed a few spots where we drop the wait_lock and
potentially call into schedule without waking up the tasks on the
wake_q structure. Since the tasks being woken are ww_mutex tasks
they need to be able to run to release the mutex and unblock the
task that currently is planning to wake them. Thus we can deadlock.

So make sure we wake the wake_q tasks when we unlock the wait_lock.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: kernel-team@android.com
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/lkml/20241211182502.2915-1-spasswolf@web.de
Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/rtmutex.c     | 18 ++++++++++++++++--
 kernel/locking/rtmutex_api.c |  2 +-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e858de203eb6f..697a56d3d949b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1292,7 +1292,13 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 */
 	get_task_struct(owner);
 
+	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);
+	/* wake up any tasks on the wake_q before calling rt_mutex_adjust_prio_chain */
+	wake_up_q(wake_q);
+	wake_q_init(wake_q);
+	preempt_enable();
+
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
@@ -1596,6 +1602,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
  *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for none
  * @waiter:		 the pre-initialized rt_mutex_waiter
+ * @wake_q:		 wake_q of tasks to wake when we drop the lock->wait_lock
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
@@ -1603,7 +1610,8 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   struct ww_acquire_ctx *ww_ctx,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
-					   struct rt_mutex_waiter *waiter)
+					   struct rt_mutex_waiter *waiter,
+					   struct wake_q_head *wake_q)
 	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
@@ -1634,7 +1642,13 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
+		preempt_disable();
 		raw_spin_unlock_irq(&lock->wait_lock);
+		if (wake_q) {
+			wake_up_q(wake_q);
+			wake_q_init(wake_q);
+		}
+		preempt_enable();
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
 			rt_mutex_schedule();
@@ -1708,7 +1722,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, wake_q);
 	if (likely(!ret))
-		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
+		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter, wake_q);
 
 	if (likely(!ret)) {
 		/* acquired the lock */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 33ea31d6a7b3b..191e4720e5466 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -383,7 +383,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter);
+	ret = rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter, NULL);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
-- 
2.47.1.613.gc27f4b7a9f-goog


