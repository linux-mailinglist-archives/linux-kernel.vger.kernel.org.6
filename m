Return-Path: <linux-kernel+bounces-249783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820A92EFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2285828103B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4216EB77;
	Thu, 11 Jul 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VpcJPowK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozWgs7f6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A21016E866
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726591; cv=none; b=MKXVDkOTwbliWXcprY22xeK7Uyfrl7TNhg3x2B4qLsCwa2AkDt9LT/HVTyCTG/yltA1g8909efH4FMKyZOvLoNoFTN9piSAC5vLl1Z6tpI8VgrO1oT+iI4OEVqYr5Z4P9meF2QVACbpzL0s2IKyVhMs8FJYXuzW0J1wqLk07uhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726591; c=relaxed/simple;
	bh=wnIFmPgQdOkUwrIhSX78uJDe/F6CrKKaJ6+BERPJ+yU=;
	h=From:To:Cc:Subject:Subject:Date:Message-ID:MIME-Version:
	 Content-Type; b=jKy5KE0dNRuukeboF16jkSJ0trCEsczku3mDLxqXsfMl0bN+i+FWDgDHAg9OCsUv5fFKE3lYhnWH7+sxlmCp6SJRm/RRTM7591XIKExNAdzq3odFe3rSywnSgzdmVxsz3HC7Cv1W985m1bMGxRughliM+6T2BOBD6t7FjXiLy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VpcJPowK reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozWgs7f6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720726588; h=from:from:reply-to:subject:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=ZcW1sCT7Y/KTj2JrkUFAgD+IvUD8m9u/4no75G6nark=;
	b=VpcJPowKwHxXRqgLvO60dZoIcXCiyOeMH+HfcXEnBp5JfXfJ/KHoPChDKCoagGPsEBOaBK
	mh75A4+vWbUSa0fz7LuReAG2k1GiHlhL29M62mimn4YDoHqb1shfCvE4u36FFMdPXiedS9
	jftdKl/y/ruXY69b8TOdSDUEdNVF6e1evhWOn46gHTjI1p/xf+dHhV83r4HZjgV2U6oHhM
	Bz20VcOskCnRMxWgkI3ZwWb82fTUJm7IDQREdXsB4b2cyDc6H97s8wvzoSbqrWSogorc8J
	XKQf5vqLqO5c3U07dzRXmTagNFHkjbGSvTbhMeZUZvNeDVBp1qWLdoQxk2MAbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720726588; h=from:from:reply-to:subject:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=ZcW1sCT7Y/KTj2JrkUFAgD+IvUD8m9u/4no75G6nark=;
	b=ozWgs7f6VOq05HlocFsXXZqohwtYuHNYhJ/yPMkV8zfY4swe1SX8vBClT3TQUxk9Pxc60R
	9Ke5QjhxBnhij3BA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linuxfoundation.org>, Peter Zijlstra
 <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] watchdog/perf: Properly initialize the turbo mode timestamp
 and rearm counter
Subject: 
Date: Thu, 11 Jul 2024 21:36:27 +0200
Message-ID: <87msmnu3es.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

For systems on which the performance counter can expire early due to turbo
modes it the watchdog handler has a safety net in place which validates
that since the last watchdog event there has at least 4/5th of the watchdog
period elapsed.

This works only reliably after the first watchdog event because the per CPU
variable which holds the timestamp of the last event is never initialized.

So a first spurious event will validate against a timestamp of 0 which
results in a delta which is likely to be way over the 4/5 threshold of
the period. As this might happen before the first watchdog hrtimer event
increments the watchdog counter, this can lead to false positives.

Fix this by initializing the timestamp before enabling the hardware
event. Reset the rearm counter as well, as that might be non zero after
the watchdog was disabled and reenabled.

Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/watchdog_perf.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -75,11 +75,15 @@ static bool watchdog_check_timestamp(voi
 	__this_cpu_write(last_timestamp, now);
 	return true;
 }
-#else
-static inline bool watchdog_check_timestamp(void)
+
+static void watchdog_init_timestamp(void)
 {
-	return true;
+	__this_cpu_write(nmi_rearmed, 0);
+	__this_cpu_write(last_timestamp, ktime_get_mono_fast_ns());
 }
+#else
+static inline bool watchdog_check_timestamp(void) { return true; }
+static inline void watchdog_init_timestamp(void) { }
 #endif
 
 static struct perf_event_attr wd_hw_attr = {
@@ -161,6 +165,7 @@ void watchdog_hardlockup_enable(unsigned
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	watchdog_init_timestamp();
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
 

