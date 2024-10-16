Return-Path: <linux-kernel+bounces-367778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E29A06B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674921F26100
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353520694A;
	Wed, 16 Oct 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RtkwtDPA"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6F1FAF17
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073391; cv=none; b=Z8Pw69rHlVk6ZTfOCmbiCj48EaWdw8Td7zeYBGWGWLNyF5wK8Q2dKd7wUhEuxFYKmyJE01ni/BTccZG3f19dOO3vRd7xrSgLNIHTNstD587pbbsWMI1IR+b9rv0FqBzZlZ0vM8eW9DR6NmpWqsnHz8IlghV5/pZgAwHohw09gYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073391; c=relaxed/simple;
	bh=G4q1nSaHcdhW8W+lBVsXIlaXABlbvqzyjc6WgN4XtXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mu/TJ2JW4k0Gpbi4qRe7zstAyc/MoA1c9tBZuP7KO1aA7R8nlPmG/XVAOuyIE2y1gNDi8mGHPvVMNW8yV6vHDBQiWfWu244yhecPIHD2zU/m0S8AH8uyzI7ieizywWfzAT6wE4/gNaROCLNaRWhiSHvqlODRBw6HLXe5IQFaV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RtkwtDPA; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729073379; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=45jXNMOMveZfimQ7xMKpnxhxl+Z6GR9GWhFQh6xPUvM=;
	b=RtkwtDPA5zNK7X9fng3o5Z0AbVRyNRYkIWBdIP27cDWFoo9q5cVei7/drfUUt7542fOUa+QVg9eRX6nE86wFLJnEhmiq0Tw2/TmW2mvLzhA9S1cpzMnS8kbyPoU8k0NlpzXwIHodBX8300kPAYoS+Zp5+6Eq6U5HtfxFsJpFOgA=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHH-UDB_1729073378 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 18:09:39 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: shmem: update iocb->ki_pos directly to simplify tmpfs read logic
Date: Wed, 16 Oct 2024 18:09:29 +0800
Message-Id: <c390879ab020c44be25de8a07e3f1f87402350e0.1729072803.git.baolin.wang@linux.alibaba.com>
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

Use iocb->ki_pos to check if the read bytes exceeds the file size and to
calculate the bytes to be read can help simplify the code logic. Meanwhile,
this is also a preparation for improving tmpfs large folios read performace
in the following patch.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 66eae800ffab..edab02a26aac 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3106,26 +3106,18 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	unsigned long offset;
 	int error = 0;
 	ssize_t retval = 0;
-	loff_t *ppos = &iocb->ki_pos;
 
-	index = *ppos >> PAGE_SHIFT;
-	offset = *ppos & ~PAGE_MASK;
+	index = iocb->ki_pos >> PAGE_SHIFT;
+	offset = iocb->ki_pos & ~PAGE_MASK;
 
 	for (;;) {
 		struct folio *folio = NULL;
 		struct page *page = NULL;
-		pgoff_t end_index;
 		unsigned long nr, ret;
-		loff_t i_size = i_size_read(inode);
+		loff_t end_offset, i_size = i_size_read(inode);
 
-		end_index = i_size >> PAGE_SHIFT;
-		if (index > end_index)
+		if (unlikely(iocb->ki_pos >= i_size))
 			break;
-		if (index == end_index) {
-			nr = i_size & ~PAGE_MASK;
-			if (nr <= offset)
-				break;
-		}
 
 		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
 		if (error) {
@@ -3148,18 +3140,14 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		 * We must evaluate after, since reads (unlike writes)
 		 * are called without i_rwsem protection against truncate
 		 */
-		nr = PAGE_SIZE;
 		i_size = i_size_read(inode);
-		end_index = i_size >> PAGE_SHIFT;
-		if (index == end_index) {
-			nr = i_size & ~PAGE_MASK;
-			if (nr <= offset) {
-				if (folio)
-					folio_put(folio);
-				break;
-			}
+		if (unlikely(iocb->ki_pos >= i_size)) {
+			if (folio)
+				folio_put(folio);
+			break;
 		}
-		nr -= offset;
+		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
+		nr = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
 
 		if (folio) {
 			/*
@@ -3199,8 +3187,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		retval += ret;
 		offset += ret;
-		index += offset >> PAGE_SHIFT;
 		offset &= ~PAGE_MASK;
+		iocb->ki_pos += ret;
+		index = iocb->ki_pos >> PAGE_SHIFT;
 
 		if (!iov_iter_count(to))
 			break;
@@ -3211,7 +3200,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		cond_resched();
 	}
 
-	*ppos = ((loff_t) index << PAGE_SHIFT) + offset;
 	file_accessed(file);
 	return retval ? retval : error;
 }
-- 
2.39.3


