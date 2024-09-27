Return-Path: <linux-kernel+bounces-341491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E49880CB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0DE1F22B52
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E211B253F;
	Fri, 27 Sep 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zj9GlIgo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3JaWNoZJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702B1B2512
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426942; cv=none; b=X8WTTrq9EtqIrJPYwbV6QgVY03HuI2uDFW56+VxOKsRjD1/xtB3WUdaDHqAGHJje+TDEm7kMmla0pmBK+78wChFwswN8wgnjQ6fD8t/qe58FPGD4wehfECPV5/G8o8Sa8fxGtS/iEpwVQt5jS+pr5c75/5NJOdfXad3Y7c98NFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426942; c=relaxed/simple;
	bh=EaiBFn5ykFkyn3SnqsoIh2Ch8Km5zazOeHvVJZ17+p0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dZ3UTNQE9hfRyjhipfIKiQ+Lay7cm5DShJOEvRQElwhtyWPm4UZG6MpqfRrPCz4tRYQBfDM86L/T6JffdRzuqnLLxj+5zVnsCzfMuj3QgA4a6uJRSxRK+l7XF9KXsNzs5i3E0+t1NlNHS3xIo7wyXiUzw+4CmHh9/rjxHCWyeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zj9GlIgo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3JaWNoZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.878595561@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SzaWYWlgppQYsQPjjX+C3/SOtqJIw5qvKkXGRKX9duM=;
	b=zj9GlIgoYEuN39qlOiKMbIvrd2FLT9g30qiV5oSBG9pu0ahNGq5yOQu05my+4ZXGYzw3yG
	ZpYHIvlkwjrJ7SoQY2GxThFEwBpEcHbFObzob3Sm8et/0/5bU9G29oK6/IVEVkZZcVHukm
	k4nV3NzTfplotJIUxJSGzZt0l7+4sUQmq8Omw/HztRNMsZ4PcvcevS+6FO90rk4BGUd/ub
	iFyUB2j+PhENJj573GjV+UoyEMSTFkTHQxfAmLcpM2AIv0aEEXOGnveAyXzPWtYCDh6jzk
	ULYWtQt6bsLHtWNBP6fnwTyOcFvne4jubODnbfB+rG96NMGbgIFQjC+3pCfwoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SzaWYWlgppQYsQPjjX+C3/SOtqJIw5qvKkXGRKX9duM=;
	b=3JaWNoZJ/iq7IPcBxTZZ26X2/EliOQgepiNm9jbT+l4DA8fs01miM1bLH3X21AqaJKHQKR
	g8+z9Phy7tQ2+CDA==
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
Subject: [patch v4 16/27] posix-timers: Store PID type in the timer
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:58 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

instead of re-evaluating the signal delivery mode everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h |  2 ++
 kernel/time/posix-timers.c   |  9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 200098d27cc0..947176582de9 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -5,6 +5,7 @@
 #include <linux/alarmtimer.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/pid.h>
 #include <linux/posix-timers_types.h>
 #include <linux/rcuref.h>
 #include <linux/spinlock.h>
@@ -180,6 +181,7 @@ struct k_itimer {
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
 	union {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 9d7e02db4157..bf68d80a0d75 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -298,7 +298,6 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	enum pid_type type;
 	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
@@ -309,8 +308,7 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 	}
 	timr->it_status = state;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -504,6 +502,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
+	if (new_timer->it_sigev_notify & SIGEV_THREAD_ID)
+		new_timer->it_pid_type = PIDTYPE_PID;
+	else
+		new_timer->it_pid_type = PIDTYPE_TGID;
+
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 	new_timer->sigq->info.si_sys_privptr  = new_timer;


