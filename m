Return-Path: <linux-kernel+bounces-399981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B69C0758
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F5F1C22484
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD8212F0C;
	Thu,  7 Nov 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tnpduwm1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19618212F0E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986006; cv=none; b=Itm8X8Gk/B5MIk5rmZ9oqZvJCTJ0IzfBA0kAgTGg2nRv52yUD0/6l/ik2uPBq0KNaVkjOysFkO8n2YEv9NiYPD3ApTjiIDQXgHwKxRED1Ra9MGbMb33Nh28hutPAOI/Ex89Omv42OE6MEjeDhtkKHHfDpTV2qxUeiSizQjy8mlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986006; c=relaxed/simple;
	bh=E233I3I6GcoFzPCbkV4ez7ihHSVbpBY2WBZMmgRDhzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQVTOYANtepBH0CWF65gZZ7CAmuNZd0UgxBRtrXHBgCdrc9+tcU8aGcCJol2WiPVW0t0XUZDPDBthDf5Fiqvo02V0fxf54jiMSg/EzgPKFcWk3q05azu0V6sMr5Gixqkfiz1uzlM2psxjqVG0uwbx0K/vgSRIwS2AeMj5zV56YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tnpduwm1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730986005; x=1762522005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E233I3I6GcoFzPCbkV4ez7ihHSVbpBY2WBZMmgRDhzE=;
  b=Tnpduwm1m+WHRv/sBT4H28/UwS7fyNNspxx/tI/nSuIGG/mefZxPDoNf
   EewYmnY39H0Yx6AAKyvotZt93wFub84rrqPSr88kLVR9heJyMZJE66t6N
   lD5Vb8LUQsGPwkpkG0yYc0FjIG8JMCdLRtXDju3Wnh93SBZSbTpXl7Xft
   ax35X7fS4+jwDKN+ZmIP7utu4s6wMU9s4U+A4eYtPmVm2J8wFxbqqunTN
   ofzFZFp4t9ciV7gkOKleZPxlf9w6Lm13uWF89uc1+jXD0A0ITGwYcIy0z
   0K8JW2aynjZEAozckuTXwoid9jLSPnEMqljKfKfygPr5V+JtqdSN8hIBe
   Q==;
X-CSE-ConnectionGUID: dKV2wlyjRPKz+xxY7CNhDg==
X-CSE-MsgGUID: NPJ3CTo5T2+O0FjWsz+QJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34750828"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="34750828"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:26:44 -0800
X-CSE-ConnectionGUID: 2HZJLObbTpywNq8tLRvuWg==
X-CSE-MsgGUID: sN2rS/S+TbiOxKdGuSPL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="89921814"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:26:41 -0800
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
Subject: [PATCH v2 10/10] drm/xe/nvm: add support for access mode
Date: Thu,  7 Nov 2024 15:13:56 +0200
Message-ID: <20241107131356.2796969-11-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107131356.2796969-1-alexander.usyskin@intel.com>
References: <20241107131356.2796969-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check NVM access mode from GSC FW status registers
and overwrite access status read from SPI descriptor, if needed.

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
index 65b2e147c4b9..27734085164e 100644
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
index 787272761e42..3396bec29c97 100644
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


