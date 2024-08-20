Return-Path: <linux-kernel+bounces-293335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8607E957E27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BD61F245D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B21E4F0C;
	Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Vr8xKv4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQqy5mwr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0931DF686
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135410; cv=none; b=IxHatbAHXL7AdIZi/or6qZCw2dYxKhVoqCJRX5BEoch2bVrhwcsctyWGy/POlWhq42cx+yxa0PSTCxIhYH0p5bcTFQ1qqF+aHXgps6eNZoMzMEg+cyF9ijGNvUyatTrPyj6uXRTF2feXrmcijhI82QPN9pjo2d5r3QITX81T3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135410; c=relaxed/simple;
	bh=w/0A+I2P64NXX1ai/t0T7MSBWwFyXQZvqP6UKKp/3BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EXUwEJ4KXw3Y+zL6+bmBCgLcg6H2GRVeH2OWHmg26BXhD/Ps5jPl56BVv6MO5DQ1vyS2JTiZalqDfqU2HoO34PuchsMUvI/x/rndHP8c/rfyBT5uORjRDonVcp9IBuUkh6dfANpJw9NWeARqSMIL6eHluOhLbi00DCv0P4rL/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Vr8xKv4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQqy5mwr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV1vJv860Ihcd3WShe7ztkuucPJuixldc8WjZwKIQZw=;
	b=2Vr8xKv4kCs8Bz0Ups8ZooMxF/dCGumZSwA3ACWVtSMIb52iFYYS+He93jZNM6adyqFUHt
	n5BD9V5gubAEFvmKK1IevhwL2nS+bjdVIhqvWut5NB/eHE3ArYAPOVsrRhLcHsXbsKquY9
	AWN1kSD6h3m/dvCvmWxjQMw6FA3Nlvhif0NFDwGU9SvHLPwBo7b9Eq6Vn/lVFgp3iaUJpR
	cqFml3IF57V4+xj/f3jKZ4wuSvZVdEB2XreQ4mrWmerkGFoedi0x5GucZLt+cEuwVMLXmC
	wMc2Tt5A5F228rsx7zROzREZsiJ9Syaxr0qg1F5kmkTNe+fePsWVcJoNgCQoxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV1vJv860Ihcd3WShe7ztkuucPJuixldc8WjZwKIQZw=;
	b=LQqy5mwrr2t6k/PlP2sjXxQ+2MgvblrIYL8g+n2ZYeu23HjiypJRoCx3d+RZo5j4A3Ijsb
	SNN7I12aAmJ6/YAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 05/35] printk: nbcon: Clarify rules of the owner/waiter matching
Date: Tue, 20 Aug 2024 08:35:31 +0206
Message-Id: <20240820063001.36405-6-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions nbcon_owner_matches() and nbcon_waiter_matches()
use a minimal set of data to determine if a context matches.
The existing kerneldoc and comments were not clear enough and
caused the printk folks to re-prove that the functions are
indeed reliable in all cases.

Update and expand the explanations so that it is clear that the
implementations are sufficient for all cases.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 56 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 776746d20fc0..931b8f086902 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -228,6 +228,13 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 	struct nbcon_state new;
 
 	do {
+		/*
+		 * Panic does not imply that the console is owned. However, it
+		 * is critical that non-panic CPUs during panic are unable to
+		 * acquire ownership in order to satisfy the assumptions of
+		 * nbcon_waiter_matches(). In particular, the assumption that
+		 * lower priorities are ignored during panic.
+		 */
 		if (other_cpu_in_panic())
 			return -EPERM;
 
@@ -259,18 +266,29 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
 	/*
 	 * The request context is well defined by the @req_prio because:
 	 *
-	 * - Only a context with a higher priority can take over the request.
+	 * - Only a context with a priority higher than the owner can become
+	 *   a waiter.
+	 * - Only a context with a priority higher than the waiter can
+	 *   directly take over the request.
 	 * - There are only three priorities.
 	 * - Only one CPU is allowed to request PANIC priority.
 	 * - Lower priorities are ignored during panic() until reboot.
 	 *
 	 * As a result, the following scenario is *not* possible:
 	 *
-	 * 1. Another context with a higher priority directly takes ownership.
-	 * 2. The higher priority context releases the ownership.
-	 * 3. A lower priority context takes the ownership.
-	 * 4. Another context with the same priority as this context
+	 * 1. This context is currently a waiter.
+	 * 2. Another context with a higher priority than this context
+	 *    directly takes ownership.
+	 * 3. The higher priority context releases the ownership.
+	 * 4. Another lower priority context takes the ownership.
+	 * 5. Another context with the same priority as this context
 	 *    creates a request and starts waiting.
+	 *
+	 * Event #1 implies this context is EMERGENCY.
+	 * Event #2 implies the new context is PANIC.
+	 * Event #3 occurs when panic() has flushed the console.
+	 * Events #4 and #5 are not possible due to the other_cpu_in_panic()
+	 * check in nbcon_context_try_acquire_direct().
 	 */
 
 	return (cur->req_prio == expected_prio);
@@ -578,11 +596,29 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
 				int expected_prio)
 {
 	/*
-	 * Since consoles can only be acquired by higher priorities,
-	 * owning contexts are uniquely identified by @prio. However,
-	 * since contexts can unexpectedly lose ownership, it is
-	 * possible that later another owner appears with the same
-	 * priority. For this reason @cpu is also needed.
+	 * A similar function, nbcon_waiter_matches(), only deals with
+	 * EMERGENCY and PANIC priorities. However, this function must also
+	 * deal with the NORMAL priority, which requires additional checks
+	 * and constraints.
+	 *
+	 * For the case where preemption and interrupts are disabled, it is
+	 * enough to also verify that the owning CPU has not changed.
+	 *
+	 * For the case where preemption or interrupts are enabled, an
+	 * external synchronization method *must* be used. In particular,
+	 * the driver-specific locking mechanism used in device_lock()
+	 * (including disabling migration) should be used. It prevents
+	 * scenarios such as:
+	 *
+	 * 1. [Task A] owns a context with NBCON_PRIO_NORMAL on [CPU X] and
+	 *    is scheduled out.
+	 * 2. Another context takes over the lock with NBCON_PRIO_EMERGENCY
+	 *    and releases it.
+	 * 3. [Task B] acquires a context with NBCON_PRIO_NORMAL on [CPU X]
+	 *    and is scheduled out.
+	 * 4. [Task A] gets running on [CPU X] and sees that the console is
+	 *    still owned by a task on [CPU X] with NBON_PRIO_NORMAL. Thus
+	 *    [Task A] thinks it is the owner when it is not.
 	 */
 
 	if (cur->prio != expected_prio)
-- 
2.39.2


