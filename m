Return-Path: <linux-kernel+bounces-414431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9509D27E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFBC2845E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D71D0B9E;
	Tue, 19 Nov 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6k26N5U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6081D07BA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025613; cv=none; b=IcbGJeghlLmwswujxd9fw5dsx+rQMH2F7e/0GuCxM90i+rdgHoV7mPcWegBvSx9ikuHzrdGS+GMWADeHR1y6mgYlbnwwC4m1t5aDsgxRTDWxVElXwDchMCi8rxJYEf9yJKX64psT0p46aa57eIk3pXoTqtuQrRMadHnlULXuvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025613; c=relaxed/simple;
	bh=BYrQ6XXN15Q62dp+R+Dj/9YVnt27WFN7NCjPk61qnA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCT2/T9Up0bmraeLgWH8UD98nzxvRsWzmv4BfGns/tXkPZaRI2RtiB/inCCIFJJeAenJ2FyqaZiGjIO/KSAxUxoolYQCMzWK13/LLAg17sg5IqHHAbUnaJtlwKnwBiZI2hRbuArSuvwdWdKQ6IgsmlNxGYqTVabh9HMXTymlxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6k26N5U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732025612; x=1763561612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BYrQ6XXN15Q62dp+R+Dj/9YVnt27WFN7NCjPk61qnA0=;
  b=i6k26N5UZZXc545OiW7lHisujvZ4Ny1fA8JULqtI/KYWSNOMLGMNNJ1R
   HgNo1c4DLGpkN6qcIWcL6mZqeDYZ4fBqSAyA5jNA8HaM1s5oKQi6jmt7S
   BBcYkOFiqUvUstvFjOWy7eW4e/g5WDJeb3pdljQBSo2J9R49FaFYkQRHg
   xSJ5iPH8inj/ioWKX+gSY20bZPdYinTsLu08daPl5P+dWMxZawFzvfAwU
   dHRrMBpOgkfK7Wm9OaLMhWMWXwLc1udqwxV5Z64oitXmZVwYXQzijUz5W
   L4VNbYb6mkQ2Sap51+o8WVoSaCk55QM1YJkq5aI6KilyZN8D8j0YyoCLM
   Q==;
X-CSE-ConnectionGUID: /91xdCd4Q8SkShcjgC+HZg==
X-CSE-MsgGUID: QDVeipO9QayT/2nnLzSt/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="54526881"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="54526881"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 06:13:32 -0800
X-CSE-ConnectionGUID: dN3UQywITJKWaKQzRJI5Dw==
X-CSE-MsgGUID: lwxZA1axRhib0t3bLRRuqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="94398695"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 06:13:27 -0800
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
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Oren Weil <oren.jer.weil@intel.com>,
	linux-mtd@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v3 10/10] drm/xe/nvm: add support for access mode
Date: Tue, 19 Nov 2024 16:01:12 +0200
Message-ID: <20241119140112.790720-11-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119140112.790720-1-alexander.usyskin@intel.com>
References: <20241119140112.790720-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check NVM access mode from GSC FW status registers
and overwrite access status read from SPI descriptor, if needed.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |  4 ++++
 drivers/gpu/drm/xe/xe_heci_gsc.c      |  5 +----
 drivers/gpu/drm/xe/xe_nvm.c           | 32 ++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_gsc_regs.h b/drivers/gpu/drm/xe/regs/xe_gsc_regs.h
index 7702364b65f1..9b66cc972a63 100644
--- a/drivers/gpu/drm/xe/regs/xe_gsc_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gsc_regs.h
@@ -16,6 +16,10 @@
 #define MTL_GSC_HECI1_BASE	0x00116000
 #define MTL_GSC_HECI2_BASE	0x00117000
 
+#define DG1_GSC_HECI2_BASE	0x00259000
+#define PVC_GSC_HECI2_BASE	0x00285000
+#define DG2_GSC_HECI2_BASE	0x00374000
+
 #define HECI_H_CSR(base)	XE_REG((base) + 0x4)
 #define   HECI_H_CSR_IE		REG_BIT(0)
 #define   HECI_H_CSR_IS		REG_BIT(1)
diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index d765bfd3636b..68f8cc5a6064 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -11,14 +11,11 @@
 #include "xe_device_types.h"
 #include "xe_drv.h"
 #include "xe_heci_gsc.h"
+#include "regs/xe_gsc_regs.h"
 #include "xe_platform_types.h"
 
 #define GSC_BAR_LENGTH  0x00000FFC
 
-#define DG1_GSC_HECI2_BASE			0x259000
-#define PVC_GSC_HECI2_BASE			0x285000
-#define DG2_GSC_HECI2_BASE			0x374000
-
 static void heci_gsc_irq_mask(struct irq_data *d)
 {
 	/* generic irq handling */
diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 16383cbc9e1d..4d16fe42315d 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -5,8 +5,11 @@
 
 #include <linux/intel_dg_nvm_aux.h>
 #include <linux/pci.h>
+#include "xe_device.h"
 #include "xe_device_types.h"
+#include "xe_mmio.h"
 #include "xe_nvm.h"
+#include "regs/xe_gsc_regs.h"
 #include "xe_sriov.h"
 
 #define GEN12_GUNIT_NVM_BASE 0x00102040
@@ -24,6 +27,33 @@ static void xe_nvm_release_dev(struct device *dev)
 {
 }
 
+static bool xe_nvm_writeable_override(struct xe_device *xe)
+{
+	struct xe_gt *gt = xe_root_mmio_gt(xe);
+	resource_size_t base;
+	bool writeable_override;
+
+	if (xe->info.platform == XE_BATTLEMAGE) {
+		base = DG2_GSC_HECI2_BASE;
+	} else if (xe->info.platform == XE_PVC) {
+		base = PVC_GSC_HECI2_BASE;
+	} else if (xe->info.platform == XE_DG2) {
+		base = DG2_GSC_HECI2_BASE;
+	} else if (xe->info.platform == XE_DG1) {
+		base = DG1_GSC_HECI2_BASE;
+	} else {
+		drm_err(&xe->drm, "Unknown platform\n");
+		return true;
+	}
+
+	writeable_override =
+		!(xe_mmio_read32(&gt->mmio, HECI_FWSTS2(base)) &
+		  HECI_FW_STATUS_2_NVM_ACCESS_MODE);
+	if (writeable_override)
+		drm_info(&xe->drm, "NVM access overridden by jumper\n");
+	return writeable_override;
+}
+
 void xe_nvm_init(struct xe_device *xe)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
@@ -48,7 +78,7 @@ void xe_nvm_init(struct xe_device *xe)
 
 	nvm = xe->nvm;
 
-	nvm->writeable_override = false;
+	nvm->writeable_override = xe_nvm_writeable_override(xe);
 	nvm->bar.parent = &pdev->resource[0];
 	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;
 	nvm->bar.end = nvm->bar.start + GEN12_GUNIT_NVM_SIZE - 1;
-- 
2.43.0


