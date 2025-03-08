Return-Path: <linux-kernel+bounces-552634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF7A57C22
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C9B1892A4B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332F2139A2;
	Sat,  8 Mar 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fzLylccU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5MGHlE+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26921213229
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452525; cv=none; b=SU2dyIEu6En9+03KVpSPxMrTLvUTZnesmYfvvoSn6e80TCLBnPC8wGVMMDtLka4om1vgq2EMf3jGY3FwyMcKm/6WW3ge/CGRfuESSUtaWo96b3wL0D7tJAmeLddIoGMiG3+vI1gyd7e211LQpQ4+0SHFn/Jt1pvP18djkMUQt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452525; c=relaxed/simple;
	bh=Hnjd65SCjNsoU60oyHNlwuhqbFiEqpOg9xXyB20JbVc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Mio27jbNADOFm1bBUiJuhtkfEntZNGmZkt0IgPjO1CEX1s67ANn63ZHXvJvd1p8cT7uPH6J767Q090pnCMTgMDGypcbVSuc4m7bTWBW9oxVc7+maE66c4RBdUtpdDjYxatdSUe3/TNAmuVNOigauEw7Gv8Qg2XqAcoBwJ9Eczr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fzLylccU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5MGHlE+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155624.341108067@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0lWpZlsveEhaW8rPU7ZtqYAYyCwF3SjzBjO3yEzqZ8E=;
	b=fzLylccULg1SuonefIhePh9Rmada9RJSmYwDxHUeJUZY2a0ctcNr4Z8bu+C3fSunD9K332
	Uicm7drLAfYa8kQvqdSREgdL0YlL6jFrrdJpGVn7aLWweyOsWcwqY9TpL0UwbnirVnnAHX
	VEFER8kn3yjsuVPTM3/wbOAxPsApya6pQzgsp5rLTJDqChAuiQtwEG+ituja1fB9VvLa2p
	FOpDkc5Fupf9lYuRInmUG/aXwkm/J6uAQmGVXKRJ7+Z8XHGWoFQh9EwW+A/qOAAoMX3dm+
	GvtZWJ/dgYNvLIYYm50XR9SJJQ/Zlm1BCFoa/FUdQwiJFvObd9jushkOg2X3Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0lWpZlsveEhaW8rPU7ZtqYAYyCwF3SjzBjO3yEzqZ8E=;
	b=N5MGHlE+2F9jgeVMDdDj6wdnAVbnRiA0QwQGtgJIpeoq4Nf4BDAEPvvBMhxUmQZH1SUDP/
	rKBndMd08nApYdCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 14/18] posix-timers: Avoid false cacheline sharing
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:42 +0100 (CET)

struct k_itimer has the hlist_node, which is used for lookup in the hash
bucket, and the timer lock in the same cache line.

That's obviously bad, if one CPU fiddles with a timer and the other is
walking the hash bucket on which that timer is queued.

Avoid this by restructuring struct k_itimer, so that the read mostly (only
modified during setup and teardown) fields are in the first cache line and
the lock and the rest of the fields which get written to are in cacheline
2-N.

Reduces cacheline contention in a test case of 64 processes creating and
accessing 20000 timers each by almost 30% according to perf.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V2: New patch
---
 include/linux/posix-timers.h |   21 ++++++++++++---------
 kernel/time/posix-timers.c   |    4 ++--
 2 files changed, 14 insertions(+), 11 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -177,23 +177,26 @@ static inline void posix_cputimers_init_
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
-	struct hlist_node	list;
-	struct hlist_node	ignored_list;
+	/* 1st cacheline contains read-mostly fields */
 	struct hlist_node	t_hash;
-	spinlock_t		it_lock;
-	const struct k_clock	*kclock;
-	clockid_t		it_clock;
+	struct hlist_node	list;
 	timer_t			it_id;
+	clockid_t		it_clock;
+	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
+	struct signal_struct	*it_signal;
+	const struct k_clock	*kclock;
+
+	/* 2nd cacheline and above contain fields which are modified regularly */
+	spinlock_t		it_lock;
 	int			it_status;
 	bool			it_sig_periodic;
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	unsigned int		it_sigqueue_seq;
-	int			it_sigev_notify;
-	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
-	struct signal_struct	*it_signal;
+	struct hlist_node	ignored_list;
 	union {
 		struct pid		*it_pid;
 		struct task_struct	*it_process;
@@ -210,7 +213,7 @@ struct k_itimer {
 		} alarm;
 	} it;
 	struct rcu_head		rcu;
-};
+} ____cacheline_aligned_in_smp;
 
 void run_posix_cpu_timers(void);
 void posix_cpu_timers_exit(struct task_struct *task);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -260,8 +260,8 @@ static int posix_get_hrtimer_res(clockid
 
 static __init int init_posix_timers(void)
 {
-	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer), 0,
-					       SLAB_ACCOUNT, NULL);
+	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer),
+					       __alignof__(struct k_itimer), SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);


