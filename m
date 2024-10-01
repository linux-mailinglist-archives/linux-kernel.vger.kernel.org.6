Return-Path: <linux-kernel+bounces-345541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3998B758
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE381F2325F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F5F1A071B;
	Tue,  1 Oct 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4LvXTfw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MsJewu4v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756741A01BB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772140; cv=none; b=RKBUrAzGlHuZvfTtyYaFiTUJder98cegJEhLcPV8TvI69m5o3dN664ryaSF5V4/pHyDpWxrToaeirfKdniqaapPWEB1AARJqgH4yIg6gpTYFsAVbfy1ltL6bVNxVT8zdecc0yqaf5NBdX0DV47Xl7KjqozmaWQd2+Mv/TDTPpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772140; c=relaxed/simple;
	bh=7By1IOqtAz0qQuAvri3T+IbplWyDq5Mz/sllGuVO58s=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nXMb6JZrzWPGZnrAiaMP/DdnNuxGCdhNrI4MC41mzlf/mW96isaatSawNOgBH+nsFlgz9FMwbEWgujqb9ZqggO1o5ZagwaFwUx78ChidWb8R4m57z3MW+UeKzNcnqF7OlvhxKkQhVBra31qA6aoUGBrw/fhapWs7jW7SZBED/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w4LvXTfw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MsJewu4v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.031093453@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3NEHXqw0CJuJv6ubSFkvIXA+dP8+q3XE+ki9sOO9HUY=;
	b=w4LvXTfw5iJrGrAR49pzUwAN0zFhOYGNZdFEGzW9kihBaRdNxH+0bQCUCMnK6P4w7p8yde
	A+1zGMPhY035jao/epOeKaCTMS2w4jNEU6GV2pAIjtDkRJuDp88ICFo1BtAIeruW1XnpOZ
	MMtFgN6RMR+MZqCaKoFQKl7tEqBqouGZbQER0r5oK8guJsOx9JvvIMxJkLjGSsBHzOzCmj
	UJyzDSA7dxegU7zrunr9wnFTfbuNlBnxKTb2mHp47iTfFp95cq+g8gRrvxCEP8b9laTjQa
	4kMyk9anGR54/za2MvwKYYa6P8LqgKMelLr+lGR5HzuCaWrRWGXpBptECCmdLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3NEHXqw0CJuJv6ubSFkvIXA+dP8+q3XE+ki9sOO9HUY=;
	b=MsJewu4vmqOPJGn0YjLUmnhVDgoYaKmnPIiDlicC9MIqSd5NOH2Ha8sfdbvv250jbA8muS
	b4Gu0rE2rww7mSAA==
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
Subject: [patch V5 13/26] signal: Provide posixtimer_sigqueue_init()
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:17 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h |    2 ++
 kernel/signal.c              |   11 +++++++++++
 2 files changed, 13 insertions(+)
---
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
@@ -1907,6 +1907,17 @@ void flush_itimer_signals(void)
 	__flush_itimer_signals(&tsk->signal->shared_pending);
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


