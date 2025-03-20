Return-Path: <linux-kernel+bounces-569871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E6A6A8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B23D188B1B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA561C3BE0;
	Thu, 20 Mar 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ppzq/esH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4D2628C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481094; cv=none; b=c7TLRt7Chdf5ptoteLmeyiqVH1NwGZ0HklD0VOx74YNf/npTwR7LnHD+CdeOv0DayQl7Ew3UIMIPPteVaFlPSVRIdC8mk3aKIp/+M89BBSUSHb9OEGgaCgD4T2mBNFZ/Nen0rh19Q1fTy/5NKLo01ES5whOMNAJw7IySJAW5Qy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481094; c=relaxed/simple;
	bh=Vx0C2iBsMJCWQbziRbl/6eLzp3RBdrGwAhwsCETF1HI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z4ybZv8aTPiPBP/41upCrYUo546EwoSFwLF8HOBfX99W6yxfpaWibML+Wxk8CiWI7IvvIYJJXowyoqrkch79pRn9SQfu5AfuqqHFpwjBT+wG1+rIgHhkBLwYApNT801coKu9YlcZ0sIeaWDfOyFUW/HgIgKr0WD2bxO6ptS9Gng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ppzq/esH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C0C4CEDD;
	Thu, 20 Mar 2025 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481093;
	bh=Vx0C2iBsMJCWQbziRbl/6eLzp3RBdrGwAhwsCETF1HI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ppzq/esHK1039JduthYDXD+qMC1umN1/PIZbHCar9NYlOTveNWXA3oFvFRCa8cubO
	 Vy1svqt37yhw9yXmidB7PR3gby4xIfGR5hnNGLoR6j1z7HARwlDq2tSi6D5Sfpc2hf
	 0ZNEBhJcidHwC5onYDS9r/C6xUFvfEO0V+Klzze9zr0sHrMSSnTapsK2d3lSf+gpyY
	 NJmaNuDy1IVX3u3aaD05/bdvhLHHezOD4iuAEYUS0kv9BS++GmMzyweJiceg9EOo5x
	 hdmh6fAswQaEpm0K7HntngZ9bg+TuvjokIwpgHG9Tw/ubRKhhP7x/e/OKYy2BT0mmc
	 tglyx2JPdVN/g==
From: Sasha Levin <sashal@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Cc: longman@redhat.com,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 1/4] locking/lockdep: Use hashtable.h for lock_keys_hash
Date: Thu, 20 Mar 2025 10:31:17 -0400
Message-Id: <20250320143120.3119975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the lock_keys_hash array in lockdep.c to use the generic
hashtable implementation from hashtable.h instead of the manual
hlist_head array implementation.

This simplifies the code and makes it more maintainable by using the
standard hashtable API defined in hashtable.h, while preserving the
RCU-safe behavior with proper RCU variants of the hashtable functions.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680f02269..160cf8310eda0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -57,6 +57,7 @@
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
 #include <linux/console.h>
+#include <linux/hashtable.h>
 
 #include <asm/sections.h>
 
@@ -212,8 +213,7 @@ static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
  * in use.
  */
 #define KEYHASH_BITS		(MAX_LOCKDEP_KEYS_BITS - 1)
-#define KEYHASH_SIZE		(1UL << KEYHASH_BITS)
-static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
+static DEFINE_HASHTABLE(lock_keys_hash, KEYHASH_BITS);
 unsigned long nr_lock_classes;
 unsigned long nr_zapped_classes;
 unsigned long max_lock_class_idx;
@@ -1209,32 +1209,28 @@ static void init_data_structures_once(void)
 	init_chain_block_buckets();
 }
 
-static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
-{
-	unsigned long hash = hash_long((uintptr_t)key, KEYHASH_BITS);
-
-	return lock_keys_hash + hash;
-}
 
 /* Register a dynamically allocated key. */
 void lockdep_register_key(struct lock_class_key *key)
 {
-	struct hlist_head *hash_head;
 	struct lock_class_key *k;
+	unsigned long hash;
 	unsigned long flags;
 
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
-	hash_head = keyhashentry(key);
+
+	hash = hash_long((uintptr_t)key, KEYHASH_BITS);
 
 	raw_local_irq_save(flags);
 	if (!graph_lock())
 		goto restore_irqs;
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+
+	hash_for_each_possible_rcu(lock_keys_hash, k, hash_entry, hash) {
 		if (WARN_ON_ONCE(k == key))
 			goto out_unlock;
 	}
-	hlist_add_head_rcu(&key->hash_entry, hash_head);
+	hash_add_rcu(lock_keys_hash, &key->hash_entry, hash);
 out_unlock:
 	graph_unlock();
 restore_irqs:
@@ -1245,8 +1241,8 @@ EXPORT_SYMBOL_GPL(lockdep_register_key);
 /* Check whether a key has been registered as a dynamic key. */
 static bool is_dynamic_key(const struct lock_class_key *key)
 {
-	struct hlist_head *hash_head;
 	struct lock_class_key *k;
+	unsigned long hash;
 	bool found = false;
 
 	if (WARN_ON_ONCE(static_obj(key)))
@@ -1260,10 +1256,10 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 	if (!debug_locks)
 		return true;
 
-	hash_head = keyhashentry(key);
+	hash = hash_long((uintptr_t)key, KEYHASH_BITS);
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+	hash_for_each_possible_rcu(lock_keys_hash, k, hash_entry, hash) {
 		if (k == key) {
 			found = true;
 			break;
@@ -6561,9 +6557,9 @@ void lockdep_reset_lock(struct lockdep_map *lock)
  */
 void lockdep_unregister_key(struct lock_class_key *key)
 {
-	struct hlist_head *hash_head = keyhashentry(key);
 	struct lock_class_key *k;
 	struct pending_free *pf;
+	unsigned long hash;
 	unsigned long flags;
 	bool found = false;
 	bool need_callback = false;
@@ -6573,12 +6569,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 
+	hash = hash_long((uintptr_t)key, KEYHASH_BITS);
+
 	raw_local_irq_save(flags);
 	lockdep_lock();
 
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+	hash_for_each_possible(lock_keys_hash, k, hash_entry, hash) {
 		if (k == key) {
-			hlist_del_rcu(&k->hash_entry);
+			hash_del_rcu(&k->hash_entry);
 			found = true;
 			break;
 		}
-- 
2.39.5


