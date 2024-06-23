Return-Path: <linux-kernel+bounces-226076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F349139E7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8569D1C20B04
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AB74BEC;
	Sun, 23 Jun 2024 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zHasFf7t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="adwvCE6Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1F63D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141368; cv=none; b=NwiESUzHvPzF8gTNPjNH/ZWDPf6tjlr20utOLwzSG+MhLv1N4oaLYeSGpApzQBDrVA5iL5Vy/qaHSRWSN7fsegZUL/RGyZew/1EKJ4AbkobdnRGefyjvDgjKS+2mFdGCCHXkwWpyhh2dHxvVxKfg3ZWgbnXPA0sPV8amXCv8nCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141368; c=relaxed/simple;
	bh=eQ9SkVzRA8uuQF0j+9HUIp55xGDAmONAhLnzCO+XxoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXSpY6ydDRJffFZwyzSzZCmisQ4kYjt1bEIAP9HT6i1uPmbigGxIKqV5Iw4EU2J94N61rU502+Iy0zvgtf5+GKtpvwsGRfLUVrZDZwH2rIWtZg4kf68AHsRcGONIbnqMLDlC8yGgL9sm+7+nPukOcSITAIyUVhqDygA4XB5nLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zHasFf7t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=adwvCE6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719141363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaUB9B93eRQsIY/06QomImy+ydUVyqmVioodX/NuWMA=;
	b=zHasFf7tcZicHnkGYSE5yYTH5h0Uc/BkjeAOHmbmfYP3HTh8H4EH38fWLbLrgClayl/Upd
	fKGq3AKhOnLYO9uj/B7bDMlZSxgz1OCrJWR0eOwkNhpRBWI5whg3ZPa76KoiT9aO2an0B1
	S3B+oWuUFzMCd2527E2U5ql6GrMDkXYZM6p2QxjjCA03ZM/Ym6BHMVOJH5+DBoVlyVZ3rs
	nIn7xlMCJYxVuH4+H9MPAdbl6txq1jwusk5YJb4JD/GmLVmAg7ZS9ED1u5I2Pqd3SiStDd
	GLRUsbC7/BiTKIrMUDkkFhkWomLKa7B/hnatc81CHPbRmL6uMmB7oJLylWvc0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719141363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaUB9B93eRQsIY/06QomImy+ydUVyqmVioodX/NuWMA=;
	b=adwvCE6Q3PwNc6r7+zmjV+cvCgHZFlR5KfyjllpDImHXLgJ5c2EE7tAJJ6+KBihWFP6bNE
	PpO2ioq6W56Xp7DA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg Nesterov
 <oleg@redhat.com>
Subject: [patch V3-2 11/51] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
In-Reply-To: <20240610164026.162380808@linutronix.de>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.162380808@linutronix.de>
Date: Sun, 23 Jun 2024 13:16:02 +0200
Message-ID: <87wmmfyknh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
timer_get(), but the posix CPU timer implementation returns 1 nsec.

Add the missing conditional.

This will be cleaned up in a follow up patch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3-2: Fix the split up fallout - Frederic
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -623,6 +623,7 @@ static void cpu_timer_fire(struct k_itim
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
@@ -706,7 +707,16 @@ static int posix_cpu_timer_set(struct k_
 				old_expires = exp - val;
 				old->it_value = ns_to_timespec64(old_expires);
 			} else {
-				old->it_value.tv_nsec = 1;
+				/*
+				 * A single shot SIGEV_NONE timer must return 0, when it is
+				 * expired! Timers which have a real signal delivery mode
+				 * must return a remaining time greater than 0 because the
+				 * signal has not yet been delivered.
+				 */
+				if (sigev_none)
+					old->it_value.tv_nsec = 0;
+				else
+					old->it_value.tv_nsec = 1;
 				old->it_value.tv_sec = 0;
 			}
 		}

