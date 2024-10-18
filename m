Return-Path: <linux-kernel+bounces-370876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3FF9A3321
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3382834C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806A168C3F;
	Fri, 18 Oct 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e3T2xx1h"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A51607A4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220448; cv=none; b=ibC96x6Z4Z9NtbqP/ArJ6vajbhtNXIIrEyiEGljtz70mDwGET4mDGidgFCFXmBu/woboPC3xsde5VhyUjAJjOJroTud4TwjpvjDVveseSNgPyoQ809KOh+6wdMzfq7IaXz+CiI9tankT6FUa3aNJqHXtJ10yLdQkfIew0mMeO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220448; c=relaxed/simple;
	bh=Y3c1W9Gibs9aUiNJwJ9qhHit2umjgziyg8++LNN6140=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRWhASv4lNwRPWCgWiCtnBShZWP7mG5dmHM8UzK9TnsteaPz5EtfCXXtSERvKXxMETyBYOK+uRdA5kR7QLabD3uwH/ffhJEz0mFSiqXOBH8w7RgrxpWDvNDFT4vQn6Cpv7S/8GL9GFharAX+jy0emhUeKMZy0hoSJUGnYQ6iuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e3T2xx1h; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729220437; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZL+DuJ+RP/aBC8VbvHjJ2i2qhBXaPyZwPwmHC2i5Ozk=;
	b=e3T2xx1hFmunyeuiIHLvsNZipxS3GpW7M+65XqNmcSNxcNmN4ib6zKrDOP/zVC/cM7vOctKe2N0eu/GHozWprOPyScw3necBXGl3rhbrqLe6FVndSymYpWJMprRyrs7jIE3K5WPPlDIgnB4I6QtnTKyFbT9KrPWboNIBdfdRG9M=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHMdEgo_1729220436 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 11:00:36 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	shy828301@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: shmem: improve the tmpfs large folio read performance
Date: Fri, 18 Oct 2024 11:00:28 +0800
Message-Id: <2129a21a5b9f77d3bb7ddec152c009ce7c5653c4.1729218573.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1729218573.git.baolin.wang@linux.alibaba.com>
References: <cover.1729218573.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tmpfs has already supported the PMD-sized large folios, but the tmpfs
read operation still performs copying at the PAGE SIZE granularity, which
is unreasonable. This patch changes to copy data at the folio granularity,
which can improve the read performance, as well as changing to use folio
related functions.

Moreoever, if a large folio has a subpage that is hwpoisoned, it will still
fallback to page granularity copying.

Use 'fio bs=64k' to read a 1G tmpfs file populated with 2M THPs, and I can
see about 20% performance improvement, and no regression with bs=4k.
Before the patch:
READ: bw=10.0GiB/s

After the patch:
READ: bw=12.0GiB/s

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 93642aa8d1aa..cbefd9801f6b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3107,13 +3107,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	int error = 0;
 	ssize_t retval = 0;
 
-	offset = iocb->ki_pos & ~PAGE_MASK;
-
 	for (;;) {
 		struct folio *folio = NULL;
 		struct page *page = NULL;
 		unsigned long nr, ret;
 		loff_t end_offset, i_size = i_size_read(inode);
+		bool fallback_page_copy = false;
+		size_t fsize;
 
 		if (unlikely(iocb->ki_pos >= i_size))
 			break;
@@ -3134,6 +3134,10 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				error = -EIO;
 				break;
 			}
+
+			if (folio_test_large(folio) &&
+			    folio_test_has_hwpoisoned(folio))
+				fallback_page_copy = true;
 		}
 
 		/*
@@ -3147,7 +3151,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		}
 		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
-		nr = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
+		if (folio && likely(!fallback_page_copy))
+			fsize = folio_size(folio);
+		else
+			fsize = PAGE_SIZE;
+		offset = iocb->ki_pos & (fsize - 1);
+		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
 
 		if (folio) {
 			/*
@@ -3155,10 +3164,15 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 * virtual addresses, take care about potential aliasing
 			 * before reading the page on the kernel side.
 			 */
-			if (mapping_writably_mapped(mapping))
-				flush_dcache_page(page);
+			if (mapping_writably_mapped(mapping)) {
+				if (likely(!fallback_page_copy))
+					flush_dcache_folio(folio);
+				else
+					flush_dcache_page(page);
+			}
+
 			/*
-			 * Mark the page accessed if we read the beginning.
+			 * Mark the folio accessed if we read the beginning.
 			 */
 			if (!offset)
 				folio_mark_accessed(folio);
@@ -3166,9 +3180,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 * Ok, we have the page, and it's up-to-date, so
 			 * now we can copy it to user space...
 			 */
-			ret = copy_page_to_iter(page, offset, nr, to);
+			if (likely(!fallback_page_copy))
+				ret = copy_folio_to_iter(folio, offset, nr, to);
+			else
+				ret = copy_page_to_iter(page, offset, nr, to);
 			folio_put(folio);
-
 		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
@@ -3186,8 +3202,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 
 		retval += ret;
-		offset += ret;
-		offset &= ~PAGE_MASK;
 		iocb->ki_pos += ret;
 
 		if (!iov_iter_count(to))
-- 
2.39.3


