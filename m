Return-Path: <linux-kernel+bounces-396086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC19BC7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A231C223AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C71FF7A7;
	Tue,  5 Nov 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suU0nOrb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pTzd0WL2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57E1FF05A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794477; cv=none; b=CLnFI6VfgWSg5WpIZfdPmtJGI/H1t7HlVD/hnrraynYWE1JxSfwMQCd2MhmH+dBqaMb4Ga3/efRUB7ag8rIW7t/2HWPZOKhlI2rXTAR56AoGZYj7z/m8fheMP4D8LcAOfJ7QWoIIhQh2g7pd8yxmGUefE8hIehuhrIVhp0Y0AWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794477; c=relaxed/simple;
	bh=c3Lph81oMf0goXncboFVGmR343kjPGdbLZcb7N8wzsc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=omtScAxrZE2OyzOKJXI9XRm8foQ+zyHvrOFDuB5IcmB5oJm+JBRG7VB0K8RiVgoFJ7JO4FyuW/LU+qemvNit3LHSyIKFqAJHBoYuyiYzod+CK94Lv+zR89E1+lZaRVxZWZPSS8LoiKahj8Txp/NM3hVZOGXc9GfeYn79lD1xsV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suU0nOrb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pTzd0WL2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.172848618@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jhFH3e0s8X8HFfwCBrDT2nkkk+DEiwk3P1itqXy87Ts=;
	b=suU0nOrbnMRSfkf5NTU4BycUoFv3lekPIsemPcBThn7rime5CoUoNe+eXHKQIfn87fUbRx
	XtMpIL3WrE2ZSsT9Tf+G4h+yI1J4wzGjaV1vKzLvgHmcebrbqTnqcoI8bu9G/KmH7Mz0EW
	VrW+UAtuLOUNxblyoX79LZmFmmGLQw7gMOXL2b36rQ8t/JIX0vn1mcOhyeI1Q+uqqJjPaP
	yWq6C2xw8yXg9mZmZyuhcyCAsSlqH4GLSlXXgNc1O2HYkNHzAlMEPYNMQfRkLsXCcMbxtr
	moQNc+PSEhIbH6Ks9IwPM3sNLmsADwEYMMsUNQ7yz9No0TKkLyRQxbTjXq/lUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jhFH3e0s8X8HFfwCBrDT2nkkk+DEiwk3P1itqXy87Ts=;
	b=pTzd0WL2XmEa9OGdzu0uqAWxqRcaBQXmkqGObKnsHcIRb0y4GCo4TlA9RR7PDfOyEFhSCw
	qEmZr5Ieyxbsy4Cg==
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
Subject: [patch V7 04/21] posix-cpu-timers: Cleanup the firing logic
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:33 +0100 (CET)

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
V6: New patch after detecting the tristate mismatch vs. bool from the
    patch which introduced the nanosleep flag.
---
 include/linux/posix-timers.h   |    2 +-
 kernel/time/posix-cpu-timers.c |   34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

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
@@ -493,10 +493,18 @@ static int posix_cpu_timer_del(struct k_
 		 */
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
-		if (timer->it.cpu.firing)
+		if (timer->it.cpu.firing) {
+			/*
+			 * Prevent signal delivery. The timer cannot be dequeued
+			 * because it is on the firing list which is not protected
+			 * by sighand->lock. The delivery path is waiting for
+			 * the timer lock. So go back, unlock and retry.
+			 */
+			timer->it.cpu.firing = false;
 			ret = TIMER_RETRY;
-		else
+		} else {
 			disarm_timer(timer, p);
+		}
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -668,7 +676,13 @@ static int posix_cpu_timer_set(struct k_
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
@@ -809,7 +823,7 @@ static u64 collect_timerqueue(struct tim
 		if (++i == MAX_COLLECTED || now < expires)
 			return expires;
 
-		ctmr->firing = 1;
+		ctmr->firing = true;
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
@@ -1364,7 +1378,7 @@ static void handle_posix_cpu_timers(stru
 	 * timer call will interfere.
 	 */
 	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
-		int cpu_firing;
+		bool cpu_firing;
 
 		/*
 		 * spin_lock() is sufficient here even independent of the
@@ -1376,13 +1390,13 @@ static void handle_posix_cpu_timers(stru
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


