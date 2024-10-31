Return-Path: <linux-kernel+bounces-390825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C519B7EED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E837F1C21490
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A951BD4EB;
	Thu, 31 Oct 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDMmKxE2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PSBmiHCn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A91BBBF4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389595; cv=none; b=G+UCBiMm/8YUHfE3m3vyI708CRYQRlu056mJO8dgLawcJSNg7oRhNxQxllgTwBFOO64FsWeQ6JVK0CXjZozS71RMODU1uf1+Hcl33j0VEujtuvmhW7CHXFWHjLpJJho/nacjTMD4AKYQuua2m9+7KBaP0xBtjAcVfuBaMPgykWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389595; c=relaxed/simple;
	bh=ZVAaQanLkDGCsroH9vcnsYuRVzlKEvfr6cRqTv9u2nQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=EI1GcidB3Id6RqO1c39+UAJ/njYHJkj8lzNAId23i7N1kjDY+H2iGR6M1JikmQBn21PRmvNAuMJuwOgzvOHDvhykjkXX07n1MhSq5FAfIrgU232cEcB7FI+S5FKslV8tSzKVZ+Ktm/G0lUjEV47uNnJiBz//lkvtbd92Mg17ipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDMmKxE2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PSBmiHCn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154424.991571969@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9/sheOM3O505WEl90eWHF3ugDs9kjENsFCU+PPXorJo=;
	b=bDMmKxE28OUqW7zAXH3vddKk/hJ1Ere04yzx2SNvb4O/pSaHeO7OIDXN4gSg3pQvI02ZgQ
	0Y0RACNEorDy+2qCSNw5rgsE78UaOg5YixVVy4XBuxmAOlYD9YygOZADHz9HASzgSdeU+2
	VIW3ui4eT2QQghj8x06xLWgQdl6AbDFlG3DTPVRBCIAT92EQm/SpXIm7PbsWxKOVdoxWyV
	t48JGvB1f7g+pwsxW4HreSgzFIOtiIOn2ydsX+lo9py/nvuMzGpkE9MVJY2lCIpxUN8gAU
	ANbeyTcoKN6AMpRW8op8R9urZzLK+DGIkEqYy64XXsxgxFJD3y9Vk7CZMuWxuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9/sheOM3O505WEl90eWHF3ugDs9kjENsFCU+PPXorJo=;
	b=PSBmiHCnDOnKb+CQ8rTZzB3sFDVKMLAuO/GSoM4j3RTrrNXbITin1aPS8b4kykVu1OgB2x
	YgpznJISEcNteNBw==
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
Subject: [patch v6 07/20] signal: Provide posixtimer_sigqueue_init()
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:31 +0100 (CET)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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
@@ -1905,6 +1905,17 @@ void flush_itimer_signals(void)
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


