Return-Path: <linux-kernel+bounces-208599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CCE902712
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E2F1F21060
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE3157A6C;
	Mon, 10 Jun 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m8KyEwe1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XdXl50y8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB115746B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037772; cv=none; b=R5AFIkas5FPGOK/ql+coa/hexl6SudUyd9QYrVu7P/y7UIGPTjncBhVUZh/W1bLXcdr77SWxzSSCLIhr0jRif/5mrNvRFvPMxqSv6qQyH9jzg+EQ0rpC1tKg4Pa48oZhql/NLzs0lcGpfLmkr2QfaksIHPVZB7HnopEABguuB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037772; c=relaxed/simple;
	bh=XsbgZtCOc5ETrVPrJ/FtKkFplUEZ2QIE7aWQKb1cCHc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=J4UTIdkB9Ayc2cHzg039AEneTokql2F3fh1gUMRSgWwNJqvtD7Pqjak7i0a4TH2RSf3DmqdHuzJKX95mZ1L9/pGu44SyXeMTqSHcxjZpOapASSmuByMDllMmECKq87aJnu/FzkIhbijBBKN9q5yrRxoYpRQoTfsyYwP+QnQZuVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m8KyEwe1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XdXl50y8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.668436817@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MQO2EYZPqj5U7pySt49QYzOaZrWaUy6rIJlwsdY8EF8=;
	b=m8KyEwe1gjtu0ioaXkqDH0NdHS5e7870xH+P/Er08pBjYu3j+CqFMytL1ZRMJJccQtcGIm
	BvQg3DVQ9qZPH/GzaNwwwwbAyScyefiCxakaLeuV5R6z3fMycHzHy9SYyiFR9Gs2LelNfJ
	EVzU83uta+xIIRQv7IJ1IW9JNECB7lx9AirX0PDKIMcWn/bAv8q9rWKAxxnGSQrZXPN+Wq
	eUM/pLHiwXtaCIMmW8O08uaSXu8SdMf5CWLKuHK5mPB15IfzIqDLzUtAj+Js82Yo1eHgH9
	aAVDu2YLoUoAEOcZydkawavbsGI2pNONcAZlNgRwRtF8g2hyeJ8w7d7LufrgDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MQO2EYZPqj5U7pySt49QYzOaZrWaUy6rIJlwsdY8EF8=;
	b=XdXl50y8CR72X2P5yTJolkSBEZppLYYiiLyKFa1EMw9V6lPiC33K2YD9eGtC8/+LdCUrp0
	S7sm1HrIW82IMYBg==
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
Subject: [patch V3 35/51] posix-cpu-timers: Use dedicated flag for CPU timer
 nanosleep
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:48 +0200 (CEST)

POSIX CPU timer nanosleep creates a k_itimer on stack and uses the sigq
pointer to detect the nanosleep case in the expiry function.

Prepare for embedding sigqueue into struct k_itimer by using a dedicated
flag for nanosleep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    4 +++-
 kernel/time/posix-cpu-timers.c |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

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
@@ -49,7 +50,8 @@ struct cpu_timer {
 	struct timerqueue_head		*head;
 	struct pid			*pid;
 	struct list_head		elist;
-	int				firing;
+	bool				firing;
+	bool				nanosleep;
 	struct task_struct __rcu	*handling;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -588,7 +588,7 @@ static void cpu_timer_fire(struct k_itim
 
 	timer->it_status = POSIX_TIMER_DISARMED;
 
-	if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(ctmr->nanosleep)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -1479,6 +1479,7 @@ static int do_cpu_nanosleep(const clocki
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+	timer.it.cpu.nanosleep = true;
 
 	if (!error) {
 		static struct itimerspec64 zero_it;


