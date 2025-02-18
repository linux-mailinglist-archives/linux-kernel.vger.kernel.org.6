Return-Path: <linux-kernel+bounces-519077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576AAA3979E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C051893FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708222CBD0;
	Tue, 18 Feb 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwqKTFt2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9F235360;
	Tue, 18 Feb 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872102; cv=none; b=Ud67XeTVRCh3h0r7OeMLKuEoLUeCAGnU9gmQY8kcNUiZsyE0mV/jtuHDzQDtQrphVcIG+pa2uBseIRnuvrvrU4KECve8aRwIvcm62NAn1FZcvVG/XA3r/q4ISlBmnpJihcu6JtH2eQMtYVQB0XeMN33gozt83yv6Rbe51+ZSHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872102; c=relaxed/simple;
	bh=o2N1i+HuudpYUzD+SBObuaUBQ9OkUJtfFTP+2nbOm8o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SSG6MwMcS71XMwns/SrZFHQhc+4pUSmOYqB0LTeRJ8oyNMLpBRuPf8DrIW9pja2QaEi53lc9sdbUZbjWGc3RPYVaKPoZ4Bj81528n+D4q6ub6WRCr2gpSXKhh9meo5yCaJWHlnwz4BuQAW6f/KyJW6FC+hRELRUWhYSR+tzyZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwqKTFt2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739872099; x=1771408099;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=o2N1i+HuudpYUzD+SBObuaUBQ9OkUJtfFTP+2nbOm8o=;
  b=MwqKTFt2dEROSHanWuQKOXXqMVD96HpejL5YRQscnFMHpi9xKpZh+Rde
   5Ya8fk8mSX89Wtb0uyz/kgilIqMJqCMsUVhhUds13jG2D7IKmQJ1osTIM
   ZNRqg/VLTQlGqY6PU7gXxiPFvaCC9iNxKAO5WMet+pSZUMD4oNSH4bLA4
   YYXBybSI1Oi7S+4v7ZrnucdbHlT7+xT8s6qNwZiff192W0hgbZ+Y3C6R7
   INfPX1fGBw5KwIIsqOa0HPcnnZONgPovYZF+Dcp+RG45sQXA9OQs8rsmM
   Ksacdv+XtlvEUrH4x61LbcGswpP6jRiMNTviE24ZktJOi3jmS3JoUKrYW
   A==;
X-CSE-ConnectionGUID: Uhp6d1UlQQa+cQEjfVkxZA==
X-CSE-MsgGUID: 1l7MzOE1RDGpiWGex53NIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57965157"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="57965157"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 01:48:19 -0800
X-CSE-ConnectionGUID: 7Mddcl+JSJKmBN79D63KQA==
X-CSE-MsgGUID: rgOVoaQmSqmy/wwSF0tKig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114213743"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa010.jf.intel.com with ESMTP; 18 Feb 2025 01:48:17 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: socfpga: agilex5: add TB daughter board support
Date: Tue, 18 Feb 2025 17:44:34 +0800
Message-Id: <20250218094434.3574060-3-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218094434.3574060-1-niravkumar.l.rabara@intel.com>
References: <20250218094434.3574060-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

The Agilex5 devkit supports a separate TB daughter board.
This board includes a SPI EEPROM and different LED pin configuration
compared to the default daughter board for the Agilex5 devkit.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/boot/dts/intel/Makefile            |  1 +
 .../dts/intel/socfpga_agilex5_socdk_tb.dts    | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tb.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index d39cfb723f5b..4c977b0aaf9b 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_agilex5_socdk.dtb \
+				socfpga_agilex5_socdk_tb.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tb.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tb.dts
new file mode 100644
index 000000000000..3cda73e12f38
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tb.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include "socfpga_agilex5_socdk.dts"
+
+/ {
+	model = "SoCFPGA Agilex5 SoCDK - TB";
+	compatible = "intel,socfpga-agilex5-socdk-tb", "intel,socfpga-agilex5";
+
+	leds {
+		led-0 {
+			label = "hps_led0";
+			gpios = <&portb 12 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&spi0 {
+	status = "okay";
+
+	spidev@0{
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
-- 
2.25.1


