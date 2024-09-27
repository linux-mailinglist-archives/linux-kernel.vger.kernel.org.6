Return-Path: <linux-kernel+bounces-341496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5EF9880D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F30B23406
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46491B3721;
	Fri, 27 Sep 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wSfC+wqH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xATPNmwe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A711B2ECA
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426948; cv=none; b=HL2AkiyC70I+l+Oe2R9SaF7sDfCvIlhBxzMrf5PLMl7GymTZ/uK7jBFqp/Lnxt6Wvh6Hzvqb3rd/PNzuhP2mH7wRVZfMyReSgoDNX5GIGtMenSyR3FAyXc/0Vu03/4+NpxP/1CaUchz+N6H4LzIpE3rug6u7Kp3B9xMFEGTUPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426948; c=relaxed/simple;
	bh=LfXtJQwy94+oedKexOUya3zMtCS6elO6jHIITTZjjsc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Xx+hAYl7YDT6liJG1PVeQQF0waxkNvm7dSXHuj6auaohZVCNp2vkYwf+KLA8dWgbWXDUv3aVkccGTl/Uza+kMLezeHozqlUAvkzTys12r+Emj82oIChguC0ZwB/uGOoHibNAWhfJ5vP02eX38EPGW/irzIKEmpGeo1CqOM5ZSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wSfC+wqH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xATPNmwe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.190628301@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P2a6nBvuJqqDzQ/HVjG6sUxFvMGxHvxjY93bghrPEFQ=;
	b=wSfC+wqHsZDhvlH1QLU9RvzbWQS1ws3jFTirYo269qnGqjs5/uCAmzEAbwB2gsEbws0URI
	J5G5cTZ4OfyMnarhe1KHfLcx/cmbN1TY5sGlAdizUGnOPd2+umnSv7OOxWx+j3+f8Eidgr
	xh1StSwbrdlM8dcxu3pPZ31ZFB3vTLnYzGz3OKzLpMp+/N8H6+w2BmN0HnggffaKQ/3yuL
	QvnJya7GMnPBJ4CbuQp/aFBOTuoevIrpldKJYh6g43zXsiFT4BSOo9HkCuYk4Weyzs8V85
	Rc8kGYLXuO5d11yjDJrCMinaFQ1ooB+drDTLWGDS06OF7rlLpftTRfHfDOFluw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P2a6nBvuJqqDzQ/HVjG6sUxFvMGxHvxjY93bghrPEFQ=;
	b=xATPNmweWcdztD74TQEuBVstRdACrDPviuC5bbzfYyQD7bq8BzvG0S2FDITXgs2S3OLsKP
	1ePE+LNN7FxnIFAw==
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
Subject: [patch v4 21/27] signal: Provide ignored_posix_timers list
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:04 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a list to task::signal.

This list will be used to queue posix timers so their signal can be
requeued when SIG_IGN is lifted later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/sched/signal.h | 1 +
 init/init_task.c             | 5 +++--
 kernel/fork.c                | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
---
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 02972fd41931..d5d03d919df8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -138,6 +138,7 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
 	struct hlist_head	posix_timers;
+	struct hlist_head	ignored_posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
diff --git a/init/init_task.c b/init/init_task.c
index 5d0399bc8d2f..65af2ba93f25 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -29,8 +29,9 @@ static struct signal_struct init_signals = {
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
diff --git a/kernel/fork.c b/kernel/fork.c
index c1b343cba560..bef4b51bd474 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1862,6 +1862,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif


