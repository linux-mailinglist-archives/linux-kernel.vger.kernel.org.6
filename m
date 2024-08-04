Return-Path: <linux-kernel+bounces-273861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB64D946EF1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32B21F22012
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6FA142E70;
	Sun,  4 Aug 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkWN0vhw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sZ74lISZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56B13F42A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776581; cv=none; b=RFzeQd/rsCWevFYZ1KzAARrY56gPRnwRTo/P5LCRzSQPlreCrvBGHGX9Wltr3fEeKPDemAb0OQr3Klj9wZxiYblhRfOQUMHqSOwrTKacQhf4+lAhf8u3bK3i2xPWE46kLMHM6j0TuybVI/qC14ajJfMiOHJkmpaqEdXdioZJiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776581; c=relaxed/simple;
	bh=cv5jhrnkMSdTe8xi9xcBFipMrPR/K6HlOLR4NxwhHew=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=KQ+sJXtU81Aa7qPSFOoaKgRg+hQo6ofm18cWopXehhXYRXeftkQld+RDr+wnkSdqpan63DeJs9+e27UPopL9Oy6Lv/xUr8a0ozMWlQQ3MAX/uZDNqMyPF9mabvCBM9CtCm5k5J9/h5JdFYhp8AgOQjfGGfvmQMdCB1vDWS9zl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkWN0vhw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sZ74lISZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722776579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=MKCsVnun+N4PElpLRtcHodLQZ31FKjpwvkCTuzyXMlg=;
	b=pkWN0vhw+o+cYsFR5Dr5WdRXVQezduQNyXaPG2rHSluTpIKfSFwy/LATdIv2rf0E/iAMJ+
	tYZBNsoTLoiMoywdv0Fx9YM+kV/K+juL2oJLnB3Cpm7BI0gMQbVhU3VgUujVjVjoNdYx/Q
	7TgHNSbmNrSkG0tYx9dUq8eY9C6McFYS5r9BhQTQq4FfJIRkMFe7i4mMzW1QTEeD6Xpm/d
	qVO9aAPQgmVHsbu0ryHAe9Eeg/vX2k8yt1LPAaWX4HINFkW9ZVIwD21hnK78St5Jhv4lXO
	l/wJsp0vJ4HXOL58VOXKyCUSdL2RjTrgr2xOtUz0HYT8rSAsGLD7R2Adn66w7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722776579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=MKCsVnun+N4PElpLRtcHodLQZ31FKjpwvkCTuzyXMlg=;
	b=sZ74lISZ7Rs/myl90DupRQUiuqN6AAfNAo1bRLD4GF96LhxTTFWgxcvKY4TU93sgZPinEb
	YXWd/IbiTtH95RAA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v6.11-rc2
References: <172277654174.866296.10517632866315552419.tglx@xen13>
Message-ID: <172277654786.866296.7434610502723586152.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  4 Aug 2024 15:02:58 +0200 (CEST)

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
24-08-04

up to:  f2655ac2c06a: clocksource: Fix brown-bag boolean thinko in cs_watchdo=
g_read()


Two fixes for the timer/clocksource code:

    - The recent fix for making the take over of the broadcast timer more
      reliable retrieves a per CPU pointer in preemptible context.
      This went unnoticed in testing as some compilers hoist the access into
      the non-preemotible section where the pointer is actually used, but
      obviously compilers can rightfully invoke it where the code put it.

      Move it into the non-preemptible section right to the actual usage
      side to cure it.

    - The clocksource watchdog is supposed to emit a warning when the retry
      count is greater than one and the number of retries reaches the
      limit. The condition is backwards and warns always when the count is
      greater than one. Fixup the condition to prevent spamming dmesg.



Thanks,

	tglx

------------------>
Paul E. McKenney (1):
      clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

Thomas Gleixner (1):
      tick/broadcast: Move per CPU pointer access into the atomic section


 kernel/time/clocksource.c    | 2 +-
 kernel/time/tick-broadcast.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d25ba49e313c..d0538a75f4c6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -246,7 +246,7 @@ static enum wd_read_status cs_watchdog_read(struct clocks=
ource *cs, u64 *csnow,
=20
 		wd_delay =3D cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <=3D WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >=3D max_retries) {
+			if (nretries > 1 && nretries >=3D max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before succe=
ss\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index b4843099a8da..ed58eebb4e8f 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,7 +1141,6 @@ void tick_broadcast_switch_to_oneshot(void)
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
-	struct tick_device *td =3D this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
=20
@@ -1167,6 +1166,8 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 		 * device to avoid the starvation.
 		 */
 		if (tick_check_broadcast_expired()) {
+			struct tick_device *td =3D this_cpu_ptr(&tick_cpu_device);
+
 			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
 			tick_program_event(td->evtdev->next_event, 1);
 		}


