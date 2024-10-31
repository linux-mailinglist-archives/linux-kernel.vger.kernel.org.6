Return-Path: <linux-kernel+bounces-390821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3749B7EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0341C21846
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E41B3724;
	Thu, 31 Oct 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRLl5Ymu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XsIAbKnK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0713A87C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389590; cv=none; b=LmfkA8mypQ+Z8df4BtzSt83DAQywReKBaI8K41LWpgBwBYcuvc+SRVoTBYeaetsHKzV0FLhRhdMWn2Bt9PSjkKmGNNtyP3X8/EqoNPz3Rj+sDM0ltVZCGX0uxhNho2/XruKkY2U8GxV8F4+3jF2wFZJoHzwNJ+WUZeI/VNfg9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389590; c=relaxed/simple;
	bh=0v21sYAYBwU9cXvaccySe7nMT4VWgURTxdRXng4D8Xs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LEEl6J7IpFj0wM3Xj8Nppagc2UWeTGAuy91aTeA6b9B6KKzwi5b8xB//cD1ySQJmSXF5UL0VT8Y6Laj0xNJbpv3MmIep8qmIbC8U/JHIBUqIB2YZ6GTOu9MqA40BwZMQbDgzVPx2PAylZX07tr7CbjwfNzhGoUstdA+YTzIJfjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRLl5Ymu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XsIAbKnK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154424.740750741@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BVfbQEbMeSQwFFsPTa1V2ybU7hlWaJTbzcbnkpGZLrk=;
	b=zRLl5YmuxBnONSv8EN01PnKFBINwI4twB3ICfLBsnV114qZEc9tuD/qvhOXVBcH9DR/7oL
	NcOowmsbb9eF78NmtPrhaA/0UhLfyuFK13Mkm6u30DRgbF+SV7pgadmjvryxqWKre98ANl
	nDdRiMZr93PJXbJEyyFBZ73Z0I2V9Rrmu5SpXsa3weJcX6B5m//r23Vik+jRpcZZSqDxuM
	tpRSd6PeUrMinGQF4NtI4WrSvFnJwy3KWaQZaBCnZ+kEMYOiDtXVsrhRYNIEp3zLCgzv+a
	6EWLE/TWi+gExFUYpeW5atjwA+iJqftWPKvnCgDIap7BT0pqiQrtRsVToebS/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BVfbQEbMeSQwFFsPTa1V2ybU7hlWaJTbzcbnkpGZLrk=;
	b=XsIAbKnKJ2nGvZV6yY+tJg+NL6J7zoVmPR1Bpj60jSYWOOmGUoz8LnpCww0HSQQ/8zZoqs
	Bxg961Ng8lZ+tdAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v6 03/20] posix-cpu-timers: Cleanup the firing logic
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:26 +0100 (CET)

The firing flag of a posix CPU timer is tristate:

  0: when the timer is not about to deliver a signal

  1: when the timer has expired, but the signal has not been delivered yet

 -1: when the timer was queued for signal delivery and a rearm operation
     raced against it and supressed the signal delivery.

This is a pointless exercise as this can be simply expressed with a
boolean. Only if set, the signal is delivered. This makes delete and rearm
consistent with the rest of the posix timers.

Convert firing to bool and fixup the usage sites accordingly and add
comments why the timer cannot be dequeued right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V6: New patch after detecting the tristate mismatch vs. bool from the
    patch which introduced the nanosleep flag.
---
 include/linux/posix-timers.h   |    2 +-
 kernel/time/posix-cpu-timers.c |   29 +++++++++++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -49,7 +49,7 @@ struct cpu_timer {
 	struct timerqueue_head		*head;
 	struct pid			*pid;
 	struct list_head		elist;
-	int				firing;
+	bool				firing;
 	struct task_struct __rcu	*handling;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -494,6 +494,13 @@ static int posix_cpu_timer_del(struct k_
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
 		if (timer->it.cpu.firing) {
+			/*
+			 * Prevent signal delivery. The timer cannot be dequeued
+			 * because it is on the firing list which is not protected
+			 * by sighand->lock. The delivery path is waiting for
+			 * the timer lock. So go back, unlock and retry.
+			 */
+			timer->it.cpu.firing = false;
 			ret = TIMER_RETRY;
 		} else {
 			disarm_timer(timer, p);
@@ -668,7 +675,13 @@ static int posix_cpu_timer_set(struct k_
 	old_expires = cpu_timer_getexpires(ctmr);
 
 	if (unlikely(timer->it.cpu.firing)) {
-		timer->it.cpu.firing = -1;
+		/*
+		 * Prevent signal delivery. The timer cannot be dequeued
+		 * because it is on the firing list which is not protected
+		 * by sighand->lock. The delivery path is waiting for
+		 * the timer lock. So go back, unlock and retry.
+		 */
+		timer->it.cpu.firing = false;
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
@@ -809,7 +822,7 @@ static u64 collect_timerqueue(struct tim
 		if (++i == MAX_COLLECTED || now < expires)
 			return expires;
 
-		ctmr->firing = 1;
+		ctmr->firing = true;
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
@@ -1364,7 +1377,7 @@ static void handle_posix_cpu_timers(stru
 	 * timer call will interfere.
 	 */
 	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
-		int cpu_firing;
+		bool cpu_firing;
 
 		/*
 		 * spin_lock() is sufficient here even independent of the
@@ -1376,13 +1389,13 @@ static void handle_posix_cpu_timers(stru
 		spin_lock(&timer->it_lock);
 		list_del_init(&timer->it.cpu.elist);
 		cpu_firing = timer->it.cpu.firing;
-		timer->it.cpu.firing = 0;
+		timer->it.cpu.firing = false;
 		/*
-		 * The firing flag is -1 if we collided with a reset
-		 * of the timer, which already reported this
-		 * almost-firing as an overrun.  So don't generate an event.
+		 * If the firing flag is cleared then this raced with a
+		 * timer rearm/delete operation. So don't generate an
+		 * event.
 		 */
-		if (likely(cpu_firing >= 0))
+		if (likely(cpu_firing))
 			cpu_timer_fire(timer);
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(timer->it.cpu.handling, NULL);


