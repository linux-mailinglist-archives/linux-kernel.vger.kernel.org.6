Return-Path: <linux-kernel+bounces-347421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF10D98D278
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95261C21824
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14EB205E3C;
	Wed,  2 Oct 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IWFBl5HJ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00489205E38
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869629; cv=none; b=otelChu7rGJd4haTVtulPwNy0mOceFpY7RbAi+/hxj0EtK6XFEf24oIx907d2B12eTkHh3ZTa206xi1rcAnadDXxQFKHGYedFMeRLmfbOHBpczSSWjqB8ZlevC3WVfnjBKH52E2ZGKLFrqGiVZTkAgZXLsznK7WDF3Md+J6cENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869629; c=relaxed/simple;
	bh=9VwufEvEc2hiFWnaPodj7E9FdvO0TJAWK4GQECaAb7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etic9nGMAjyt3ZFZ/ARSu6t+A2x54TtN87m7rltm0+NBGmvGqadj+/JQ7F0wZDjBOwTvHwmHbG+y+5s6fZ4Xaf+jwr5WMLAwDgH4iOINBh3i+y5RGKJXTrDx7ljBFKgOjxeAMYxLuMdb+rigNARGNlhh0SIwk5qMr18T2aicjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IWFBl5HJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71b070ff24dso5867218b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727869627; x=1728474427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kCRWUVsMe5+ruVnzqb/M8kOaOzFKMCz6CioUWe4Zic=;
        b=IWFBl5HJj9hy2oKY9KZMVKKRdDgymDVU2nGcE/gUhAXp3+tu1tltHCk/QSM7k4PMnU
         K+6WHvMm6PN4jPQ5C7m8gdvXhiEQ9hZVxbhpdBh82RLpZqlyr+jhi4oDugWSmS9zkqjM
         wJmV/k+65iQmcCX/11LReuwsTaS9+pOBTpp7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869627; x=1728474427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kCRWUVsMe5+ruVnzqb/M8kOaOzFKMCz6CioUWe4Zic=;
        b=eNbOr7A+Hja00/GgNCluRMotSDk12rvQPfxobaRuTuUZDPVTwtPVtmkEOIZrZmnQRq
         WWyrMfKUoZuc2QViKbmnjOTrwl4LNn2O5L0Fhgz0yztQUMyxgRZKZVllGf2S3qe9DiXO
         im4qJ0FSrx+YX8JTJWE6B0tBp/aWU6oUgkN/73UOqbrIqkLYeVZ8fUGJuROdo4jZhdPJ
         elQoDvKiRscTKunkkroZ3XACGcoR3lLaywqACoOuVe+FD+FlSgueMnUdPfrnlo5Qh9dA
         eMrBFbCBdqj+1cUGKCgY7IwUxzYwoHCNPMOdwX5OzS4R9fx86rfrreVMtb2pBoNt7lHi
         eyYA==
X-Forwarded-Encrypted: i=1; AJvYcCUCYY8XuKq1zL1mEs84sS4s6jn8x6jqjgkOv4lmA0Fl07MzZByyyF0KMoXyhAu8ecxPqJDi/lwgNxNnKSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCz2zXOsAkt91MhAYT0Hf4mclUb7IwzKe8o7boYyRwzuR3qufU
	WEiOsZ8fKWwe1qlYPAXLtByrAv5wsaQGOISmK/P3CnFttUfC7BOSR+oXcLshqfauAnk7QwrEauM
	2kg==
X-Google-Smtp-Source: AGHT+IGSKihjE2uix0MsFR+Y2YP02j39pJdlcIAUBAcjG7Two3aKYoPuMKCbMK/2BY64lg0nVErf5w==
X-Received: by 2002:a05:6a00:1915:b0:718:e276:eea8 with SMTP id d2e1a72fcca58-71dc5c688f7mr4336293b3a.10.1727869627191;
        Wed, 02 Oct 2024 04:47:07 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652baefsm9639627b3a.180.2024.10.02.04.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:47:06 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 7/9] arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
Date: Wed,  2 Oct 2024 19:41:47 +0800
Message-ID: <20241002114614.847553-8-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002114614.847553-1-fshao@chromium.org>
References: <20241002114614.847553-1-fshao@chromium.org>
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

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 298 +++++++++++++++++++++++
 1 file changed, 298 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 79e007b619b7..5410469e5fd8 100644
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
@@ -2505,6 +2528,16 @@ vdosys1: syscon@1c100000 {
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
@@ -2526,5 +2559,270 @@ larb3: smi@1c103000 {
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


