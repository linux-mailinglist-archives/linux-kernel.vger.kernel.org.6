Return-Path: <linux-kernel+bounces-379433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F4A9ADE99
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A9DB253E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B441B6D12;
	Thu, 24 Oct 2024 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hD62SLSk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596131B4F2B;
	Thu, 24 Oct 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757478; cv=none; b=t9X5Y6xmOehkm1oSk/RLLX2ZXC6RdSSrnPZEqlO2Qc8/mxpRnmqYVctT9VaS4mU1BksXCEiQgWzUAmaxNJgq9gLSBJjjOYW1+G7lCB4xhExKd5FZWyuYb/NCCLKo7pzg+1HFVoeADrEBMZvurWIfWGP7148zfLtD0ctX4/C+G8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757478; c=relaxed/simple;
	bh=o7cd69LRMbZ7XOw6nRqljbHEMyAv9q4vtNc+OOTiHUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOhRcQaYox9pnnc6GXQ1/5hAEMaGWPXvL4crSMS4xRlmY5uGfHS7sAdgIsKwaVwIWL/MwVzinGhDod1w32sbzVoKrGGSH/pwwJjWlswXL7RaqPy2z5y/mv2/A/mxJ7+Kn4U64MdogF5fMTf/J/3E29O4NkITRfvvl4yyEdJu0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hD62SLSk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757473; x=1761293473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o7cd69LRMbZ7XOw6nRqljbHEMyAv9q4vtNc+OOTiHUc=;
  b=hD62SLSkEeW34U1H1HpIe/r2CmjkFkANd6Bg5CGtXcOeA/u9W4O47XGN
   PehreR4a5uzvX8xF+h5YvfDFggbLWA8uoNPSBr0RkYVesxzocKPuG2EP0
   +KZFvY7nwgKzSJ5LjeGZRnqj75O4mr9o7AXc2bNvOaaI+zQZZNF9LkXLP
   DX4U9P6EA0wE9vgaZG8GgAYPxjzlFbruU2j6vawnVdkuSC9rE3ohETFDR
   txSMFsdD92iW/8EcsWiW5HVq4HnV2j+CUqb6/B+zKDnmZnYNlYh0li2Um
   1KmQLb/etZ8ZWNLp5hjNLza8Sa0dRkJbswpzTnnkWd84uY+7JgUyOpbwu
   Q==;
X-CSE-ConnectionGUID: 33BPIJXlTCS+wdg4R7+njQ==
X-CSE-MsgGUID: LDHStiisSASpYT7AF8IvJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501016"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29501016"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:11:13 -0700
X-CSE-ConnectionGUID: cw8cxnVxRFi/7dGHwIuYXQ==
X-CSE-MsgGUID: j2QqoV3WQ+O4uRvag4t61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80690770"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:09 -0700
From: Even Xu <even.xu@intel.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	corbet@lwn.net
Cc: linux-input@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 07/22] HID: intel-thc-hid: intel-thc: Add THC LTR interfaces
Date: Thu, 24 Oct 2024 16:10:08 +0800
Message-Id: <20241024081023.1468951-8-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241024081023.1468951-1-even.xu@intel.com>
References: <20241024081023.1468951-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xinpeng Sun <xinpeng.sun@intel.com>

THC supports LTR configuration and runtimely mode switching. There
are two LTR modes: Active LTR and Low Power LTR.

THC hardware layer provides APIs for LTR configuration and mode
switching.

Co-developed-by: Even Xu <even.xu@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 114 ++++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   |   3 +
 .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  21 ++++
 3 files changed, 138 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 951279ed7765..d9735a8696ac 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -552,6 +552,120 @@ void thc_set_pio_interrupt_support(struct thc_device *dev, bool supported)
 }
 EXPORT_SYMBOL_NS_GPL(thc_set_pio_interrupt_support, INTEL_THC);
 
+/**
+ * thc_ltr_config - Configure THC Latency Tolerance Reporting(LTR) settings
+ *
+ * @dev: The pointer of THC private device context
+ * @active_ltr_us: active LTR value, unit is us
+ * @lp_ltr_us: low power LTR value, unit is us
+ */
+void thc_ltr_config(struct thc_device *dev, u32 active_ltr_us, u32 lp_ltr_us)
+{
+	u32 active_ltr_scale, lp_ltr_scale, ltr_ctrl, ltr_mask, orig, tmp;
+
+	if (active_ltr_us >= THC_LTR_MIN_VAL_SCALE_3 &&
+	    active_ltr_us < THC_LTR_MAX_VAL_SCALE_3) {
+		active_ltr_scale = THC_LTR_SCALE_3;
+		active_ltr_us = active_ltr_us >> 5;
+	} else if (active_ltr_us >= THC_LTR_MIN_VAL_SCALE_4 &&
+		   active_ltr_us < THC_LTR_MAX_VAL_SCALE_4) {
+		active_ltr_scale = THC_LTR_SCALE_4;
+		active_ltr_us = active_ltr_us >> 10;
+	} else if (active_ltr_us >= THC_LTR_MIN_VAL_SCALE_5 &&
+		   active_ltr_us < THC_LTR_MAX_VAL_SCALE_5) {
+		active_ltr_scale = THC_LTR_SCALE_5;
+		active_ltr_us = active_ltr_us >> 15;
+	} else {
+		active_ltr_scale = THC_LTR_SCALE_2;
+	}
+
+	if (lp_ltr_us >= THC_LTR_MIN_VAL_SCALE_3 &&
+	    lp_ltr_us < THC_LTR_MAX_VAL_SCALE_3) {
+		lp_ltr_scale = THC_LTR_SCALE_3;
+		lp_ltr_us = lp_ltr_us >> 5;
+	} else if (lp_ltr_us >= THC_LTR_MIN_VAL_SCALE_4 &&
+		   lp_ltr_us < THC_LTR_MAX_VAL_SCALE_4) {
+		lp_ltr_scale = THC_LTR_SCALE_4;
+		lp_ltr_us = lp_ltr_us >> 10;
+	} else if (lp_ltr_us >= THC_LTR_MIN_VAL_SCALE_5 &&
+		   lp_ltr_us < THC_LTR_MAX_VAL_SCALE_5) {
+		lp_ltr_scale = THC_LTR_SCALE_5;
+		lp_ltr_us = lp_ltr_us >> 15;
+	} else {
+		lp_ltr_scale = THC_LTR_SCALE_2;
+	}
+
+	regmap_read(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET, &orig);
+	ltr_ctrl = FIELD_PREP(THC_M_CMN_LTR_CTRL_ACT_LTR_VAL, active_ltr_us) |
+		   FIELD_PREP(THC_M_CMN_LTR_CTRL_ACT_LTR_SCALE, active_ltr_scale) |
+		   THC_M_CMN_LTR_CTRL_ACTIVE_LTR_REQ |
+		   THC_M_CMN_LTR_CTRL_ACTIVE_LTR_EN |
+		   FIELD_PREP(THC_M_CMN_LTR_CTRL_LP_LTR_VAL, lp_ltr_us) |
+		   FIELD_PREP(THC_M_CMN_LTR_CTRL_LP_LTR_SCALE, lp_ltr_scale) |
+		   THC_M_CMN_LTR_CTRL_LP_LTR_REQ;
+
+	ltr_mask = THC_M_CMN_LTR_CTRL_ACT_LTR_VAL |
+		   THC_M_CMN_LTR_CTRL_ACT_LTR_SCALE |
+		   THC_M_CMN_LTR_CTRL_ACTIVE_LTR_REQ |
+		   THC_M_CMN_LTR_CTRL_ACTIVE_LTR_EN |
+		   THC_M_CMN_LTR_CTRL_LP_LTR_VAL |
+		   THC_M_CMN_LTR_CTRL_LP_LTR_SCALE |
+		   THC_M_CMN_LTR_CTRL_LP_LTR_REQ |
+		   THC_M_CMN_LTR_CTRL_LP_LTR_EN;
+
+	tmp = orig & ~ltr_mask;
+	tmp |= ltr_ctrl & ltr_mask;
+
+	regmap_write(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET, tmp);
+}
+EXPORT_SYMBOL_NS_GPL(thc_ltr_config, INTEL_THC);
+
+/**
+ * thc_change_ltr_mode - Change THC LTR mode
+ *
+ * @dev: The pointer of THC private device context
+ * @ltr_mode: LTR mode(active or low power)
+ */
+void thc_change_ltr_mode(struct thc_device *dev, u32 ltr_mode)
+{
+	if (ltr_mode == THC_LTR_MODE_ACTIVE) {
+		regmap_write_bits(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET,
+				  THC_M_CMN_LTR_CTRL_LP_LTR_EN, 0);
+		regmap_write_bits(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET,
+				  THC_M_CMN_LTR_CTRL_ACTIVE_LTR_EN,
+				  THC_M_CMN_LTR_CTRL_ACTIVE_LTR_EN);
+		return;
+	}
+
+	regmap_write_bits(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET,
+			  THC_M_CMN_LTR_CTRL_ACTIVE_LTR_EN, 0);
+	regmap_write_bits(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET,
+			  THC_M_CMN_LTR_CTRL_LP_LTR_EN,
+			  THC_M_CMN_LTR_CTRL_LP_LTR_EN);
+}
+EXPORT_SYMBOL_NS_GPL(thc_change_ltr_mode, INTEL_THC);
+
+/**
+ * thc_ltr_unconfig - Unconfigure THC Latency Tolerance Reporting(LTR) settings
+ *
+ * @dev: The pointer of THC private device context
+ */
+void thc_ltr_unconfig(struct thc_device *dev)
+{
+	u32 ltr_ctrl, bits_clear;
+
+	regmap_read(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET, &ltr_ctrl);
+	bits_clear = THC_M_CMN_LTR_CTRL_LP_LTR_EN |
+			THC_M_CMN_LTR_CTRL_ACTIVE_LTR_EN |
+			THC_M_CMN_LTR_CTRL_LP_LTR_REQ |
+			THC_M_CMN_LTR_CTRL_ACTIVE_LTR_REQ;
+
+	ltr_ctrl &= ~bits_clear;
+
+	regmap_write(dev->thc_regmap, THC_M_CMN_LTR_CTRL_OFFSET, ltr_ctrl);
+}
+EXPORT_SYMBOL_NS_GPL(thc_ltr_unconfig, INTEL_THC);
+
 MODULE_AUTHOR("Xinpeng Sun <xinpeng.sun@intel.com>");
 MODULE_AUTHOR("Even Xu <even.xu@intel.com>");
 
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
index f775b972b4f5..c25f2fd57c76 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
@@ -68,5 +68,8 @@ void thc_int_trigger_type_select(struct thc_device *dev, bool edge_trigger);
 void thc_interrupt_enable(struct thc_device *dev, bool int_enable);
 void thc_set_pio_interrupt_support(struct thc_device *dev, bool supported);
 int thc_interrupt_quiesce(const struct thc_device *dev, bool int_quiesce);
+void thc_ltr_config(struct thc_device *dev, u32 active_ltr_us, u32 lp_ltr_us);
+void thc_change_ltr_mode(struct thc_device *dev, u32 ltr_mode);
+void thc_ltr_unconfig(struct thc_device *dev);
 
 #endif /* _INTEL_THC_DEV_H_ */
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
index d4b67b81e954..4a1153022605 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
@@ -653,6 +653,27 @@
 /* Interrupt Quiesce default timeout value */
 #define THC_QUIESCE_EN_TIMEOUT_US		USEC_PER_SEC /* 1s */
 
+/* LTR definition */
+/*
+ * THC uses scale to calcualte final LTR value.
+ * Scale is geometric progression of 2^5 step, starting from 2^0.
+ * For example, THC_LTR_SCALE_2(2) means 2^(5 * 2) = 1024, unit is ns.
+ */
+#define THC_LTR_SCALE_0				0
+#define THC_LTR_SCALE_1				1
+#define THC_LTR_SCALE_2				2
+#define THC_LTR_SCALE_3				3
+#define THC_LTR_SCALE_4				4
+#define THC_LTR_SCALE_5				5
+#define THC_LTR_MODE_ACTIVE			0
+#define THC_LTR_MODE_LP				1
+#define THC_LTR_MIN_VAL_SCALE_3			BIT(10)
+#define THC_LTR_MAX_VAL_SCALE_3			BIT(15)
+#define THC_LTR_MIN_VAL_SCALE_4			BIT(15)
+#define THC_LTR_MAX_VAL_SCALE_4			BIT(20)
+#define THC_LTR_MIN_VAL_SCALE_5			BIT(20)
+#define THC_LTR_MAX_VAL_SCALE_5			BIT(25)
+
 /*
  * THC PIO opcode default value
  * @THC_PIO_OP_SPI_TIC_READ: THC opcode for SPI PIO read
-- 
2.40.1


