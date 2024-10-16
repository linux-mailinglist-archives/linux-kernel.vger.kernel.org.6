Return-Path: <linux-kernel+bounces-367302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7959A009F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E48B22E51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8B18C01D;
	Wed, 16 Oct 2024 05:28:47 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2B18C021
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056527; cv=none; b=r+wD9oMKYEOIe5mKbxrNVXVbr77Vn3mQOc84dQGQmx0NCMGaT8GhEWsZq3WZ0fS4MWhV3Ty184z/bzZ4HOyAtxmOaYy5AoBRD2sSpGghOnmna7LKQQwttRHnL6cM7ZHGSG2qAS+aqfaEckwSRt6Y/qrejC3IFP1rJKIbr2hk6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056527; c=relaxed/simple;
	bh=NAyYjww6NuYkQYuCqsKaXzEHJZDoUd18AyghCBePBQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0+8ACDpikJuH5tMCnPwyRS3ycJSN3zK7DC3P9gQbwttdgAm1JLBkR8+z7ZX8dd+VZUONqXMWIN1oKlX2Jv/dIt4mWc5Tf3hiI6asE0PGcQNUva5mN1SwQfngu/doZ+9kuaeqsd0Bm8g+Lf+O0WFX8fHUrR0A7IITMLtasZiDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49G5S63f033963;
	Wed, 16 Oct 2024 13:28:06 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XSzy41Lghz2SW4QH;
	Wed, 16 Oct 2024 13:27:56 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 16 Oct 2024 13:28:03 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>
CC: <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <sunyibuaa@gmail.com>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [RFC PATCH 2/2] f2fs: introduce f2fs_invalidate_consecutive_blocks()
Date: Wed, 16 Oct 2024 13:27:58 +0800
Message-ID: <20241016052758.3400359-3-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016052758.3400359-1-yi.sun@unisoc.com>
References: <20241016052758.3400359-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49G5S63f033963

When doing truncate, consecutive blocks in the same segment
can be processed at the same time. So that the efficiency of
doing truncate can be improved.

Add f2fs_invalidate_compress_pages_range() only for doing truncate.
Add check_f2fs_invalidate_consecutive_blocks() only for doing
truncate and to determine whether the blocks are continuous and
belong to the same segment.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/compress.c | 14 ++++++++++++++
 fs/f2fs/f2fs.h     |  5 +++++
 fs/f2fs/file.c     | 34 +++++++++++++++++++++++++++++++++-
 fs/f2fs/segment.c  | 25 +++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7f26440e8595..70929a87e9bf 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -2014,6 +2014,20 @@ void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
 	} while (index < end);
 }
 
+void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int cnt)
+{
+	if (!sbi->compress_inode)
+		return;
+
+	if (cnt < 1) {
+		f2fs_bug_on(sbi, 1);
+		cnt = 1;
+	}
+
+	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr + cnt - 1);
+}
+
 int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
 {
 	struct inode *inode;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ce00cb546f4a..99767f35678f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3716,6 +3716,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
+void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, block_t addr, int cnt);
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
@@ -4375,6 +4376,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 								block_t blkaddr);
 void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
+void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int cnt);
 #define inc_compr_inode_stat(inode)					\
 	do {								\
 		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
@@ -4432,6 +4435,8 @@ static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
 				struct page *page, block_t blkaddr) { return false; }
 static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
 							nid_t ino) { }
+static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
+						block_t blkaddr, int cnt) { }
 #define inc_compr_inode_stat(inode)		do { } while (0)
 static inline int f2fs_is_compressed_cluster(
 				struct inode *inode,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7057efa8ec17..634691e3b5f1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -612,6 +612,18 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	return finish_preallocate_blocks(inode);
 }
 
+static bool check_f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi,
+					block_t blkaddr1, block_t blkaddr2)
+{
+	if (blkaddr2 - blkaddr1 != 1)
+		return false;
+
+	if (GET_SEGNO(sbi, blkaddr1) != GET_SEGNO(sbi, blkaddr2))
+		return false;
+
+	return true;
+}
+
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
@@ -621,6 +633,9 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	int cluster_index = 0, valid_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
+	block_t con_start;
+	bool run_invalid = true;
+	int con_cnt = 1;
 
 	addr = get_dnode_addr(dn->inode, dn->node_page) + ofs;
 
@@ -652,7 +667,24 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 				valid_blocks++;
 		}
 
-		f2fs_invalidate_blocks(sbi, blkaddr);
+		if (run_invalid)
+			con_start = blkaddr;
+
+		if (count > 1 &&
+			check_f2fs_invalidate_consecutive_blocks(sbi, blkaddr,
+				le32_to_cpu(*(addr + 1)))) {
+			run_invalid = false;
+
+			if (con_cnt++ == 1)
+				con_start = blkaddr;
+		} else {
+			run_invalid = true;
+		}
+
+		if (run_invalid) {
+			f2fs_invalidate_consecutive_blocks(sbi, con_start, con_cnt);
+			con_cnt = 1;
+		}
 
 		if (!released || blkaddr != COMPRESS_ADDR)
 			nr_free++;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f118faf36d35..edb8a78985ba 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2570,6 +2570,31 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	up_write(&sit_i->sentry_lock);
 }
 
+void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, block_t addr, int cnt)
+{
+	unsigned int segno = GET_SEGNO(sbi, addr);
+	unsigned int segno2 = GET_SEGNO(sbi, addr + cnt - 1);
+	struct sit_info *sit_i = SIT_I(sbi);
+
+	f2fs_bug_on(sbi, addr == NULL_ADDR || segno != segno2);
+	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
+		return;
+
+	f2fs_truncate_meta_inode_pages(sbi, addr, cnt);
+	f2fs_invalidate_compress_pages_range(sbi, addr, cnt);
+
+	/* add it into sit main buffer */
+	down_write(&sit_i->sentry_lock);
+
+	update_segment_mtime(sbi, addr, 0);
+	update_sit_entry(sbi, addr, -cnt);
+
+	/* add it into dirty seglist */
+	locate_dirty_segment(sbi, segno);
+
+	up_write(&sit_i->sentry_lock);
+}
+
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-- 
2.25.1


