Return-Path: <linux-kernel+bounces-569872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A2A6A88B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625033AEB42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148931DE3A9;
	Thu, 20 Mar 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+Tw2iKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4701BD9E3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481095; cv=none; b=c88vFhgBFLuCZaBIbvIYhJ9S5DfCQ23XouTSak/TCN6i8faaJWjyfbDZ5n6B6rM9ePKCEobZ+9ARE8Uf9HtNX2LijccG2IDQtTmMyZCTu/tC4BaUvw/KaD24r3Yoqktv7WoBwSPXjckxaepW5ytlNSOLKHcZRKbEH50WkOC7LNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481095; c=relaxed/simple;
	bh=575q0JjfPO2Zf/qskDv6/YDS5vP+Uz+dcnGYtx4FlOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3qo6UhnnDErif4MdMaNHXuVrXyP0NOqpqKs9AKfeV2XeTtIMaqsIBz5EUNA3FN9jj59bdeh+9FVQR470aEMlHQvANngmj5GhauUO8h6F6p1kVq9TcgxBKbQ+aamOdl9QxscXePDKKeOahUeUIPxrp9hH0cfn5I3rnBzYo2vUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+Tw2iKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB1EC4CEE3;
	Thu, 20 Mar 2025 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481094;
	bh=575q0JjfPO2Zf/qskDv6/YDS5vP+Uz+dcnGYtx4FlOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+Tw2iKFmrzNApmgFSi85anEWRKGIj7eOkt/4UKLYXDFywxctvlVoJdyIGGe+F6FV
	 6BATJYsnI6ZvM6PwavPXfoHZiTjfI2XJJ8HI1kIFCakgPBitFEP7DuDI7/5qhdKuPl
	 YcAS04Kitf033Z7Bf7mFzp0ICS/btsypYftvIYwv39g8scL5Jaa+eO5K2Sepu6Po7b
	 QqID8lVSNrPEh3xCCDGcQCZnKE7v1XNPIjyU6/bPc1pAh9TcOHvomJ3PRBSAsLHIzI
	 +fPL+gFEZtbY0Ibl9Ihhrdx0Tlhpmkk23JWJwIGVtdyWYoMfJ2lpt/GYMRnDNpVUN+
	 Nf+ltafdOzwBA==
From: Sasha Levin <sashal@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Cc: longman@redhat.com,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 2/4] locking/lockdep: Use hashtable.h for classhash_table
Date: Thu, 20 Mar 2025 10:31:18 -0400
Message-Id: <20250320143120.3119975-2-sashal@kernel.org>
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

Convert classhash_table in lockdep.c to use the generic hashtable
implementation from hashtable.h instead of the manual hlist_head array
implementation.

This simplifies the code and makes it more maintainable by using the
standard hashtable API and removes the need for custom hash lookup
functions.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 69 ++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 45 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 160cf8310eda0..b071bbf0d955c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -404,12 +404,8 @@ static struct delayed_free {
 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
  */
-#define CLASSHASH_BITS		(MAX_LOCKDEP_KEYS_BITS - 1)
-#define CLASSHASH_SIZE		(1UL << CLASSHASH_BITS)
-#define __classhashfn(key)	hash_long((unsigned long)key, CLASSHASH_BITS)
-#define classhashentry(key)	(classhash_table + __classhashfn((key)))
-
-static struct hlist_head classhash_table[CLASSHASH_SIZE];
+#define CLASSHASH_BITS		(MAX_LOCKDEP_KEYS_BITS-1)
+static DEFINE_HASHTABLE(classhash_table, CLASSHASH_BITS);
 
 /*
  * We put the lock dependency chains into a hash-table as well, to cache
@@ -886,8 +882,8 @@ static noinstr struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
 	struct lockdep_subclass_key *key;
-	struct hlist_head *hash_head;
 	struct lock_class *class;
+	unsigned long hash;
 
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
 		instrumentation_begin();
@@ -920,8 +916,7 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 			sizeof(struct lockdep_map));
 
 	key = lock->key->subkeys + subclass;
-
-	hash_head = classhashentry(key);
+	hash = (unsigned long)key;
 
 	/*
 	 * We do an RCU walk of the hash, see lockdep_free_key_range().
@@ -929,7 +924,7 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	hlist_for_each_entry_rcu_notrace(class, hash_head, hash_entry) {
+	hash_for_each_possible_rcu_notrace(classhash_table, class, hash_entry, hash) {
 		if (class->key == key) {
 			/*
 			 * Huh! same key, different name? Did someone trample
@@ -1084,7 +1079,6 @@ static bool __check_data_structures(void)
 {
 	struct lock_class *class;
 	struct lock_chain *chain;
-	struct hlist_head *head;
 	struct lock_list *e;
 	int i;
 
@@ -1110,12 +1104,9 @@ static bool __check_data_structures(void)
 	}
 
 	/* Check the chain_key of all lock chains. */
-	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
-		head = chainhash_table + i;
-		hlist_for_each_entry_rcu(chain, head, entry) {
-			if (!check_lock_chain_key(chain))
-				return false;
-		}
+	hash_for_each_rcu(chainhash_table, i, chain, entry) {
+		if (!check_lock_chain_key(chain))
+			return false;
 	}
 
 	/*
@@ -1279,8 +1270,8 @@ static struct lock_class *
 register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 {
 	struct lockdep_subclass_key *key;
-	struct hlist_head *hash_head;
 	struct lock_class *class;
+	unsigned long hash;
 	int idx;
 
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
@@ -1297,7 +1288,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	}
 
 	key = lock->key->subkeys + subclass;
-	hash_head = classhashentry(key);
+	hash = (unsigned long)key;
 
 	if (!graph_lock()) {
 		return NULL;
@@ -1306,7 +1297,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	 * We have to do the hash-walk again, to avoid races
 	 * with another CPU:
 	 */
-	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
+	hash_for_each_possible_rcu(classhash_table, class, hash_entry, hash) {
 		if (class->key == key)
 			goto out_unlock_set;
 	}
@@ -1343,7 +1334,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	 * We use RCU's safe list-add method to make
 	 * parallel walking of the hash-list safe:
 	 */
-	hlist_add_head_rcu(&class->hash_entry, hash_head);
+	hash_add_rcu(classhash_table, &class->hash_entry, hash);
 	/*
 	 * Remove the class from the free list and add it to the global list
 	 * of classes.
@@ -6206,14 +6197,10 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 					  struct lock_class *class)
 {
 	struct lock_chain *chain;
-	struct hlist_head *head;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
-		head = chainhash_table + i;
-		hlist_for_each_entry_rcu(chain, head, entry) {
-			remove_class_from_lock_chain(pf, chain, class);
-		}
+	hash_for_each_rcu(chainhash_table, i, chain, entry) {
+		remove_class_from_lock_chain(pf, chain, class);
 	}
 }
 
@@ -6370,18 +6357,14 @@ static void __lockdep_free_key_range(struct pending_free *pf, void *start,
 				     unsigned long size)
 {
 	struct lock_class *class;
-	struct hlist_head *head;
 	int i;
 
 	/* Unhash all classes that were created by a module. */
-	for (i = 0; i < CLASSHASH_SIZE; i++) {
-		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			if (!within(class->key, start, size) &&
-			    !within(class->name, start, size))
-				continue;
-			zap_class(pf, class);
-		}
+	hash_for_each_rcu(classhash_table, i, class, hash_entry) {
+		if (!within(class->key, start, size) &&
+		    !within(class->name, start, size))
+			continue;
+		zap_class(pf, class);
 	}
 }
 
@@ -6454,16 +6437,12 @@ void lockdep_free_key_range(void *start, unsigned long size)
 static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 {
 	struct lock_class *class;
-	struct hlist_head *head;
 	int i, j;
 
-	for (i = 0; i < CLASSHASH_SIZE; i++) {
-		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
-				if (lock->class_cache[j] == class)
-					return true;
-		}
+	hash_for_each_rcu(classhash_table, i, class, hash_entry) {
+		for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
+			if (lock->class_cache[j] == class)
+				return true;
 	}
 	return false;
 }
@@ -6605,7 +6584,7 @@ void __init lockdep_init(void)
 	pr_info("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
 	pr_info("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
 	pr_info("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
-	pr_info("... CLASSHASH_SIZE:          %lu\n", CLASSHASH_SIZE);
+	pr_info("... CLASSHASH_SIZE:          %lu\n", HASH_SIZE(classhash_table));
 	pr_info("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
 	pr_info("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
 	pr_info("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
-- 
2.39.5


