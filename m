Return-Path: <linux-kernel+bounces-528675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 766CBA41A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E746F7A2010
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253625332D;
	Mon, 24 Feb 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BdUqDahJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hN4rsXSQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185D250BFF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392132; cv=none; b=ealJhRtWs39+OYGgLprvKDHHOpr6yIZ52puyFU514aBrVNUxhEulVO6x3G34MIGC27/Evtll6loB//OE3N+dHL98i8oPKQuy5bREPRrLyuB7Kvx8OjcFBTI//vJTGAzf+aUFjpsI4nS5TH6mNh0p3oe+k2SrEO7epPk5xKz63nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392132; c=relaxed/simple;
	bh=DHbJrH7Wy2Qgrxrm10ExE1EJqyog3aCCmza3aa8M7VE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RXRbqKGb5kZyqdsX0V32T/49v8g3lxW8sMAlY1pyI5/nBXTNGyHknlVYaB5/FptLmuIy3lxrfA/m1mROXzjN1+eOCVBXVHg+PjVoknwHAuSZaYPbPwxBPaTeTBcku0UQ56MxAGNVdgqWHtXb+yjZ88hsIazrq1j6ToXSOjcSrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BdUqDahJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hN4rsXSQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.211872476@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IeocMCfWumPqvW9Qhzgc4ByoA3vEdEKIXpzY+ZUrsp0=;
	b=BdUqDahJXBOiiAllt17mDdMQ4pN22rY1boweAmQ5J84PVJJtWgkNSqBIBSkcB6c6hysDZZ
	6GK6gccKpR0swzzC1Zun22HtLy6fVKssoMLcxfxbQeOX9Ias5n61CCpjAEgwoN+ojzXgto
	FKHm77/EdnrgIN0DOPHrDxvm76biwxa8fCC1LrFJqfK/kgG+WZRETOVlJ4e1hAJGujdE2k
	3eqH6lEqMvQtv7yUbree++OG+1bUMIHO/9UVZsFhoCkAeYIsNk1c9Y3H9FNdm+AkOMBlam
	nKWBIvj4wpgknGTemlaWnn9aY+W005vTH8jUhrrBa9RtDmfjwf7jrr4uUp90ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IeocMCfWumPqvW9Qhzgc4ByoA3vEdEKIXpzY+ZUrsp0=;
	b=hN4rsXSQ6khTEIY5r6M5sXcA62YLo0JmJKJav4tcl4JGVEIDnX2/pSWZuQ9LyeyDCRbIDj
	ybZSGp9zpMgPQmAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 04/11] posix-timers: Remove pointless unlock_timer() wrapper
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:28 +0100 (CET)

It's just a wrapper around spin_unlock_irqrestore() with zero value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -144,11 +144,6 @@ static int posix_timer_add(struct k_itim
 	return -EAGAIN;
 }
 
-static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
-{
-	spin_unlock_irqrestore(&timr->it_lock, flags);
-}
-
 static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
@@ -691,7 +686,7 @@ static int do_timer_gettime(timer_t time
 	else
 		kc->timer_get(timr, setting);
 
-	unlock_timer(timr, flags);
+	spin_unlock_irqrestore(&timr->it_lock, flags);
 	return ret;
 }
 
@@ -755,7 +750,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_
 		return -EINVAL;
 
 	overrun = timer_overrun_to_int(timr);
-	unlock_timer(timr, flags);
+	spin_unlock_irqrestore(&timr->it_lock, flags);
 
 	return overrun;
 }
@@ -822,7 +817,7 @@ static struct k_itimer *timer_wait_runni
 
 	/* Prevent kfree(timer) after dropping the lock */
 	rcu_read_lock();
-	unlock_timer(timer, *flags);
+	spin_unlock_irqrestore(&timer->it_lock, *flags);
 
 	/*
 	 * kc->timer_wait_running() might drop RCU lock. So @timer
@@ -928,7 +923,7 @@ static int do_timer_settime(timer_t time
 		timr = timer_wait_running(timr, &flags);
 		goto retry;
 	}
-	unlock_timer(timr, flags);
+	spin_unlock_irqrestore(&timr->it_lock, flags);
 
 	return error;
 }
@@ -1046,7 +1041,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	WRITE_ONCE(timer->it_signal, NULL);
 	spin_unlock(&current->sighand->siglock);
 
-	unlock_timer(timer, flags);
+	spin_unlock_irqrestore(&timer->it_lock, flags);
 	posix_timer_unhash_and_free(timer);
 	return 0;
 }


