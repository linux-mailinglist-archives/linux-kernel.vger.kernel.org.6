Return-Path: <linux-kernel+bounces-390831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D183D9B7EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EE81F22AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41961C9B98;
	Thu, 31 Oct 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKnH5ZhL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V2D3JIx0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509F1C3F2B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389604; cv=none; b=S4jA0NGs9+7w/Gn84l0Ac35XqkElJ+VM3jREu1c0WNdTQ0WRJwv66YFsZn28YpEDzm08rsvifb4DJM3a/KUpk3oCZx9bnsJWjfYL4WIrHn0yghDLxyy/JISBJEvjyLsd17+LW3ego+Gst0nY2C70pbGhDmHeqdFwcSWoX6WGYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389604; c=relaxed/simple;
	bh=ubluM7VL7U4qZdDlhPmrWete8fA4Qc5SDItcL0E4eTI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=db00x4BqVppWELPW0grdz+OB99MwTx6aUIy4t3bbnuMpvlGRGGw2qAy7XNb+1yLlpf/U+xv4u1HKZjw5jolyIlWITe9TYUYHHItpkEJkaahubBrnKtavbqMre9gm6AAH/kz3zYZxcOGxcj1sSabnHTwE+sCjszJ7QIAtXo+DQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKnH5ZhL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V2D3JIx0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.370529748@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=o1ks1lD5Wsww0i59mhgG4iV/2G0j+TRp1u5nKEoD0lo=;
	b=eKnH5ZhLiOZa4FJ5oN0MWay//wmEtk9FlgQW3prk0oEdlDlYIYe/vrNwxSZTiC8PNl6br+
	x5A3DcGx9W8VMXVq1wgCOBf3GgAuOcbrZO/7Z6lDOkR+AfKrCxVFPgFfu6LQdtdQUzvp7e
	SLf3HEBSu0DbPoZSL6aUeQFWHTC4dASVhB/R5WtP6JXxMsqdeKWPZreP7XLVbLGs25Rpn4
	JznvQf5mSFynd5BJUQgNnE/AZI/r4Vtz6Q7OuhTFAFiy9ysC2iL3TWmaDIeZIZJPYKsIbC
	Kcy7x7LTwSu6JkFS9jw6vpLCZHJ8ca72Vvk96HIXQdKpBjUBJnPrxDqkGUWWRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=o1ks1lD5Wsww0i59mhgG4iV/2G0j+TRp1u5nKEoD0lo=;
	b=V2D3JIx0awQzBgQK/54BEAEzkpivtMgXdfSmR1efs+OULL6raELbdvAEjR192u+RoMl8bE
	EDSZ/l7rIxcwikCA==
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
Subject: [patch v6 13/20] posix-timers: Move sequence logic into struct
 k_itimer
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:38 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The posix timer signal handling uses siginfo::si_sys_private for handling
the sequence counter check. That indirection is not longer required and the
sequence count value at signal queueing time can be stored in struct
k_itimer itself.

This removes the requirement of treating siginfo::si_sys_private special as
it's now always zero as the kernel does not touch it anymore.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
V6: Update the comment in siginfo.h
V5: New patch
---
 include/linux/posix-timers.h       |    2 ++
 include/uapi/asm-generic/siginfo.h |    2 +-
 kernel/signal.c                    |    8 +++-----
 kernel/time/posix-timers.c         |    5 +----
 4 files changed, 7 insertions(+), 10 deletions(-)

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
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -46,7 +46,7 @@ union __sifields {
 		__kernel_timer_t _tid;	/* timer id */
 		int _overrun;		/* overrun count */
 		sigval_t _sigval;	/* same as below */
-		int _sys_private;       /* not to be passed to user */
+		int _sys_private;       /* Not used by the kernel. Historic leftover. Always 0. */
 	} _timer;
 
 	/* POSIX.1b signals */
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1976,12 +1976,10 @@ int posixtimer_send_sigqueue(struct k_it
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
 
 	ret = 1; /* the signal is ignored */
 	if (!prepare_signal(sig, t, false)) {
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -259,7 +259,7 @@ static bool __posixtimer_deliver_signal(
 	 * since the signal was queued. In either case, don't rearm and
 	 * drop the signal.
 	 */
-	if (timr->it_signal_seq != info->si_sys_private || WARN_ON_ONCE(!timr->it_signal))
+	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->it_signal))
 		return false;
 
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
@@ -297,9 +297,6 @@ bool posixtimer_deliver_signal(struct ke
 	posixtimer_putref(timr);
 
 	spin_lock(&current->sighand->siglock);
-
-	/* Don't expose the si_sys_private value to userspace */
-	info->si_sys_private = 0;
 	return ret;
 }
 


