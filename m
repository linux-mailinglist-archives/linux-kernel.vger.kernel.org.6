Return-Path: <linux-kernel+bounces-540900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007EBA4B640
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C653AC8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638EF19C54B;
	Mon,  3 Mar 2025 02:47:49 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F406018E025
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970069; cv=none; b=Oyc+x3ELnFgXPoYAsHudgmljYbxz8fr0E4Do1Z3930gHnESDdq4vVbJeW4/kfmYmK8plATKZgEwUWn0uiZLzq9qFPLuvqoJKOdKTJlzo5/Q0QPz2SrXOwJ7RDGOPxL1tf/dc6W0aWlncZFiVlVlzJEqC+gdm1L8iiAOoOI0cQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970069; c=relaxed/simple;
	bh=FJ7wLgel9TPVLGApU7RiYCLI668Fm1OGkgwKYLXX5jc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHpC9ywOlX8e/sPIFnkPtLe1JQen+UL9J6upPSmMbWIA4miPTeEqYZOSMds/F1D8o7n3HYH27x13wddB0kh3L7bcjC4Mjs9S2qHYAyanxNtb2ZEleW/7UjyhP4QccQR+wIlocSoR6DK/lhYfxivOxAOoRA7lXXniStFWVJLdvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z5jmb6jpnz1f00s;
	Mon,  3 Mar 2025 10:43:27 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EAC11402C7;
	Mon,  3 Mar 2025 10:47:38 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemg200013.china.huawei.com
 (7.202.181.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Mar
 2025 10:47:37 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Muchun Song <muchun.song@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Barry Song
	<song.bao.hua@hisilicon.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Peter
 Xu <peterx@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Liu Shixin
	<liushixin2@huawei.com>
Subject: [PATCH] mm/hugetlb: update nr_huge_pages and surplus_huge_pages together
Date: Mon, 3 Mar 2025 10:41:05 +0800
Message-ID: <20250303024105.990297-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200013.china.huawei.com (7.202.181.64)

In alloc_surplus_hugetlb_folio(), we increase nr_huge_pages and
surplus_huge_pages separately. In the middle window, if we set
nr_hugepages to smaller and satisfy count < persistent_huge_pages(h),
the surplus_huge_pages will be increased by adjust_pool_surplus().

After adding delay in the middle window, we can reproduce the problem
easily by following step:

 1. echo 3 > /proc/sys/vm/nr_overcommit_hugepages
 2. mmap two hugepages. When nr_huge_pages=2 and surplus_huge_pages=1,
    goto step 3.
 3. echo 0 > /proc/sys/vm/nr_huge_pages

Finally, nr_huge_pages is less than surplus_huge_pages.

Fixes: 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9faa1034704ff..a900562ea7679 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2248,14 +2248,17 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 	if (hstate_is_gigantic(h))
 		return NULL;
 
+	mutex_lock(&h->resize_lock);
 	spin_lock_irq(&hugetlb_lock);
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
 	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
-	if (!folio)
+	if (!folio) {
+		mutex_unlock(&h->resize_lock);
 		return NULL;
+	}
 
 	spin_lock_irq(&hugetlb_lock);
 	/*
@@ -2268,6 +2271,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		folio_set_hugetlb_temporary(folio);
 		spin_unlock_irq(&hugetlb_lock);
+		mutex_unlock(&h->resize_lock);
 		free_huge_folio(folio);
 		return NULL;
 	}
@@ -2277,6 +2281,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
+	mutex_unlock(&h->resize_lock);
 
 	return folio;
 }
-- 
2.34.1


