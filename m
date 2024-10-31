Return-Path: <linux-kernel+bounces-390820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22EE9B7EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74FB281D00
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9581B0103;
	Thu, 31 Oct 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycLUHNR+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k8eg3rPw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197133F7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389590; cv=none; b=YadWDIa0gpnANJuilN1Qx+SzaqHCVlNHn7zRDHEkRl7ZmgYzsrZY0kNhFevgMPUGio74jaw3fRAInW8cf18ywQGJz7IAs5VDwY1jW5Rxzm9qq7wfl15kwmbWvXcVJqbgZlVmCgBR1MEcAv8DjCw1ZcQrd1AFCEwQVLiaHJC28DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389590; c=relaxed/simple;
	bh=KX1FFQwMnsJoVPsOnqh6Joq5g99AWzhEz+Vr7i6dJ58=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=aDc9lkmAsjysqVXqJoHgy15eMN8uokGpB8IJfNJF2WbwcoXTAqgFyM0c6ieBq2y9N0tlhxOmDRnLHOneF7eHGf2pjQVDjtLd4Q6AMwqYDbcu9MrW7zhpZtEQnQJaLl7vwP5aJe0INCDjmElMNsCey/FTONy3yKg+um/1yxluXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ycLUHNR+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k8eg3rPw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154424.677253735@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8Ktc/ZSZllcX0GFHzNBw2jkczc+2QhjWp2jl7bmrkpY=;
	b=ycLUHNR+kek0COxqqSZI4FDdnQV5XVgcVYpuylcXnLXbWu+KIg/SIr0ipc+h+hHWJ4cDO1
	deWc1N6oKSThxDAS8Qn5FOenM+wgKDB8Pl8M+P0O722tEP/WkJLxgbKg0W2+CVYuOMtgoc
	WEpx0tqsXt03e3A0wxqerWavckH+qTJ6rZCG1bJu2dyN+x27/6DwMML7iFceMb9a9Q7IfZ
	9DRoLwViqBiuxNwGFN4Qw9shkb9XbzQx0ORjYLkvLHk0D5n+GWYlkojYCjwn2egdK0+ehO
	f6qeXxnyS/SPIbPMGAJnPYm50YZinHRB+NjsHJMQu+0kyKpM5PfyMSUfx06Sfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8Ktc/ZSZllcX0GFHzNBw2jkczc+2QhjWp2jl7bmrkpY=;
	b=k8eg3rPw5dnOW29o3steDs2kRPq+o4qxNwj6F7Q0FiX4GeJz3vwePCCHJjkcNgIepi1x5u
	x4/VJoRhgExM9EAw==
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
Subject: [patch v6 02/20] posix-timers: Make signal overrun accounting
 sensible
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:25 +0100 (CET)

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Don't touch info::si_overrun in send_sigqueue() and only store the overrun
value at signal delivery time, which is computed from the timer itself
relative to the expiry time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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


