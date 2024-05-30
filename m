Return-Path: <linux-kernel+bounces-194869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E808D434D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FAA2834BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726F1BF24;
	Thu, 30 May 2024 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FjDHHL+6"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF017BA8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034683; cv=none; b=hHb7lGiWQ8utALAGzD0NgMVkT1J2fzffqyExjgwQS29xYF3DKXsDYF/uaIyikURCW6QfHtulh3yzOlNzBGUq87o2+Xr303AUNqMXSldChVEHeHTgWF4nsZmpm2NKjFCPT9WNjZfgPtv8yVe3kMXdBzA/6DKZRc6GEULnJQtmiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034683; c=relaxed/simple;
	bh=7IKpLQeAk/PwE+XF6sHfhIKOPcGYzFBQ1rJnTW0WlxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFYoG0Csy67aXVy0Pog0DqBl+Y06V32Xp+GvK4Im7kDrVLElktWOLdfLRHDnpt1X+E9lhqm3eneh88st3ZH79/NkvWlTIMQm3cMNfsL4gGAtx4hI1ThZXCuOEnIMAhQvceUouqi9x6kHGEx8/6438B7X4n+OsOO0VCLmdTsOLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FjDHHL+6; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717034678; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sk0VCEBLx9HEPQafud6f811f0Tz6WgnTKVbuudZtsuE=;
	b=FjDHHL+6nvMQhAE2W0JEM707EeNJXtctxtaTYOaeB3Rykfmw/WBzcom3vory6qXW32nsbgjvti1UnE8j7CUx2Hy+fHF1ylOe6eS/bHScNUsCxsCegrwHy0XF0EVo8T486CFX7oRTLOi9eCdddhb6IgeHDIura768ubziJIHuzgc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7V1J5D_1717034676;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7V1J5D_1717034676)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 10:04:36 +0800
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
Subject: [PATCH v3 2/6] mm: shmem: add THP validation for PMD-mapped THP related statistics
Date: Thu, 30 May 2024 10:04:13 +0800
Message-Id: <9122368aafec9f630190da3023e01337ac49b9cd.1717033868.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
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


