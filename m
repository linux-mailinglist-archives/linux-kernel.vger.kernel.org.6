Return-Path: <linux-kernel+bounces-396099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05829BC7D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95951C20CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB520371A;
	Tue,  5 Nov 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+TI2xgG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovvZoePD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34608202F71
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794496; cv=none; b=dy34T44Ap9XJhgw5cIFe8vck2mc3OXK+s9abwN6ayI35xjLDrsJQTUhaPKJsTZ44/zZi5f8ckcl9AUmBeBSwJZvwO5DPKvyQ0UPdBSNc+UevIQR+WkkK0tYfWjOFnT7tusoH0oi4TGDoHGwRGmVHlqorD0RteJvuhhlJMBj4+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794496; c=relaxed/simple;
	bh=vXgm/ekqWJovTiyDCzowyMkfvitfSUTMQOfI9S4YcQE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=j6Pje1n6gUg9E5aO2S87q/qBHBA+BOWyhIo6b3qi0oqkGi57FsVXbRCm4finH3SwW5ig8BGJ9BF6GLS3cdpSOTXTfmMgEBXyMs5pQWmgN0F9jAGW04Dm2JCEJo2zBvzQP0+9E+Kx7SG8yV75pm/4B9lssqBHph+SHrQNaUEsqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+TI2xgG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovvZoePD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064214.054091076@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Fuun7vC9AlK7MPpBjV7RcU0R+2c+ftDxNYh4oCXgd6Q=;
	b=H+TI2xgGJVczIiQKZ1nOkLFvaSZdZp2RU6jBVExL/QPwqUIVvSa+cx1duPI4LcJSSp9JRH
	GmltLiNhGDZZM2o0iBiUeTg6MVClD6WDX6cMPLj29hwy9txgwiKj666p6uYuGQMFCVzoNT
	XA/1j2bbVzxPUobfz7X7p546mBbCJVjt1HpavdxKVQRpu/59LaXzRa5DCOaTdPY5RNgIam
	ABMqi8VcR4M1pUNce8bAwNP0hExFSkyhsvSW1+o73l9NeQpZfXXfo39wbakiOs68iXPYwM
	H9vIuXIqdP49g4Ugrqn0dIpgYAaslQl6Agt1+FDINZDu2eqruxDuwCZzxPHpGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Fuun7vC9AlK7MPpBjV7RcU0R+2c+ftDxNYh4oCXgd6Q=;
	b=ovvZoePDLckWhpOKcHvmROaYU9uUvdLqsdWVBtSfyf4DMX5vPczlXLI0efxbPJK2jJ9RSC
	A3Vsj4OI2/NatsAg==
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
Subject: [patch V7 17/21] signal: Handle ignored signals in
 do_sigaction(action != SIG_IGN)
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:52 +0100 (CET)

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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>                                                                                                                                                                                                                                                                    
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/signal.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)
---

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2002,7 +2002,54 @@ int posixtimer_send_sigqueue(struct k_it
 	unlock_task_sighand(t, &flags);
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
+		guard(rcu)();
+		target = posixtimer_get_target(tmr);
+		if (target)
+			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
+		else
+			posixtimer_putref(tmr);
+	}
+}
+#else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
+#endif /* !CONFIG_POSIX_TIMERS */
 
 void do_notify_pidfd(struct task_struct *task)
 {
@@ -4180,6 +4227,8 @@ int do_sigaction(int sig, struct k_sigac
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
+		bool was_ignored = k->sa.sa_handler == SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k = *act;
@@ -4200,6 +4249,8 @@ int do_sigaction(int sig, struct k_sigac
 			flush_sigqueue_mask(p, &mask, &p->signal->shared_pending);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(p, &mask, &t->pending);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
 


