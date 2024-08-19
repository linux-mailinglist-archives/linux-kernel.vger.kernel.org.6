Return-Path: <linux-kernel+bounces-291318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B49560D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B8A1C2125D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B81CF83;
	Mon, 19 Aug 2024 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th6dCCdQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F761BDE6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724030456; cv=none; b=gxGXWUs2vB2tWVhzpyC0srQfOWklQGjnidUXlvYjl/ZMmBqhYFKl4iAbaTeDzG+x4mWaHIvO4ZKEPBnliXpAmeRwWp2QLb2UeO+men917lkorUa74N7Hr5r/nOuf9M7Jmf+Q0RxZRoWbiszrHmyQzuXE+Ql4Ft0G42FTbr9i1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724030456; c=relaxed/simple;
	bh=RpwG5EcmusMtZWl0L7ZY9zxIw8uIi4krsgEzFuO4KFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3U+wTZC4B38pK8GJR8eR5ncwUd+SGZqBkonTJrJFJvvMcOxCwyunzQvBHeYWSVXAzGw+RLMCdGB1LjbkmtqLM9P98weo+WZySv51bKOoeUNXE/8nvQxhamxlikuW296s3rC13NNGIdm6vpbXJ+Ty51zE1ZkUiDuBNyZyQdXLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th6dCCdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3BEC4AF19;
	Mon, 19 Aug 2024 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724030456;
	bh=RpwG5EcmusMtZWl0L7ZY9zxIw8uIi4krsgEzFuO4KFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Th6dCCdQGDzOtEZSZjnPrqBeHpr5QJzZnwjwLFhujXirJ34pPAg5/3+zPrQya/Gjf
	 JEUsUA3q9nc+M35u3hOkqS1I3QJj8wSoWTmnasStfKiztj8pLpMs825wUoViepVpbx
	 CCA0y6ba4dhgJOwd978Qs9XFxzmNkXVMFiH7qCz1hc8VJqnLQmAe9M7g1E8FSYFF8T
	 EmZwPzGHSUzAU/LhCixQReRJ5cOFPQp70JoaqRfsRbuzSzL9U0L5dTXJ77epZmhFrk
	 Fcdq4Tl6QZoPE2KW+NyRDxrFoCwk90IR85WP5t2abt8hwVSoQPDVY87jZ3lrwZ12bY
	 VxhPtiFXw6qwQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/8] f2fs: convert f2fs_write_end() to use folio
Date: Mon, 19 Aug 2024 09:20:17 +0800
Message-Id: <20240819012023.3871272-2-chao@kernel.org>
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
 fs/f2fs/data.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9e1ade13060c..e114d738b6b4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3378,7 +3378,7 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
 }
 
 static int prepare_write_begin(struct f2fs_sb_info *sbi,
-			struct page *page, loff_t pos, unsigned len,
+			struct folio *folio, loff_t pos, unsigned int len,
 			block_t *blk_addr, bool *node_changed)
 {
 	struct inode *inode = folio->mapping->host;
@@ -3425,7 +3425,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 				set_page_private_inline(ipage);
 			goto out;
 		}
-		err = f2fs_convert_inline_page(&dn, page);
+		err = f2fs_convert_inline_page(&dn, folio_page(folio, 0));
 		if (err || dn.data_blkaddr != NULL_ADDR)
 			goto out;
 	}
@@ -3629,7 +3629,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	folio = page_folio(page);
 
 	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, folio, pos, len
+		err = prepare_atomic_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance, &use_cow);
 	else
 		err = prepare_write_begin(sbi, folio, pos, len,
@@ -3698,7 +3698,8 @@ static int f2fs_write_end(struct file *file,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
 
 	trace_f2fs_write_end(inode, pos, len, copied);
 
@@ -3707,17 +3708,17 @@ static int f2fs_write_end(struct file *file,
 	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
 	 * let generic_perform_write() try to copy data again through copied=0.
 	 */
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len))
 			copied = 0;
 		else
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* overwrite compressed file */
 	if (f2fs_compressed_file(inode) && fsdata) {
-		f2fs_compress_write_end(inode, fsdata, page->index, copied);
+		f2fs_compress_write_end(inode, fsdata, folio->index, copied);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 		if (pos + copied > i_size_read(inode) &&
@@ -3730,10 +3731,10 @@ static int f2fs_write_end(struct file *file,
 	if (!copied)
 		goto unlock_out;
 
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	if (f2fs_is_atomic_file(inode))
-		set_page_private_atomic(page);
+		set_page_private_atomic(folio_page(folio, 0));
 
 	if (pos + copied > i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
-- 
2.40.1


