Return-Path: <linux-kernel+bounces-345538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F298B755
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1871B25BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A49A19FA98;
	Tue,  1 Oct 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJVB0Z/f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfL7KSwA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117419F430
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772136; cv=none; b=lr+QUY2ZkZfbkGinLCMfvPcubUyCSCumhUobJ35XDjOu6i585/NQWZndy4c7NKMLTqb0cvKWHi+0horb0JXIb55txntv0TEB5q2froUQKCyQ3WgWuxcn4LWftLy6qjO+P/YblrTgnBO8uZEkTjEnc1lijuOy+h/7L5I0UaP1q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772136; c=relaxed/simple;
	bh=+2fIijOLWcSBLiaSrFrK6FdMUB/dFmsW0E5g8XCruQY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DoI2AOidPeWf9gZXUbcSkGSfLynaTwMbsQ7U3QCbms8yU9h79i5POG4YagEO8/FGSaBrKiw+rzR9hpSGwfN9koUfJ7r96C1gijV+PBbnll3rttLZuSMK4cpg6hSNpIFziFrAGKdKCaeLwon79FEXZ/pGJNlZr6TJMfGHJyLFBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJVB0Z/f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lfL7KSwA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.850997918@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tQCVdEvPXh4Wm/hJB6IEGBX+1Rtg0oGtuB4fY52s0bM=;
	b=BJVB0Z/fB/eJcx9kB+VfGxERZ7zvIU0h3eZJL8UGBz47F8rxP4tBYuROr7mxB62y1sX9G9
	4jgIZDhHIU4pftTwy6lI59LVOSNl674HYndk6SkhyOKlO+jigBQ9k7YGHmXL4Re4Tz4XJU
	BSKGYSOfuxASdyjuL8VN8RbIlUMZ1r5ZAOlj4xoHMF0OpGAouxhWz6ngzPw9e/5Upy8d/y
	j4uRuDHGnOlGSE7/n7kcDy4QAgt9UY/lgO+iB/0eVdTNBQHn1XzJP4vM1VORDhreMec8Xq
	idUo4GlrfH1XxtvvWzIGAOS4b2iRa4R58al3yBRa9MVxTxYgLOJRfaXSUoxD5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tQCVdEvPXh4Wm/hJB6IEGBX+1Rtg0oGtuB4fY52s0bM=;
	b=lfL7KSwAsrp4fvOgAoD7g+Q+G0/LPnxGE3j9vghiUeTjdp1ID54/LTmLlsRDHGU86pq/rP
	KVL1QSve9zOwVsCQ==
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
Subject: [patch V5 10/26] posix-cpu-timers: Use dedicated flag for CPU timer
 nanosleep
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:13 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

POSIX CPU timer nanosleep creates a k_itimer on stack and uses the sigq
pointer to detect the nanosleep case in the expiry function.

Prepare for embedding sigqueue into struct k_itimer by using a dedicated
flag for nanosleep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h   | 4 +++-
 kernel/time/posix-cpu-timers.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 8c6d97412526..bcd01208d795 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -42,6 +42,7 @@ static inline int clockid_to_fd(const clockid_t clk)
  * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @nanosleep:	Timer is used for nanosleep and is not a regular posix-timer
  * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
@@ -49,7 +50,8 @@ struct cpu_timer {
 	struct timerqueue_head		*head;
 	struct pid			*pid;
 	struct list_head		elist;
-	int				firing;
+	bool				firing;
+	bool				nanosleep;
 	struct task_struct __rcu	*handling;
 };
 
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index bc2cd32b7a40..ea1835cb541a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -588,7 +588,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 
 	timer->it_status = POSIX_TIMER_DISARMED;
 
-	if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(ctmr->nanosleep)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -1479,6 +1479,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+	timer.it.cpu.nanosleep = true;
 
 	if (!error) {
 		static struct itimerspec64 zero_it;


