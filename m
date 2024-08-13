Return-Path: <linux-kernel+bounces-284954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA17950750
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8895A1F224B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45B19DF5B;
	Tue, 13 Aug 2024 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJR5h6nf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEA19DF46
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558431; cv=none; b=EH99SfZTnvXXqn04uqyvc/osdmtRl9pOj3/sphHjX8H2QTXdVQlSeMUcu2AKC5ORpCwsWCArJp2VovC4gHu/vW+w1wLyGdanJy2fFStCRhT8HroNzwnbIOtnuV3Our+2TXhoiSg89PrlqIRK//TwGx+r/20aWhKfu3epc5nwyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558431; c=relaxed/simple;
	bh=ceJAsQVNvPZUvEVH90Lwtfbz3Ha3JuH6fkV/BpfNMgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6ArCOAEI47xrmujvP9GSgpMwXdilVFgaYS9b6AJLKBnwmvNlDzdunwLqeA1smrC/dSJO7P1viVTYKH/FkS4cxEDsXgvCa9vT7cddXi7+cFAuj1waEJTzPjGCbmoVV+FE6LWMzN48ILDQA/Pwq1lWUR4eOtu/3XHseK1hKlI158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJR5h6nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC9CC4AF11;
	Tue, 13 Aug 2024 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558430;
	bh=ceJAsQVNvPZUvEVH90Lwtfbz3Ha3JuH6fkV/BpfNMgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJR5h6nfLGvDN1tZY8B6tCGJErI5wYrupexx86bDUR8ZZHF8uZMGcphc6Zx+caNhZ
	 DrbS/FicXfh88Q20S4VUlUtCar05NhDlieMIS29787iWRjGwOYby6pamMfP0wkw0HZ
	 pQp4ZSo4Fen2MQNQKjKJrr6rDdx4wjoLpCWmsrX9dTV+wQQBOtQ6xLo6FrY2Awb3k4
	 hNcABuWiQCJxOO53ORBjVtZ56ffg/X6a2XYmKuOUrpBydDcY9iHgRRVSB257K3gO6f
	 R3JV1+fOfwZz9f77Gw9b7J3Y5nIyp9u4cGHMyLobvT9YrItmYnqwz/r4dHHvmyasDO
	 piGcoJYEvKSXA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4/9] f2fs: convert f2fs_write_inline_data() to use folio
Date: Tue, 13 Aug 2024 22:13:26 +0800
Message-Id: <20240813141331.417067-4-chao@kernel.org>
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
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   |  2 +-
 fs/f2fs/inline.c | 10 +++++-----
 fs/f2fs/node.c   |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0df5a0c66ede..6d2a37db0c9e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2866,7 +2866,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	err = -EAGAIN;
 	if (f2fs_has_inline_data(inode)) {
-		err = f2fs_write_inline_data(inode, page);
+		err = f2fs_write_inline_data(inode, folio);
 		if (!err)
 			goto out;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a4b90215a51f..7c7760aa1a7c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4185,7 +4185,7 @@ int f2fs_read_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
 int f2fs_convert_inline_inode(struct inode *inode);
 int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry);
-int f2fs_write_inline_data(struct inode *inode, struct page *page);
+int f2fs_write_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 98d122164cd1..005babf1bed1 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -260,7 +260,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	return err;
 }
 
-int f2fs_write_inline_data(struct inode *inode, struct page *page)
+int f2fs_write_inline_data(struct inode *inode, struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *ipage;
@@ -274,14 +274,14 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 		return -EAGAIN;
 	}
 
-	f2fs_bug_on(F2FS_I_SB(inode), page->index);
+	f2fs_bug_on(F2FS_I_SB(inode), folio->index);
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
-	memcpy_from_page(inline_data_addr(inode, ipage),
-			 page, 0, MAX_INLINE_DATA(inode));
+	memcpy_from_folio(inline_data_addr(inode, ipage),
+			 folio, 0, MAX_INLINE_DATA(inode));
 	set_page_dirty(ipage);
 
-	f2fs_clear_page_cache_dirty_tag(page_folio(page));
+	f2fs_clear_page_cache_dirty_tag(folio);
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 20518c12f5b7..2b764c86aacc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1535,7 +1535,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	if (!clear_page_dirty_for_io(page))
 		goto page_out;
 
-	ret = f2fs_write_inline_data(inode, page);
+	ret = f2fs_write_inline_data(inode, page_folio(page));
 	inode_dec_dirty_pages(inode);
 	f2fs_remove_dirty_inode(inode);
 	if (ret)
-- 
2.40.1


