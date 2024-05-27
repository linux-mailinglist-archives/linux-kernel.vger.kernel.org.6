Return-Path: <linux-kernel+bounces-190002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8A8CF844
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BDAB21144
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F668C0B;
	Mon, 27 May 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xu19mPZQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8BDDA5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782873; cv=none; b=Iq4lszMNqhO8DsLKIruaBvXzvj51uI8CaxVvp2kbk9ewcJYRZBBs0sXd52c0lSpl8Wkk4Y2ejl6OuU2rLq8Zb2XoS/NE2WEH+Npvr0TGwDRegWTWexS5ux2/rF3I9qelHCSG7Y2+vTKxW7GOhT8zJvGPSis8U/OXViU5FomM0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782873; c=relaxed/simple;
	bh=LS8wZ9NUK/jLPQzP1An5gXUR6Pde7W4oWkfEMwi5Ipk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jC2YXdRTH8dy2lA2cEaHzaXVNhjyLkQW4yTDUukxl/D4QiRCW/nDZEFEBdx3ucg2bhyDMuWiQiIYpljZI39PVO+ixMQhmyXqZ/X467qY+U5Pl2CKoOsEheYuxQrShhrFMf116wSN+aUrF2QJJNY10WHXnRLMolHJpVW6uFmVLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xu19mPZQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716782872; x=1748318872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LS8wZ9NUK/jLPQzP1An5gXUR6Pde7W4oWkfEMwi5Ipk=;
  b=Xu19mPZQPUmLJpBDEqhWdgTA09mzD7RwkzETs6ce42Bh/1sG8NYcpAi7
   NhjFSFks0B6UXlPR/doBAR5Lh1eUiVlvixb2ViObn6zTNd1rMnQPDTy0q
   QWrSPKLRZOMtvc+TCeN82YzhOQ5vjHGFul1wmpb7fLhUPcHRh/kqMfIVl
   o1L2cegQn/cY6mL/iAUxcxfhSIrES8iRwRVV9nCoKGEGS3UraPkKsQbKu
   a0cVuvWDTtrIe/OiB24hJNxGnpslbqcNXw9S9hZz6J2UMJkIGDHDzvPOU
   sk8cLEntN7s649TuYFSPOSp6AoWh9dh8SOLMAXrf1qsb90BPDnV4VqraN
   w==;
X-CSE-ConnectionGUID: TyKrDBgRQKW7fv5i0HRIDA==
X-CSE-MsgGUID: 6NJS6u+iTFCwJb+QpxmwzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13022699"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13022699"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:07:32 -0700
X-CSE-ConnectionGUID: lpY7jq8iRQKFkAjWzFWuFg==
X-CSE-MsgGUID: drBZuryTSBm7GdeBX/FEYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39399888"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 21:07:29 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 02/10] iommu: Remove sva handle list
Date: Mon, 27 May 2024 12:05:09 +0800
Message-Id: <20240527040517.38561-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527040517.38561-1-baolu.lu@linux.intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct sva_iommu represents an association between an SVA domain and
a PASID of a device. It's stored in the iommu group's pasid array and also
tracked by a list in the per-mm data structure. Removes duplicate tracking
of sva_iommu by eliminating the list.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  2 --
 drivers/iommu/iommu-priv.h |  3 +++
 drivers/iommu/iommu-sva.c  | 21 ++++++++++++---------
 drivers/iommu/iommu.c      | 31 +++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b89404acacd6..823fa3bcc2c6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1005,14 +1005,12 @@ struct iommu_attach_handle {
 struct iommu_sva {
 	struct iommu_attach_handle	handle;
 	struct device			*dev;
-	struct list_head		handle_item;
 	refcount_t			users;
 };
 
 struct iommu_mm_data {
 	u32			pasid;
 	struct list_head	sva_domains;
-	struct list_head	sva_handles;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 5f731d994803..f1536a5ebb0d 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -28,4 +28,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
 				 struct notifier_block *nb);
 
+struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
+						    ioasid_t pasid,
+						    unsigned int type);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 0fb923254062..e85f4ccc9dcc 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -41,7 +41,6 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	}
 	iommu_mm->pasid = pasid;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
-	INIT_LIST_HEAD(&iommu_mm->sva_handles);
 	/*
 	 * Make sure the write to mm->iommu_mm is not reordered in front of
 	 * initialization to iommu_mm fields. If it does, readers may see a
@@ -69,11 +68,16 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
  */
 struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *attach_handle;
 	struct iommu_mm_data *iommu_mm;
 	struct iommu_domain *domain;
 	struct iommu_sva *handle;
 	int ret;
 
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
@@ -83,12 +87,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
-		if (handle->dev == dev) {
-			refcount_inc(&handle->users);
-			mutex_unlock(&iommu_sva_lock);
-			return handle;
-		}
+	/* A bond already exists, just take a reference`. */
+	attach_handle = iommu_attach_handle_get(group, iommu_mm->pasid, IOMMU_DOMAIN_SVA);
+	if (!IS_ERR(attach_handle)) {
+		handle = container_of(attach_handle, struct iommu_sva, handle);
+		refcount_inc(&handle->users);
+		mutex_unlock(&iommu_sva_lock);
+		return handle;
 	}
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
@@ -125,7 +130,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 out:
 	refcount_set(&handle->users, 1);
-	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
 	return handle;
@@ -159,7 +163,6 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 		mutex_unlock(&iommu_sva_lock);
 		return;
 	}
-	list_del(&handle->handle_item);
 
 	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index efd281ddfa63..0263814cba6b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3483,3 +3483,34 @@ void iommu_free_global_pasid(ioasid_t pasid)
 	ida_free(&iommu_global_pasid_ida, pasid);
 }
 EXPORT_SYMBOL_GPL(iommu_free_global_pasid);
+
+/**
+ * iommu_attach_handle_get - Return the attach handle
+ * @group: the iommu group that domain was attached to
+ * @pasid: the pasid within the group
+ * @type: matched domain type, 0 for any match
+ *
+ * Return handle or ERR_PTR(-ENOENT) on none, ERR_PTR(-EBUSY) on mismatch.
+ *
+ * Return the attach handle to the caller. The life cycle of an iommu attach
+ * handle is from the time when the domain is attached to the time when the
+ * domain is detached. Callers are required to synchronize the call of
+ * iommu_attach_handle_get() with domain attachment and detachment. The attach
+ * handle can only be used during its life cycle.
+ */
+struct iommu_attach_handle *
+iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type)
+{
+	struct iommu_attach_handle *handle;
+
+	xa_lock(&group->pasid_array);
+	handle = xa_load(&group->pasid_array, pasid);
+	if (!handle)
+		handle = ERR_PTR(-ENOENT);
+	else if (type && handle->domain->type != type)
+		handle = ERR_PTR(-EBUSY);
+	xa_unlock(&group->pasid_array);
+
+	return handle;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
-- 
2.34.1


