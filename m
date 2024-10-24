Return-Path: <linux-kernel+bounces-379565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFB9AE08B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70C71C223BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DEC1B21B6;
	Thu, 24 Oct 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxjbF6Bn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17C1AF0D6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761903; cv=none; b=Fz3bR3hb3UTMlIsnpEUKvn+PDAAWXp0gQe6c2YcfpsO97BlBwtfWtVrHJffzJpd/xh/gJ5XjeEpVbwIpC6Ja6x3HXLU7uKCKd18AHkcyEduGD5EEvlkD5oQ1bjG3+WorM6qG+20yaQMR7RxtxZcbq+kfJOh7vBjMUhvPk7vkuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761903; c=relaxed/simple;
	bh=T+u/g1HFWDF9jOvjp+9R4OeCqsrKfvx1zOARwCDWovg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUYPlfbO8crV9rLhevaKNKoE2FBGdRHCL3LSeUjrhtrZlqzJw+y5DPxwUXsNYBDAXUUKoySZo5RWtRbhU0hbIQesGfNco/zLNohx7Tox11ZBSTKsUyfwYK5Bm1TPSPZ6mvULmgc2tWV5gcVzwkUGlGbCpzMoGvmLWsAuP+e1QlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxjbF6Bn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729761902; x=1761297902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+u/g1HFWDF9jOvjp+9R4OeCqsrKfvx1zOARwCDWovg=;
  b=LxjbF6BnMPs2gcBrHDmnz3nZFi9ZQ8aY9E8oYzWaRBc7WIjV4Tf9947c
   xToEhd7AarkO7A/2JCCQ3el08cAL6u6Qj8MD/MkLENPvVY8DTMq5zmpAm
   dTTmcg5er+f1qDrLHPcaaqGvc7xi1AXZNxJx3ouYDan67PDhx96y8KqB1
   zGyavOE1qgT+R5N0khbMmB6I+67jmJOhuogHADTSoaontq2wm0medfhM+
   DYfGoTVjcdn+ugkO4RbCOxsVsgCh9D/YTpUnfcRSsdA10d1BZyqCLYhdH
   AAmzDOISDqejKEnSHkOzkaDZSeO1Hc4noQuHTEnlgwcjZdnXA2Dt+Wn+9
   Q==;
X-CSE-ConnectionGUID: gj3a0RsHRq+EZHLNxCQRfA==
X-CSE-MsgGUID: 4dT88iwlSluDHE8iGoiBRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40501260"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40501260"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:25:02 -0700
X-CSE-ConnectionGUID: g0mGFH/CT2y7nTUz5tE6FQ==
X-CSE-MsgGUID: nEW14SRsRlCzOw3SsJhxtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80705041"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:25:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Kyung Min Park <kyung.min.park@intel.com>
Subject: [PATCH v3 2/2] iommu/vt-d: Fix checks and print in pgtable_walk()
Date: Thu, 24 Oct 2024 17:21:46 +0800
Message-Id: <20241024092146.715063-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024092146.715063-1-zhenzhong.duan@intel.com>
References: <20241024092146.715063-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some issues in pgtable_walk():

1. Super page is dumped as non-present page
2. dma_pte_superpage() should not check against leaf page table entries
3. Pointer pte is never NULL so checking it is meaningless
4. When an entry is not present, it still makes sense to dump the entry
   content.

Fix 1,2 by checking dma_pte_superpage()'s returned value after level check.
Fix 3 by removing pte check.
Fix 4 by checking persent bit after printing.

By this chance, change to print "page table not present" instead of "PTE
not present" to be clearer.

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e7a711a42528..6c9a69a89b81 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -707,14 +707,15 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
 	while (1) {
 		offset = pfn_level_offset(pfn, level);
 		pte = &parent[offset];
-		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
-			pr_info("PTE not present at level %d\n", level);
-			break;
-		}
 
 		pr_info("pte level: %d, pte value: 0x%016llx\n", level, pte->val);
 
-		if (level == 1)
+		if (!dma_pte_present(pte)) {
+			pr_info("page table not present at level %d\n", level - 1);
+			break;
+		}
+
+		if (level == 1 || dma_pte_superpage(pte))
 			break;
 
 		parent = phys_to_virt(dma_pte_addr(pte));
-- 
2.34.1


