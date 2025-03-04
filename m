Return-Path: <linux-kernel+bounces-543679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7E1A4D882
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616741779DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA547205E16;
	Tue,  4 Mar 2025 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzplkB5q"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34541204C11
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080391; cv=none; b=Q4scm5rxwhGHTj/4XPIeMVBPWOZW98HPtyL3i7xgfstdoPCJMIknSUOmJbv7iSi5dHbbElKRT/QGdpPoRfJiqUQETv6xzDq3PTFfS5EmTE+v5pLZUJC8KejIbwf5whJ2GpDP5FM2/Q8Him2BtHBz0VoJm8CHKs63mlK+ado5Bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080391; c=relaxed/simple;
	bh=ny5w6oHqV2txpuQ0MsAltkXYUEne0mzXHdXbqKiPXa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6nNtF+ULNZYFjxX/r/EKVMtQaczt2akvgPlkj1RdKAC4xpQtPEgKbyAoayPbrqvaZQVKSqGfvb7aO1m9cXjSnQJyHI/QDft0ysXo0w/96M/v4q2DVrDEONO+QeQ+ARN1XnU/4TUR+wmsNtHCUHveLVHcP9MDYbcOVNYiRD8kcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzplkB5q; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abf59b0b274so242503166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080387; x=1741685187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Oslc0Vw7rD1eBm5IrdyoxIc7gTLsk2fVXwffC4VNN0=;
        b=GzplkB5qAmFjGkOm61CeLejKHxWb6fhAoVnp6Vk4t3OelyEVkbdlnlgnXOU2KzPOuk
         3NGdQrknSOpmR/Tmywq+CCn5gqFVv1Tngg2qARQKwPmA5U3VZd1Ihe8vV7FIXxxy907S
         8aklq5Oqbob0MpxvYjGrBRfcW3XbFptiPd1RaZrprSMx1gcFS0VNpav7Gfr8YFAGcLCe
         aCCAYdx+it2pCz0otT4bWO8TQsG9yx+MJ54Gjb5P+YYCeDoBBvKZSXS6iHxV7WQY9wd5
         xWnGp21pnfRYBdSbFHrKp1rHDrH0IWSwem+YMGC7/ckiG0J2KQCRWvFeNm7EI5fN3QDd
         wlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080387; x=1741685187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Oslc0Vw7rD1eBm5IrdyoxIc7gTLsk2fVXwffC4VNN0=;
        b=LVHpjJv1OfSNT1iUNALhEQ83EuGeiPFb5Y1+PaaTArG+CvS6sDUQshgdTpOoh/7UNY
         Kegu/qIUaSEzhtRpVTIgSbBeS/ZNRFvO5ed6Y+ubTYZFeDfGVw7nvPjAWKGQukGSBiTz
         DNdbrrR2zwRUHs8XftmHZMdRJhfRsYNH7xhXJwhgne+Rrs0aEe4q/iYwQCwVPq/zH8so
         NuOpWwhxubG0/R4/a6KnUnLIBFfutzVjzY7fDAD/p1zuA4ViRth6DCUoqwF7cie7XeTR
         zztRGz5jwOYTlXUwHwTeoEuTewSVkCfPzqsaD4cN3s8o5f65JkHP2TxOm63t0Fz1ucjl
         LSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwiMCf6UvjRfbNwSmUMIaB2Gq21Yyk8h9TZQpsLlE0AYHB3kDS9P4cK41VIXSW+G0xLlzKqFAahtqZo/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CbpB2hLPc4Mw6w+hUj8t6KfaUfWK6vQM5Rw6IK47A6gTxeYn
	kVIjhkbdmqL6j685Mxu7oAec4p2daLEOF8dzUpR5yOVbXYta+qcMwYk2klz53B8ZLxSWX+OUew=
	=
X-Google-Smtp-Source: AGHT+IHtToTtakBuhP4/+sNMLQALzVHMJHtjC5HLCinrcP/6hbX3DMvKPBSJ238d92jV7XTaug7SYLQQPg==
X-Received: from ejctb24.prod.google.com ([2002:a17:907:8b98:b0:ac1:4149:808d])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:781:b0:abe:f6f5:93fa
 with SMTP id a640c23a62f3a-abf261d3b82mr1992742166b.33.1741080387611; Tue, 04
 Mar 2025 01:26:27 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:28 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-30-elver@google.com>
Subject: [PATCH v2 29/34] rhashtable: Enable capability analysis
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Enable capability analysis for rhashtable, which was used as an initial
test as it contains a combination of RCU, mutex, and bit_spinlock usage.

Users of rhashtable now also benefit from annotations on the API, which
will now warn if the RCU read lock is not held where required.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Remove disable/enable_capability_analysis() around headers.
---
 include/linux/rhashtable.h | 14 +++++++++++---
 lib/Makefile               |  2 ++
 lib/rhashtable.c           |  5 +++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 8463a128e2f4..c6374691ccc7 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -245,16 +245,17 @@ void *rhashtable_insert_slow(struct rhashtable *ht, const void *key,
 void rhashtable_walk_enter(struct rhashtable *ht,
 			   struct rhashtable_iter *iter);
 void rhashtable_walk_exit(struct rhashtable_iter *iter);
-int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires(RCU);
+int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires_shared(RCU);
 
 static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
+	__acquires_shared(RCU)
 {
 	(void)rhashtable_walk_start_check(iter);
 }
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
 void *rhashtable_walk_peek(struct rhashtable_iter *iter);
-void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
+void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases_shared(RCU);
 
 void rhashtable_free_and_destroy(struct rhashtable *ht,
 				 void (*free_fn)(void *ptr, void *arg),
@@ -325,6 +326,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket_insert(
 
 static inline unsigned long rht_lock(struct bucket_table *tbl,
 				     struct rhash_lock_head __rcu **bkt)
+	__acquires(__bitlock(0, bkt))
 {
 	unsigned long flags;
 
@@ -337,6 +339,7 @@ static inline unsigned long rht_lock(struct bucket_table *tbl,
 static inline unsigned long rht_lock_nested(struct bucket_table *tbl,
 					struct rhash_lock_head __rcu **bucket,
 					unsigned int subclass)
+	__acquires(__bitlock(0, bucket))
 {
 	unsigned long flags;
 
@@ -349,6 +352,7 @@ static inline unsigned long rht_lock_nested(struct bucket_table *tbl,
 static inline void rht_unlock(struct bucket_table *tbl,
 			      struct rhash_lock_head __rcu **bkt,
 			      unsigned long flags)
+	__releases(__bitlock(0, bkt))
 {
 	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(0, (unsigned long *)bkt);
@@ -402,13 +406,14 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
 				     struct rhash_lock_head __rcu **bkt,
 				     struct rhash_head *obj,
 				     unsigned long flags)
+	__releases(__bitlock(0, bkt))
 {
 	if (rht_is_a_nulls(obj))
 		obj = NULL;
 	lock_map_release(&tbl->dep_map);
 	rcu_assign_pointer(*bkt, (void *)obj);
 	preempt_enable();
-	__release(bitlock);
+	__release(__bitlock(0, bkt));
 	local_irq_restore(flags);
 }
 
@@ -589,6 +594,7 @@ static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
 static inline struct rhash_head *__rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhashtable_compare_arg arg = {
 		.ht = ht,
@@ -642,6 +648,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 static inline void *rhashtable_lookup(
 	struct rhashtable *ht, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he = __rhashtable_lookup(ht, key, params);
 
@@ -692,6 +699,7 @@ static inline void *rhashtable_lookup_fast(
 static inline struct rhlist_head *rhltable_lookup(
 	struct rhltable *hlt, const void *key,
 	const struct rhashtable_params params)
+	__must_hold_shared(RCU)
 {
 	struct rhash_head *he = __rhashtable_lookup(&hlt->ht, key, params);
 
diff --git a/lib/Makefile b/lib/Makefile
index f40ba93c9a94..c7004270ad5f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -45,6 +45,8 @@ lib-$(CONFIG_MIN_HEAP) += min_heap.o
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
 
+CAPABILITY_ANALYSIS_rhashtable.o := y
+
 obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 3e555d012ed6..fe8dd776837c 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -358,6 +358,7 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 static int rhashtable_rehash_alloc(struct rhashtable *ht,
 				   struct bucket_table *old_tbl,
 				   unsigned int size)
+	__must_hold(&ht->mutex)
 {
 	struct bucket_table *new_tbl;
 	int err;
@@ -392,6 +393,7 @@ static int rhashtable_rehash_alloc(struct rhashtable *ht,
  * bucket locks or concurrent RCU protected lookups and traversals.
  */
 static int rhashtable_shrink(struct rhashtable *ht)
+	__must_hold(&ht->mutex)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	unsigned int nelems = atomic_read(&ht->nelems);
@@ -724,7 +726,7 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_exit);
  * resize events and always continue.
  */
 int rhashtable_walk_start_check(struct rhashtable_iter *iter)
-	__acquires(RCU)
+	__acquires_shared(RCU)
 {
 	struct rhashtable *ht = iter->ht;
 	bool rhlist = ht->rhlist;
@@ -940,7 +942,6 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_peek);
  * hash table.
  */
 void rhashtable_walk_stop(struct rhashtable_iter *iter)
-	__releases(RCU)
 {
 	struct rhashtable *ht;
 	struct bucket_table *tbl = iter->walker.tbl;
-- 
2.48.1.711.g2feabab25a-goog


