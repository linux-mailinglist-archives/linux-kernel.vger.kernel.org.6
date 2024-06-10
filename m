Return-Path: <linux-kernel+bounces-208579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D479026F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD99E1C21E21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D6153501;
	Mon, 10 Jun 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="of25osih";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o0/w2V3t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830915278D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037747; cv=none; b=AzOkA3sEwU5FxJBjQT7Va4M5Ing/SIgByPGQGGZp/xKnG5cEMdvCJCsG6F7RvJf4qy2XlOJuGSm4qTOidiRCievBXfZPvy/XvCadz6HKAQ9y+PJMpr8q8OzOSWA3Z3OSm5ITLHbI8hpq8Zhsu2cC8DhR7jZY+0DpfxqIV/xN/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037747; c=relaxed/simple;
	bh=jwLW+rNG7bMs4zQGx/O8eL+ZFKFCQ9a+FbpMQ0kFoaQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Hcb9fmMhDQPD2wRIVfnULcUcYC7j7JyYvOiHsT1u8WPIhQL6AqOvB3fbGEVbTsAfvIfC3hJOv8X+65oSuLxSS6X5CO7CcYRcfpwmIje7wvc6ZtfmykcqxqFdoqIJYrasW0DhW8rUsvaxVhjSsRIGVJSjzSdRgn4M8XBzkm/s98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=of25osih; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o0/w2V3t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.489279861@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=prXY1arwiBmGreObgLsf7R5UB66La837yy2ta+3sTC4=;
	b=of25osihGdxddT12JC/f97xCy1APXnL57lBQ0pXazi9kSOgJa0B1BGntyp1yhhJDdaYaCV
	o0jiKym9SnhSYnXKa29F9Rpy+rrdVqCcf1kQgGVFeZAzL0k7zf93EDJO8tLdjWpMaw0c3p
	uEV4wR9wX+2pcAdlPz238uIZdQhkQRpQavozuHLkzhDXp1qzOioQHtdBvmm4fjucDt5VH9
	uAqSja7cylH7KdAr61wDcI2Dix/2tSJ8PsiTeDKY2BAGnh56IinEsYuUOPL2Wnqivb+yq0
	gOV4zTc60wm5JCIMIBvhqvAs69LaqYrGncui+rbbKi/i1W5mAA0NvS65p9T5QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=prXY1arwiBmGreObgLsf7R5UB66La837yy2ta+3sTC4=;
	b=o0/w2V3t/SLJK2q5U2ydsRtnW80BSGNlq40hacvkTjFyjkSnjwg93wZ059RztN6gbyWPNa
	0VhyeBvZVHnyBnAw==
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
Subject: [patch V3 16/51] posix-cpu-timers: Simplify posix_cpu_timer_set()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:25 +0200 (CEST)

Avoid the late sighand lock/unlock dance when a timer is not armed to
enforce reevaluation of the timer base so that the process wide CPU timer
sampling can be disabled.

Do it right at the point where the arming decision is made which already
has sighand locked.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   44 +++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -705,10 +705,16 @@ static int posix_cpu_timer_set(struct k_
 	/*
 	 * Arm the timer if it is not disabled, the new expiry value has
 	 * not yet expired and the timer requires signal delivery.
-	 * SIGEV_NONE timers are never armed.
+	 * SIGEV_NONE timers are never armed. In case the timer is not
+	 * armed, enforce the reevaluation of the timer base so that the
+	 * process wide cputime counter can be disabled eventually.
 	 */
-	if (!sigev_none && new_expires && now < new_expires)
-		arm_timer(timer, p);
+	if (likely(!sigev_none)) {
+		if (new_expires && now < new_expires)
+			arm_timer(timer, p);
+		else
+			trigger_base_recalc_expires(timer, p);
+	}
 
 	unlock_task_sighand(p, &flags);
 	/*
@@ -727,30 +733,14 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (!sigev_none && now >= new_expires) {
-		if (new_expires != 0) {
-			/*
-			 * The designated time already passed, so we notify
-			 * immediately, even if the thread never runs to
-			 * accumulate more time on this clock.
-			 */
-			cpu_timer_fire(timer);
-		}
-
-		/*
-		 * Make sure we don't keep around the process wide cputime
-		 * counter or the tick dependency if they are not necessary.
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			goto out;
-
-		if (!cpu_timer_queued(ctmr))
-			trigger_base_recalc_expires(timer, p);
-
-		unlock_task_sighand(p, &flags);
-	}
- out:
+	/*
+	 * If the new expiry time was already in the past the timer was not
+	 * queued. Fire it immediately even if the thread never runs to
+	 * accumulate more time on this clock.
+	 */
+	if (!sigev_none && new_expires && now >= new_expires)
+		cpu_timer_fire(timer);
+out:
 	rcu_read_unlock();
 	if (old)
 		old->it_interval = ns_to_timespec64(old_incr);


