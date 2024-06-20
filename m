Return-Path: <linux-kernel+bounces-222093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF090FCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E4283024
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81B38FA5;
	Thu, 20 Jun 2024 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPXYH5HE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF226AFB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865133; cv=none; b=f4G+ozdh7eH68hSHfdLKV+EiIze317SULYYLLMmvLk0ZQtv5e8rJflaVzA0ynqYXcCiTAmuPcDb0Q4iF+JisQTPcP3YiQxlxAHYuEOVbTwkdKOFSFqYCWh7EFaTm+fAIzOWb8nawUcXqNSMsb4AGDIi1m49wseXlHj8veIVfkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865133; c=relaxed/simple;
	bh=+Wnn24Xlpa6rae18wbizkFcb2MAtnQ/iXJt1icI1Q0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r2CsYMUBtU+LGTLOpyv4g3lr7yeVVaXlWEdbzLEiqRrhLknh3gr/h7B9Yu7GXYCW7EQGiQJHGq6g9p5LZOeHRqpIcYirJMwFs8ntTBpvbJW4LY7CIomit2C4xUHXR1PcFb6u/PPzyZXYPIRfJZqeqGOaE2sXSy+3JyAmkdAlimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPXYH5HE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718865133; x=1750401133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Wnn24Xlpa6rae18wbizkFcb2MAtnQ/iXJt1icI1Q0A=;
  b=MPXYH5HENwPcteHLVYu2ogTCbt0zKP5SFX18kOcJMzR2X5/wp8P5SsD+
   n1z5BoRX0w19UDHFDdthPSwcWthkBMXsgW/Z5K7lH4RCRxLiKNlQ21WiC
   mw3/4QbxYPAnwq2se7wISHDUhDfbdZsL08th3BuUPpBC5gMO8M6DUAum5
   sOJLLRz6pF8ak/DhEjGC0/u/eHLWtJNVR23/atgo5ip4zHxHso+tNQ8Hz
   Zq/kknFihlRjsJ+S8ChyrZ0qKaTrGdyH/aGGZgIkC1wkYhvjPZUbJfaEw
   5KN2a9h7SZVN8RePIHVd09BXnQKoI1c62l2wTs7/rf9qIIEzYrJXUS0ni
   Q==;
X-CSE-ConnectionGUID: MkfVTWuLT8yfs2O40dSuQA==
X-CSE-MsgGUID: hOCsJYGBR5Ok49DIkW/S2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="38334032"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="38334032"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:32:12 -0700
X-CSE-ConnectionGUID: 8xLW16KfRteWdLWvkDkhdw==
X-CSE-MsgGUID: 5cU3Uf+mS5GF7QFugpHoDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42242042"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jun 2024 23:32:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Fix missed device TLB cache tag
Date: Thu, 20 Jun 2024 14:29:40 +0800
Message-Id: <20240620062940.201786-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a domain is attached to a device, the required cache tags are
assigned to the domain so that the related caches can be flushed
whenever it is needed. The device TLB cache tag is created based
on whether the ats_enabled field of the device's iommu data is set.
This creates an ordered dependency between cache tag assignment and
ATS enabling.

The device TLB cache tag would not be created if device's ATS is
enabled after the cache tag assignment. This causes devices with PCI
ATS support to malfunction.

The ATS control is exclusively owned by the iommu driver. Hence, move
cache_tag_assign_domain() after PCI ATS enabling to make sure that the
device TLB cache tag is created for the domain.

Fixes: 3b1d9e2b2d68 ("iommu/vt-d: Add cache tag assignment interface")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Change log:
v2:
- Reverting the order instead of adding unnecessary run-time overhead.

v1:
- https://lore.kernel.org/linux-iommu/20240619015345.182773-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e9811bf2a4e..fd11a080380c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2114,12 +2114,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		return ret;
 
-	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
-	if (ret) {
-		domain_detach_iommu(domain, iommu);
-		return ret;
-	}
-
 	info->domain = domain;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
@@ -2137,15 +2131,21 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	else
 		ret = intel_pasid_setup_second_level(iommu, domain, dev, IOMMU_NO_PASID);
 
-	if (ret) {
-		device_block_translation(dev);
-		return ret;
-	}
+	if (ret)
+		goto out_block_translation;
 
 	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
 		iommu_enable_pci_caps(info);
 
+	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
+	if (ret)
+		goto out_block_translation;
+
 	return 0;
+
+out_block_translation:
+	device_block_translation(dev);
+	return ret;
 }
 
 /**
-- 
2.34.1


