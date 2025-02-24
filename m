Return-Path: <linux-kernel+bounces-529959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B216A42CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD93AA951
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BE1157A48;
	Mon, 24 Feb 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hbVPi3j3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPBatL7t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E633F3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426360; cv=none; b=ZeY0tdjM7CPLgkIsOWIsSop56AH7zvgljmNTPa6RroYNqw/EjkTn9YuFikA9ysnVFJteokvY/kABPNaW51wPfcmZIicxVGjxL0MpDdVGA+n8GMSpFdZf7793taTCXtEeRTQ76j728N/YigJGKKk5M7XwYq/6WamGENY873L6ex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426360; c=relaxed/simple;
	bh=8i+xz4hZpSFBmEsXse103bXZhOLAzMWHKn6KTJ3PqWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lIfcgzL5qw1xbjuIkNmMSVV+kCmS7UkvavlB7Xvzmsi9BDZQy615Kz5e5UsWOPKOHOkaJCTik+S1sayt5xzINjMlAlhTz6zCXHPHEYKB6alPsL1v5dVAS54DcOBpq1B13B3oTmrQ6Q/na7fDog30hqOgIqgnMvPksovKDKJDl2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hbVPi3j3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hPBatL7t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740426356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXq/kWbImhY9MKmzWnNSHiOxhhRI+XEK9Qt84FAbNCY=;
	b=hbVPi3j3iSULesb1hupMUOsWQLp8/rW2nTHZ+ar4fELEtK1CTUqkmRZz+KgFBaxAyYtW7E
	ymrD2dSDYh24Q/8hQg8qBbIj0T6P2aA75JXjMty1aOA+ScmUAiiYR5R1CQSEHWzPQIooJk
	huDcXE1RMjcDIDGy5o22X4ikX9D0YrCz1JFqYke0GTRNiZzfnvwuuEvd9coUUa/zZxI0D2
	TpZ7ajC+Yyp6m0a0tOuJkN9lHvUsFpRs3Y0XgpCDu08d23wDMO3YyoZKeXjgcw9+chaZ7Z
	W6/Iz3PC8DbRvwERkKpBD75lVmqnWIVTkDDngTbSpSKk4ROwnxe0djiiYg0lrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740426356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXq/kWbImhY9MKmzWnNSHiOxhhRI+XEK9Qt84FAbNCY=;
	b=hPBatL7trskOLiqQD8aKTzHWSdWjMaNYsin5/OrUdi4OdiyjGbcrEg1EGBiQusMvDLXP8P
	EHut7ExGujGfmxCg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 07/11] posix-timers: Improve hash table performance
In-Reply-To: <20250224101343.410413967@linutronix.de>
References: <20250224095736.145530367@linutronix.de>
 <20250224101343.410413967@linutronix.de>
Date: Mon, 24 Feb 2025 20:45:56 +0100
Message-ID: <87msebf7nv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 24 2025 at 11:15, Thomas Gleixner wrote:

There are two more long hanging fruits:

      1) The hashing is suboptimal and can simply be improved by using
         jhash32(), which gives a way better distribution in the
         pathological test case with 1.2M timers

      2) Avoid false sharing

         struct k_itimer has the hlist_node which is used for lookup in
         the hash bucket and the timer lock in the same cache line.

         That's obviously bad, if one CPU fiddles with a timer and the
         other is walking the hash bucket on which that timer is queued.

         That can be avoided by restructuring struct k_itimer, so that
         the read mostly (only modified during setup and teardown)
         fields are in the first cache line and the lock and the rest of
         the fields which get written to are in cacheline 2-N.

Combo patch below.

Thanks,

        tglx
---
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -179,23 +179,26 @@ static inline void posix_cputimers_init_
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
@@ -212,7 +215,7 @@ struct k_itimer {
 		} alarm;
 	} it;
 	struct rcu_head		rcu;
-};
+} ____cacheline_aligned_in_smp;
 
 void run_posix_cpu_timers(void);
 void posix_cpu_timers_exit(struct task_struct *task);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -11,8 +11,8 @@
  */
 #include <linux/compat.h>
 #include <linux/compiler.h>
-#include <linux/hash.h>
 #include <linux/init.h>
+#include <linux/jhash.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
@@ -48,11 +48,11 @@ struct timer_hash_bucket {
 
 static struct {
 	struct timer_hash_bucket	*buckets;
-	unsigned long			bits;
+	unsigned long			mask;
 } __timer_data __ro_after_init __aligned(2*sizeof(long));
 
 #define timer_buckets	(__timer_data.buckets)
-#define timer_hashbits	(__timer_data.bits)
+#define timer_hashmask	(__timer_data.mask)
 
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
@@ -74,15 +74,15 @@ static struct k_itimer *__lock_timer(tim
 	__timr;								   \
 })
 
-static int hash(struct signal_struct *sig, unsigned int nr)
+static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsigned int nr)
 {
-	return hash_32(hash32_ptr(sig) ^ nr, timer_hashbits);
+	return &timer_buckets[jhash2((u32 *)&sig, sizeof(sig) / sizeof(u32), nr) & timer_hashmask];
 }
 
 static struct k_itimer *posix_timer_by_id(timer_t id)
 {
 	struct signal_struct *sig = current->signal;
-	struct timer_hash_bucket *bucket = &timer_buckets[hash(sig, id)];
+	struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 	struct k_itimer *timer;
 
 	hlist_for_each_entry_rcu(timer, &bucket->head, t_hash) {
@@ -119,7 +119,7 @@ static bool posix_timer_hashed(struct ti
 
 static bool posix_timer_add_at(struct k_itimer *timer, struct signal_struct *sig, unsigned int id)
 {
-	struct timer_hash_bucket *bucket = &timer_buckets[hash(sig, id)];
+	struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 
 	scoped_guard (spinlock, &bucket->lock) {
 		/*
@@ -260,9 +260,9 @@ static int posix_get_hrtimer_res(clockid
 
 static __init int init_posix_timers(void)
 {
-	posix_timers_cache = kmem_cache_create("posix_timers_cache",
-					sizeof(struct k_itimer), 0,
-					SLAB_PANIC | SLAB_ACCOUNT, NULL);
+	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer),
+					       __alignof__(struct k_itimer),
+					       SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);
@@ -424,8 +424,7 @@ void posixtimer_free_timer(struct k_itim
 
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 {
-	unsigned int idx = hash(posix_sig_owner(tmr), tmr->it_id);
-	struct timer_hash_bucket *bucket = &timer_buckets[idx];
+	struct timer_hash_bucket *bucket = hash_bucket(posix_sig_owner(tmr), tmr->it_id);
 
 	scoped_guard (spinlock, &bucket->lock)
 		hlist_del_rcu(&tmr->t_hash);
@@ -1611,7 +1610,7 @@ static int __init posixtimer_init(void)
 	timer_buckets = alloc_large_system_hash("posixtimers", sizeof(*timer_buckets),
 						size, 0, 0, &shift, NULL, size, size);
 	size = 1UL << shift;
-	timer_hashbits = ilog2(size);
+	timer_hashmask = size - 1;
 
 	for (i = 0; i < size; i++) {
 		spin_lock_init(&timer_buckets[i].lock);

         

