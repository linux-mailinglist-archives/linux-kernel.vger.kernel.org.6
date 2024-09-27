Return-Path: <linux-kernel+bounces-341485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D69880C5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9B2B238A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648341B143F;
	Fri, 27 Sep 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvH70WKl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kE9l8ejV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974C1B07B2
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426935; cv=none; b=TWtSK+3VB71nBUVjohLPLWcPaKczhNvnCkq3651beQsjO/QjKXIrM0hvbmzFFRkkajg8jbtmpI86+hSh65+6uz/sZyWQ4/aNpS0ZuCUT5Hi9v+dHadi6+tJ/ScPDRHVBboU6Ez9jv35hBkt1/OR99aThnf+xbX3w/DNR+GGA4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426935; c=relaxed/simple;
	bh=JS8OTIugV54U4c9TnOdGFMqXhSz/nJrdTvMchyD+w/M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RwKadS9JkYnlrmooP0w/U8UK6FZc1vkpk9Y+FlMjzB2xzgaNJl0YZeme6IQD1C9S4pHoy0Li8MmuYirMWvGpNUagYysu9hXdPhYHGLACii7SlgGNpHh1/6rxJmkMpHv5SGZb343NZIFGvBSa44VL4kbIdMgjrNxZjiopgVR+uCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvH70WKl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kE9l8ejV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.574566710@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KgET3aIT9+OZMdI/ErQ6Q2EVM4fWSh0RVcwU7MumU1s=;
	b=hvH70WKlWaFoy9bj9Sgw3w/MNFQCjofPpIHt9YELmRARDIFwI9s1Sh2ooPwm7eetsb2X7s
	HPk3zpBaWwfH84dx3haOtT/iCItrta4jG1QVYxzSK1fkEVzYcsL19Jmjw4DLT3WV7S6buF
	U0lNI1ZQaVSuT7Uu//JQL9uVCXpnI3coJoaHugZhpCyP1Rn98dPBypqeSRCm3MBPc4oY60
	dlIyPS/8VdpdB9FDqT0E18yWbvGR3Zy67bJvUxL1Fi/9h3PRGXgiKDwmm6MU4YHLo0cnOe
	6cOkB11cAM0cGxmSY0bxZMl08lHFglLL4+08kaYzHx1tuSso3et+Tv8RMqtxyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KgET3aIT9+OZMdI/ErQ6Q2EVM4fWSh0RVcwU7MumU1s=;
	b=kE9l8ejVONf+ZP2MJ4v0C67x0GtN0KRaeBwK61NqxvSz6gJexzbHIfZbtCaZxepbbK4pM7
	1FQzOQIX+Ew9H6Bw==
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
Subject: [patch v4 11/27] posix-cpu-timers: Use dedicated flag for CPU timer
 nanosleep
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:52 +0200 (CEST)

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


