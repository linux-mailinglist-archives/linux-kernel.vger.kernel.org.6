Return-Path: <linux-kernel+bounces-377653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B689AC1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FBA1C251B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FE15B149;
	Wed, 23 Oct 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lw7vBMGT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0815852F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672860; cv=none; b=fROdjAGrN/AbryZmVaz94s+lMr+5dVbTzF31XrYpNbdfJpZri9GwEyARqz5oazdXHcHPE7lCFaaiBDl+mN/qSigSzId8iKucBDDV0lhgBAB4vD5rHFF7FSB4d2x/23GZLUXzt9SPlDigfxfET7GrU6YvHBbh4V/eVAIeaQ8g3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672860; c=relaxed/simple;
	bh=1xgmr/Jdzs7NSnAqqcZTvBWcfjR/pYYOZT4P/xKMir8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3djClaMLMJE5m4930OlfzoTE7qj9Xv0+RcxBZ93bCzCGpdWJolKcMPKlEniQpI4jndGfB1ta7jz8X4vInmTjLX3r0ZxCdLkZGBTdggmMU7icq1X4Orbi5xKC/Gs2jPdhZbg5us1D4t3+rLvIt+FdjN1+wR10bOMvrdV/XqIzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lw7vBMGT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729672858; x=1761208858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xgmr/Jdzs7NSnAqqcZTvBWcfjR/pYYOZT4P/xKMir8=;
  b=lw7vBMGTkB2WQCLvv4q6B2Dxyl7LqLdPZqpppW/g4nC/7LCR3eV+gaEr
   iWFrdYnYxHcmz4jmDrUoDDJDq2A4L8p60JnsVXy/l+8ikkGzy8VN2gH4P
   n0IWVwGgQ9SejCb4U0c4sRH+QGsvkjC7wxp6ripFD91G2tcqUv69DNvk6
   Nq49Z3sYnpM9goAbje9rrG2j5vNiZFexqcn8kIE3dMDEKsHRPTBCeP9iN
   XKw06WwKu4RU7LUFoAvUuyOjdFWIgcK3nUcmBLzd0kBeZYgQMl78xZkyu
   0JBLIgB9hsLo8er2+qOksnmQZpBMsxWRKS61Evhu6yUkgIzCXdrpT6n/R
   A==;
X-CSE-ConnectionGUID: jGQEDmeLTJu26fPubr674Q==
X-CSE-MsgGUID: YA35rlZ7Ta+g+frQIVnAMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="32108934"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="32108934"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:40:57 -0700
X-CSE-ConnectionGUID: Xo0ZdLXFRPq73WgkyBM/jg==
X-CSE-MsgGUID: ioVUBKqnQly74fGxC+pOJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80048668"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:40:55 -0700
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
Subject: [PATCH v2 2/2] iommu/vt-d: Fix checks in pgtable_walk()
Date: Wed, 23 Oct 2024 16:37:15 +0800
Message-Id: <20241023083715.582149-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023083715.582149-1-zhenzhong.duan@intel.com>
References: <20241023083715.582149-1-zhenzhong.duan@intel.com>
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

Fix it by moving the check of super page after (level == 1) check and
removing pte check.

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8288b0ee7a61..fec5cc1147f3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -707,14 +707,14 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
 	while (1) {
 		offset = pfn_level_offset(pfn, level);
 		pte = &parent[offset];
-		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
+		if (!dma_pte_present(pte)) {
 			pr_info("PTE not present at level %d\n", level);
 			break;
 		}
 
 		pr_info("pte level: %d, pte value: 0x%016llx\n", level, pte->val);
 
-		if (level == 1)
+		if (level == 1 || dma_pte_superpage(pte))
 			break;
 
 		parent = phys_to_virt(dma_pte_addr(pte));
-- 
2.34.1


