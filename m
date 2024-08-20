Return-Path: <linux-kernel+bounces-293170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B49957B91
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4701F1C23AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6242A4778E;
	Tue, 20 Aug 2024 02:43:22 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436440870
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121802; cv=none; b=QNlmHyqQM+4Bl/6sqHxKWNZAsUgCX4oxfj7wlWH2FzrS5gYArRuFcz7SheUgbRHL1/j+Jm2ktXpLFsox2ELCevGoz3E83Hk0qIt6zvMTfLZnFTJICXLZ6Mg3h6T70Oxez1L7Bb8l0z2bSKJAwbh9m6bIPx90UWH05l8fGElYLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121802; c=relaxed/simple;
	bh=8n4o0+56IFg9fO5C9iI20K4tYl7J0cGKQmS4e9dZgZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqMNXGdbhOzqnqLaRICimHgatiVxvWsaC2T/F3ka5F+LF8PLF3fuMKicAtFpH4NPLxQ4Gnh76BQeXprMC4x8msawO68SdHBXwRkxx7YrjInLuTOpJ33LmUnK1QL7jN2n8ujfbOfACbMJyjv0nwFnkFhZUFkFD2JI2dc8zajzWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WntyD1xccz1xvSl;
	Tue, 20 Aug 2024 10:41:24 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 33DCA1402CD;
	Tue, 20 Aug 2024 10:43:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 10:43:17 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>
CC: <lizetao1@huawei.com>, <linux-um@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
Date: Tue, 20 Aug 2024 10:50:45 +0800
Message-ID: <20240820025045.13339-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)

convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1]: https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6d1cf2436ead..e17e70f20fa1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -411,18 +411,19 @@ static const struct file_operations hostfs_dir_fops = {
 
 static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	struct address_space *mapping = page->mapping;
-	struct inode *inode = mapping->host;
+	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio->mapping;
+	struct inode *inode = folio_inode(folio);
 	char *buffer;
-	loff_t base = page_offset(page);
+	loff_t base = folio_pos(folio);
 	int count = PAGE_SIZE;
 	int end_index = inode->i_size >> PAGE_SHIFT;
 	int err;
 
-	if (page->index >= end_index)
+	if (folio->index >= end_index)
 		count = inode->i_size & (PAGE_SIZE-1);
 
-	buffer = kmap_local_page(page);
+	buffer = kmap_local_folio(folio, 0);
 
 	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
 	if (err != count) {
@@ -439,7 +440,7 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 
  out:
 	kunmap_local(buffer);
-	unlock_page(page);
+	folio_unlock(folio);
 
 	return err;
 }
-- 
2.34.1


