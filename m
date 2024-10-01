Return-Path: <linux-kernel+bounces-345550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343498B763
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E2E282146
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E919D09A;
	Tue,  1 Oct 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XVYx/vGa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkUKbGDP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7D1BE878
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772153; cv=none; b=ucPITCORIcb9l5h/eKgOd763fCbe3fHS5wvWdORONNvSzDqhHnF+NwiNrkw8hdTYwjaYbQvz+HWgpuDIUeQrZP+87GIg5n+BXKsb+lhV9rrv8vkZy1wsfmVbG6cLBhplX+oQ6OJQmZP/fkiJ9kggLtdXCk5L65R1RjVJwH/G7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772153; c=relaxed/simple;
	bh=M677pHX34QOCyjxhMRo1zE6Z6Vi2BL9+felSGOBSgjE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LNJiK4P5O4dFhjMkSDRiEBpcDItOEj1oxgtfWgj9SE/So+lmwcKx/SpqIHV1vxT3hlCCezsh/sKzorRNhl0XoDexMnZ4LDfIcB8vqj9W0shxDBe/5gaJBXHrPgIoYIfma83PuD3B2BtUuPJjPUQx9YJkZ3RcSD3RXISbLtiHvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XVYx/vGa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PkUKbGDP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.572425978@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XK5UMo6tOwtpxK/g5DT8lDLUeDF/9ZRZjd7s5geMFrQ=;
	b=XVYx/vGaxUxdCWKw8yMOa+Thf8pykwPtD9d5ErqaKs0k88XarLZHEB5An5y2oDqu8P5NLW
	2HP5zM2m0Gg0mK/hquNuPICPpckDcgli0LaUz3efyK2E5xb5tjDxsqBZKCaSH+jXPbEtXM
	1udUftuv4cTav0vzZ49ftqi137JzfE+vuVV6fcybgj8qBsp/8rLwNmsfSA3+VTQMGaKNhQ
	YS5Hb5BUsrsBDx2WnVU3YuIu05NsfwgDoZSjlOtWT3G7xLffAM+C92TopkxMxtvGql2Byk
	u6cNbUjBa73Hw26Xk9qtM7UriLfrdMLPAdIxXn/kHbigJhYfLBm03UMr0aTkpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XK5UMo6tOwtpxK/g5DT8lDLUeDF/9ZRZjd7s5geMFrQ=;
	b=PkUKbGDPLk9sQpWz7syY9xPfD4eHb8OzKktKONSPjj+KCBvqjhejKlbyEU2/crVhFSIs6w
	XFU+C+21V+sxmsBw==
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
Subject: [patch V5 22/26] signal: Handle ignored signals in
 do_sigaction(action != SIG_IGN)
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:30 +0200 (CEST)

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
 kernel/signal.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)
---
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2022,7 +2022,54 @@ int posixtimer_send_sigqueue(struct k_it
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
@@ -4200,6 +4247,8 @@ int do_sigaction(int sig, struct k_sigac
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
+		bool was_ignored = k->sa.sa_handler == SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k = *act;
@@ -4220,6 +4269,8 @@ int do_sigaction(int sig, struct k_sigac
 			flush_sigqueue_mask(p, &mask, &p->signal->shared_pending);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(p, &mask, &t->pending);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
 


