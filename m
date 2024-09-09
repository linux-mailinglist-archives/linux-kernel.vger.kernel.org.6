Return-Path: <linux-kernel+bounces-321255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936A8971679
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13F11C22E30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5C1B9B3C;
	Mon,  9 Sep 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJ/43/e7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE781B9B2F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880692; cv=none; b=qfHQ1sQyO1P9KRajko9bGXSSGgZWBAWqQapIgiDu+gtZckNRVZkCEpYUTW/f/vd8Zun4bhJ/oTzJHE1RiE5XA8o0mlH9+GjQEF2YvyJR6AS/CznF1NDqU1LsRdBFT6yZVruuoyiYcKPYBa4gpUpZXtOMAWssccTkgXZonqSCGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880692; c=relaxed/simple;
	bh=nveov2nZGenrDj2kQ8zJpbaSkGlH2w2MzgCqjd9aH9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK96H+RbrnLaSnPzGsmHwWPngy9zsBnr9Sp98iFfVngGVmTvegvcXmY0cnksDc+TV3EEhxkDwwccLxtwlfCQt3nYi7Wxtuv86dQLZTEjkay0VHGyE9MzofizioYYF1mCyub7CCHcGA9TrbOcX2hLVhCEYKm/rfdZAKgHw+fhqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dJ/43/e7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-205909af9b5so32497265ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880689; x=1726485489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYgAVySTOtFl/MrFCMmK+Fl5uF1KDDdSmV7dSnMl93g=;
        b=dJ/43/e7uaDtv+Dk9jcan+AXeXfbFtYz/64kBIXrtYhb/b9cJ1m3sQFVCP8szhog2e
         JO7+Yp/OLjeZo+FiIOVKb2kvNnhgXrTWSTHVkZGxwVcXME75VWJUxwHXrXTh7/YIZyEo
         yVv7Sx62G1cghFlHeFI2cR2mNiQl7nK7lxzwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880689; x=1726485489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYgAVySTOtFl/MrFCMmK+Fl5uF1KDDdSmV7dSnMl93g=;
        b=w65eT3RgagGH7iMhJGmE6yMWpCD74qLmjSSC0qVicdjC/vu6nFtAKpO9xO6eZJ8lqy
         bL6MuGCaZjkhLTUuozG+YZFOw5sFcz5VZPb2csHWeUmYnB1wA2d0djLxlrG1VbgkA5LH
         u0xSb1GdtcydlwY4p8eMgTxQizm8FbgscSe0nKBjB3CtJiVakoAUpT/gaPq6fotgK0ka
         ze7CjVNo6U9fTUn67yvrFao5AZ6AG+s48pO1VqTtBqq9cJXBv3Px83KBN7dz6qMyP/T9
         2+TKk+hYYLuBZUThpFFxhxxKI5KC4FUPWT2GxpDwxXiUX6mumyu5XnWRh1PNAFf/BnBi
         dW+g==
X-Forwarded-Encrypted: i=1; AJvYcCW1kmbbF262I1LEswXYiU+GXu6f6aXkM+vuQstfNzUNwp+HkYvvcVp6lQ7s4g9m5/1DXpgAxZramDR5zXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMIRtskdYCoc1o0mdDIMxrKQrF2Kb6uqEy0d5PzjwLAzjRrKHX
	3/9fCQ71HJSuO2dJ+6fj4QOiUBmL0+54vlDpKICnBKWrkwrj6pzhlTETxjJbOA==
X-Google-Smtp-Source: AGHT+IHdpdCmpZMYGzYffSQ63aRQugqmqnkmvvFcvB6KeCQXoITSbuvEd9XZmdPY2B49U196YUSIow==
X-Received: by 2002:a17:903:1211:b0:207:3a4a:de43 with SMTP id d9443c01a7336-2073a4ae70dmr11101175ad.34.1725880688967;
        Mon, 09 Sep 2024 04:18:08 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:18:08 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 08/13] arm64: dts: mediatek: mt8188: Add SMI/LARB/IOMMU support
Date: Mon,  9 Sep 2024 19:14:21 +0800
Message-ID: <20240909111535.528624-9-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240909111535.528624-1-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Local Arbiter (LARB) is a component of Smart Multimedia Interface (SMI)
that supports IOMMU on the MediaTek SoCs.

Add the following nodes for memory management support on MT8188 SoC:
- one Infra IOMMU
- two Multimedia (MM) IOMMUs of VDO and VPP
- corresponding SMI common and LARB nodes of the MM IOMMUs

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 169 +++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 14e51a11f688..7e3a90c1a173 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mailbox/mediatek,mt8188-gce.h>
+#include <dt-bindings/memory/mediatek,mt8188-memory-port.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
 #include <dt-bindings/power/mediatek,mt8188-power.h>
@@ -1310,6 +1311,13 @@ pwrap: pwrap@10024000 {
 			clock-names = "spi", "wrap";
 		};
 
+		infra_iommu: iommu@10315000 {
+			compatible = "mediatek,mt8188-iommu-infra";
+			reg = <0 0x10315000 0 0x1000>;
+			interrupts = <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH 0>;
+			#iommu-cells = <1>;
+		};
+
 		gce0: mailbox@10320000 {
 			compatible = "mediatek,mt8188-gce";
 			reg = <0 0x10320000 0 0x4000>;
@@ -1805,6 +1813,37 @@ vppsys0: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		vpp_smi_common: smi@14012000 {
+			compatible = "mediatek,mt8188-smi-common-vpp";
+			reg = <0 0x14012000 0 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+				 <&vppsys0 CLK_VPP0_SMI_SUB_COMMON_REORDER>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VPPSYS0>;
+		};
+
+		larb4: smi@14013000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x14013000 0 0x1000>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+				 <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VPPSYS0>;
+			mediatek,larb-id = <SMI_L4_ID>;
+			mediatek,smi = <&vpp_smi_common>;
+		};
+
+		vpp_iommu: iommu@14018000 {
+			compatible = "mediatek,mt8188-iommu-vpp";
+			reg = <0 0x14018000 0 0x5000>;
+			clocks = <&vppsys0 CLK_VPP0_SMI_IOMMU>;
+			clock-names = "bclk";
+			interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VPPSYS0>;
+			#iommu-cells = <1>;
+			mediatek,larbs = <&larb1 &larb3 &larb4 &larb6 &larb7 &larb23>;
+		};
+
 		wpesys: clock-controller@14e00000 {
 			compatible = "mediatek,mt8188-wpesys";
 			reg = <0 0x14e00000 0 0x1000>;
@@ -1817,12 +1856,45 @@ wpesys_vpp0: clock-controller@14e02000 {
 			#clock-cells = <1>;
 		};
 
+		larb7: smi@14e04000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x14e04000 0 0x1000>;
+			clocks = <&wpesys CLK_WPE_TOP_SMI_LARB7>,
+				 <&wpesys CLK_WPE_TOP_SMI_LARB7>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_WPE>;
+			mediatek,larb-id = <SMI_L7_ID>;
+			mediatek,smi = <&vpp_smi_common>;
+		};
+
 		vppsys1: syscon@14f00000 {
 			compatible = "mediatek,mt8188-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb5: smi@14f02000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x14f02000 0 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_GALS5>,
+				 <&vppsys1 CLK_VPP1_LARB5>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VPPSYS1>;
+			mediatek,larb-id = <SMI_L5_ID>;
+			mediatek,smi = <&vdo_smi_common>;
+		};
+
+		larb6: smi@14f03000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x14f03000 0 0x1000>;
+			clocks = <&vppsys1 CLK_VPP1_GALS6>,
+				 <&vppsys1 CLK_VPP1_LARB6>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VPPSYS1>;
+			mediatek,larb-id = <SMI_L6_ID>;
+			mediatek,smi = <&vpp_smi_common>;
+		};
+
 		imgsys: clock-controller@15000000 {
 			compatible = "mediatek,mt8188-imgsys";
 			reg = <0 0x15000000 0 0x1000>;
@@ -1901,12 +1973,34 @@ ccusys: clock-controller@17200000 {
 			#clock-cells = <1>;
 		};
 
+		larb23: smi@1800d000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x1800d000 0 0x1000>;
+			clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>,
+				 <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDEC0>;
+			mediatek,larb-id = <SMI_L23_ID>;
+			mediatek,smi = <&vpp_smi_common>;
+		};
+
 		vdecsys_soc: clock-controller@1800f000 {
 			compatible = "mediatek,mt8188-vdecsys-soc";
 			reg = <0 0x1800f000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb21: smi@1802e000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x1802e000 0 0x1000>;
+			clocks = <&vdecsys CLK_VDEC2_LARB1>,
+				 <&vdecsys CLK_VDEC2_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDEC1>;
+			mediatek,larb-id = <SMI_L21_ID>;
+			mediatek,smi = <&vdo_smi_common>;
+		};
+
 		vdecsys: clock-controller@1802f000 {
 			compatible = "mediatek,mt8188-vdecsys";
 			reg = <0 0x1802f000 0 0x1000>;
@@ -1919,6 +2013,17 @@ vencsys: clock-controller@1a000000 {
 			#clock-cells = <1>;
 		};
 
+		larb19: smi@1a010000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x1a010000 0 0x1000>;
+			clocks = <&vencsys CLK_VENC1_VENC>,
+				 <&vencsys CLK_VENC1_VENC>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VENC>;
+			mediatek,larb-id = <SMI_L19_ID>;
+			mediatek,smi = <&vdo_smi_common>;
+		};
+
 		vdosys0: syscon@1c01d000 {
 			compatible = "mediatek,mt8188-vdosys0", "syscon";
 			reg = <0 0x1c01d000 0 0x1000>;
@@ -1927,6 +2032,48 @@ vdosys0: syscon@1c01d000 {
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xd000 0x1000>;
 		};
 
+		larb0: smi@1c022000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x1c022000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vdosys0 CLK_VDO0_SMI_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,larb-id = <SMI_L0_ID>;
+			mediatek,smi = <&vdo_smi_common>;
+		};
+
+		larb1: smi@1c023000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x1c023000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_LARB>,
+				 <&vdosys0 CLK_VDO0_SMI_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			mediatek,larb-id = <SMI_L1_ID>;
+			mediatek,smi = <&vpp_smi_common>;
+		};
+
+		vdo_smi_common: smi@1c024000 {
+			compatible = "mediatek,mt8188-smi-common-vdo";
+			reg = <0 0x1c024000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_COMMON>,
+				 <&vdosys0 CLK_VDO0_SMI_GALS>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+		};
+
+		vdo_iommu: iommu@1c028000 {
+			compatible = "mediatek,mt8188-iommu-vdo";
+			reg = <0 0x1c028000 0 0x5000>;
+			clocks = <&vdosys0 CLK_VDO0_SMI_IOMMU>;
+			clock-names = "bclk";
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			#iommu-cells = <1>;
+			mediatek,larbs = <&larb0 &larb2 &larb5 &larb19 &larb21>;
+		};
+
 		vdosys1: syscon@1c100000 {
 			compatible = "mediatek,mt8188-vdosys1", "syscon";
 			reg = <0 0x1c100000 0 0x1000>;
@@ -1935,5 +2082,27 @@ vdosys1: syscon@1c100000 {
 			mboxes = <&gce0 1 CMDQ_THR_PRIO_4>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0 0x1000>;
 		};
+
+		larb2: smi@1c102000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x1c102000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_SMI_LARB2>,
+				 <&vdosys1 CLK_VDO1_SMI_LARB2>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,larb-id = <SMI_L2_ID>;
+			mediatek,smi = <&vdo_smi_common>;
+		};
+
+		larb3: smi@1c103000 {
+			compatible = "mediatek,mt8188-smi-larb";
+			reg = <0 0x1c103000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_SMI_LARB3>,
+				 <&vdosys1 CLK_VDO1_SMI_LARB3>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,larb-id = <SMI_L3_ID>;
+			mediatek,smi = <&vpp_smi_common>;
+		};
 	};
 };
-- 
2.46.0.469.g59c65b2a67-goog


