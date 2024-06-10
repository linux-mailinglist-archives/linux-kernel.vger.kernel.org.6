Return-Path: <linux-kernel+bounces-208603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD8B902757
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4665B29F31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84970158845;
	Mon, 10 Jun 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlfQ/fIz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKGP3LVD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A678158219
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037777; cv=none; b=kN36ILygXyRucWVZvUEU9PtVti1WxwtlJar0rKNhiK6pm4qNPjFP0bEdxN0msWiwD9Ef9kf+AHHqtHej60DWelHu1qsjQc1GbhV2MqiBv9FodGJTR7vdLrZrflIPVflBSKM15C/kL+2vw17xYAF8JclMqBApm9w71ujh0MEDXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037777; c=relaxed/simple;
	bh=Bp/mJsKy0K7y+W6reqzXaf54OlcjiFTLH7F90/BxRvU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dqpVTtiSCgeSbV7/qg8n5VOoqF73XvJh2OynCpzmZbk3GMfsTW4Av1gZ0+OzDmgQWizGHEZySAYgtBzCGwKQM/b/MrIuewlHQNq2WLImsV3u9devbwVtV7Km3L1HZ3wO+W/bBdOFiKNtO/PrzJbnsRIyBoz5z4j9l1c3krSDOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlfQ/fIz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKGP3LVD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.988500833@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lbd4hY6DO5yS4CWfhpTcHrpvo9CKLyiSwH3SuNY1ueE=;
	b=TlfQ/fIznRlByLSiADsEJwsOcku5dU6LmwbMrS8AZlxssOeIUNHq+I7HrAcOeTb4HqwDdc
	qQWlGS0aNatffUpAZJBZ2LOvgdCTS9ovP9x625JfMfM5Jm00HlZ9/GAv8NRoze3c288sul
	2d37JX/HRgjjsKCm0C7lZvjGYf19BOD0UlIUYNqJtXhIyX1PA4SM6NrwdHzspLf/+VBe0n
	HZD/OKOarTTiT6MM3FGftR9UOls5EhCSCmK0Oan3ivZhhVgWG1glAoy8d8u+opb5MoCq2l
	xVrxsluJ7qi6ZEkwf7qEZ6gNGlnyrKlLHKo96BHYFp6/wi7FdlCDMdoXqmtKCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lbd4hY6DO5yS4CWfhpTcHrpvo9CKLyiSwH3SuNY1ueE=;
	b=bKGP3LVDlYFypVVTX2jeGI/ZNIYcbxKRNZr85L909WGLUoLLg4DaWDiNFpAprk+U4qPbjQ
	kDpYOZevpE/ndxAQ==
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
Subject: [patch V3 40/51] posix-timers: Store PID type in the timer
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:54 +0200 (CEST)

instead of re-evaluating the signal delivery mode everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    2 ++
 kernel/time/posix-timers.c   |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

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
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -298,7 +298,6 @@ bool posixtimer_deliver_signal(struct ke
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	enum pid_type type;
 	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
@@ -309,8 +308,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -504,6 +502,11 @@ static int do_timer_create(clockid_t whi
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


