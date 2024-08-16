Return-Path: <linux-kernel+bounces-288795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98206953ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD96E1C2182B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9D1D69E;
	Fri, 16 Aug 2024 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSK9fb93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737CBE6F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770829; cv=none; b=XWja1gEPqGp9Q59oX69T8bOnHpbxVLIjlHTVMjHfjXtyBQPl+q3X2/3KcW7okdCSEhMYLNr6lYMB9mOt9FhUq+ZcsS/YzQFT4Ex46CjdoMfT5bgDYq6whVaYnJwhHGQGDKqGeP32bDcOnVw/dRZUIV1Pjj66xRQl7K+soRBP3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770829; c=relaxed/simple;
	bh=dqNp+7QcCFd8ngmu/YJqLLqUCV4q4RdV9c4aq2gfp8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=an4fwpCQ36+OvbruY+5fh6sxhZuXEg9wltpT8SFiee04ppreqw9AEiuaiIBk7LHGJ3PDE4xsfix84mdqXnsBsukk7USKubsLdQx7y3rUfz7HjAW+ckZth464oQh9o5o2SIfm++yB3BtddC7kmX+diZSD/BhziuViVfDmK7OyYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSK9fb93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B2AC32786;
	Fri, 16 Aug 2024 01:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723770828;
	bh=dqNp+7QcCFd8ngmu/YJqLLqUCV4q4RdV9c4aq2gfp8o=;
	h=From:To:Cc:Subject:Date:From;
	b=jSK9fb93LNBqWP6KNKV29n5TCXTrEJC3QcIRkG0jPUp9xpf5LovWm3wybV4ca0YHL
	 BBSRAXt/hphsyUhXcK5qA1Ak1WziNgtOa3BAVl8yyPLonJt3hxgJsVtVZKq5pfXnf5
	 tDlhEnx50GtnwU9EE/kaKav2WlD/n02t9/4JskBPjguJD3VKSyWgGtxHVZLfJ81s09
	 KDvWCeAynMp+OhQApqu849Arz1iUJ8YzMaT/jLAz9JmJ076l72vVrRjSO0FFG7ppTx
	 8bKuDQ+w2OHnRNqYZL1tqL/dvDn42bU3EwiqWKlFRAghsP58mk6HMgN4/Sav7+8kAf
	 XyuLzrbAgTnAA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 4/4] f2fs: atomic: fix to forbid dio in atomic_file
Date: Fri, 16 Aug 2024 09:13:42 +0800
Message-Id: <20240816011342.1668666-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atomic write can only be used via buffered IO, let's fail direct IO on
atomic_file and return -EOPNOTSUPP.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix error path handling.
 fs/f2fs/file.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b4f417f3474..b50ebebbbaab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2162,6 +2162,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		goto out;
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+	f2fs_down_write(&fi->i_gc_rwsem[READ]);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2171,10 +2172,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%lu, npages=%u",
 			  inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
-	if (ret) {
-		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-		goto out;
-	}
+	if (ret)
+		goto out_unlock;
 
 	/* Check if the inode already has a COW inode */
 	if (fi->cow_inode == NULL) {
@@ -2183,10 +2182,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		struct inode *dir = d_inode(dentry->d_parent);
 
 		ret = f2fs_get_tmpfile(idmap, dir, &fi->cow_inode);
-		if (ret) {
-			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-			goto out;
-		}
+		if (ret)
+			goto out_unlock;
 
 		set_inode_flag(fi->cow_inode, FI_COW_FILE);
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
@@ -2200,10 +2197,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
 
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
-		if (ret) {
-			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-			goto out;
-		}
+		if (ret)
+			goto out_unlock;
 	}
 
 	f2fs_write_inode(inode, NULL);
@@ -2222,7 +2217,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	}
 	f2fs_i_size_write(fi->cow_inode, isize);
 
+out_unlock:
+	f2fs_up_write(&fi->i_gc_rwsem[READ]);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+	if (ret)
+		goto out;
 
 	f2fs_update_time(sbi, REQ_TIME);
 	fi->atomic_write_task = current;
@@ -4567,6 +4566,13 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		f2fs_down_read(&fi->i_gc_rwsem[READ]);
 	}
 
+	/* dio is not compatible w/ atomic file */
+	if (f2fs_is_atomic_file(inode)) {
+		f2fs_up_read(&fi->i_gc_rwsem[READ]);
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/*
 	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
 	 * the higher-level function iomap_dio_rw() in order to ensure that the
@@ -4982,6 +4988,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Determine whether we will do a direct write or a buffered write. */
 	dio = f2fs_should_use_dio(inode, iocb, from);
 
+	/* dio is not compatible w/ atomic write */
+	if (dio && f2fs_is_atomic_file(inode)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
-- 
2.40.1


