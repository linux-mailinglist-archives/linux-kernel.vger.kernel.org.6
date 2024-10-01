Return-Path: <linux-kernel+bounces-345554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97198B767
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167142823B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26711BF333;
	Tue,  1 Oct 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDWDZw6l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KxvG1Imb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BA1BF814
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772158; cv=none; b=uSeZI4ePji6IapovjsSGv5gZjtB3KBHfETecqH7UV/octpPoiBnMMCq24Yfu1uzLxkjfWd0qL3VYuhKEsPDclS1BrPUG27wMhcabkd6llksyH1XPn4y1czCpGOf5l5Zy1GFi0RpDjDnmV6tOvaiukHEci4uURvVumyueWAz4KTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772158; c=relaxed/simple;
	bh=A8egy+nUGYQ0pNfWcftUljyWgjT+dpcfC5EDeO3tOqU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HNvSoIHecctYqm44NAoqYEZ8bhPG5AGEhfRNI1ZGnbBj0bMoXbhz4V15o09NFmRKVVKAHJOZ5jN5b/M2glqq+UsI8SFUIbzX20UlmWgzZX/fBS0gpSnFCJ74CZlkhRY05NYjrtGbcT4ToO4gGLwjN4745ekGOryg+RVqOVPMFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dDWDZw6l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KxvG1Imb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.749282631@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+GGMvIt5z7I9VJm4esvwiz4Q8v92uRiYrO25Sjx4v2Q=;
	b=dDWDZw6lCkcvVw+BnBRxKDL4kZOJLAyMFFiObRxUAP3+JTaGL7VSG62Ua0XUF8cB3iO82U
	tSPv7DRIVmKegOuXtm3+1Q6qxW8T1m6r95Cia5EgjdmRX+nC28syCyFmKxMUEYx7fSFghO
	Pe844BjEJtCtk0Bc6X+azwsGsiE4zwfuehRVjcCElhZQueFWIeuBFhORg13KiBqJ9zvk8C
	6Nvd1Pzg9kUG2RO78HhNqsUQ58c5hxFFc8VRhWxy1TYW9lfdeQ9fLHWLIhOR0MJxHkSSCV
	JZ/eG5X3J3eDYG+XM0Z43RZu8IWIUAiTNaHXUtVeueKJ3qPfm0md2qq/Qa758A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+GGMvIt5z7I9VJm4esvwiz4Q8v92uRiYrO25Sjx4v2Q=;
	b=KxvG1ImbWY2fyselSDsiI0EA/2L1AWuPgsM16FhncUlSjGfG1h22JwBdt5FGk2tKNgOD91
	sZjPN31UgXY3RQBA==
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
Subject: [patch V5 25/26] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:34 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the unused alarm timer parts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/alarmtimer.c |   28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)
---
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -467,35 +467,11 @@ u64 alarm_forward(struct alarm *alarm, k
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
-		 * To prevent DOS fake @now to be 1 jiffy out which keeps
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
 


