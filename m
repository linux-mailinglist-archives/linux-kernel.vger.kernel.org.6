Return-Path: <linux-kernel+bounces-577282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F4A71AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A35A1707FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F51F8BBC;
	Wed, 26 Mar 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih6RO7wg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EAA1FF1B3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003490; cv=none; b=ke9D4uQpdDPX+PECA2rQ4DJxCQ5I84imll1EdYNUnngvG3U4OM/WS6QiYd4NhOIIvq/LKQNED9OmnVtcimVqf1h6pL5INt5zlKblyJhYc8sEvWV6fMm1If7gRgtoLbDFVwIhRZA6Y4FMV4IMb1mSz2x4UW6/R4weAEC1dRaMw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003490; c=relaxed/simple;
	bh=jp8JwSIuJk4GFCR3LmfzYuHpnYGRU8UeJvhnzagKb4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6znXnMJ3HgJSgs9HZdqqjw0fa66wDUfildAo74j5HdSM5cIlLMZZ/BRMu2/o/NUsnvIrzXqGNIY2vZMA+EHe2Xvu0HmqrpfRDl5C7xnF7+INCP06HSU2SraktGG7M6PZkOGEo4IqzIlfHU3zKoHfFn8qNJQ+YA0vZVP/hRmSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih6RO7wg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743003489; x=1774539489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jp8JwSIuJk4GFCR3LmfzYuHpnYGRU8UeJvhnzagKb4c=;
  b=Ih6RO7wgUoBMiGvYF7rKuWhLZtyz7g3jWRQheOtHTrTR07nH2/AJ8kdv
   Six539bKC5r2MRLWJwpR1eKCt+48ED4llLmeO7TTl4/nRfJTyF31y+pG5
   9vnLrGIiIgCrz29JUGFzAx3sW1tTnNpcwLa8GnVrVeQLh/sAf+cwa2H8G
   bj0ICtc7TXwoMVVMeWR/3o8OE14xMk6ZGtfuG43u67exuQS523qq5rOht
   76OSoL1BZ0NfmxSbpwOGgremEBwphWRnV3ViVwAZRWelw/Qavr3/nds3Z
   WhfsjmfsTflhDTGe58auWfxGdlgfJc0OMBROBOMsGgZym337Cg0FlHsvn
   w==;
X-CSE-ConnectionGUID: 604ga/nMTvmy9grosG9H9A==
X-CSE-MsgGUID: 9qjSYGwPRae7QTRU87fjGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55665559"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="55665559"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:38:09 -0700
X-CSE-ConnectionGUID: zrc886I+RMKH87rLC9pp5Q==
X-CSE-MsgGUID: IEOOi2U7QWm437nrhRu7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129923538"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:38:03 -0700
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
Subject: [PATCH v7 09/12] drm/i915/nvm: add support for access mode
Date: Wed, 26 Mar 2025 17:26:20 +0200
Message-ID: <20250326152623.3897204-10-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326152623.3897204-1-alexander.usyskin@intel.com>
References: <20250326152623.3897204-1-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/i915/intel_nvm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_nvm.c b/drivers/gpu/drm/i915/intel_nvm.c
index 75d3ebe669ff..dd3999c934a7 100644
--- a/drivers/gpu/drm/i915/intel_nvm.c
+++ b/drivers/gpu/drm/i915/intel_nvm.c
@@ -10,6 +10,7 @@
 #include "intel_nvm.h"
 
 #define GEN12_GUNIT_NVM_SIZE 0x80
+#define HECI_FW_STATUS_2_NVM_ACCESS_MODE BIT(3)
 
 static const struct intel_dg_nvm_region regions[INTEL_DG_NVM_REGIONS] = {
 	[0] = { .name = "DESCRIPTOR", },
@@ -22,6 +23,28 @@ static void i915_nvm_release_dev(struct device *dev)
 {
 }
 
+static bool i915_nvm_writable_override(struct drm_i915_private *i915)
+{
+	resource_size_t base;
+	bool writable_override;
+
+	if (IS_DG1(i915)) {
+		base = DG1_GSC_HECI2_BASE;
+	} else if (IS_DG2(i915)) {
+		base = DG2_GSC_HECI2_BASE;
+	} else {
+		drm_err(&i915->drm, "Unknown platform\n");
+		return true;
+	}
+
+	writable_override =
+		!(intel_uncore_read(&i915->uncore, HECI_FWSTS(base, 2)) &
+		  HECI_FW_STATUS_2_NVM_ACCESS_MODE);
+	if (writable_override)
+		drm_info(&i915->drm, "NVM access overridden by jumper\n");
+	return writable_override;
+}
+
 void intel_nvm_init(struct drm_i915_private *i915)
 {
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
@@ -43,7 +66,7 @@ void intel_nvm_init(struct drm_i915_private *i915)
 
 	nvm = i915->nvm;
 
-	nvm->writeable_override = true;
+	nvm->writable_override = i915_nvm_writable_override(i915);
 	nvm->bar.parent = &pdev->resource[0];
 	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;
 	nvm->bar.end = nvm->bar.start + GEN12_GUNIT_NVM_SIZE - 1;
-- 
2.43.0


