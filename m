Return-Path: <linux-kernel+bounces-390837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DFC9B7EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147791F22839
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8460E1C9DFB;
	Thu, 31 Oct 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dzKxxRHZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xI2FfpDy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D221CB534
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389610; cv=none; b=ZOEy7Y/b48qQepAmOQ0wGCTzPzGeFEI0hPBi/9TnvBo7toKWC0o3E/TJutXCiUxH2aKzu1Pw3UPEFlUFCLxE6z95HIKoAyDE+5e2KTZxNx1LT03AjOKX78A+X9U6zxHsuh24W8/RGFb7VpMybIEvdFjPWWQmfPv+Sc0YAGu4pKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389610; c=relaxed/simple;
	bh=cd4sXhXakwb+fzXsqRjrgrAranc1Xfhju2HSn7PWquc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=d5vZeujRl0eX8JeJY46g4GsEG+ytTY5vLcA5ZefXs3too3QVhkSQyaOD5cWEyPzDH7pDpz6O/ju5SUna+g7tcH5pdRGCxpM3X9EYI+H9Hp7AZz6Riu5JtnrClb0s5bDIXY7GTk3KMTE4WNhkJfXpm7rqhyaXOHHbcdB8+XxvJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dzKxxRHZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xI2FfpDy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.752089279@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/G9tthwBjRfRyuW6tk1m7S8dPbACqU7gfIOOQy6uXgM=;
	b=dzKxxRHZdVFEQ3CSWJm9hyznvf0E6q8T0OElhgho1SkLxvYZziUCyPvahANAOMUOflc9vN
	e6wcq84UigMgEa25oNSI1rXGxy4YSE78LrqTSh8znsW0UiISgQHBOOlv56SrbUUdZh1DaW
	cIiYHUuXb4DIlxkRoiqkgWbtr9kGFrMKvIw8XnmoO9/mjyfYv2yEpIZbBcJAq2CSa72RT8
	nAUGAWTfn9+NQJYDHLg0Qk3WWDCXnew9dh6OfptZD7BfzJMU31+jBJuDNgAfVY0vqgwO5n
	0bdHV8qOmYDWTUPLzQ6lzOo/x0vQHNH12671T6ijQ6EAozdIxi1rf4j/u7hdsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/G9tthwBjRfRyuW6tk1m7S8dPbACqU7gfIOOQy6uXgM=;
	b=xI2FfpDyOzkWeffV0yk+/ocILtMWvki3BViDwmThxYcBf2/Dy3Om7JsLtxpXFPXXweTCNt
	3YHavJjXHqGpOICg==
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
Subject: [patch v6 19/20] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:46 +0100 (CET)

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
 




