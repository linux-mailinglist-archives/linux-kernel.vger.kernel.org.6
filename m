Return-Path: <linux-kernel+bounces-212161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2F905C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C451C218FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7084A32;
	Wed, 12 Jun 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgyBIKp5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BFA3A29F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221114; cv=none; b=NpVtBPSTOmIYUc5WUTbNf4MPDsJPm/UvTZm0UYsSYrLVwHHoR3b0yc5EK5ruOAS1R8dSxrJ12cB60M+/LBtX/36E1sRJV8ReU8F3/pG8msABySnuffktpbfobYHV+YbNk2rcJBIVzTJ5gu21GyLTfu3hnfz7uev03T1TRTaCYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221114; c=relaxed/simple;
	bh=3O2VXIYtm+77i6RAmyE/iB05l4/QfxPoP/92pVes7fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQmouaRt5hxfNk4vMUmZSgGMW3aV3qV/dT0nndGIET3Qiru/1iF5CgHM/7Z6oJx3NZIEsl7g1iRZBskMMgipO4As5rOz5I8H1A8/GHN25bmYbsHP4GJ4gl5mrJrt418uDtQ6QuCiBgBqGYaen9q5pJ7Wg5XUjlh7FkdjUe7plaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgyBIKp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17D6C4AF48;
	Wed, 12 Jun 2024 19:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718221114;
	bh=3O2VXIYtm+77i6RAmyE/iB05l4/QfxPoP/92pVes7fo=;
	h=From:To:Cc:Subject:Date:From;
	b=sgyBIKp54VFxMG+medder41hKEsUF9I96Q7lJMnDAIgEa2Z90m9udgd5uLeLkl+uR
	 TWza8FdFCTK54XAb/CvhGGNfJ+FJsQI+CfjiFqGjeFS1ZecS1puBZC57agbfXef47z
	 bLXwfQKlaT9Lpv/9KVc8q2hyzWgnYuPSEoNqr0xTNVbOkBs/5KOsgAQyjlWstvPTNX
	 vQbSv7EkvxIM4wxwQbW+gPD9heSDvL9zY2DeLh4m79x5igjJO3QfxCHRef1mKuINww
	 49t/yHwvW3iT4rnhK2lgZ7ADKWaM6BcYarZ7MvHH005hqIboFvDpxGruZ6E4hH+S52
	 41BigPna414eA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: clean up set REQ_RAHEAD given rac
Date: Wed, 12 Jun 2024 19:38:31 +0000
Message-ID: <20240612193831.106524-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's set REQ_RAHEAD per rac by single source.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/data.c     | 17 +++++++++++------
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1ef82a546391..990b93689b46 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1100,7 +1100,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		struct bio *bio = NULL;
 
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
-					&last_block_in_bio, false, true);
+					&last_block_in_bio, NULL, true);
 		f2fs_put_rpages(cc);
 		f2fs_destroy_compress_ctx(cc, true);
 		if (ret)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9b0debc6b3d..b6dcb3bcaef7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2067,12 +2067,17 @@ static inline loff_t f2fs_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
+static inline blk_opf_t f2fs_ra_op_flags(struct readahead_control *rac)
+{
+	return rac ? REQ_RAHEAD : 0;
+}
+
 static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 					unsigned nr_pages,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
 					sector_t *last_block_in_bio,
-					bool is_readahead)
+					struct readahead_control *rac)
 {
 	struct bio *bio = *bio_ret;
 	const unsigned blocksize = blks_to_bytes(inode, 1);
@@ -2148,7 +2153,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 	}
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
-				is_readahead ? REQ_RAHEAD : 0, index,
+				f2fs_ra_op_flags(rac), index,
 				false);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
@@ -2178,7 +2183,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
-				bool is_readahead, bool for_write)
+				struct readahead_control *rac, bool for_write)
 {
 	struct dnode_of_data dn;
 	struct inode *inode = cc->inode;
@@ -2301,7 +2306,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		if (!bio) {
 			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages,
-					is_readahead ? REQ_RAHEAD : 0,
+					f2fs_ra_op_flags(rac),
 					page->index, for_write);
 			if (IS_ERR(bio)) {
 				ret = PTR_ERR(bio);
@@ -2399,7 +2404,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 			ret = f2fs_read_multi_pages(&cc, &bio,
 						max_nr_pages,
 						&last_block_in_bio,
-						rac != NULL, false);
+						rac, false);
 			f2fs_destroy_compress_ctx(&cc, false);
 			if (ret)
 				goto set_error_page;
@@ -2449,7 +2454,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
-							rac != NULL, false);
+							rac, false);
 				f2fs_destroy_compress_ctx(&cc, false);
 			}
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9688df332147..95d12e025786 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4297,7 +4297,7 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				unsigned int llen, unsigned int c_len);
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
-				bool is_readahead, bool for_write);
+				struct readahead_control *rac, bool for_write);
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
 void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 				bool in_task);
-- 
2.45.2.505.gda0bf45e8d-goog


