Return-Path: <linux-kernel+bounces-396098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0839BC7D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD58B22B28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01BC2036E1;
	Tue,  5 Nov 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RYP8TksG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrSOIeM+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707F2022EE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794495; cv=none; b=dNZUXvfE1vZFxT+akQbZlzkjA4soyWwN2a5ppVTWh2MXZeY+3XIK9ejYLNNbcPrjtRL98O73szvAwLH0Wq66KVl8moV24layyoZIkcdvYqA6pGvo5h5nDgTy1f3VwQAJxVF3EH0qLjk9roRoGz2t0c1xUVL98VGC/V2kNs3x3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794495; c=relaxed/simple;
	bh=OdxRJWzsqlt3RDPicipw19FTh9P42wtBr2ai+KIEZ94=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IXB74m66egIaIr3r2Urm4atJkXuEJxh8RF8rkq873kAJKRnhAOIB2lcmfyOLemhTVfWKus1y8CL1mV8zmmyhdsCPmWXHovssauTacJsE8+P5036IsL3ppWLypXqE2NPerpYN0d0ijOH2mFXZFZsnq3REAudi/Mw7vKbnE6SUHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RYP8TksG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrSOIeM+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.987530588@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vgoa6rtDkkb0z+4ZnUL4z1FDa/4gqsWfMTkB0ZqCFsI=;
	b=RYP8TksGw8DpWhNNRzKSXxfR1AfjECZJw3eQ1Hqu6QOw2l5T+H10xSp28vtwQOD1F1+xz6
	+3zr/ws3p3bTTDJpteBEykVVagQ1/vXIFn5eQW2Dp/QDCtwe2RN0Hjcug/Nk+LygN0HplI
	XqiMf4kifpkb1zQvJFFWOhA5ybuXXNvkEzO9GZHeuKzD4HvyBTOhmPN1GRT34BPkTESYGq
	y5IuDSlmK2PrYKjVwgPW6dJcS6t9mRsW3IUGEluOMK8KP719HXcejiPTJx41G5kmb1/1Zi
	5QJ25TCTF3LXALMnBe7LvurgWVjzss5P2IDeO5hZQQv1FMj/1eukL9aKlvazVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vgoa6rtDkkb0z+4ZnUL4z1FDa/4gqsWfMTkB0ZqCFsI=;
	b=LrSOIeM+Cu7tG0WXGV0J2crE/wSoGyHQCDw3eqn3ESGBLwIU/HmaoPboIEkjs+HQV9GG1s
	I6bLGpNfy0lAOGBA==
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
Subject: [patch V7 16/21] posix-timers: Handle ignored list on delete and exit
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:51 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V7: Use the proper struct member for the ignored list failure case - Frederic

V6: Warn when the ignored list is not empty after deleting all timers in
    exit_itimers()
---
 include/linux/posix-timers.h |    4 +++-
 kernel/time/posix-timers.c   |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
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
@@ -1027,6 +1027,18 @@ int common_timer_del(struct k_itimer *ti
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
@@ -1059,6 +1071,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1110,6 +1123,8 @@ static void itimer_delete(struct k_itime
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1142,6 +1157,19 @@ void exit_itimers(struct task_struct *ts
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers))
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+
+	/*
+	 * There should be no timers on the ignored list. itimer_delete() has
+	 * mopped them up.
+	 */
+	if (!WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers)))
+		return;
+
+	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
+	while (!hlist_empty(&timers)) {
+		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer,
+							ignored_list));
+	}
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,


