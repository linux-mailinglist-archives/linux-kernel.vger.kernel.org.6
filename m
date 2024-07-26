Return-Path: <linux-kernel+bounces-262874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278AD93CE28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C62B20CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B572175560;
	Fri, 26 Jul 2024 06:28:20 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57532B9C4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975300; cv=none; b=kG2OPVBAucGv0J2cblDUM8ujjMKB2eBKEJpNwwK9zBnP6Syw00Y9TGTn+x+Esn7FNaMxy7GLgqKk11jhDeHOIgirtaEE05RX5yLS2b+NAmkyI4sEKQnS55iOLt4mCmiKHdbTbZCaDzVcbGb6xtO7AG4boKD8juk1NpRwwiQlca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975300; c=relaxed/simple;
	bh=mASy784erLL+EluMNRQrltZDJ3e4bSVi2ZckEXftvlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVVSuCm30Sh9ULv47Y1kw37R9X0fTtxCbnZ/6RBEAHU3+i1LlwGbZLdK2kTgQmVdgvdnluHc0S7H4/d0C/GISBgBji26v4H9EAYZlVxg5EsGC/BQkIsvCbwU7asMtqaeI/0KDlTI+CRDn/i3QoEFMxLPC/QmTTzSHVz7ukGTrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46Q6RgvF069514;
	Fri, 26 Jul 2024 14:27:42 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WVd2J4C4Xz2Lk7m3;
	Fri, 26 Jul 2024 14:22:00 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 26 Jul 2024 14:27:40 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH V2] f2fs: fix to use per-inode maxbytes and cleanup
Date: Fri, 26 Jul 2024 14:27:26 +0800
Message-ID: <1721975246-32345-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 46Q6RgvF069514

This is a supplement to commit 6d1451bf7f84 ("f2fs: fix to use per-inode maxbytes")
for some missed cases, also cleanup redundant code in f2fs_llseek.

Cc: Chengguang Xu <cgxu519@mykernel.net>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v2: use Macro F2FS_BLK_TO_BYTES
---
---
 fs/f2fs/data.c   | 4 ++--
 fs/f2fs/file.c   | 7 ++-----
 fs/f2fs/verity.c | 5 +++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a2c3d39..e9570f4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1938,7 +1938,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	inode_lock_shared(inode);
 
-	maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
+	maxbytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
 	if (start > maxbytes) {
 		ret = -EFBIG;
 		goto out;
@@ -2063,7 +2063,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 static inline loff_t f2fs_readpage_limit(struct inode *inode)
 {
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
-		return inode->i_sb->s_maxbytes;
+		return F2FS_BLK_TO_BYTES(max_file_blocks(inode));
 
 	return i_size_read(inode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6c62f76..41ef3ad 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -432,7 +432,7 @@ static bool __found_offset(struct address_space *mapping,
 static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = inode->i_sb->s_maxbytes;
+	loff_t maxbytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
 	struct dnode_of_data dn;
 	pgoff_t pgofs, end_offset;
 	loff_t data_ofs = offset;
@@ -514,10 +514,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = inode->i_sb->s_maxbytes;
-
-	if (f2fs_compressed_file(inode))
-		maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
+	loff_t maxbytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
 
 	switch (whence) {
 	case SEEK_SET:
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index f7bb0c5..83310b5 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -74,7 +74,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 
-	if (pos + count > inode->i_sb->s_maxbytes)
+	if (pos + count > F2FS_BLK_TO_BYTES(max_file_blocks(inode)))
 		return -EFBIG;
 
 	while (count) {
@@ -237,7 +237,8 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 	pos = le64_to_cpu(dloc.pos);
 
 	/* Get the descriptor */
-	if (pos + size < pos || pos + size > inode->i_sb->s_maxbytes ||
+	if (pos + size < pos ||
+	    pos + size > F2FS_BLK_TO_BYTES(max_file_blocks(inode)) ||
 	    pos < f2fs_verity_metadata_pos(inode) || size > INT_MAX) {
 		f2fs_warn(F2FS_I_SB(inode), "invalid verity xattr");
 		f2fs_handle_error(F2FS_I_SB(inode),
-- 
1.9.1


