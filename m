Return-Path: <linux-kernel+bounces-287959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745FB952E92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F581F21D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA3419AD8E;
	Thu, 15 Aug 2024 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H60ViqEu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCF143888
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726355; cv=none; b=Ggc6pbeYFDBIO9rTSPu1ERLD2fJlgGb4SOpVMImeJqJeBv6RNs+j7IDn5M7ZhEq8cxNunGwe49UEDnIgLtgSqrF4IKcW889nQEhPDl9W7FOaBU5wbpBK85YZfy4h7zmIFeQ6gaVRBMTuPogrBVp8Qan1wvGq3XuC8wN0J1MZS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726355; c=relaxed/simple;
	bh=BrSRR5uvh8cU30zKn+CdjcQa5boqGY1qzsHYzMNtRcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fKgAxGSuCAVjZKqRbr7Jm1zi4ce0mQcPFeo+C7fnn9ah1V1rzHuxLwdSH3J2Nmajb0eKIeGUhZBCSy83SSpsmAIhJlmyvLrst0bU3rQereOb/oP7ghWNYWIE568XkoYJ+tA8k9EoxmTJ2TTpbfyUB2fHlHClcQ+ptYcrkvPyJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H60ViqEu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723726355; x=1755262355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BrSRR5uvh8cU30zKn+CdjcQa5boqGY1qzsHYzMNtRcc=;
  b=H60ViqEu0Bg1p2qHP7t9rfn9s2avf1y3oG+iPGk7Nd4CLm+IE1G/3yDR
   wACo+IOEVPei9olyGtpP9nIIUahS9r8xFFbGFFhsT7q9Q1o15+y3M74MC
   rpO5svtZM0gSsNCIp8reka+Z2CmKgYQHz6nh3qN5J3Uxcsvar/SLWc2Lz
   YYTJ9ZTw6ldsRI9awEhqHhZcQEBsG3VRYOz4EbG5iI9eLFANwpVoZW1IK
   YDIFPdr9w2BMIsq0e5A1hygHiVW2VUZLyHqwJTnusRntR735MhRXK9vaN
   8ujC1Ivj6vnHxL5AQ19aRp0DaOfa2Yym51dkvR2G0bqz7yTzv6q4hJoW0
   A==;
X-CSE-ConnectionGUID: u3LrM9l6Rsyq/fXvDv2/Ew==
X-CSE-MsgGUID: Kaokw5qBQV2YLRSc7P/JoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33128570"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="33128570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:52:34 -0700
X-CSE-ConnectionGUID: 9p4ODleiTrC/tUzhBtCqUw==
X-CSE-MsgGUID: FlNkPZEET3+x/835CA25yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59906470"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 05:52:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush helper
Date: Thu, 15 Aug 2024 20:48:57 +0800
Message-Id: <20240815124857.70038-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper intel_context_flush_present() is designed to flush all related
caches when a context entry with the present bit set is modified. It
currently retrieves the domain ID from the context entry and uses it to
flush the IOTLB and context caches. This is incorrect when the context
entry transitions from present to non-present, as the domain ID field is
cleared before calling the helper.

Fix it by passing the domain ID programmed in the context entry before the
change to intel_context_flush_present(). This ensures that the correct
domain ID is used for cache invalidation.

Fixes: f90584f4beb8 ("iommu/vt-d: Add helper to flush caches for context change")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/linux-iommu/20240814162726.5efe1a6e.alex.williamson@redhat.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 2 +-
 drivers/iommu/intel/iommu.c | 8 ++++++--
 drivers/iommu/intel/pasid.c | 7 ++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..a969be2258b1 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1154,7 +1154,7 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 
 void intel_context_flush_present(struct device_domain_info *info,
 				 struct context_entry *context,
-				 bool affect_domains);
+				 u16 did, bool affect_domains);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..4aa070cf56e7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1944,6 +1944,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 {
 	struct intel_iommu *iommu = info->iommu;
 	struct context_entry *context;
+	u16 did;
 
 	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
@@ -1952,10 +1953,11 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 		return;
 	}
 
+	did = context_domain_id(context);
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, true);
+	intel_context_flush_present(info, context, did, true);
 }
 
 static int domain_setup_first_level(struct intel_iommu *iommu,
@@ -4249,6 +4251,7 @@ static int context_flip_pri(struct device_domain_info *info, bool enable)
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
 	struct context_entry *context;
+	u16 did;
 
 	spin_lock(&iommu->lock);
 	if (context_copied(iommu, bus, devfn)) {
@@ -4261,6 +4264,7 @@ static int context_flip_pri(struct device_domain_info *info, bool enable)
 		spin_unlock(&iommu->lock);
 		return -ENODEV;
 	}
+	did = context_domain_id(context);
 
 	if (enable)
 		context_set_sm_pre(context);
@@ -4269,7 +4273,7 @@ static int context_flip_pri(struct device_domain_info *info, bool enable)
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(context, sizeof(*context));
-	intel_context_flush_present(info, context, true);
+	intel_context_flush_present(info, context, did, true);
 	spin_unlock(&iommu->lock);
 
 	return 0;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5792c817cefa..b51fc268dc84 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -683,6 +683,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct context_entry *context;
+	u16 did;
 
 	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, false);
@@ -691,10 +692,11 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 		return;
 	}
 
+	did = context_domain_id(context);
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, false);
+	intel_context_flush_present(info, context, did, false);
 }
 
 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
@@ -885,10 +887,9 @@ static void __context_flush_dev_iotlb(struct device_domain_info *info)
  */
 void intel_context_flush_present(struct device_domain_info *info,
 				 struct context_entry *context,
-				 bool flush_domains)
+				 u16 did, bool flush_domains)
 {
 	struct intel_iommu *iommu = info->iommu;
-	u16 did = context_domain_id(context);
 	struct pasid_entry *pte;
 	int i;
 
-- 
2.34.1


