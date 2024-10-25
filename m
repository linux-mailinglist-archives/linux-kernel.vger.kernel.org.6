Return-Path: <linux-kernel+bounces-380945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A79AF823
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452B41F227B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79E18BC0A;
	Fri, 25 Oct 2024 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I7n2JLGL"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BE2BD19
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826826; cv=none; b=BlletIE1ZC7dJM9se/XSaLf3j2FUgotUMV6xQ8AkoP59O1j//iIV452DChuA2SRypR6gmfGYxGeXq7qe0v+7ZKW2al5FthWRuol2QcBtbc1X40lWjSS3bTJwz5lDK17RTgHQUfaTmNOnr0dkKraY1qY+yDANK8cyuxvY8hs875s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826826; c=relaxed/simple;
	bh=aAXXh2Xx+474WvW4l2OYHkEvEu0Eu2onK0IF96+ptTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dxp39mjYrBn8dDm6KCa9cp+oIJH5KSr3aVzSXxQWIlg7OsDKkAnyt0kdgE9tZwG++Hpwu8xIdQroY6FVRXP1ZPmc8B0DJu5QjGj+80S3nF2squ2KQ1/H5IrJq9XyxCRdE74fUwF+YmewrOhZsu00owfw3yS0YAJAEg6iN1rof20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I7n2JLGL; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729826814; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0nOXd776EWcCD5hlZ32PV6/J3I4PXz2ZWlCfAwu6rzQ=;
	b=I7n2JLGLzSRRV/aXVShnHpLydP2hocjpRZKmwjCdccMQUFMiWyeFvrkVREYcIPf8l+gjZ2MqUD47JeEpn0jVLBmz/DTAN9eA0ICzyId2pISJ3ja15YJEU+LSWgs2x3u9YKqI6cZdEpRD3vYU6gYMIyZE4daQWi4ikoRRq3qoz3k=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHqyxJi_1729826813 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 11:26:53 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	shy828301@gmail.com,
	dhowells@redhat.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shmem: fallback to page size splice if large folio has poisoned subpages
Date: Fri, 25 Oct 2024 11:26:39 +0800
Message-Id: <fd3893f318493a3720dc1a4b1c33f0f692ddf125.1729825743.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tmpfs has already supported the PMD-sized large folios, and splice()
can not read any subpages if the large folio has a poisoned subpage,
which is not good as we discussed in previous mail[1].

Thus adding a fallback to the PAGE_SIZE splice() still allows reading
normal subpages if the large folio has hwpoisoned subpages.

[1] https://lore.kernel.org/all/Zw_d0EVAJkpNJEbA@casper.infradead.org/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1bef6e32a1fa..79010e636056 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3291,11 +3291,16 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 	len = min_t(size_t, len, npages * PAGE_SIZE);
 
 	do {
+		bool fallback_page_splice = false;
+		struct page *page = NULL;
+		pgoff_t index;
+		size_t size;
+
 		if (*ppos >= i_size_read(inode))
 			break;
 
-		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, 0, &folio,
-					SGP_READ);
+		index = *ppos >> PAGE_SHIFT;
+		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
 		if (error) {
 			if (error == -EINVAL)
 				error = 0;
@@ -3304,12 +3309,15 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		if (folio) {
 			folio_unlock(folio);
 
-			if (folio_test_hwpoison(folio) ||
-			    (folio_test_large(folio) &&
-			     folio_test_has_hwpoisoned(folio))) {
+			page = folio_file_page(folio, index);
+			if (PageHWPoison(page)) {
 				error = -EIO;
 				break;
 			}
+
+			if (folio_test_large(folio) &&
+			    folio_test_has_hwpoisoned(folio))
+				fallback_page_splice = true;
 		}
 
 		/*
@@ -3323,7 +3331,18 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		isize = i_size_read(inode);
 		if (unlikely(*ppos >= isize))
 			break;
-		part = min_t(loff_t, isize - *ppos, len);
+		/*
+		 * Fallback to PAGE_SIZE splice if the large folio has hwpoisoned
+		 * subpages.
+		 */
+		if (likely(!fallback_page_splice)) {
+			size = len;
+		} else {
+			size_t offset = *ppos & ~PAGE_MASK;
+
+			size = min_t(loff_t, PAGE_SIZE - offset, len);
+		}
+		part = min_t(loff_t, isize - *ppos, size);
 
 		if (folio) {
 			/*
@@ -3331,8 +3350,12 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (mapping_writably_mapped(mapping))
-				flush_dcache_folio(folio);
+			if (mapping_writably_mapped(mapping)) {
+				if (likely(!fallback_page_splice))
+					flush_dcache_folio(folio);
+				else
+					flush_dcache_page(page);
+			}
 			folio_mark_accessed(folio);
 			/*
 			 * Ok, we have the page, and it's up-to-date, so we can
-- 
2.39.3


