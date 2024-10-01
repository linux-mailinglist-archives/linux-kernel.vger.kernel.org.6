Return-Path: <linux-kernel+bounces-345547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4A98B75E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8ECDB26D17
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168DA1BE24A;
	Tue,  1 Oct 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NMycND5F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4XpTcG6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272E19D07B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772149; cv=none; b=kxVQp5O53X1eMZ2KMx55TqKPTEMsUEK0PeEvAEGiNUXuwVvbzSZJgTVQvqpMrCZdIsAq/i/EiRHacRN/T5wAndUX3rpCU1QHYUqdfoRk2eWKM6J7xzAXBAq6wrqXi7KbhiCC/YAkFcoPFRd/WOnDWcvAZKf2YEV7S6apU3ntyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772149; c=relaxed/simple;
	bh=KuUukowE5tPhVZKOtVjcWUVBluppHCcX64h5AI5MFX8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rnyJkc6mX0ghfXjpvcIHVueadsraxqxL2t0d1QIOmwULmrsl3LGIFQm+CN1Qg7PUKzwrdb5/6Quw9TztAycOEWiPrdWyUou3Uk9zkGKVmUu/rHcrcu5ZDKch4msIeeOdNR2QywcKDGaztFjAwyumoMF2xjGf2U799m2Nhcer4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NMycND5F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4XpTcG6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.396279339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fiicOvJThNrOacm9GJVlSNcZNMkcKU4EAK0p4+HOCH0=;
	b=NMycND5F+wojaVM9glSL/sTKWdxuXIt4s0HQQi2YxKVj3bjJFFN2SJ5tPsXoYA24cD6Pw9
	fajFLELvOOFLpxKHoy4Tu3D+c/KyTh9rgItagmOmi+3WoiUCCWvdiBlHPldWfGgI4w6vYW
	0oNMvWToUYyTXV1dbJQHqQyd89C2m93VH94VtcqU76nbP98dPKvOeDNFjiQBdjuJdzgrjk
	5e2PxbwEmggVdOrH+MHrHArAe3auxvSo259+PSAjqR0an8qigIswk7bfgDpqCY7heIBzZF
	VjOURfk1YBaw46FdHDM/mxfnIblbs246Gmk5WGxbYYyC9QdLEb5/j00TmP4nhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fiicOvJThNrOacm9GJVlSNcZNMkcKU4EAK0p4+HOCH0=;
	b=n4XpTcG6klTjeJLRfRM1M9+khCCnmmQCDOwyTR+PdtzXd8h6mNwl3DzewligBCWJK5mQOX
	CzfH+AkKMUhO3wDw==
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
Subject: [patch V5 19/26] posix-timers: Move sequence logic into struct
 k_itimer
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:26 +0200 (CEST)

The posix timer signal handling uses siginfo::si_sys_private for handling
the sequence counter check. That indirection is not longer required and the
sequence count value at signal queueing time can be stored in struct
k_itimer itself.

This removes the requirement of treating siginfo::si_sys_private special as
it's now always zero as the kernel does not touch it anymore.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/posix-timers.h |    2 ++
 kernel/signal.c              |    8 +++-----
 kernel/time/posix-timers.c   |    5 +----
 3 files changed, 6 insertions(+), 9 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -162,6 +162,7 @@ static inline void posix_cputimers_init_
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
  * @it_signal_seq:	Sequence count to control signal delivery
+ * @it_sigqueue_seq:	The sequence count at the point where the signal was queued
  * @it_sigev_notify:	The notify word of sigevent struct for signal delivery
  * @it_interval:	The interval for periodic timers
  * @it_signal:		Pointer to the creators signal struct
@@ -184,6 +185,7 @@ struct k_itimer {
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
+	unsigned int		it_sigqueue_seq;
 	int			it_sigev_notify;
 	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1968,12 +1968,10 @@ int posixtimer_send_sigqueue(struct k_it
 		return -1;
 
 	/*
-	 * Update @q::info::si_sys_private for posix timer signals with
-	 * sighand locked to prevent a race against dequeue_signal() which
-	 * decides based on si_sys_private whether to invoke
-	 * posixtimer_rearm() or not.
+	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
+	 * locked to prevent a race against dequeue_signal().
 	 */
-	q->info.si_sys_private = tmr->it_signal_seq;
+	tmr->it_sigqueue_seq = tmr->it_signal_seq;
 
 	/*
 	 * Set the overrun count to zero unconditionally. The posix timer
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -272,7 +272,7 @@ bool posixtimer_deliver_signal(struct ke
 	 * since the signal was queued. In either case, don't rearm and
 	 * drop the signal.
 	 */
-	if (!timr->it_signal || timr->it_signal_seq != info->si_sys_private)
+	if (!timr->it_signal || timr->it_signal_seq != timr->it_sigqueue_seq)
 		goto out_unlock;
 
 	if (timr->it_interval && timr->it_status == POSIX_TIMER_REQUEUE_PENDING) {
@@ -293,9 +293,6 @@ bool posixtimer_deliver_signal(struct ke
 	posixtimer_putref(timr);
 
 	spin_lock(&current->sighand->siglock);
-
-	/* Don't expose the si_sys_private value to userspace */
-	info->si_sys_private = 0;
 	return ret;
 }
 


