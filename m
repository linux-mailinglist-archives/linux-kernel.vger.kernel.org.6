Return-Path: <linux-kernel+bounces-370875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16D9A3320
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E8DB235A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2D16631C;
	Fri, 18 Oct 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pa7+cn4T"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489415DBB3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220447; cv=none; b=aPTM/y+RhXbNY0qp7LQz8x/yY5OlaQCRabyr4humOXIJAuEDvazom1GMNJT7HAeBcAmHVJjFP6Ij0C3BwBLrBLFqr/NmDUYbXf/CYLK0nS3At46ILoOEeGa8zl2kpWAV7A7MEksCqs3w/1Zu1dKA0JSXniebYGMAaNjWEGDWhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220447; c=relaxed/simple;
	bh=fGpK3d66SdoBUTnXPeubhKKC12+CIKZi3TlVUcLOx08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toFLw1xx8C3oUGyR2laiqpkY1kDudrXxbd8BuBXMJLvjFIcqcuxOBfpwdAUC9GMXOEA8N96ZwZ1PRHpzoGR99E7FRBZp5BS31KM/os+ODXIhJUrWuOtOQXtvMpOM3XZE/N5EZv2VlrWalRtSZG4ZmSEwaovhj9OxsglYVmsy0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pa7+cn4T; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729220436; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ynn20XvNY9Nu0PNOg+bwufz+Xr8j8cPFzYmz1b4byuY=;
	b=Pa7+cn4THX4U9JjAB2qOQuuQ1czUmA+Ra61mHIap4D/2PFN3RXuhE9lFQqQopafmCflDLDqY/rYZlax9sNIgsPmP6juDi5mHXNVSs9F4Ui0ArRaKO/5tCuLHK4R3WRFo++q1O5TVA1yWJzAIGmgwPbRnSu8DO92dxhtekUs41ew=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHMZWVd_1729220435 cluster:ay36)
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
Subject: [PATCH v2 1/2] mm: shmem: update iocb->ki_pos directly to simplify tmpfs read logic
Date: Fri, 18 Oct 2024 11:00:27 +0800
Message-Id: <e8863e289577e0dc1e365b5419bf2d1c9a24ae3d.1729218573.git.baolin.wang@linux.alibaba.com>
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

Use iocb->ki_pos to check if the read bytes exceeds the file size and to
calculate the bytes to be read can help simplify the code logic. Meanwhile,
this is also a preparation for improving tmpfs large folios read performace
in the following patch.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 66eae800ffab..93642aa8d1aa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3106,27 +3106,19 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	unsigned long offset;
 	int error = 0;
 	ssize_t retval = 0;
-	loff_t *ppos = &iocb->ki_pos;
 
-	index = *ppos >> PAGE_SHIFT;
-	offset = *ppos & ~PAGE_MASK;
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
 
+		index = iocb->ki_pos >> PAGE_SHIFT;
 		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
 		if (error) {
 			if (error == -EINVAL)
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
@@ -3199,8 +3187,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		retval += ret;
 		offset += ret;
-		index += offset >> PAGE_SHIFT;
 		offset &= ~PAGE_MASK;
+		iocb->ki_pos += ret;
 
 		if (!iov_iter_count(to))
 			break;
@@ -3211,7 +3199,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		cond_resched();
 	}
 
-	*ppos = ((loff_t) index << PAGE_SHIFT) + offset;
 	file_accessed(file);
 	return retval ? retval : error;
 }
-- 
2.39.3


