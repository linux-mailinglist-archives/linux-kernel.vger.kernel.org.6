Return-Path: <linux-kernel+bounces-208591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62543902701
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1683E283F57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717E156655;
	Mon, 10 Jun 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ig7CHDgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TmBS80Rg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5F156221
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037763; cv=none; b=Qy0JF/nzt0TXjVSOAcYJWDGWdFff8DeObHuLCRSYISshhj5ZKki4HYjpPIcBqLZmBQwI0km73pFTw2eYlVW7JME8QvF/UF7vARdASRgw+JiEfA5/nR9emUT4s18VF1kzCMu3+5WM05L2s1dAUEanTlQ+EnfOExpmhCpyJ4xrag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037763; c=relaxed/simple;
	bh=ipfz+AaYDg2jRk2QzxjlJP24YxnDWUAysNYhb2QjuYU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ypi5vpdb+qfS/86umLFY41y+HsjViDyid4SX+CNXp0Dvi9w9UvIuGKZYUmDmb3aWL8TXPgBPyjIPP69y8+7w0HPsrukPFhHsi5jw1T4OgnOXjZh+xY6r12G4FTuchw+by2R28y/IvSVRV0v4FTuwU5CJ+tpg+q2jzh1/g8LVg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ig7CHDgS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TmBS80Rg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.175737443@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t7pjsSQKBc6tEHZWynKUhlTqjE2Ct45jVqlBq7pgRI0=;
	b=Ig7CHDgSH0EjF8KG/YMtAF8vgWZdmuIaNmilJF5M7LmwTrtoCjdHuHjR3GmdE4yuoqzoFL
	I67G1p3jotFFqMPqfTJoKGle4kr4k0Q30rQ+QKE6zD5RPuDHyf5W0K+gMb24UYeGZT6ffh
	rDJ5OzeXT8wNszb34pa55E16pvw43hZHm9Q+dCRtuB/ixSXeXwBhFMtXernAy/UtWj4qqD
	dkbsB5+PNwWzZgMXDiyFt09nDMH2sVgRs4t3q8ncCNlcmbDASKZXP4lwCFEhjxJ2dVOrSW
	prv/iKuuqmt4pYC1lEGU0ecadmDGwcjJneOfxpl9pkzuv27T4HADMDengaYf2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t7pjsSQKBc6tEHZWynKUhlTqjE2Ct45jVqlBq7pgRI0=;
	b=TmBS80Rg0JR64rsW9MEt1Jwmyow/BfyNqbloFFX3QYk2UkquD9CnBQwd+z2ynml01cljSo
	AK06rupT78vLkWAA==
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
Subject: [patch V3 27/51] signal: Get rid of resched_timer logic
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:38 +0200 (CEST)

There is no reason for handing the *resched pointer argument through
several functions just to check whether the signal is related to a self
rearming posix timer.

SI_TIMER is only used by the posix timer code and cannot be queued from
user space. The only extra check in collect_signal() to verify whether the
queued signal is preallocated is not really useful. Some other places
already check purely the SI_TIMER type.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -526,8 +526,7 @@ bool unhandled_signal(struct task_struct
 	return !tsk->ptrace;
 }
 
-static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
-			   bool *resched_timer)
+static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info)
 {
 	struct sigqueue *q, *first = NULL;
 
@@ -549,12 +548,6 @@ static void collect_signal(int sig, stru
 still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
-
-		*resched_timer =
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code == SI_TIMER) &&
-			(info->si_sys_private);
-
 		__sigqueue_free(first);
 	} else {
 		/*
@@ -571,13 +564,12 @@ static void collect_signal(int sig, stru
 	}
 }
 
-static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			kernel_siginfo_t *info, bool *resched_timer)
+static int __dequeue_signal(struct sigpending *pending, sigset_t *mask, kernel_siginfo_t *info)
 {
 	int sig = next_signal(pending, mask);
 
 	if (sig)
-		collect_signal(sig, pending, info, resched_timer);
+		collect_signal(sig, pending, info);
 	return sig;
 }
 
@@ -589,17 +581,15 @@ static int __dequeue_signal(struct sigpe
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
 	struct task_struct *tsk = current;
-	bool resched_timer = false;
 	int signr;
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
 	*type = PIDTYPE_PID;
-	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
 		*type = PIDTYPE_TGID;
-		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
+		signr = __dequeue_signal(&tsk->signal->shared_pending, mask, info);
 
 		if (unlikely(signr == SIGALRM))
 			posixtimer_rearm_itimer(tsk);
@@ -626,7 +616,7 @@ int dequeue_signal(sigset_t *mask, kerne
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(resched_timer))
+		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
 			posixtimer_rearm(info);
 	}
 
@@ -1011,6 +1001,9 @@ static int __send_signal_locked(int sig,
 
 	lockdep_assert_held(&t->sighand->siglock);
 
+	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
+		return 0;
+
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, force))
 		goto ret;


