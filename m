Return-Path: <linux-kernel+bounces-208611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3990272D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E41F22032
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638CB158DC6;
	Mon, 10 Jun 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fI9SObHD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HyMuCgd7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513A158D77
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037786; cv=none; b=nN290zwm7GHkTGU/jghi+5fwrZTrPDsuL73ZjWP+qY5CP5qH0+BXyiwPfD/akE3UMfBfaZDynGQRYR+5PGGok+YfqyPheW1FkbSj+zu718YvzvT/xOsYXS460YztNSa05y0TOe1JQ1DPV0HVOd0kIdlJRdn8KXNPH3vUidLDSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037786; c=relaxed/simple;
	bh=S6JUDkyUPN6u68oQn5OUPewj7arp5+lzXuIlS/xwEHU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DEyc7S4HkRPx2vHk/4V7inxIWWkIMdb4CEP6u3CKXq8sUz8eJ6l3KpVm/MFG26bShuBQHJoKEtUilPJlcLp9Hob6ula+2KoLdOQp0+w5UBiJtY5GVAigofa+AJBSN4cZoccqTpL5yy8DjJeQW4brOfirriDP8G3qLyU9xBBTstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fI9SObHD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HyMuCgd7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164028.349232422@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=h6hDrXB0chXNrUH4sCnb+tErkyrDv3iJrXtwT3bPMl8=;
	b=fI9SObHDM9O6wikpox0ex9IAcR01YvcTqVRh8/mNFLPytHBI4CkQfZcZQ0SdF2e+c5h1FL
	067m/aa8KMmO28Ab/6jlVYVUlKyJwnNaXHi60H9cVf6OZZOy2zrPRVC0LEjLjZeHSMWL/D
	sLXRIJqi97aimIRRy1TES1EVsJaolvH+tjJIOd/F6dZxgJIS1OO/JtsilvbNjvuPM0DDt0
	EcPPKGRukN17EU3vhYkbfavXzKyaJ79O9r3PTy2g95+ig1AbIdo9SdE10lh0NDkPflF+J9
	z3/gyTZ9vnk4esFhsdrVa3OT2VaC9MI8I83XGToLjDQQ3novEn3Hi9MomWETJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=h6hDrXB0chXNrUH4sCnb+tErkyrDv3iJrXtwT3bPMl8=;
	b=HyMuCgd7e3EwTD6aSkoRg6Qhqf6hHQgB+svRqdC4DlihL0iwEAf6J0sMTgl2HIi1hyfg24
	zcmW/OHD9AdmSmBA==
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
Subject: [patch V3 46/51] posix-timers: Handle ignored list on delete and exit
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:43:02 +0200 (CEST)

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    4 +++-
 kernel/time/posix-timers.c   |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -151,7 +151,8 @@ static inline void posix_cputimers_init_
 
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
@@ -174,6 +175,7 @@ static inline void posix_cputimers_init_
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1036,6 +1036,18 @@ int common_timer_del(struct k_itimer *ti
 	return 0;
 }
 
+/*
+ * If the deleted timer is on the ignored list, remove it and
+ * drop the associated reference.
+ */
+static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
+{
+	if (!hlist_unhashed(&tmr->ignored_list)) {
+		hlist_del_init(&tmr->ignored_list);
+		posixtimer_putref(tmr);
+	}
+}
+
 static inline int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
@@ -1068,6 +1080,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1119,6 +1132,8 @@ static void itimer_delete(struct k_itime
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1151,6 +1166,11 @@ void exit_itimers(struct task_struct *ts
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers))
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+
+	/* Mop up timers which are on the ignored list */
+	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
+	while (!hlist_empty(&timers))
+		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer, list));
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,


