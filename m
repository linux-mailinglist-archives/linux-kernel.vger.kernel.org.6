Return-Path: <linux-kernel+bounces-190360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A648CFD43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55B61C220EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FE713CFAF;
	Mon, 27 May 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uoOi9mfS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069013C822;
	Mon, 27 May 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802760; cv=none; b=hE6iNPMxE4Y+Ez3aCIOGtrDOkgO1jbReRdI68ke/Ph12l+ZUcPSv+q/D/tNdu8frwUCwN9W+I17bsAfpfXSBCxf+bmxaOOb6i8PFuDIaZDrRAWMW19xgYPKLzWRZzvzJpU4K+fGSe5gydk+dxo0onZ5foiTfZW+pCwhXjT2YIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802760; c=relaxed/simple;
	bh=QRwIRv75yrAf1JRz9MJTa1TTMXZRbOPBpI7smHJhw+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfex/EnIXdGhcMmV0xx+b0D1kP5E7dhkhf1JVgGNyEwHbWQMpomuRfcOSDgV/a68NZm6p6w1UmdcvfLoN09kSSvi/I/7cimmVPNjW+Wn52Q3LyROHVgjqZ9/mncAznBeuWOSt4rZrmxZT2QA9cyzMUfjF/jSruHhmEPXy7AOfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uoOi9mfS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716802757;
	bh=QRwIRv75yrAf1JRz9MJTa1TTMXZRbOPBpI7smHJhw+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoOi9mfSjwLdpbFTnW2XcAiSrXvPodUR1TMR+3XWrGE8Mk60RS8OdT64mGSUwfNKU
	 4bxoBtNZbXLUqypa6mocjg88L9dntbreZtekiX4oW/gyV+aXv/oPWO03iNiQMANl/b
	 3CjEer1f8OSK28xQ71MNjUgTqt28DrdbzRoRm7nqWUFuWMd7X01rI52cA/MOWtYlD2
	 JlT5nWY/jZwph5C5xjmkNS3DN08+ABmOoN+fuBaFsu1ZxwPH01K9kmm6cA+kuQivyn
	 Xtrrr1V3lh2u5qmevf9UmhIk3WgyBiYqIGzl9iv6pCKY1+M5m5zNOKauV0VID8CQf7
	 yZiLR2qLolAMw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6BA873782134;
	Mon, 27 May 2024 09:39:16 +0000 (UTC)
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
Subject: [PATCH 5/5] arm64: dts: mediatek: mt8188: Add support for Mali GPU on Panfrost
Date: Mon, 27 May 2024 11:39:08 +0200
Message-ID: <20240527093908.97574-6-angelogioacchino.delregno@collabora.com>
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

Add the necessary OPP table for the GPU and also add a GPU node
to enable support for the Valhall-JM G57 MC3 found on this SoC,
using the Panfrost driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 123 +++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 0bca6c9f15fe..29d012d28edb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -294,6 +294,112 @@ clk32k: oscillator-32k {
 		clock-output-names = "clk32k";
 	};
 
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-390000000 {
+			opp-hz = /bits/ 64 <390000000>;
+			opp-microvolt = <575000>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-431000000 {
+			opp-hz = /bits/ 64 <431000000>;
+			opp-microvolt = <587500>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-473000000 {
+			opp-hz = /bits/ 64 <473000000>;
+			opp-microvolt = <600000>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-515000000 {
+			opp-hz = /bits/ 64 <515000000>;
+			opp-microvolt = <612500>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-556000000 {
+			opp-hz = /bits/ 64 <556000000>;
+			opp-microvolt = <625000>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-598000000 {
+			opp-hz = /bits/ 64 <598000000>;
+			opp-microvolt = <637500>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-640000000 {
+			opp-hz = /bits/ 64 <640000000>;
+			opp-microvolt = <650000>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-670000000 {
+			opp-hz = /bits/ 64 <670000000>;
+			opp-microvolt = <662500>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <675000>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-730000000 {
+			opp-hz = /bits/ 64 <730000000>;
+			opp-microvolt = <687500>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-760000000 {
+			opp-hz = /bits/ 64 <760000000>;
+			opp-microvolt = <700000>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-790000000 {
+			opp-hz = /bits/ 64 <790000000>;
+			opp-microvolt = <712500>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-835000000 {
+			opp-hz = /bits/ 64 <835000000>;
+			opp-microvolt = <731250>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-880000000 {
+			opp-hz = /bits/ 64 <880000000>;
+			opp-microvolt = <750000>;
+			opp-supported-hw = <0xff>;
+		};
+		opp-915000000 {
+			opp-hz = /bits/ 64 <915000000>;
+			opp-microvolt = <775000>;
+			opp-supported-hw = <0x8f>;
+		};
+		opp-915000000-5 {
+			opp-hz = /bits/ 64 <915000000>;
+			opp-microvolt = <762500>;
+			opp-supported-hw = <0x30>;
+		};
+		opp-915000000-6 {
+			opp-hz = /bits/ 64 <915000000>;
+			opp-microvolt = <750000>;
+			opp-supported-hw = <0x70>;
+		};
+		opp-950000000 {
+			opp-hz = /bits/ 64 <950000000>;
+			opp-microvolt = <800000>;
+			opp-supported-hw = <0x8f>;
+		};
+		opp-950000000-5 {
+			opp-hz = /bits/ 64 <950000000>;
+			opp-microvolt = <775000>;
+			opp-supported-hw = <0x30>;
+		};
+		opp-950000000-6 {
+			opp-hz = /bits/ 64 <950000000>;
+			opp-microvolt = <750000>;
+			opp-supported-hw = <0x70>;
+		};
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupt-parent = <&gic>;
@@ -1167,6 +1273,23 @@ imp_iic_wrap_en: clock-controller@11ec2000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@13000000 {
+			compatible = "mediatek,mt8188-mali", "arm,mali-valhall-jm";
+			reg = <0 0x13000000 0 0x4000>;
+
+			clocks = <&mfgcfg CLK_MFGCFG_BG3D>;
+			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "job", "mmu", "gpu";
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_MFG2>,
+					<&spm MT8188_POWER_DOMAIN_MFG3>,
+					<&spm MT8188_POWER_DOMAIN_MFG4>;
+			power-domain-names = "core0", "core1", "core2";
+			status = "disabled";
+		};
+
 		mfgcfg: clock-controller@13fbf000 {
 			compatible = "mediatek,mt8188-mfgcfg";
 			reg = <0 0x13fbf000 0 0x1000>;
-- 
2.45.1


