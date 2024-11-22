Return-Path: <linux-kernel+bounces-417836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F89D5993
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF6D282DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07981632E1;
	Fri, 22 Nov 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsYFuLFC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473C1527A7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258221; cv=none; b=K93kDFXG4dEeNnCGz3xxDdZG1M5qdj9YWj3d8HSzv26+2AKAmtv5lUHb8pm/RMPl01zL4kheFjdeUwU7hL8anHhCseeOl6nbids/n1KYrqLLgAKSyNh8ZtIKVik6pddoMQWKGTFGpIf6tQo2tNOh8FWRiWO1AhYyrN8wVeOPy4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258221; c=relaxed/simple;
	bh=ppR+9bFx7XFGx82bTz63XvGFhm3DKgJSHpQ9Nyj/KHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOfUMuztmUyoKBZt+EuF0YwJi+/Moj4it/ZdwmRzSnZmbtZjQulld8NNpfuA6hzXjJJS7HEI9dTS2i1nzl1Cheofgc+HujdnYrOk156xSCGTX0+LCplDMeyYu2WNrCP0A6OYoocjmP/cf/FTtbzCNsfeS0UpG/5FgH7YFzgFYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsYFuLFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F020FC4CECE;
	Fri, 22 Nov 2024 06:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732258220;
	bh=ppR+9bFx7XFGx82bTz63XvGFhm3DKgJSHpQ9Nyj/KHI=;
	h=From:To:Cc:Subject:Date:From;
	b=NsYFuLFCOQxEEjPNbHcNwNjFaF79CNuWSZqk5cfKKd4ECHyyp4pRLRHTXHKdOpmsw
	 uRvkj3UYj1Hq0fMhd7Up1xLZEkAGIT0qPYj1mCKA1KM5ZlOUpGnVsRttpYqXJ9SJ4K
	 duLrOmm06hR1zGm31bO33SZItUY6z7uWyYFnz5vItjcQr3rhNX8QdDpWtgV2IOo1mG
	 KR2n7HxOti9jS6/VXUl5/7iFMFwbqePBZWsrw9KY6J95VS3gehSYAlu26DJmAgIyXH
	 YkUml/Ct+xMgtqA2r+SE8RAwJU8/8uAU1peEOeTcX0e9/6RmlMpRw9n7IBgNsy7AJ5
	 0bnQ9jjJMwEmA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH v2 1/2] f2fs: fix to shrink read extent node in batches
Date: Fri, 22 Nov 2024 14:50:04 +0800
Message-Id: <20241122065005.3772987-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use rwlock to protect core structure data of extent tree during
its shrink, however, if there is a huge number of extent nodes in
extent tree, during shrink of extent tree, it may hold rwlock for
a very long time, which may trigger kernel hang issue.

This patch fixes to shrink read extent node in batches, so that,
critical region of the rwlock can be shrunk to avoid its extreme
long time hold.

Reported-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/20241112110627.1314632-1-xiuhong.wang@unisoc.com/
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- no updates.
 fs/f2fs/extent_cache.c | 69 +++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 019c1f7b7fa5..b7a6817b44b0 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -379,21 +379,22 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode,
 }
 
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
-					struct extent_tree *et)
+				struct extent_tree *et, unsigned int nr_shrink)
 {
 	struct rb_node *node, *next;
 	struct extent_node *en;
-	unsigned int count = atomic_read(&et->node_cnt);
+	unsigned int count;
 
 	node = rb_first_cached(&et->root);
-	while (node) {
+
+	for (count = 0; node && count < nr_shrink; count++) {
 		next = rb_next(node);
 		en = rb_entry(node, struct extent_node, rb_node);
 		__release_extent_node(sbi, et, en);
 		node = next;
 	}
 
-	return count - atomic_read(&et->node_cnt);
+	return count;
 }
 
 static void __drop_largest_extent(struct extent_tree *et,
@@ -622,6 +623,30 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 	return en;
 }
 
+static unsigned int __destroy_extent_node(struct inode *inode,
+					enum extent_type type)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
+	unsigned int nr_shrink = type == EX_READ ?
+				READ_EXTENT_CACHE_SHRINK_NUMBER :
+				AGE_EXTENT_CACHE_SHRINK_NUMBER;
+	unsigned int node_cnt = 0;
+
+	if (!et || !atomic_read(&et->node_cnt))
+		return 0;
+
+	while (atomic_read(&et->node_cnt)) {
+		write_lock(&et->lock);
+		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
+		write_unlock(&et->lock);
+	}
+
+	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
+
+	return node_cnt;
+}
+
 static void __update_extent_tree_range(struct inode *inode,
 			struct extent_info *tei, enum extent_type type)
 {
@@ -760,9 +785,6 @@ static void __update_extent_tree_range(struct inode *inode,
 		}
 	}
 
-	if (is_inode_flag_set(inode, FI_NO_EXTENT))
-		__free_extent_tree(sbi, et);
-
 	if (et->largest_updated) {
 		et->largest_updated = false;
 		updated = true;
@@ -780,6 +802,9 @@ static void __update_extent_tree_range(struct inode *inode,
 out_read_extent_cache:
 	write_unlock(&et->lock);
 
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
+		__destroy_extent_node(inode, EX_READ);
+
 	if (updated)
 		f2fs_mark_inode_dirty_sync(inode, true);
 }
@@ -942,10 +967,14 @@ static unsigned int __shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink
 	list_for_each_entry_safe(et, next, &eti->zombie_list, list) {
 		if (atomic_read(&et->node_cnt)) {
 			write_lock(&et->lock);
-			node_cnt += __free_extent_tree(sbi, et);
+			node_cnt += __free_extent_tree(sbi, et,
+					nr_shrink - node_cnt - tree_cnt);
 			write_unlock(&et->lock);
 		}
-		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
+
+		if (atomic_read(&et->node_cnt))
+			goto unlock_out;
+
 		list_del_init(&et->list);
 		radix_tree_delete(&eti->extent_tree_root, et->ino);
 		kmem_cache_free(extent_tree_slab, et);
@@ -1084,23 +1113,6 @@ unsigned int f2fs_shrink_age_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink
 	return __shrink_extent_tree(sbi, nr_shrink, EX_BLOCK_AGE);
 }
 
-static unsigned int __destroy_extent_node(struct inode *inode,
-					enum extent_type type)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
-	unsigned int node_cnt = 0;
-
-	if (!et || !atomic_read(&et->node_cnt))
-		return 0;
-
-	write_lock(&et->lock);
-	node_cnt = __free_extent_tree(sbi, et);
-	write_unlock(&et->lock);
-
-	return node_cnt;
-}
-
 void f2fs_destroy_extent_node(struct inode *inode)
 {
 	__destroy_extent_node(inode, EX_READ);
@@ -1109,7 +1121,6 @@ void f2fs_destroy_extent_node(struct inode *inode)
 
 static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
 	bool updated = false;
 
@@ -1117,7 +1128,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 		return;
 
 	write_lock(&et->lock);
-	__free_extent_tree(sbi, et);
 	if (type == EX_READ) {
 		set_inode_flag(inode, FI_NO_EXTENT);
 		if (et->largest.len) {
@@ -1126,6 +1136,9 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 		}
 	}
 	write_unlock(&et->lock);
+
+	__destroy_extent_node(inode, type);
+
 	if (updated)
 		f2fs_mark_inode_dirty_sync(inode, true);
 }
-- 
2.40.1


