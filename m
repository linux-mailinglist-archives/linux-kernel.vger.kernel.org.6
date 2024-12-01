Return-Path: <linux-kernel+bounces-426739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA49DF724
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9DA2815A8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFFA1D90DF;
	Sun,  1 Dec 2024 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMI2Uve+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E81D8A16
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088181; cv=none; b=Swu45eiW/hcCtMpyEpBKK6HibMosBn87BwiNzUhUFhHWaNGT0wjdBZgpo8h/5b4XkKvBC3uavMYpCH01dsdx/j/gG+MyRkz3pNxksA4He4jFOO4nBOZa6GGzvUVHxlomO31yF4fc/NKLI8/NYgeOs1H7yvJFg3tUyKt2lIDZEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088181; c=relaxed/simple;
	bh=jIB/nB2x+v2Jbbkmervyzfz0wYkf9mfmXiK+PmDv8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHDpePfBeWOUH+km/7RzO6qDL+9LULXodLUKGwvKy3/TtPkFQ6FsFUSjGcmVIaYxAhman+J0LTWetYleVqSlpTMyzStZDVyf2stH6mOncztjQbz79n8T1vXy95DhrM3/h8j3d7s7GVrRoVds+BXKQ3VOjlsp1x2F/Cy4389TjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMI2Uve+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733088179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsfRVwDPpEABH52Gas2qEz8JIuJrK9vYix32n1qAh2g=;
	b=MMI2Uve+Mrabsv3/az4ZPzDJ8pfbY2NgCAbLZSuDUQMxHQYydd9wVDmbsaq3ri5pctxbXd
	dloKsNAprwsl7EQa4JbCq9v74kNsGMCcpj2SD6MOijhTGnpz4dL1Snv/Z6siZeT5f1yX+B
	NacZfxCAD3ZSdWfXtCnK/9B2eG2WyI0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-jgKA7OGCMqCtk41tBBS26w-1; Sun, 01 Dec 2024 16:22:58 -0500
X-MC-Unique: jgKA7OGCMqCtk41tBBS26w-1
X-Mimecast-MFC-AGG-ID: jgKA7OGCMqCtk41tBBS26w
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46697645ceeso63314401cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 13:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733088177; x=1733692977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsfRVwDPpEABH52Gas2qEz8JIuJrK9vYix32n1qAh2g=;
        b=o1yzVYBYHubE2MR16E58kH86v0k+m8yMWlbpmtMmEQ/NPxp0eewIOxCbsZnHjUFm04
         0If4HKmybONmuR77EB2p96aholcjzJclTt8WDLCYvgfskDCcl0wiBNEn+sz96VeVE7+J
         71ygCs0ltOjcangLJ0U9aWCq1oaCYx22QeQF7JZ11ukgpwlCun7Aa7lfOWTxt+QsphcO
         CxmsFojmXOQ/pi3C1sJirQkS63Q65OJjW7DpckYS5fJeZsGapUp5cBdAq7nO7MXAOtj0
         QZedFjr8O20qjSjfWlknSaCTOMxE0smIYtpVolkzbx7nkbjjIswu6A1uEHxnmHj0MWiH
         YlwA==
X-Gm-Message-State: AOJu0Yw8xnVI3ZRsighmh8x1JKsg7hv/bQcbwvxy4RWB+ovplWwNfraK
	Y+Pq8CJ9sjgIDMa0ltSehZeEY1ZnXjgl9KRPbDi8eJqNsmaN47PZdJHWBkHH02eKqynJQ0EQCUk
	72pwRmdU4GaxTjzXnKtT9Mg46WE1itDRVcjx+jTvi+z89VwvNSFk2MDA44+vZcgvF1ZHosUIEC5
	MdESux09zjQ4hMiayIkCJFfyDYCAXkdmoxE/CXbpC8U3E=
X-Gm-Gg: ASbGncufGeOVFjJ4J76H8Dfw+9h49hqBUKaRvZtZb+x4JBmC8gvwbDKVIldBF1zJsl3
	7zI8KlhS43P25ZlsKun4tAyo62CW/u4aCaJ0tw3hgk8q7Dm1CyHkua9WH6C5UxWW1ewkkqmhsWk
	UiXqRpS0LYmnsJVaAiiNu3zNLHBQInxNsPUBIxqLKhg4yi+8U6EiRXpyJXvR5O98v7EwLLsrhxa
	K8bWtJjt808T3JXduQVebwgxkI7xtc+z8iIkidujvpVYPiVXshsTJAU5waEzEHZYK9ab9W2go7d
	ogAFFHrdXC1PUoh1V0jiaGFJRg==
X-Received: by 2002:a05:622a:1801:b0:462:a7d1:8e19 with SMTP id d75a77b69052e-466b359cc6dmr326628501cf.13.1733088176612;
        Sun, 01 Dec 2024 13:22:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIHjJ7gsnlT3rnkpu2KbnEapiMVvKzn9R0CmFm4KgWLF8XZTcnqWRYbl4fLEluyyAPgKpicA==
X-Received: by 2002:a05:622a:1801:b0:462:a7d1:8e19 with SMTP id d75a77b69052e-466b359cc6dmr326628031cf.13.1733088176142;
        Sun, 01 Dec 2024 13:22:56 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4249f0asm41278911cf.81.2024.12.01.13.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 13:22:55 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Rik van Riel <riel@surriel.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: [PATCH 4/7] mm/hugetlb: Clean up map/global resv accounting when allocate
Date: Sun,  1 Dec 2024 16:22:37 -0500
Message-ID: <20241201212240.533824-5-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201212240.533824-1-peterx@redhat.com>
References: <20241201212240.533824-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_hugetlb_folio() isn't a function easy to read, especially on
reservation accountings for either VMA or globally (majorly, spool only).

The 1st complexity lies in the special private CoW path, aka,
cow_from_owner=true case.

The 2nd complexity may be the confusing updates of gbl_chg after it's set
once, which looks like they can change anytime on the fly.

Logically, cow_from_user is only about vma reservation.  We could already
decouple the flag and consolidate it into map charge flag very early.  Then
we don't need to keep checking the CoW special flag every time.

This patch does it by making map_chg a tri-state flag.  Tri-state needed is
unfortunate, and it's because currently vma_needs_reservation() has a side
effect internally, that it must be followed by either a end() or commit().

We keep the same semantic as before on one thing: "if (map_chg)" means we
need a separate per-vma resv count.  It keeps most of the old code like
before untouched with the new enum.

After this patch, we take these steps to decide these variables, hopefully
slightly easier to follow:

  - First, decide map_chg.  This will take cow_from_owner into account,
    once and for all.  It's about whether we could take a resv count from
    the vma, no matter it's shared, private, etc.

  - Then, decide gbl_chg.  The only diff here is spool, comparing to
    map_chg.

Now only update each flag once and for all, instead of keep any of them
flipping which can be very hard to follow.

With cow_from_owner merged into map_chg, we could remove quite a few such
checks all over.  Side benefit of such is that we can get rid of one more
confusing flag, which is deferred_reserve.

Cleanup the comments a bit too.  E.g., MAP_NORESERVE may not need to check
against spool limit, AFAIU, if it's on a shared mapping, and if the page
cache folio has its inode's resv map available (in which case map_chg would
have been set zero, hence the code should be correct, not the comment).

There's one trivial detail that needs attention that this patch touched,
which is this check right after vma_commit_reservation():

  if (map_chg > map_commit)

It changes to:

  if (unlikely(map_chg == MAP_CHG_NEEDED && retval == 0))

It should behave the same like before, because previously the only way to
make "map_chg > map_commit" happen is map_chg=1 && map_commit=0.  That's
exactly the rewritten line.  Meanwhile, either commit() or end() will need
to be skipped if ENFORCE, to keep the old behavior.

Even though it looks a lot changed, but no functional change expected.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 116 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 36 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfd479a857b6..14cfe0bb01e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2956,6 +2956,25 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
+typedef enum {
+	/*
+	 * For either 0/1: we checked the per-vma resv map, and one resv
+	 * count either can be reused (0), or an extra needed (1).
+	 */
+	MAP_CHG_REUSE = 0,
+	MAP_CHG_NEEDED = 1,
+	/*
+	 * Cannot use per-vma resv count can be used, hence a new resv
+	 * count is enforced.
+	 *
+	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
+	 * that currently vma_needs_reservation() has an unwanted side
+	 * effect to either use end() or commit() to complete the
+	 * transaction.	 Hence it needs to differenciate from NEEDED.
+	 */
+	MAP_CHG_ENFORCED = 2,
+} map_chg_state;
+
 /*
  * NOTE! "cow_from_owner" represents a very hacky usage only used in CoW
  * faults of hugetlb private mappings on top of a non-page-cache folio (in
@@ -2969,12 +2988,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
-	long map_chg, map_commit, nr_pages = pages_per_huge_page(h);
-	long gbl_chg;
+	long retval, gbl_chg, nr_pages = pages_per_huge_page(h);
+	map_chg_state map_chg;
 	int memcg_charge_ret, ret, idx;
 	struct hugetlb_cgroup *h_cg = NULL;
 	struct mem_cgroup *memcg;
-	bool deferred_reserve;
 	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
 
 	memcg = get_mem_cgroup_from_current();
@@ -2985,36 +3003,56 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	}
 
 	idx = hstate_index(h);
-	/*
-	 * Examine the region/reserve map to determine if the process
-	 * has a reservation for the page to be allocated.  A return
-	 * code of zero indicates a reservation exists (no change).
-	 */
-	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
-	if (map_chg < 0) {
-		if (!memcg_charge_ret)
-			mem_cgroup_cancel_charge(memcg, nr_pages);
-		mem_cgroup_put(memcg);
-		return ERR_PTR(-ENOMEM);
+
+	/* Whether we need a separate per-vma reservation? */
+	if (cow_from_owner) {
+		/*
+		 * Special case!  Since it's a CoW on top of a reserved
+		 * page, the private resv map doesn't count.  So it cannot
+		 * consume the per-vma resv map even if it's reserved.
+		 */
+		map_chg = MAP_CHG_ENFORCED;
+	} else {
+		/*
+		 * Examine the region/reserve map to determine if the process
+		 * has a reservation for the page to be allocated.  A return
+		 * code of zero indicates a reservation exists (no change).
+		 */
+		retval = vma_needs_reservation(h, vma, addr);
+		if (retval < 0) {
+			if (!memcg_charge_ret)
+				mem_cgroup_cancel_charge(memcg, nr_pages);
+			mem_cgroup_put(memcg);
+			return ERR_PTR(-ENOMEM);
+		}
+		map_chg = retval ? MAP_CHG_NEEDED : MAP_CHG_REUSE;
 	}
 
 	/*
+	 * Whether we need a separate global reservation?
+	 *
 	 * Processes that did not create the mapping will have no
 	 * reserves as indicated by the region/reserve map. Check
 	 * that the allocation will not exceed the subpool limit.
-	 * Allocations for MAP_NORESERVE mappings also need to be
-	 * checked against any subpool limit.
+	 * Or if it can get one from the pool reservation directly.
 	 */
-	if (map_chg || cow_from_owner) {
+	if (map_chg) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0)
 			goto out_end_reservation;
+	} else {
+		/*
+		 * If we have the vma reservation ready, no need for extra
+		 * global reservation.
+		 */
+		gbl_chg = 0;
 	}
 
-	/* If this allocation is not consuming a reservation, charge it now.
+	/*
+	 * If this allocation is not consuming a per-vma reservation,
+	 * charge the hugetlb cgroup now.
 	 */
-	deferred_reserve = map_chg || cow_from_owner;
-	if (deferred_reserve) {
+	if (map_chg) {
 		ret = hugetlb_cgroup_charge_cgroup_rsvd(
 			idx, pages_per_huge_page(h), &h_cg);
 		if (ret)
@@ -3038,7 +3076,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-		if (!cow_from_owner && vma_has_reserves(vma, gbl_chg)) {
+		if (vma_has_reserves(vma, gbl_chg)) {
 			folio_set_hugetlb_restore_reserve(folio);
 			h->resv_huge_pages--;
 		}
@@ -3051,7 +3089,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
 	 */
-	if (deferred_reserve) {
+	if (map_chg) {
 		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
 						  h_cg, folio);
 	}
@@ -3060,26 +3098,31 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	hugetlb_set_folio_subpool(folio, spool);
 
-	map_commit = vma_commit_reservation(h, vma, addr);
-	if (unlikely(map_chg > map_commit)) {
+	if (map_chg != MAP_CHG_ENFORCED) {
+		/* commit() is only needed if the map_chg is not enforced */
+		retval = vma_commit_reservation(h, vma, addr);
 		/*
+		 * Check for possible race conditions. When it happens..
 		 * The page was added to the reservation map between
 		 * vma_needs_reservation and vma_commit_reservation.
 		 * This indicates a race with hugetlb_reserve_pages.
 		 * Adjust for the subpool count incremented above AND
-		 * in hugetlb_reserve_pages for the same page.  Also,
+		 * in hugetlb_reserve_pages for the same page.	Also,
 		 * the reservation count added in hugetlb_reserve_pages
 		 * no longer applies.
 		 */
-		long rsv_adjust;
+		if (unlikely(map_chg == MAP_CHG_NEEDED && retval == 0)) {
+			long rsv_adjust;
 
-		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
-		hugetlb_acct_memory(h, -rsv_adjust);
-		if (deferred_reserve) {
-			spin_lock_irq(&hugetlb_lock);
-			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
-					pages_per_huge_page(h), folio);
-			spin_unlock_irq(&hugetlb_lock);
+			rsv_adjust = hugepage_subpool_put_pages(spool, 1);
+			hugetlb_acct_memory(h, -rsv_adjust);
+			if (map_chg) {
+				spin_lock_irq(&hugetlb_lock);
+				hugetlb_cgroup_uncharge_folio_rsvd(
+				    hstate_index(h), pages_per_huge_page(h),
+				    folio);
+				spin_unlock_irq(&hugetlb_lock);
+			}
 		}
 	}
 
@@ -3093,14 +3136,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
 out_uncharge_cgroup_reservation:
-	if (deferred_reserve)
+	if (map_chg)
 		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
 						    h_cg);
 out_subpool_put:
-	if (map_chg || cow_from_owner)
+	if (map_chg)
 		hugepage_subpool_put_pages(spool, 1);
 out_end_reservation:
-	vma_end_reservation(h, vma, addr);
+	if (map_chg != MAP_CHG_ENFORCED)
+		vma_end_reservation(h, vma, addr);
 	if (!memcg_charge_ret)
 		mem_cgroup_cancel_charge(memcg, nr_pages);
 	mem_cgroup_put(memcg);
-- 
2.47.0


