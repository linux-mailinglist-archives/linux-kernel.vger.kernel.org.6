Return-Path: <linux-kernel+bounces-208602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F18902721
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917A31C21A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719DA1586CF;
	Mon, 10 Jun 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="werZbN9V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sl6nfPu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471941581FF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037776; cv=none; b=qkVce5BiDUW4EYarK+ZJWfmirdEIYOnLtNWmT3ChCItOgA9YRf7Us5MCr1pY89WE7vCGIJEoVtVwE7TSycfViNsBQVUmMH/GqVjXTQsVvhj+6Wt16fuW/zzlI3CH4n9JTGDXT6tviqmR27FepjQwzsgUOj5HlPOMIySel0B6BUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037776; c=relaxed/simple;
	bh=JBVsg51a1C6emguYqjQ6r5sm9uw8SoWsLBDNYeJITWk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AbR/AKNPdCAa8DIJSDJB+wo9/msmrj6Oy4Xx8hhT9AZD9IVT/nLJL/jRREbImwl5XRv5+xnJm+A1mJ9TKLoGXrrdI+qaTBLDBXrdwTepwXocLoKVmUke0nMOzrskVlfzFYv1FW2sRXvz05+Kd4yKOAYrKUt0I+OF53oXvgPjCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=werZbN9V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sl6nfPu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.853215767@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uih5CqJpJPUslYvMN+crWXfC4uyqUetkrCUQg27T5sU=;
	b=werZbN9VkgOYnVeqcxaduNhFRxFdOPoUGuHTFfHDI/rslVinBnjNdBlL/Kc8n/kgvur2Os
	KorSDhs4p48tIRX4gOIvbE5oiMfJZbEC+YenHL5ojlZR5L1mbPCGN60XFcm1LJVCzHp6BK
	bjslNiEoNlibXyyAvI+Kx5EjI/mmdEPuSAJ6/LP0qEpxUhZfXkhq4xMvtPAGAmPlyZhDvH
	E5XqImHZbFkG/PiLeTYZipIOVmZvtfho1qkgxtcNWt1f2IVrDsXJz61YyB4zbxB3xV0rI9
	RP59CqQKLrWYmlf7TDFi4grFv35bdvWu+JQRFG9REpX1W79b3CrB4qKSPLebQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uih5CqJpJPUslYvMN+crWXfC4uyqUetkrCUQg27T5sU=;
	b=0sl6nfPu7GVfb4os1/xUF/w4qbivnJAl8p6g722HD2ToxD1k79mClQNojzJ4Mu6kzqICcY
	ur2jV7+lTd5uUhBA==
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
Subject: [patch V3 38/51] signal: Provide posixtimer_sigqueue_init()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:52 +0200 (CEST)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    2 ++
 kernel/signal.c              |   11 +++++++++++
 2 files changed, 13 insertions(+)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -12,6 +12,7 @@
 
 struct kernel_siginfo;
 struct task_struct;
+struct sigqueue;
 struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
@@ -106,6 +107,7 @@ static inline void posix_cputimers_rt_wa
 }
 
 void posixtimer_rearm_itimer(struct task_struct *p);
+bool posixtimer_init_sigqueue(struct sigqueue *q);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1909,6 +1909,17 @@ void flush_itimer_signals(void)
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 }
 
+bool posixtimer_init_sigqueue(struct sigqueue *q)
+{
+	struct ucounts *ucounts = sig_get_ucounts(current, -1, 0);
+
+	if (!ucounts)
+		return false;
+	clear_siginfo(&q->info);
+	__sigqueue_init(q, ucounts, SIGQUEUE_PREALLOC);
+	return true;
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);


