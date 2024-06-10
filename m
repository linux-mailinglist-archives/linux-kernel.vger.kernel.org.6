Return-Path: <linux-kernel+bounces-208617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4D902735
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596581F2166E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1B15ADBA;
	Mon, 10 Jun 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="braac+sm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eklJcDEC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C515A49C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037791; cv=none; b=N8EYAj+DLLUyakJ9dloqJbU3H4BF1SDVcyQ0xNitRIwyGVMPIye38nLXlOJ8xENkH7LS9UsUaPt3jZsB2MIx+fCUT2Jw4l0FeaAj7mOSyuSo2DgozDRhgGgH3WLLcxhfulP6/Mu/rQ5qkaXIV+gv3ZyPjLqDFvA5RcZ3Ldod9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037791; c=relaxed/simple;
	bh=dVOMH7eiDEHVePUyZa4h1ExK1Rjvcqco8G9d9SW/qIU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QKzODpsBhzg7NiBWfh6MV/nyMOBUiJj661LihoW2fmEtxHb174+Pod3WirfT3HbavLIV2HZCIU8U8W4FmjLrTeObuVf0NZ0Gpf2UeFqPAeefYgHI7UWr34JziTFDNr0G58qkqhTWMNzoyuyWZvmq5c+uchGQRt8RsZaySOBP4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=braac+sm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eklJcDEC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164028.602391697@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HdIXDmhsPUZ2RPLujxzrsxlJ5xE23RHzUivxcwc9L5U=;
	b=braac+sm3dy3Sj6PI2wRWC5h2tNpmtL6i1ul4xFtWdXaCn8Se2grLPNaS15m1K2azpftr3
	a5AV9MqnpwnViEb3EHB+V57NUSVQcKGCh7vcqye5bGHdXxOJXCtBqFhUJssrFoDlsf+YSl
	GJhQD3MoEL6s2Lu425H26W7QCnR2oLbns2SPUwQhD1bXIa5oF6CHzG8e3N/5dYe1JQiCgJ
	qG7khJkbfQXX2ovn7Lb4AF8xlnz6HbtwHk0MFzfPpfculL/uAhaI7u5sZTO8GA/8HSitYx
	ZfPIIM9qYGBTi4U1XGJ+vcVu3BSsw+ZblWp1ipoSu2V4T/ooa34yH/mco12vfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HdIXDmhsPUZ2RPLujxzrsxlJ5xE23RHzUivxcwc9L5U=;
	b=eklJcDEC7895pOTsJCssnGpd5ZjyEg5taghQDWJrmLU86tOjVf4k9d0N2sHaLPlXN0Qszo
	jSE4fPnw95Aa27AQ==
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
Subject: [patch V3 50/51] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:43:07 +0200 (CEST)

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the unused alarm timer parts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -469,35 +469,11 @@ u64 alarm_forward(struct alarm *alarm, k
 }
 EXPORT_SYMBOL_GPL(alarm_forward);
 
-static u64 __alarm_forward_now(struct alarm *alarm, ktime_t interval, bool throttle)
+u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	ktime_t now = base->get_ktime();
-
-	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && throttle) {
-		/*
-		 * Same issue as with posix_timer_fn(). Timers which are
-		 * periodic but the signal is ignored can starve the system
-		 * with a very small interval. The real fix which was
-		 * promised in the context of posix_timer_fn() never
-		 * materialized, but someone should really work on it.
-		 *
-		 * To prevent DOS fake @now to be 1 jiffie out which keeps
-		 * the overrun accounting correct but creates an
-		 * inconsistency vs. timer_gettime(2).
-		 */
-		ktime_t kj = NSEC_PER_SEC / HZ;
 
-		if (interval < kj)
-			now = ktime_add(now, kj);
-	}
-
-	return alarm_forward(alarm, now, interval);
-}
-
-u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
-{
-	return __alarm_forward_now(alarm, interval, false);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 


