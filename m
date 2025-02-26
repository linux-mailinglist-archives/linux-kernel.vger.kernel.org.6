Return-Path: <linux-kernel+bounces-533911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9FA46030
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC6A178944
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF4221F13;
	Wed, 26 Feb 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5nSp5cO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33302185B1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575033; cv=none; b=buKJLYh6+vhjbNogCCVUHFjJMKkYPk957L3JhPN7a0J6eXVxWMLKj2un0T3gz7gxqBZpc/D6wuGxaQxP5KmZsiLHT8MuzoSkOJZfAYbYs/GdL0DyguJHW+mWXrB6iLE9ZzWlSMMRff9Cyn3ZwpoDs14/KVft4BW3UcSrzm4ZBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575033; c=relaxed/simple;
	bh=/Yf6hVM7Xux/NN25ntIHgUkjUYUqTJyV8WCqWA7w1LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcpGLyc+z4S0tqb/rOZGeM4bkcnEpIXt+Baks123N8DV/DQWVIndXLQVSHzGXywlJJ1zJ6TzwrV8Fgy6HnPxVOFWTDlD4bC/5btbxsrm2wbXq4xH+KKNnksBkN9EiYCBLnUcBKerKd7PF3kN2SqHwXiQld1WxaqQGC/M0YPIvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5nSp5cO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740575032; x=1772111032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Yf6hVM7Xux/NN25ntIHgUkjUYUqTJyV8WCqWA7w1LU=;
  b=e5nSp5cOxNzObhv/3ibdY0MW5KUuM0G6SYTKPZZX8k00A2erTU+tt5IK
   rmecW99Uzn9apldQbn22iWmaVmgy/PwCdVaxfEevVYi6XK2ZT/ydQQApr
   +idLmY+vOod5LkjiVnZiYnSXaOaVnNioywFXBodD7Ha52xoXWcIrxfXHo
   Dc8txx3/eGjCrV7o46WOjjRy1PLJiFIVfNJ92hU0l1kBRCrYw6EpxgYQR
   Q9OLKbQES6OxWJEzjnxyy+4Lhe/YOZyhUdkiGlb21BV5WrWgPvz+Ia1av
   vhGtLOU6fVhW8s11UNasxfrGV8KRr7NR3XaaziE5TOpwrqO7rNubGibPC
   g==;
X-CSE-ConnectionGUID: +4LI1JNwQEKa+vEpBF58PQ==
X-CSE-MsgGUID: AUqLtGXfRtuDX39m4CZZow==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41341656"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41341656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:03:52 -0800
X-CSE-ConnectionGUID: Y7FqJLXFRHOGA1N4Fh43fw==
X-CSE-MsgGUID: eCaM7MgUS2abxTp/OnfCbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121691025"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 05:03:46 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Karthik Poosa <karthik.poosa@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Oren Weil <oren.jer.weil@intel.com>,
	linux-mtd@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v5 10/11] drm/xe/nvm: add on-die non-volatile memory device
Date: Wed, 26 Feb 2025 14:51:42 +0200
Message-ID: <20250226125143.3791515-11-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226125143.3791515-1-alexander.usyskin@intel.com>
References: <20250226125143.3791515-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable access to internal non-volatile memory on DGFX
with GSC/CSC devices via a child device.
The nvm child device is exposed via auxiliary bus.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   5 ++
 drivers/gpu/drm/xe/xe_device_types.h |   6 ++
 drivers/gpu/drm/xe/xe_nvm.c          | 101 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_nvm.h          |  15 ++++
 drivers/gpu/drm/xe/xe_pci.c          |   6 ++
 6 files changed, 134 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.c
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index ffc836fa8e60..085792d4831a 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -79,6 +79,7 @@ xe-y += xe_bb.o \
 	xe_mmio.o \
 	xe_mocs.o \
 	xe_module.o \
+	xe_nvm.o \
 	xe_oa.o \
 	xe_observation.o \
 	xe_pat.o \
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index c9ab79da3f9f..c40fe480b514 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -52,6 +52,7 @@
 #include "xe_pmu.h"
 #include "xe_pxp.h"
 #include "xe_query.h"
+#include "xe_nvm.h"
 #include "xe_sriov.h"
 #include "xe_tile.h"
 #include "xe_ttm_stolen_mgr.h"
@@ -854,6 +855,8 @@ int xe_device_probe(struct xe_device *xe)
 			return err;
 	}
 
+	xe_nvm_init(xe);
+
 	err = xe_heci_gsc_init(xe);
 	if (err)
 		return err;
@@ -907,6 +910,8 @@ void xe_device_remove(struct xe_device *xe)
 {
 	xe_display_unregister(xe);
 
+	xe_nvm_fini(xe);
+
 	drm_dev_unplug(&xe->drm);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 28d10a1d7b64..a215f72b0ff4 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -35,6 +35,7 @@
 #include "intel_display_device.h"
 #endif
 
+struct intel_dg_nvm_dev;
 struct xe_ggtt;
 struct xe_pat_ops;
 struct xe_pxp;
@@ -302,6 +303,8 @@ struct xe_device {
 		u8 has_device_atomics_on_smem:1;
 		/** @info.has_flat_ccs: Whether flat CCS metadata is used */
 		u8 has_flat_ccs:1;
+		/** @info.has_gsc_nvm: device has gsc non-volatile memory */
+		u8 has_gsc_nvm:1;
 		/** @info.has_heci_cscfi: device has heci cscfi */
 		u8 has_heci_cscfi:1;
 		/** @info.has_heci_gscfi: device has heci gscfi */
@@ -508,6 +511,9 @@ struct xe_device {
 	/** @heci_gsc: graphics security controller */
 	struct xe_heci_gsc heci_gsc;
 
+	/** @nvm: discrete graphics non-volatile memory */
+	struct intel_dg_nvm_dev *nvm;
+
 	/** @oa: oa observation subsystem */
 	struct xe_oa oa;
 
diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
new file mode 100644
index 000000000000..26de7d4472c8
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright(c) 2019-2025, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/intel_dg_nvm_aux.h>
+#include <linux/pci.h>
+
+#include "xe_device_types.h"
+#include "xe_nvm.h"
+#include "xe_sriov.h"
+
+#define GEN12_GUNIT_NVM_BASE 0x00102040
+#define GEN12_GUNIT_NVM_SIZE 0x80
+#define HECI_FW_STATUS_2_NVM_ACCESS_MODE BIT(3)
+
+static const struct intel_dg_nvm_region regions[INTEL_DG_NVM_REGIONS] = {
+	[0] = { .name = "DESCRIPTOR", },
+	[2] = { .name = "GSC", },
+	[11] = { .name = "OptionROM", },
+	[12] = { .name = "DAM", },
+};
+
+static void xe_nvm_release_dev(struct device *dev)
+{
+}
+
+void xe_nvm_init(struct xe_device *xe)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct intel_dg_nvm_dev *nvm;
+	struct auxiliary_device *aux_dev;
+	int ret;
+
+	if (!xe->info.has_gsc_nvm)
+		return;
+
+	/* No access to internal NVM from VFs */
+	if (IS_SRIOV_VF(xe))
+		return;
+
+	/* Nvm pointer should be NULL here */
+	if (WARN_ON(xe->nvm))
+		return;
+
+	xe->nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
+	if (!xe->nvm)
+		return;
+
+	nvm = xe->nvm;
+
+	nvm->writeable_override = false;
+	nvm->bar.parent = &pdev->resource[0];
+	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;
+	nvm->bar.end = nvm->bar.start + GEN12_GUNIT_NVM_SIZE - 1;
+	nvm->bar.flags = IORESOURCE_MEM;
+	nvm->bar.desc = IORES_DESC_NONE;
+	nvm->regions = regions;
+
+	aux_dev = &nvm->aux_dev;
+
+	aux_dev->name = "nvm";
+	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
+		       PCI_DEVID(pdev->bus->number, pdev->devfn);
+	aux_dev->dev.parent = &pdev->dev;
+	aux_dev->dev.release = xe_nvm_release_dev;
+
+	ret = auxiliary_device_init(aux_dev);
+	if (ret) {
+		drm_err(&xe->drm, "xe-nvm aux init failed %d\n", ret);
+		return;
+	}
+
+	ret = auxiliary_device_add(aux_dev);
+	if (ret) {
+		drm_err(&xe->drm, "xe-nvm aux add failed %d\n", ret);
+		auxiliary_device_uninit(aux_dev);
+		return;
+	}
+}
+
+void xe_nvm_fini(struct xe_device *xe)
+{
+	struct intel_dg_nvm_dev *nvm = xe->nvm;
+
+	if (!xe->info.has_gsc_nvm)
+		return;
+
+	/* No access to internal NVM from VFs */
+	if (IS_SRIOV_VF(xe))
+		return;
+
+	/* Nvm pointer should not be NULL here */
+	if (WARN_ON(!nvm))
+		return;
+
+	auxiliary_device_delete(&nvm->aux_dev);
+	auxiliary_device_uninit(&nvm->aux_dev);
+	kfree(nvm);
+	xe->nvm = NULL;
+}
diff --git a/drivers/gpu/drm/xe/xe_nvm.h b/drivers/gpu/drm/xe/xe_nvm.h
new file mode 100644
index 000000000000..5487764c180f
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_nvm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2019-2025 Intel Corporation. All rights reserved.
+ */
+
+#ifndef __XE_NVM_H__
+#define __XE_NVM_H__
+
+struct xe_device;
+
+void xe_nvm_init(struct xe_device *xe);
+
+void xe_nvm_fini(struct xe_device *xe);
+
+#endif
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 8b6658b214be..51a729d1ef98 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -62,6 +62,7 @@ struct xe_device_desc {
 	u8 is_dgfx:1;
 
 	u8 has_display:1;
+	u8 has_gsc_nvm:1;
 	u8 has_heci_gscfi:1;
 	u8 has_heci_cscfi:1;
 	u8 has_llc:1;
@@ -285,6 +286,7 @@ static const struct xe_device_desc dg1_desc = {
 	PLATFORM(DG1),
 	.dma_mask_size = 39,
 	.has_display = true,
+	.has_gsc_nvm = 1,
 	.has_heci_gscfi = 1,
 	.require_force_probe = true,
 };
@@ -296,6 +298,7 @@ static const u16 dg2_g12_ids[] = { INTEL_DG2_G12_IDS(NOP), 0 };
 #define DG2_FEATURES \
 	DGFX_FEATURES, \
 	PLATFORM(DG2), \
+	.has_gsc_nvm = 1, \
 	.has_heci_gscfi = 1, \
 	.subplatforms = (const struct xe_subplatform_desc[]) { \
 		{ XE_SUBPLATFORM_DG2_G10, "G10", dg2_g10_ids }, \
@@ -330,6 +333,7 @@ static const __maybe_unused struct xe_device_desc pvc_desc = {
 	PLATFORM(PVC),
 	.dma_mask_size = 52,
 	.has_display = false,
+	.has_gsc_nvm = 1,
 	.has_heci_gscfi = 1,
 	.max_remote_tiles = 1,
 	.require_force_probe = true,
@@ -356,6 +360,7 @@ static const struct xe_device_desc bmg_desc = {
 	PLATFORM(BATTLEMAGE),
 	.dma_mask_size = 46,
 	.has_display = true,
+	.has_gsc_nvm = 1,
 	.has_heci_cscfi = 1,
 };
 
@@ -631,6 +636,7 @@ static int xe_info_init_early(struct xe_device *xe,
 
 	xe->info.dma_mask_size = desc->dma_mask_size;
 	xe->info.is_dgfx = desc->is_dgfx;
+	xe->info.has_gsc_nvm = desc->has_gsc_nvm;
 	xe->info.has_heci_gscfi = desc->has_heci_gscfi;
 	xe->info.has_heci_cscfi = desc->has_heci_cscfi;
 	xe->info.has_llc = desc->has_llc;
-- 
2.43.0


