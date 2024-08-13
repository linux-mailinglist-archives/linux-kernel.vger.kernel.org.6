Return-Path: <linux-kernel+bounces-284955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01BC950751
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DC42827CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82419DF7C;
	Tue, 13 Aug 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jojLb2S8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9619DF69
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558432; cv=none; b=j3lB5aoMzBGCx3LC1l0hFMSYvd85QuvCiVS7Sz2/e/Q+ld1Mx3To+KaOMzuZBLHvEqhdNjAr35Qj6BQ83NNG3+Rr4CYLcIsdVZXBU9mtTpsQ6BwEVx0ZEq7eUqiInb410Q3e3VGuGB6/K0jIuHqOs8Ep/EbCiZ+ETYwwWHJKY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558432; c=relaxed/simple;
	bh=CAOJ8mgA8jKzzI9hA7HpfYwAeUu6fh4NOYcV9F2ZHaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2w+Q1jXN4LJNFljNRLi/wuwJTfRqkJ2JImADkkG3fcfPATSYJSf97Zo8pZU6D25hyUUpPgrgxga1FnHDK9hVQF/yKDa+dVi6ygBaiLDtKrpG3gaAaVYp9LPsoVWeMC0TJ9k5gKLrl9jmgp7oqBK58s7iXuLy4lCxjfoSwkRe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jojLb2S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6733C4AF0F;
	Tue, 13 Aug 2024 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558432;
	bh=CAOJ8mgA8jKzzI9hA7HpfYwAeUu6fh4NOYcV9F2ZHaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jojLb2S8+RXDU3B+0dvEVenn7/GAwWb3Mu2ll6AbX3FJ+WXV0Ul8RFaFDRhqt2lAm
	 Eyn1k3U1YVnoXMZrjxCmGRHdRlS8xIL5/BzSicOS/CkUwMXRc0S/VE2G/BpZ4F4w/k
	 dBB6FWr3cf2GXDCdV/wExXZZQhhShlqJh70kMYz8XE+ATbLNZNfz/YGNohcpM5DVXB
	 blgqcGLhod9jvLlJzDlQepVfEGQQyWpgXp5sMPm9U2YBZj20IR4lMoJDEpg3R7WFEN
	 40HSY1IO/t4BvQ4i4T6uszN5J9GMXG6twUuW2mJkP/4D/61yQC1rHg3kSwhk+6iEgC
	 OrEn7tvVBaDVg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 5/9] f2fs: convert f2fs_write_single_data_page() to use folio
Date: Tue, 13 Aug 2024 22:13:27 +0800
Message-Id: <20240813141331.417067-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>
References: <20240813141331.417067-1-chao@kernel.org>
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
 fs/f2fs/compress.c |  3 ++-
 fs/f2fs/data.c     | 29 +++++++++++++++--------------
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index eb5cd1457ffc..82c31641e696 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1523,7 +1523,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
-		ret = f2fs_write_single_data_page(cc->rpages[i], &submitted,
+		ret = f2fs_write_single_data_page(page_folio(cc->rpages[i]),
+						&submitted,
 						NULL, NULL, wbc, io_type,
 						compr_blocks, false);
 		if (ret) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d2a37db0c9e..0779e222f709 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2764,7 +2764,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	return err;
 }
 
-int f2fs_write_single_data_page(struct page *page, int *submitted,
+int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct bio **bio,
 				sector_t *last_block,
 				struct writeback_control *wbc,
@@ -2772,12 +2772,13 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 				int compr_blocks,
 				bool allow_balance)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
+	struct page *page = folio_page(folio, 0);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	loff_t i_size = i_size_read(inode);
 	const pgoff_t end_index = ((unsigned long long)i_size)
 							>> PAGE_SHIFT;
-	loff_t psize = (loff_t)(page->index + 1) << PAGE_SHIFT;
+	loff_t psize = (loff_t)(folio->index + 1) << PAGE_SHIFT;
 	unsigned offset = 0;
 	bool need_balance_fs = false;
 	bool quota_inode = IS_NOQUOTA(inode);
@@ -2801,11 +2802,11 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		.last_block = last_block,
 	};
 
-	trace_f2fs_writepage(page_folio(page), DATA);
+	trace_f2fs_writepage(folio, DATA);
 
 	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
-		mapping_set_error(page->mapping, -EIO);
+		mapping_set_error(folio->mapping, -EIO);
 		/*
 		 * don't drop any dirty dentry pages for keeping lastest
 		 * directory structure.
@@ -2823,7 +2824,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
-	if (page->index < end_index ||
+	if (folio->index < end_index ||
 			f2fs_verity_in_progress(inode) ||
 			compr_blocks)
 		goto write;
@@ -2833,10 +2834,10 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	 * this page does not have to be written to disk.
 	 */
 	offset = i_size & (PAGE_SIZE - 1);
-	if ((page->index >= end_index + 1) || !offset)
+	if ((folio->index >= end_index + 1) || !offset)
 		goto out;
 
-	zero_user_segment(page, offset, PAGE_SIZE);
+	folio_zero_segment(folio, offset, folio_size(folio));
 write:
 	/* Dentry/quota blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode) || quota_inode) {
@@ -2896,7 +2897,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 out:
 	inode_dec_dirty_pages(inode);
 	if (err) {
-		ClearPageUptodate(page);
+		folio_clear_uptodate(folio);
 		clear_page_private_gcing(page);
 	}
 
@@ -2906,7 +2907,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 		f2fs_remove_dirty_inode(inode);
 		submitted = NULL;
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode) &&
 			!F2FS_I(inode)->wb_task && allow_balance)
 		f2fs_balance_fs(sbi, need_balance_fs);
@@ -2924,7 +2925,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	return 0;
 
 redirty_out:
-	redirty_page_for_writepage(wbc, page);
+	folio_redirty_for_writepage(wbc, folio);
 	/*
 	 * pageout() in MM translates EAGAIN, so calls handle_write_error()
 	 * -> mapping_set_error() -> set_bit(AS_EIO, ...).
@@ -2933,7 +2934,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	 */
 	if (!err || wbc->for_reclaim)
 		return AOP_WRITEPAGE_ACTIVATE;
-	unlock_page(page);
+	folio_unlock(folio);
 	return err;
 }
 
@@ -2955,7 +2956,7 @@ static int f2fs_write_data_page(struct page *page,
 out:
 #endif
 
-	return f2fs_write_single_data_page(page, NULL, NULL, NULL,
+	return f2fs_write_single_data_page(page_folio(page), NULL, NULL, NULL,
 						wbc, FS_DATA_IO, 0, true);
 }
 
@@ -3165,7 +3166,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 #endif
-			ret = f2fs_write_single_data_page(&folio->page,
+			ret = f2fs_write_single_data_page(folio,
 					&submitted, &bio, &last_block,
 					wbc, io_type, 0, true);
 			if (ret == AOP_WRITEPAGE_ACTIVATE)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7c7760aa1a7c..5800ac90a5f7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3881,7 +3881,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 int f2fs_encrypt_one_page(struct f2fs_io_info *fio);
 bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
 bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
-int f2fs_write_single_data_page(struct page *page, int *submitted,
+int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct bio **bio, sector_t *last_block,
 				struct writeback_control *wbc,
 				enum iostat_type io_type,
-- 
2.40.1


