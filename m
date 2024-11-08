Return-Path: <linux-kernel+bounces-400880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF4E9C1396
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A836A1C226BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068AB15E96;
	Fri,  8 Nov 2024 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRNGA5sy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628311187
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029166; cv=none; b=fakZG7zI/0SytxyA6umZti0qwGK/D2Tgc8fIYW9ZhqIOVgHjnC++yTmM8mYt4aadulRQKwdY80NE8iYomdjAeeQDkP/lORyeWJOCTll41mXYSXpHOjLVUZlA3a72S7FPXEJSLiTH6AyEHskFNfKiCU7iYLenFtX4iIFRX+jhm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029166; c=relaxed/simple;
	bh=z1H8xN41cgBNtfszEpjIbmeQ+MnAkd5Yt6kDRAkWbss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReA9sQy40zYmPDAR6Uadu9G4N5FGj/7yc3TcAei6MM/EZ0z3jMMuPZLCIyySjZ+gipJZqaoUo5+WQWIVuy76OFzjlXXzR2fPtWn+FeLi+i3Exng3H8RuQj1mgzrf8He4eODrVqRVqYKpJdRlR5y6VXjERrGae6zC5E50S8MkUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRNGA5sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6487C4CECE;
	Fri,  8 Nov 2024 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731029166;
	bh=z1H8xN41cgBNtfszEpjIbmeQ+MnAkd5Yt6kDRAkWbss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRNGA5sysTjVfpmMwZGzPWf0wCt3cjJdz/Y5Q5fR5T1iVQP2MKJqtSWa4zIPCGgPs
	 xkcxng2kDyw8KRSJi0RmYAI95siETheMn/pRMvQoM9FC0FlfQmTpfWnXlHEx/jPzuT
	 B4d0t3R4yoxpXxAQAJbknUuhRnuOwgQbrNEMTdLPiqgU5dNJXuGLy2p6KVM3rXEDTt
	 XIxPnyGjQln2npBJQGzNbY7d4CwPm6o23U5Cyxbxzq3MGp/JYrR40oBSeYjUeM/lUR
	 UWzuBqjH95GGv+zqMKs3mZRpVORG10aMHxDD6x2gdK0U1TJ9qImLBLcKQ777JuroGQ
	 ApGyJkYGGAnKw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 2/4] f2fs: clean up w/ F2FS_{BLK_TO_BYTES,BTYES_TO_BLK}
Date: Fri,  8 Nov 2024 09:25:55 +0800
Message-Id: <20241108012557.572782-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241108012557.572782-1-chao@kernel.org>
References: <20241108012557.572782-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs doesn't support different blksize in one instance, so
bytes_to_blks() and blks_to_bytes() are equal to F2FS_BYTES_TO_BLK
and F2FS_BLK_TO_BYTES, let's use F2FS_BYTES_TO_BLK/F2FS_BLK_TO_BYTES
instead for cleanup.

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 68 +++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b33aca24b9ef..0e8390cbdb5b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1819,16 +1819,6 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 	return true;
 }
 
-static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
-{
-	return (bytes >> inode->i_blkbits);
-}
-
-static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
-{
-	return (blks << inode->i_blkbits);
-}
-
 static int f2fs_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
 {
@@ -1854,7 +1844,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}
 
-		phys = blks_to_bytes(inode, ni.blk_addr);
+		phys = F2FS_BLK_TO_BYTES(ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
 					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
 					get_inline_xattr_addrs(inode));
@@ -1886,7 +1876,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}
 
-		phys = blks_to_bytes(inode, ni.blk_addr);
+		phys = F2FS_BLK_TO_BYTES(ni.blk_addr);
 		len = inode->i_sb->s_blocksize;
 
 		f2fs_put_page(page, 1);
@@ -1948,16 +1938,16 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			goto out;
 	}
 
-	if (bytes_to_blks(inode, len) == 0)
-		len = blks_to_bytes(inode, 1);
+	if (F2FS_BYTES_TO_BLK(len) == 0)
+		len = F2FS_BLKSIZE;
 
-	start_blk = bytes_to_blks(inode, start);
-	last_blk = bytes_to_blks(inode, start + len - 1);
+	start_blk = F2FS_BYTES_TO_BLK(start);
+	last_blk = F2FS_BYTES_TO_BLK(start + len - 1);
 
 next:
 	memset(&map, 0, sizeof(map));
 	map.m_lblk = start_blk;
-	map.m_len = bytes_to_blks(inode, len);
+	map.m_len = F2FS_BYTES_TO_BLK(len);
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = NO_CHECK_TYPE;
 
@@ -1974,7 +1964,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
 		start_blk = next_pgofs;
 
-		if (blks_to_bytes(inode, start_blk) < maxbytes)
+		if (F2FS_BLK_TO_BYTES(start_blk) < maxbytes)
 			goto prep_next;
 
 		flags |= FIEMAP_EXTENT_LAST;
@@ -2011,14 +2001,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	} else if (compr_appended) {
 		unsigned int appended_blks = cluster_size -
 						count_in_cluster + 1;
-		size += blks_to_bytes(inode, appended_blks);
+		size += F2FS_BLK_TO_BYTES(appended_blks);
 		start_blk += appended_blks;
 		compr_cluster = false;
 	} else {
-		logical = blks_to_bytes(inode, start_blk);
+		logical = F2FS_BLK_TO_BYTES(start_blk);
 		phys = __is_valid_data_blkaddr(map.m_pblk) ?
-			blks_to_bytes(inode, map.m_pblk) : 0;
-		size = blks_to_bytes(inode, map.m_len);
+			F2FS_BLK_TO_BYTES(map.m_pblk) : 0;
+		size = F2FS_BLK_TO_BYTES(map.m_len);
 		flags = 0;
 
 		if (compr_cluster) {
@@ -2026,13 +2016,13 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			count_in_cluster += map.m_len;
 			if (count_in_cluster == cluster_size) {
 				compr_cluster = false;
-				size += blks_to_bytes(inode, 1);
+				size += F2FS_BLKSIZE;
 			}
 		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
 			flags = FIEMAP_EXTENT_UNWRITTEN;
 		}
 
-		start_blk += bytes_to_blks(inode, size);
+		start_blk += F2FS_BYTES_TO_BLK(size);
 	}
 
 prep_next:
@@ -2070,7 +2060,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 					struct readahead_control *rac)
 {
 	struct bio *bio = *bio_ret;
-	const unsigned blocksize = blks_to_bytes(inode, 1);
+	const unsigned int blocksize = F2FS_BLKSIZE;
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -2080,8 +2070,8 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 
 	block_in_file = (sector_t)index;
 	last_block = block_in_file + nr_pages;
-	last_block_in_file = bytes_to_blks(inode,
-			f2fs_readpage_limit(inode) + blocksize - 1);
+	last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
+							blocksize - 1);
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
 
@@ -2181,7 +2171,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	struct bio *bio = *bio_ret;
 	unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
 	sector_t last_block_in_file;
-	const unsigned blocksize = blks_to_bytes(inode, 1);
+	const unsigned int blocksize = F2FS_BLKSIZE;
 	struct decompress_io_ctx *dic = NULL;
 	struct extent_info ei = {};
 	bool from_dnode = true;
@@ -2190,8 +2180,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 	f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
 
-	last_block_in_file = bytes_to_blks(inode,
-			f2fs_readpage_limit(inode) + blocksize - 1);
+	last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
+							blocksize - 1);
 
 	/* get rid of pages beyond EOF */
 	for (i = 0; i < cc->cluster_size; i++) {
@@ -3957,7 +3947,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	 * to be very smart.
 	 */
 	cur_lblock = 0;
-	last_lblock = bytes_to_blks(inode, i_size_read(inode));
+	last_lblock = F2FS_BYTES_TO_BLK(i_size_read(inode));
 
 	while (cur_lblock < last_lblock && cur_lblock < sis->max) {
 		struct f2fs_map_blocks map;
@@ -4200,8 +4190,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	pgoff_t next_pgofs = 0;
 	int err;
 
-	map.m_lblk = bytes_to_blks(inode, offset);
-	map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
+	map.m_lblk = F2FS_BYTES_TO_BLK(offset);
+	map.m_len = F2FS_BYTES_TO_BLK(offset + length - 1) - map.m_lblk + 1;
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
@@ -4212,7 +4202,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (err)
 		return err;
 
-	iomap->offset = blks_to_bytes(inode, map.m_lblk);
+	iomap->offset = F2FS_BLK_TO_BYTES(map.m_lblk);
 
 	/*
 	 * When inline encryption is enabled, sometimes I/O to an encrypted file
@@ -4232,21 +4222,21 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		if (WARN_ON_ONCE(map.m_pblk == NEW_ADDR))
 			return -EINVAL;
 
-		iomap->length = blks_to_bytes(inode, map.m_len);
+		iomap->length = F2FS_BLK_TO_BYTES(map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
 		iomap->bdev = map.m_bdev;
-		iomap->addr = blks_to_bytes(inode, map.m_pblk);
+		iomap->addr = F2FS_BLK_TO_BYTES(map.m_pblk);
 	} else {
 		if (flags & IOMAP_WRITE)
 			return -ENOTBLK;
 
 		if (map.m_pblk == NULL_ADDR) {
-			iomap->length = blks_to_bytes(inode, next_pgofs) -
-								iomap->offset;
+			iomap->length = F2FS_BLK_TO_BYTES(next_pgofs) -
+							iomap->offset;
 			iomap->type = IOMAP_HOLE;
 		} else if (map.m_pblk == NEW_ADDR) {
-			iomap->length = blks_to_bytes(inode, map.m_len);
+			iomap->length = F2FS_BLK_TO_BYTES(map.m_len);
 			iomap->type = IOMAP_UNWRITTEN;
 		} else {
 			f2fs_bug_on(F2FS_I_SB(inode), 1);
-- 
2.40.1


