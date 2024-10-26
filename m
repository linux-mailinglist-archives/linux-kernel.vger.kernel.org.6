Return-Path: <linux-kernel+bounces-383211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD09B1882
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E210E1C212B4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C687B67E;
	Sat, 26 Oct 2024 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wo4Yz7Or"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD1217F47
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729950733; cv=none; b=nZ0pyjCTHpBLffehTLafgKU5nHGL0DdhsUcTlHRDWQem5m2u1NZj0NixH72WiJLtxhk52Ar71OEsaNMLSWAlK1UzTvLSxARzj+FcyhmnMdTJ3RE34k+yuAdJNQwJzVBCpCG53Je9N5+En5O73BuMJofyf36pEF2iKyzm4eGUfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729950733; c=relaxed/simple;
	bh=sp5pw2pfpJB1jUStzF9aKS9eRk6a3beLKNZ79tlo8D4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTE+nRuU4pH8FgIcpsifKVeoDAKJGKlrnaZgvIZwBpLOT1rDYwPISlg1Cf8mtt5zG5D0g/Gx3K6AyJXj1tuRIcPYFeVF4VidJTUq5M4M0l07nXIiUpjQT9lwdF6504omfN/R1485/+kqomcQf2q+RAZNrWT+ft769HF3lV8YWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wo4Yz7Or; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729950722; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Yn7IMviIZnvK7YYzvaA/aGBlTXmKShv9ycQ4bY+Uv/g=;
	b=wo4Yz7Or6GVB0mUxk/iRP2n3XL2h8TLUvY5IJ6HDmxr86SxxfOT8ogyxs19X9OAuxmrZsQVp2nvie1PYVjSM71bV+Dz9Hy6LOeC6MqfzeaWBUerk/myEYTdMb7uroBuTWFPPeh1gj8tolULOUQo95neCd3n/J1zEV5msygO7ONU=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHvS07n_1729950721 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 21:52:02 +0800
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
Subject: [PATCH v2] mm: shmem: fallback to page size splice if large folio has poisoned pages
Date: Sat, 26 Oct 2024 21:51:52 +0800
Message-Id: <e3737fbd5366c4de4337bf5f2044817e77a5235b.1729915173.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tmpfs has already supported the PMD-sized large folios, and splice()
can not read any pages if the large folio has a poisoned page, which is
not good as Matthew pointed out in a previous email[1]:
"
so if we have hwpoison set on one page in a folio, we now can't read
bytes from any page in the folio?  That seems like we've made a bad
situation worse.
"

Thus adding a fallback to the PAGE_SIZE splice() still allows reading
normal pages if the large folio has hwpoisoned pages.

[1] https://lore.kernel.org/all/Zw_d0EVAJkpNJEbA@casper.infradead.org/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Use 'pages' instead of 'subpages' in the commit message, per Matthew.
 - Include the relevant information from previous discussion,
 per Andrew.
---
 mm/shmem.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1bef6e32a1fa..44282a296c33 100644
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
+		 * pages.
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


