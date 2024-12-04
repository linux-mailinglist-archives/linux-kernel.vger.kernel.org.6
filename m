Return-Path: <linux-kernel+bounces-430616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D886A9E3394
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01563B25569
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E169188012;
	Wed,  4 Dec 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBOFHxLQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01A2AEE7;
	Wed,  4 Dec 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294168; cv=none; b=ToAstlz+QTgBnI2xlu204k6zIo8HmdX36uIyErVgPQ/+4borhXzgcryEsUt61P25wNcRkJEUrIC/S3naeVF51hvymGjmttcezIrt9CgmUaMNTj0Xm4XG7HCANDZ/8tmoTuoTawFQv19L7uHtIhRFNbVdBqUzH8tHhKo8vnnuVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294168; c=relaxed/simple;
	bh=WejUnlMmt2Wz3iigCBflEuyeBNo9JwBI3drDTSPn0O8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=IeHNwvWpXJupjvvVTMtk6SDEo7D+QeXnM01BmZCSTkn9jORs/aVuJ8jUbxGpwYjDes82ddppfpl5rsqr59tTAchtZcW/VImETguN7JtmddWjj2CMuuULS1KUHAlFCU14EsZiWxbcldoX9kILjyApMATSS953DmDyJF61wTfCflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBOFHxLQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733294167; x=1764830167;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WejUnlMmt2Wz3iigCBflEuyeBNo9JwBI3drDTSPn0O8=;
  b=BBOFHxLQVW1TcWBwT454Dgxx6kEx5K+aveBOlJffgCVnRxEDhFf5l/BQ
   HcqyNvXF7NS0Kpzu0Lt0MvgazVzGBbxumy9d0kM54F3VHTfQFKeOp0uId
   5Z+BrISyXyzXrb08TJpPhFWpr2xrZUU4/tVb/M/L0ECEV8DdABGykPUVo
   WP8Cfb/I+5d6u35QYwra6pTcHVXsQTWUUesJEtSgT5ByP2CixN39LdO4v
   okTxrkKSvzfQ+MG3HTCoVhq1mevctnkiVcE+3lPhlixYc/PxgILOX3LSp
   wCJBsRJGHiuu266ox0zmr8OHrftNyWSAoIp1kB/jZ2EAoJcl/255Rr4aa
   A==;
X-CSE-ConnectionGUID: bXvXdAP2Ra+MVoVq5CDlbA==
X-CSE-MsgGUID: j1trVTU3QSCys2O4GGeeTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44205892"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44205892"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 22:36:06 -0800
X-CSE-ConnectionGUID: mwNcPt4lRIqW5nllZAmGNA==
X-CSE-MsgGUID: 8X83OMtMQp+a/MI0ffDDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94097099"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa007.jf.intel.com with ESMTP; 03 Dec 2024 22:36:04 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: socfpga: agilex5: Add gpio0 node and spi dma handshake id
Date: Wed,  4 Dec 2024 14:32:54 +0800
Message-Id: <20241204063254.296870-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add gpio0 controller node and correct DMA handshake ID for SPI
tx and rx channels.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 1162978329c1..51c6e19e40b8 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -222,6 +222,26 @@ i3c1: i3c@10da1000 {
 			status = "disabled";
 		};
 
+		gpio0: gpio@ffc03200 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xffc03200 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&rst GPIO0_RESET>;
+			status = "disabled";
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		gpio1: gpio@10c03300 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x10c03300 0x100>;
@@ -314,7 +334,7 @@ spi0: spi@10da4000 {
 			reg-io-width = <4>;
 			num-cs = <4>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>;
-			dmas = <&dmac0 2>, <&dmac0 3>;
+			dmas = <&dmac0 16>, <&dmac0 17>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 
@@ -331,6 +351,8 @@ spi1: spi@10da5000 {
 			reg-io-width = <4>;
 			num-cs = <4>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>;
+			dmas = <&dmac0 20>, <&dmac0 21>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
-- 
2.25.1


