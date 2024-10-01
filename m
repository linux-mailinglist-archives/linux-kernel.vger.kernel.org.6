Return-Path: <linux-kernel+bounces-345548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3A98B75F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0F4280E2F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8C1BE86C;
	Tue,  1 Oct 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4y0njSCC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKMiFW8m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4C1BE23B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772151; cv=none; b=ei+nROypK+tpcwDPFD7ReZFdkS0miNpaq8Y8otZaw6GTALWP56DloappuzNzv/BGxUlhHaBuNLgatXC6l5uS/imiB5IWKt0wFYG8s8U8688Nyz297F2fhrp0UILhW/Yzc88WCF/3bMVOjTQymHs2635eNyW+WKtkwctuTu8mJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772151; c=relaxed/simple;
	bh=3MAwcXstmu0gnWTYcr5kZDdejdNgPxaQb2XQWXWsj2o=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SzpzZlNKXWoHjkC6N7Vb7DODANE5ibgXf/gXxbA5lXNjuYYUhRlwCTFNqIWcwlCtz1QiPNYTxiT7+SvNhVz0EpDR7ewlloQnDrJze8iTwnsgEhmfTHAQfceeBgnKd3qi1G2ixUGAaP6V3aGZm5ni4SOALumThKh4zBkTgpY2PTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4y0njSCC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKMiFW8m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.455949409@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AJWNttDVPF/rmQe1Q1kyokOqlDn+dzynriewRiuGxO4=;
	b=4y0njSCCoazPD8CrhnKnH2PbIk5H5e5qqXeym3mIge9ZMK1LPOpnv00QOiU7/ezo82FfFF
	y4q67MUbWltCG726PQWD68Baa4bt4tvvbwATWnhedi/CbQ9dI5XpYMwMlMN6/sxgdFPa2I
	tg6FUQmHuYQdwMkl14d0ORcQy48IO2170O2HyYzBV/kDzvq02igVcYusLPsl5VPfNNZ8N5
	aTRrHtNkL/MJ7+E8fO84ZJH2x4yl6vt30GbMLMkrwaIv6mvSyH17e9bi4ma75YYpG4Gl/x
	DB3b1K3mxs3YLA7K84jUpHcmC6ODsZ3vygbr+xdju4qpfscrMcdSgFS7bEfLsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AJWNttDVPF/rmQe1Q1kyokOqlDn+dzynriewRiuGxO4=;
	b=lKMiFW8mIRTk3zjMM92oVXYwmjdzDnA1NdDkoePLWHfIXQFuqZ/xk5F+wgE8S7KiC0b4nl
	UnR9JesUDF6ijADw==
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
Subject: [patch V5 20/26] signal: Provide ignored_posix_timers list
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:27 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a list to task::signal.

This list will be used to queue posix timers so their signal can be
requeued when SIG_IGN is lifted later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/signal.h |    1 +
 init/init_task.c             |    5 +++--
 kernel/fork.c                |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
---
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -138,6 +138,7 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
 	struct hlist_head	posix_timers;
+	struct hlist_head	ignored_posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,8 +30,9 @@ static struct signal_struct init_signals
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers	= HLIST_HEAD_INIT,
-	.cputimer	= {
+	.posix_timers		= HLIST_HEAD_INIT,
+	.ignored_posix_timers	= HLIST_HEAD_INIT,
+	.cputimer		= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
 #endif
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1864,6 +1864,7 @@ static int copy_signal(unsigned long clo
 
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif


