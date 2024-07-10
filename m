Return-Path: <linux-kernel+bounces-247223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0797692CCBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391771C2274D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE98484E18;
	Wed, 10 Jul 2024 08:19:16 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6BF85626
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599556; cv=none; b=VvdQ3QHmhfxHJaS5BU9GepYuxW6RDIknIQx6Z22/2k78oSfqjSKUoQYHoXzlttWBlDrJEQHOiYuZztZCkxHGkn3LzKyxVQeioicZFLi0K6RLvECDiqRWHMV9D4kRUyM6pjWKM4X3n5q4lkvA4Dk7OTTOfBHjaH4ItoSftsFpnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599556; c=relaxed/simple;
	bh=3ei+wbaOm2pwHyNkV9y2w5jh+KndD1GNVFW8VmStN1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdzo1vdTBc66ZDyc1g6jS2bhWzdSJnXZx/HIyVHVY+MwoBTpgk5Oi7SEO7ExsyOZYX3EuPZNyVPwqUZgKiLcFwrNJA/T0oamp38xC67UdkrHPX7ug/umvbOrbTXFhkNPvVzx+T3IfIb/AEyPsZ+hplYuoLTMiub/mXrL/VccS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WJrJ21Npjz2Cl9C;
	Wed, 10 Jul 2024 16:14:58 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 852E41A016C;
	Wed, 10 Jul 2024 16:19:10 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Jul
 2024 16:19:09 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/hugetlb: fix potential race with try_memory_failure_hugetlb()
Date: Wed, 10 Jul 2024 16:14:45 +0800
Message-ID: <20240710081445.3307355-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200019.china.huawei.com (7.221.188.193)

There is a potential race between __update_and_free_hugetlb_folio() and
try_memory_failure_hugetlb():

 CPU1					CPU2
 __update_and_free_hugetlb_folio	try_memory_failure_hugetlb
  					 spin_lock_irq(&hugetlb_lock);
					 __get_huge_page_for_hwpoison
					  folio_test_hugetlb
					  -- It's still hugetlb folio.
  folio_test_hugetlb_raw_hwp_unreliable
  -- raw_hwp_unreliable flag is not set yet.
					  folio_set_hugetlb_hwpoison
					  -- raw_hwp_unreliable flag might
					     be set.
					 spin_unlock_irq(&hugetlb_lock);
  spin_lock_irq(&hugetlb_lock);
  __folio_clear_hugetlb(folio);
   -- Hugetlb flag is cleared but too late!
  spin_unlock_irq(&hugetlb_lock);

When above race occurs, raw error pages will hit pcplists/buddy. Fix
this issue by deferring folio_test_hugetlb_raw_hwp_unreliable() until
__folio_clear_hugetlb() is done. The raw_hwp_unreliable flag cannot be
set after hugetlb folio flag is cleared.

Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9155144a654c..3d65b68cf78f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1705,13 +1705,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	/*
-	 * If we don't know which subpages are hwpoisoned, we can't free
-	 * the hugepage, so it's leaked intentionally.
-	 */
-	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
-		return;
-
 	/*
 	 * If folio is not vmemmap optimized (!clear_flag), then the folio
 	 * is no longer identified as a hugetlb page.  hugetlb_vmemmap_restore_folio
@@ -1739,6 +1732,13 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	/*
+	 * If we don't know which subpages are hwpoisoned, we can't free
+	 * the hugepage, so it's leaked intentionally.
+	 */
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+		return;
+
 	/*
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.
-- 
2.33.0


