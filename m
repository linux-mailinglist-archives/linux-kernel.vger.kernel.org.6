Return-Path: <linux-kernel+bounces-294175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C806958A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FBA1C215BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB4219309A;
	Tue, 20 Aug 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocMVQX4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650F193075
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165724; cv=none; b=bk7UXcMqimgD1BryHvsezFvQRJ1ppkewVtkJfluvo5edejTpPBRnm0LwqIeGdVuRAF5lp8eRKSJM/EpqfkwwMGoAI9Vd0yrvPe2GarhptHmXF/kavbyJ9oRRNsNGqGCXT2IkEEVcAoCjANAmuAMgbea6Pvu/xNKWLvwlHPlDsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165724; c=relaxed/simple;
	bh=kI9JNrkqcWakqf9nzqIrzXTTjP9TFX7SUhwYCeGt3EY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PL51S6cIQ2BCGGqa7zUEnTJpmgTPXds9Vr1wfZKaqK1VaRJfHVPfGfktM04k5TEBUE5cQnUWvTIKaM6Ww6hGu1JScZ1dmCEtIO9ndTQ/4J0cEwvtxObYfsucxNd2lfn+0pVV2TClZI+qT569PhSD3468eMcnXaiJ/gYqHOCy7JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocMVQX4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38C9C4AF0F;
	Tue, 20 Aug 2024 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165724;
	bh=kI9JNrkqcWakqf9nzqIrzXTTjP9TFX7SUhwYCeGt3EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocMVQX4yvZXXOw7EB9CKyPfWAPT34+sT1q7W9pU+vK0pGK+Hauttq5icAxeX/NauH
	 mHAc36H9eWAyroe0RN27R8a+xzt/pq0yAWx6HA20RTNdJwEUwr4r5wq+xpfF1zRkFh
	 P9SGzliUI5/WLwoCwknMame3neclrreHFaC/YMN29CctYUQ6nA5DlC+IgtHNv2bi+c
	 a7qM9aj2nlE/Qc0epWV6LWuMJkOH6ZzUErYB+0RQTzi3M7UZEWY7YLJnu5xElBYiOl
	 Dg9lVUNg6bhJRIsyAEMdiaFOkVMjdTVppzhIzljhlCGI7RFS11VVOG/TywCpGxit9y
	 yCKJOny9Hi97A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 5/9] f2fs: convert f2fs_do_write_data_page() to use folio
Date: Tue, 20 Aug 2024 22:55:03 +0800
Message-Id: <20240820145507.1372905-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
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


