Return-Path: <linux-kernel+bounces-427501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C699E0225
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F5F1666B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023141FECCE;
	Mon,  2 Dec 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="G67mCFeS"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905681FC7C5;
	Mon,  2 Dec 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142376; cv=none; b=C1mkFfSgJGEehkRf6cunzfwDnKw9UPla01CDYi/Mu6ukEWk7hOVmbEszXBBPEL7P2mxLov9pECgFyKYPMZ9n4GphYRMzKmU/XnQXwJ+vTZHfasgDMSPX6TZ9aE7eZFKpCn2nlLubjs6m8PIuB5kmwLA7ZDaEabZWHIvIwOXx9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142376; c=relaxed/simple;
	bh=Pm4c9rc9ZBM6jBPIP7L8dI/2fcwpWS/k/JkkQXkHa2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joxDTLFcl1jT4BW8LzA4ZrLV2KHG2N+1/QOYm2jJpoDW4COebzc7SepNEzTmf43/CCnK6t6+sLVTP//V3CPhqcf1XiX0qb6od6v2AeactYsRqN+U39/JDJGRqygi/MFAVIvSTHCL3yEWWpuvwj2X299n54Du/UrVgAnut7bF7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=G67mCFeS; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id C4D0260435;
	Mon,  2 Dec 2024 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TWzayKwl6vTitRugS2EOw67/+C7PLCqur4K/uzJmtc=;
	b=G67mCFeS2W4Mp8n8AAMMRRfUWEm3Ich2UOZmYqbo8jZIxVJ/L572mlTxdgv0jilrChg5HH
	nNjixBF7XXVZVurpbER9BidyU+GWbaicIdNPZqK0/DS4WCv81I6bCVusNPLmO8qoCOOllb
	VLd0cD9xrqnb/M0MZ1oPR7cRVRuLZKc=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 3F6CE3600C0;
	Mon,  2 Dec 2024 12:26:12 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 04/18] arm64: dts: mediatek: mt7988: add lvts node
Date: Mon,  2 Dec 2024 13:25:45 +0100
Message-ID: <20241202122602.30734-5-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202122602.30734-1-linux@fw-web.de>
References: <20241202122602.30734-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 8b4c00e1-9437-4750-95d9-f1438fe1860c

From: Frank Wunderlich <frank-w@public-files.de>

Add Low Voltage Thermal Sensor (LVTS) node for mt7988 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes:

v2:
squash
- "arm64: dts: mediatek: mt7988: add label for efuse"
- "arm64: dts: mediatek: mt7988: extend efuse node" (drop other efuse subnodes)
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 5e40446cb7b3..f7748a840297 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
+#include <dt-bindings/reset/mediatek,mt7988-resets.h>
 
 / {
 	compatible = "mediatek,mt7988a";
@@ -85,6 +86,7 @@ infracfg: clock-controller@10001000 {
 			compatible = "mediatek,mt7988-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		topckgen: clock-controller@1001b000 {
@@ -250,6 +252,17 @@ i2c@11005000 {
 			status = "disabled";
 		};
 
+		lvts: lvts@1100a000 {
+			compatible = "mediatek,mt7988-lvts-ap";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100a000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_26M_THERM_SYSTEM>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&infracfg MT7988_INFRA_RST1_THERM_CTRL_SWRST>;
+			nvmem-cells = <&lvts_calibration>;
+			nvmem-cell-names = "lvts-calib-data-1";
+		};
+
 		usb@11190000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11190000 0 0x2e00>,
@@ -307,11 +320,15 @@ clock-controller@11f40000 {
 			#clock-cells = <1>;
 		};
 
-		efuse@11f50000 {
+		efuse: efuse@11f50000 {
 			compatible = "mediatek,mt7988-efuse", "mediatek,efuse";
 			reg = <0 0x11f50000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			lvts_calibration: calib@918 {
+				reg = <0x918 0x28>;
+			};
 		};
 
 		clock-controller@15000000 {
-- 
2.43.0


