Return-Path: <linux-kernel+bounces-569873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4BEA6A88E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4166C3AF869
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6971DEFFC;
	Thu, 20 Mar 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXQ/t/fw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6171DE4DB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481096; cv=none; b=Z/bY13ioa8y+6koO5j5uV30dnJNnhGCcqos8RDjr8Jqh8GlWvd8FV7gmX5m705qc4abK5+cp8oCU1M/bsHGvkCoI03FRjc9OLYo6t5rCQVVmL4BcYMXeKM6nfShogbpkFaO7bcED0fXDIwf7BvmYrUQs2wNwmzpcYSJnNAj/Rew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481096; c=relaxed/simple;
	bh=ybL2FMIfsMa8yXccByn/80EiwESQguHm4rO3MRAKZZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/6QWw4NQOKQivWPqKyOzzpsjTN+oJX9mJWGJYrKOuamuo+CsCcydZ9h8cS8u231MW828KiaYZmfRjjxQkmqa7MjtRqMQWplXogxEvtBJ8MyIewEaZoEuhgSEcdOBZ3Xx3cQsxm+WkH7vWVpIeSAK5RFSpuVMv9ZPK6HFXND8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXQ/t/fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124A0C4CEEC;
	Thu, 20 Mar 2025 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481095;
	bh=ybL2FMIfsMa8yXccByn/80EiwESQguHm4rO3MRAKZZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXQ/t/fwR2J2CeGFyhCaVaPU93QZJ0HKt1p0lqWqnygHgA83GrLfwk5kMAtHRDHx3
	 JVL/7gdKQvhHTK36GuKu7occhD6XGU9wJbjY1VcURipC3vu2+QnEqYgRMyWKSHFJkb
	 xa/i0CAycipA9q2WpXAq0+fqKV1LhyNWF1c9AKLWO2XaajpXBvH1T9+xfvRkgCpOJk
	 QKnSCo5bWPPVeiKZfo4bAhx1XSs0uIruyvJ8t0uJa3tBzM/88mToWGM46TyS8c9/UH
	 fhP5fYLdOAYf+DnWe0nR0TBadI64M80FR/zE/UCU4YH5w33wKayNTYX/Tf5PmClFNo
	 UE5iyBBWA0WZw==
From: Sasha Levin <sashal@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Cc: longman@redhat.com,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3/4] locking/lockdep: Use hashtable.h for chainhash_table
Date: Thu, 20 Mar 2025 10:31:19 -0400
Message-Id: <20250320143120.3119975-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320143120.3119975-1-sashal@kernel.org>
References: <20250320143120.3119975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert chainhash_table in lockdep.c to use the generic hashtable
implementation from hashtable.h instead of the manual hlist_head array
implementation.

This simplifies the code and makes it more maintainable by using the
standard hashtable API and removes the need for custom hash lookup
functions.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b071bbf0d955c..151fec00f1c2c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -412,11 +412,7 @@ static DEFINE_HASHTABLE(classhash_table, CLASSHASH_BITS);
  * their existence:
  */
 #define CHAINHASH_BITS		(MAX_LOCKDEP_CHAINS_BITS-1)
-#define CHAINHASH_SIZE		(1UL << CHAINHASH_BITS)
-#define __chainhashfn(chain)	hash_long(chain, CHAINHASH_BITS)
-#define chainhashentry(chain)	(chainhash_table + __chainhashfn((chain)))
-
-static struct hlist_head chainhash_table[CHAINHASH_SIZE];
+DEFINE_HASHTABLE(chainhash_table, CHAINHASH_BITS);
 
 /*
  * the id of held_lock
@@ -3716,7 +3712,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 				  struct held_lock *hlock,
 				  u64 chain_key)
 {
-	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 	int i, j;
 
@@ -3767,7 +3762,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 		chain_hlocks[chain->base + j] = lock_id;
 	}
 	chain_hlocks[chain->base + j] = hlock_id(hlock);
-	hlist_add_head_rcu(&chain->entry, hash_head);
+	hash_add_rcu(chainhash_table, &chain->entry, chain_key);
 	debug_atomic_inc(chain_lookup_misses);
 	inc_chains(chain->irq_context);
 
@@ -3780,10 +3775,9 @@ static inline int add_chain_cache(struct task_struct *curr,
  */
 static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 {
-	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 
-	hlist_for_each_entry_rcu(chain, hash_head, entry) {
+	hash_for_each_possible_rcu(chainhash_table, chain, entry, chain_key) {
 		if (READ_ONCE(chain->chain_key) == chain_key) {
 			debug_atomic_inc(chain_lookup_hits);
 			return chain;
@@ -6142,7 +6136,6 @@ EXPORT_SYMBOL_GPL(lock_acquired);
 void lockdep_reset(void)
 {
 	unsigned long flags;
-	int i;
 
 	raw_local_irq_save(flags);
 	lockdep_init_task(current);
@@ -6151,8 +6144,7 @@ void lockdep_reset(void)
 	nr_softirq_chains = 0;
 	nr_process_chains = 0;
 	debug_locks = 1;
-	for (i = 0; i < CHAINHASH_SIZE; i++)
-		INIT_HLIST_HEAD(chainhash_table + i);
+	hash_init(chainhash_table);
 	raw_local_irq_restore(flags);
 }
 
@@ -6183,10 +6175,10 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	dec_chains(chain->irq_context);
 
 	/*
-	 * Note: calling hlist_del_rcu() from inside a
-	 * hlist_for_each_entry_rcu() loop is safe.
+	 * Note: calling hash_del_rcu() from inside a
+	 * hash_for_each_rcu() loop is safe.
 	 */
-	hlist_del_rcu(&chain->entry);
+	hash_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
 	nr_zapped_lock_chains++;
 #endif
@@ -6229,7 +6221,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 	if (list_empty(&class->locks_after) &&
 	    list_empty(&class->locks_before)) {
 		list_move_tail(&class->lock_entry, &pf->zapped);
-		hlist_del_rcu(&class->hash_entry);
+		hash_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
 		nr_lock_classes--;
@@ -6587,7 +6579,7 @@ void __init lockdep_init(void)
 	pr_info("... CLASSHASH_SIZE:          %lu\n", HASH_SIZE(classhash_table));
 	pr_info("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
 	pr_info("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
-	pr_info("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
+	pr_info("... CHAINHASH_SIZE:          %lu\n", HASH_SIZE(chainhash_table));
 
 	pr_info(" memory used by lock dependency info: %zu kB\n",
 	       (sizeof(lock_classes) +
-- 
2.39.5


