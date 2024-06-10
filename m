Return-Path: <linux-kernel+bounces-208610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0AF90272C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E45A1C22BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48698158DBF;
	Mon, 10 Jun 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNVsEhEn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24Evbwjf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399D158D7A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037786; cv=none; b=nRiU9JYWaXz0KC6gWLkfHROQz9jeEhZgZ/az15HLvEtbS+0tdAAr5kF4RavqkdCHw7lkcKwoFZ3IbNnsXV+9IuDKixoRgxJsvZS9OU1Ikcj7zK9MF4FT5dv4hz/Q2C9y8mldPx8Vqiyq4QtCORCaDwzgX10XMiMs+GBtphgCnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037786; c=relaxed/simple;
	bh=Kaitif/719xp2xVCsTipKGEhafvxHZw3eYIDLxrxhD4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VCZYSKYAbgTGxjLtmUggWIx77BEMImm8K3eXaSD+/P0t4VjiNAyrAf535ubZSdJRaoAhVppIKNd/QaG5x3dxEXogXtqVcVVPxbxp8ybADaxfZMeAOJioD+kdvJoWfZw2XmRmyxSze2Ll2MmsiBZOxKTlrYKu57Uxlow1U6/3sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNVsEhEn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24Evbwjf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164028.409956464@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TLf+HH0NPG+O40MqHfVvMTLhniRUMJJ6i8JJ174+iCU=;
	b=pNVsEhEnU4lfBY5Khit3r/Y2QlIQrsyr+nOKf06yQLdKgEo4UB+hP1qP8LC8X88m45YQsi
	eOTxXzhhBHN+GtexAilKR8enYLM3OFfGEKaJz2Jdw8zpxRUyIXRlYLD6Mg3BArrub0Qnpi
	VxG3DZ3BHGUEOv4puhs98UbpcPaQz2z5wMsnS/rOLRkL+NX5tpTAo+m16ZQtP6+m4aP8f3
	sG1dy+pH9Vk9yTLSM2+9gCUNNVl8aCdOReduGpNY+2u0FmQgY816jyq1y2cZSsBdobxiT2
	68to7rHHuvIKPmAhNUV5PxT8aR3UUscmtId2C7hntYDGF/zV6U4mXJ1Ssa/hkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TLf+HH0NPG+O40MqHfVvMTLhniRUMJJ6i8JJ174+iCU=;
	b=24EvbwjfZ8MnZ/CpMmuPxTzb7LwSx6SCGkOJMHV4uh8/1+YccBbIM1S8ESb/I9wkDVIpaP
	oJ/pmca645vgKwAw==
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
Subject: [patch V3 47/51] signal: Handle ignored signals in
 do_sigaction(action != SIG_IGN)
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:43:03 +0200 (CEST)

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
---
 kernel/signal.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2035,7 +2035,55 @@ int posixtimer_send_sigqueue(struct k_it
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
@@ -4205,6 +4253,8 @@ int do_sigaction(int sig, struct k_sigac
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
+		bool was_ignored = k->sa.sa_handler == SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k = *act;
@@ -4225,6 +4275,8 @@ int do_sigaction(int sig, struct k_sigac
 			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(&mask, &t->pending, NULL);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
 


