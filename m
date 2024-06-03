Return-Path: <linux-kernel+bounces-199373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B2E8D8633
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D81E1C21B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C2130A68;
	Mon,  3 Jun 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDT5G8/+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE4882B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429056; cv=none; b=uiiANW2rxOwXMw9pJSUtLCSeszNP5zvo1bk28nnUAIp3m/6ApELPKHNb3tJvBFsKOahfVHGX20o0I0xDLiF6mMt9G3Zs3lCQDwRd7olIx12tNP7nikJ2W+JcCGcwo7aZ/np1whwm3qvqO0uZvA42p+gFbQgd3XQR0wo9VC96ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429056; c=relaxed/simple;
	bh=H02pkg0cMo/O8ZymvJcklLrUWLpS0iRiFxI+1Per87Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUl5cEfegZykl9hRZEdy6iU1nhCMke12geioocFJ5YnTc1j3l7Izr8IadRRNlzdRIDBFuT6LgYzneuwWu6dpnVi3g4M94Ll+AeJN3g9ZOr76BpvbXW1qLC7PSnWfI5ZUqqxFyxBcMRgd1GeJV5eKEdyt8CZ6KaU+7eJdfHcvekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDT5G8/+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717429053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhdofQNjL+lCEu875vUgkpWMiLC309LRMUAE+8RleL8=;
	b=CDT5G8/+SnCvNg/R83JuCJfUbfkXfWEe4dSWRiTJ8RkKOMmDJ7sSqDE91NFHZCX03ayU5P
	A4gWXPpGymEVdcRkfMv1DTpKkjQpFrvFJ9+bsob/f1e1F9dsC+RVCbG5pl/Egqd7TzGYlC
	Y/Kr+yyt04CQTro3bPqJzFqhagCgqhM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-qBjBMv9tO8uM6_WGQghMQw-1; Mon,
 03 Jun 2024 11:37:30 -0400
X-MC-Unique: qBjBMv9tO8uM6_WGQghMQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D2163806703;
	Mon,  3 Jun 2024 15:37:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.103])
	by smtp.corp.redhat.com (Postfix) with SMTP id 41103404F585;
	Mon,  3 Jun 2024 15:37:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Jun 2024 17:36:00 +0200 (CEST)
Date: Mon, 3 Jun 2024 17:35:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tick/nohz_full: turn tick_do_timer_boot_cpu into
 boot_cpu_is_nohz_full
Message-ID: <20240603153557.GA8311@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <20240530124032.GA26833@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530124032.GA26833@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We don't need to record the cpu number of the nohz_full boot CPU, a simple
boolean is enough. We could even kill it, the "else if" branch could check
tick_nohz_full_cpu(tick_do_timer_cpu) && !tick_nohz_full_cpu(cpu).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/time/tick-common.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 27d0018c8b05..82c1b2206631 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -49,15 +49,6 @@ ktime_t tick_next_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
-#ifdef CONFIG_NO_HZ_FULL
-/*
- * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
- * tick_do_timer_cpu and it should be taken over by an eligible secondary
- * when one comes online.
- */
-static int tick_do_timer_boot_cpu __read_mostly = -1;
-#endif
-
 /*
  * Debugging: see timer_list.c
  */
@@ -192,6 +183,7 @@ static void tick_setup_device(struct tick_device *td,
 	 * First device setup ?
 	 */
 	if (!td->evtdev) {
+		static bool boot_cpu_is_nohz_full __read_mostly;
 		/*
 		 * If no cpu took the do_timer update, assign it to
 		 * this cpu:
@@ -199,18 +191,14 @@ static void tick_setup_device(struct tick_device *td,
 		if (READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
 			WRITE_ONCE(tick_do_timer_cpu, cpu);
 			tick_next_period = ktime_get();
-#ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case the
 			 * first housekeeping secondary will take do_timer()
 			 * from us.
 			 */
-			if (tick_nohz_full_cpu(cpu))
-				tick_do_timer_boot_cpu = cpu;
-
-		} else if (tick_do_timer_boot_cpu != -1 &&
-						!tick_nohz_full_cpu(cpu)) {
-			tick_do_timer_boot_cpu = -1;
+			boot_cpu_is_nohz_full = tick_nohz_full_cpu(cpu);
+		} else if (boot_cpu_is_nohz_full && !tick_nohz_full_cpu(cpu)) {
+			boot_cpu_is_nohz_full = false;
 			/*
 			 * The boot CPU will stay in periodic (NOHZ disabled)
 			 * mode until clocksource_done_booting() called after
@@ -221,7 +209,6 @@ static void tick_setup_device(struct tick_device *td,
 			 * check in tick_periodic() but this race is harmless.
 			 */
 			WRITE_ONCE(tick_do_timer_cpu, cpu);
-#endif
 		}
 
 		/*
-- 
2.25.1.362.g51ebf55



