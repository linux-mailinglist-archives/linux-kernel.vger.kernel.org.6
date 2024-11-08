Return-Path: <linux-kernel+bounces-400909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057579C13E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157B11C22239
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451B117C224;
	Fri,  8 Nov 2024 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/9c1cYi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5A142E7C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032111; cv=none; b=Nvu48iRQiS+Yr7smwiOwGEmOqgz+Zoq0JtC9AEi/lQHeXS6dttiSYyQioaAlY9YvFYHo6pVb/ep/ouuaRSFHw+lMPjpqTza8lX38xXnA1YcRIR6GRdUeChbXUrQrDrk2P06nAW8p1+ehH+sAA7LvPNihcb5Z8/CuCGhPlJnrwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032111; c=relaxed/simple;
	bh=Ad/Uyrw6QTC4tKg0asmcSQrfUTh9tXUBj5y09i8V0hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AinPz69s2RVwPEZMWCmCaT0hkIFAdkZBKWWpR5jt+0EiMQMS0W6TspAdQ3aoBVdhvEzrc9U6bn629NcCs8rzG+F+T2JU+7LFdbStwNAIMonwpORhZ0xuvvt6t6DdYkBTC+fYzIue+z2Pki8kR8cjYKGpuzHVU9jEk5aS+baJLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/9c1cYi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032110; x=1762568110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ad/Uyrw6QTC4tKg0asmcSQrfUTh9tXUBj5y09i8V0hQ=;
  b=Z/9c1cYiMJSKTOwAw7Yn9K4l97o7kzrKI010Ib8Iy+RDZgm8OjC4yOZp
   tgESdgP5+H8v/hs6TH9HtSwcGF9dymW451SdTgxJPNbC+E7eRWfrZ3SlF
   D6ZJ2Fcxhr12cRjvOTR1FKiCbdTueY6IpHE/jfPaG1WfEHnWi4GR8m8Ac
   124usNEncOHxQCrgGON2nH4EZrLZudi9n0j837tXotVmgGAxysnMgp0LR
   3HsUUmzHAxGa5hVRxyAzwDJRzemru7TvBCCYv4i1v5BNv1O32UNOeQwGw
   J57+8t8jb0UCguC56nLwgX17thFqBsdC7eCEf2n9/eBUi/J4id6vpZJ6Y
   A==;
X-CSE-ConnectionGUID: GkmMW6GVSUmmMfdjLFKJXQ==
X-CSE-MsgGUID: NKqeaHmNSrW5Bc6bk0Sxpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007780"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007780"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:09 -0800
X-CSE-ConnectionGUID: +wdbPTMmTn+nw2Xs5hdhAQ==
X-CSE-MsgGUID: Ag5cTilBRBWcIitVZHzGBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213791"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:06 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] iommu/vt-d: Consolidate the struct dev_pasid_info add/remove
Date: Fri,  8 Nov 2024 10:13:56 +0800
Message-ID: <20241108021406.173972-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

The domain_add_dev_pasid() and domain_remove_dev_pasid() are added to
consolidate the adding/removing of the struct dev_pasid_info. Besides,
it includes the cache tag assign/unassign as well.

This also prepares for adding domain replacement for pasid. The
set_dev_pasid callbacks need to deal with the dev_pasid_info for both old
and new domain. These two helpers make the life easier.

intel_iommu_set_dev_pasid() and intel_svm_set_dev_pasid() are updated to
use the helpers.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-6-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 101 +++++++++++++++++++++++-------------
 drivers/iommu/intel/iommu.h |   6 +++
 drivers/iommu/intel/svm.c   |  28 +++-------
 3 files changed, 79 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2d1d208d5125..103b109e23a9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4036,8 +4036,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+void domain_remove_dev_pasid(struct iommu_domain *domain,
+			     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4045,10 +4045,12 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	struct dmar_domain *dmar_domain;
 	unsigned long flags;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	if (!domain)
+		return;
+
+	/* Identity domain has no meta data for pasid. */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
-	}
 
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
@@ -4066,12 +4068,20 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
-	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid,
-				     struct iommu_domain *old)
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *domain)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
+	domain_remove_dev_pasid(domain, dev, pasid);
+}
+
+struct dev_pasid_info *
+domain_add_dev_pasid(struct iommu_domain *domain,
+		     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4080,22 +4090,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret;
 
-	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
-		return -EOPNOTSUPP;
-
-	if (domain->dirty_ops)
-		return -EINVAL;
-
-	if (context_copied(iommu, info->bus, info->devfn))
-		return -EBUSY;
-
-	ret = paging_domain_compatible(domain, dev);
-	if (ret)
-		return ret;
-
 	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
 	if (!dev_pasid)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = domain_attach_iommu(dmar_domain, iommu);
 	if (ret)
@@ -4105,6 +4102,47 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_detach_iommu;
 
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return dev_pasid;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free:
+	kfree(dev_pasid);
+	return ERR_PTR(ret);
+}
+
+static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	int ret;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (domain->dirty_ops)
+		return -EINVAL;
+
+	if (context_copied(iommu, info->bus, info->devfn))
+		return -EBUSY;
+
+	ret = paging_domain_compatible(domain, dev);
+	if (ret)
+		return ret;
+
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
+
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
@@ -4112,24 +4150,17 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
 	if (ret)
-		goto out_unassign_tag;
+		goto out_remove_dev_pasid;
 
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	domain_remove_dev_pasid(old, dev, pasid);
 
 	if (domain->type & __IOMMU_DOMAIN_PAGING)
 		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
-out_unassign_tag:
-	cache_tag_unassign_domain(dmar_domain, dev, pasid);
-out_detach_iommu:
-	domain_detach_iommu(dmar_domain, iommu);
-out_free:
-	kfree(dev_pasid);
+
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b3912633ce25..df0261e03fad 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1228,6 +1228,12 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
 
+struct dev_pasid_info *
+domain_add_dev_pasid(struct iommu_domain *domain,
+		     struct device *dev, ioasid_t pasid);
+void domain_remove_dev_pasid(struct iommu_domain *domain,
+			     struct device *dev, ioasid_t pasid);
+
 int dmar_ir_support(void);
 
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4a2bd65614ad..6c0685ea8466 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -115,43 +115,29 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct dev_pasid_info *dev_pasid;
 	unsigned long sflags;
-	unsigned long flags;
 	int ret = 0;
 
-	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
-	if (!dev_pasid)
-		return -ENOMEM;
-
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
-
-	ret = cache_tag_assign_domain(to_dmar_domain(domain), dev, pasid);
-	if (ret)
-		goto free_dev_pasid;
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
-		goto unassign_tag;
+		goto out_remove_dev_pasid;
 
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	domain_remove_dev_pasid(old, dev, pasid);
 
 	return 0;
 
-unassign_tag:
-	cache_tag_unassign_domain(to_dmar_domain(domain), dev, pasid);
-free_dev_pasid:
-	kfree(dev_pasid);
-
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
 }
 
-- 
2.43.0


