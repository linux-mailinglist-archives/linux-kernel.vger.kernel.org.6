Return-Path: <linux-kernel+bounces-291317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50DE9560D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87135281847
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0EA1BC20;
	Mon, 19 Aug 2024 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGll7YjG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F018E0E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030439; cv=none; b=oa5j7D4YqS+MptSoI1/25Lt9sTPu/vG59u0kwinNJoKkDPJo0ennP6A1Ol2ZMFy1+vj9QE3SuscyiN1Pk65rErSDoYRQ/66KgUgigr8nwpt4S7bP4E6qspHuXLWbUyqIR+R+Q1jdxmxAgLdUk3x0gxIrqaF2djzQLThrIqfOogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030439; c=relaxed/simple;
	bh=P+be2YV0Pz1Bes9YK9GlYeb7ROGI28QQhwWOLpl4U4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijmMuxGyXm7XSTMttZdOCqKRq/TyFIEYJ3T4RT03eF8swLqP1OIZPXzzkFoLoAR6Ro9xHr2htgQO5oHTZ48cGdNSoWcZyqSm8NptE0t2ee5MWg4Fcvy+ynpqN5X77KGrNQboxqZR/FiIOG1Rp3DhzzkO8GvHTyayvf7rvX40luM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGll7YjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA2BC32786;
	Mon, 19 Aug 2024 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724030438;
	bh=P+be2YV0Pz1Bes9YK9GlYeb7ROGI28QQhwWOLpl4U4s=;
	h=From:To:Cc:Subject:Date:From;
	b=iGll7YjGKwvT2n7x8QWoZH6Tkz7pGp/r5UjuJu4lxu9alE90MNOKYf0Wktak0NiyG
	 8VudkfP2PZ00Adphq+CEPTw0tpWqeEeOT7gIARHofBgHVI2rfbcW+Sr9uZ6DBsJrP/
	 haVG8SPMHsc4bKDszYMzNbq5GiSQPna/kNvZWWUyO1FtHxqFN4FNwqGNYVr20xBXr7
	 Re4bGJDxR69MKhtQmoLFUjxD8CEfyGRENq8eD0at1UEVVXPKeCushTkNgc2O9QCpuq
	 YZVV3kOwDRLrrO3HM1wy3mVivDgk9BGYSqXmqfSjA2fx2hnDhHzAN8B1w2wy/8V66f
	 RvnH2DzXdteAA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/8] f2fs: convert f2fs_write_begin() to use folio
Date: Mon, 19 Aug 2024 09:20:16 +0800
Message-Id: <20240819012023.3871272-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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
 fs/f2fs/data.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0655fddfc4ba..9e1ade13060c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3381,8 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			struct page *page, loff_t pos, unsigned len,
 			block_t *blk_addr, bool *node_changed)
 {
-	struct inode *inode = page->mapping->host;
-	pgoff_t index = page->index;
+	struct inode *inode = folio->mapping->host;
+	pgoff_t index = folio->index;
 	struct dnode_of_data dn;
 	struct page *ipage;
 	bool locked = false;
@@ -3419,7 +3419,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA(inode)) {
-			f2fs_do_read_inline_data(page_folio(page), ipage);
+			f2fs_do_read_inline_data(folio, ipage);
 			set_inode_flag(inode, FI_DATA_EXIST);
 			if (inode->i_nlink)
 				set_page_private_inline(ipage);
@@ -3518,12 +3518,12 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 }
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
-			struct page *page, loff_t pos, unsigned int len,
+			struct folio *folio, loff_t pos, unsigned int len,
 			block_t *blk_addr, bool *node_changed, bool *use_cow)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
-	pgoff_t index = page->index;
+	pgoff_t index = folio->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
 
@@ -3566,6 +3566,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *page = NULL;
+	struct folio *folio;
 	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
 	bool need_balance = false;
 	bool use_cow = false;
@@ -3625,22 +3626,23 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	/* TODO: cluster can be compressed due to race with .writepage */
 
 	*pagep = page;
+	folio = page_folio(page);
 
 	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, page, pos, len,
+		err = prepare_atomic_write_begin(sbi, folio, pos, len
 					&blkaddr, &need_balance, &use_cow);
 	else
-		err = prepare_write_begin(sbi, page, pos, len,
+		err = prepare_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance);
 	if (err)
 		goto fail;
 
 	if (need_balance && !IS_NOQUOTA(inode) &&
 			has_not_enough_free_secs(sbi, 0, 0)) {
-		unlock_page(page);
+		folio_unlock(folio);
 		f2fs_balance_fs(sbi, true);
-		lock_page(page);
-		if (page->mapping != mapping) {
+		folio_lock(folio);
+		if (folio->mapping != mapping) {
 			/* The page got truncated from under us */
 			f2fs_put_page(page, 1);
 			goto repeat;
@@ -3649,18 +3651,18 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	f2fs_wait_on_page_writeback(page, DATA, false, true);
 
-	if (len == PAGE_SIZE || PageUptodate(page))
+	if (len == PAGE_SIZE || folio_test_uptodate(folio))
 		return 0;
 
 	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
-		zero_user_segment(page, len, PAGE_SIZE);
+		folio_zero_segment(folio, len, folio_size(folio));
 		return 0;
 	}
 
 	if (blkaddr == NEW_ADDR) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+		folio_zero_segment(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
 	} else {
 		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
 				DATA_GENERIC_ENHANCE_READ)) {
@@ -3669,16 +3671,16 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		}
 		err = f2fs_submit_page_read(use_cow ?
 				F2FS_I(inode)->cow_inode : inode,
-				page_folio(page), blkaddr, 0, true);
+				folio, blkaddr, 0, true);
 		if (err)
 			goto fail;
 
-		lock_page(page);
-		if (unlikely(page->mapping != mapping)) {
+		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping)) {
 			f2fs_put_page(page, 1);
 			goto repeat;
 		}
-		if (unlikely(!PageUptodate(page))) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			err = -EIO;
 			goto fail;
 		}
-- 
2.40.1


