Return-Path: <linux-kernel+bounces-228239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475EF915D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FAD8B2192C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4C4E1D6;
	Tue, 25 Jun 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf7SrOlM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30F49648
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285243; cv=none; b=sKQwQS/lhu30+USgSk0g4nXhY/47+rF+MnvSGVsaIYCTuzcEN27Huk6xm6zhguDXzBeye0GvQ+u7IgBGWC8YZzxdUya5PzyDI+bfeb6n/wa2aL736Dq66Ui82fC2GVyfOUNWbKk/pPe8hHzOamRAQZcnuSXuOQqflawOpVgZ0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285243; c=relaxed/simple;
	bh=0eAJUXNK7k0eoACdFcWnWupZI7JhpdKON3unr3Ao0hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ssvp3f9Hpc0QUsarcXIfGZjH9yg1oJjS2DRboETJ5pOYp2dtK+pcuTnBec9zAXSz7Tx1DlI9tz0RnuMVTuhgXfwykarh7u9LL3+QBxOogZKLKuyibvpHZfGpwqBZcLqjxuSyo8eHrTwbm6YaoPHdJW+wKrsfPJyRNIXcRgzGrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf7SrOlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E693C32782;
	Tue, 25 Jun 2024 03:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719285242;
	bh=0eAJUXNK7k0eoACdFcWnWupZI7JhpdKON3unr3Ao0hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lf7SrOlMH/1fEKjba/eCJe0GgTpp/YFjevK0bmG7R/INKvyLnfOh5bydYmK0UhmoM
	 tRv/KFUhVuxJyyeQoRaN4haiaFbF2l5UDtHwdadhr36XAgXdi42ABihvOfjsGIOyW1
	 2oMOEz87gwmnR6X65K97gDnoWMhzYn4cq2sO0SWGC279axHqGU6pN7+11QwCcNSe1Z
	 JIUei08+j9earKDKpzvr9DkYsQvJ/0iImPzhWd2lu1SWeJSx5WDRcRI4Jh/Mx1kVK8
	 bPMhnTvGzNWSKZULg/EYKgXaIk+HwDZrzm7z3n08ItJQ7K8m+uS/O6oEqayP9SAMqJ
	 oTFfMN7RBp+ag==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: atomic: fix to not allow GC to pollute atomic_file
Date: Tue, 25 Jun 2024 11:13:49 +0800
Message-Id: <20240625031351.3586955-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625031351.3586955-1-chao@kernel.org>
References: <20240625031351.3586955-1-chao@kernel.org>
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
v1:
- this patch can fix in-memory data consistency issue caused by f2fs/003
 fs/f2fs/segment.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4db1add43e36..914a13bfc2ab 100644
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
 
@@ -379,16 +385,28 @@ int f2fs_commit_atomic_write(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int err;
 
+	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+
 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (err)
 		return err;
 
-	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
-	f2fs_lock_op(sbi);
+	/* writeback GCing page of cow_inode */
+	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
+							0, LLONG_MAX);
+	if (err)
+		return err;
 
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
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;
-- 
2.40.1


