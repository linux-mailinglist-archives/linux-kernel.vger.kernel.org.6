Return-Path: <linux-kernel+bounces-291320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807369560DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3750E1F21246
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E6E36B17;
	Mon, 19 Aug 2024 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5aXqjCF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB14634
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030460; cv=none; b=PCtRsRA/Z3iI6kcZsr5vbdjGGxGPZ/Kz5HEgILg5RAC1t8zKKtlkm3ud4k7xeopI0l2VdnLPOXxy/J9sIegmr9NaCCaUJl91nlXSxIADQRnAcnrMkwO4CeArqlXnQM/gFOtNAiZprTpO9hKuk3R+6Y476VCc72IjXJYgRJmJ4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030460; c=relaxed/simple;
	bh=kI9JNrkqcWakqf9nzqIrzXTTjP9TFX7SUhwYCeGt3EY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jH3UqUcCR/OpV32zhE0Mz0fsrioK0o9PAijdDeUVNxLU5LGwbJSXeIHeKsjUy9YV9reK74+h0IE+gb2pY3e8X6E/IaroBcw4OfXTB0uECyQhdBFhy52g9jinK4aLj6vXJdI4JjKKRQv4CuhneOgC6JPeFXNtfJK33hkjqnyrlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5aXqjCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9F2C4AF0B;
	Mon, 19 Aug 2024 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724030460;
	bh=kI9JNrkqcWakqf9nzqIrzXTTjP9TFX7SUhwYCeGt3EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5aXqjCFwU2zWIIRqIcR0mUWgN+gKVG4jGh5mBRNloM2Tcu2DEeZ6Ov/50czBUnOA
	 XaE8p+rZnG7GvEr7J5iuj4chzfwrNycFJfqo3Y4cmUDtdDl53vRx5H0GDHZGN1HEih
	 TJLU+jCgMPM+UKGicQORpyliYLhSANIPPVpOgq3dRO1H3j6YVYg2JeuGImDjFLgssL
	 vCdCxTzs1Uz6bWNybfmlPIGzxkqGjAZp2TjIG5LAp8r2IhBCgdiwEqybEG83XUDrBg
	 2hL+8hR/ujVQoPi+3K8OqDUMliYwtRN36+QLpsdSD7frriKY4OP5dxPq8JmcTKuPZB
	 pC6insOss6X6Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4/8] f2fs: convert f2fs_do_write_data_page() to use folio
Date: Mon, 19 Aug 2024 09:20:19 +0800
Message-Id: <20240819012023.3871272-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240819012023.3871272-1-chao@kernel.org>
References: <20240819012023.3871272-1-chao@kernel.org>
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
 fs/f2fs/data.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e114d738b6b4..c57ddee2c7c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2648,8 +2648,8 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
 
 int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 {
-	struct page *page = fio->page;
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(fio->page);
+	struct inode *inode = folio->mapping->host;
 	struct dnode_of_data dn;
 	struct node_info ni;
 	bool ipu_force = false;
@@ -2658,14 +2658,14 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	/* Use COW inode to make dnode_of_data for atomic write */
 	atomic_commit = f2fs_is_atomic_file(inode) &&
-				page_private_atomic(fio->page);
+				page_private_atomic(folio_page(folio, 0));
 	if (atomic_commit)
 		set_new_dnode(&dn, F2FS_I(inode)->cow_inode, NULL, NULL, 0);
 	else
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 
 	if (need_inplace_update(fio) &&
-	    f2fs_lookup_read_extent_cache_block(inode, page->index,
+	    f2fs_lookup_read_extent_cache_block(inode, folio->index,
 						&fio->old_blkaddr)) {
 		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
 						DATA_GENERIC_ENHANCE))
@@ -2680,7 +2680,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
 		return -EAGAIN;
 
-	err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+	err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
 	if (err)
 		goto out;
 
@@ -2688,8 +2688,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
-		ClearPageUptodate(page);
-		clear_page_private_gcing(page);
+		folio_clear_uptodate(folio);
+		clear_page_private_gcing(folio_page(folio, 0));
 		goto out_writepage;
 	}
 got_it:
@@ -2715,7 +2715,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		if (err)
 			goto out_writepage;
 
-		set_page_writeback(page);
+		folio_start_writeback(folio);
 		f2fs_put_dnode(&dn);
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
@@ -2723,11 +2723,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		if (err) {
 			if (fscrypt_inode_uses_fs_layer_crypto(inode))
 				fscrypt_finalize_bounce_page(&fio->encrypted_page);
-			end_page_writeback(page);
+			folio_end_writeback(folio);
 		} else {
 			set_inode_flag(inode, FI_UPDATE_WRITE);
 		}
-		trace_f2fs_do_write_data_page(page_folio(page), IPU);
+		trace_f2fs_do_write_data_page(folio, IPU);
 		return err;
 	}
 
@@ -2749,17 +2749,17 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	if (err)
 		goto out_writepage;
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 
 	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
 		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
 
 	/* LFS mode write path */
 	f2fs_outplace_write_data(&dn, fio);
-	trace_f2fs_do_write_data_page(page_folio(page), OPU);
+	trace_f2fs_do_write_data_page(folio, OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (atomic_commit)
-		clear_page_private_atomic(page);
+		clear_page_private_atomic(folio_page(folio, 0));
 out_writepage:
 	f2fs_put_dnode(&dn);
 out:
-- 
2.40.1


