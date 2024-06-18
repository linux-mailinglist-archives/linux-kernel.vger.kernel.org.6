Return-Path: <linux-kernel+bounces-220128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9480390DCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE1E1F245A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751BC16EB78;
	Tue, 18 Jun 2024 20:03:37 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27916EB4C;
	Tue, 18 Jun 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741017; cv=none; b=iB2Uu7vPqN2PDUaqXBvT52GcrszIOeus/R4oXKSQxO/A4o1ygTHU1csExp1pOgu/tq5R7rWAjEViriQuC2uluI7YEBgtU4Ddp28bze9SHb2gCemT0pmKuCfpuZlDMkl213dzzxRBkbqwaDZGi0Lz6WekCFuvRG/zHNnmj1pkDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741017; c=relaxed/simple;
	bh=m2eB/dMu1og6DWfAWTWpxsH02qyBitrQbzXdWK0qvfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AqVReNbmC5gnSMKU4TiFfutAJ+V1scl9gcJiK/AV2juNj7nVuckQ+2/YrO/EW1kotfzUp3q9epCey1gdQ2UCmId2fzBLaBeevPIxBq664jJhYkJ2qnZw9Z/COxTYBsRyfd7940zDC1/Xk17UjBHvU/VFvziJdNP9U1lK35O776Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1sJf3A-00Cv10-JD;
	Tue, 18 Jun 2024 20:03:28 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice-gw700x: add support for PHY LED's
Date: Tue, 18 Jun 2024 13:02:54 -0700
Message-Id: <20240618200253.1738876-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GW700x SoM has an onboard DP83867 RGMII GbE PHY that drives two
LED's (LED1 and LED2, skipping LED0). Add the appropriate dt bindings to
allow these PHY LED's to be controlled via a netdev trigger.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mm-venice-gw700x.dtsi   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
index de7f67a4ff2a..36803b038cd5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/net/ti-dp83867.h>
 
 / {
@@ -113,6 +114,25 @@ ethphy0: ethernet-phy@0 {
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 			tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 			rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+
+			leds {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				led@1 {
+					reg = <1>;
+					color = <LED_COLOR_ID_AMBER>;
+					function = LED_FUNCTION_LAN;
+					default-state = "keep";
+				};
+
+				led@2 {
+					reg = <2>;
+					color = <LED_COLOR_ID_GREEN>;
+					function = LED_FUNCTION_LAN;
+					default-state = "keep";
+				};
+			};
 		};
 	};
 };
-- 
2.25.1


