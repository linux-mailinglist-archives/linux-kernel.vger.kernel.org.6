Return-Path: <linux-kernel+bounces-574759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B6DA6E993
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71EC188CD02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7232F1F9AAB;
	Tue, 25 Mar 2025 06:26:32 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AEC38385
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742883992; cv=none; b=Bu86I3s1LGO6Cic25GO5kfQtnZT9SivuIjgH13UFC1IaJ8UsRiFivJCMCEzMZNcZoBvIJ7L/LMh+7WvhhL2B7cBgmcW8U7p3LR6wTztTgZODHw5oXZsTZ9ZJbDRu4PqVaf/vl/BtlsgQGYMo3BrR61u8XS5qtKND4ByO0K6dM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742883992; c=relaxed/simple;
	bh=Ox1fhONWN8x2PVBse44ep4LUGaP+pA4mpHXFB6FyPvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IAKOx6k32B+/UPP9lMmjnxNNxEPzTq6J7/SFzjn/0Kf0PL3wdM9PTiwZ5olCd9Db5KZOqzBzyNjntkxJKzw2U6viMYP3d6nCaAQyPtUXtZgmTOHMKSR4nTSUTsKV5x1ZQajJBmluUAp+TePGA0xzJrS+frigSva+3Vy9BKmdwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZMKf10n59ztRM2;
	Tue, 25 Mar 2025 14:24:57 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id D35C81800E2;
	Tue, 25 Mar 2025 14:26:23 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemg100017.china.huawei.com
 (7.202.181.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 25 Mar
 2025 14:26:23 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>, <david@redhat.com>
CC: <muchun.song@linux.dev>, <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] mm: hugetlb: Fix incorrect fallback for subpool
Date: Tue, 25 Mar 2025 14:16:34 +0800
Message-ID: <20250325061634.2118202-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg100017.china.huawei.com (7.202.181.58)

During our testing with hugetlb subpool enabled, we observe that
hstate->resv_huge_pages may underflow into negative values. Root cause
analysis reveals a race condition in subpool reservation fallback handling
as follow:

hugetlb_reserve_pages()
    /* Attempt subpool reservation */
    gbl_reserve = hugepage_subpool_get_pages(spool, chg);

    /* Global reservation may fail after subpool allocation */
    if (hugetlb_acct_memory(h, gbl_reserve) < 0)
        goto out_put_pages;

out_put_pages:
    /* This incorrectly restores reservation to subpool */
    hugepage_subpool_put_pages(spool, chg);

When hugetlb_acct_memory() fails after subpool allocation, the current
implementation over-commits subpool reservations by returning the full
'chg' value instead of the actual allocated 'gbl_reserve' amount. This
discrepancy propagates to global reservations during subsequent releases,
eventually causing resv_huge_pages underflow.

This problem can be trigger easily with the following steps:
1. reverse hugepage for hugeltb allocation
2. mount hugetlbfs with min_size to enable hugetlb subpool
3. alloc hugepages with two task(make sure the second will fail due to
   insufficient amount of hugepages)
4. with for a few seconds and repeat step 3 which will make
   hstate->resv_huge_pages to go below zero.

To fix this problem, return corrent amount of pages to subpool during the
fallback after hugepage_subpool_get_pages is called.

Fixes: 1c5ecae3a93f ("hugetlbfs: add minimum size accounting to subpools")
Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
---
 mm/hugetlb.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 318624c96584..dc4449592d00 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2987,7 +2987,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
-	long retval, gbl_chg;
+	long retval, gbl_chg, gbl_reserve;
 	map_chg_state map_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
@@ -3140,8 +3140,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg);
 out_subpool_put:
-	if (map_chg)
-		hugepage_subpool_put_pages(spool, 1);
+	/*
+	 * put page to subpool iff the quota of subpool's rsv_hpages is used
+	 * during hugepage_subpool_get_pages.
+	 */
+	if (map_chg && !gbl_chg) {
+		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
+		hugetlb_acct_memory(h, -gbl_reserve);
+	}
+
+
 out_end_reservation:
 	if (map_chg != MAP_CHG_ENFORCED)
 		vma_end_reservation(h, vma, addr);
@@ -6949,7 +6957,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long chg = -1, add = -1;
+	long chg = -1, add = -1, spool_resv, gbl_resv;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
@@ -7084,8 +7092,16 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	return true;
 
 out_put_pages:
-	/* put back original number of pages, chg */
-	(void)hugepage_subpool_put_pages(spool, chg);
+	spool_resv = chg - gbl_reserve;
+	if (spool_resv) {
+		/* put sub pool's reservation back, chg - gbl_reserve */
+		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
+		/*
+		 * subpool's reserved pages can not be put back due to race,
+		 * return to hstate.
+		 */
+		hugetlb_acct_memory(h, -gbl_resv);
+	}
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
-- 
2.43.0


