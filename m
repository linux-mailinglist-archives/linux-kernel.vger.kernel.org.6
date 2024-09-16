Return-Path: <linux-kernel+bounces-330350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE50979CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CBC1F22C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E713E03E;
	Mon, 16 Sep 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lATcmgsw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B55tdtoh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F3146A72
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475930; cv=none; b=GMjlhWs2shBZGyJ23Ase7SR7fpqpGDFUluKy0SgqZMEO5AoDe5zpMk7qcocoZBbLK8SKaEsuZddpegoiRX0LB0/y4GfJgGsfJAPZ6DAPXmzhhGfy8QhhjpdTuAqLY6X/VTqZcheSloPNjUa21gInNozsrSrjE8ec91w67t8+CKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475930; c=relaxed/simple;
	bh=lk/EgyrmE73eJq+w8XPJpjaOj1Zl3LE+Xj363u9mJkQ=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=Rym+UIqAYG0LnR5TaDied17guJLcu0ggVbXcjIdH7MVchYaU6JiEIyQlhk8rqtPSrSx61lXWEg1LkhcqUry2OAMmhs2iYlY0fNI/I+7pLvUzPMmps7FmMu4jZevlFUC2qemkUPfliA+vrFsEJ6AsoLrWoJA/G3BtqvSA5PmvxuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lATcmgsw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B55tdtoh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726475920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=IIAizPiE38teQZpkZTcCJfDojT1J1Xdpby4SVSHnkgw=;
	b=lATcmgswKk9P406Qc3ul1+QeP1HrWUwlpeEpzitkftjLfDyxtRcPDTvkD+/HA8oM7LMTw7
	OMfCtpmVd/K8VSWdnwVrG6T9aOUS1rXBAN+0rLsSySUSQAa5D1K0D45MmNhyDDW2MVAVA4
	3JshbXHg/Z0RwbrpJF6BTRGigx/TmgOPvPdKVrutiTpaQ2EuVzoLnketF9Ot8O5I60y/68
	U6NeoCQApZHNs/FsWvd2tWWNALri6Ke+gAMGDWc35d5SdC4jYUSVUT2rWxKVJJThdBt19j
	5rUZYc8WTuqIIT6B+47Ww64CJ1ZhRG5w8LhnXeMR8nft104mluoqpcFt19L0YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726475920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=IIAizPiE38teQZpkZTcCJfDojT1J1Xdpby4SVSHnkgw=;
	b=B55tdtoh9BlHSHu0yP6rG1sn4uO0ThGpk2u1wiwYW41V9Ql3kqUOiR1cYqJZirpu6GKtrK
	T70BnLx/CJ/LH+CQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/clocksource for v6.12-rc1
References: <172647588843.2450257.3544233832195550173.tglx@xen13>
Message-ID: <172647589402.2450257.6913545425550099726.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 10:38:39 +0200 (CEST)

Linus,

please pull the latest timers/clocksource branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksour=
ce-2024-09-16

up to:  4ac1dd3245b9: clocksource: Set cs_watchdog_read() checks based on .un=
certainty_margin


Updates for the clocksource watchdog:

  - Make the uncertainty margin handling more robust to prevent false
    positives

  - Clarify comments


Thanks,

	tglx

------------------>
Borislav Petkov (1):
      clocksource: Improve comments for watchdog skew bounds

Paul E. McKenney (2):
      clocksource: Fix comments on WATCHDOG_THRESHOLD & WATCHDOG_MAX_SKEW
      clocksource: Set cs_watchdog_read() checks based on .uncertainty_margin


 kernel/time/clocksource.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d0538a75f4c6..23336eecb4f4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -113,7 +113,6 @@ static u64 suspend_start;
=20
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
- * Also a default for cs->uncertainty_margin when registering clocks.
  */
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 5)
=20
@@ -125,6 +124,13 @@ static u64 suspend_start;
  *
  * The default of 500 parts per million is based on NTP's limits.
  * If a clocksource is good enough for NTP, it is good enough for us!
+ *
+ * In other words, by default, even if a clocksource is extremely
+ * precise (for example, with a sub-nanosecond period), the maximum
+ * permissible skew between the clocksource watchdog and the clocksource
+ * under test is not permitted to go below the 500ppm minimum defined
+ * by MAX_SKEW_USEC.  This 500ppm minimum may be overridden using the
+ * CLOCKSOURCE_WATCHDOG_MAX_SKEW_US Kconfig option.
  */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 #define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
@@ -132,6 +138,13 @@ static u64 suspend_start;
 #define MAX_SKEW_USEC	(125 * WATCHDOG_INTERVAL / HZ)
 #endif
=20
+/*
+ * Default for maximum permissible skew when cs->uncertainty_margin is
+ * not specified, and the lower bound even when cs->uncertainty_margin
+ * is specified.  This is also the default that is used when registering
+ * clocks with unspecifed cs->uncertainty_margin, so this macro is used
+ * even in CONFIG_CLOCKSOURCE_WATCHDOG=3Dn kernels.
+ */
 #define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
=20
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
@@ -231,6 +244,7 @@ enum wd_read_status {
=20
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csn=
ow, u64 *wdnow)
 {
+	int64_t md =3D 2 * watchdog->uncertainty_margin;
 	unsigned int nretries, max_retries;
 	int64_t wd_delay, wd_seq_delay;
 	u64 wd_end, wd_end2;
@@ -245,7 +259,7 @@ static enum wd_read_status cs_watchdog_read(struct clocks=
ource *cs, u64 *csnow,
 		local_irq_enable();
=20
 		wd_delay =3D cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
-		if (wd_delay <=3D WATCHDOG_MAX_SKEW) {
+		if (wd_delay <=3D md + cs->uncertainty_margin) {
 			if (nretries > 1 && nretries >=3D max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before succe=
ss\n",
 					smp_processor_id(), watchdog->name, nretries);
@@ -258,12 +272,12 @@ static enum wd_read_status cs_watchdog_read(struct cloc=
ksource *cs, u64 *csnow,
 		 * there is too much external interferences that cause
 		 * significant delay in reading both clocksource and watchdog.
 		 *
-		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
-		 * report system busy, reinit the watchdog and skip the current
+		 * If consecutive WD read-back delay > md, report
+		 * system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
 		wd_seq_delay =3D cycles_to_nsec_safe(watchdog, wd_end, wd_end2);
-		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
+		if (wd_seq_delay > md)
 			goto skip_test;
 	}
=20
@@ -1146,14 +1160,19 @@ void __clocksource_update_freq_scale(struct clocksour=
ce *cs, u32 scale, u32 freq
 	}
=20
 	/*
-	 * If the uncertainty margin is not specified, calculate it.
-	 * If both scale and freq are non-zero, calculate the clock
-	 * period, but bound below at 2*WATCHDOG_MAX_SKEW.  However,
-	 * if either of scale or freq is zero, be very conservative and
-	 * take the tens-of-milliseconds WATCHDOG_THRESHOLD value for the
-	 * uncertainty margin.  Allow stupidly small uncertainty margins
-	 * to be specified by the caller for testing purposes, but warn
-	 * to discourage production use of this capability.
+	 * If the uncertainty margin is not specified, calculate it.  If
+	 * both scale and freq are non-zero, calculate the clock period, but
+	 * bound below at 2*WATCHDOG_MAX_SKEW, that is, 500ppm by default.
+	 * However, if either of scale or freq is zero, be very conservative
+	 * and take the tens-of-milliseconds WATCHDOG_THRESHOLD value
+	 * for the uncertainty margin.  Allow stupidly small uncertainty
+	 * margins to be specified by the caller for testing purposes,
+	 * but warn to discourage production use of this capability.
+	 *
+	 * Bottom line:  The sum of the uncertainty margins of the
+	 * watchdog clocksource and the clocksource under test will be at
+	 * least 500ppm by default.  For more information, please see the
+	 * comment preceding CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US above.
 	 */
 	if (scale && freq && !cs->uncertainty_margin) {
 		cs->uncertainty_margin =3D NSEC_PER_SEC / (scale * freq);


