Return-Path: <linux-kernel+bounces-228238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC3D915D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711661C2133C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5B47A6B;
	Tue, 25 Jun 2024 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLcrhK/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7E43AB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285241; cv=none; b=LlRkCwHOCGNdPWsa2C1DRkhKNUsVcjYQ8x+Qul4cC9VdLoNpvrvX8Iqcdh8kqoO1JvRBBVe82aKnqpQMMqZ/8CDkPQKSxDUdc1WzChSCr7hFjJQNP3k4+j9zZqWN3P1gZn3h1cJdvWCnRiOPDZ/nURSTdowBNF2olofzZrX3RoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285241; c=relaxed/simple;
	bh=wxT7s6VN+/GloyB+qWgTcBkk6+rCXosFyOxrCWFGLqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kvz2P2C7FwERqREYuV4oBbRBp5H3tAlXldJ9b6S08AkRswjLSyThiakbn48+r1ATVhObiQDLoe0KWpfpiIMYEMvtYY7W+yhH8ZI8kDlJCRHNPPlavyN72GwBY7PS7Jame0EUB5X2qQdsMWvmE1+kdLDJQ03Hd8AbN2LeYLVnz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLcrhK/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC10DC32782;
	Tue, 25 Jun 2024 03:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719285240;
	bh=wxT7s6VN+/GloyB+qWgTcBkk6+rCXosFyOxrCWFGLqE=;
	h=From:To:Cc:Subject:Date:From;
	b=JLcrhK/NZP0TSviBtUvn/pqtj0qNrgHRPVTfJ0xlkU/9RLka7tuoH7s7BBdGPqp7S
	 hEiSMx7h8/u5Ym8VFSfqzxxBtFHT6xSD6rnzWMvr//X+S1poxSBiVGqYHXeChjCmab
	 axAxe2pXw6gtE2MWC6Z87/5u7BqgkJXCqxUF+sjHHl2sR4D37ekCtk2DCHQRb3O5f9
	 EKapz6lWE58bLkdWlX+bewronwIWIlZvRPyz9OXarj+nR2vKa9Z28ZB5gbiXLqGBPX
	 KNqpLxCIrkUa8TaohxTs9Vo/ENLf5coXFMQMymdt7vIMGJdU/Q5WaQobvonwVCqElQ
	 Nquq0HDRwBU/g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/4] f2fs: atomic: fix to avoid racing w/ GC
Date: Tue, 25 Jun 2024 11:13:48 +0800
Message-Id: <20240625031351.3586955-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Case #1:
SQLite App		GC Thread		Kworker		Shrinker
- f2fs_ioc_start_atomic_write

- f2fs_ioc_commit_atomic_write
 - f2fs_commit_atomic_write
  - filemap_write_and_wait_range
  : write atomic_file's data to cow_inode
								echo 3 > drop_caches
								to drop atomic_file's
								cache.
			- f2fs_gc
			 - gc_data_segment
			  - move_data_page
			   - set_page_dirty

						- writepages
						 - f2fs_do_write_data_page
						 : overwrite atomic_file's data
						   to cow_inode
  - f2fs_down_write(&fi->i_gc_rwsem[WRITE])
  - __f2fs_commit_atomic_write
  - f2fs_up_write(&fi->i_gc_rwsem[WRITE])

Case #2:
SQLite App		GC Thread		Kworker
- f2fs_ioc_start_atomic_write

						- __writeback_single_inode
						 - do_writepages
						  - f2fs_write_cache_pages
						   - f2fs_write_single_data_page
						    - f2fs_do_write_data_page
						    : write atomic_file's data to cow_inode
			- f2fs_gc
			 - gc_data_segment
			  - move_data_page
			   - set_page_dirty

						- writepages
						 - f2fs_do_write_data_page
						 : overwrite atomic_file's data to cow_inode
- f2fs_ioc_commit_atomic_write

In above cases racing in between atomic_write and GC, previous
data in atomic_file may be overwrited to cow_file, result in
data corruption.

This patch introduces PAGE_PRIVATE_ATOMIC_WRITE bit flag in page.private,
and use it to indicate that there is last dirty data in atomic file,
and the data should be writebacked into cow_file, if the flag is not
tagged in page, we should never write data across files.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v1:
- this patch can fix on-disk data consistency issue caused by f2fs/003
 fs/f2fs/data.c | 10 +++++++++-
 fs/f2fs/f2fs.h |  8 +++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0b4f563f2361..22031b9b507c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2647,10 +2647,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	struct dnode_of_data dn;
 	struct node_info ni;
 	bool ipu_force = false;
+	bool atomic_commit;
 	int err = 0;
 
 	/* Use COW inode to make dnode_of_data for atomic write */
-	if (f2fs_is_atomic_file(inode))
+	atomic_commit = f2fs_is_atomic_file(inode) &&
+				page_private_atomic(fio->page);
+	if (atomic_commit)
 		set_new_dnode(&dn, F2FS_I(inode)->cow_inode, NULL, NULL, 0);
 	else
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -2749,6 +2752,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(page_folio(page), OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
+	if (atomic_commit)
+		clear_page_private_atomic(page);
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
@@ -3718,6 +3723,9 @@ static int f2fs_write_end(struct file *file,
 
 	set_page_dirty(page);
 
+	if (f2fs_is_atomic_file(inode))
+		set_page_private_atomic(page);
+
 	if (pos + copied > i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
 		f2fs_i_size_write(inode, pos + copied);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eacf0b0e6b2e..f1d65ee3addf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1413,7 +1413,8 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * bit 1	PAGE_PRIVATE_ONGOING_MIGRATION
  * bit 2	PAGE_PRIVATE_INLINE_INODE
  * bit 3	PAGE_PRIVATE_REF_RESOURCE
- * bit 4-	f2fs private data
+ * bit 4	PAGE_PRIVATE_ATOMIC_WRITE
+ * bit 5-	f2fs private data
  *
  * Layout B: lowest bit should be 0
  * page.private is a wrapped pointer.
@@ -1423,6 +1424,7 @@ enum {
 	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
 	PAGE_PRIVATE_INLINE_INODE,		/* inode page contains inline data */
 	PAGE_PRIVATE_REF_RESOURCE,		/* dirty page has referenced resources */
+	PAGE_PRIVATE_ATOMIC_WRITE,		/* data page from atomic write path */
 	PAGE_PRIVATE_MAX
 };
 
@@ -2401,14 +2403,17 @@ static inline void clear_page_private_##name(struct page *page) \
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
 
 PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_SET_FUNC(atomic, ATOMIC_WRITE);
 
 PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
+PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
 static inline unsigned long get_page_private_data(struct page *page)
 {
@@ -2440,6 +2445,7 @@ static inline void clear_page_private_all(struct page *page)
 	clear_page_private_reference(page);
 	clear_page_private_gcing(page);
 	clear_page_private_inline(page);
+	clear_page_private_atomic(page);
 
 	f2fs_bug_on(F2FS_P_SB(page), page_private(page));
 }
-- 
2.40.1


