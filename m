Return-Path: <linux-kernel+bounces-256224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77C0934B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A495428791F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4712C481;
	Thu, 18 Jul 2024 09:37:14 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A78002E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295434; cv=none; b=n5P5pSsuYAjTBqGq3OajKe6YufXudyCh+ZXIUOmb94rFYngAinL5qtqqPLyIYWZ3RH4pcIZd2WzEO3REfsGzfh8csED+05Ng3awoxXUOCoxXanlrJ2gSk7vHO1P7b+hGtSuHC92jrJg+TYnEr3o+7GqPdnG81SMqAiKh+qn9fsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295434; c=relaxed/simple;
	bh=Z6kGOR/fyoETge1rmn754ir7mL2NxQyqjnTZBBwBe0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNdG8bDn7rq0QiVB0QNAH+woldmfbxrIC4xCLfvl4HcEJ/xwsik8/O2dZvaX7oXamkXUk1b7J+rfdUnR461fsE69IOldO/GYz5CYlgrQALZwTjuC4QkgTgETeBPdhbpli8Vw55Oy+gSxNg0Qe0IXpiSYe7RL+QpGNCZ4qZxH59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46I9aRQF021665;
	Thu, 18 Jul 2024 17:36:27 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WPnc51fvGz2KVL6p;
	Thu, 18 Jul 2024 17:31:01 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 18 Jul 2024 17:36:24 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] f2fs: fix to use per-inode maxbytes and cleanup
Date: Thu, 18 Jul 2024 17:36:06 +0800
Message-ID: <1721295366-21008-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 46I9aRQF021665

This is a supplement to commit 6d1451bf7f84 ("f2fs: fix to use per-inode maxbytes")
for some missed cases, also cleanup redundant code in f2fs_llseek.

Cc: Chengguang Xu <cgxu519@mykernel.net>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/data.c   | 2 +-
 fs/f2fs/file.c   | 7 ++-----
 fs/f2fs/verity.c | 5 +++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6457e5b..1d41d99 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2064,7 +2064,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 static inline loff_t f2fs_readpage_limit(struct inode *inode)
 {
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
-		return inode->i_sb->s_maxbytes;
+		return max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
 
 	return i_size_read(inode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index effbaa6..e6411d5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -431,7 +431,7 @@ static bool __found_offset(struct address_space *mapping,
 static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = inode->i_sb->s_maxbytes;
+	loff_t maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
 	struct dnode_of_data dn;
 	pgoff_t pgofs, end_offset;
 	loff_t data_ofs = offset;
@@ -513,10 +513,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = inode->i_sb->s_maxbytes;
-
-	if (f2fs_compressed_file(inode))
-		maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
+	loff_t maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
 
 	switch (whence) {
 	case SEEK_SET:
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index f7bb0c5..7fc787c 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -74,7 +74,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 
-	if (pos + count > inode->i_sb->s_maxbytes)
+	if (pos + count > (max_file_blocks(inode) << F2FS_BLKSIZE_BITS))
 		return -EFBIG;
 
 	while (count) {
@@ -237,7 +237,8 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 	pos = le64_to_cpu(dloc.pos);
 
 	/* Get the descriptor */
-	if (pos + size < pos || pos + size > inode->i_sb->s_maxbytes ||
+	if (pos + size < pos ||
+	    pos + size > (max_file_blocks(inode) << F2FS_BLKSIZE_BITS) ||
 	    pos < f2fs_verity_metadata_pos(inode) || size > INT_MAX) {
 		f2fs_warn(F2FS_I_SB(inode), "invalid verity xattr");
 		f2fs_handle_error(F2FS_I_SB(inode),
-- 
1.9.1


