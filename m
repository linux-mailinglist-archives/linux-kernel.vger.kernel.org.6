Return-Path: <linux-kernel+bounces-259240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F220A939315
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE228238B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2873F16F281;
	Mon, 22 Jul 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hf0RJrQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+12s/A5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561E16EB44
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668790; cv=none; b=ZPu7KYNE9Y/wj/DV7qIx82ZEByPiq7SDIRVfWSfQP3IN/Qt/7NkiAP7X+dZSqq/DkoKCLsrnYePA7d2+vg99p6KycY9GfaiEfTuQ2pzfTXcMh/e/eem750x6FcijwN+hvp88sd7J57CWkN18WJW8C8KhdpN7MNgQ14AeY5CuQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668790; c=relaxed/simple;
	bh=XnATik6cxgSBQomo+Y77x9GvHXh59HU0zmFsjquhHBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWIwS7XTdwQ3Q//nwrVKFO8RJRztExUPy+tEGczz2hMnS07bv7BGIvPDjjZ9eKSVRnWxlhTtFbrmJ2ieiRFwgAntEWH0uUCv6qLA+gkfoFTe99EYjdxdmyQIGALwZLlgwi62BK0yjpp7u0IdQvDVFZLCOPjhUi5Tu7MULSZ7030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hf0RJrQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+12s/A5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5+IoeYj/HBpqJqJrR+C44gazCIq5k30FQfC4+nSAcs=;
	b=4hf0RJrQVGC4JHeY1Na50NUoSKiAOL0MrXklC77vrOD7Z9LH94e2XuRxRRhpTcguIvxyIP
	W59yOiFyyV4hPJI2kwUp0eX6hJNjNnUhzfvEyW6DE+vlbpNvjnrz8jSdlrSt2pJCLGk1nA
	RAt1XuuN+26kFNTDdTDFNd2m21kJ6fGSKMYwz/KrbRteHqcM8ep85vprFcE3Ex7pYHcV6O
	I8595vNHExBT6A0i6VXmvjqC2otxitN7vK29PdWb9T6XppFVOw8GELbdh9lkh0qXVu7yH0
	/tGj00hV2nc9StWcmteo9Pv45U+n2OGMaoZUa9pdFuTeI+2eTnu6wnh75Ca6mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5+IoeYj/HBpqJqJrR+C44gazCIq5k30FQfC4+nSAcs=;
	b=S+12s/A5L0otdcT7czT/g79126aA0y/mtAfVTXGyVhMIqJEn21JO6YKy2PmD/R6aI4voO9
	w2wDx39iUaE2nOCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 04/19] printk: nbcon: Clarify rules of the owner/waiter matching
Date: Mon, 22 Jul 2024 19:25:24 +0206
Message-Id: <20240722171939.3349410-5-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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
---
 kernel/printk/nbcon.c | 56 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 18a83d181622..db1685a6d5cd 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -241,6 +241,13 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
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
 
@@ -272,18 +279,29 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
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
@@ -591,11 +609,29 @@ static bool nbcon_owner_matches(struct nbcon_state *cur, int expected_cpu,
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


