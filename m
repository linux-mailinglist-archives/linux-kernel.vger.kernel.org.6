Return-Path: <linux-kernel+bounces-367779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A789A06B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60246B27C13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52606206979;
	Wed, 16 Oct 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YY2Ix3PU"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF42206050
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073392; cv=none; b=V8ZpvmcLeL+A+CrJ3qJx1PAXvpBgrEITgvhiZU+8G8qVhcnbZsWVY6/EeoYV6r75SQAPHhg5heQLOvj14dK+KLevlbJ8W14PONMSF1G6y0BfHsbgbfBMYmfgtKfMv0su6Id22au51XPVTAHIZllmxJ6xlQN5VRD7mEw6756Fpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073392; c=relaxed/simple;
	bh=fh0I9f+0oKK5Ggx4os5HyBVZw9i+Uu8lG+fr8jbL7NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtqeGIHUqQ/kPb1iK11REUYEd7ZD9q9E6uy/06/Asz7akp7ql441Dajf2krH1WY72230+srN7IQDHodfimv4nEOBnrOb+gHn59sKQy/Jcn71XEjph2q3dFTKQZctuljBJIr47w+oeXYEefqUWYwkms8Z2Zpldry0VHh4Muo+tdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YY2Ix3PU; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729073380; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wkcQzqhjpS9uwSQXB5+PPSGfoLQjvCtl7yMPRr0AdnM=;
	b=YY2Ix3PUdGK6OeQxRCOkBAMpgCskzZFO1TJRWbWEiAUtdENrL9EcF9Zc7ZIIZtA5FLDkHVjx2D5jkfcVy1KBJEuKbuMtPXzz6D1KtQHXzGodk4X4aoS/lKray8HJ8IQ+/pOJBcWbc7RngHgjePiRudoKMad4oxxB5cTwMuGKYV0=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHGye6P_1729073379 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 18:09:40 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: shmem: improve the tmpfs large folio read performance
Date: Wed, 16 Oct 2024 18:09:30 +0800
Message-Id: <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
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

Use 'fio bs=64k' to read a 1G tmpfs file populated with 2M THPs, and I can
see about 20% performance improvement, and no regression with bs=4k.
Before the patch:
READ: bw=10.0GiB/s

After the patch:
READ: bw=12.0GiB/s

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index edab02a26aac..7e79b6a96da0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3108,13 +3108,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	ssize_t retval = 0;
 
 	index = iocb->ki_pos >> PAGE_SHIFT;
-	offset = iocb->ki_pos & ~PAGE_MASK;
 
 	for (;;) {
 		struct folio *folio = NULL;
-		struct page *page = NULL;
 		unsigned long nr, ret;
 		loff_t end_offset, i_size = i_size_read(inode);
+		size_t fsize;
 
 		if (unlikely(iocb->ki_pos >= i_size))
 			break;
@@ -3128,8 +3127,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (folio) {
 			folio_unlock(folio);
 
-			page = folio_file_page(folio, index);
-			if (PageHWPoison(page)) {
+			if (folio_test_hwpoison(folio) ||
+			    (folio_test_large(folio) &&
+			     folio_test_has_hwpoisoned(folio))) {
 				folio_put(folio);
 				error = -EIO;
 				break;
@@ -3147,7 +3147,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		}
 		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
-		nr = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
+		if (folio)
+			fsize = folio_size(folio);
+		else
+			fsize = PAGE_SIZE;
+		offset = iocb->ki_pos & (fsize - 1);
+		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
 
 		if (folio) {
 			/*
@@ -3156,7 +3161,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 * before reading the page on the kernel side.
 			 */
 			if (mapping_writably_mapped(mapping))
-				flush_dcache_page(page);
+				flush_dcache_folio(folio);
 			/*
 			 * Mark the page accessed if we read the beginning.
 			 */
@@ -3166,9 +3171,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 * Ok, we have the page, and it's up-to-date, so
 			 * now we can copy it to user space...
 			 */
-			ret = copy_page_to_iter(page, offset, nr, to);
+			ret = copy_folio_to_iter(folio, offset, nr, to);
 			folio_put(folio);
-
 		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
@@ -3186,8 +3190,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 
 		retval += ret;
-		offset += ret;
-		offset &= ~PAGE_MASK;
 		iocb->ki_pos += ret;
 		index = iocb->ki_pos >> PAGE_SHIFT;
 
-- 
2.39.3


