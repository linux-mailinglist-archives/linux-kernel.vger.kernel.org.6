Return-Path: <linux-kernel+bounces-396102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C059BC7DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72581C2161D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC1204F91;
	Tue,  5 Nov 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CUj/67IC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAabmXMd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B01FF5F4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794502; cv=none; b=YGSoAUL6MXNXYHo3CWMCCyiyun3H7geL/Dn/wMBeM2NXRoxg/eJdpGc7sJr9No3cVc98bZ483HCdIU3WeYHtjoyEk9f7JBnWFfzfgKJAcUe96FldkUNz0Lrkr4pLz/mYf9x35rbIcl0pDC4mfz7J2b48jUf5G/vQWduz87CURkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794502; c=relaxed/simple;
	bh=cd4sXhXakwb+fzXsqRjrgrAranc1Xfhju2HSn7PWquc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=agzD5NMd3gBin1G71iJ4wWmovjSWEbORIJUiLBR4ieKmU4TSMLKFmR2A/buNGpW+Smbga7fBCntPlqIsc8mCExsq4JWurw8pbCgxiYWxpfxUDxvmAp9njWSCnH88CRf36UuQCHb7qmZ53PT4sBr7LyIMi/Jox40raDOktNS74RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CUj/67IC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAabmXMd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064214.252443020@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/G9tthwBjRfRyuW6tk1m7S8dPbACqU7gfIOOQy6uXgM=;
	b=CUj/67IC/QtY0diI5e5h7Eg1ieIbeAQGmB/QvaDXxnEIuBCT5a9YPMmkL2ZSl+xMf60mLr
	4JW0RbLocE1d8JixrHEXK9fO4jmgvY92qsx0OmaoTpYCcXO+88ku1gO0EYQoIW+/YwVNCH
	tOBrqpyhBQHyfReUXPLiN+9AXwXnK5WOqV/kix1x6YqASi0mNeylRu91kX0q47PBMOcOoA
	NKB8OapkVQxEBNqiwztZEmUqfPGg2V1E/LHoZUZxcwEGLhpPjHugiDPT4Rt+FdMPNnjMdL
	IyRhhJlsrSDR2Z43rkHdgls9ewQooQKCOiUAgfGky4OS51ctWn/6tt0O1g4wOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/G9tthwBjRfRyuW6tk1m7S8dPbACqU7gfIOOQy6uXgM=;
	b=sAabmXMdaMz9PNoe2wALX3pW7iTkqKphmWV1pMuSnywSXSt51vxdk9NV9oax/5k7YqYDx5
	YOCr/EknPvSLe5BQ==
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
Subject: [patch V7 20/21] alarmtimers: Remove the throttle mechanism from
 alarm_forward_now()
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:56 +0100 (CET)

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
 


