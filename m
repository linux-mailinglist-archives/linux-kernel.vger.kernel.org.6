Return-Path: <linux-kernel+bounces-208598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E690270B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198322815B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58854157496;
	Mon, 10 Jun 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aaFg6+3c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+jMmRPvo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC60156F5C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037771; cv=none; b=Y3Ea2ayOw+Z1Wqpbe1sTAqLhwTYkHRxw/M9izYZsTTR7+2o+yBFzV5eD2YSQN9gZZFUd1WxvQxfqkEtErhOgTTOGVayZ2bZaAVH5BcWFqgIp3+8GTs4jjB0hxlU24Pz3D7+9igL4vrjKOodZndGRsUQFRH2Stmz33M9EjhhYK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037771; c=relaxed/simple;
	bh=hYNVuSguWX5kL+feRx+7A+qZ1CJIoDAjlsCoswgjWkw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MQNV1LGBM2iIJ2cBXS+jUA73AjLIeTJ0PdzOehfsSH+tWh04av9jbpl/zdllwAFHPGwEt81NoSijcxXWE1CbltOJ5qRkAOmxbxoMmVlKW6u/zdmFINDl6AE0Rc/AERWnIp4yTLS/lcgmAeRCF4NaLHA9GqSQk3YEIphzhLhWsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aaFg6+3c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+jMmRPvo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.606874728@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aNS2WvbMpSrKZ+gyfUquRBBrzhJQZEx4EROddFmkK80=;
	b=aaFg6+3cICoZrAclQf9VXJb4U69oBHrt517hxlQObtG7pHFeIyQwjMrYeQ7/cL4PHOcBxm
	w0o+j8EH653Y41xDvCq0vkNOPUPsa89qG8ng4YnwUhVj0AS82yEW6JMuKUe0YNmRvy2GQ0
	hDyi855Xq0EYXJjzgxnqAZeR3NLaF6MmG8j5sZl1DAaWL0DB2YrIXUCgOuSd/wOy7LSWNV
	jDKBosfYtbMhYNG1NofnOFccYhaKpKiJ5EbEKhjlfFqcB4kzTiiy+YOWmo8hXUVQuOFeBo
	ZaWWpXb30kk6Z5VI+EJ30J8rhdlSxNSL237ZsDetHVUqh1W0JY1LcAFggmZm5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aNS2WvbMpSrKZ+gyfUquRBBrzhJQZEx4EROddFmkK80=;
	b=+jMmRPvoCmehn8UIzWW7nU2Oh+DDhDlNr3G6pXEyK017UnEX34UKLhH+BwxIQnDfzqqkmX
	i+cUSDSlc9vKwADA==
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
Subject: [patch V3 34/51] posix-timers: Make signal overrun accounting
 sensible
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:47 +0200 (CEST)

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Make the accounting in send_sigqueue() consistent with that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1965,6 +1965,34 @@ int send_sigqueue(struct sigqueue *q, st
 	 */
 	q->info.si_sys_private = si_private;
 
+	/*
+	 * Set the overrun count to zero unconditionally. The posix timer
+	 * code does not self rearm periodic timers. They are rearmed from
+	 * dequeue_signal().
+	 *
+	 * But there is a situation where @q is already enqueued:
+	 *
+	 * 1) timer_settime()
+	 *      arm_timer()
+	 * 2) timer_expires()
+	 *      send_sigqueue(@q)
+	 *        enqueue(@q)
+	 * 3) timer_settime()
+	 *      arm_timer()
+	 * 4) timer_expires()
+	 *      send_sigqueue(@q) <- Observes @q already queued
+	 *
+	 * In this case incrementing si_overrun does not make sense because
+	 * there is no relationship between timer_settime() #1 and #2.
+	 *
+	 * The POSIX specification is useful as always: "The effect of
+	 * disarming or resetting a timer with pending expiration
+	 * notifications is unspecified."
+	 *
+	 * Just do the sensible thing and reset the overrun.
+	 */
+	q->info.si_overrun = 0;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
@@ -1972,15 +2000,9 @@ int send_sigqueue(struct sigqueue *q, st
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
-		/*
-		 * If an SI_TIMER entry is already queue just increment
-		 * the overrun count.
-		 */
-		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;


