Return-Path: <linux-kernel+bounces-394083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949F69BAA73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194451F226CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47619AA58;
	Mon,  4 Nov 2024 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5fJegJC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE918DF97
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684500; cv=none; b=YDBLMV+3NPhSa14R1n2GDc6PigXkFDr5XdHkX0Xb6JBFAaCH3sL6e8cfTah5nUJyWYNueV5njMcqtAI5ZzG8/0LzEAg/LoCfq15Oqda1kUEdGi6+/IE+fYIxgnChdc9CXzxGBiFsTBjqXOLDvWjG+2FE3jHZ65iLKP0jjjWD4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684500; c=relaxed/simple;
	bh=FFYvpKwIdstb8aiaJRbgaOuMpBvEONLeaDeu6tCW2c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYlrp82OJ0UW9Mv+7BDYja4lyfth/DsZ8DVQCzWxNvVOdBANz/td8b4niMhp7u1hcGfA0lWysmzswKD25uFn7bDZiCwwiFeEVRsFgbL4XxdARwW6WDT4Q265weLnmUCr/uIZb5icsUu3Z65jgPftKN1jPzYbw0Np8W1xtzqQbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5fJegJC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684499; x=1762220499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFYvpKwIdstb8aiaJRbgaOuMpBvEONLeaDeu6tCW2c8=;
  b=c5fJegJCEa/xHq3wHKQBigdPULmQX9P52yA84CNH/LZeyBHP5Pe1qFIF
   hdWsVWsQpiLQByjkcdmMPDx/Q92wRi8weP/T8huLO111GuXRMEtzNPOQ4
   c+esDcB/wnjXw5imexvxNnhPRdBOX4JBj/4CDMc6yRUBIKHiZ7LwH0g2A
   wIqkbjUMW2wBKY6yG/sp4syvTWK8Fus2jyGayf2Gj1/Qg+HfjH3rblLBg
   j1/GOSrNGMsg7EeTXjLVekXPSfKXDzvonnOkZPxUhECstElpPc4hTSXjA
   qo0M8KsCkbh4k/IMru9ulH05WLf6JvdWWz0PwDSPHTXtgI0wlUrkq+wHI
   A==;
X-CSE-ConnectionGUID: 5jC6OX+BSnqomu0V6MmbEw==
X-CSE-MsgGUID: iVsuXhTvT62DclXeIFLgeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221943"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221943"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:39 -0800
X-CSE-ConnectionGUID: xNfxnvoQTUSj3nvdzvVf7A==
X-CSE-MsgGUID: sSYjM+UTQQCK2u9YGY8epA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020890"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:38 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
Date: Mon,  4 Nov 2024 09:40:32 +0800
Message-ID: <20241104014040.106100-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

There are some issues in dmar_fault_dump_ptes():

1. return value of phys_to_virt() is used for checking if an entry is
   present.
2. dump is confusing, e.g., "pasid table entry is not present", confusing
   by unpresent pasid table vs. unpresent pasid table entry. Current code
   means the former.
3. pgtable_walk() is called without checking if page table is present.

Fix 1 by checking present bit of an entry before dump a lower level entry.
Fix 2 by removing "entry" string, e.g., "pasid table is not present".
Fix 3 by checking page table present before walk.

Take issue 3 for example, before fix:

[  442.240357] DMAR: pasid dir entry: 0x000000012c83e001
[  442.246661] DMAR: pasid table entry[0]: 0x0000000000000000
[  442.253429] DMAR: pasid table entry[1]: 0x0000000000000000
[  442.260203] DMAR: pasid table entry[2]: 0x0000000000000000
[  442.266969] DMAR: pasid table entry[3]: 0x0000000000000000
[  442.273733] DMAR: pasid table entry[4]: 0x0000000000000000
[  442.280479] DMAR: pasid table entry[5]: 0x0000000000000000
[  442.287234] DMAR: pasid table entry[6]: 0x0000000000000000
[  442.293989] DMAR: pasid table entry[7]: 0x0000000000000000
[  442.300742] DMAR: PTE not present at level 2

After fix:
...
[  357.241214] DMAR: pasid table entry[6]: 0x0000000000000000
[  357.248022] DMAR: pasid table entry[7]: 0x0000000000000000
[  357.254824] DMAR: scalable mode page table is not present

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/r/20241024092146.715063-2-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a2212d15371d..96d40e0268a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -626,11 +626,11 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
 
 	/* root entry dump */
+	if (!iommu->root_entry) {
+		pr_info("root table is not present\n");
+		return;
+	}
 	rt_entry = &iommu->root_entry[bus];
-	if (!rt_entry) {
-		pr_info("root table entry is not present\n");
-		return;
-	}
 
 	if (sm_supported(iommu))
 		pr_info("scalable mode root entry: hi 0x%016llx, low 0x%016llx\n",
@@ -641,7 +641,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	/* context entry dump */
 	ctx_entry = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!ctx_entry) {
-		pr_info("context table entry is not present\n");
+		pr_info("context table is not present\n");
 		return;
 	}
 
@@ -650,17 +650,23 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 
 	/* legacy mode does not require PASID entries */
 	if (!sm_supported(iommu)) {
+		if (!context_present(ctx_entry)) {
+			pr_info("legacy mode page table is not present\n");
+			return;
+		}
 		level = agaw_to_level(ctx_entry->hi & 7);
 		pgtable = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
 		goto pgtable_walk;
 	}
 
+	if (!context_present(ctx_entry)) {
+		pr_info("pasid directory table is not present\n");
+		return;
+	}
+
 	/* get the pointer to pasid directory entry */
 	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
-	if (!dir) {
-		pr_info("pasid directory entry is not present\n");
-		return;
-	}
+
 	/* For request-without-pasid, get the pasid from context entry */
 	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
 		pasid = IOMMU_NO_PASID;
@@ -672,7 +678,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	/* get the pointer to the pasid table entry */
 	entries = get_pasid_table_from_pde(pde);
 	if (!entries) {
-		pr_info("pasid table entry is not present\n");
+		pr_info("pasid table is not present\n");
 		return;
 	}
 	index = pasid & PASID_PTE_MASK;
@@ -680,6 +686,11 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
 		pr_info("pasid table entry[%d]: 0x%016llx\n", i, pte->val[i]);
 
+	if (!pasid_pte_is_present(pte)) {
+		pr_info("scalable mode page table is not present\n");
+		return;
+	}
+
 	if (pasid_pte_get_pgtt(pte) == PASID_ENTRY_PGTT_FL_ONLY) {
 		level = pte->val[2] & BIT_ULL(2) ? 5 : 4;
 		pgtable = phys_to_virt(pte->val[2] & VTD_PAGE_MASK);
-- 
2.43.0


