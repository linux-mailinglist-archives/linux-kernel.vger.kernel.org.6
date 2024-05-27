Return-Path: <linux-kernel+bounces-190359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FD8CFD42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A19B21F77
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04AC13CA92;
	Mon, 27 May 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kb/hu0AE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE913AA5C;
	Mon, 27 May 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802759; cv=none; b=WZjaJLOl39yFqYigeqo2URcY+dgRAuNuQk1SDfRNP+FADgJiAq0JOeTMTFESADaqFnKotPyFkx4jO0Tcm7cs08D4/4dgQQl88guPqNcuQdiWmdQEnNKvFpkRvJq9oa441apoMM5I2ctRq4WwrxLhxXIPtkaMTxtz43dvrAML0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802759; c=relaxed/simple;
	bh=Td33TX+uUVkJpO/PZzVilgGjh46whLu7yUwBuGLbx3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi4JX9jAVKlXQrRvHx1fzO9HnmDxhvXmyPUpkCZ0jBVERRDrJIh6Vji502J9UDCSLJ3iyAkNOnnup790gyle+xMZjrA4nWitvUFwNJEvaqAPAjwC0bLGXsG/MIvEZisK4Eo7DN2x4uQm/UR6WOtYPk/YiY9swSmI45r1CajE1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kb/hu0AE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716802756;
	bh=Td33TX+uUVkJpO/PZzVilgGjh46whLu7yUwBuGLbx3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kb/hu0AEnSsb/FXG4zqhv8U74gRCA9AGQ/BbefiDCmUlg6zY2geZX42TN3sVi/zuq
	 dHtCDJ+ZK+Mlb16lG1V3lUMqtwLn3vVZbB2rJJWHvYs9JYTOp0ufTLusdRlvtwYWjq
	 yblaH/gbAzFGCcbMRqGGe7Uocui321bOYA7AIq27jBnIM+dm7kIXkrgj4p0ICDa2Ur
	 4Oc/AGOgqns4JeWktpJelSKN/+7JgeuExdXNvBpHXgJA9+8R/fM0SXackrwShWLf7k
	 4I2pnL0UBsCw2dZVJK5SOVHBrIAHIDknVYiMGAXE4BtlxxQB8TKY7Cf/fUL9YjnxiG
	 A0N/G8Tg0qlVg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4BADE3782146;
	Mon, 27 May 2024 09:39:15 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mandyjh.liu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	jpanis@baylibre.com
Subject: [PATCH 4/5] arm64: dts: mediatek: mt8188: Add support for SoC power domains
Date: Mon, 27 May 2024 11:39:07 +0200
Message-ID: <20240527093908.97574-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding support for hardware IP that requires
power switching, add the necessary power domains nodes for the
MT8188 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 323 +++++++++++++++++++++++
 1 file changed, 323 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 84f2809eae7a..0bca6c9f15fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -384,6 +384,329 @@ pio: pinctrl@10005000 {
 			#interrupt-cells = <2>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8188-scpsys", "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8188-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				mfg0: power-domain@MT8188_POWER_DOMAIN_MFG0 {
+					reg = <MT8188_POWER_DOMAIN_MFG0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8188_POWER_DOMAIN_MFG1 {
+						reg = <MT8188_POWER_DOMAIN_MFG1>;
+						clocks = <&topckgen CLK_APMIXED_MFGPLL>,
+							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
+						clock-names = "mfg", "alt";
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8188_POWER_DOMAIN_MFG2 {
+							reg = <MT8188_POWER_DOMAIN_MFG2>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_MFG3 {
+							reg = <MT8188_POWER_DOMAIN_MFG3>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_MFG4 {
+							reg = <MT8188_POWER_DOMAIN_MFG4>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8188_POWER_DOMAIN_VPPSYS0 {
+					reg = <MT8188_POWER_DOMAIN_VPPSYS0>;
+					clocks = <&topckgen CLK_TOP_VPP>,
+						 <&topckgen CLK_TOP_CAM>,
+						 <&topckgen CLK_TOP_CCU>,
+						 <&topckgen CLK_TOP_IMG>,
+						 <&topckgen CLK_TOP_VENC>,
+						 <&topckgen CLK_TOP_VDEC>,
+						 <&topckgen CLK_TOP_WPE_VPP>,
+						 <&topckgen CLK_TOP_CFGREG_CLOCK_EN_VPP0>,
+						 <&topckgen CLK_TOP_CFGREG_F26M_VPP0>,
+						 <&vppsys0 CLK_VPP0_SMI_COMMON_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB0_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB1_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_VENCSYS_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_VENCSYS_CORE1_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_INFRA_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_CAMSYS_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_VPP1_LARB5_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_GALS_VPP1_LARB6_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_SMI_REORDER_MMSRAM>,
+						 <&vppsys0 CLK_VPP0_SMI_IOMMU>,
+						 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>,
+						 <&vppsys0 CLK_VPP0_GALS_EMI0_EMI1>,
+						 <&vppsys0 CLK_VPP0_SMI_SUB_COMMON_REORDER>,
+						 <&vppsys0 CLK_VPP0_SMI_RSI>,
+						 <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+						 <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+						 <&vppsys0 CLK_VPP0_GALS_VPP1_WPESYS>,
+						 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>;
+					clock-names = "top", "cam", "ccu", "img", "venc",
+						      "vdec", "wpe", "cfgck", "cfgxo",
+						      "ss-sram-cmn", "ss-sram-v0l0", "ss-sram-v0l1",
+						      "ss-sram-ve0", "ss-sram-ve1", "ss-sram-ifa",
+						      "ss-sram-cam", "ss-sram-v1l5", "ss-sram-v1l6",
+						      "ss-sram-rdr", "ss-iommu", "ss-imgcam",
+						      "ss-emi", "ss-subcmn-rdr", "ss-rsi",
+						      "ss-cmn-l4", "ss-vdec1", "ss-wpe",
+						      "ss-cvdo-ve1";
+					mediatek,infracfg = <&infracfg_ao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8188_POWER_DOMAIN_VDOSYS0 {
+						reg = <MT8188_POWER_DOMAIN_VDOSYS0>;
+						clocks = <&topckgen CLK_TOP_CFGREG_CLOCK_EN_VDO0>,
+							 <&topckgen CLK_TOP_CFGREG_F26M_VDO0>,
+							 <&vdosys0 CLK_VDO0_SMI_GALS>,
+							 <&vdosys0 CLK_VDO0_SMI_COMMON>,
+							 <&vdosys0 CLK_VDO0_SMI_EMI>,
+							 <&vdosys0 CLK_VDO0_SMI_IOMMU>,
+							 <&vdosys0 CLK_VDO0_SMI_LARB>,
+							 <&vdosys0 CLK_VDO0_SMI_RSI>,
+							 <&vdosys0 CLK_VDO0_APB_BUS>;
+						clock-names = "cfgck", "cfgxo", "ss-gals",
+							      "ss-cmn", "ss-emi", "ss-iommu",
+							      "ss-larb", "ss-rsi", "ss-bus";
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
+							reg = <MT8188_POWER_DOMAIN_VPPSYS1>;
+							clocks = <&topckgen CLK_TOP_CFGREG_CLOCK_EN_VPP1>,
+								 <&topckgen CLK_TOP_CFGREG_F26M_VPP1>,
+								 <&vppsys1 CLK_VPP1_GALS5>,
+								 <&vppsys1 CLK_VPP1_GALS6>,
+								 <&vppsys1 CLK_VPP1_LARB5>,
+								 <&vppsys1 CLK_VPP1_LARB6>;
+							clock-names = "cfgck", "cfgxo",
+								      "ss-vpp1-g5", "ss-vpp1-g6",
+								      "ss-vpp1-l5", "ss-vpp1-l6";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_VDEC1 {
+							reg = <MT8188_POWER_DOMAIN_VDEC1>;
+							clocks = <&vdecsys CLK_VDEC2_LARB1>;
+							clock-names = "ss-vdec";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_VDEC0 {
+							reg = <MT8188_POWER_DOMAIN_VDEC0>;
+							clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
+							clock-names = "ss-vdec";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						cam_vcore: power-domain@MT8188_POWER_DOMAIN_CAM_VCORE {
+							reg = <MT8188_POWER_DOMAIN_CAM_VCORE>;
+							clocks = <&topckgen CLK_TOP_CAM>,
+								 <&topckgen CLK_TOP_CCU>,
+								 <&topckgen CLK_TOP_CCU_AHB>,
+								 <&topckgen CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS>;
+							clock-names = "cam", "ccu", "bus", "cfgck";
+							mediatek,infracfg = <&infracfg_ao>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8188_POWER_DOMAIN_CAM_MAIN {
+								reg = <MT8188_POWER_DOMAIN_CAM_MAIN>;
+								clocks = <&camsys CLK_CAM_MAIN_LARB13>,
+									 <&camsys CLK_CAM_MAIN_LARB14>,
+									 <&camsys CLK_CAM_MAIN_CAM2MM0_GALS>,
+									 <&camsys CLK_CAM_MAIN_CAM2MM1_GALS>,
+									 <&camsys CLK_CAM_MAIN_CAM2SYS_GALS>;
+								clock-names= "ss-cam-l13", "ss-cam-l14",
+									     "ss-cam-mm0", "ss-cam-mm1",
+									     "ss-camsys";
+								mediatek,infracfg = <&infracfg_ao>;
+								#address-cells = <1>;
+								#size-cells = <0>;
+								#power-domain-cells = <1>;
+
+								power-domain@MT8188_POWER_DOMAIN_CAM_SUBB {
+									reg = <MT8188_POWER_DOMAIN_CAM_SUBB>;
+									clocks = <&camsys CLK_CAM_MAIN_CAM_SUBB>,
+										 <&camsys_rawb CLK_CAM_RAWB_LARBX>,
+										 <&camsys_yuvb CLK_CAM_YUVB_LARBX>;
+									clock-names = "ss-camb-sub",
+										      "ss-camb-raw",
+										      "ss-camb-yuv";
+									#power-domain-cells = <0>;
+								};
+
+								power-domain@MT8188_POWER_DOMAIN_CAM_SUBA {
+									reg =<MT8188_POWER_DOMAIN_CAM_SUBA>;
+									clocks = <&camsys CLK_CAM_MAIN_CAM_SUBA>,
+										 <&camsys_rawa CLK_CAM_RAWA_LARBX>,
+										 <&camsys_yuva CLK_CAM_YUVA_LARBX>;
+									clock-names = "ss-cama-sub",
+										      "ss-cama-raw",
+										      "ss-cama-yuv";
+									#power-domain-cells = <0>;
+								};
+							};
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_VDOSYS1 {
+							reg = <MT8188_POWER_DOMAIN_VDOSYS1>;
+							clocks = <&topckgen CLK_TOP_CFGREG_CLOCK_EN_VDO1>,
+								 <&topckgen CLK_TOP_CFGREG_F26M_VDO1>,
+								 <&vdosys1 CLK_VDO1_SMI_LARB2>,
+								 <&vdosys1 CLK_VDO1_SMI_LARB3>,
+								 <&vdosys1 CLK_VDO1_GALS>;
+							clock-names = "cfgck", "cfgxo", "ss-larb2",
+								      "ss-larb3", "ss-gals";
+							mediatek,infracfg = <&infracfg_ao>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8188_POWER_DOMAIN_HDMI_TX {
+								reg = <MT8188_POWER_DOMAIN_HDMI_TX>;
+								clocks = <&topckgen CLK_TOP_HDMI_APB>,
+									 <&topckgen CLK_TOP_HDCP_24M>;
+								clock-names = "bus", "hdcp";
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8188_POWER_DOMAIN_DP_TX {
+								reg = <MT8188_POWER_DOMAIN_DP_TX>;
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8188_POWER_DOMAIN_EDP_TX {
+								reg = <MT8188_POWER_DOMAIN_EDP_TX>;
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_VENC {
+							reg = <MT8188_POWER_DOMAIN_VENC>;
+							clocks = <&vencsys CLK_VENC1_LARB>,
+								 <&vencsys CLK_VENC1_VENC>,
+								 <&vencsys CLK_VENC1_GALS>,
+								 <&vencsys CLK_VENC1_GALS_SRAM>;
+							clock-names = "ss-ve1-larb", "ss-ve1-core",
+								      "ss-ve1-gals", "ss-ve1-sram";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_WPE {
+							reg = <MT8188_POWER_DOMAIN_WPE>;
+							clocks = <&wpesys CLK_WPE_TOP_SMI_LARB7>,
+								 <&wpesys CLK_WPE_TOP_SMI_LARB7_PCLK_EN>;
+							clock-names = "ss-wpe-l7", "ss-wpe-l7pce";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8188_POWER_DOMAIN_PEXTP_MAC_P0 {
+					reg = <MT8188_POWER_DOMAIN_PEXTP_MAC_P0>;
+					mediatek,infracfg = <&infracfg_ao>;
+					clocks = <&pericfg_ao CLK_PERI_AO_PCIE_P0_FMEM>;
+					clock-names = "ss-pextp-fmem";
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8188_POWER_DOMAIN_CSIRX_TOP {
+					reg = <MT8188_POWER_DOMAIN_CSIRX_TOP>;
+					clocks = <&topckgen CLK_TOP_SENINF>,
+						 <&topckgen CLK_TOP_SENINF1>;
+					clock-names = "seninf0", "seninf1";
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8188_POWER_DOMAIN_PEXTP_PHY_TOP {
+					reg = <MT8188_POWER_DOMAIN_PEXTP_PHY_TOP>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8188_POWER_DOMAIN_ADSP_AO {
+					reg = <MT8188_POWER_DOMAIN_ADSP_AO>;
+					clocks = <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
+						 <&topckgen CLK_TOP_ADSP>;
+					clock-names = "bus", "main";
+					mediatek,infracfg = <&infracfg_ao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8188_POWER_DOMAIN_ADSP_INFRA {
+						reg = <MT8188_POWER_DOMAIN_ADSP_INFRA>;
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8188_POWER_DOMAIN_AUDIO_ASRC {
+							reg = <MT8188_POWER_DOMAIN_AUDIO_ASRC>;
+							clocks = <&topckgen CLK_TOP_ASM_H>;
+							clock-names = "asm";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_AUDIO {
+							reg = <MT8188_POWER_DOMAIN_AUDIO>;
+							clocks = <&topckgen CLK_TOP_A1SYS_HP>,
+								 <&topckgen CLK_TOP_AUD_INTBUS>,
+								 <&adsp_audio26m CLK_AUDIODSP_AUDIO26M>;
+							clock-names = "a1sys", "intbus", "adspck";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8188_POWER_DOMAIN_ADSP {
+							reg = <MT8188_POWER_DOMAIN_ADSP>;
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8188_POWER_DOMAIN_ETHER {
+					reg = <MT8188_POWER_DOMAIN_ETHER>;
+					clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
+					clock-names = "ethermac";
+					mediatek,infracfg = <&infracfg_ao>;
+					#power-domain-cells = <0>;
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8188-wdt";
 			reg = <0 0x10007000 0 0x100>;
-- 
2.45.1


