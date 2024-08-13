Return-Path: <linux-kernel+bounces-284953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAB95074C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE72847FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FE19D89E;
	Tue, 13 Aug 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deSS6dQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9ED19D88B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558428; cv=none; b=EprPN13XlsoWf/gmoWYfhEJ+IBeJIGA6EW+bE+QYguARHQiLeJ7f/2hPM3iklxCiO+B5QJTap2Q06Tss3uOH5xphUx3L6Hf/5PPujnHxI9p6zz3w+2Gx4duMgCK9LxNph94iwy9gEWJKDNPi7jgxRJ4WW7TB/Cfz+bZzkEBNLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558428; c=relaxed/simple;
	bh=eWtrXzMhJKS5xOWZigySRTMy/cUMuJ5/xx/SVnO/CfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0Qoa9ApD2K0/TPfJVxOfWe9dfpsc1y7Yjia4Kjp2AXOoTvdzHbCxOVuzb21M1QUgDn9J84tjQbdH5fAyoKknbLRP3QD7yPlbpoW4WbaysaMj3asHx+v3eiwr70jkB12h2bMAze7HNx2jRU+eVBVpC/f6l1wGzP3Ljii5lodN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deSS6dQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F278BC4AF09;
	Tue, 13 Aug 2024 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558428;
	bh=eWtrXzMhJKS5xOWZigySRTMy/cUMuJ5/xx/SVnO/CfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deSS6dQWX6MhyUkHKOW35OnUJXdbXGhjTAED2iUx20cNK7aJallgy3rIyQ1jlXP23
	 o58u1wZSlop3de6DqDEwwyRCEY9DF85+1eNYjfKxMNLXfXvfLhAFNDW6KnvbZa6Ss5
	 RxtFQfYz2MCMpny54vB2qv81YayXky0y9l0rIsT6zQbLnzj32w0uf3+IRYPFJI7gN/
	 aWmhxuwul5XvIW5LukXURj9dqVIy9fJ0iNNJwzLZPjYVrDuTdCAM8eymv1NbfoJzzw
	 z7haXumUHWmdZTrXHy8lDCs95z/GBNzJUn4ROcm5UFNIR/lnFGWTpZXTym3tPNEM+9
	 m49vf8yl4rPpg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/9] f2fs: convert f2fs_clear_page_cache_dirty_tag() to use folio
Date: Tue, 13 Aug 2024 22:13:25 +0800
Message-Id: <20240813141331.417067-3-chao@kernel.org>
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
 fs/f2fs/data.c   | 3 +--
 fs/f2fs/dir.c    | 2 +-
 fs/f2fs/f2fs.h   | 2 +-
 fs/f2fs/inline.c | 2 +-
 fs/f2fs/node.c   | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 100b6526717f..0df5a0c66ede 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4117,9 +4117,8 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.swap_deactivate = f2fs_swap_deactivate,
 };
 
-void f2fs_clear_page_cache_dirty_tag(struct page *page)
+void f2fs_clear_page_cache_dirty_tag(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct address_space *mapping = folio->mapping;
 	unsigned long flags;
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 14900ca8a9ff..5fcc952107e9 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -868,7 +868,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
-		f2fs_clear_page_cache_dirty_tag(page);
+		f2fs_clear_page_cache_dirty_tag(page_folio(page));
 		clear_page_dirty_for_io(page);
 		ClearPageUptodate(page);
 		clear_page_private_all(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index df436dd3aac1..a4b90215a51f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3890,7 +3890,7 @@ void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
 bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
-void f2fs_clear_page_cache_dirty_tag(struct page *page);
+void f2fs_clear_page_cache_dirty_tag(struct folio *folio);
 int f2fs_init_post_read_processing(void);
 void f2fs_destroy_post_read_processing(void);
 int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d76a3bed7093..98d122164cd1 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -281,7 +281,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 			 page, 0, MAX_INLINE_DATA(inode));
 	set_page_dirty(ipage);
 
-	f2fs_clear_page_cache_dirty_tag(page);
+	f2fs_clear_page_cache_dirty_tag(page_folio(page));
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9e7a6e21f30c..20518c12f5b7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -123,7 +123,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 static void clear_node_page_dirty(struct page *page)
 {
 	if (PageDirty(page)) {
-		f2fs_clear_page_cache_dirty_tag(page);
+		f2fs_clear_page_cache_dirty_tag(page_folio(page));
 		clear_page_dirty_for_io(page);
 		dec_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 	}
-- 
2.40.1


