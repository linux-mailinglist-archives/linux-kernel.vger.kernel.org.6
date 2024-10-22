Return-Path: <linux-kernel+bounces-375440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776949A95E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2F82843C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D1139CEF;
	Tue, 22 Oct 2024 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjGW5/53"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2764136E30
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562515; cv=none; b=MUwrBPK+/W4EdcnufK/LCqhJp5GHPmNwVvToZI+Gw6N+T3l7JN1pkxp40jiXY5YI4hO1cCf0c9PsBcb/V5BtO3W5cMhZH87lT1CYqS7GHnEYt5ox9xKIcSKknl9Bq6UajpFYCKKbwYlHLYLlyRRBdpj/k6xIkhb3IaoyB5idNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562515; c=relaxed/simple;
	bh=p1IPA7AXgFr6MIFjf4vUo0APCh0tHO4LcVmBobcRXkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CaDGNuA/lExnxMgzeh9vpI2L8EeW/qwJVEBMyWIAhHt59dANtZhUI/IuUuFpO+uWTNJTdTGQMcwfeK4EBDOwTVeX7wpEuw4xb/oWCOSDWB7XU6g4+Ntb7rpciSaWXviDTZFpV0p0xnMNQq5LA0lq0p28QkxHCKf9N/GCfUEL2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjGW5/53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B269C4CEC3;
	Tue, 22 Oct 2024 02:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729562515;
	bh=p1IPA7AXgFr6MIFjf4vUo0APCh0tHO4LcVmBobcRXkk=;
	h=From:To:Cc:Subject:Date:From;
	b=jjGW5/5315A4KM1hioo70ew7mF5SznAT92PGxI2lfKrvEA9ovqeIFY6xSdNah+w/+
	 gpmNCcCpD1xrpOt6M274DEBSXF8RDhbUnbaxkdAX1bAn4h9a9vX7jxgIAT7CO6sAfZ
	 r8qKx97trKG9OPDwvnUJz/KBYEW6760qeqnQCdzpaQf7u+8riIPusW6zL/YuFn0xjo
	 hPGdswqkC9vzpI3JgH2UyaySsTYRrw4DjrPVkJDqH64dGW0xqyi0bpNu171mYYR3Jh
	 p4eVaVFh2TloO+EAZKe/De9J5jBWOy9JMGXBA+9LZeFhoYSD+i7xfzPavT0ywtEEwS
	 MO+jVyyPo2H8A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs: fix to parse temperature correctly in f2fs_get_segment_temp()
Date: Tue, 22 Oct 2024 10:01:49 +0800
Message-Id: <20241022020149.2302191-1-chao@kernel.org>
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
v3:
- initialize type variable in __get_segment_type()
 fs/f2fs/f2fs.h    |  5 +++--
 fs/f2fs/file.c    |  4 ++--
 fs/f2fs/segment.c | 33 +++++++++++++++++++++++++--------
 fs/f2fs/segment.h |  4 ----
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3c6f3cce5779..7190b5677e44 100644
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
@@ -3759,7 +3759,8 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
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
index 75a8b22da664..0e7a0195eca8 100644
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
index bb2fd98331cd..a0347a59be6c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3604,18 +3604,35 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
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
+	enum log_type type = CURSEG_HOT_DATA;
 
 	switch (F2FS_OPTION(fio->sbi).active_logs) {
 	case 2:
@@ -3631,7 +3648,7 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 		f2fs_bug_on(fio->sbi, true);
 	}
 
-	fio->temp = f2fs_get_segment_temp(type);
+	fio->temp = f2fs_get_segment_temp(fio->sbi, type);
 
 	return type;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8bf09fb67841..c5228e1dfe9b 100644
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


