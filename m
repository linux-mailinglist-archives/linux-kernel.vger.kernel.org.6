Return-Path: <linux-kernel+bounces-448904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E19F4707
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05425188F8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9B1E260A;
	Tue, 17 Dec 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="EPWjSnPi"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7591D63DB;
	Tue, 17 Dec 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426782; cv=none; b=rlXsFoAqDlmz/9J92uikmbs4lcIQ8noRDSJIxSZcytfQZ4NGPfmJjwjnYTVfM0brI6y3rHw0yNfv6mdduopLXoLfV8Fc0qf7AdaKFVTnK3c4tb3qQ8b6A9cO3QPZJth9i04I5Vx8GquXc37FRHTE5dkto2gWJwEZLh9nu+4y220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426782; c=relaxed/simple;
	bh=s850yqE2N5fsCrH4Kaz1iuc75QWkzxd06LIfsrlRV8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT38/Y57shyZgjPyurD1kp6yQeU4sNGLvzYXtXvb/8m/9N0sCr1KYRaZzjjoa2FlzHFPe+p05o8aWG+evhPG6zoPSgODECDkc1RuPI/KR2fRdhQaPRoLRAmWxPI3AkTKZF3cckN9aCaAB+/diPIDxXwK5ZmBtbu5btuwHXzZKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=EPWjSnPi; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 8DAE7100827;
	Tue, 17 Dec 2024 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KGrCiIlPUGsJUkmSNeRDBiTzjQ27Y05cIVQuYTCvps=;
	b=EPWjSnPi3iPrRl+MH5kp1dFTlS2UM1hXdHq15HtFngHvIEHLzbwQAmdcyji5ek7cQ3riPJ
	t5kj3jt9aBDQtslWjcQA+dLj8krvazqdyIysM+Kw0dVmd3MS0arZinvLvQkcwcoWyjsgDw
	9DUg3z7vw7Bg5CJVdkixsQ0dGXtYkiI=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id D3FA610030F;
	Tue, 17 Dec 2024 09:12:57 +0000 (UTC)
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
Subject: [PATCH v3 10/22] arm64: dts: mediatek: mt7988: Add pcie nodes
Date: Tue, 17 Dec 2024 10:12:24 +0100
Message-ID: <20241217091238.16032-11-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217091238.16032-1-linux@fw-web.de>
References: <20241217091238.16032-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 52a3750b-10e6-4221-bddd-4d42af3ebb3d

From: Frank Wunderlich <frank-w@public-files.de>

Add pcie controllers for mt7988. Reuse mt7986 compatible.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 152 ++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 209d170bce7f..74c75d5149d7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -373,6 +373,158 @@ mmc0: mmc@11230000 {
 			status = "disabled";
 		};
 
+		pcie@11280000 {
+			compatible = "mediatek,mt7986-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x11280000 0 0x2000>;
+			reg-names = "pcie-mac";
+			linux,pci-domain = <3>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0x00 0x20000000 0x00
+				  0x20000000 0x00 0x00200000>,
+				 <0x82000000 0x00 0x20200000 0x00
+				  0x20200000 0x00 0x07e00000>;
+			clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P2>,
+				 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P2>,
+				 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P2>,
+				 <&infracfg CLK_INFRA_133M_PCIE_CK_P2>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m",
+				      "top_133m";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie2_pins>;
+			status = "disabled";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc2 0>,
+					<0 0 0 2 &pcie_intc2 1>,
+					<0 0 0 3 &pcie_intc2 2>,
+					<0 0 0 4 &pcie_intc2 3>;
+			pcie_intc2: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie@11290000 {
+			compatible = "mediatek,mt7986-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x11290000 0 0x2000>;
+			reg-names = "pcie-mac";
+			linux,pci-domain = <2>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0x00 0x28000000 0x00
+				  0x28000000 0x00 0x00200000>,
+				 <0x82000000 0x00 0x28200000 0x00
+				  0x28200000 0x00 0x07e00000>;
+			clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P3>,
+				 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P3>,
+				 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P3>,
+				 <&infracfg CLK_INFRA_133M_PCIE_CK_P3>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m",
+				      "top_133m";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie3_pins>;
+			status = "disabled";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc3 0>,
+					<0 0 0 2 &pcie_intc3 1>,
+					<0 0 0 3 &pcie_intc3 2>,
+					<0 0 0 4 &pcie_intc3 3>;
+			pcie_intc3: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie@11300000 {
+			compatible = "mediatek,mt7986-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x11300000 0 0x2000>;
+			reg-names = "pcie-mac";
+			linux,pci-domain = <0>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0x00 0x30000000 0x00
+				  0x30000000 0x00 0x00200000>,
+				 <0x82000000 0x00 0x30200000 0x00
+				  0x30200000 0x00 0x07e00000>;
+			clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P0>,
+				 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P0>,
+				 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P0>,
+				 <&infracfg CLK_INFRA_133M_PCIE_CK_P0>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m",
+				      "top_133m";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie0_pins>;
+			status = "disabled";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie@11310000 {
+			compatible = "mediatek,mt7986-pcie",
+				     "mediatek,mt8192-pcie";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			reg = <0 0x11310000 0 0x2000>;
+			reg-names = "pcie-mac";
+			linux,pci-domain = <1>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0x00 0x38000000 0x00
+				  0x38000000 0x00 0x00200000>,
+				 <0x82000000 0x00 0x38200000 0x00
+				  0x38200000 0x00 0x07e00000>;
+			clocks = <&infracfg CLK_INFRA_PCIE_PIPE_P1>,
+				 <&infracfg CLK_INFRA_PCIE_GFMUX_TL_P1>,
+				 <&infracfg CLK_INFRA_PCIE_PERI_26M_CK_P1>,
+				 <&infracfg CLK_INFRA_133M_PCIE_CK_P1>;
+			clock-names = "pl_250m", "tl_26m", "peri_26m",
+				      "top_133m";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pcie1_pins>;
+			status = "disabled";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
 		t-phy@11c50000 {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
-- 
2.43.0


