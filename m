Return-Path: <linux-kernel+bounces-396084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C39BC7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7471C22338
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3381FF5FA;
	Tue,  5 Nov 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nzyDT5PI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gDY5tia"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBC1FF036
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794476; cv=none; b=g19lKSUbghAS2KQw0ZE7nF4cV4fbzR+pvWHcZUXVRyw6EPqHWE8Yh67vtW5FnhOqZ4tGCSrfSaP+xYBajGr1ZRHx2kdW1pyCp2EbEjrsoBG5oev0rm4UPIDQy8SxiaMXVznBIQEzc45GK2iGnp3sfgGD72utw7ZeCqFuwa55920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794476; c=relaxed/simple;
	bh=vz6O6NUW5cVXKOR2NcO/9+UMWZ8n1nRPSIioZxHa5Wg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=opvNlZ9/ZiiBnuAxjDA+iGHql+f2UgZRM7++Eu+zWkXDy/k/YTzovoO6YVq7ohGMecpux0ciYwfaGMD3UlEp4Tr1suUpLlHP3GXjU484XHmDjHONlwQAAMedPP5+XRF0+DyJmo2kPZJkvUKOVI81GZzang6LGxOAarMEce/YKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nzyDT5PI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gDY5tia; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.106738193@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YAq1M/SEwLvYVpHqhX0ClKqud7YWHzs+k/e3uY1M2Wo=;
	b=nzyDT5PIDxMQ0QDGSUoY1Mv4x2eMik18tBN6UEeyUh1SlDMN0rwYNNKyP1ZF3qDW2+Wz9z
	3HLc+ZxlXVylFZQw0qK7cnPRrl9BG+lqFgRG9QqS23w4oX3oczbuAqBrNng2J0OfkZn9w5
	yl4WXo7FHdrCWryE9y2vYLrJ1Do9EnIxkezRpRuDtaO7UPSmPNpOjQrttdAamxsLtiyrPa
	nwiLz7lirvLpiU7DbfmQ/dKUV/uLuPPIteKZwgqApXgq6r1+zAk9oOiUBxxsV6lMGvsMFE
	G1H4AdFNZZwafCu9EXzqqYZ2Qj+ZlZOPAlhLvcHcmovVt0MCXZNgB1woo+9QDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YAq1M/SEwLvYVpHqhX0ClKqud7YWHzs+k/e3uY1M2Wo=;
	b=0gDY5tiawWfzJc/LmSqvPFT7o4reioGB8RSwdGE1QpCAFBzJtU7ePQm9dVVmPOpnBtd18w
	OV0SEFkREmSCmcCg==
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
Subject: [patch V7 03/21] posix-timers: Make signal overrun accounting
 sensible
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:32 +0100 (CET)

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Don't touch info::si_overrun in send_sigqueue() and only store the overrun
value at signal delivery time, which is computed from the timer itself
relative to the expiry time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V6: Fold the timer_overrun_to_int() cleanup from Frederic and remove all
    overrun fiddling from the signal path.
---
 kernel/signal.c            |    6 ------
 kernel/time/posix-timers.c |   11 ++++++-----
 2 files changed, 6 insertions(+), 11 deletions(-)
---

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1968,15 +1968,9 @@ int send_sigqueue(struct sigqueue *q, st
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
-		/*
-		 * If an SI_TIMER entry is already queue just increment
-		 * the overrun count.
-		 */
-		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -233,11 +233,12 @@ static __init int init_posix_timers(void
  * The siginfo si_overrun field and the return value of timer_getoverrun(2)
  * are of type int. Clamp the overrun value to INT_MAX
  */
-static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+static inline int timer_overrun_to_int(struct k_itimer *timr)
 {
-	s64 sum = timr->it_overrun_last + (s64)baseval;
+	if (timr->it_overrun_last > (s64)INT_MAX)
+		return INT_MAX;
 
-	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+	return (int)timr->it_overrun_last;
 }
 
 static void common_hrtimer_rearm(struct k_itimer *timr)
@@ -280,7 +281,7 @@ bool posixtimer_deliver_signal(struct ke
 		timr->it_overrun = -1LL;
 		++timr->it_signal_seq;
 
-		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
+		info->si_overrun = timer_overrun_to_int(timr);
 	}
 	ret = true;
 
@@ -774,7 +775,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timer_overrun_to_int(timr, 0);
+	overrun = timer_overrun_to_int(timr);
 	unlock_timer(timr, flags);
 
 	return overrun;


