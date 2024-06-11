Return-Path: <linux-kernel+bounces-209612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB552903877
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A92872D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3603178381;
	Tue, 11 Jun 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G+S8m3CJ"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB3E57E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100685; cv=none; b=q+V8ASJwMQ1vMpt0/AJCReUgWkhBen2q/cevKixnFsTKDsWk4noc/4ZpRWSrWh/fFPfwa3yQA4VZS5gvvEQFysM0tCpjtPdNp/0eyMq6b4hoIkMo+EP8/qt8IURH/a5uKoveEw0tMvvaw6MUh3KoQEza4T1eOLc1zHpVTk0kTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100685; c=relaxed/simple;
	bh=7IKpLQeAk/PwE+XF6sHfhIKOPcGYzFBQ1rJnTW0WlxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5xYzM9nwEK8ooT1/evy29FWXhLPcpJMcIW3Hxv427Zgf/vghvZv8tvSYhJ3Wkct8w/RsfQDZm7S4Ktq6eOyLaoErcCjxCUuJ9vj3rhrcdTfexm8oWhX0em5nHmwLLLFRLPytlFD5fATiDn0SNaGvmyepCPGkrubknps2drBtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G+S8m3CJ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718100679; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sk0VCEBLx9HEPQafud6f811f0Tz6WgnTKVbuudZtsuE=;
	b=G+S8m3CJeaGO/N3L6M/HIQFECjbieubXUYafz8SHfbvukr+zHxZjC7+yrkmKRvRxj22CHcIrRDKBMQ1s1tSrCP813AzIOuhW/3RFu71gmbwIj3oy7wu2P/gk7y44omrPCbRGc3Gjwa5QeAqP4+yMB1F0ycSZD6O1ExuD5yGIZBw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8G1Jqm_1718100677;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8G1Jqm_1718100677)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 18:11:17 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
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
Subject: [PATCH v5 2/6] mm: shmem: add THP validation for PMD-mapped THP related statistics
Date: Tue, 11 Jun 2024 18:11:06 +0800
Message-Id: <c4b04cbd51e6951cc2436a87be8eaa4a1516faec.1718090413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
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
index 6868c0af3a69..ae358efc397a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1647,7 +1647,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 			return ERR_PTR(-E2BIG);
 
 		folio = shmem_alloc_folio(gfp, HPAGE_PMD_ORDER, info, index);
-		if (!folio)
+		if (!folio && pages == HPAGE_PMD_NR)
 			count_vm_event(THP_FILE_FALLBACK);
 	} else {
 		pages = 1;
@@ -1665,7 +1665,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 		if (xa_find(&mapping->i_pages, &index,
 				index + pages - 1, XA_PRESENT)) {
 			error = -EEXIST;
-		} else if (huge) {
+		} else if (pages == HPAGE_PMD_NR) {
 			count_vm_event(THP_FILE_FALLBACK);
 			count_vm_event(THP_FILE_FALLBACK_CHARGE);
 		}
@@ -2031,7 +2031,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
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


