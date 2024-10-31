Return-Path: <linux-kernel+bounces-390822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A59B7EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2AA1C2039F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED121B5827;
	Thu, 31 Oct 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IXCcTG2F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KTunwOIf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD21A3BC8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389591; cv=none; b=VM3wdtQveFQOCrDbZaqM6BrZXWS0mj37B7oL86jayaEztEZ17soeEo8j/E5eZDJeH2ePdiAnBXLt7fUP7iStnt1xfy7D4GQf2zkaY8xgkE7tQC+UMLEmSpMe7TgKgfUZ6ucTghtcFO2KpXg6cda9kCrZvhsr1VRJ7tvzqRObycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389591; c=relaxed/simple;
	bh=6QadadNKAM5qb4g5XADfumRJa53grKZV/xEszGMAJLc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rm/A3IH0gO09VX0hl/HLM1oUoR6Ivx99coEWCVL157ky6WhcIbT8rMrC38oHHzInO0wlzpjLZHWi2mM5m3h/1csU6hlsg4JZDBQFtQn49ayxvI0LjIpV9vaMVcbFZ4YaSAKdL0NdbSmNF6abC2u66b38z0MR5T2JhuX0IXqtliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IXCcTG2F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KTunwOIf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154424.804147685@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fk1ptLUC33Bw0wSzd0G6hpDiLiKMBhvHROCcbCZNqe0=;
	b=IXCcTG2FZizq+R5JTTbIBCUmYi1XC8qP6fcIV9YUr8aoUpIVp7q9vdegqREOdkGJHjWG5P
	pHwL5MkInnbs0OFaqfKlrAunlJoXRD+1amrRBfSBiC28ucCH+RxfxK97i4wvR/C5GB6zpq
	/tSH9fi9q/AXju8pJwnf2El7orpwXT9f1FGh1G8Z7xkyC+YVAau6krkeLBCE0C6ezl/po0
	BGsNOkvWpDNEi1J6sMSnCH9fA/YJoZZraukLxCmkyIm87S9FysnzsaOCKJVL8Dzte2GdIz
	wYoQIXH9FZzivvi/5RtcKE6X03OFeiViJOq6tRay5T97JfAeLZTmdKlg97J0bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fk1ptLUC33Bw0wSzd0G6hpDiLiKMBhvHROCcbCZNqe0=;
	b=KTunwOIf5+8pqRv+cv3fENyBMgOR8K3lzWEE6D2M1kRG/EVqs+cEK1aIvCO1NVHFMe6QnC
	9fJ818t8BOh3ylDw==
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
Subject: [patch v6 04/20] posix-cpu-timers: Use dedicated flag for CPU timer
 nanosleep
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:27 +0100 (CET)

POSIX CPU timer nanosleep creates a k_itimer on stack and uses the sigq
pointer to detect the nanosleep case in the expiry function.

Prepare for embedding sigqueue into struct k_itimer by using a dedicated
flag for nanosleep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h   |    2 ++
 kernel/time/posix-cpu-timers.c |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -42,6 +42,7 @@ static inline int clockid_to_fd(const cl
  * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @nanosleep:	Timer is used for nanosleep and is not a regular posix-timer
  * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
@@ -50,6 +51,7 @@ struct cpu_timer {
 	struct pid			*pid;
 	struct list_head		elist;
 	bool				firing;
+	bool				nanosleep;
 	struct task_struct __rcu	*handling;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -595,7 +595,7 @@ static void cpu_timer_fire(struct k_itim
 
 	timer->it_status = POSIX_TIMER_DISARMED;
 
-	if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(ctmr->nanosleep)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -1492,6 +1492,7 @@ static int do_cpu_nanosleep(const clocki
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+	timer.it.cpu.nanosleep = true;
 
 	if (!error) {
 		static struct itimerspec64 zero_it;


