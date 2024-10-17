Return-Path: <linux-kernel+bounces-369025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D29A17ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16581F26A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C21DA5A;
	Thu, 17 Oct 2024 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZx71UDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B912E7F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128579; cv=none; b=B7icuycvqWvy0HR7e8kRmee9pMU36mVBenxnVCCH0FZAa0EeogTjSAs4YDkyFP74yRiZQcDgS+Md3QKJ0QmuPMHdxGHgGVoYamEIECrqDC4tgIs+jqAqCm/M/B6DbREX9JDx9kJvVpyDuaQ40ZTG/ctjOjM7A3e2Hi/q/6xSFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128579; c=relaxed/simple;
	bh=5uWKOLBLn15zISg5A9rYN6qNLZtI1h333CyXCSKao40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tyV4SXu0bKKw9QFhZUwEXVfq4WXmekjlNBjsSAyNVOZt0k+1MwJFpzZpBYRZmqhJ61ZAMHgb6CXIzGrOwpxVaIEZFdxvFIzz8oGq5mmeIfnyk6B4NuLE3S4FCiccaS555utpqD9gmENyEP2UXhfimat/pk27POiJucvlIFko28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZx71UDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BDBC4CEC5;
	Thu, 17 Oct 2024 01:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729128579;
	bh=5uWKOLBLn15zISg5A9rYN6qNLZtI1h333CyXCSKao40=;
	h=From:To:Cc:Subject:Date:From;
	b=HZx71UDsLeccilUed3hqgfOfPhR+2RBNErwVznbEfybpswV59nHtlbMJZylwaZzef
	 l6PvawoQ7ewJk0Hk26VxNR8HTX6N/sDr8qwcNV5SQtMxZHUfLj45PSSXXxZ7fJyoVY
	 i9WS0UujxMZg7S5zrWEGB4O8s3+t+ymjjc8u+LpXSxiyK4Zmvba0BgbSuDlLpnADaY
	 IrCpZy2bLW3l+uui89soBfHxxWfzJAzJxZWwBu60AGX/QMDPFWGhcsTWsKGQt8Hic4
	 ydgrG2OIibwj4QBdTp5KLXFRpHAB1nhS/yH1xsShP60ajSjcQfnoxF5z+revKpTjna
	 YPsSkb4KDYuhg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to parse temperature correctly in f2fs_get_segment_temp()
Date: Thu, 17 Oct 2024 09:29:32 +0800
Message-Id: <20241017012932.1570038-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __get_segment_type(), __get_segment_type_6() may return
CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC log type, but
following f2fs_get_segment_temp() can only handle persistent
log type, fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- initialize variable in f2fs_get_segment_temp() to avoid
static compilier complaint.
 fs/f2fs/f2fs.h    |  5 +++--
 fs/f2fs/file.c    |  4 ++--
 fs/f2fs/segment.c | 33 +++++++++++++++++++++++++--------
 fs/f2fs/segment.h |  4 ----
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f3ef4dc50992..56797f8e6659 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1019,7 +1019,7 @@ static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
 #define NR_CURSEG_PERSIST_TYPE	(NR_CURSEG_DATA_TYPE + NR_CURSEG_NODE_TYPE)
 #define NR_CURSEG_TYPE		(NR_CURSEG_INMEM_TYPE + NR_CURSEG_PERSIST_TYPE)
 
-enum {
+enum log_type {
 	CURSEG_HOT_DATA	= 0,	/* directory entry blocks */
 	CURSEG_WARM_DATA,	/* data blocks */
 	CURSEG_COLD_DATA,	/* multimedia or GCed data blocks */
@@ -3758,7 +3758,8 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			block_t old_addr, block_t new_addr,
 			unsigned char version, bool recover_curseg,
 			bool recover_newaddr);
-int f2fs_get_segment_temp(int seg_type);
+enum temp_type f2fs_get_segment_temp(struct f2fs_sb_info *sbi,
+						enum log_type seg_type);
 int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0e07231dc093..92d7c62eba29 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4858,8 +4858,8 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 {
 	struct inode *inode = iter->inode;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int seg_type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
-	enum temp_type temp = f2fs_get_segment_temp(seg_type);
+	enum log_type type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
+	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
 
 	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
 	submit_bio(bio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0f4408fe2b19..8e80e6620854 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3603,18 +3603,35 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 	}
 }
 
-int f2fs_get_segment_temp(int seg_type)
+enum temp_type f2fs_get_segment_temp(struct f2fs_sb_info *sbi,
+						enum log_type type)
 {
-	if (IS_HOT(seg_type))
-		return HOT;
-	else if (IS_WARM(seg_type))
-		return WARM;
-	return COLD;
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	enum temp_type temp = COLD;
+
+	switch (curseg->seg_type) {
+	case CURSEG_HOT_NODE:
+	case CURSEG_HOT_DATA:
+		temp = HOT;
+		break;
+	case CURSEG_WARM_NODE:
+	case CURSEG_WARM_DATA:
+		temp = WARM;
+		break;
+	case CURSEG_COLD_NODE:
+	case CURSEG_COLD_DATA:
+		temp = COLD;
+		break;
+	default:
+		f2fs_bug_on(sbi, 1);
+	}
+
+	return temp;
 }
 
 static int __get_segment_type(struct f2fs_io_info *fio)
 {
-	int type = 0;
+	enum log_type type;
 
 	switch (F2FS_OPTION(fio->sbi).active_logs) {
 	case 2:
@@ -3630,7 +3647,7 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 		f2fs_bug_on(fio->sbi, true);
 	}
 
-	fio->temp = f2fs_get_segment_temp(type);
+	fio->temp = f2fs_get_segment_temp(fio->sbi, type);
 
 	return type;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 55a01da6c4be..6a23bb1d16a2 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -34,10 +34,6 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 	f2fs_bug_on(sbi, seg_type >= NR_PERSISTENT_LOG);
 }
 
-#define IS_HOT(t)	((t) == CURSEG_HOT_NODE || (t) == CURSEG_HOT_DATA)
-#define IS_WARM(t)	((t) == CURSEG_WARM_NODE || (t) == CURSEG_WARM_DATA)
-#define IS_COLD(t)	((t) == CURSEG_COLD_NODE || (t) == CURSEG_COLD_DATA)
-
 #define IS_CURSEG(sbi, seg)						\
 	(((seg) == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno) ||	\
 	 ((seg) == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno) ||	\
-- 
2.40.1


