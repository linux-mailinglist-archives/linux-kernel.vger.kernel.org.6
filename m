Return-Path: <linux-kernel+bounces-552126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D9AA57606
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA6B7A9FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38F25A348;
	Fri,  7 Mar 2025 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0YLHXT7"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4F25A2B1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390133; cv=none; b=ajPxjXgRPcQ2jixP/4GNZnHAYTnmq2i6Umxl/uscnUHauOODdLkI8bTWOOBM9dkAc6FIE3sIcmlNa0Pvsr4DmL3ExkKucEZ5J/joh0NEUo9UwRzMr9NV3D7DH6yX94MqRObnd7cRaJv81MGtdeWEZ8xLB2zBOzQ4jcBqq+X3yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390133; c=relaxed/simple;
	bh=YWS3YTxPo0eIxetQZ5Wi1gbfGXr70VpbX+VkMOMzsbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCEi9Q7iqOH19RqoyaPGVpH8K6jqxNvefbOrX5WOnrE4Zx7jI2bKjageR3k5i+ct3dEzNPmN0SGCLkh7k7bjwJ18yVyHIN6sc5wcgnGCKVkz9Lm+7cFg9OsEwhEsGXS6gwL1NabDeVEDHspF9T6xDgeOuDC27fANqSwplPkma1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0YLHXT7; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so18977796d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 15:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390130; x=1741994930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nK9C2ycbnsbicr/CbpEtAT9WiQIoIO2pIW0NwItXeA0=;
        b=B0YLHXT7Qvoq/ctVpznKH9F8FLp/VtJ7hyXkUJ2X4E8O+MJzZGgAECbigoARjyZHhT
         7x1SFcyslL4jc7dW0KOx5S1hhozihNEIB/ws8lV7+OsXCkfUcsFWDlvqJYO97Int8f6A
         Wm6kFvWHLk7ZLLPfOFfihYXT/Vv5jDOoEo/WICFzTDRxrvBXYaAFclMo0FoUM1XER7aq
         8tZaadF9JeyFk1XFH+/UDkHqsaB5EvWD1TKs6fJZkSgSZ0QJBQPSYY1HZTsSwh2rCxRI
         4nhyoPz8CbRvpNTSNheDzqEL6jpypVk7iaO6ynlCpiSMBjlgJts8dzSWBLE6miZP9LaA
         vVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390130; x=1741994930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nK9C2ycbnsbicr/CbpEtAT9WiQIoIO2pIW0NwItXeA0=;
        b=PwaWa8ddd6SJsD1hsUQG+4ItZD1K6JY2I+q6DmCSeAQBrZRF/zaGqbhqUgPqfaPuYR
         zjzMkdOgDfVG0Ox6j1VJhfSFBqJaTk4basUJ6TMGF7ulROQkOITNRvSlTCSLjQq6lz0B
         IhRgcRsN58n6BXUWoDHRI6cOPTvvRTyzTE+iga1raFp90cqaVn7PSoUnqws/uEILe758
         bFmpn8swDyBsviHf1HdOyrroDz/a+109YPedkVdfnFaV7k2C4MgAAenPAWrtHWD2RTrN
         yzn403DzbH8S5VLmBNUKmNS/2pSw8w0ax5f8c6DkOk9xxPJoYzBZk8z2Xucl0t/g++uv
         2UhA==
X-Forwarded-Encrypted: i=1; AJvYcCXgxMJL8KwTfeJvNwqEtPlDgtriXMb8gTel9K9XCGKJ6CPdVgCUNocV50TDFsYEIgXd5Oh56XTU+WO5XUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXDzeG3ZQTikSZm/HfTLT3oVqkUieb64kSNLO3/MGICxLiTLf
	c6QtC4zQfbd3pgNBaPIRzwQkurbXXGyiN2zxesePbAbRpzBmQ7JL
X-Gm-Gg: ASbGnctfktfBUzdfzwHe0rdQKTbq19p5Ker4k4pV3E6PEByxBSums1Q5sJnSm3bEYpH
	eJJU3++20UfKd3nPxDKiVcSoArdfmAu9zKG174MM7tTw6IEYRTL1zSfLs1fWBGc2xcJQSnyRLDl
	cel2S82RwQ0fq9XB4TIHN44cRaZ64I3SPgqeVt92iAZskToSoDVGqqbvoPatpY/eAd4N0DpNhb3
	4pguipJjlWR+KART4gNIjpoWXYlTv3M7qaobjfkV/90qjoGIfZkA1lDab2VLeIQ+VDuXh0zPWiH
	daUdp0e8Z7BVIxjeUlWpIPZ8CZnIB79GyhgcOn9s/H92M9xUKKumJuL0vnR1sZB078nZe55ubf5
	h+WcDYajc6qrvFzITV7PXgZEYSAsOhof1Kiw=
X-Google-Smtp-Source: AGHT+IH1508u/0Io/iePaf6ivNgvvb8S3mxMKS0aUYuDLOagTX1WvAsArhuVHGGT88SIj2qTxIZPjA==
X-Received: by 2002:ad4:5ce8:0:b0:6e6:68d6:3932 with SMTP id 6a1803df08f44-6e900693f6amr58047116d6.40.1741390130146;
        Fri, 07 Mar 2025 15:28:50 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7171e6esm24680806d6.104.2025.03.07.15.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:28:49 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 64A37120006A;
	Fri,  7 Mar 2025 18:28:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 07 Mar 2025 18:28:49 -0500
X-ME-Sender: <xms:MYHLZ69rkxdPwlcsq84PKr4F20zyBsjs7ieAZfR9ugQNqYOW1ppb0A>
    <xme:MYHLZ6svzstmxARmmRMrusdQnLj9wJcgxSCKtN1tR8j-RuFGY9nEBvnck5TeKA2Po
    ykZDx0pY1LZ3FriZg>
X-ME-Received: <xmr:MYHLZwBGojjS2f8IowKrS392dZN5oNi_Sep7OaMX-WkYsZD1Eg7BFhDtMeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgv
    ughhrghtrdgtohhm
X-ME-Proxy: <xmx:MYHLZyc637RpFAJfDNi0JanY1nhWiR9ALT4-U3PK8hpLiMWg_AHlug>
    <xmx:MYHLZ_OQgjsYd7eBConzmKJx3rxgXB20N0zyxSXO8v9xa5gGesQKTA>
    <xmx:MYHLZ8mlvH8tmCn4qc9mIQ0nS5nMsu_5PZGNCOGBCCgUFwjB2HKs_A>
    <xmx:MYHLZxu-LnZkTNvYjBsIOeeCNus6RtT2bfgyNnc_hBlfg5iO5kW7SQ>
    <xmx:MYHLZ1sASASjMeyBvUz5gSnNoHNiAbXJ_zGGo3eCac6z_EO1UNi91g4z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:28:48 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH locking 03/11] locking/lock_events: Add locking events for rtmutex slow paths
Date: Fri,  7 Mar 2025 15:26:53 -0800
Message-ID: <20250307232717.1759087-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

Add locking events for rtlock_slowlock() and rt_mutex_slowlock() for
profiling the slow path behavior of rt_spin_lock() and rt_mutex_lock().

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250213200228.1993588-2-longman@redhat.com
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
2.47.1


