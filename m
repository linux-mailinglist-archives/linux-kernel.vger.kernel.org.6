Return-Path: <linux-kernel+bounces-513811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A3A34EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA90616D463
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C47266196;
	Thu, 13 Feb 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/jFSOpf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC224BBF7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476970; cv=none; b=IFtUjRhRj2Nmmz91ULMCYYsMTd+l15uLSTDymkCVcokA5h3yAPtwBTeJ72wnV9K4ht6/W9MLNpb8yg1N45kYImK0frysA4PCRzD2Qa6/ePLcbnr3PI1XNvyLA8m3qYXxvqh9mI0hYZPyRBSLt1ru+m1ylZEQpJY+vQ8juIAEFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476970; c=relaxed/simple;
	bh=xQnYCBQJlOCqN0QxyY/yXcLZ+NgzI2pqR3+zsf/WQWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0noV+DLWbj4E3h/FrAe77krRLgzMKMCminuq3nb8lVqshG6LoVVG3Y+q4hln8NIHA+Nr4mn2cUIvPyxtfNNy2O4C2xYc8SgrJNIBtJBWVbMteJGcBFVmB6UfEk6/ikq0RjQpWiYon+ek4WdsilgWzyc7re2HV8y9bEdCDUV3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/jFSOpf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739476968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2qiXC/cNFFNJmD/Jr1WU9cXX6QUwEFoWyQGXl5gh0Q=;
	b=M/jFSOpf95M2QZ+T/sUZHdpXv6f094OESBjln220MD1eytLhzjRW7wOg27NyAZ1eOqazdx
	Yo40Mu4Op1+TKIIGhBiH0dyCAYdlxurMPh9waK70+UkrESs7CtBz2LMcrh+e1mNMpi8blJ
	QuD/14V4XsDKre3+/UcrINimFyBFlRE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-_VGgiUUcOfCNkxtkAmgh3Q-1; Thu,
 13 Feb 2025 15:02:43 -0500
X-MC-Unique: _VGgiUUcOfCNkxtkAmgh3Q-1
X-Mimecast-MFC-AGG-ID: _VGgiUUcOfCNkxtkAmgh3Q
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02D4E19560B5;
	Thu, 13 Feb 2025 20:02:42 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.174])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53E5A180035E;
	Thu, 13 Feb 2025 20:02:39 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/4] locking/lock_events: Add locking events for rtmutex slow paths
Date: Thu, 13 Feb 2025 15:02:25 -0500
Message-ID: <20250213200228.1993588-2-longman@redhat.com>
In-Reply-To: <20250213200228.1993588-1-longman@redhat.com>
References: <20250213200228.1993588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add locking events for rtlock_slowlock() and rt_mutex_slowlock() for
profiling the slow path behavior of rt_spin_lock() and rt_mutex_lock().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h | 21 +++++++++++++++++++++
 kernel/locking/rtmutex.c          | 29 ++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3f840a..80b11f194c9f 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -67,3 +67,24 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+
+/*
+ * Locking events for rtlock_slowlock()
+ */
+LOCK_EVENT(rtlock_slowlock)	/* # of rtlock_slowlock() calls		*/
+LOCK_EVENT(rtlock_slow_acq1)	/* # of locks acquired after wait_lock	*/
+LOCK_EVENT(rtlock_slow_acq2)	/* # of locks acquired in for loop	*/
+LOCK_EVENT(rtlock_slow_sleep)	/* # of sleeps				*/
+LOCK_EVENT(rtlock_slow_wake)	/* # of wakeup's			*/
+
+/*
+ * Locking events for rt_mutex_slowlock()
+ */
+LOCK_EVENT(rtmutex_slowlock)	/* # of rt_mutex_slowlock() calls	*/
+LOCK_EVENT(rtmutex_slow_block)	/* # of rt_mutex_slowlock_block() calls	*/
+LOCK_EVENT(rtmutex_slow_acq1)	/* # of locks acquired after wait_lock	*/
+LOCK_EVENT(rtmutex_slow_acq2)	/* # of locks acquired at the end	*/
+LOCK_EVENT(rtmutex_slow_acq3)	/* # of locks acquired in *block()	*/
+LOCK_EVENT(rtmutex_slow_sleep)	/* # of sleeps				*/
+LOCK_EVENT(rtmutex_slow_wake)	/* # of wakeup's			*/
+LOCK_EVENT(rtmutex_deadlock)	/* # of rt_mutex_handle_deadlock()'s	*/
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a8df1800cbb..c80902eacd79 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -27,6 +27,7 @@
 #include <trace/events/lock.h>
 
 #include "rtmutex_common.h"
+#include "lock_events.h"
 
 #ifndef WW_RT
 # define build_ww_mutex()	(false)
@@ -1612,10 +1613,13 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 	struct task_struct *owner;
 	int ret = 0;
 
+	lockevent_inc(rtmutex_slow_block);
 	for (;;) {
 		/* Try to acquire the lock: */
-		if (try_to_take_rt_mutex(lock, current, waiter))
+		if (try_to_take_rt_mutex(lock, current, waiter)) {
+			lockevent_inc(rtmutex_slow_acq3);
 			break;
+		}
 
 		if (timeout && !timeout->task) {
 			ret = -ETIMEDOUT;
@@ -1638,8 +1642,10 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			owner = NULL;
 		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
-		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner)) {
+			lockevent_inc(rtmutex_slow_sleep);
 			rt_mutex_schedule();
+		}
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1694,6 +1700,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	int ret;
 
 	lockdep_assert_held(&lock->wait_lock);
+	lockevent_inc(rtmutex_slowlock);
 
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
@@ -1701,6 +1708,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 			__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
+		lockevent_inc(rtmutex_slow_acq1);
 		return 0;
 	}
 
@@ -1719,10 +1727,12 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
+		lockevent_inc(rtmutex_slow_acq2);
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
+		lockevent_inc(rtmutex_deadlock);
 	}
 
 	/*
@@ -1751,6 +1761,7 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 				  &waiter, wake_q);
 
 	debug_rt_mutex_free_waiter(&waiter);
+	lockevent_cond_inc(rtmutex_slow_wake, !wake_q_empty(wake_q));
 	return ret;
 }
 
@@ -1823,9 +1834,12 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 	struct task_struct *owner;
 
 	lockdep_assert_held(&lock->wait_lock);
+	lockevent_inc(rtlock_slowlock);
 
-	if (try_to_take_rt_mutex(lock, current, NULL))
+	if (try_to_take_rt_mutex(lock, current, NULL)) {
+		lockevent_inc(rtlock_slow_acq1);
 		return;
+	}
 
 	rt_mutex_init_rtlock_waiter(&waiter);
 
@@ -1838,8 +1852,10 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 
 	for (;;) {
 		/* Try to acquire the lock again */
-		if (try_to_take_rt_mutex(lock, current, &waiter))
+		if (try_to_take_rt_mutex(lock, current, &waiter)) {
+			lockevent_inc(rtlock_slow_acq2);
 			break;
+		}
 
 		if (&waiter == rt_mutex_top_waiter(lock))
 			owner = rt_mutex_owner(lock);
@@ -1847,8 +1863,10 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 			owner = NULL;
 		raw_spin_unlock_irq_wake(&lock->wait_lock, wake_q);
 
-		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner)) {
+			lockevent_inc(rtlock_slow_sleep);
 			schedule_rtlock();
+		}
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(TASK_RTLOCK_WAIT);
@@ -1865,6 +1883,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 	debug_rt_mutex_free_waiter(&waiter);
 
 	trace_contention_end(lock, 0);
+	lockevent_cond_inc(rtlock_slow_wake, !wake_q_empty(wake_q));
 }
 
 static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
-- 
2.48.1


