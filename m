Return-Path: <linux-kernel+bounces-275671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2760948838
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD05B22619
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABED1BA88D;
	Tue,  6 Aug 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg+uio2o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E909A59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722917443; cv=none; b=pD64+8bi2aYFA03WdNzv14o1Vkh5R8UA7h4L/NFtnsDa54ZXAkhAkwCCzTCKizr43w3ANrDaDAdAB7Oa6im2AlkDsz5yFImuSUiYpm11CXyjD64VWS3FA7xG24jDLvgKsLE8VqI2ufnd5y4ZiKGGdOWbkgTETvoBnuJhUmmOuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722917443; c=relaxed/simple;
	bh=SPnmSOct1S+IO17hcd9r9Hsb1cuxXerhUYiz4U7zea0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CDJdDCjFIfIwvpKb4EpYWUqu6QNxL8sI64vu5m0NSAj0OQ+zx6r8Pw6RRnjY2LbI8sgZTsUlvEuiHQwGnx73kkjYcG9S7D2/75kDUaAY3LwNNfNqkjnzw7YDKVwRmowaKwdYVp002u5UL2mggVPHWxBdmeaLyhB/9OCHoU24/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qg+uio2o; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722917442; x=1754453442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SPnmSOct1S+IO17hcd9r9Hsb1cuxXerhUYiz4U7zea0=;
  b=Qg+uio2oJYLaLqOvjcexyhxzzYRi1hl5U5XI0zz4W1NBE15tX/72K17q
   E4Hfe5jCpR/LCzzmjyVtT8OWMc9QIIImWg7yHwm8SqQbHp2h6dcpDW+Wt
   p8gC409YrW6pJtXSpakwQUbV1KPF66D39P76UqLSoL3Z3y6qK7XnNeOfl
   3+yZ9ZcL7tit0Wtk/AujR/HE9IVMvHFis1yI0kbgohE256aUfgzfJys+N
   IUHUeSxRDnZwlS+VTS7gLrwAI+AGqdNPTWC3u0y4w3gyxwiivkGY6zbYn
   7UZ5CmWeC4h8ZcGiNdOfCAQFCdJgk36Hi48YA8UkEY/jSI+0vmTvVSKrT
   g==;
X-CSE-ConnectionGUID: LTxbxFygSn2r4KGCxp1QQg==
X-CSE-MsgGUID: gNajvCsBRNe9OeQvgoDVnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31574087"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="31574087"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 21:10:41 -0700
X-CSE-ConnectionGUID: Ex9UJI+RSK6WZm3fGN9X7w==
X-CSE-MsgGUID: c03abkaDSmmvx4vL6tD6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56464538"
Received: from jraag-nuc8i7beh.iind.intel.com ([10.145.169.79])
  by fmviesa010.fm.intel.com with ESMTP; 05 Aug 2024 21:10:36 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	himal.prasad.ghimiray@intel.com,
	francois.dugast@intel.com,
	rodrigo.vivi@intel.com,
	aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] drm/xe/uapi: Bring back reset uevent
Date: Tue,  6 Aug 2024 10:02:31 +0530
Message-Id: <20240806043231.624645-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

Bring back uevent for gt reset failure with better uapi naming.
With this in place we can receive failure event using udev.

$ udevadm monitor --property --kernel
monitor will print the received events for:
KERNEL - the kernel uevent

KERNEL[871.188570] change   /devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:01.0/0000:03:00.0 (pci)
ACTION=change
DEVPATH=/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:01.0/0000:03:00.0
SUBSYSTEM=pci
DEVICE_STATUS=NEEDS_RESET
REASON=GT_RESET_FAILED
TILE_ID=0
GT_ID=0
DRIVER=xe
PCI_CLASS=30000
PCI_ID=8086:56B1
PCI_SUBSYS_ID=8086:1210
PCI_SLOT_NAME=0000:03:00.0
MODALIAS=pci:v00008086d000056B1sv00008086sd00001210bc03sc00i00
SEQNUM=6104

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_gt.c | 27 +++++++++++++++++++++++++--
 include/uapi/drm/xe_drm.h  | 17 +++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index b04e47186f5b..5ceef0059861 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -740,6 +740,30 @@ static int do_gt_restart(struct xe_gt *gt)
 	return 0;
 }
 
+static void xe_uevent_gt_reset_failure(struct pci_dev *pdev, u8 tile_id, u8 gt_id)
+{
+	char *reset_event[5];
+
+	reset_event[0] = DRM_XE_RESET_REQUIRED_UEVENT;
+	reset_event[1] = DRM_XE_RESET_REQUIRED_UEVENT_REASON_GT;
+	reset_event[2] = kasprintf(GFP_KERNEL, "TILE_ID=%d", tile_id);
+	reset_event[3] = kasprintf(GFP_KERNEL, "GT_ID=%d", gt_id);
+	reset_event[4] = NULL;
+	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, reset_event);
+
+	kfree(reset_event[2]);
+	kfree(reset_event[3]);
+}
+
+static void gt_reset_failed(struct xe_gt *gt, int err)
+{
+	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
+
+	/* Notify userspace about gt reset failure */
+	xe_uevent_gt_reset_failure(to_pci_dev(gt_to_xe(gt)->drm.dev),
+				   gt_to_tile(gt)->id, gt->info.id);
+}
+
 static int gt_reset(struct xe_gt *gt)
 {
 	int err;
@@ -795,8 +819,7 @@ static int gt_reset(struct xe_gt *gt)
 	XE_WARN_ON(xe_uc_start(&gt->uc));
 	xe_pm_runtime_put(gt_to_xe(gt));
 err_fail:
-	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
-
+	gt_reset_failed(gt, err);
 	xe_device_declare_wedged(gt_to_xe(gt));
 
 	return err;
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 19619d4952a8..9ea3be97535e 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -20,6 +20,7 @@ extern "C" {
  *   2. Extension definition and helper structs
  *   3. IOCTL's Query structs in the order of the Query's entries.
  *   4. The rest of IOCTL structs in the order of IOCTL declaration.
+ *   5. uEvents
  */
 
 /**
@@ -1686,6 +1687,22 @@ struct drm_xe_oa_stream_info {
 	__u64 reserved[3];
 };
 
+/**
+ * DOC: uevent generated by xe on it's pci node.
+ *
+ * DRM_XE_RESET_REQUIRED_UEVENT - Event is generated when device needs reset.
+ * The REASON is provided along with the event for which reset is required.
+ * On the basis of REASONS, additional information might be supplied.
+ */
+#define DRM_XE_RESET_REQUIRED_UEVENT "DEVICE_STATUS=NEEDS_RESET"
+
+/**
+ * DRM_XE_RESET_REQUIRED_UEVENT_REASON_GT - Reason provided to DRM_XE_RESET_REQUIRED_UEVENT
+ * incase of gt reset failure. The additional information supplied is tile id and
+ * gt id of the gt unit for which reset has failed.
+ */
+#define DRM_XE_RESET_REQUIRED_UEVENT_REASON_GT "REASON=GT_RESET_FAILED"
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1


