Return-Path: <linux-kernel+bounces-341497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B729880D5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8474280EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA71B3747;
	Fri, 27 Sep 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RLwVJdHz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+ilk7HH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027E1B2EEC
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426949; cv=none; b=VBnfCG27JGqYzw8s3nVDkVMX1zdpjy370TnBmrJ+zSp8d8Yt2RFq1plXoQZm8AL9uKEmYpc6dAiqtMVAeW0qB0h10h+WuVLYw7j3cL05UV14SukGmB2TMakNC+NQYxUevz4I3Q232J4Ghmyj862t/fD0RQdFcw8k1zAQK1VjMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426949; c=relaxed/simple;
	bh=nRkN+AiEmsFUgQVS26MCYMF4hF2KHRsgRGt7CXwjl7s=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lMjNR6zAogw9ke4/IILUcwR8jozoSWDVsELr6Gt6hdRaeMuvfEOttkZG7sECLXHHzwRSks9YNHdugpQycJ1zXdeC1rY4cT0FsMsplZdnYE0gMrk2VCjm0SfEZK4l1tDBbh6ilKJqvfvmtdUgYZkKYizrJssup3Otisd8absnh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RLwVJdHz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y+ilk7HH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.250962485@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gKoKdWNMyp0JkiI/4428ZyD0vyyNKG9BGZhxNuonT28=;
	b=RLwVJdHz9Q8YjjY8Dhqm4jdUCxS1xyNwAEhFQBtaS2a/57z7f0Mj3WaE0AXCMw2YEloEXu
	pCMeSxqFSEIhEZMWvmWP7pMNwKBi1iuxkp8bn5NpbnnWFfQF76ffbSm57sY5xCBHIeGM/O
	VHmm/pSgv7e3lHeTVPK1D5GBkHBdC2RF/GetEvuTxBarvaEgNMWqt/ONhtjhavY1K+jfMx
	qyWhiMWx0eAfNIZZ7Pz5qn3Oyyc2Xl9bJx/NNPVrNkz0ZfRzBRaiAjG2e5ENxRumIKhFUD
	DUe0y5QJDXJOihT9iBC7x8Zl6nyrIHuzx4tf8cwKi5OnCZQ0ntG4ti5HmC0tzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gKoKdWNMyp0JkiI/4428ZyD0vyyNKG9BGZhxNuonT28=;
	b=Y+ilk7HHohzN1UJy5oMHrUl0IT3qldgTPvtWEnF3dXSIhNvDNFw1ncT5avEOWZzmb1enWa
	glfmbF9YPQYhC2Dw==
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
Subject: [patch v4 22/27] posix-timers: Handle ignored list on delete and exit
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:06 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h |  4 +++-
 kernel/time/posix-timers.c   | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index ddd7ccd9ba77..efab1ef7a7fe 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -151,7 +151,8 @@ static inline void posix_cputimers_init_work(void) { }
 
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
@@ -174,6 +175,7 @@ static inline void posix_cputimers_init_work(void) { }
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b62e3ccb45ff..5a5967a01f53 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1036,6 +1036,18 @@ int common_timer_del(struct k_itimer *timer)
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
@@ -1068,6 +1080,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1119,6 +1132,8 @@ static void itimer_delete(struct k_itimer *timer)
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1151,6 +1166,11 @@ void exit_itimers(struct task_struct *tsk)
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


