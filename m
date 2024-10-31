Return-Path: <linux-kernel+bounces-390832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37959B7EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F351C2039E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA71C9B9A;
	Thu, 31 Oct 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PuTMj1Qo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtWsVJKg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AC1C4614
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389604; cv=none; b=C8xuJZuOE+17a/PqtzXNVgYRn00N/arjozffQqA/7QYPPKeATCGIzRwN//ndq2tGvUAFsIKqzV19WGqLHQyIneLAkGm4+eHrQxE092cr/OEnXayWA8ytQ87Q3SNxt+xwb4mOQH1cYmR+FqSTaSQF9g/BXVcXMwdTAfMs0IdJiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389604; c=relaxed/simple;
	bh=+lUP6TsMuqE3IqXpPLjwkfLL0Lw7iNcYZDOIOAM353A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JcCWKY8LbVZatd9DDkMBMZRYmOvz/qDblQn5gQGCX2MPyJB1P34cTzrXK6t3KprVbLgiZaf+6+a+Lkc1HjxyyQJy5VUKOle6OWl6kaRhtvoVPI9a4JCLSaT1VOcSrqmg11YMrb6lWV9G6oqG5ApjWGwwPOAMxVdUqkWCDibNNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PuTMj1Qo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtWsVJKg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.434594109@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P5v7WakqlAk2QTAVxuUtUxQppzdrdxi6ddqN05QxfAw=;
	b=PuTMj1QoRVig3O0FI9gIf2kODufkruex1LJ/IUI79/O7QUp8Ue4i7U25XVn/rfTsmLHrf8
	QN9kHTDPcxXbzCSN52JpS+DihbW5E8dareLMxDgwvYtmEN11JEtfg5nxkrOEjFxAHKlYee
	yRRCBuDRO2xd9W+qzFLkhY9kfXczIzt82ZodC7u05IMpNcMWecJN0TE6q0pyF8f45xn0s5
	c/T7Y9BGJ80o6db9i+EGQP+Frf8Gj3+v5FUeWDe4Dgs+33bAQoCJjEbIG0k49MSiQjrHrr
	tIY/n9BbutG6f+DHRjzx5VE4xu3UF90gOj3UCPzI0f0McinEsyzMM+uRC2hu8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P5v7WakqlAk2QTAVxuUtUxQppzdrdxi6ddqN05QxfAw=;
	b=wtWsVJKgNdA3eHPh95+gsbFzzFux/Xhm1U/x7F4MxmXNheXeIaFrmrGAtvs4YMlDCP7CPV
	Bra+sHsybZi6CKAg==
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
Subject: [patch v6 14/20] signal: Provide ignored_posix_timers list
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:40 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a list to task::signal.

This list will be used to queue posix timers so their signal can be
requeued when SIG_IGN is lifted later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/sched/signal.h |    1 +
 init/init_task.c             |    5 +++--
 kernel/fork.c                |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
---

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
@@ -30,8 +30,9 @@ static struct signal_struct init_signals
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
@@ -1864,6 +1864,7 @@ static int copy_signal(unsigned long clo
 
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif


