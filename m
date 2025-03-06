Return-Path: <linux-kernel+bounces-549274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29CAA5502E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABE516A0E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215BF20F062;
	Thu,  6 Mar 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQzlOYca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3519B5B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277199; cv=none; b=M+Gg4Ff+PpfEK6/sKIiFTGSLT6lnp2T66gvMrVIzfKIyDSIcANlRyzs5EjxpmnlK15jnxCc6684Jax36/09qNNV6OwRNfduvvNIuPmmZYkLMofQUuA3ivpuAyOfjrDmxVFrSzQESOelDxXa00LKd3Y3U/RHCT2RjhqOD3G0jK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277199; c=relaxed/simple;
	bh=koXrdMPK6dIUrbvgZsVwTyFa33Z4wZ9XXfnyfmcllNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VGMF+ewslAQ5idQt4JqtWOwVm7ALBIRqghqBfnby3QOua9JtZ/Pq7xrIoK/aJRQ9I8y2t95BAYlk0+Ah7ZhKVjGdT7BI5XGuDkbfmrvRWLwCaCbYdKLxHCmtYUyU0d9uGls455Q9P/UkcCidKsgPHjpkcH/y/K8djXSbkTJVjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQzlOYca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C69EC4CEE0;
	Thu,  6 Mar 2025 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741277199;
	bh=koXrdMPK6dIUrbvgZsVwTyFa33Z4wZ9XXfnyfmcllNk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=oQzlOYcaCnE6clpc5hAD2+wD6S8ylSsjfzkzYpSRKf0b3Tipq7f0D0lhxcuPnEqAF
	 mKim3BEK/ssc4h+hRcNQbts12/XELS8DYtknOJY0AKgvsIkBHLyxqBkEoAfWW+VBmw
	 o8YVcI2nBmD7fhRh4m+2IRSSlwv3xK91Tynra5g/ZSAMzIP5C6wsILplZc9Bhsamh2
	 uroJN2nAFEb465R/rlAIkJfsyfpLzO3slJiPoR9+x4dlbvccMFiAJU5vXh03Sd5PV+
	 NyhAPLfALDS2TlNNXUZb2AOeyq2bdhQSfNQCcnp/tPqYlYerOD3dvXBxoLNZFeSH2W
	 edNK3q0PVG03A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3D0ECE13D4; Thu,  6 Mar 2025 08:06:38 -0800 (PST)
Date: Thu, 6 Mar 2025 08:06:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
	christian@heusel.eu, kernel-team@meta.com
Subject: [PATCH v2] clocksource: Defer marking clocksources unstable to
 kthread
Message-ID: <11d36fdd-55c2-4f3b-96b1-dd442f759ba0@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The clocksource watchdog marks clocksources unstable from within a timer
handler.  On x86, this marking involves an on_each_cpu_cond_mask(),
which in turn invokes smp_call_function_many_cond(), which may not be
invoked from a timer handler.  Doing so results in:

WARNING: CPU: 3 PID: 0 at kernel/smp.c:815 smp_call_function_many_cond+0x46b/0x4c0

Fix this by deferring the marking to the clocksource watchdog kthread.
Note that marking unstable is already deferred, so deferring it a bit
more should be just fine.

Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/all/46a200b4-1293-413c-8b73-37f7b50abd1a@heusel.eu/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
---
V1 -> V2: Fixed subject line.

 include/linux/clocksource.h |    1 +
 kernel/time/clocksource.c   |   16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41471c39..a5317a4c07990 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -149,6 +149,7 @@ struct clocksource {
 #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
 #define CLOCK_SOURCE_RESELECT			0x100
 #define CLOCK_SOURCE_VERIFY_PERCPU		0x200
+#define CLOCK_SOURCE_DEFERRED_UNSTABLE		0x400
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7304d7cf47f2d..60ace6f64c761 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -201,7 +201,8 @@ static void clocksource_change_rating(struct clocksource *cs, int rating)
 
 static void __clocksource_unstable(struct clocksource *cs)
 {
-	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
+	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG |
+		       CLOCK_SOURCE_DEFERRED_UNSTABLE);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
 	/*
@@ -215,6 +216,11 @@ static void __clocksource_unstable(struct clocksource *cs)
 
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
+}
+
+static void __clocksource_deferred_unstable(struct clocksource *cs)
+{
+	cs->flags |= CLOCK_SOURCE_DEFERRED_UNSTABLE;
 
 	/* kick clocksource_watchdog_kthread() */
 	if (finished_booting)
@@ -236,7 +242,7 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	if (!(cs->flags & CLOCK_SOURCE_UNSTABLE)) {
 		if (!list_empty(&cs->list) && list_empty(&cs->wd_list))
 			list_add(&cs->wd_list, &watchdog_list);
-		__clocksource_unstable(cs);
+		__clocksource_deferred_unstable(cs);
 	}
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
@@ -453,7 +459,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		if (read_ret == WD_READ_UNSTABLE) {
 			/* Clock readout unreliable, so give it up. */
-			__clocksource_unstable(cs);
+			__clocksource_deferred_unstable(cs);
 			continue;
 		}
 
@@ -538,7 +544,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 				pr_warn("                      '%s' (not '%s') is current clocksource.\n", curr_clocksource->name, cs->name);
 			else
 				pr_warn("                      No current clocksource.\n");
-			__clocksource_unstable(cs);
+			__clocksource_deferred_unstable(cs);
 			continue;
 		}
 
@@ -703,6 +709,8 @@ static int __clocksource_watchdog_kthread(void)
 
 	spin_lock_irqsave(&watchdog_lock, flags);
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
+		if (cs->flags & CLOCK_SOURCE_DEFERRED_UNSTABLE)
+			__clocksource_unstable(cs);
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			list_del_init(&cs->wd_list);
 			clocksource_change_rating(cs, 0);

