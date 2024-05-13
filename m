Return-Path: <linux-kernel+bounces-177152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1BC8C3AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE58B20D39
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A556146013;
	Mon, 13 May 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="srFSmgNC"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D11E493
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576925; cv=none; b=XvUPbtmQzzlCFC5l8Jdl1aYvgdSAXGYN1iDXCYxCANzU4u/00e593KfRwfeMafeVAQl7xAjd9C/CXxe8CHzSmBd+A5y0/k0IdlNCyUacDp6cLOV4wT3MO0kBRDN210y5qaa7iUtVcN8sTeIEnvDtuW2I5n7NsKQjsiAEf1G+pUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576925; c=relaxed/simple;
	bh=aXZ3X5BsKkhtjbzkDsuZ2qmB5MEnQRxlo7XdIgbTI/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSDC0efCTYDYt+WmKOEVO4TXejWWCVN7He612QMOq+zcTEG5AFdUwtSmx/iYsWYa757IHzlPBKoS/wmeHmDoVB3kTkSdr45lhkt53NWFuy/ImxtFA6Urk3fw5g5AlvU5RnEQeLwQz/fvwBK+k+WBIILZR6liOdR8tHoKsrj735g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=srFSmgNC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715576919; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aUksnnssWSvRHZu6SVpR2z8swC3sgIQdPUjmp/ogrf0=;
	b=srFSmgNCQAoX3A57O4gWlnWXqQmz46ne38nEDzmfEKo51vZif83UxWegLppk3TLr9WSnqctHrYlNTOiRRZAUTyBoCF5/f2a0lIZMDVzBhgmhQAueteKYbI1YMZkeDR7wkaMwbUJ18ElttmZIdel5+hIhZ1uQu1A+y1YgVHRIhjc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6HNn3X_1715576916;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6HNn3X_1715576916)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 13:08:37 +0800
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
Subject: [PATCH v2 3/7] mm: shmem: add THP validation for PMD-mapped THP related statistics
Date: Mon, 13 May 2024 13:08:13 +0800
Message-Id: <b546be09a3129a69c4b645c7ae2a6d760a26091c.1715571279.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
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


