Return-Path: <linux-kernel+bounces-540751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D06A4B47D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615793B2F3F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5911EDA3A;
	Sun,  2 Mar 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZG1J4f+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FCXbaqB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C131EDA32
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944228; cv=none; b=cqnh+IMNLVGiUqRjVqwOF+ls5UhESs/HeMMuSOOBiCYZ8MmckwWpJs4y6freH3vSmEaUq/fq4X4wWg20Idqp2WNTbWEqmZ4V7l4g5iQccLsIJVEbsDAeXHynCZv4lNnNZd3DHm6/jx0kCviMMpn6jkRUGmslMUzJTbXzmorroEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944228; c=relaxed/simple;
	bh=JG1yW85eIxVDSozqC+oYG9lX+kCxaDGIRh7fRGvCJlQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KU3KA/41jh9wvet0y8GzANAt+QzqxbCwbUWPqLCwNi3Tw8PrJ0JAH8iaWSSv/01nj1ECX5g6Jvd3hERtkFFVt7HvekbLA4yXFbEalIWx6oBnMze2HhsQwExS2T34h11GgKTXbwK4YK/dKzXkV+tZEVP6WZHPqygjpmbiqQOOGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SZG1J4f+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2FCXbaqB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.730551737@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KAkIcnagyxvTTCqc+Efy7bF6aips8b3Vv/tAhqWPhPQ=;
	b=SZG1J4f+6T+tA3lnmwjneVWbdhhJA6DrgmqYgNwKf8AB8goMumIJ67cEbdIhfIhaPsBPfm
	aKw9dAvxZRw9q/eGvcfrvW0FqUkPZ+Qcso3qxg7LwzTuhwqnkTudEHGodlR+JMf1DNDh9i
	Io/bQCqIiRNiDZIT48Ib+wQMDknbXklXEA6wx+Kor8dXbzZ8RORXoolpd6i0HZrRnKoNmM
	X0NrQmhF1FE7V7hyyFxRFkozx9fGjXCWx70Gy+v66SgM1OehSk3Jg6LvluVQBjbFa8SJtq
	CrNVzHRZdPyJBn8PWJ30bFv2OxE/97hjO1BG5+hM5TmeBTrvLetcWUBa3Wtv4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KAkIcnagyxvTTCqc+Efy7bF6aips8b3Vv/tAhqWPhPQ=;
	b=2FCXbaqB+DrejeIvbEltm3HzS4Ev3KZLQW1VZFcG1Ai3dhfEzBpBch44PF0P916KimzXLT
	ABo2chsJ0UbmHLCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 13/17] posix-timers: Avoid false cacheline sharing
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:37:05 +0100 (CET)

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
@@ -259,8 +259,8 @@ static int posix_get_hrtimer_res(clockid
 
 static __init int init_posix_timers(void)
 {
-	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer), 0,
-					       SLAB_ACCOUNT, NULL);
+	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer),
+					       __alignof__(struct k_itimer), SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);


