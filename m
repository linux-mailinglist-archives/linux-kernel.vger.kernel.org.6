Return-Path: <linux-kernel+bounces-284952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937D950748
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE41F23914
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C0119D88C;
	Tue, 13 Aug 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Ws6BEU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A719D09E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558428; cv=none; b=VYEYf9DBYps1uPoGtxSzqjM/DFtuWp2JlM1k89jC0YZy2GuqzQ8XImEineaIq6iQ13m4NG8G2cA8nxlT1oJg1qZPla0Ht4FOysOBSBr09DnD6XhJLLtQJjiYWk8aL7FXD6P+lHZOzJxQ+4NnrlfoNp9M3hNJtZDf7A0V6Fcpwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558428; c=relaxed/simple;
	bh=r8VUUyyyojUjPoAkVdjtfFrqOLyTXjXWxZ3MOiPSYtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPwly1qBsD7SQNwswPlzqeyhRYJryakIKwuy8n3KDLm9EbBUhqaogtQ7G+H0VH4BEf+wzUa32QG1moH9wOFvH3C/5BlnFIOsVFEVcjQlTrDKojLa23x4hQJzq05MigjtrXzsW/PAb1SA54SMBPuETyGTviNOgWff9VL/spumPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Ws6BEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FC6C4AF0B;
	Tue, 13 Aug 2024 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558426;
	bh=r8VUUyyyojUjPoAkVdjtfFrqOLyTXjXWxZ3MOiPSYtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7Ws6BEUshWrGSkJ6u4ewdjywioZy237bBmdMqh1qJUIyGgigcirqLDjCC+IxTknZ
	 5fVyXQ+QUcBwqUiDQPBEDOHzeBk2KuzDq1Tl9sTJuVSCL45d+EQi9sPHGJz0fgzm2Z
	 6pKbzAhXdL2RLzcYIJKnPM1yjoNxsvq/oP2NUu0LmuIGrZe1YuS2Y11rcXC7bALDQw
	 XzD2mqp2kfacqv9pyuCySGeuwzcU499UfsiQnAB1aeNC4Kg+CPs226Hd/thhKUW+f0
	 0quITyLHUZZS5mLINWSNJqMiiDrczFepJXA2q6+N6aOviZT2opgDepR2f9Sb+fxePA
	 aTO8Aq0m3Vtzg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/9] f2fs: convert f2fs_vm_page_mkwrite() to use folio
Date: Tue, 13 Aug 2024 22:13:24 +0800
Message-Id: <20240813141331.417067-2-chao@kernel.org>
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
 fs/f2fs/file.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8d2f4160a8eb..3c73da7bb05a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -53,7 +53,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 
 static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
@@ -85,7 +85,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, page->index);
+		int ret = f2fs_is_compressed_cluster(inode, folio->index);
 
 		if (ret < 0) {
 			err = ret;
@@ -105,11 +105,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
-	lock_page(page);
-	if (unlikely(page->mapping != inode->i_mapping ||
-			page_offset(page) > i_size_read(inode) ||
-			!PageUptodate(page))) {
-		unlock_page(page);
+	folio_lock(folio);
+	if (unlikely(folio->mapping != inode->i_mapping ||
+			folio_pos(folio) > i_size_read(inode) ||
+			!folio_test_uptodate(folio))) {
+		folio_unlock(folio);
 		err = -EFAULT;
 		goto out_sem;
 	}
@@ -117,9 +117,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	if (need_alloc) {
 		/* block allocation */
-		err = f2fs_get_block_locked(&dn, page->index);
+		err = f2fs_get_block_locked(&dn, folio->index);
 	} else {
-		err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+		err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
 		f2fs_put_dnode(&dn);
 		if (f2fs_is_pinned_file(inode) &&
 		    !__is_valid_data_blkaddr(dn.data_blkaddr))
@@ -127,11 +127,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto out_sem;
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA, false, true);
+	f2fs_wait_on_page_writeback(folio_page(folio, 0), DATA, false, true);
 
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
@@ -139,18 +139,18 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/*
 	 * check to see if the page is mapped already (no holes)
 	 */
-	if (PageMappedToDisk(page))
+	if (folio_test_mappedtodisk(folio))
 		goto out_sem;
 
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
+	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 						i_size_read(inode)) {
 		loff_t offset;
 
 		offset = i_size_read(inode) & ~PAGE_MASK;
-		zero_user_segment(page, offset, PAGE_SIZE);
+		folio_zero_segment(folio, offset, folio_size(folio));
 	}
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
 	f2fs_update_time(sbi, REQ_TIME);
@@ -162,7 +162,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out:
 	ret = vmf_fs_error(err);
 
-	trace_f2fs_vm_page_mkwrite(inode, page->index, vmf->vma->vm_flags, ret);
+	trace_f2fs_vm_page_mkwrite(inode, folio->index, vmf->vma->vm_flags, ret);
 	return ret;
 }
 
-- 
2.40.1


