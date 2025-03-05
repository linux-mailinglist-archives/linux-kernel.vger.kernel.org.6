Return-Path: <linux-kernel+bounces-547403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35397A5069F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B018189236B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82624EA88;
	Wed,  5 Mar 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCOW695T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF161FFE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196591; cv=none; b=F68l2gT/bVxeC4+kJ+ddGvXBUYWY2MteDZitdV3MXsSuP4INAbu2LeTln/IzIkV15FxLlRDIK5HDzA4nvPrlKwG7OiuserspwIeOhvs4SrmtwOv0LEd3aVjGvetXdDVf+VRob1M0fvbMYHob0ZGVqXmh+Dx7JiT6DIZ8F7U36vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196591; c=relaxed/simple;
	bh=G+e6+D8oZKd+mzrIJuax07EDHsOLu98NekRGvxRXWHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mz7C+Hj20hkxg/CT/Fvrx2nSjy3+MqE9iQ+6d71Q77ph7afEKsCDY5ZXuA/E04+w0/zoZw0iAE2PTuPBeCfq3y9dNGGpBQRS98nmCCBhRSREdAJyR0y1Sx6uuoM3JmDWqBAuAq5O6YGcg9JN9VdgzRP229ONXFa/skyvFR36TNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCOW695T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7910DC4CED1;
	Wed,  5 Mar 2025 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196590;
	bh=G+e6+D8oZKd+mzrIJuax07EDHsOLu98NekRGvxRXWHo=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=aCOW695TfHiMlg5GKYUWrGI3E+XoaoMo0oop+pd20iFSduE9GHYn37X3ULri+xLQ1
	 t7gdO7uDu90S42sMOS+/sehJ3XQ1HORmuOO58TLjM72YIBuBr8ZzR4qnU+0TEEB18x
	 caTIQFvnA71JkIp5sJ9WnremF2ROvsUF2F8H1JrGzY11FkymNrV7c/pk+Seukw/t+C
	 0ML60Snwl4ITkmCrWY4sqgxjMF+UBmV8Zvf9+J5wSd7wUezmEP01DNLD/uzyVnG+QB
	 Jaen4tAJsH2pN+BQixDwxn3Y4knmqpLn6Kk7iv5X8H974va4+6sb1eV7jiluchjGT8
	 nX3GrOi+6GKIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0DD1BCE0546; Wed,  5 Mar 2025 09:43:10 -0800 (PST)
Date: Wed, 5 Mar 2025 09:43:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
	christian@heusel.eu, kernel-team@meta.com
Subject: [PATCH clocksource] Defer marking clocksources unstable to kthread
Message-ID: <f6bb6dd3-7183-42db-8e7e-c9103c0bd5ff@paulmck-laptop>
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

