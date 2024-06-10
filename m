Return-Path: <linux-kernel+bounces-208608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70E90275E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79837B2A878
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC13158D79;
	Mon, 10 Jun 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mn5OaB9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="svGWzVt6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57814BFA8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037784; cv=none; b=cosgcgF1+mkohjdlW4X22rivZh88JUcCB894+QZcgFYyOAHh2fgCdqBYBU7Rzk/xYaHCD+ayABxiklYn4GVuCXTvi9YKVarR2mETsX8mc10P7xCkSHmqshQYXUqrbeKVw25tbJiENVspnr4gJ5ySq0Pf8EKhfUvPnNq1GqgnL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037784; c=relaxed/simple;
	bh=H8C4ae3qB9pJTAhYrEUW6UIkzelbDNrIyM/SxoxcYVc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SUUQrcJSFG20K7+dcUwS9dG6+l+6X4QCVgRL6C6L4hdKIcwgrbh4gbhQNh6xqxsbcJPIdDvo1P8dILq/IHs2VJ5AaYSqzv0YSs/2nwKo+6XVeTwtrnYWd4wtiYIuvVXiV5mwHM1oD3+qyPqEKv2iREs1Hr2YKuXpUQtOrNvzVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mn5OaB9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=svGWzVt6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164028.229525528@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gS0GunzjJF0mIhSZ9sJXDkEdhMOznUExWpmLyjVDd8s=;
	b=mn5OaB9jNhYxLm1Au5SbSFz5ZyINHHxzpUiGgwO6OdfcH8IBQdAppwEsFgcrBMEFKyT/mA
	RQ2v6owkyy7aLKZ67oiGDZFaND2/itsh3f0LhYNSY8uPRlYwKev9EzjLya3QujgG4htD2H
	35yWiEDazTU1GLHYgfjhIbYRFEDtxlV5LPIC43j41gYhahKFtF28lK8L2hLU/TyrcRBFEo
	iSFUfiyM+syMKuqRztx1chIZcfJ5TT7axJPz4lsq1qeVKkmLJctuLxmi7JMgFxmnUihu5j
	O0027ooHX7eLjssrt0zIz6zKhQBLVBg48aNu2wcxSZUHl3fd7WsUtOyiEaGyfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gS0GunzjJF0mIhSZ9sJXDkEdhMOznUExWpmLyjVDd8s=;
	b=svGWzVt61HHvsJX/ltwLCdXT7FAwt0UwNpn1mdG/sMyZr8bl9UxXIOCSDZ/K/p8dRvtGUT
	HMEsNKZwJr9afNBA==
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
Subject: [patch V3 44/51] signal: Add task argument to flush_sigqueue_mask()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:59 +0200 (CEST)

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a task argument to flush_sigqueue_mask() and fixup all call sites.

This argument will be used in a later step to enqueue posix timers on an
ignored list, so their signal can be requeued when SIG_IGN is lifted later
on.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -724,11 +724,10 @@ void signal_wake_up_state(struct task_st
 
 /*
  * Remove signals in mask from the pending set and queue.
- * Returns 1 if any signals were found.
  *
  * All callers must be holding the siglock.
  */
-static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s, struct task_struct *ptmr_tsk)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
@@ -866,18 +865,18 @@ static bool prepare_signal(int sig, stru
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
 		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t)
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 	} else if (sig == SIGCONT) {
 		unsigned int why;
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
 		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED))) {
 				t->jobctl &= ~JOBCTL_STOPPED;
@@ -4155,8 +4154,8 @@ void kernel_sigaction(int sig, __sighand
 		sigemptyset(&mask);
 		sigaddset(&mask, sig);
 
-		flush_sigqueue_mask(&mask, &current->signal->shared_pending);
-		flush_sigqueue_mask(&mask, &current->pending);
+		flush_sigqueue_mask(&mask, &current->signal->shared_pending, NULL);
+		flush_sigqueue_mask(&mask, &current->pending, NULL);
 		recalc_sigpending();
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -4223,9 +4222,9 @@ int do_sigaction(int sig, struct k_sigac
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending);
+				flush_sigqueue_mask(&mask, &t->pending, NULL);
 		}
 	}
 


