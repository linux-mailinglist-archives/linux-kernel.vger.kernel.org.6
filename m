Return-Path: <linux-kernel+bounces-568621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC6A6987E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BA6171704
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE720E028;
	Wed, 19 Mar 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2X+MK+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9101F4164
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410646; cv=none; b=UsOO7rp3cBQR7naf4S6hUJcv490Vh3fkJEE3rJD2w/JaMgyD91f2qip5T0dPpasX1ibtIpqj/tLqTqCC8lhlT+k30fMj9StqckFWAIJ2hnRIJHXatI1HsvzSrTN0AHvKkIw+8C54T48WbNf4EKCD2iQpwodyfnnPd3RlFeG6atM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410646; c=relaxed/simple;
	bh=REEwXTdkDeMX0tVAQJHqxxvlqF3mvRB67Zb9AM+3ro8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+jXXSfHJrIA5ySDlUFSeGjfvSKTxTCF/EFbLDWImKJnECYCdHQ4KVZszXpjwFqgXRv6YnbhF+qt9fS6pUhYVWp25Zx8lCgFACl/Ot+K4CzU3DMVLT8VT7faC2/Nt3pROWOgvwgW+krCG/B7AxEXXIOfYEd5bKcKwYW40hO1VIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2X+MK+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F19C4CEE9;
	Wed, 19 Mar 2025 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742410645;
	bh=REEwXTdkDeMX0tVAQJHqxxvlqF3mvRB67Zb9AM+3ro8=;
	h=From:To:Cc:Subject:Date:From;
	b=L2X+MK+qpqyK3SNhqrCXgcXdF6u9bBk5tn7vF8U+k7a1kdqAVYnSv5Nf66lDyNHcK
	 VHH99IU8TFWIi3D/OExtdYIeBTx9gSj71rZxIAICjd1z6p9CV1XcGy/YUJtoWacEfz
	 PewOZ2QpmpVN28ZsBahzCojlFkQKWG5Nvc4arrwok0EJxcRX6nPn66eByO4rIfI95J
	 XxJjhtWDwwuOu6IXUwkGT82xGT7JMHXFM/pX8v8FYhLwA7rL2UbIbt2dyjUDfwQBXb
	 YvxXqtuK8Ti07b9RsrAlA0a5B2aYNSoy2Wq2tSCV5FFlxneptOLRhSKkwoERlxzRFE
	 U0rXZx+9I0xqA==
From: Sasha Levin <sashal@kernel.org>
To: pmladek@suse.com,
	yoann.congal@smile.fr,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Sasha Levin <levinsasha928@gmail.com>
Subject: [PATCH] user: Use hashtable.h instead of manual hashtable implementation
Date: Wed, 19 Mar 2025 14:57:11 -0400
Message-Id: <20250319185711.3055630-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the UID hashtable in kernel/user.c to use the generic hashtable
implementation from hashtable.h instead of the manual approach with
hardcoded hlist_head array and custom hash functions.

This simplifies the code and makes it more maintainable by using the
standard hashtable API defined in hashtable.h.

Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 kernel/user.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/kernel/user.c b/kernel/user.c
index f46b1d41163b2..e54b409068f00 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -20,6 +20,7 @@
 #include <linux/user_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/proc_ns.h>
+#include <linux/hashtable.h>
 
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 struct binfmt_misc init_binfmt_misc = {
@@ -89,13 +90,9 @@ EXPORT_SYMBOL_GPL(init_user_ns);
  */
 
 #define UIDHASH_BITS	(IS_ENABLED(CONFIG_BASE_SMALL) ? 3 : 7)
-#define UIDHASH_SZ	(1 << UIDHASH_BITS)
-#define UIDHASH_MASK		(UIDHASH_SZ - 1)
-#define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
-#define uidhashentry(uid)	(uidhash_table + __uidhashfn((__kuid_val(uid))))
 
 static struct kmem_cache *uid_cachep;
-static struct hlist_head uidhash_table[UIDHASH_SZ];
+static DEFINE_HASHTABLE(uidhash_table, UIDHASH_BITS);
 
 /*
  * The uidhash_lock is mostly taken from process context, but it is
@@ -118,21 +115,21 @@ struct user_struct root_user = {
 /*
  * These routines must be called with the uidhash spinlock held!
  */
-static void uid_hash_insert(struct user_struct *up, struct hlist_head *hashent)
+static void uid_hash_insert(struct user_struct *up)
 {
-	hlist_add_head(&up->uidhash_node, hashent);
+	hash_add(uidhash_table, &up->uidhash_node, __kuid_val(up->uid));
 }
 
 static void uid_hash_remove(struct user_struct *up)
 {
-	hlist_del_init(&up->uidhash_node);
+	hash_del(&up->uidhash_node);
 }
 
-static struct user_struct *uid_hash_find(kuid_t uid, struct hlist_head *hashent)
+static struct user_struct *uid_hash_find(kuid_t uid)
 {
 	struct user_struct *user;
 
-	hlist_for_each_entry(user, hashent, uidhash_node) {
+	hash_for_each_possible(uidhash_table, user, uidhash_node, __kuid_val(uid)) {
 		if (uid_eq(user->uid, uid)) {
 			refcount_inc(&user->__count);
 			return user;
@@ -183,7 +180,7 @@ struct user_struct *find_user(kuid_t uid)
 	unsigned long flags;
 
 	spin_lock_irqsave(&uidhash_lock, flags);
-	ret = uid_hash_find(uid, uidhashentry(uid));
+	ret = uid_hash_find(uid);
 	spin_unlock_irqrestore(&uidhash_lock, flags);
 	return ret;
 }
@@ -202,11 +199,10 @@ EXPORT_SYMBOL_GPL(free_uid);
 
 struct user_struct *alloc_uid(kuid_t uid)
 {
-	struct hlist_head *hashent = uidhashentry(uid);
 	struct user_struct *up, *new;
 
 	spin_lock_irq(&uidhash_lock);
-	up = uid_hash_find(uid, hashent);
+	up = uid_hash_find(uid);
 	spin_unlock_irq(&uidhash_lock);
 
 	if (!up) {
@@ -228,12 +224,12 @@ struct user_struct *alloc_uid(kuid_t uid)
 		 * on adding the same user already..
 		 */
 		spin_lock_irq(&uidhash_lock);
-		up = uid_hash_find(uid, hashent);
+		up = uid_hash_find(uid);
 		if (up) {
 			user_epoll_free(new);
 			kmem_cache_free(uid_cachep, new);
 		} else {
-			uid_hash_insert(new, hashent);
+			uid_hash_insert(new);
 			up = new;
 		}
 		spin_unlock_irq(&uidhash_lock);
@@ -244,20 +240,15 @@ struct user_struct *alloc_uid(kuid_t uid)
 
 static int __init uid_cache_init(void)
 {
-	int n;
-
 	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
 
-	for(n = 0; n < UIDHASH_SZ; ++n)
-		INIT_HLIST_HEAD(uidhash_table + n);
-
 	if (user_epoll_alloc(&root_user))
 		panic("root_user epoll percpu counter alloc failed");
 
 	/* Insert the root user immediately (init already runs as root) */
 	spin_lock_irq(&uidhash_lock);
-	uid_hash_insert(&root_user, uidhashentry(GLOBAL_ROOT_UID));
+	uid_hash_insert(&root_user);
 	spin_unlock_irq(&uidhash_lock);
 
 	return 0;
-- 
2.39.5


