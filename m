Return-Path: <linux-kernel+bounces-341498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214C9880D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5701C223F1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F41B375E;
	Fri, 27 Sep 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMmndMI7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2SM/Bt7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA81B3725
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426950; cv=none; b=qTuQjF0kJhBfWgUZkAWxgF5vHro3JyD6SKP38pR1a/OZPnZKCzZWA58U+ZUj5SglORKJmqKYwNPxIhD0wDXRvjE1YNLs4XLqMblaTtyJfE2qemyz1qc701eQHWI9hBNghSZZIiwcPhTH9tYESKyih/OCAhH2X5O5grqzxTtlDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426950; c=relaxed/simple;
	bh=4ikW86M3H7XfpKJPNbZtxvrCBNrAsM8MbXKgaFbcHoQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Wimbj7hK2VcHAeuvGpRHI9RWtA745p6Vj3Yx2Oc4xkKcaZeH98bU9XfhjtQ4lrYy7G6tMJN3bMFPgoNoalP2XF+OQHZVaPOv3IpBftozjGsE0edFdR32ncGUiTSiwS+xTIr0LehqnU6WdwdBzDCJaVZfbKgzPc3rlNFZDZoJ6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMmndMI7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2SM/Bt7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.309948950@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bF1tbiczXha3tzRWe8mp8ywCA3VZYXkdj82il0Ewpe0=;
	b=KMmndMI7fD15drjJk/7VMhjgPKoCx1uVkHENbPXbsdBuK40Hn4ely0ZvBw0fTNesfaV5oX
	wOYyOWD3UDhgciy4+2mMIVkEMTzwUnPXgESY9GU1ZmnHaB6Rq5Kwrz2X5rotFnsNFyoUaG
	bH1RaIId3J939VQHle4j9edpo+olnENsFNNYbAk/+trl/BhrafgtHcT6D/z9zsLSLV+jtN
	RpR5B8PwFXE9NEw/bVTY+CxXsmYFAo954BJrsEWWKezmqNb7MbpVwBBwXnAV3F8zz0HqVC
	Ck6SM+CBrKDYNOM8CO78wMlJgu6lz0X/HcOF0KzVztihyvVPGzuUlLNUxl7o4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bF1tbiczXha3tzRWe8mp8ywCA3VZYXkdj82il0Ewpe0=;
	b=H2SM/Bt7Lgbdo6Ab1oTKXMgP5WXwOWSTDJRUTaOB6kd2BBDKUe2tQPqSPUyfa++MRtTZSV
	ztBvMN6iI2AguxDg==
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
Subject: [patch v4 23/27] signal: Handle ignored signals in
 do_sigaction(action != SIG_IGN)
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:07 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

When a real handler (including SIG_DFL) is installed for a signal, which
had previously SIG_IGN set, then the list of ignored posix timers has to be
checked for timers which are affected by this change.

Add a list walk function which checks for the matching signal number and if
found requeues the timers signal, so the timer is rearmed on signal
delivery.

Rearming the timer right away is not possible because that requires to drop
sighand lock.

No functional change as the counter part which queues the timers on the
ignored list is still missing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 kernel/signal.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)
---
diff --git a/kernel/signal.c b/kernel/signal.c
index 93c2d681309c..855f19f74287 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2031,7 +2031,55 @@ int posixtimer_send_sigqueue(struct k_itimer *tmr)
 	rcu_read_unlock();
 	return ret;
 }
-#endif /* CONFIG_POSIX_TIMERS */
+
+static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
+{
+	struct hlist_head *head = &tsk->signal->ignored_posix_timers;
+	struct hlist_node *tmp;
+	struct k_itimer *tmr;
+
+	if (likely(hlist_empty(head)))
+		return;
+
+	/*
+	 * Rearming a timer with sighand lock held is not possible due to
+	 * lock ordering vs. tmr::it_lock. Just stick the sigqueue back and
+	 * let the signal delivery path deal with it whether it needs to be
+	 * rearmed or not. This cannot be decided here w/o dropping sighand
+	 * lock and creating a loop retry horror show.
+	 */
+	hlist_for_each_entry_safe(tmr, tmp , head, ignored_list) {
+		struct task_struct *target;
+
+		/*
+		 * tmr::sigq.info.si_signo is immutable, so accessing it
+		 * without holding tmr::it_lock is safe.
+		 */
+		if (tmr->sigq.info.si_signo != sig)
+			continue;
+
+		hlist_del_init(&tmr->ignored_list);
+
+		/* This should never happen and leaks a reference count */
+		if (WARN_ON_ONCE(!list_empty(&tmr->sigq.list)))
+			continue;
+
+		/*
+		 * Get the target for the signal. If target is a thread and
+		 * has exited by now, drop the reference count.
+		 */
+		rcu_read_lock();
+		target = posixtimer_get_target(tmr);
+		if (target)
+			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
+		else
+			posixtimer_putref(tmr);
+		rcu_read_unlock();
+	}
+}
+#else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
+#endif /* !CONFIG_POSIX_TIMERS */
 
 void do_notify_pidfd(struct task_struct *task)
 {
@@ -4219,6 +4267,8 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
+		bool was_ignored = k->sa.sa_handler == SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k = *act;
@@ -4239,6 +4289,8 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(&mask, &t->pending, NULL);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
 


