Return-Path: <linux-kernel+bounces-324729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6F975037
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BE11F28401
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C06194081;
	Wed, 11 Sep 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YcXjc/G+"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D19192B9F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051936; cv=none; b=gkW6mXxsUFiWY8pb//tXYlfSL58VOpntYUR847kFVJHJQAIeax6VRzsa1Gi0SENq1JFz05V12v0EcRs2iapG1yYrDerJDJf2m4OwwDE4Aytyq2TjqxtX7KCfVX3umvrM1KhbtlhZEXvZf6IENUdIrqx09mfRLMU19HY2qmR6tSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051936; c=relaxed/simple;
	bh=S6WFy6AHaUquyuINcrIMSHqJU48hl1BfP0n0UBsL/q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crcRLI8owezdNlk0LZyBwTPA0TkwdLZ/xEO+nycwLPllUXNnzsoW6aDlbM4ZSOpWmvPOkKtDH3g+vUQ3XcykOlF+K22gN8fAYjtzqgFmgzcLbd0UaKTgbxPPepX9TCatmulMa2O6fnad7laOT3cd21nbNzmdO1lj1AhHwFcLAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YcXjc/G+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so4558362a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726051934; x=1726656734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3C8P2/ShZAyxq+RU0fcUwIOZvUAQXLkIBcEAMfkacE=;
        b=YcXjc/G+Av9Aw/3S0KfCsE1RF1jg1hdMAlH0DObOqmdqCiOM01FvYDvU4Pp2DdKwrw
         Ecrb4yJBHm8NQx09aBCqy9Ra76lfiof9PTfdZ2DTk+GVZYO2lQPXl+J5qdBN++L//oKT
         SQssEzuDy3SQw3+YBKvchFGJehMFyh1+71csE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051934; x=1726656734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3C8P2/ShZAyxq+RU0fcUwIOZvUAQXLkIBcEAMfkacE=;
        b=FouX5ppff/OGW/Ez9t5j/PBGH2XPZKwrXiU/ijtmWHHa1yJgdsPHYzwgm5wYqbvdG9
         C25yqvp8IWQtT95/+H3JsBZHvr9OnNjYrhS4d9BwYxTRAWuzeGTy/WZZyLvxWtmJDoTw
         4TMFwxsZ8m4EJ1nQie+d7h8/b1qPJjR+FidvvFHQ4Ya4z2RLhfP5a3BhZyV7Idz7uP1k
         2xHq+5yUAWdqRTCAUn/Fr1Jcor8iiKzu8vdPIR15Arp3iYaBEKoRMiuke9EonABBH9ZE
         y9/uIso5lPc5zr0Pd4gGV4bwgVd8Z3mdcj5IJrW8iMxH6hIxtMD8bvlVKL7P/+DTfZFI
         JJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCWhBvU6RUU3u8uT1qM72vEoRZwsqPX6DbYAKkOwCjpwCF2Qtfj+mMWaX2BmhY7GVhLo6Mwa2q/XOWkH87Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkK75TyWnr6cy8XydZUyslUHptWJ8V9D10oF+1+EvOaT1O6t9
	otwcD7wB1mP2LoYU5kC4CF3DXWyC3u020I65rHYdNS+rpKsD+NNAcYDGs6AedA==
X-Google-Smtp-Source: AGHT+IFvcmZapnkoc8hFKeAufdgIfoNywmUYYmh54sA4Z3cUyhlE/Ivs+jH9iTZfXDjBYPY0vLczEA==
X-Received: by 2002:a05:6a21:2d8d:b0:1cf:359b:1a3e with SMTP id adf61e73a8af0-1cf5e17b0c1mr5019616637.32.1726051933650;
        Wed, 11 Sep 2024 03:52:13 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8242b3d13sm7147352a12.52.2024.09.11.03.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:52:13 -0700 (PDT)
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
Subject: [PATCH v2 4/8] arm64: dts: mediatek: mt8188: Add SMI/LARB/IOMMU support
Date: Wed, 11 Sep 2024 18:51:09 +0800
Message-ID: <20240911105131.4094027-5-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911105131.4094027-1-fshao@chromium.org>
References: <20240911105131.4094027-1-fshao@chromium.org>
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

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 169 +++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index cdd2fe14effa..f746b89c1ec6 100644
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
@@ -1305,6 +1306,13 @@ pwrap: pwrap@10024000 {
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
@@ -1798,6 +1806,37 @@ vppsys0: clock-controller@14000000 {
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
@@ -1810,12 +1849,45 @@ wpesys_vpp0: clock-controller@14e02000 {
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
 		vppsys1: clock-controller@14f00000 {
 			compatible = "mediatek,mt8188-vppsys1";
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
@@ -1894,12 +1966,34 @@ ccusys: clock-controller@17200000 {
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
@@ -1912,6 +2006,17 @@ vencsys: clock-controller@1a000000 {
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
@@ -1920,6 +2025,48 @@ vdosys0: syscon@1c01d000 {
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
@@ -1928,5 +2075,27 @@ vdosys1: syscon@1c100000 {
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
2.46.0.598.g6f2099f65c-goog


