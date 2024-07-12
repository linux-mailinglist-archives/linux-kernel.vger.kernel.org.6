Return-Path: <linux-kernel+bounces-250093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC1892F428
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BBF1C217E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5279D0;
	Fri, 12 Jul 2024 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="UzhrMi6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="At1TRM8p"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D6C8D7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752313; cv=none; b=iSThJjywbM4gdESDzdeaJesm1gUrU/7LpWzuvwAqL+UTc6uC4dbQfI54L7sS2WPHpmVBUoqWyTkHDEtkmuDsFUuG+mZXZ9YjwX+7H11LGxxhcBtR/iU3qK9hTog4vxcEhiKC/1+2jn0nECfhsXTk7bfUya8djMo+HVoRfyPbSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752313; c=relaxed/simple;
	bh=yGl+Vm21WAbpoDJw2xN1jKUePiteO4Emne3TzFKScTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyMToV7F6JndwhUf7Vws9ZRJsds+haRNAGtefgPcMhXHxmG06/VOSzK9EFOYAtjFLEWZ1E7AVoQAZVK9RUK2lWkPNn9mHHDt83iNIoP5zlj0jVV0RBDLctk3EH3ZtafF0zvo2BU4nMqeiei67JOsG+gBODewivaDjj+eF1IP+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=UzhrMi6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=At1TRM8p; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7F0D11388636;
	Thu, 11 Jul 2024 22:45:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jul 2024 22:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1720752310;
	 x=1720838710; bh=qOLH68BAMXmJaL/17ag+VBuU12QsIrePjVshhM6Mfe0=; b=
	UzhrMi6KRCDGISUUfYy8VY1O+HNyLY+YsDCfn7vyNqLyKNGyvCiSp9lSx4DIlrdH
	Wz+A0c1HnuV444dIAMSJgLwkaNNhtz4lhfpX+gTZnqbMokGPCg7uxg8j0zaAtrnr
	EWxIehnk0SV9nHHyDxbY5U7RiN7QcbagxPxt/rOmTQVH+1epuEnFG0iYOIUOCVfG
	XgncIdsqnEve7p5ol3AcczTUYpTAXmqf2ow/fkmJaK4zZhrSsewoCoxNgq1mcoQf
	/fqXqJW4PGGdUQZiIhi3ZDvNr/Zo5QpZ7OaHn12I9iLFunXjwZGLOVapaaxzpiHH
	fxJGpWsU1BKUjU5L/bydTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720752310; x=
	1720838710; bh=qOLH68BAMXmJaL/17ag+VBuU12QsIrePjVshhM6Mfe0=; b=A
	t1TRM8pYiC+yDef6ArSXq6vIeVDSlwZcsQDCaVLGNIxE4y0f/Vhbnx2bSXtCH/Ki
	Wui7qzOwtG6EfE/TvSOU8G+iFjPFvFISE5JCp4PJ1M21fMSKoKD9mrRaTxEhIj6j
	6O0/Xlo1boRKbeFqZeKuidvP05NIVdUBWzKO7qRECwyYbtGYqh8OHWnyflHUMvZ5
	q7nXoI7kEY4k+bQmvSGAbpfXR/qck3i9ctyTJmlrh2/coeF06LvghZoDLzpyDnhG
	qZQ6lrNiySmt77S9XhQ8BJBeKfv1GurePGryUThlB7g7ALS7nA0QzLZ0Lybi6N/P
	/VLW4r2XyjIn89dqDqGKw==
X-ME-Sender: <xms:tZiQZiOq6f3SpLPQRuFNdKZ-zRNH21wMIcg7lHa93A3J27rW1CHjbQ>
    <xme:tZiQZg__koWvxT1mK4fCcpLqBua7V2RK-UEQzVjb6vhm3tOCk07CWkPqm3oIHVnSR
    KVEZvB_pbY0kEEA-g>
X-ME-Received: <xmr:tZiQZpRr8gt9wzGHva4mdf57W6121nw_Dh-Ti_y1ey2BFbNOBstr75jE2vxItBZ8D_rtIHCHc5CO8s8YGgVrHNMaTxv9PSAaM19QapIPGUF5PfI_r-i89J6l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepudfgfe
    elhfekiefgtedvudfghfduffefieefffejvefhlefhhffgkedtfeevhfevnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:tZiQZisyMqz7e4UlrPzwD4dob1rmKn9y1o-gDYDXvn5JbN4vPGKafQ>
    <xmx:tZiQZqfCWTCKMgc4-OmBUld586A7fTnfi1EYKJae1n-TxwgZ5z-W1g>
    <xmx:tZiQZm2H9P_Q4zPYcNenk5-fUVkvHwEkVlTJCS1jaAkBFMRUkaZ6FQ>
    <xmx:tZiQZu8o4322HOAZJZ7wmwexl8JJQuSdQxf-lNWjPH13OXIqaSd1Fw>
    <xmx:tpiQZgtrhjUvj8B5jn0Y8Y1L1dnRjkM0v8lg0kdslOXayY4El4xzBML->
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 22:45:08 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] mm/migrate: move common code to numa_migrate_check (was numa_migrate_prep)
Date: Thu, 11 Jul 2024 22:44:55 -0400
Message-ID: <20240712024455.163543-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712024455.163543-1-zi.yan@sent.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
reduce redundancy, move common code to numa_migrate_prep() and rename
the function to numa_migrate_check() to reflect its functionality.

There is some code difference between do_numa_page() and
do_huge_pmd_numa_page() before the code move:

1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SHARED.
2. do_huge_pmd_numa_page() did not check and skip zone device folios.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 28 ++++++-----------
 mm/internal.h    |  5 +--
 mm/memory.c      | 81 +++++++++++++++++++++++-------------------------
 3 files changed, 52 insertions(+), 62 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8c11d6da4b36..66d67d13e0dc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	pmd_t pmd;
 	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
-	int nid = NUMA_NO_NODE;
-	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
+	int target_nid = NUMA_NO_NODE;
+	int last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool writable = false;
-	int flags = 0;
+	int flags = 0, nr_pages;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
@@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		writable = true;
 
 	folio = vm_normal_folio_pmd(vma, haddr, pmd);
-	if (!folio)
+	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/* See similar comment in do_numa_page for explanation */
-	if (!writable)
-		flags |= TNF_NO_GROUP;
+	nr_pages = folio_nr_pages(folio);
 
-	nid = folio_nid(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (folio_has_cpupid(folio))
-		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
+	target_nid = numa_migrate_check(folio, vmf, haddr, writable,
+			&flags, &last_cpupid);
 	if (target_nid == NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
@@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		flags |= TNF_MIGRATED;
-		nid = target_nid;
 	} else {
+		target_nid = NUMA_NO_NODE;
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
@@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	}
 
 out:
-	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+	if (target_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
 
 	return 0;
 
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..7782b7bb3383 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1217,8 +1217,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags);
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, bool writable,
+		      int *flags, int *last_cpupid);
 
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index 96c2f5b3d796..a252c0f13755 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5209,16 +5209,42 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags)
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, bool writable,
+		      int *flags, int *last_cpupid)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	/*
+	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
+	 * much anyway since they can be in shared cache state. This misses
+	 * the case where a mapping is writable but the process never writes
+	 * to it but pte_write gets cleared during protection updates and
+	 * pte_dirty has unpredictable behaviour between PTE scan updates,
+	 * background writeback, dirty balancing and application behaviour.
+	 */
+	if (!writable)
+		*flags |= TNF_NO_GROUP;
+
+	/*
+	 * Flag if the folio is shared between multiple address spaces. This
+	 * is later used when determining whether to group tasks together
+	 */
+	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
+		*flags |= TNF_SHARED;
+
+	/*
+	 * For memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.
+	 */
+	if (folio_has_cpupid(folio))
+		*last_cpupid = folio_last_cpupid(folio);
+
 	/* Record the current PID acceesing VMA */
 	vma_set_access_pid_bit(vma);
 
 	count_vm_numa_event(NUMA_HINT_FAULTS);
-	if (page_nid == numa_node_id()) {
+	if (folio_nid(folio) == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
 		*flags |= TNF_FAULT_LOCAL;
 	}
@@ -5284,12 +5310,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio = NULL;
-	int nid = NUMA_NO_NODE;
+	int target_nid = NUMA_NO_NODE;
 	bool writable = false, ignore_writable = false;
 	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
-	int last_cpupid;
-	int target_nid;
-	pte_t pte, old_pte;
+	int last_cpupid = (-1 & LAST_CPUPID_MASK);
+	pte_t pte, old_pte = vmf->orig_pte;
 	int flags = 0, nr_pages;
 
 	/*
@@ -5297,10 +5322,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * table lock, that its contents have not changed during fault handling.
 	 */
 	spin_lock(vmf->ptl);
-	/* Read the live PTE from the page tables: */
-	old_pte = ptep_get(vmf->pte);
-
-	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
+	if (unlikely(!pte_same(old_pte, *vmf->pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		goto out;
 	}
@@ -5320,35 +5342,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 
-	/*
-	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
-	 * much anyway since they can be in shared cache state. This misses
-	 * the case where a mapping is writable but the process never writes
-	 * to it but pte_write gets cleared during protection updates and
-	 * pte_dirty has unpredictable behaviour between PTE scan updates,
-	 * background writeback, dirty balancing and application behaviour.
-	 */
-	if (!writable)
-		flags |= TNF_NO_GROUP;
-
-	/*
-	 * Flag if the folio is shared between multiple address spaces. This
-	 * is later used when determining whether to group tasks together
-	 */
-	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
-		flags |= TNF_SHARED;
-
-	nid = folio_nid(folio);
 	nr_pages = folio_nr_pages(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (!folio_has_cpupid(folio))
-		last_cpupid = (-1 & LAST_CPUPID_MASK);
-	else
-		last_cpupid = folio_last_cpupid(folio);
-	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
+
+	target_nid = numa_migrate_check(folio, vmf, vmf->address, writable,
+			&flags, &last_cpupid);
 	if (target_nid == NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
@@ -5362,9 +5359,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	/* Migrate to the requested node */
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
-		nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
+		target_nid = NUMA_NO_NODE;
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					       vmf->address, &vmf->ptl);
@@ -5378,8 +5375,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	}
 
 out:
-	if (nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+	if (target_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
 	return 0;
 out_map:
 	/*
-- 
2.43.0


