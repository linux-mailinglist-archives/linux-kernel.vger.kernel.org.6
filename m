Return-Path: <linux-kernel+bounces-218701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D9890C414
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601361F24F55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FD7346A;
	Tue, 18 Jun 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jPV10q7o"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30411210F8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693674; cv=none; b=lU8mOrSIx1IpUaNA8ztfI7DTMMQhDowSHp2dwjhxG15dq3C/g8V2cj5NdjzGNKbyXtl3hHTEwpbkJo7Rye5Ef3eXAw9X5l+yVybXXkUWF060J0G6Mb6oKbUycndUw4mNo73HMgSILH8/WzG24hQyafayKRCBZ9Xc07fjYZvqGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693674; c=relaxed/simple;
	bh=89pIoAXavdFIN8K8yf6MCqWgIZXiI9HwlIwNMVvrXm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bkRAT9s1jvDsAU/vzVwVdHfsuZy8DdxxTv2ujZjh/Xx+pEP3OhBV7iNzSAWu3rZlsvjr9c5oDlFhXRlEbvkl8IRzP0aokoFu/cGbM9mzGOM3ki2hnVXLuPDGqXUqZsQ1S3mTsEUcIF3+v4R3yBjKMq+lNKbIzzXYql0mSrpIHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jPV10q7o; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693670; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yoIYIBJL5vLTtJOJekDK/vHyVKGOuJ66AVuG1N/Iti4=;
	b=jPV10q7olMSR8lQVPiAVl3vfo2TAPTkGrKgZXo3xtI56kZoEUXzLPXwZzQvh6nki6PLOEXw94WwZmqvUs/4USnES2yUHRFaJE4DD7xLqPz+v6F1kg7IKhG8NAfmRLKE1qRS4XxzEby7hfRHnSm2LBa+0ZDgXtbcn7yD9ShaN4+A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8jKUXF_1718693668;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8jKUXF_1718693668)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:54:28 +0800
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
Subject: [PATCH v2 1/9] mm: vmscan: add validation before spliting shmem large folio
Date: Tue, 18 Jun 2024 14:54:13 +0800
Message-Id: <413866f2f2d996cfbb5c906467b36c96b1a82e2d.1718690645.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add swap available space validation before spliting shmem large folio to
avoid redundant split, since we can not write shmem folio to the swap device
in this case.

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


