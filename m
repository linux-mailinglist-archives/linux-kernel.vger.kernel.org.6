Return-Path: <linux-kernel+bounces-226077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E949139E9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EB81C20A3A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559F12EBE3;
	Sun, 23 Jun 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kajajaiX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Oc10H0z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1963D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141432; cv=none; b=ln9vSVgt3S+AIe0Xf0hF+uUaBWsO/0+IskGEGiADH2WbYjeJRphN8LYcQXXeWEqFCTn9pVYkAjZ0MaNsSRPfFs+Kixx/DkAvpJxtd4A5wca0FwlYgUt6FXbhvtOwDL3qGwaTVwjCMw6yLVrpuIVM754Gs6JLs0NDJc7MMyw58kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141432; c=relaxed/simple;
	bh=qSJTCa/qG7DFp96j39WRTupbxiACQG3bluYvSBSFHBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d7XDRRd3ieZgL9lwhXVFgQs29sfwtgf1D8pWBdZPXJ922AtM13u53lxGPiqHqVCSV0EEBQAey5LQD55bC7bnIHiUBdET0MN/0IBwvDcXGMRy9e7AZkLIHy8b9VgyLjC0lgVvvSCum6X1Bmg6lkbdjrP/AChcdTaiB5q1RJBIhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kajajaiX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Oc10H0z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719141428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3XPr0wFynEBg5v7ITZ27Ki98RtC1t0AarHT3dh7H7c=;
	b=kajajaiXWH9FYHd/VvBVjkoEnjQIwLSnp/lxCMyEG1A3Nql9TLXtdSZJmT8yBQd/ImhKWO
	XnG1qAIXXPQXhQ7xMPqwyR3rMfPtjEx3yKbjoS+TEpyNgVKU+b6oZLi7fOoMFt9QWWvqPU
	reCFYUf4U2MOiuu+a30o43WbYeEjhN2J3OeNoKzhNTo4IptMi+GrkODiUvQOz/b/be4Rpl
	jTa8MYMHY9sOF7E7Q/74jpWMHYtYH5dGLsYkXnYgQVAaIRUYOsZ078Sb2M3d1OoMtTYD7U
	eFVCubqdLKgcqRtAD9F/PpSH2d5gulHKyFWzgTQmWG7mxr+8jPgZN4FLRUvUqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719141428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3XPr0wFynEBg5v7ITZ27Ki98RtC1t0AarHT3dh7H7c=;
	b=+Oc10H0ziE+pVCIr0yBcie5AziZBpZJaqBh2guCyXw/869k+2k8SI20l6DkX5+abEs7GO7
	+lNTX40PP97iTpDA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg Nesterov
 <oleg@redhat.com>
Subject: [patch V3-2 12/51] posix-cpu-timers: Replace old expiry retrieval
 in posix_cpu_timer_set()
In-Reply-To: <20240610164026.225762087@linutronix.de>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.225762087@linutronix.de>
Date: Sun, 23 Jun 2024 13:17:08 +0200
Message-ID: <87tthjykln.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Reuse the split out __posix_cpu_timer_get() function which does already the
right thing.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3-2: Fixup the split fallout
V2: Adopted to previous changes
---
 kernel/time/posix-cpu-timers.c |   37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -614,6 +614,8 @@ static void cpu_timer_fire(struct k_itim
 	}
 }
 
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now);
+
 /*
  * Guts of sys_timer_settime for CPU timers.
  * This is called with the timer locked and interrupts disabled.
@@ -623,7 +625,6 @@ static void cpu_timer_fire(struct k_itim
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
-	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
@@ -689,37 +690,11 @@ static int posix_cpu_timer_set(struct k_
 	else
 		val = cpu_clock_sample_group(clkid, p, true);
 
+	/* Retrieve the previous expiry value if requested. */
 	if (old) {
-		if (old_expires == 0) {
-			old->it_value.tv_sec = 0;
-			old->it_value.tv_nsec = 0;
-		} else {
-			/*
-			 * Update the timer in case it has overrun already.
-			 * If it has, we'll report it as having overrun and
-			 * with the next reloaded timer already ticking,
-			 * though we are swallowing that pending
-			 * notification here to install the new setting.
-			 */
-			u64 exp = bump_cpu_timer(timer, val);
-
-			if (val < exp) {
-				old_expires = exp - val;
-				old->it_value = ns_to_timespec64(old_expires);
-			} else {
-				/*
-				 * A single shot SIGEV_NONE timer must return 0, when it is
-				 * expired! Timers which have a real signal delivery mode
-				 * must return a remaining time greater than 0 because the
-				 * signal has not yet been delivered.
-				 */
-				if (sigev_none)
-					old->it_value.tv_nsec = 0;
-				else
-					old->it_value.tv_nsec = 1;
-				old->it_value.tv_sec = 0;
-			}
-		}
+		old->it_value = (struct timespec64){ };
+		if (old_expires)
+			__posix_cpu_timer_get(timer, old, val);
 	}
 
 	if (unlikely(ret)) {

