Return-Path: <linux-kernel+bounces-249816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FB92F049
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345D3282A75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62119EEAE;
	Thu, 11 Jul 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EhDPddAH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUCWR+uK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48A16DC1E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729531; cv=none; b=cbRogVp0SfRpybuaU2/7BALh2rYL9MZDTmH8klbGkvQ7QJ1SWcMy62DiWBKq43tZM/vF6ddSAhzcyTQf5PJmwBDl1ZM5afLXi9GofQ1HrCQj9JefBYxHyCsi6uO0IzYgvNhAYpfd1QLSlo54rw7TZJtNGySBCz7sIkJOImX2Ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729531; c=relaxed/simple;
	bh=/9ofpnHO2OAP+FbQBqxbViJyhmn2yJpzI4MjCx0uX2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MWAPZpf/Ms55hkeTv3pQU8LfQCtI8Wy8e0XNbL0f23VUVaOvyeStnoIua3JMpjf+DaxyqBKpivX0q6JQsUGYn0Rl3RI3wNf2rGruKeaHgBRKcGtjzxFKwV7EZqeDBQOPlmSqY25fB6mhLCzDQ5yivXBvL0s+KO8YHKUzyuTELIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EhDPddAH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RUCWR+uK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720729522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=443/8prm4wyzfSQuAra7ANeG3CnB0RgMw6k+zn0D23M=;
	b=EhDPddAH9cmhNPlbVWa8nA6IBHHU9XZ20UyEoXLPE1n6iv6ucqpusXdDRC8jJbaPgwDLOZ
	YKkkA1yVCMAPXzT38KYN5rhwHWDDzmImM4vs+9j8eIXK1MCqialNl8oWZpwb0l9jWQNa3U
	NnMW5c+uvswqLiMVKGVe9Fsk7azEnelSWegpPd/2VBTP2YpbTpa+kDYXgJLYMaqVzfz4Ez
	bca8BoZc1w+HD+9D42aBQ2WBVPHoAivzEndfUjd3jG+blNRfZg6aJA+XX/RsfC9cHjRiyf
	82WXJX1SHCN/ctnEQJGGE0nUE5RkGoTap5RPpRou5Z1FRJ3qnffAQFlr01jwiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720729522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=443/8prm4wyzfSQuAra7ANeG3CnB0RgMw6k+zn0D23M=;
	b=RUCWR+uKSH3JmnGVSqR0W+aPmL3qW57UbVHAczbazz0/MRz1Lf0Em0ujQv81B+H8rqWdZt
	InvbiE3lq+HaJnCw==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linuxfoundation.org>, Peter Zijlstra
 <peterz@infradead.org>, x86@kernel.org, Arjan van de Ven
 <arjan@linux.intel.com>
Subject: [PATCH Resend] watchdog/perf: Properly initialize the turbo mode
 timestamp and rearm counter
Date: Thu, 11 Jul 2024 22:25:21 +0200
Message-ID: <87frsfu15a.ffs@tglx>
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
Resend because I screwed up the subject header. Sorry for the noise
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
 

