Return-Path: <linux-kernel+bounces-240957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5692750E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF491F2395E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339B1AD3E8;
	Thu,  4 Jul 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CCjZi0lw"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63D1AC431
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092320; cv=none; b=NCpBlIZbglRlxFlk1zR9jTBpShtZGrQqwEz9D+OuovnHaAnxQZYfcPn9NCD7Dpp7cVNiwfganeVC0Rc7+Ef3YXlhBStGYJxpMyMLHS5+BUUdzZ6lPPZpt3RtwwV3oZRWi2enTZ0ySTKaKs6lpWqD1hRQIEKPXLOpOlMsMR1gMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092320; c=relaxed/simple;
	bh=0GBn0WLyFfTnZqZxayQz4y6BfCnwGmOo7URL0mMJmc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVImzuginn9FUTYfig30O6Bb8kdA2Hz7XNLx56fJQn8jNucAuk0xnrRXT2B9tr3EoH32P/iRKH81S0TRO2/+uj24xFi2TzYDu3OqMYbybCwoMhC5RKxDw3gt1GZXYN50RICQpWtH+eKexze3QkVceLAUlItcPam2rH9ILHzrMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CCjZi0lw; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092310; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gnvmYA2eSyc6bAhukdfnEGSceMWwrl4WSlzxAF32JnQ=;
	b=CCjZi0lwY1mBkJrU6DuNIHswHSZEFu4DHKb/DV0/RuSchNRaWG5l2SrRhysnnqxWYPd4dncEA/fbYd5qcnbjRiago2UKZoYWipTFV4OeDa4y6EnVVWrtad7gxEnbA9/erDJYqLcI6MDy3o2DxpJ22tpByE0k9vonKgDxZY1Ipno=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qjOw7_1720092308;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qjOw7_1720092308)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:08 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] mm: vmscan: add validation before spliting shmem large folio
Date: Thu,  4 Jul 2024 19:24:50 +0800
Message-Id: <cc77364eb03288e19b9e08a14d11431f5704ec2b.1720079976.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
References: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page reclaim will not scan anon LRU if no swap space, however MADV_PAGEOUT
can still split shmem large folios even without a swap device. Thus add
swap available space validation before spliting shmem large folio to
avoid redundant split.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1807e5d95dda..61465f92283f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1237,6 +1237,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			}
 		} else if (folio_test_swapbacked(folio) &&
 			   folio_test_large(folio)) {
+
+			/*
+			 * Do not split shmem folio if no swap memory
+			 * available.
+			 */
+			if (!total_swap_pages)
+				goto activate_locked;
+
 			/* Split shmem folio */
 			if (split_folio_to_list(folio, folio_list))
 				goto keep_locked;
-- 
2.39.3


