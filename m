Return-Path: <linux-kernel+bounces-237311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA091EF1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA252843F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA911487CC;
	Tue,  2 Jul 2024 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sclzd2Dq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB171474CC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902267; cv=none; b=qGQkm1ZiHB0dEYoS5th/GkiqSTeNEim4u5rP/R55XQs1Clfxn6eD7lSIC5Q0nNKmQIZgqunf2yfF1OX6PeWfHcLJwozdKfaOSVLEsqHIRKsEjmsQ44oA7Jkoc0tPdQnQVauF/QT0eP/yh4eUjKQpbenEArEuyqOLgyDlDcr6CO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902267; c=relaxed/simple;
	bh=dPdzFv08205rJsZbX2ITbLdssatLx9iQwSF9vaAj3+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=td76o6rbGh6sOmk6nwdvhGZkS6PBeg+dy6ZkuB4w3x/fTHydrPvVX1DiOmGg0ZQWh+ZyKdVou3spLDyd+jemks52m1uheCx5bMaNa2dL60SvWJMOnVNGwIkAqKRefNdkAE4gpnA9IHh6JXoQbczTIwUdVRPyOt11Q/uDewlUQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sclzd2Dq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902267; x=1751438267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dPdzFv08205rJsZbX2ITbLdssatLx9iQwSF9vaAj3+Y=;
  b=Sclzd2DqkUWazcu/3x7Dp62p7oRhReASkKFdJ+FfXo7INqKP9A7EsCl3
   W0em+A/USjj2Qcrf9JkHApMj9WOGwUdTiYXk0K7o59S+9VMiVVPIYSVVz
   cKSjBTiijWHyJ+gYfbNLSJVoiSmLhqAkC9pCJ7jRakOUAofFGvMAm+5GY
   ObSPbxRFyD+Q+zYkFbG632yjrZRNWieexSZPnu4RxOqfl6t8Cnr8zU0sk
   fcTGK1otdJLyGIEeXbeU5kE0So/WZm3ZULlqZhSvgQMyo4rdTV0pRH409
   6BgQztfUOaVCRzUCdqCWOBpqj0nB0PlErRt+k/sGbgkCHzrPNDwNvIDBr
   g==;
X-CSE-ConnectionGUID: 5TczVRJwRNOY4VonX6bO5w==
X-CSE-MsgGUID: TyrC/i4aSMyI9NLxV20KKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28455610"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28455610"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:37:46 -0700
X-CSE-ConnectionGUID: j48sfWD0Q9urrdK3mAhPsg==
X-CSE-MsgGUID: 1NAE0M01RbqPfy3TsjBiDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50137185"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2024 23:37:42 -0700
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
Subject: [PATCH v8 04/10] iommu: Extend domain attach group with handle support
Date: Tue,  2 Jul 2024 14:34:38 +0800
Message-Id: <20240702063444.105814-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702063444.105814-1-baolu.lu@linux.intel.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the SVA case where each PASID of a device has an SVA domain
attached to it, the I/O page faults are handled by the fault handler
of the SVA domain. The I/O page faults for a user page table might
be handled by the domain attached to RID or the domain attached to
the PASID, depending on whether the PASID table is managed by user
space or kernel. As a result, there is a need for the domain attach
group interfaces to have attach handle support. The attach handle
will be forwarded to the fault handler of the user domain.

Add some variants of the domain attaching group interfaces so that they
could support the attach handle and export them for use in IOMMUFD.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommu-priv.h |   8 +++
 drivers/iommu/iommu.c      | 103 +++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index f1536a5ebb0d..c37801c32f33 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -31,4 +31,12 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
 struct iommu_attach_handle *iommu_attach_handle_get(struct iommu_group *group,
 						    ioasid_t pasid,
 						    unsigned int type);
+int iommu_attach_group_handle(struct iommu_domain *domain,
+			      struct iommu_group *group,
+			      struct iommu_attach_handle *handle);
+void iommu_detach_group_handle(struct iommu_domain *domain,
+			       struct iommu_group *group);
+int iommu_replace_group_handle(struct iommu_group *group,
+			       struct iommu_domain *new_domain,
+			       struct iommu_attach_handle *handle);
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5a7e874abb36..8484285fbaa8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3478,3 +3478,106 @@ iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int
 	return handle;
 }
 EXPORT_SYMBOL_NS_GPL(iommu_attach_handle_get, IOMMUFD_INTERNAL);
+
+/**
+ * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU group
+ * @domain: IOMMU domain to attach
+ * @group: IOMMU group that will be attached
+ * @handle: attach handle
+ *
+ * Returns 0 on success and error code on failure.
+ *
+ * This is a variant of iommu_attach_group(). It allows the caller to provide
+ * an attach handle and use it when the domain is attached. This is currently
+ * used by IOMMUFD to deliver the I/O page faults.
+ */
+int iommu_attach_group_handle(struct iommu_domain *domain,
+			      struct iommu_group *group,
+			      struct iommu_attach_handle *handle)
+{
+	int ret;
+
+	if (handle)
+		handle->domain = domain;
+
+	mutex_lock(&group->mutex);
+	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	if (ret)
+		goto err_unlock;
+
+	ret = __iommu_attach_group(domain, group);
+	if (ret)
+		goto err_erase;
+	mutex_unlock(&group->mutex);
+
+	return 0;
+err_erase:
+	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+err_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_attach_group_handle, IOMMUFD_INTERNAL);
+
+/**
+ * iommu_detach_group_handle - Detach an IOMMU domain from an IOMMU group
+ * @domain: IOMMU domain to attach
+ * @group: IOMMU group that will be attached
+ *
+ * Detach the specified IOMMU domain from the specified IOMMU group.
+ * It must be used in conjunction with iommu_attach_group_handle().
+ */
+void iommu_detach_group_handle(struct iommu_domain *domain,
+			       struct iommu_group *group)
+{
+	mutex_lock(&group->mutex);
+	__iommu_group_set_core_domain(group);
+	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	mutex_unlock(&group->mutex);
+}
+EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, IOMMUFD_INTERNAL);
+
+/**
+ * iommu_replace_group_handle - replace the domain that a group is attached to
+ * @group: IOMMU group that will be attached to the new domain
+ * @new_domain: new IOMMU domain to replace with
+ * @handle: attach handle
+ *
+ * This is a variant of iommu_group_replace_domain(). It allows the caller to
+ * provide an attach handle for the new domain and use it when the domain is
+ * attached.
+ */
+int iommu_replace_group_handle(struct iommu_group *group,
+			       struct iommu_domain *new_domain,
+			       struct iommu_attach_handle *handle)
+{
+	void *curr;
+	int ret;
+
+	if (!new_domain)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	if (handle) {
+		ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
+		if (ret)
+			goto err_unlock;
+	}
+
+	ret = __iommu_group_set_domain(group, new_domain);
+	if (ret)
+		goto err_release;
+
+	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
+	WARN_ON(xa_is_err(curr));
+
+	mutex_unlock(&group->mutex);
+
+	return 0;
+err_release:
+	xa_release(&group->pasid_array, IOMMU_NO_PASID);
+err_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, IOMMUFD_INTERNAL);
-- 
2.34.1


