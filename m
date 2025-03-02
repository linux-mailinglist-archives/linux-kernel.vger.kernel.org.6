Return-Path: <linux-kernel+bounces-540560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE12A4B234
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1F33A1F04
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024301E9B36;
	Sun,  2 Mar 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kILuXNbV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214C1E7C27
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740925303; cv=none; b=vCTbOGurl+btjC51BeXAsKw4Qgs/vXgTX/sh+CCP1fb1J7ImRGEDgEcwgmf3F/6I6a/tlAxi6ewjT14aA7jyA+/zdZoSSlBXe6MKcaLWOXI3J3d2iP4gK4t5QMHaSh3btcRGTcwa2DRMWBofIUPjPCOEwHAzRn6BLmzfMx4Vgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740925303; c=relaxed/simple;
	bh=rjKY1l/SEQEYfQRD5GQW4b/ZP8WwEI3BeQdcMqQ/5zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rknxk2GHeJmEqNYrnqDG/Kwk1kZLBsrLwVU/3e2MYgQx0EC+i7VscXl1HAtpr9lilWEzLXCpqaH+Ms8ccNKT2iMmSn9579L5bJ339trmZowM1nXwdgBOwqdi619POJ3qxsa4iFKIuf9DDwgsOlFI9gtR7Yi9F/dNCQ2ULLMBIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kILuXNbV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740925302; x=1772461302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rjKY1l/SEQEYfQRD5GQW4b/ZP8WwEI3BeQdcMqQ/5zY=;
  b=kILuXNbVbAMi9EXdzbaD1SHyiNu688MmHA+t94CcjDJdult81xY2bzGa
   cRyq0kGotRjWC5oUVB6SSQ3NKnQxoYL874JyZlxfSrEgZau1g5MpbdWTU
   ryuZaLQ1VlJveuPIaZJVcigMT/lctaGThE7Pt5pgxzSChX35X5UjooSxo
   EpbXj7b5fu1xR3ANpmF13I2+qgpVm9fgO7kqapAU+H400KywbM3lcZ1N3
   VoYS5MgE0uBhpIoD1TMCjMwtolULHghKhbtF6OHmts+bs7w3/rrgoCDjp
   GoJjVbw19QbNyDaSoXEz3puPPZHv7YZyDuBxU86Hl5i6FnteupW1w4hco
   w==;
X-CSE-ConnectionGUID: eZSrQzK/QCG0SjeAlaYs6g==
X-CSE-MsgGUID: 53KHN1wjT7Clr0LdYF58hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="67176515"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="67176515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 06:21:42 -0800
X-CSE-ConnectionGUID: F0lrrH2LR3aSZOIBrkpqvQ==
X-CSE-MsgGUID: MrjAYm3+RlKBPEaAyAr+3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="122737475"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 06:21:35 -0800
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
Subject: [PATCH v6 11/11] drm/xe/nvm: add support for access mode
Date: Sun,  2 Mar 2025 16:09:21 +0200
Message-ID: <20250302140921.504304-12-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302140921.504304-1-alexander.usyskin@intel.com>
References: <20250302140921.504304-1-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |  4 +++
 drivers/gpu/drm/xe/xe_heci_gsc.c      |  5 +---
 drivers/gpu/drm/xe/xe_nvm.c           | 37 ++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 5 deletions(-)

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
index 27d11e06a82b..6d7b62724126 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -11,15 +11,12 @@
 #include "xe_device_types.h"
 #include "xe_drv.h"
 #include "xe_heci_gsc.h"
+#include "regs/xe_gsc_regs.h"
 #include "xe_platform_types.h"
 #include "xe_survivability_mode.h"
 
 #define GSC_BAR_LENGTH  0x00000FFC
 
-#define DG1_GSC_HECI2_BASE			0x259000
-#define PVC_GSC_HECI2_BASE			0x285000
-#define DG2_GSC_HECI2_BASE			0x374000
-
 static void heci_gsc_irq_mask(struct irq_data *d)
 {
 	/* generic irq handling */
diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 26de7d4472c8..8aec20bc629a 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -6,8 +6,11 @@
 #include <linux/intel_dg_nvm_aux.h>
 #include <linux/pci.h>
 
+#include "xe_device.h"
 #include "xe_device_types.h"
+#include "xe_mmio.h"
 #include "xe_nvm.h"
+#include "regs/xe_gsc_regs.h"
 #include "xe_sriov.h"
 
 #define GEN12_GUNIT_NVM_BASE 0x00102040
@@ -25,6 +28,38 @@ static void xe_nvm_release_dev(struct device *dev)
 {
 }
 
+static bool xe_nvm_writable_override(struct xe_device *xe)
+{
+	struct xe_gt *gt = xe_root_mmio_gt(xe);
+	resource_size_t base;
+	bool writable_override;
+
+	switch (xe->info.platform) {
+	case XE_BATTLEMAGE:
+		base = DG2_GSC_HECI2_BASE;
+		break;
+	case XE_PVC:
+		base = PVC_GSC_HECI2_BASE;
+		break;
+	case XE_DG2:
+		base = DG2_GSC_HECI2_BASE;
+		break;
+	case XE_DG1:
+		base = DG1_GSC_HECI2_BASE;
+		break;
+	default:
+		drm_err(&xe->drm, "Unknown platform\n");
+		return true;
+	}
+
+	writable_override =
+		!(xe_mmio_read32(&gt->mmio, HECI_FWSTS2(base)) &
+		  HECI_FW_STATUS_2_NVM_ACCESS_MODE);
+	if (writable_override)
+		drm_info(&xe->drm, "NVM access overridden by jumper\n");
+	return writable_override;
+}
+
 void xe_nvm_init(struct xe_device *xe)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
@@ -49,7 +84,7 @@ void xe_nvm_init(struct xe_device *xe)
 
 	nvm = xe->nvm;
 
-	nvm->writeable_override = false;
+	nvm->writable_override = xe_nvm_writable_override(xe);
 	nvm->bar.parent = &pdev->resource[0];
 	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;
 	nvm->bar.end = nvm->bar.start + GEN12_GUNIT_NVM_SIZE - 1;
-- 
2.43.0


