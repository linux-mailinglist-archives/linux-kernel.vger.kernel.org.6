Return-Path: <linux-kernel+bounces-546060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF7A4F5D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30691890E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEC719ADBA;
	Wed,  5 Mar 2025 04:00:55 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E960158524
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147255; cv=none; b=R4kBsGPshGV7bosNE5AV80HXR87F+K7mU4iv/MB0PRamA6uKxNZVJwcHZzLOHvMZLagZgg4xybGwDC3aXRD6c43VaKLAxJGn3Wjb4jwglM2O33hKh67uyDBqvVK7Z5Z6JhZBcpck3SZ7ATN+mgc9jacnpd7E7t7VfkKjgKR29Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147255; c=relaxed/simple;
	bh=0qU+HPPxGJrOwXAzroPYXI6+/+jU7Q4yaXzp/TQlPvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Olrwme8YWMQ0+qCz0jT02+2OaxzNalkuthLtj6WVw2P39vYNQrEaYt+M2gun2onFXz/l3kg/ooagn3TVUKxb68RXVGhEmbe1q9gHqRvtCtcIk90LOD5Zgjn25v5njy/9X91rD+KOGRdIxXtm0DcnGyTqjueie66HnWGklC/D3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z6zHz0jk5z2DjfM;
	Wed,  5 Mar 2025 11:56:31 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 6224A1400D3;
	Wed,  5 Mar 2025 12:00:43 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemg200013.china.huawei.com
 (7.202.181.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 12:00:42 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Muchun Song <muchun.song@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar
 Salvador <osalvador@suse.de>, Kefeng Wang <wangkefeng.wang@huawei.com>, Peter
 Xu <peterx@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Liu Shixin
	<liushixin2@huawei.com>
Subject: [PATCH v3] mm/hugetlb: update nr_huge_pages and surplus_huge_pages together
Date: Wed, 5 Mar 2025 11:54:09 +0800
Message-ID: <20250305035409.2391344-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

To fix the problem, call only_alloc_fresh_hugetlb_folio() instead and
move down __prep_account_new_huge_page() into the hugetlb_lock.

Fixes: 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
v2->v3: Modify the comment suggested by Oscar.
 mm/hugetlb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9faa1034704ff..0e08d2fff2360 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2253,11 +2253,20 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
+	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
 	if (!folio)
 		return NULL;
 
+	hugetlb_vmemmap_optimize_folio(h, folio);
+
 	spin_lock_irq(&hugetlb_lock);
+	/*
+	 * nr_huge_pages needs to be adjusted within the same lock cycle
+	 * as surplus_pages, otherwise it might confuse
+	 * persistent_huge_pages() momentarily.
+	 */
+	__prep_account_new_huge_page(h, nid);
+
 	/*
 	 * We could have raced with the pool size change.
 	 * Double check that and simply deallocate the new page
-- 
2.34.1


