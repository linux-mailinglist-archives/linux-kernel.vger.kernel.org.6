Return-Path: <linux-kernel+bounces-568607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F0A6983E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD51917196C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50020C48F;
	Wed, 19 Mar 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO84p6mh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9693208969
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409779; cv=none; b=DlZImstdGYkuQVCD910HOohf7mGksrrmCPqqbCNDefMoJDmGKrEMIDtJz0ALFbAJ3R7Q0o/xWFVr3NkpK2IulvjmeLcZ6pI5g1vaoVEw6NOtHcfFUbyhdmxpto+ibm0vWUl3VGncE/+fEPx4wLOnd6TzvjrurnPc690lTCDn6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409779; c=relaxed/simple;
	bh=R2wswgTSA1DkDh1GSmSRDeFGUKwCPM0Q3B5R4B/AV5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWDN5l/zirGVIALRdJL0uZzjkBwnbzZBVUFGkST4bt6gY1DEbLUaO2COvawmG+Yiws2W1k7xH9RJjLE1LyRu7P+QYxqxidX1/rXAQHIcgatdAPy0fDrI02941KtjVclMXQbKYCdMbG7qfhSgCWRsg7GPw69dukSMxmzJZCBR5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO84p6mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC56DC4CEE4;
	Wed, 19 Mar 2025 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742409779;
	bh=R2wswgTSA1DkDh1GSmSRDeFGUKwCPM0Q3B5R4B/AV5U=;
	h=From:To:Cc:Subject:Date:From;
	b=kO84p6mhDDCPz0w9ge1wDPs+7oZxIdXe+dSr4dXs09DqocoO7fEHiEugftFMmsG9X
	 hjJFOzND2YzoWx/EAV2f/G2EylZBok1B1IiNLR0niGJV39qgr1txRUh8+B+HcxWj+y
	 o6vxJBB17hKZ0QLyXX3vkKjXFK0os38HN4gdtZke+CCtZ+gSyuxFkIkTl5+a8gi9o3
	 dFylwS3ZtKhouCq4xf1hVTiViADagg17AAmXR8+If1jC+bcOhMnuftRyH6sD27uvzk
	 4Jv1mY+OmajxAJislv0XswZGfmaItDFoHqDebo4SI2jhul4++OxrNdTKBm01KhtFE1
	 yQWukMX2Fxs2Q==
From: Sasha Levin <sashal@kernel.org>
To: joel.granados@kernel.org,
	akpm@linux-foundation.org,
	linux@weissschuh.net
Cc: linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] ucount: Convert ucounts hashtable to use hashtable.h API
Date: Wed, 19 Mar 2025 14:42:45 -0400
Message-Id: <20250319184245.3052913-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the manual hashtable implementation in kernel/ucount.c to use
the standard hashtable.h interface. This simplifies the code by:

- Replacing custom hlist_head array with DEFINE_HASHTABLE
- Removing ucounts_hashfn and ucounts_hashentry macros
- Using hash_add, hash_del, and hash_for_each_possible instead of manual
  hlist operations

This conversion makes the code more maintainable by using the standard
hashtable implementation while preserving the same functionality.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/ucount.c | 74 +++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 43 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 86c5f1c0bad90..db4c1a8534b33 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -7,6 +7,7 @@
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/user_namespace.h>
+#include <linux/hashtable.h>
 
 struct ucounts init_ucounts = {
 	.ns    = &init_user_ns,
@@ -15,16 +16,9 @@ struct ucounts init_ucounts = {
 };
 
 #define UCOUNTS_HASHTABLE_BITS 10
-static struct hlist_head ucounts_hashtable[(1 << UCOUNTS_HASHTABLE_BITS)];
+static DEFINE_HASHTABLE(ucounts_hashtable, UCOUNTS_HASHTABLE_BITS);
 static DEFINE_SPINLOCK(ucounts_lock);
 
-#define ucounts_hashfn(ns, uid)						\
-	hash_long((unsigned long)__kuid_val(uid) + (unsigned long)(ns), \
-		  UCOUNTS_HASHTABLE_BITS)
-#define ucounts_hashentry(ns, uid)	\
-	(ucounts_hashtable + ucounts_hashfn(ns, uid))
-
-
 #ifdef CONFIG_SYSCTL
 static struct ctl_table_set *
 set_lookup(struct ctl_table_root *root)
@@ -127,22 +121,13 @@ void retire_userns_sysctls(struct user_namespace *ns)
 #endif
 }
 
-static struct ucounts *find_ucounts(struct user_namespace *ns, kuid_t uid, struct hlist_head *hashent)
-{
-	struct ucounts *ucounts;
-
-	hlist_for_each_entry(ucounts, hashent, node) {
-		if (uid_eq(ucounts->uid, uid) && (ucounts->ns == ns))
-			return ucounts;
-	}
-	return NULL;
-}
-
 static void hlist_add_ucounts(struct ucounts *ucounts)
 {
-	struct hlist_head *hashent = ucounts_hashentry(ucounts->ns, ucounts->uid);
+	unsigned long hash_key = (unsigned long)__kuid_val(ucounts->uid) +
+				(unsigned long)(ucounts->ns);
+
 	spin_lock_irq(&ucounts_lock);
-	hlist_add_head(&ucounts->node, hashent);
+	hash_add(ucounts_hashtable, &ucounts->node, hash_key);
 	spin_unlock_irq(&ucounts_lock);
 }
 
@@ -163,33 +148,36 @@ struct ucounts *get_ucounts(struct ucounts *ucounts)
 
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
-	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
+	unsigned long hash_key = (unsigned long)__kuid_val(uid) + (unsigned long)(ns);
 	bool wrapped;
 	struct ucounts *ucounts, *new = NULL;
 
 	spin_lock_irq(&ucounts_lock);
-	ucounts = find_ucounts(ns, uid, hashent);
-	if (!ucounts) {
-		spin_unlock_irq(&ucounts_lock);
-
-		new = kzalloc(sizeof(*new), GFP_KERNEL);
-		if (!new)
-			return NULL;
-
-		new->ns = ns;
-		new->uid = uid;
-		atomic_set(&new->count, 1);
-
-		spin_lock_irq(&ucounts_lock);
-		ucounts = find_ucounts(ns, uid, hashent);
-		if (!ucounts) {
-			hlist_add_head(&new->node, hashent);
-			get_user_ns(new->ns);
-			spin_unlock_irq(&ucounts_lock);
-			return new;
-		}
+	hash_for_each_possible(ucounts_hashtable, ucounts, node, hash_key) {
+		if (uid_eq(ucounts->uid, uid) && (ucounts->ns == ns))
+			goto found;
+	}
+	spin_unlock_irq(&ucounts_lock);
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	new->ns = ns;
+	new->uid = uid;
+	atomic_set(&new->count, 1);
+
+	spin_lock_irq(&ucounts_lock);
+	hash_for_each_possible(ucounts_hashtable, ucounts, node, hash_key) {
+		if (uid_eq(ucounts->uid, uid) && (ucounts->ns == ns))
+			goto found;
 	}
+	hash_add(ucounts_hashtable, &new->node, hash_key);
+	get_user_ns(new->ns);
+	spin_unlock_irq(&ucounts_lock);
+	return new;
 
+found:
 	wrapped = !get_ucounts_or_wrap(ucounts);
 	spin_unlock_irq(&ucounts_lock);
 	kfree(new);
@@ -205,7 +193,7 @@ void put_ucounts(struct ucounts *ucounts)
 	unsigned long flags;
 
 	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
-		hlist_del_init(&ucounts->node);
+		hash_del(&ucounts->node);
 		spin_unlock_irqrestore(&ucounts_lock, flags);
 		put_user_ns(ucounts->ns);
 		kfree(ucounts);
-- 
2.39.5


