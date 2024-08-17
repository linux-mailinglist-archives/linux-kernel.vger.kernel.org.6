Return-Path: <linux-kernel+bounces-290665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E37955715
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A12DB2143E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98096149018;
	Sat, 17 Aug 2024 10:04:41 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244F13E043
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889081; cv=none; b=FH4tyWzsQnht71qhi9vXu3xUe1rELshJ31+IkEXdF+U3HCM3fo3Rm/yfMBAgEaweJHGQj4k4+pxojYArsTOuZoGP+/l7Y+R4v35jCo/nb5H56KUioWzshZWFMkoUHO1+OrvfcAmfVKROFg/yND2CA+i0vF9vQIjF5dR5F7VuRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889081; c=relaxed/simple;
	bh=x7tWsshP4WAibYs0KjYaRTg4X1ZHJ01iV2v7b5ss/nc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+zAyDg2SSvuip910u8kdl/izw1XVg/Kly99wUWIR2GBqDSRKVuZIksCgA17zqc/aGPRmG89+/ZltH5XikJYGicwLnucw+UzdpvNAH8yy5yjGnzLkchg1MsWKdMomV1v5JNZq1S8pmIC815agv5I48OHLRMjDR1aPJSXlx4y2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WmDqH3RzZz2CmjH;
	Sat, 17 Aug 2024 17:59:39 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BC2D140154;
	Sat, 17 Aug 2024 18:04:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 17 Aug
 2024 18:04:34 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <phillip@squashfs.org.uk>, <willy@infradead.org>
CC: <lizetao1@huawei.com>, <squashfs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/2] squashfs: convert squashfs_read_folio to use folio APIs
Date: Sat, 17 Aug 2024 18:11:46 +0800
Message-ID: <20240817101146.2347378-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240817101146.2347378-1-lizetao1@huawei.com>
References: <20240817101146.2347378-1-lizetao1@huawei.com>
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

In order to remote page APIs and index field in structure page [1],
this patch convert squashfs_read_folio to use folio APIs, switch from
kmap_atomic to kmap_local and use folio_end_read() to set uptodate
and unlock folio.

[1]: https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/squashfs/file.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 893043ecf973..8c80d77a6115 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -446,10 +446,9 @@ static int squashfs_readpage_sparse(struct page *page, int expected)
 
 static int squashfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio_inode(folio);
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	int index = page->index >> (msblk->block_log - PAGE_SHIFT);
+	int index = folio->index >> (msblk->block_log - PAGE_SHIFT);
 	int file_end = i_size_read(inode) >> msblk->block_log;
 	int expected = index == file_end ?
 			(i_size_read(inode) & (msblk->block_size - 1)) :
@@ -457,10 +456,10 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	int res = 0;
 	void *pageaddr;
 
-	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
-				page->index, squashfs_i(inode)->start);
+	TRACE("Entered squashfs_readpage, folio index %lx, start block %llx\n",
+				folio->index, squashfs_i(inode)->start);
 
-	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
+	if (folio->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
 					PAGE_SHIFT))
 		goto out;
 
@@ -473,23 +472,21 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 			goto out;
 
 		if (res == 0)
-			res = squashfs_readpage_sparse(page, expected);
+			res = squashfs_readpage_sparse(&folio->page, expected);
 		else
-			res = squashfs_readpage_block(page, block, res, expected);
+			res = squashfs_readpage_block(&folio->page, block, res, expected);
 	} else
-		res = squashfs_readpage_fragment(page, expected);
+		res = squashfs_readpage_fragment(&folio->page, expected);
 
 	if (!res)
 		return 0;
 
 out:
-	pageaddr = kmap_atomic(page);
+	pageaddr = kmap_local_folio(folio, 0);
 	memset(pageaddr, 0, PAGE_SIZE);
-	kunmap_atomic(pageaddr);
-	flush_dcache_page(page);
-	if (res == 0)
-		SetPageUptodate(page);
-	unlock_page(page);
+	kunmap_local(pageaddr);
+	flush_dcache_folio(folio);
+	folio_end_read(folio, res == 0);
 
 	return res;
 }
-- 
2.34.1


