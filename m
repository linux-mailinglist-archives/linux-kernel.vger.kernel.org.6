Return-Path: <linux-kernel+bounces-326074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1D976225
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BC72858D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA918BBA7;
	Thu, 12 Sep 2024 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="osuaPkQv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9218B486;
	Thu, 12 Sep 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124796; cv=none; b=nopTV9Drj66VjhPnghnbjSBRkxwYRlx9O+S7gQuO76G6lDvDwAbfqpkZt1tAO7eOD8gjkbohuahqkdtf3iAGEYKNdE7j+z2yGE3HMBXR81mjfrqEX3X6yODbVaJgAgjVSkwkgi6tsHWmKQoQPXRSLZH0wEZe6TLDVwsCSb9dFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124796; c=relaxed/simple;
	bh=DyqjTxdmYcFRSYwExFXfjsQE7FVLZXqc5JIFWYRLrsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NaSYWNjlysSmSY7i57alZWgWN2X+ibgSG+oLRL2x7sugGaLy1lAJTZ0HiNxMeVoNlpE73nQpvzm3pEX53pHjgicU9A4l2nF85/pejl+uDYndJpJVlPro2WCOgsPTMPZ9TQ0+E65dmGOyPDPrTve8263Lm2NDw+7R4OumBwYJ4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=osuaPkQv; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 87d92ab070d511ef8b96093e013ec31c-20240912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ycm75bx+ikCTXSypBlYTHLgbMqzoqeOexBSyfGPPesE=;
	b=osuaPkQvNj7XijnxIkR/uGQ46o7WCL6Zjr5O8BPLwPrgCtBPXxUyNW6hTeosT58VeS+jF+uTPWuDCjXm0lIUYLQfIyaGCfMjLd1qgPEPlh/dOV/5fd0gsTMdDXy2cTWaQvOIk8rhliuG2nx4kTZjLli1ZecJUQBAbPfkZ8tkZ+g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:24c1b322-027d-4827-9f9f-cc0a1be61951,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:5343d8bf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 87d92ab070d511ef8b96093e013ec31c-20240912
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1999240759; Thu, 12 Sep 2024 15:06:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Sep 2024 15:06:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Sep 2024 15:06:26 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v2] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU
Date: Thu, 12 Sep 2024 15:06:24 +0800
Message-ID: <20240912070624.25540-1-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Enable the Mali Valhall GPU on Genio 1200 EVK by providing regulator
supply settingsi to gpu and mfg1, and enable the GPU node.

In addition, set the GPU related regulator voltage range:

1. Set the recommended input voltage range of DVDD_GPU to (0.546V-0.787V),
   based on Table 5-3 of MT8395 Application Processor Datasheet.
   The regulator mt6315_7_vbuck1("Vgpu") connects to the DVDD_GPU input.
   Note that the minimum voltage in SoC eFuse data, which is read by
   MTK-SVS to adjust the regulator voltage, does not go below
   the recommended operating voltage in the datasheet.

2. Set the input voltage of DVDD_SRAM_GPU, supplied by
   mt6359_vsram_others_ldo_reg, to 0.75V, the recommended typical
   operating voltage in MT8395 Application Processor Datasheet.

This patch is tested by enabling CONFIG_DRM_PANFROST and
on Genio 1200 EVK it probed with following dmesg:

```
panfrost 13000000.gpu: clock rate = 700000092
panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x1 status 0x0
panfrost 13000000.gpu: features: 00000000,000019f7,
					   issues: 00000001,80000400
panfrost 13000000.gpu: Features: L2:0x07120206 Shader:0x00000000
					   Tiler:0x00000809 Mem:0x301
					   MMU:0x00002830 AS:0xff JS:0x7
panfrost 13000000.gpu: shader_present=0x50045 l2_present=0x1
[drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
```

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index a06610fff8ad..4f7d66d6d785 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -194,6 +194,11 @@ eth_phy0: eth-phy0@1 {
 	};
 };
 
+&gpu {
+	mali-supply = <&mt6315_7_vbuck1>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&i2c0_pins>;
@@ -337,6 +342,10 @@ &mfg0 {
 	domain-supply = <&mt6315_7_vbuck1>;
 };
 
+&mfg1 {
+	domain-supply = <&mt6359_vsram_others_ldo_reg>;
+};
+
 &mmc0 {
 	status = "okay";
 	pinctrl-names = "default", "state_uhs";
@@ -407,6 +416,12 @@ &mt6359_vrf12_ldo_reg {
 	regulator-always-on;
 };
 
+/* for GPU SRAM */
+&mt6359_vsram_others_ldo_reg {
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <750000>;
+};
+
 &mt6359codec {
 	mediatek,mic-type-0 = <1>; /* ACC */
 	mediatek,mic-type-1 = <3>; /* DCC */
@@ -839,8 +854,8 @@ regulators {
 			mt6315_7_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1193750>;
+				regulator-min-microvolt = <546000>;
+				regulator-max-microvolt = <787000>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
 			};
-- 
2.45.2


