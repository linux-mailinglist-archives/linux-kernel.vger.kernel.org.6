Return-Path: <linux-kernel+bounces-553899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42143A59069
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C73188EC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC2226548;
	Mon, 10 Mar 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="clxrUSww"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FE224B01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600521; cv=none; b=JP+k5j8/YTuE2NtrV6XcfW5udle1b7uzLVkuIwe5UrXUcJHNG1uWaQbcHwciJ5Y+JcRBISxKx1XaDmeJGWYeBtKIp6FkupB3lJl7cPalvM1g94H37GSkqZhh5dmc+1Vztbau65rlxhabC4UT/mro14vou8XmcfC0GUjLQQPCKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600521; c=relaxed/simple;
	bh=WR7Z61D0WTPYhdMw5VkMJf2ghCbQAVtcdibKXxAZfDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=des5Ss7CPVM1HfFzXBe1jKpHhptQgUeWxqO773vJFxKvaPDLQe0i5OAncDu9dly6/hsfdP5XPizaCp0jO582WxINPtxzXvlHw68EN/GU5bCfOVzZKlHNOpTJNMIAEoB4gGIs8Eg9QF5gSPS7cw2ZreidMNlZ8Cw+XXxmXKTFsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=clxrUSww; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600508; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hLCfhtAgsnLF75lrVLJI+S/yAoxnVal1krGL9Ofsli4=;
	b=clxrUSwwOJpn7DlNpcSjGNGVw7w8YYHmyAtqxYyhW3nEkvrnXoZpQbUw19Zn7G3Lzt66yU7EkTosSURWA7xJl54FtZMBFPvZcyEDr7R0lev6IdsVyipQBXsSFRszGkAMP/wnv+s/FFaoaN8HgNhVpVXbexYWbx2aTGTVlyRf4jM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3yt_1741600507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 04/10] erofs: implement 48-bit block addressing for unencoded inodes
Date: Mon, 10 Mar 2025 17:54:54 +0800
Message-ID: <20250310095459.2620647-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It adapts the on-disk changes from the previous commit.  It also
supports EROFS_NULL_ADDR (all 1's) for EROFS_INODE_FLAT_PLAIN inodes
to indicate 0-filled inodes, as it's common for composefs use cases.
As a result, EROFS_INODE_CHUNK_BASED is no longer needed.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c              | 13 +++++++++----
 fs/erofs/dir.c               |  2 +-
 fs/erofs/inode.c             | 34 +++++++++++++++++++++++++---------
 fs/erofs/internal.h          | 12 ++++++------
 fs/erofs/super.c             | 15 ++++++++++-----
 fs/erofs/sysfs.c             |  2 ++
 include/trace/events/erofs.h |  2 +-
 7 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3c4a4eaffe8c..2409d2ab0c28 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -77,7 +77,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	unsigned int unit, blksz = sb->s_blocksize;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_chunk_index *idx;
-	erofs_blk_t startblk;
+	erofs_blk_t startblk, addrmask;
 	bool tailpacking;
 	erofs_off_t pos;
 	u64 chunknr;
@@ -91,6 +91,8 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 
 	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
 		tailpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+		if (!tailpacking && vi->startblk == EROFS_NULL_ADDR)
+			goto out;
 		pos = erofs_pos(sb, erofs_iblks(inode) - tailpacking);
 
 		map->m_flags = EROFS_MAP_MAPPED;
@@ -124,8 +126,11 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 	map->m_llen = min_t(erofs_off_t, 1UL << vi->chunkbits,
 			    round_up(inode->i_size - map->m_la, blksz));
 	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
-		startblk = le32_to_cpu(idx->startblk_lo);
-		if (startblk != EROFS_NULL_ADDR) {
+		addrmask = (vi->chunkformat & EROFS_CHUNK_FORMAT_48BIT) ?
+			BIT_ULL(48) - 1 : BIT_ULL(32) - 1;
+		startblk = (((u64)le16_to_cpu(idx->startblk_hi) << 32) |
+			    le32_to_cpu(idx->startblk_lo)) & addrmask;
+		if ((startblk ^ EROFS_NULL_ADDR) & addrmask) {
 			map->m_deviceid = le16_to_cpu(idx->device_id) &
 				EROFS_SB(sb)->device_id_mask;
 			map->m_pa = erofs_pos(sb, startblk);
@@ -133,7 +138,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 		}
 	} else {
 		startblk = le32_to_cpu(*(__le32 *)idx);
-		if (startblk != EROFS_NULL_ADDR) {
+		if (startblk != (u32)EROFS_NULL_ADDR) {
 			map->m_pa = erofs_pos(sb, startblk);
 			map->m_flags = EROFS_MAP_MAPPED;
 		}
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 1d3bb8746ab1..fa3c2d380cc9 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -60,7 +60,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
-			erofs_err(sb, "fail to readdir of logical block %u of nid %llu",
+			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
 				  erofs_blknr(sb, dbstart), EROFS_I(dir)->nid);
 			err = PTR_ERR(de);
 			break;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e74c0c00aa26..20d58228dfc9 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -31,10 +31,10 @@ static int erofs_read_inode(struct inode *inode)
 	unsigned int ofs = erofs_blkoff(sb, erofs_iloc(inode));
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	erofs_blk_t addrmask = BIT_ULL(48) - 1;
 	struct erofs_inode *vi = EROFS_I(inode);
 	struct erofs_inode_extended *die, copied;
 	struct erofs_inode_compact *dic;
-	union erofs_inode_i_u iu;
 	unsigned int ifmt;
 	void *ptr;
 	int err = 0;
@@ -71,6 +71,8 @@ static int erofs_read_inode(struct inode *inode)
 		if (ofs + vi->inode_isize <= sb->s_blocksize) {
 			ofs += vi->inode_isize;
 			die = (struct erofs_inode_extended *)dic;
+			copied.i_u = die->i_u;
+			copied.i_nb = die->i_nb;
 		} else {
 			const unsigned int gotten = sb->s_blocksize - ofs;
 
@@ -90,7 +92,6 @@ static int erofs_read_inode(struct inode *inode)
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(die->i_mode);
-		iu = die->i_u;
 		i_uid_write(inode, le32_to_cpu(die->i_uid));
 		i_gid_write(inode, le32_to_cpu(die->i_gid));
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
@@ -105,11 +106,21 @@ static int erofs_read_inode(struct inode *inode)
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(dic->i_mode);
-		iu = dic->i_u;
+		copied.i_u = dic->i_u;
+		copied.i_nb = dic->i_nb;
 		i_uid_write(inode, le16_to_cpu(dic->i_uid));
 		i_gid_write(inode, le16_to_cpu(dic->i_gid));
-		set_nlink(inode, le16_to_cpu(dic->i_nb.nlink));
-		inode_set_mtime(inode, sbi->build_time, sbi->build_time_nsec);
+		if (!S_ISDIR(inode->i_mode) &&
+		    ((ifmt >> EROFS_I_NLINK_1_BIT) & 1)) {
+			set_nlink(inode, 1);
+			copied.i_nb = dic->i_nb;
+		} else {
+			set_nlink(inode, le16_to_cpu(dic->i_nb.nlink));
+			copied.i_nb.startblk_hi = 0;
+			addrmask = BIT_ULL(32) - 1;
+		}
+		inode_set_mtime(inode, sbi->epoch + le32_to_cpu(dic->i_mtime),
+				sbi->fixed_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
 		break;
@@ -129,7 +140,12 @@ static int erofs_read_inode(struct inode *inode)
 	case S_IFREG:
 	case S_IFDIR:
 	case S_IFLNK:
-		vi->startblk = le32_to_cpu(iu.startblk_lo);
+		vi->startblk = le32_to_cpu(copied.i_u.startblk_lo) |
+			((u64)le16_to_cpu(copied.i_nb.startblk_hi) << 32);
+		if (vi->datalayout == EROFS_INODE_FLAT_PLAIN &&
+		    !((vi->startblk ^ EROFS_NULL_ADDR) & addrmask))
+			vi->startblk = EROFS_NULL_ADDR;
+
 		if(S_ISLNK(inode->i_mode)) {
 			err = erofs_fill_symlink(inode, ptr, ofs);
 			if (err)
@@ -138,7 +154,7 @@ static int erofs_read_inode(struct inode *inode)
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
-		inode->i_rdev = new_decode_dev(le32_to_cpu(iu.rdev));
+		inode->i_rdev = new_decode_dev(le32_to_cpu(copied.i_u.rdev));
 		break;
 	case S_IFIFO:
 	case S_IFSOCK:
@@ -152,14 +168,14 @@ static int erofs_read_inode(struct inode *inode)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout))
-		inode->i_blocks = le32_to_cpu(iu.blocks_lo) <<
+		inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
 					(sb->s_blocksize_bits - 9);
 	else
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
 		/* fill chunked inode summary info */
-		vi->chunkformat = le16_to_cpu(iu.c.format);
+		vi->chunkformat = le16_to_cpu(copied.i_u.c.format);
 		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
 			erofs_err(sb, "unsupported chunk format %x of nid %llu",
 				  vi->chunkformat, vi->nid);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 58e401131c75..07515a6f2534 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -37,8 +37,7 @@ __printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
 
 typedef u64 erofs_nid_t;
 typedef u64 erofs_off_t;
-/* data type for filesystem-wide blocks number */
-typedef u32 erofs_blk_t;
+typedef u64 erofs_blk_t;
 
 struct erofs_device_info {
 	char *path;
@@ -143,8 +142,8 @@ struct erofs_sb_info {
 	unsigned char blkszbits;	/* filesystem block size in bit shift */
 
 	u32 sb_size;			/* total superblock size */
-	u32 build_time_nsec;
-	u64 build_time;
+	u32 fixed_nsec;
+	s64 epoch;
 
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
@@ -205,8 +204,8 @@ struct erofs_buf {
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-#define erofs_blknr(sb, addr)	((erofs_blk_t)((addr) >> (sb)->s_blocksize_bits))
-#define erofs_blkoff(sb, addr)	((addr) & ((sb)->s_blocksize - 1))
+#define erofs_blknr(sb, pos)	((erofs_blk_t)((pos) >> (sb)->s_blocksize_bits))
+#define erofs_blkoff(sb, pos)	((pos) & ((sb)->s_blocksize - 1))
 #define erofs_pos(sb, blk)	((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
 #define erofs_iblks(i)	(round_up((i)->i_size, i_blocksize(i)) >> (i)->i_blkbits)
 
@@ -226,6 +225,7 @@ EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
+EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index a64f9765e95e..18445dc8597d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -268,7 +268,7 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
-	sbi->blkszbits  = dsb->blkszbits;
+	sbi->blkszbits = dsb->blkszbits;
 	if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
 		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
 		goto out;
@@ -308,13 +308,18 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
-	sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
+	if (erofs_sb_has_48bit(sbi) && dsb->rootnid_8b) {
+		sbi->root_nid = le64_to_cpu(dsb->rootnid_8b);
+		sbi->dif0.blocks = (sbi->dif0.blocks << 32) |
+				le16_to_cpu(dsb->rb.blocks_hi);
+	} else {
+		sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
+	}
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
-	sbi->build_time = le64_to_cpu(dsb->epoch);
-	sbi->build_time_nsec = le32_to_cpu(dsb->fixed_nsec);
-
+	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
+	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
 
 	/* parse on-disk compression configurations */
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 19d586273b70..dad4e6c6c155 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -81,6 +81,7 @@ EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
+EROFS_ATTR_FEATURE(48bit);
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -93,6 +94,7 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
+	ATTR_LIST(48bit),
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 57df3843e650..c69c7b1e41d1 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -75,7 +75,7 @@ TRACE_EVENT(erofs_fill_inode,
 		__entry->ofs		= erofs_blkoff(inode->i_sb, erofs_iloc(inode));
 	),
 
-	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %u ofs %u",
+	TP_printk("dev = (%d,%d), nid = %llu, blkaddr %llu ofs %u",
 		  show_dev_nid(__entry),
 		  __entry->blkaddr, __entry->ofs)
 );
-- 
2.43.5


