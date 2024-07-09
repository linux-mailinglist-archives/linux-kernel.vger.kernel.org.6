Return-Path: <linux-kernel+bounces-245392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF292B1FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CDA28106E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C015252E;
	Tue,  9 Jul 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="aU7JabxT"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21412CD96;
	Tue,  9 Jul 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513347; cv=none; b=LTFT4sW1bl184HcKFhPjjfd1l3jO1kAXsQmN8cEpWYZZsZfA3w+/55g/GHDz945Ir1qz+Tefg2cJpeAS2xYbeMRXUI4PcPaFau3IugAf3Bg/XkBP6PrMVX9KnE/qoMcCliXO3plE5CfTJDUnkVaWuHpb6A0Z4I/C2frBQy9M9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513347; c=relaxed/simple;
	bh=/gYVJD15xFaui6T9JocnKA1r2ooEEcIgwDZnejMpIlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DOMl9yIgwtYFLRjLNmsJ6FIjMQNkX8TFS18EhE4X/tP3wFonyUJe0KFS931dLSZecXbTqiTJ9kDhSPM+cyx89G8NUEbkMv8m+mzlBHLEJP9IxS6e4o2HaWSV0Sh5HsATXJHaOPP1r//JILRys2bq48ZvefZhpHQjni7atBS4Ams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=aU7JabxT; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id 0C6E55FD4B;
	Tue,  9 Jul 2024 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1720512985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MDMf7DvFYCdwJ6yYWc6ATDV2rtt8qlGbjIkB3P1prUA=;
	b=aU7JabxTsf1aK/77OmIldWo1GPgTLA5vNZ2v32VbWnnegBjJxybkGe9FceGO9HlAj28g4w
	Eb7b0Y8qwAYrzEfsX7GRXJyIQ+7C6CBG62hDSFd2fWvGkcl6v+8eJM2OHAoi8dOT3cgKov
	mTn9L82xGi7m+N7npAFIKYaHOnhQNl8=
Received: from frank-u24.. (fttx-pool-217.61.149.221.bambit.de [217.61.149.221])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 082581006CA;
	Tue,  9 Jul 2024 08:16:23 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1] arm64: dts: mediatek: mt7988: add labels for different nodes
Date: Tue,  9 Jul 2024 10:16:13 +0200
Message-ID: <20240709081614.19993-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 86a6b8d6-7d26-42ab-aaf3-d045996a5733

From: Frank Wunderlich <frank-w@public-files.de>

Current devicetree-nodes missing a label which allows to add aproperties
or phandles to them, so add them.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Fixes: 660c230bf302 ("arm64: dts: mediatek: mt7988: add I2C controllers")
Fixes: 09ff2216a035 ("arm64: dts: mediatek: mt7988: add PWM controller")
Fixes: 09346afaba0a ("arm64: dts: mediatek: mt7988: add XHCI controllers")
Fixes: b616b403cbff ("arm64: dts: mediatek: mt7988: add clock controllers")
Fixes: 6c1d134a103f ("arm64: dts: mediatek: Add initial MT7988A and BPI-R4")
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 32 +++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index aa728331e876..9ced005b1595 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -14,28 +14,28 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a73";
 			reg = <0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a73";
 			reg = <0x1>;
 			device_type = "cpu";
 			enable-method = "psci";
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a73";
 			reg = <0x2>;
 			device_type = "cpu";
 			enable-method = "psci";
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a73";
 			reg = <0x3>;
 			device_type = "cpu";
@@ -43,7 +43,7 @@ cpu@3 {
 		};
 	};
 
-	oscillator-40m {
+	system_clk: oscillator-40m {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
 		#clock-cells = <0>;
@@ -86,7 +86,7 @@ infracfg: clock-controller@10001000 {
 			#clock-cells = <1>;
 		};
 
-		clock-controller@1001b000 {
+		topckgen: clock-controller@1001b000 {
 			compatible = "mediatek,mt7988-topckgen", "syscon";
 			reg = <0 0x1001b000 0 0x1000>;
 			#clock-cells = <1>;
@@ -99,13 +99,13 @@ watchdog: watchdog@1001c000 {
 			#reset-cells = <1>;
 		};
 
-		clock-controller@1001e000 {
+		apmixedsys: clock-controller@1001e000 {
 			compatible = "mediatek,mt7988-apmixedsys";
 			reg = <0 0x1001e000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		pwm@10048000 {
+		pwm: pwm@10048000 {
 			compatible = "mediatek,mt7988-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
@@ -124,7 +124,7 @@ pwm@10048000 {
 			status = "disabled";
 		};
 
-		i2c@11003000 {
+		i2c0: i2c@11003000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11003000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
@@ -137,7 +137,7 @@ i2c@11003000 {
 			status = "disabled";
 		};
 
-		i2c@11004000 {
+		i2c1: i2c@11004000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11004000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
@@ -150,7 +150,7 @@ i2c@11004000 {
 			status = "disabled";
 		};
 
-		i2c@11005000 {
+		i2c2: i2c@11005000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11005000 0 0x1000>,
 			      <0 0x10217180 0 0x80>;
@@ -163,7 +163,7 @@ i2c@11005000 {
 			status = "disabled";
 		};
 
-		usb@11190000 {
+		ssusb0: usb@11190000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11190000 0 0x2e00>,
 			      <0 0x11193e00 0 0x0100>;
@@ -177,7 +177,7 @@ usb@11190000 {
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 		};
 
-		usb@11200000 {
+		ssusb1: usb@11200000 {
 			compatible = "mediatek,mt7988-xhci", "mediatek,mtk-xhci";
 			reg = <0 0x11200000 0 0x2e00>,
 			      <0 0x11203e00 0 0x0100>;
@@ -191,21 +191,21 @@ usb@11200000 {
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 		};
 
-		clock-controller@11f40000 {
+		xfi_pll: clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
 			resets = <&watchdog 16>;
 			#clock-cells = <1>;
 		};
 
-		clock-controller@15000000 {
+		ethsys: clock-controller@15000000 {
 			compatible = "mediatek,mt7988-ethsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
-		clock-controller@15031000 {
+		ethwarp: clock-controller@15031000 {
 			compatible = "mediatek,mt7988-ethwarp";
 			reg = <0 0x15031000 0 0x1000>;
 			#clock-cells = <1>;
-- 
2.43.0


