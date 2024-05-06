Return-Path: <linux-kernel+bounces-169522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC08BC9EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C738B223F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0C1420A6;
	Mon,  6 May 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ARCWruIb"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB21422D9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985215; cv=none; b=k1LQ6eDrzPJP2oGH0OmoEQ819aSTwapD4BJI+LKTW9E6o2nyopqyianbEJwCDvYt+Hi/SFZ7WkSENRZshfwtvDXl88YnNHL7Y1NKpJyhB4Kp05rmLHQyJkwDdph1ZhciNDhymJMIl++XONWHOWBJKo3Jd4nCLhoRK9vgCQlY+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985215; c=relaxed/simple;
	bh=aXZ3X5BsKkhtjbzkDsuZ2qmB5MEnQRxlo7XdIgbTI/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8o3Zk4cxCPLbCJLthfYjO0Rxnmo2G2JMnnAH9uIZ4nH37Yt3Bwl7pD4wv7LeoBshoc+8d3aM7TU13vART7woMDopjYP1MeoOT/R4GPIubzcXGmuhx1yjgXnp0SYRfdJ6nIeOkY5izqeUgyM3AMlgEP9KT3nNoT7wQu1HkUkJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ARCWruIb; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714985211; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aUksnnssWSvRHZu6SVpR2z8swC3sgIQdPUjmp/ogrf0=;
	b=ARCWruIbNbLap1Zvf8QiIb609LrCzQXRyRWkpUh1wRWfe6eNKFHF7I4hUdge5LH0/NBbgnU9kBAD4jZD5wZIDY5kj4ILhW4W7Ulb57n2wbUgmEurGTeafF4yZijdSlIFQFiOJ7DWraO6pi1j/uUFZ4RET6HSbVY863X6a9AxtsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W5w3v7-_1714985207;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5w3v7-_1714985207)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 16:46:48 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] mm: shmem: add THP validation for PMD-mapped THP related statistics
Date: Mon,  6 May 2024 16:46:28 +0800
Message-Id: <be82070653c172ff77198c692d216aba0f1eb914.1714978902.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to extend support for mTHP, add THP validation for PMD-mapped THP
related statistics to avoid statistical confusion.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/shmem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e4483c4596a8..a383ea9a89a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1661,7 +1661,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 			return ERR_PTR(-E2BIG);
 
 		folio = shmem_alloc_hugefolio(gfp, info, index, HPAGE_PMD_ORDER);
-		if (!folio)
+		if (!folio && pages == HPAGE_PMD_NR)
 			count_vm_event(THP_FILE_FALLBACK);
 	} else {
 		pages = 1;
@@ -1679,7 +1679,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 		if (xa_find(&mapping->i_pages, &index,
 				index + pages - 1, XA_PRESENT)) {
 			error = -EEXIST;
-		} else if (huge) {
+		} else if (pages == HPAGE_PMD_NR) {
 			count_vm_event(THP_FILE_FALLBACK);
 			count_vm_event(THP_FILE_FALLBACK_CHARGE);
 		}
@@ -2045,7 +2045,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		folio = shmem_alloc_and_add_folio(huge_gfp,
 				inode, index, fault_mm, true);
 		if (!IS_ERR(folio)) {
-			count_vm_event(THP_FILE_ALLOC);
+			if (folio_test_pmd_mappable(folio))
+				count_vm_event(THP_FILE_ALLOC);
 			goto alloced;
 		}
 		if (PTR_ERR(folio) == -EEXIST)
-- 
2.39.3


