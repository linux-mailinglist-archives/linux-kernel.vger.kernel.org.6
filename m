Return-Path: <linux-kernel+bounces-191743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667C8D138C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825671C21C88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0241BC20;
	Tue, 28 May 2024 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFLjRmuW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EC645
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872229; cv=none; b=kWXnAmUL+xofoyGvwCL7vCsQt1FwEJS7tcW3iiNDW28HV3Y4H01BjzmKz7jU4V/a+7XpOeMMis1xUYVGUX2AmS1RfMar9t6NmxQPRudDVMe/vEbW5TBISgSib8tHEiFLtIvqSUWGQvBHlBxRmWI1j9s1eJBZNG5vgZxhCFLipjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872229; c=relaxed/simple;
	bh=ba3iMqZ2mVcpdjFj398KFn5b1Uae31zCbUmpsYwDZxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OICVrVPNl26GOlQ6biWa08H++/tFOr1tA83XzGVQj5o9FH7Tuu145MNAWFyCavr3CHbE2zOt34PCHswz6pmuudrlZK8DlgpfKS9q3RNvGJ4jAZfFeT4it7nvp0h18BHsxROMYr6HO/4116SaS0RjY1FQueNlqHZUAVpil9VjwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFLjRmuW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716872227; x=1748408227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ba3iMqZ2mVcpdjFj398KFn5b1Uae31zCbUmpsYwDZxI=;
  b=fFLjRmuW5eN0hJzXfdZgshSYP5TE73NK9dP4YMpqcZsjNKxPdqotYVcP
   k5BrTmwEl/1flwU1jVSkevbRyAU/F6AT5V/5nzm0VGllFJmyclwAhXyk2
   l1gWKge1d+l5gPWquChqtxxsHxUCxZ3AKbVG1PTI6bjGI9zxwJypnMrp+
   0q/Z5NdyhhDdUzb3LXXSoOn4DkD7h6S4o22wSESNvwHcmOcm5lbZE8ZOS
   80Fbu/5K5rNRCIi/3ItlQxVbjJI2ORgcYyJoyozDNW4N10B9hx7Ue7z1D
   JL326M7a7isKhiirh+oFJ3PEAhD4fZ1xliHP4Q+2NAgpvCcxd00ZVQ3Cj
   w==;
X-CSE-ConnectionGUID: xfefWEZ+RZqze2qaLOZLFw==
X-CSE-MsgGUID: zH+bp8SJToy0QlSpjRPkmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13319867"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13319867"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:57:07 -0700
X-CSE-ConnectionGUID: T6MY8SfYRwK0ifOZ/jp4XQ==
X-CSE-MsgGUID: A2aBLC5SSEqrUGX//ypULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34840002"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 27 May 2024 21:57:05 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
Date: Tue, 28 May 2024 12:54:58 +0800
Message-Id: <20240528045458.81458-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
static.

On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
removal of inline code avoids potential confusion.

Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h     | 8 --------
 drivers/iommu/iommu-sva.c | 6 ++++--
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..5cdd3d41b87b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1527,8 +1527,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
-struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
-					    struct mm_struct *mm);
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1553,12 +1551,6 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 }
 
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
-
-static inline struct iommu_domain *
-iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
-{
-	return NULL;
-}
 #endif /* CONFIG_IOMMU_SVA */
 
 #ifdef CONFIG_IOMMU_IOPF
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 18a35e798b72..25e581299226 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,8 @@
 #include "iommu-priv.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
+static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+						   struct mm_struct *mm);
 
 /* Allocate a PASID for the mm within range (inclusive) */
 static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct device *dev)
@@ -277,8 +279,8 @@ static int iommu_sva_iopf_handler(struct iopf_group *group)
 	return 0;
 }
 
-struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
-					    struct mm_struct *mm)
+static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+						   struct mm_struct *mm)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
-- 
2.34.1


