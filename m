Return-Path: <linux-kernel+bounces-444148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC609F0204
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47771188D9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADB2C181;
	Fri, 13 Dec 2024 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSt52rM3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52BB17BA1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052772; cv=none; b=iCFYgJqvR8oYkpy+Jr0w5L02jAlMV/nnkR+KgOALNc2XSn80B0pio7eCjqyucYATeMchrSmbRMuSTaZVFO7kfwsBe4jzfZAtLzbxWVTlm9bsrzE/SADNTfRLo2rtYYVH+pxWlBuC7tY7Yvr7rcZwKnbgnWTfgc8G4sLGslppttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052772; c=relaxed/simple;
	bh=jhoSJv0G7JOBom4scM9bS6XGif5FA4Y6amjcXDcKrok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJaAhgGoJBBhATixRI0LKNodoIhgCLVenx1GqLJT0cYrFbVs9e6RCK48Iw04EIsJUKqwScmW4M+gDs5/f3phkWRmh8KrP+qTz3V1I2mLnaRNH7gabxBOwJ052yTd5TaklNfTsQpxS03ISaLQRwgn38DcKLAdf1QI96CQGr0VdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSt52rM3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734052770; x=1765588770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhoSJv0G7JOBom4scM9bS6XGif5FA4Y6amjcXDcKrok=;
  b=MSt52rM382LKf8UYHPUCJ1aplbAtMB01yPPrriQ6M3SOmIsWH2LbT62N
   a/wn07+1pRJXOdwRwLFnUsGqCU22rKCCAVQ0F8NlfMfWqBVyFilUnzKWJ
   R1Ogv8UezoSM5bXkAzzGIp3yUA3gi4kfeLOPfWoGm7wMC+BdQP9FAugN6
   G2ju8xGDPrpFej28dflWIiB2ABGq1USkE/6MNXouBmfN6yfotkGG0w28V
   9Lzw45D7EOa2PqLlBMUjn1kVIkhg9S3VKLoMxGKe8vOq+12o3eyNcmZy9
   plStRa3rhj27yEIn978qJD4uCRAdtNtGXiZtTslTEuCDeRCaX1TNcJhB/
   Q==;
X-CSE-ConnectionGUID: 8SXgA0HAR0uYTFButOzahA==
X-CSE-MsgGUID: gCWolc/fS7aJ1V6AprbCHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45510010"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45510010"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 17:19:29 -0800
X-CSE-ConnectionGUID: +GzNBlz1T2mZvxJZM/xLyg==
X-CSE-MsgGUID: fFODMDO9TfSO1xIKkCW/vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96835611"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa007.jf.intel.com with ESMTP; 12 Dec 2024 17:19:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/vt-d: Remove cache tags before disabling ATS
Date: Fri, 13 Dec 2024 09:17:50 +0800
Message-ID: <20241213011752.1177061-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
References: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation removes cache tags after disabling ATS,
leading to potential memory leaks and kernel crashes. Specifically,
CACHE_TAG_DEVTLB type cache tags may still remain in the list even
after the domain is freed, causing a use-after-free condition.

This issue really shows up when multiple VFs from different PFs
passed through to a single user-space process via vfio-pci. In such
cases, the kernel may crash with kernel messages like:

 BUG: kernel NULL pointer dereference, address: 0000000000000014
 PGD 19036a067 P4D 1940a3067 PUD 136c9b067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 74 UID: 0 PID: 3183 Comm: testCli Not tainted 6.11.9 #2
 RIP: 0010:cache_tag_flush_range+0x9b/0x250
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x163/0x590
  ? exc_page_fault+0x72/0x190
  ? asm_exc_page_fault+0x22/0x30
  ? cache_tag_flush_range+0x9b/0x250
  ? cache_tag_flush_range+0x5d/0x250
  intel_iommu_tlb_sync+0x29/0x40
  intel_iommu_unmap_pages+0xfe/0x160
  __iommu_unmap+0xd8/0x1a0
  vfio_unmap_unpin+0x182/0x340 [vfio_iommu_type1]
  vfio_remove_dma+0x2a/0xb0 [vfio_iommu_type1]
  vfio_iommu_type1_ioctl+0xafa/0x18e0 [vfio_iommu_type1]

Move cache_tag_unassign_domain() before iommu_disable_pci_caps() to fix
it.

Fixes: 3b1d9e2b2d68 ("iommu/vt-d: Add cache tag assignment interface")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20241129020506.576413-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7d0acb74d5a5..79e0da9eb626 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3220,6 +3220,9 @@ void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
+	if (info->domain)
+		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
+
 	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
@@ -3236,7 +3239,6 @@ void device_block_translation(struct device *dev)
 	list_del(&info->link);
 	spin_unlock_irqrestore(&info->domain->lock, flags);
 
-	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 	domain_detach_iommu(info->domain, iommu);
 	info->domain = NULL;
 }
-- 
2.43.0


