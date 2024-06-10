Return-Path: <linux-kernel+bounces-208609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929690273D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84857B2AAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77334158DA3;
	Mon, 10 Jun 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ckMsYXKC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTNAr643"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C414C5B8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037785; cv=none; b=HnHratq8/UZvhfzWD7Zdy47bggjViKDs49dG7Ve4Zn6jvu1J/5+EbDvSB65XPcTE6Suq0kdZsjPATpfyAwWw7/Z6USVNo+/NMZ20XvZm6IXCZ2P5CGck4Z8tR9CsOFnhmQzuckCbJgxPRoSgNmCRCoorKgVOiXT82LszD4SbUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037785; c=relaxed/simple;
	bh=cp19dVUb7xvWUsokdlmPF5WkDY+X0uWwwuOAQ7Ty6Vc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bSPV5AJc+8O/EAwUkVaKbbdZ3j0unKY2JajFn8S7kXYhXXaut4VxcAHmu/bYfeGMqoEPDiZqrOmZqTqb9liNzkvP3lYaVMmSe0t88FG70vrgV+1DvLquziFyvSzaIHyF9kn7i09EVvf4+FimcQLj3eld18p8zajoKtRAU9km0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ckMsYXKC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTNAr643; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164028.288945590@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pv6YrQN2ETIiH5UgbcE48m3AAv3y/nIIur52dGrER6A=;
	b=ckMsYXKCAAMEzrCAiqvrISbsyr0HCIwLj4dk+onV593ag1zXOF6iX+iG7qZOdoiYEtlbtB
	+zCNVR0y4NaF8+KoYiyyBM/Mn1SQ+jlc2G1UZy7Ni7oSaa+OBco4xKouhSCqejcfUDkI13
	2iLsD4Bw/IW4TyP73y5UCEF5S6H2fSAsLavva+yxrTVHbAfmS0zSb+6YaZCwBu4C6YqB3o
	N54wMlLJ9e+KUF1Tg4ywvosDLYw7TkAbhBioxBbkqAD8rSZTWRF2Tk1lPza3+MuLUeRg5h
	sL5fGqtPkJoTNeYKrxmDrtiUUheJ/G4g/Ui0XFJHFoi0xvJgvjGmMJmGZxKLBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pv6YrQN2ETIiH5UgbcE48m3AAv3y/nIIur52dGrER6A=;
	b=mTNAr643KAJBm62oTRMqq22cOienvIFgka6csOHmutJ8NfZqCtLbaB9fM2hu9WrFkBjW78
	M96Fh2edgxwHeXDA==
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
Subject: [patch V3 45/51] signal: Provide ignored_posix_timers list
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:43:00 +0200 (CEST)

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a list to task::signal.

This list will be used to queue posix timers so their signal can be
requeued when SIG_IGN is lifted later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/signal.h |    1 +
 init/init_task.c             |    5 +++--
 kernel/fork.c                |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -138,6 +138,7 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
 	struct hlist_head	posix_timers;
+	struct hlist_head	ignored_posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -29,8 +29,9 @@ static struct signal_struct init_signals
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers	= HLIST_HEAD_INIT,
-	.cputimer	= {
+	.posix_timers		= HLIST_HEAD_INIT,
+	.ignored_posix_timers	= HLIST_HEAD_INIT,
+	.cputimer		= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
 #endif
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1877,6 +1877,7 @@ static int copy_signal(unsigned long clo
 
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif


