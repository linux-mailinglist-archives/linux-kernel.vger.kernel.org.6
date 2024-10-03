Return-Path: <linux-kernel+bounces-348643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7598EA05
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095361F25E44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123F13A888;
	Thu,  3 Oct 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKeDJwUw"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200713BAE7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938927; cv=none; b=KnudTRi2ssYQEkztZByXwm4+Bnt0jVeSXibcVf+y5quV9VxNydcGXg7bn4YiGDLGtwj2r5/yplIU2AAzj07cI/MxdmtxfzBQdQoej7fa4jOu1+QrJtjICzX9zM+OPS+vD24sbfF6GdZn8YHv5LCbkpftKH+5Sm0ybrUAW2v/WOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938927; c=relaxed/simple;
	bh=kFd2zFR3PLHQUi9t7qCCRxG8mWOlDzI5jQoMX6E/bHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0l1EOk03rEMo+eSzBsKnhvPGohBtDDR+TiOOKa3gSI9OIkuoYUf0h/GgqRilUYJqMzCl+fpV+/qsBGdNLocm2BuyxWS4eqWQB3goViYvzzaBfwMVBnfkBsuLDsFm3iVesQsyz53AwqKfaInjnSdY3FMzcAgUSvaA8p2AuKvJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PKeDJwUw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71b00a97734so620574b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727938925; x=1728543725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k2o/I2+UBi0xubeN2RcTfc2l9sMDWMvwW6OmAATdeU=;
        b=PKeDJwUwEnOiPVKl+f1jqhqVzqUAiONyhsKJ/EEXFQmgr2Ug7nxrrslnk9ni1QIq6G
         G7PwXiuzkVAc4tvZ2Qvcl6Ew3+GDv5wB36xvzu8AmL6HBWQQsZwR2pyTWKkjKqg1Nn/E
         MRNkYhBo5MgeW48HsoC0W+mR6tdgfEjq5jR2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938925; x=1728543725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k2o/I2+UBi0xubeN2RcTfc2l9sMDWMvwW6OmAATdeU=;
        b=PAhVne3I+8D8EONxhSKAJ8Jz3U34l7IsPJ7bpqpPTHoGBpTkd+hvu/72/WTaeJV9kY
         T+m7uH+QJRrA2OrOolu8QgoF5rnQxpVnGzRFlqTVWwZiMdd00SSjqt8SH6Or/SoLIQ9t
         Ikno74hMffzMDoRqOg6R2jpvSUmFa4SzuPJw46g27qKbzgeTlTsbSBM4XqqLfLIUZ/EJ
         TiIQXhYdjG1Uym08PQaTdavvCk12CAvLiyyVWkT7kXPN3INs1cIIrlRU/sIPOU7cFaKS
         TGpgm1ffEKAkU5eif5hxGVsG4Y3nu5IM6x7E1UyalAyT1iGgGyMNOvR3DHRvv3w3nNLA
         7yow==
X-Forwarded-Encrypted: i=1; AJvYcCX8e5rg4Z2/RFMTHbaprrIlObhTKixBUEBX6cW7KMZBFi27bAYPWxwRIIdKMa8l5w9eG5YOFYc2YFoCUu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLh6l0ENkbd2xkl89NvYDp6JmT8x6+tOoogAcE1pXbdmHnoxS
	SXlocpkvPTSKd7lr/umgsvatb+LkDmcWw2lhItB4ckwihDbJGdCFae74AP7BTQ==
X-Google-Smtp-Source: AGHT+IEEV+Twz/qRb0YWbMBXSzMpp2pPI6Y9wOqdXQYwZTiPE3gnTEKFIyoXDi3D3wWX8a/nRu+Lfw==
X-Received: by 2002:a05:6a00:2d94:b0:714:1f6d:11e5 with SMTP id d2e1a72fcca58-71dc5c67665mr9381827b3a.12.1727938924901;
        Thu, 03 Oct 2024 00:02:04 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e473sm633782b3a.81.2024.10.03.00.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:02:04 -0700 (PDT)
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
Subject: [PATCH v2 7/9] arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
Date: Thu,  3 Oct 2024 15:00:01 +0800
Message-ID: <20241003070139.1461472-8-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241003070139.1461472-1-fshao@chromium.org>
References: <20241003070139.1461472-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the vdosys1 display nodes to support the external display pipeline.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 298 +++++++++++++++++++++++
 1 file changed, 298 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index c4026de18fd8..541eaed59e8b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -24,9 +24,32 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		ethdr0 = &ethdr0;
 		gce0 = &gce0;
 		gce1 = &gce1;
+		merge0 = &merge0;
+		merge1 = &merge1;
+		merge2 = &merge2;
+		merge3 = &merge3;
+		merge4 = &merge4;
 		mutex0 = &mutex0;
+		mutex1 = &mutex1;
+		padding0 = &padding0;
+		padding1 = &padding1;
+		padding2 = &padding2;
+		padding3 = &padding3;
+		padding4 = &padding4;
+		padding5 = &padding5;
+		padding6 = &padding6;
+		padding7 = &padding7;
+		vdo1-rdma0 = &vdo1_rdma0;
+		vdo1-rdma1 = &vdo1_rdma1;
+		vdo1-rdma2 = &vdo1_rdma2;
+		vdo1-rdma3 = &vdo1_rdma3;
+		vdo1-rdma4 = &vdo1_rdma4;
+		vdo1-rdma5 = &vdo1_rdma5;
+		vdo1-rdma6 = &vdo1_rdma6;
+		vdo1-rdma7 = &vdo1_rdma7;
 	};
 
 	cpus {
@@ -2507,6 +2530,16 @@ vdosys1: syscon@1c100000 {
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0 0x1000>;
 		};
 
+		mutex1: mutex@1c101000 {
+			compatible = "mediatek,mt8188-disp-mutex";
+			reg = <0 0x1c101000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_DISP_MUTEX>;
+			interrupts = <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x1000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_VDO1_STREAM_DONE_ENG_0>;
+		};
+
 		larb2: smi@1c102000 {
 			compatible = "mediatek,mt8188-smi-larb";
 			reg = <0 0x1c102000 0 0x1000>;
@@ -2528,5 +2561,270 @@ larb3: smi@1c103000 {
 			mediatek,larb-id = <SMI_L3_ID>;
 			mediatek,smi = <&vpp_smi_common>;
 		};
+
+		vdo1_rdma0: rdma@1c104000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c104000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
+			interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L2_MDP_RDMA0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x4000 0x1000>;
+		};
+
+		vdo1_rdma1: rdma@1c105000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c105000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA1>;
+			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vpp_iommu M4U_PORT_L3_MDP_RDMA1>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x5000 0x1000>;
+		};
+
+		vdo1_rdma2: rdma@1c106000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c106000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA2>;
+			interrupts = <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L2_MDP_RDMA2>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x6000 0x1000>;
+		};
+
+		vdo1_rdma3: rdma@1c107000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c107000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA3>;
+			interrupts = <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vpp_iommu M4U_PORT_L3_MDP_RDMA3>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x7000 0x1000>;
+		};
+
+		vdo1_rdma4: rdma@1c108000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c108000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA4>;
+			interrupts = <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L2_MDP_RDMA4>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x8000 0x1000>;
+		};
+
+		vdo1_rdma5: rdma@1c109000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c109000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA5>;
+			interrupts = <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vpp_iommu M4U_PORT_L3_MDP_RDMA5>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x9000 0x1000>;
+		};
+
+		vdo1_rdma6: rdma@1c10a000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c10a000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA6>;
+			interrupts = <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vdo_iommu M4U_PORT_L2_MDP_RDMA6>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xa000 0x1000>;
+		};
+
+		vdo1_rdma7: rdma@1c10b000 {
+			compatible = "mediatek,mt8188-vdo1-rdma", "mediatek,mt8195-vdo1-rdma";
+			reg = <0 0x1c10b000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_MDP_RDMA7>;
+			interrupts = <GIC_SPI 502 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vpp_iommu M4U_PORT_L3_MDP_RDMA7>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			#dma-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xb000 0x1000>;
+		};
+
+		merge0: merge@1c10c000 {
+			compatible = "mediatek,mt8188-disp-merge", "mediatek,mt8195-disp-merge";
+			reg = <0 0x1c10c000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_VPP_MERGE0>,
+				 <&vdosys1 CLK_VDO1_MERGE0_DL_ASYNC>;
+			clock-names = "merge", "merge_async";
+			interrupts = <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			resets = <&vdosys1 MT8188_VDO1_RST_MERGE0_DL_ASYNC>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xc000 0x1000>;
+			mediatek,merge-mute;
+		};
+
+		merge1: merge@1c10d000 {
+			compatible = "mediatek,mt8188-disp-merge", "mediatek,mt8195-disp-merge";
+			reg = <0 0x1c10d000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_VPP_MERGE1>,
+				 <&vdosys1 CLK_VDO1_MERGE1_DL_ASYNC>;
+			clock-names = "merge", "merge_async";
+			interrupts = <GIC_SPI 504 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			resets = <&vdosys1 MT8188_VDO1_RST_MERGE1_DL_ASYNC>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xd000 0x1000>;
+			mediatek,merge-mute;
+		};
+
+		merge2: merge@1c10e000 {
+			compatible = "mediatek,mt8188-disp-merge", "mediatek,mt8195-disp-merge";
+			reg = <0 0x1c10e000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_VPP_MERGE2>,
+				 <&vdosys1 CLK_VDO1_MERGE2_DL_ASYNC>;
+			clock-names = "merge", "merge_async";
+			interrupts = <GIC_SPI 505 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			resets = <&vdosys1 MT8188_VDO1_RST_MERGE2_DL_ASYNC>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xe000 0x1000>;
+			mediatek,merge-mute;
+		};
+
+		merge3: merge@1c10f000 {
+			compatible = "mediatek,mt8188-disp-merge", "mediatek,mt8195-disp-merge";
+			reg = <0 0x1c10f000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_VPP_MERGE3>,
+				 <&vdosys1 CLK_VDO1_MERGE3_DL_ASYNC>;
+			clock-names = "merge", "merge_async";
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			resets = <&vdosys1 MT8188_VDO1_RST_MERGE3_DL_ASYNC>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xf000 0x1000>;
+			mediatek,merge-mute;
+		};
+
+		merge4: merge@1c110000 {
+			compatible = "mediatek,mt8188-disp-merge", "mediatek,mt8195-disp-merge";
+			reg = <0 0x1c110000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_VPP_MERGE4>,
+				 <&vdosys1 CLK_VDO1_MERGE4_DL_ASYNC>;
+			clock-names = "merge", "merge_async";
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			resets = <&vdosys1 MT8188_VDO1_RST_MERGE4_DL_ASYNC>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0x0000 0x1000>;
+			mediatek,merge-fifo-en;
+		};
+
+		ethdr0: ethdr@1c114000 {
+			compatible = "mediatek,mt8188-disp-ethdr", "mediatek,mt8195-disp-ethdr";
+			reg = <0 0x1c114000 0 0x1000>,
+			      <0 0x1c115000 0 0x1000>,
+			      <0 0x1c117000 0 0x1000>,
+			      <0 0x1c119000 0 0x1000>,
+			      <0 0x1c11a000 0 0x1000>,
+			      <0 0x1c11b000 0 0x1000>,
+			      <0 0x1c11c000 0 0x1000>;
+			reg-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
+				    "vdo_be", "adl_ds";
+
+			clocks = <&vdosys1 CLK_VDO1_DISP_MIXER>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE0>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE1>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE0>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE1>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
+				 <&vdosys1 CLK_VDO1_26M_SLOW>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE0_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_FE1_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE0_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_GFX_FE1_DL_ASYNC>,
+				 <&vdosys1 CLK_VDO1_HDR_VDO_BE_DL_ASYNC>,
+				 <&topckgen CLK_TOP_ETHDR>;
+			clock-names = "mixer", "vdo_fe0", "vdo_fe1", "gfx_fe0", "gfx_fe1",
+				      "vdo_be", "adl_ds", "vdo_fe0_async", "vdo_fe1_async",
+				      "gfx_fe0_async", "gfx_fe1_async", "vdo_be_async", "ethdr_top";
+
+			interrupts = <GIC_SPI 566 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&vpp_iommu M4U_PORT_L3_HDR_DS_SMI>,
+				 <&vpp_iommu M4U_PORT_L3_HDR_ADL_SMI>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			resets = <&vdosys1 MT8188_VDO1_RST_HDR_VDO_FE0_DL_ASYNC>,
+				 <&vdosys1 MT8188_VDO1_RST_HDR_VDO_FE1_DL_ASYNC>,
+				 <&vdosys1 MT8188_VDO1_RST_HDR_GFX_FE0_DL_ASYNC>,
+				 <&vdosys1 MT8188_VDO1_RST_HDR_GFX_FE1_DL_ASYNC>,
+				 <&vdosys1 MT8188_VDO1_RST_HDR_VDO_BE_DL_ASYNC>;
+
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0x4000 0x1000>,
+						  <&gce0 SUBSYS_1c11XXXX 0x5000 0x1000>,
+						  <&gce0 SUBSYS_1c11XXXX 0x7000 0x1000>,
+						  <&gce0 SUBSYS_1c11XXXX 0x9000 0x1000>,
+						  <&gce0 SUBSYS_1c11XXXX 0xa000 0x1000>,
+						  <&gce0 SUBSYS_1c11XXXX 0xb000 0x1000>,
+						  <&gce0 SUBSYS_1c11XXXX 0xc000 0x1000>;
+		};
+
+		padding0: padding@1c11d000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c11d000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0xd000 0x1000>;
+		};
+
+		padding1: padding@1c11e000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c11e000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING1>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0xe000 0x1000>;
+		};
+
+		padding2: padding@1c11f000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c11f000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING2>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0xf000 0x1000>;
+		};
+
+		padding3: padding@1c120000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c120000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING3>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c12XXXX 0x0000 0x1000>;
+		};
+
+		padding4: padding@1c121000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c121000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING4>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c12XXXX 0x1000 0x1000>;
+		};
+
+		padding5: padding@1c122000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c122000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING5>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c12XXXX 0x2000 0x1000>;
+		};
+
+		padding6: padding@1c123000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c123000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING6>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c12XXXX 0x3000 0x1000>;
+		};
+
+		padding7: padding@1c124000 {
+			compatible = "mediatek,mt8188-disp-padding";
+			reg = <0 0x1c124000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_PADDING7>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c12XXXX 0x4000 0x1000>;
+		};
 	};
 };
-- 
2.46.1.824.gd892dcdcdd-goog


