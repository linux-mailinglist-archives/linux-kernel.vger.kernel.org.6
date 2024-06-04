Return-Path: <linux-kernel+bounces-199917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B488FA7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0561C238B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD7B13D295;
	Tue,  4 Jun 2024 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU589C/v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3A13D606
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466042; cv=none; b=JxV2PWF632bNB0ag+jxEVtK4FGX4oimJlNmjBiBKQT1Yr/LWlRVwjuQaouUEbt8AKvReuPKT1wA3BdGLvD+QP7YZF/YOiHfZvRm5YEcDKqpzrlCjyovqOOmhKNFDbVQ8FmY9Q7dAZK2RPTdTog9UjZtsX6DFvbD7I+kQDPEZ9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466042; c=relaxed/simple;
	bh=WX+m07wt3DtPAOjU2K7TAng/knQriugPLDZHnttGpjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvBZSi+bFGeI1lkm42cFUC+F/+FDJg61THprQoG5c2xJ4KE9fhmxAttmrXd/Z0nYxgBe3mc6/zZHRAgfSCQBCeBsiBoWDokO+A7AAk2SYXxxxVUP+/C1NKmbhdWQLXvEmMHsDQ2QGLXlZQagrC6z8FQrRb9C99js1Urbxwm7Xc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU589C/v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466039; x=1749002039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WX+m07wt3DtPAOjU2K7TAng/knQriugPLDZHnttGpjU=;
  b=BU589C/vPAOoNBvrH6WC6U9I2pgPi/J23NzGoZfq/0DuF6GERug4w++U
   eKdMh+8JZbEm0nqrKQ29GdkuGR+fmJJt26m3B/FtZ5FLeP/S+8nvPG4tF
   Wv/VXfGfaAP/tnbLnr/iUoQfNgFVIYeXLeUMeqN2LBvGTeKFiblRMUS3Z
   2KiCMhxuhwc7c9vyopxPzT50lCkj01FMmi1VvYlBXitgVu41wRR2Iyqth
   pkT4otcdDdMMowIqIv7ZovZM95mKSUWhgMKrEXedbd7pe1WcSPXG81ZOf
   6SGbd1MKwXRmN3ngEqi26BMbc5VEndmB6fZxAU0II1m08BNF2IsSMM6p8
   Q==;
X-CSE-ConnectionGUID: nBHNzNsHQlyakN2ojrCNFw==
X-CSE-MsgGUID: 9VFrthX7Q2SUIjB+tzS1eA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384832"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384832"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:53:59 -0700
X-CSE-ConnectionGUID: H2d7q3d/ToWaibEpldtEew==
X-CSE-MsgGUID: e4akGPgXS7ya4weofPLdUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661779"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:53:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 01/22] iommu: Add iommu_user_domain_alloc() interface
Date: Tue,  4 Jun 2024 09:51:13 +0800
Message-Id: <20240604015134.164206-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <909f4abd1097> ("iommu: Add new iommu op to create domains owned
by userspace") added a dedicated iommu op to allocate a user domain.
While IOMMUFD has already made use of this callback, other frameworks
like vfio/type1 and vDPA still use the paging domain allocation interface.

Add a new interface named iommu_user_domain_alloc(), which indicates the
allocation of a domain for device DMA managed by user space driver. All
device passthrough frameworks could use this interface for their domain
allocation.

Although it is expected that all iommu drivers could implement their own
domain_alloc_user ops, most drivers haven't implemented it yet. Rollback
to the paging domain allocation interface if the iommu driver hasn't
implemented this op yet.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  6 ++++++
 drivers/iommu/iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..6648b2415474 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -780,6 +780,7 @@ extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
 extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
+struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
@@ -1086,6 +1087,11 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
 	return NULL;
 }
 
+static inline struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void iommu_domain_free(struct iommu_domain *domain)
 {
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9df7cc75c1bc..f1416892ef8e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2032,6 +2032,48 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
+/**
+ * iommu_user_domain_alloc() - Allocate a user domain
+ * @dev: device for which the domain is allocated
+ * @flags: iommufd_hwpt_alloc_flags defined in uapi/linux/iommufd.h
+ *
+ * Allocate a user domain which will be managed by a userspace driver. Return
+ * allocated domain if successful, or a ERR pointer for failure.
+ */
+struct iommu_domain *iommu_user_domain_alloc(struct device *dev, u32 flags)
+{
+	struct iommu_domain *domain;
+	const struct iommu_ops *ops;
+
+	if (!dev_has_iommu(dev))
+		return ERR_PTR(-ENODEV);
+
+	ops = dev_iommu_ops(dev);
+	if (ops->domain_alloc_user) {
+		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
+		if (IS_ERR(domain))
+			return domain;
+
+		domain->type = IOMMU_DOMAIN_UNMANAGED;
+		domain->owner = ops;
+		domain->pgsize_bitmap = ops->pgsize_bitmap;
+		domain->ops = ops->default_domain_ops;
+
+		return domain;
+	}
+
+	/*
+	 * The iommu driver doesn't support domain_alloc_user callback.
+	 * Rollback to a UNMANAGED paging domain which doesn't support
+	 * the allocation flags.
+	 */
+	if (flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return __iommu_domain_alloc(ops, dev, IOMMU_DOMAIN_UNMANAGED);
+}
+EXPORT_SYMBOL_GPL(iommu_user_domain_alloc);
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain->type == IOMMU_DOMAIN_SVA)
-- 
2.34.1


