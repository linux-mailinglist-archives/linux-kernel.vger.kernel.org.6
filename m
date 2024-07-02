Return-Path: <linux-kernel+bounces-237316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF5E91EF2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F003E1F23739
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79712FB39;
	Tue,  2 Jul 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfDRhv8e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E526B14D70E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902286; cv=none; b=EAkd4P+QgY9d3YYY55fmY+6YD5y5m5qRpUt5Il7paWv5mMIhUSYL6Mj24VlvH6zc/Rmi6dpmMbhD8E+tWH08Zh4XUBKJi59ZwHDT6GOdNkfSxNRJn8NVlhi7DKi9+Q70UYG6kobuUBb3iX/QdsNtQEEDZyAU7nvNXaTgyal1A6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902286; c=relaxed/simple;
	bh=UsNgl2+dPtzEBiNUrTHukQdcXrBMGTa4xujfdgev7og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXsuyNYMhOj3lkusfKzjNiWmaZiwKgrOSnPPLJOw5iqnPWGLw0RmzcFze7XjIR7rsMBEFu89Cl1+JotMNHGlTdRclIx+RaE67jHF4awSvMzQZ+mE4gZXPPL616Q4RyuzGeF4kzu4uGcoJDcT6QkHgDzbiIhHeCuUAZwqogvCHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfDRhv8e; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902285; x=1751438285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UsNgl2+dPtzEBiNUrTHukQdcXrBMGTa4xujfdgev7og=;
  b=gfDRhv8efDQZVzXF+KZ70s8kAkPlfontj0wst6nQ5zQiYzOSDFnq4DzE
   DDXIBk1Wn+ubgIyJ04WJWA/zBUZIsrRM9JjhvbGoQHfjiAVH4Z7iO7B1i
   FigboQw3c4JA/A2cOz+SoomTogD7YyXIrF64kXTI1g1s5WHoPD1WLEk8I
   cdtEp3YvZdFlugA6ZfURc0jDz+pjtkRajCj7kkBBDrrJ6VTsBMv3AEBxq
   lo5npGhLFLnrcnx2NpoW37iUZq5mR4NpwXAK1kwTOGACrXlxT3Azfo01Y
   Oz3S0wz5/wqiOHETyd68Dfq5VtoVaMMGbbed8T0kjOyxx4FAmRRQy2W9p
   A==;
X-CSE-ConnectionGUID: JerpwWo5SC228vr0bfWpVQ==
X-CSE-MsgGUID: SfokNartSMifNK51ImFPAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28455686"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28455686"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:38:05 -0700
X-CSE-ConnectionGUID: bAVOC67wTfukMupMlZAbEw==
X-CSE-MsgGUID: n85bgfLaTJ6yPJjfzFdCuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50137307"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2024 23:38:01 -0700
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
Subject: [PATCH v8 09/10] iommufd/selftest: Add IOPF support for mock device
Date: Tue,  2 Jul 2024 14:34:43 +0800
Message-Id: <20240702063444.105814-10-baolu.lu@linux.intel.com>
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

Extend the selftest mock device to support generating and responding to
an IOPF. Also add an ioctl interface to userspace applications to trigger
the IOPF on the mock device. This would allow userspace applications to
test the IOMMUFD's handling of IOPFs without having to rely on any real
hardware.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


