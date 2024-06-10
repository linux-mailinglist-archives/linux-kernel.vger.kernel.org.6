Return-Path: <linux-kernel+bounces-208573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 405DA9026EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94BBB23781
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8914F9F9;
	Mon, 10 Jun 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1aKYBAAJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0KqAgwz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F814C58C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037742; cv=none; b=qOkXzIpDdUw7/t5eUcR4+LECwTvs7/F7PnPM+EXuqdPBnJVCC+LD1eU1yvnSQPgJ880gysqWp+eYXUMxjo1f7pBiqfR63RL5WKCEfRWI0iUXMEeIUZkoUTb7P8jPp4Lg/mxGESai3qTOy+YYBC17/OTdYXxmFQ89YmdAxp4trsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037742; c=relaxed/simple;
	bh=uF1VDsOZ4FIX9FT58rai3eHyWyTmEsXGceZwBt+UMwI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tqzhBeIqOhGxweDGGYMXojpF6kyKczkl8xXILmtxyp373s580Pwq37Kzr1w1EYdePt77i4Hw1EJdaKi3ZM7XnzUTMVyWTNKxKglDB279CI1BN1kq9VvOZfDbVJGcnLfz13RbEpTo3wQ4mw7X94Ehqiio+JqFPSUh4paZYcocqFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1aKYBAAJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0KqAgwz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.099214180@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vXPCMrPwGrJjX858eQh8BXnWzZ6Yig+J2QuB2rurbL0=;
	b=1aKYBAAJStW4RUQXCW07jzw6bT01OVH2YUAcLzxkU160tuv7FeJBvPAz41pc15tp+0DNI9
	K0Y3P6GR07tfZ0qeYM3lNrq1ub0wl94Y22S9GXkY5/NUQhpzMa5uaUOB6bXfec2cMccwj+
	bz/4I/DFwWXkVl8zooyLDIPyWHfBpBEcHCrON1fpiJDl0IWzVrwLvmqEYk9G1SS/4WbPtN
	E07XWf9m83rpCPv2kQT3fxYkTaL/o7hzHepz4Gef3hdHhIdLOx1Qka/8gPQwtpJDaR9O2s
	szhPGZYOpii+K27pyGgNhV63dpcUraoW4fYrgrGbK634akOyuTUf7Enmh/KZqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vXPCMrPwGrJjX858eQh8BXnWzZ6Yig+J2QuB2rurbL0=;
	b=D0KqAgwzQY3WSiLkwf4WRZKatXYq52JWwqsTLFGW5pCIScot9p6pfsXPT15T3HRBitpkB4
	2nGYVamt3b19N4Dw==
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
Subject: [patch V3 10/51] posix-cpu-timers: Handle SIGEV_NONE timers correctly
 in timer_get()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:17 +0200 (CEST)

Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
timer_get(), but the posix CPU timer implementation returns 1 nsec.

Add the missing conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -787,15 +787,17 @@ static int posix_cpu_timer_set(struct k_
 
 static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	u64 expires, iv = timer->it_interval;
 
 	/*
 	 * Make sure that interval timers are moved forward for the
 	 * following cases:
+	 *  - SIGEV_NONE timers which are never armed
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
+	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
@@ -809,11 +811,13 @@ static void __posix_cpu_timer_get(struct
 		itp->it_value = ns_to_timespec64(expires - now);
 	} else {
 		/*
-		 * The timer should have expired already, but the firing
-		 * hasn't taken place yet.  Say it's just about to expire.
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
-		itp->it_value.tv_nsec = 1;
-		itp->it_value.tv_sec = 0;
+		if (!sigev_none)
+			itp->it_value.tv_nsec = 1;
 	}
 }
 


