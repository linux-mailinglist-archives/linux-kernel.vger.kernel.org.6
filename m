Return-Path: <linux-kernel+bounces-293211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62417957C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FC52873D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAC14C5A3;
	Tue, 20 Aug 2024 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRJLxlUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375943ACB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125638; cv=none; b=RDnQsUH43xrN8HtX04isLMQKuzfsQd8BCj+RJGVo20aNCXg36tA3S+A1OKKKXsvMxOuVtJqzXZwWCTfvWuX5GOyxQngzed4/riBRHNoZz0RG+nC4FA820gxocwIH2rW+/JM4gqO4q4EQOvq+P/ClaZCqiRl98hs8aD2bTLLvo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125638; c=relaxed/simple;
	bh=8r7Ek2cBap+An9MVHAkEPVDijkmUphd6VWrszUU4RwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thnRGB8zcTmKhY4jqElMboAVyz5maWEdGKPNseBIHg71D+lVtaybgAXXQMEYtr5gS1QPzDokpsxJNP47/8TA++fYFIdmDBu6h6BMG40KjozyahmdQAtz65G9PfFZiNZWsLGfPEtK5SXZL9poN2f3omgmuFY5cNju2tv/qY4XQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRJLxlUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D10AC4AF09;
	Tue, 20 Aug 2024 03:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724125637;
	bh=8r7Ek2cBap+An9MVHAkEPVDijkmUphd6VWrszUU4RwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRJLxlUGgbeST1Z2h6/Qb1w/LMJrsufYye6VcWESI36hZ+vHOWF4CXIjSSynT4TRC
	 HKm3wzFu8l2902A2ca6RnJUaFuB73eVAY8hrAY0r7PPTquT+Lt2P3xLTdZwqitoRmy
	 pTR7hSK0ztWC4pDYkBfQj6xHAYEgkpfRr5vQZsTopnraBbPDGSnk3dDkT0n/moWvcH
	 tgEMkeLxK9bSeHHz3ReGcgvAnn49BekZ8iuPgX5mOGBVtpJ4R+/y8BMdwQKa5HaZct
	 wylRUHT0RzOM6eEo9UIpuYgB/bTeYudA8C3U0OXJaxy2tHO1IOj2cHDgdQC9xblPmb
	 BvtvCc33BPHUw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 8/8] f2fs: get rid of page->index
Date: Tue, 20 Aug 2024 11:46:54 +0800
Message-Id: <20240820034654.698236-8-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820034654.698236-1-chao@kernel.org>
References: <20240820034654.698236-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/data.c     | 12 ++++++------
 fs/f2fs/dir.c      |  3 ++-
 fs/f2fs/inode.c    |  3 ++-
 fs/f2fs/node.c     |  4 ++--
 fs/f2fs/segment.c  |  3 ++-
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 67bb1e2e07a4..163ad0d7d495 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -881,7 +881,7 @@ static bool cluster_has_invalid_data(struct compress_ctx *cc)
 		f2fs_bug_on(F2FS_I_SB(cc->inode), !page);
 
 		/* beyond EOF */
-		if (page->index >= nr_pages)
+		if (page_folio(page)->index >= nr_pages)
 			return true;
 	}
 	return false;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e69097267b99..c6d688208f8b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -354,7 +354,7 @@ static void f2fs_write_end_io(struct bio *bio)
 		}
 
 		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
-					page->index != nid_of_node(page));
+				page_folio(page)->index != nid_of_node(page));
 
 		dec_page_count(sbi, type);
 		if (f2fs_in_warm_node_list(sbi, page))
@@ -703,7 +703,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	bio = __bio_alloc(fio, 1);
 
 	f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
-			       fio->page->index, fio, GFP_NOIO);
+			page_folio(fio->page)->index, fio, GFP_NOIO);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		bio_put(bio);
@@ -802,7 +802,7 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 							    fio->new_blkaddr));
 			if (f2fs_crypt_mergeable_bio(*bio,
 					fio->page->mapping->host,
-					fio->page->index, fio) &&
+					page_folio(fio->page)->index, fio) &&
 			    bio_add_page(*bio, page, PAGE_SIZE, 0) ==
 					PAGE_SIZE) {
 				ret = 0;
@@ -902,7 +902,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_VECS);
 		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
-				       fio->page->index, fio, GFP_NOIO);
+				page_folio(fio->page)->index, fio, GFP_NOIO);
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
 	} else {
@@ -995,13 +995,13 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
-				       bio_page->index, fio)))
+				page_folio(bio_page)->index, fio)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
 		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
 		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
-				       bio_page->index, fio, GFP_NOIO);
+				page_folio(bio_page)->index, fio, GFP_NOIO);
 		io->fio = *fio;
 	}
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 5fcc952107e9..1136539a57a8 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -842,6 +842,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	struct	f2fs_dentry_block *dentry_blk;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
+	pgoff_t index = page_folio(page)->index;
 	int i;
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
@@ -867,7 +868,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
-		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
+		!f2fs_truncate_hole(dir, index, index + 1)) {
 		f2fs_clear_page_cache_dirty_tag(page_folio(page));
 		clear_page_dirty_for_io(page);
 		ClearPageUptodate(page);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 5d7e4c7f5969..b2d5c3ef8e24 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -174,7 +174,8 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 
 	if (provided != calculated)
 		f2fs_warn(sbi, "checksum invalid, nid = %lu, ino_of_node = %x, %x vs. %x",
-			  page->index, ino_of_node(page), provided, calculated);
+			  page_folio(page)->index, ino_of_node(page),
+			  provided, calculated);
 
 	return provided == calculated;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f5e5abce695b..59b13ff243fa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -919,7 +919,7 @@ static int truncate_node(struct dnode_of_data *dn)
 	clear_node_page_dirty(dn->node_page);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
-	index = dn->node_page->index;
+	index = page_folio(dn->node_page)->index;
 	f2fs_put_page(dn->node_page, 1);
 
 	invalidate_mapping_pages(NODE_MAPPING(sbi),
@@ -1869,7 +1869,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 	if (!ret && atomic && !marked) {
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
-			   ino, last_page->index);
+			   ino, page_folio(last_page)->index);
 		lock_page(last_page);
 		f2fs_wait_on_page_writeback(last_page, NODE, true, true);
 		set_page_dirty(last_page);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3bda3f707007..fafbb1cbcb57 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3564,7 +3564,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (file_is_cold(inode) || f2fs_need_compress_data(inode))
 			return CURSEG_COLD_DATA;
 
-		type = __get_age_segment_type(inode, fio->page->index);
+		type = __get_age_segment_type(inode,
+				page_folio(fio->page)->index);
 		if (type != NO_CHECK_TYPE)
 			return type;
 
-- 
2.40.1


