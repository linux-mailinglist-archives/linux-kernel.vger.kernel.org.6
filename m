Return-Path: <linux-kernel+bounces-290666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD5955716
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA70F2824F0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADFB1494CA;
	Sat, 17 Aug 2024 10:04:41 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A1145344
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889081; cv=none; b=uvrpbFX+arDhnzYuI73ec/025dSEe+60B0hIhpVh2zZw5ZaiflApLHJCpuxAoiEa48KOdQZbFr1o0tU2etSS9x+xmi+RAOUSh8sLOCBu/urBXdlOGGbLNTvaygFCsP8CCJcdjQvt4l8CkaGMHcJ1n4Iq1+U/nKjIhesVNuUbVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889081; c=relaxed/simple;
	bh=eH5I0H27uYtfQy7MRD4Ssl9kVJuBsJcLJZtZLbAznAw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvTpXpY+7tJrXgQm715R1r7oJc3HY0DBHZI4gJthebGAXmGnVEEwBQ5E+P2kB0QD9IpdQIh54AYocyF6CEwUTOwbFuOBUvZ8V4eBVCDpJayjrSkgatIAmfxdBjgpQs1WY+3j1qa3dyKlb9hC285KdOX93tvWGQrCPqF7pK1jg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WmDqd5925z20lsM;
	Sat, 17 Aug 2024 17:59:57 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id EE583180043;
	Sat, 17 Aug 2024 18:04:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 17 Aug
 2024 18:04:34 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <phillip@squashfs.org.uk>, <willy@infradead.org>
CC: <lizetao1@huawei.com>, <squashfs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/2] squashfs: convert squashfs_copy_cache() to use folio
Date: Sat, 17 Aug 2024 18:11:45 +0800
Message-ID: <20240817101146.2347378-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1]: https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/squashfs/file.c       | 31 ++++++++++++++++---------------
 fs/squashfs/file_cache.c |  2 +-
 fs/squashfs/squashfs.h   |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8c1e7f9a609..893043ecf973 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -378,13 +378,13 @@ void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer,
 }
 
 /* Copy data into page cache  */
-void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
+void squashfs_copy_cache(struct folio *folio, struct squashfs_cache_entry *buffer,
 	int bytes, int offset)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio_inode(folio);
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	int i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int start_index = page->index & ~mask, end_index = start_index | mask;
+	int start_index = folio->index & ~mask, end_index = start_index | mask;
 
 	/*
 	 * Loop copying datablock into pages.  As the datablock likely covers
@@ -394,25 +394,26 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
 	 */
 	for (i = start_index; i <= end_index && bytes > 0; i++,
 			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
-		struct page *push_page;
+		struct folio *push_folio;
 		int avail = buffer ? min_t(int, bytes, PAGE_SIZE) : 0;
 
 		TRACE("bytes %d, i %d, available_bytes %d\n", bytes, i, avail);
 
-		push_page = (i == page->index) ? page :
-			grab_cache_page_nowait(page->mapping, i);
-
-		if (!push_page)
+		push_folio = (i == folio->index) ? folio :
+			__filemap_get_folio(folio->mapping, i,
+					    FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
+					    mapping_gfp_mask(folio->mapping));
+		if (IS_ERR(push_folio))
 			continue;
 
-		if (PageUptodate(push_page))
+		if (folio_test_uptodate(push_folio))
 			goto skip_page;
 
-		squashfs_fill_page(push_page, buffer, offset, avail);
+		squashfs_fill_page(folio_file_page(push_folio, i), buffer, offset, avail);
 skip_page:
-		unlock_page(push_page);
-		if (i != page->index)
-			put_page(push_page);
+		folio_unlock(push_folio);
+		if (i != folio->index)
+			folio_put(push_folio);
 	}
 }
 
@@ -430,7 +431,7 @@ static int squashfs_readpage_fragment(struct page *page, int expected)
 			squashfs_i(inode)->fragment_block,
 			squashfs_i(inode)->fragment_size);
 	else
-		squashfs_copy_cache(page, buffer, expected,
+		squashfs_copy_cache(page_folio(page), buffer, expected,
 			squashfs_i(inode)->fragment_offset);
 
 	squashfs_cache_put(buffer);
@@ -439,7 +440,7 @@ static int squashfs_readpage_fragment(struct page *page, int expected)
 
 static int squashfs_readpage_sparse(struct page *page, int expected)
 {
-	squashfs_copy_cache(page, NULL, expected, 0);
+	squashfs_copy_cache(page_folio(page), NULL, expected, 0);
 	return 0;
 }
 
diff --git a/fs/squashfs/file_cache.c b/fs/squashfs/file_cache.c
index 54c17b7c85fd..23d585025882 100644
--- a/fs/squashfs/file_cache.c
+++ b/fs/squashfs/file_cache.c
@@ -29,7 +29,7 @@ int squashfs_readpage_block(struct page *page, u64 block, int bsize, int expecte
 		ERROR("Unable to read page, block %llx, size %x\n", block,
 			bsize);
 	else
-		squashfs_copy_cache(page, buffer, expected, 0);
+		squashfs_copy_cache(page_folio(page), buffer, expected, 0);
 
 	squashfs_cache_put(buffer);
 	return res;
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 5a756e6790b5..a31bd5e9c8bf 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -68,7 +68,7 @@ extern __le64 *squashfs_read_fragment_index_table(struct super_block *,
 
 /* file.c */
 void squashfs_fill_page(struct page *, struct squashfs_cache_entry *, int, int);
-void squashfs_copy_cache(struct page *, struct squashfs_cache_entry *, int,
+void squashfs_copy_cache(struct folio *, struct squashfs_cache_entry *, int,
 				int);
 
 /* file_xxx.c */
-- 
2.34.1


