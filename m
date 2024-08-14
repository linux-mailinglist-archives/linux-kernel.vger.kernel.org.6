Return-Path: <linux-kernel+bounces-286531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D44951C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269C61C22CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950A1AE031;
	Wed, 14 Aug 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrvbRPMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95335179BD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643309; cv=none; b=AfEB82ryQbTd8HJUhXTG2UqUKV97qY85uPRW04jVIFVKsGom46AdYpMvb6ic5cdOtA3luwrcHFqVs9QAQxVXHzG5gC2C7WLRbk6fdFu864Dy5Q+EYwqj03iUCM6wVSxh8k95+YgMJI82ERfATjMq2d4/CHP6suSZTS0XwxzRm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643309; c=relaxed/simple;
	bh=TV7e8O5Dp1Ln1kyoeo3xPcNmajK9Di/HeAdWJnXc+QE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hr600NNccZYql7KAsvOq/Bu/+5Fo5VQaZZOhuX0Y0M9Vh2NUOea/hfK3sPHXaHNXFiYobQAvifsG3tGGk1Xg3TbaH9wzEGHWS2UPcii7pPvjvANc+1zn7ykZzxHEi6543cJ8x1g3tq+XB9x/TE0D0tbfgT+XapajeJhas+G2ozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrvbRPMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D5FC32786;
	Wed, 14 Aug 2024 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643309;
	bh=TV7e8O5Dp1Ln1kyoeo3xPcNmajK9Di/HeAdWJnXc+QE=;
	h=From:To:Cc:Subject:Date:From;
	b=hrvbRPMYY3E1N+RGXO5pT93z20i48atFAcLwYJTvO+k9i9dN4KGN1vRzX5gZ5OBDM
	 F9KhGZ853eIhSAo/2NvBr952pzUCO6t31S3qZfp7BHbHsDyEuqoQjN2t6z7j501yi3
	 dRiuXZVu5vKhQ/QQ/HHW9oOFd9TRqBCFZy30LoMzYsZbxD/qwchaXi6Q1PsHu4OiEt
	 s2Ji+0yXTi134fOcybzSmERgTV2aMNJujQA9CGKeffHbRJAowyuDdU4eg1qHOUaFgj
	 QWPt47JfizVwcIYraEjOoGA8NAv0wffnwWaC65NxRURZzLK317eAukCFzH5lS8K03I
	 wVdMemaiwsCMQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/4] f2fs: atomic: fix to not allow GC to pollute atomic_file
Date: Wed, 14 Aug 2024 21:48:15 +0800
Message-Id: <20240814134815.801303-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SQLite App			GC Thread	Shrinker
- f2fs_ioc_start_atomic_write

- f2fs_ioc_commit_atomic_write
 - f2fs_commit_atomic_write
  - filemap_write_and_wait_range
  : write atomic_file's data to cow_inode
						echo 3 > drop_caches
				- f2fs_gc
				 - gc_data_segment
				  - move_data_page
				   - set_page_dirty
				   : it may load data of previous
				     transaction into pagecache.
  - f2fs_down_write(&fi->i_gc_rwsem[WRITE])
  - __f2fs_commit_atomic_write
  - f2fs_up_write(&fi->i_gc_rwsem[WRITE])

During committing atomic_file, GC may be triggered to migrate
atomic_file's block, so it may contain data of previous transaction
in page cache, we should drop atomic_file's cache once it was
migrated by GC.

And also, we should writeback atomic_file and cow_file's data
w/ i_gc_rwsem lock held, in order to avoid block address change
during __f2fs_commit_atomic_write().

Meahwhile, this patch adds f2fs_wait_on_block_writeback_range()
to wait completion of block migration.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix error path handling.
 fs/f2fs/segment.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3aee71c9f3c6..a43054ab0cf1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -236,6 +236,9 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 		return err;
 	}
 
+	if (__is_valid_data_blkaddr(dn.data_blkaddr))
+		f2fs_wait_on_block_writeback_range(inode, dn.data_blkaddr, 1);
+
 	if (recover) {
 		/* dn.data_blkaddr is always valid */
 		if (!__is_valid_data_blkaddr(new_addr)) {
@@ -339,6 +342,9 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 				goto out;
 			}
 
+			f2fs_wait_on_block_writeback_range(cow_inode,
+								blkaddr, 1);
+
 			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
 							true, NULL);
 
@@ -379,16 +385,29 @@ int f2fs_commit_atomic_write(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int err;
 
+	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+
 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
-	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
-	f2fs_lock_op(sbi);
+	/* writeback GCing page of cow_inode */
+	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
+							0, LLONG_MAX);
+	if (err)
+		goto out;
 
-	err = __f2fs_commit_atomic_write(inode);
+	filemap_invalidate_lock(inode->i_mapping);
+
+	/* don't allow clean page loaded by GC to pollute atomic_file */
+	truncate_pagecache(inode, 0);
 
+	f2fs_lock_op(sbi);
+	err = __f2fs_commit_atomic_write(inode);
 	f2fs_unlock_op(sbi);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+out:
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;
-- 
2.40.1


