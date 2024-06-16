Return-Path: <linux-kernel+bounces-216139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FA909BD7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC30B20E21
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2339316F82B;
	Sun, 16 Jun 2024 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMdmXScQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38016F0DA
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518492; cv=none; b=hQU7ixHB/ZzxBu3QZInK5rq9BC/98RobGdToWaIdjnaSjJlF/GCYZr4VgX4z128Nq/Z7zZCRzbhC76nQOPoviSXgDoLCHQNZsPsbMPBeCsNHbDOmkfmkaojvbIogJ9juMrukhl09vJGwANCmP0pvsZ+L0sPPNLIG5v7kH6nk1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518492; c=relaxed/simple;
	bh=ullyzJXBGBDY3bfB9g/2KspzDZ1zS3XRW4ql0xuBS+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFXMSSMhD1hpKmhfABLgFtzpYrKvNyq1JxOEprUsrXTn7wX73ovZ9qBWIOGY0mYNSN/Zm4D7L/7XgttK1Uaqywe3PMKuu2CgrDNJzpjhHozBwsO664ByR6ebEL/+ZbOAloR0R9XZHaiXdHqSW+2zNqvFNDSksKrSg+YG6qV4Mhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMdmXScQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518489; x=1750054489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ullyzJXBGBDY3bfB9g/2KspzDZ1zS3XRW4ql0xuBS+o=;
  b=lMdmXScQxe0kG1VZyoakC+IPjsyEoXXd6EuNqQP0jBBOQfDiAC7i+olY
   7BqfiC0XlxZXMPm9IUxf/RXeLIr7/pePPMvfFHt7OAono9Jbkg6b9cZQT
   3/YElCEXf1bMgXVKdrEdq0pAiDCRwsfviSJu6A1qOaKa6qUCXDb/ogrWx
   WNnepT1KrQUdWTrlku5RtglGJXnpdY2Iim8Um00QnxmkwDlLP2Q1r6YV4
   DclI6m08R9/JzSkTR2BOjgrgH/UI/WHhzrUubrLvCr0/jCz6D2xVs/Q0w
   BjEjdae41kYe/Q6PLRiJOQlpmdUdG2PvQaGolequjMcjKz9Z5BMMbluTP
   A==;
X-CSE-ConnectionGUID: CZI8WurbRAOSZufDkCFJHw==
X-CSE-MsgGUID: piULwzQcScKy07+0H7vkAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18290085"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18290085"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:49 -0700
X-CSE-ConnectionGUID: lVDrcXNzS3C3VKMOn0J8NA==
X-CSE-MsgGUID: UFFmX8WUTbyRYHz73wuDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748206"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:45 -0700
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
Subject: [PATCH v7 08/10] iommufd: Associate fault object with iommufd_hw_pgtable
Date: Sun, 16 Jun 2024 14:11:53 +0800
Message-Id: <20240616061155.169343-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240616061155.169343-1-baolu.lu@linux.intel.com>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating a user iommufd_hw_pagetable, the user space is allowed to
associate a fault object with the hw_pagetable by specifying the fault
object ID in the page table allocation data and setting the
IOMMU_HWPT_FAULT_ID_VALID flag bit.

On a successful return of hwpt allocation, the user can retrieve and
respond to page faults by reading and writing the file interface of the
fault object.

Once a fault object has been associated with a hwpt, the hwpt is
iopf-capable, indicated by hwpt->fault is non NULL. Attaching,
detaching, or replacing an iopf-capable hwpt to an RID or PASID will
differ from those that are not iopf-capable.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  9 ++++++
 include/uapi/linux/iommufd.h            |  8 +++++
 drivers/iommu/iommufd/fault.c           | 17 ++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    | 41 +++++++++++++++++++------
 4 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index aa4c26c87cb9..92efe30a8f0d 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -458,8 +458,17 @@ struct iommufd_attach_handle {
 /* Convert an iommu attach handle to iommufd handle. */
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
+static inline struct iommufd_fault *
+iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_FAULT),
+			    struct iommufd_fault, obj);
+}
+
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
+int iommufd_fault_iopf_handler(struct iopf_group *group);
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 70b8a38fcd46..ede2b464a761 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -357,10 +357,13 @@ struct iommu_vfio_ioas {
  *                                the parent HWPT in a nesting configuration.
  * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
  *                                   enforced on device attachment
+ * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
+ *                             valid.
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
+	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
 };
 
 /**
@@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
  * @data_type: One of enum iommu_hwpt_data_type
  * @data_len: Length of the type specific data
  * @data_uptr: User pointer to the type specific data
+ * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
+ *            IOMMU_HWPT_FAULT_ID_VALID is set.
+ * @__reserved2: Padding to 64-bit alignment. Must be 0.
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
@@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
 	__u32 data_type;
 	__u32 data_len;
 	__aligned_u64 data_uptr;
+	__u32 fault_id;
+	__u32 __reserved2;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 4934ae572638..54d6cd20a673 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -414,3 +414,20 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_fault_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_fault *fault;
+
+	hwpt = group->attach_handle->domain->fault_data;
+	fault = hwpt->fault;
+
+	mutex_lock(&fault->mutex);
+	list_add_tail(&group->node, &fault->deliver);
+	mutex_unlock(&fault->mutex);
+
+	wake_up_interruptible(&fault->wait_queue);
+
+	return 0;
+}
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..14a32bf80549 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,6 +8,15 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->domain)
+		iommu_domain_free(hwpt->domain);
+
+	if (hwpt->fault)
+		iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
+}
+
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hwpt_paging *hwpt_paging =
@@ -22,9 +31,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 					 hwpt_paging->common.domain);
 	}
 
-	if (hwpt_paging->common.domain)
-		iommu_domain_free(hwpt_paging->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_paging->common);
 	refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
@@ -49,9 +56,7 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 	struct iommufd_hwpt_nested *hwpt_nested =
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
-	if (hwpt_nested->common.domain)
-		iommu_domain_free(hwpt_nested->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_nested->common);
 	refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
@@ -213,7 +218,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags || !user_data->len || !ops->domain_alloc_user)
+	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	    !user_data->len || !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent)
 		return ERR_PTR(-EINVAL);
@@ -227,7 +233,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
-	hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+	hwpt->domain = ops->domain_alloc_user(idev->dev,
+					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
 					      parent->common.domain, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
@@ -308,13 +315,29 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
+	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
+		struct iommufd_fault *fault;
+
+		fault = iommufd_get_fault(ucmd, cmd->fault_id);
+		if (IS_ERR(fault)) {
+			rc = PTR_ERR(fault);
+			goto out_hwpt;
+		}
+		hwpt->fault = fault;
+		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
+		hwpt->domain->fault_data = hwpt;
+	}
+
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-		goto out_hwpt;
+		goto out_put_fault;
 	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
 	goto out_unlock;
 
+out_put_fault:
+	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID)
+		iommufd_put_object(ucmd->ictx, &hwpt->fault->obj);
 out_hwpt:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
-- 
2.34.1


