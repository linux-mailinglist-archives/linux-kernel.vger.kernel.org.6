Return-Path: <linux-kernel+bounces-216140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5EB909BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3770284ABD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2018509A;
	Sun, 16 Jun 2024 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVXLq0yV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D11836C7
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718518495; cv=none; b=JNiQGy0fCciomg39HuAReefwMJD9FMQ4RhqyE0GMnnBaOGuUAPfrtXNNdNH53y2qT41jM+uqNQhQkD+iwd5ea7Z2trIK6QNyNigcJYTWx+wyLdZbdqBye37oOGmMd0zXDliwPA6SBMO+F1JQQuJgWowsuQIhLcOOdK2yojBzPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718518495; c=relaxed/simple;
	bh=d/YRXMccV0MNIXgnqN4N/1O0i4xd54kR9zwbYBZb6po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdaOZ5D4v28v7Imi/756Xn8Qr90JdTy94iJV8blynCQMtrrMwI6fnNwRQqiLB+ahRqJAovsqrTZiYvFRAhxMR3OtXpz1pfPU6k0xUsSUc1gTwE+fPBRqhTK7mJpirK3pfBqsAVHjYZPgZJrWGYNIP8VhRjD340ISUlCnFhBaQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVXLq0yV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718518492; x=1750054492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/YRXMccV0MNIXgnqN4N/1O0i4xd54kR9zwbYBZb6po=;
  b=FVXLq0yVyQvhjdHY8z57BgwPF9OdqVL+rxstUESX7yQQR4pRoS6YptcK
   28yEMRMxRtktWQ79hVEXudx8XAG6Dq11IqjSBBHBaUaqVkEiRBuGv0hY5
   7t+qwubtCFMJsD0ycoHVyKIrR2Eo32N7YQAcMseTRUM0DozsHFarCVWVw
   oJaPdCyC+gT51pXDGGJx5UMGc4TBC3CUGoSebz69QzuiG3UTizG05in79
   g+83Jn6bwbctUC5SKsJkkfcHqxqga87PkM5fK3BDRmPs+eTyKg9ofwrbt
   rgXJmrNM2C6RoSfz/z9+/2oh9EneBMPDZOefyCRLpAdu+Gj3fVZOgaTFf
   w==;
X-CSE-ConnectionGUID: Pa79psxzTQWJjhQLOc3RHA==
X-CSE-MsgGUID: /1T/vxffRay9ROGyPq8Lhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="18290097"
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="18290097"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 23:14:52 -0700
X-CSE-ConnectionGUID: Bf9YnuOsREaQIsMwMhr7Lg==
X-CSE-MsgGUID: oDgFX114TW2o8DxR9t5SPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,241,1712646000"; 
   d="scan'208";a="40748217"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jun 2024 23:14:49 -0700
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
Subject: [PATCH v7 09/10] iommufd/selftest: Add IOPF support for mock device
Date: Sun, 16 Jun 2024 14:11:54 +0800
Message-Id: <20240616061155.169343-10-baolu.lu@linux.intel.com>
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

Extend the selftest mock device to support generating and responding to
an IOPF. Also add an ioctl interface to userspace applications to trigger
the IOPF on the mock device. This would allow userspace applications to
test the IOMMUFD's handling of IOPFs without having to rely on any real
hardware.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  8 ++++
 drivers/iommu/iommufd/selftest.c     | 64 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e854d3f67205..acbbba1c6671 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -22,6 +22,7 @@ enum {
 	IOMMU_TEST_OP_MOCK_DOMAIN_FLAGS,
 	IOMMU_TEST_OP_DIRTY,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
+	IOMMU_TEST_OP_TRIGGER_IOPF,
 };
 
 enum {
@@ -127,6 +128,13 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 iotlb;
 		} check_iotlb;
+		struct {
+			__u32 dev_id;
+			__u32 pasid;
+			__u32 grpid;
+			__u32 perm;
+			__u64 addr;
+		} trigger_iopf;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7a2199470f31..1133f1b2362f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -504,6 +504,8 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
+static struct iopf_queue *mock_iommu_iopf_queue;
+
 static struct iommu_device mock_iommu_device = {
 };
 
@@ -514,6 +516,29 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 	return &mock_iommu_device;
 }
 
+static void mock_domain_page_response(struct device *dev, struct iopf_fault *evt,
+				      struct iommu_page_response *msg)
+{
+}
+
+static int mock_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
+		return -ENODEV;
+
+	return iopf_queue_add_device(mock_iommu_iopf_queue, dev);
+}
+
+static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	if (feat != IOMMU_DEV_FEAT_IOPF || !mock_iommu_iopf_queue)
+		return -ENODEV;
+
+	iopf_queue_remove_device(mock_iommu_iopf_queue, dev);
+
+	return 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -529,6 +554,10 @@ static const struct iommu_ops mock_ops = {
 	.capable = mock_domain_capable,
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
+	.page_response = mock_domain_page_response,
+	.dev_enable_feat = mock_dev_enable_feat,
+	.dev_disable_feat = mock_dev_disable_feat,
+	.user_pasid_table = true,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -1375,6 +1404,31 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	return rc;
 }
 
+static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct iopf_fault event = { };
+	struct iommufd_device *idev;
+
+	idev = iommufd_get_device(ucmd, cmd->trigger_iopf.dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	event.fault.prm.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (cmd->trigger_iopf.pasid != IOMMU_NO_PASID)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = cmd->trigger_iopf.addr;
+	event.fault.prm.pasid = cmd->trigger_iopf.pasid;
+	event.fault.prm.grpid = cmd->trigger_iopf.grpid;
+	event.fault.prm.perm = cmd->trigger_iopf.perm;
+
+	iommu_report_device_fault(idev->dev, &event);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+
+	return 0;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
@@ -1450,6 +1504,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.page_size,
 					  u64_to_user_ptr(cmd->dirty.uptr),
 					  cmd->dirty.flags);
+	case IOMMU_TEST_OP_TRIGGER_IOPF:
+		return iommufd_test_trigger_iopf(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1491,6 +1547,9 @@ int __init iommufd_test_init(void)
 				  &iommufd_mock_bus_type.nb);
 	if (rc)
 		goto err_sysfs;
+
+	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
+
 	return 0;
 
 err_sysfs:
@@ -1506,6 +1565,11 @@ int __init iommufd_test_init(void)
 
 void iommufd_test_exit(void)
 {
+	if (mock_iommu_iopf_queue) {
+		iopf_queue_free(mock_iommu_iopf_queue);
+		mock_iommu_iopf_queue = NULL;
+	}
+
 	iommu_device_sysfs_remove(&mock_iommu_device);
 	iommu_device_unregister_bus(&mock_iommu_device,
 				    &iommufd_mock_bus_type.bus,
-- 
2.34.1


