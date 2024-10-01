Return-Path: <linux-kernel+bounces-345551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC398B764
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EE91C2279B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99411BF7F0;
	Tue,  1 Oct 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKYz36kI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGvqb0J/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC41BE87C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772155; cv=none; b=G0rLHXOWJPY66LP3LTZABIkKZMYrM/uryRT7FdoVpxTqKe64k9OgYq5Sjfe2FvDskGONECvxke1ht4qCwDWzygoTzOi8LnedsKS3gy2uP5vZVOo63W11YlggDlAEMH/LtJvLPCn21G16TOT1Cgeo7NrFkiJYe4dRkKSPUjYZhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772155; c=relaxed/simple;
	bh=ugm1bDvC3jut/vMuR/KbvcyMOYDJMmXjOVhnIPLEVhY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=EBre4hZngpiY27S0eNKZZ9SYLIrUFBGrgPZmtS8pRALV85lze3vIePPtgWKAJDGG3vBGdpOVgz7g3BT1b7A0jiKmdodVOax0iBPVp7eGMWWR1kHBF2RlVVeK5OVNLMAK4tw/nsGBsvI/uwTmWup5cbZ4GUg/y4yqFvnHDkcqYyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKYz36kI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGvqb0J/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.514196709@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=c6Y96xN0JlBMa7/gJ/CnZwn5sY28IT7kPPBfheQu2l4=;
	b=hKYz36kI2iyfXQ3c1cMeN4pPdtTLIZR87pn4Fo9u30PmcmzeaOHZOb+hP3TT98DhnvypOv
	xKEnTnFsbabOWPOWrFLX87FUtu6wroeaIM73Pyre8wtthy68nEGexQlOBsjRjvotsIUq7R
	DWOzB8OySBNz3GI7g1NqsQmd2jXwnBMwgMSsdiv/4mHwErzXV89By5hR9jfd3/iO9rVSqO
	10QH4UZb5rFpt54/AkB+9JxYyRhODLHEf1bELTDq3X77c1YbruqmDSY4Iobeqegm5fBPNm
	N+2sFEl0tmeW1SBIAfQIGBX6wor3VPkbgB7kGYzQZP+1in9DzLdpQLz6uJe5+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=c6Y96xN0JlBMa7/gJ/CnZwn5sY28IT7kPPBfheQu2l4=;
	b=LGvqb0J/ea7/g7G34YLpcs07FMEivcCoRFm6d4pAFGTYsW3IEJpZkgTdS5tmB8rw82S1ek
	QLQcRzJXCP4D4LCw==
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
Subject: [patch V5 21/26] posix-timers: Handle ignored list on delete and exit
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:29 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h |    4 +++-
 kernel/time/posix-timers.c   |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
---
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -152,7 +152,8 @@ static inline void posix_cputimers_init_
 
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
@@ -176,6 +177,7 @@ static inline void posix_cputimers_init_
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1031,6 +1031,18 @@ int common_timer_del(struct k_itimer *ti
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
@@ -1063,6 +1075,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1114,6 +1127,8 @@ static void itimer_delete(struct k_itime
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1146,6 +1161,11 @@ void exit_itimers(struct task_struct *ts
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


