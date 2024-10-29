Return-Path: <linux-kernel+bounces-386693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 565079B470C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA605B22893
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6677204F8D;
	Tue, 29 Oct 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="rgXTN+tw"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DC204934;
	Tue, 29 Oct 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198395; cv=none; b=eRnRCwgw/sQP/leYB1JUHz3vV36waUmnEQynlh3K5rOBj7lVau1IyseyDTwiAzvK/MYwVe7zETZxOgY7zhi9kSlQ8Ob7RD1lTTNh8oqt+LSyyO+xKA3Q36/44IhXafM5UJIv1EhkZvrk1dTpHzkT9aXZVxC8L8Lm5lYCGzTJfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198395; c=relaxed/simple;
	bh=3PsF9HX+Nj3CzyAv9vPoPhY0wMCJvEL3Blh6abO9DYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+oR+pxf28pYxPCxqbpcWS2UFE9w5y7Ay0pjsZ8G3p96DsclVDtTkQlGHO7eGEA7uVstQl6FmNvHm4B/HrrV9df0W4gWysmFJm67iofLVZv42OGUu6Byu4NQR1DmbMtct7aeGAB/UhuGJeWckJw/DChfH3w03a0ShaPEgkSDp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=rgXTN+tw; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id 6089E4051F;
	Tue, 29 Oct 2024 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEn9e3Gmbg9qm+aCkqjz6Xik1WTOU1GWAXvr6sZyRfw=;
	b=rgXTN+tw5vVYbKuWd3PhDQ9ddTNeXR+wn/nFeZXjY1dUiOswiYa+quyZNCwJjJUkmdMLOP
	tPoZxDPErukR3B5bELwZW4DLxz/bddvxu+aJ2t4JUwGbVqguNQeFcLHVLEu+BsnIuuwMKq
	3fvSxMQ0tOvpVB+GbGR3axQDl24wqPs=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id BE91636037C;
	Tue, 29 Oct 2024 10:39:48 +0000 (UTC)
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
Subject: [RFC v1 10/14] arm64: dts: mediatek: mt7988: add lvts node
Date: Tue, 29 Oct 2024 11:39:29 +0100
Message-ID: <20241029103937.45852-11-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 9cfe9d8b-db7c-4981-b57d-3a085ddbeb43

From: Frank Wunderlich <frank-w@public-files.de>

Add Low Voltage Thermal Sensor (LVTS) node for mt7988 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index ed8ce1e6f68b..de9a9ff2edd8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
+#include <dt-bindings/reset/mediatek,mt7988-resets.h>
 
 / {
 	compatible = "mediatek,mt7988a";
@@ -103,6 +104,7 @@ infracfg: clock-controller@10001000 {
 			compatible = "mediatek,mt7988-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		topckgen: clock-controller@1001b000 {
@@ -268,6 +270,17 @@ i2c2: i2c@11005000 {
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
 		ssusb0: usb@11190000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11190000 0 0x2e00>,
-- 
2.43.0


