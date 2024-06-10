Return-Path: <linux-kernel+bounces-208576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00629026F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B3F1C21376
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E3145354;
	Mon, 10 Jun 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQKwhV2V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RQeo4Py8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96C14F9F7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037745; cv=none; b=q1qE3GmJLX/hn+RnjFVqgtIZOSy8ynmZCfGjPIM6sZ+ORVKlhdjnx71s97kjenBm+ZLDnMa/0MUD9WrAbxrvlPZitGyFQ8Kw59a6wNmejZNwn3iF4P/MIsSxT3NkvbXCTtoxfplWNTk8g5qELv7FTpDH5Z7thTctP83WX4WkfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037745; c=relaxed/simple;
	bh=UGVZy9yiNtE3R/qqXfALDVUSsmVr1T6CsA5jtA7JuEI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PIQ62bLNcUYJYJHf0ewFXGm9bkUbPnWCisqMMlz4Ba1dIE1/KxDBx8VqVtrxvdemmMI+gq2HVcr4+q11s46erAGube2FYkM6rvDdrwjGkAnCiXPIV1KFr5l40FjNG9ntltiyHIRDg0yvRKXg1LKoi7SuCe+FnK5d0Q/AGa51a2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQKwhV2V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RQeo4Py8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.225762087@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IjZXK69CXPSZdDcaR3Lrs+m7BfPVp6Q5CnwMmPhWl8E=;
	b=vQKwhV2VHCny5Tg9fl+zR5CNQptSwBYJMiOrxDw+e1CprtmxOUsVGtbzKoS24BralhVc/t
	/O6N7SJtNVDWq9knDZsyLHaXLJNxI26a7EGSN7ujqIFtLs0Ys5Eeb2LRFWvnQWQ1LWecCl
	RQMO8J+21voQbixP7HAEm76GP7E1ua0lnRQXJPAeylmfFkJT28lqS8DthGFCCSOapTQrmx
	pwNF1LKM0ycUGc7Ce63QsXk32xmT3ojOpCpM+qITQ5UYJH55ZG562zWOh4jmmHSbBwUsUx
	KUOuUj6djGUwFYZ51jpWkRmZj59eeuN77/eaPYdDFFhCtANZkrwVTHOIV+htXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IjZXK69CXPSZdDcaR3Lrs+m7BfPVp6Q5CnwMmPhWl8E=;
	b=RQeo4Py8SyaHuNFc2wn7AHLLc4Nu6RvFl5F64d02NDNnhld6SvGIdMVwfy6yhBRTVLIYkK
	GGomy/CX/nWDjADA==
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
Subject: [patch V3 12/51] posix-cpu-timers: Replace old expiry retrieval in
 posix_cpu_timer_set()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:20 +0200 (CEST)

Reuse the split out __posix_cpu_timer_get() function which does already the
right thing.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adopted to previous changes
---
 kernel/time/posix-cpu-timers.c |   36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

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
@@ -688,37 +690,11 @@ static int posix_cpu_timer_set(struct k_
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


