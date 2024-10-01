Return-Path: <linux-kernel+bounces-345537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4DF98B754
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94ED2B25B64
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6E19F474;
	Tue,  1 Oct 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XBkjREkZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/0Nwl1NU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAA19F125
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772135; cv=none; b=BNHq0RBawD/I8IZiKr7/PONwoM6Q3WO2LOVjTeyXVS+WhvjFmNCg5k8kmUKNqI+mvx6Q1EjjWcQButtQ517y28TboAr41xdKmItg5UTYd/Kk7siB5GhQW0swQRwr+9FX5drXDwyM2FVfQf/PJQgafRh3ZrQB5P5lwH1cllDo+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772135; c=relaxed/simple;
	bh=AEiot9FztQ13Wj30VxZ4rIX1Z97/r+X89CCBUXoiuz0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JQMEi49iByl+paj+kLus0Jdn62bV1yM6rlvihZASvwkTZJTCy98KN5MrJ8SFVfkAhCXKxvclzZJGomr+nF+q+0AeNTM5xv5CVgthGwJL371RNFv86lLWkEJ+A+UD0f/42V9RikKM8AOE24zzFrLN88LPqnLdGPoTEesn6GgGSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XBkjREkZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/0Nwl1NU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.790542522@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fGGpvUvjuTFoEqWI2WeRDpfCt8hIp9FqKEHSvmTlWgc=;
	b=XBkjREkZrn3gNKRsVffYhXLtvUaARO6gI53WHJHBrHPtVYy3imWHj2XV9AngJhT0QdzT2s
	dW+Fi92s3tm5WLWaDuX4w3lHDmAvRxsPB5pT+zKX1JAEmTgl3Jqv640IYVxfM07vXVJWY/
	gTxz001rYMjeM0fOWMQQs21GZtXJNBXNvAwejp3aY1e/3flCwOw4U6oWPXysytxxKeFQ8L
	3ajES3hdFvcsSEWNx+5EkTed6reaArZrQhCQtKfB7LYWDIjjPAckc/0+YWanxRpFVAP8JV
	sJ/EdQMJwuGnWOCqfqIVs3E+Qfc6LEGPiFWktC/ouFBPXvBZGoGL5X6tk/84Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fGGpvUvjuTFoEqWI2WeRDpfCt8hIp9FqKEHSvmTlWgc=;
	b=/0Nwl1NUyYF3Vz2FB+W2cDgGDIg/AxM9FchY/7wrQF4100SQNWbJkTZrAYAIMVLHb7iUpf
	ZFen2xC3la8ZuNAQ==
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
Subject: [patch V5 09/26] posix-timers: Make signal overrun accounting
 sensible
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:12 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Make the accounting in send_sigqueue() consistent with that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/signal.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)
---
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1961,6 +1961,34 @@ int send_sigqueue(struct sigqueue *q, st
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
@@ -1968,15 +1996,9 @@ int send_sigqueue(struct sigqueue *q, st
 
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


