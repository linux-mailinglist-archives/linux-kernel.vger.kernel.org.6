Return-Path: <linux-kernel+bounces-368894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76739A1634
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4110B282643
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D841D63E0;
	Wed, 16 Oct 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8J2E9Cb"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA91D5ABD;
	Wed, 16 Oct 2024 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121466; cv=none; b=Dv4JDFABG26uRCgWlkwe0ovIMO6xMnctV8D+PkPS3nFsNuiknV0soMs7vyla2BL+pt1IKA1YgmJntEeasM4iLUwHLX2Eu2h3akK/eOQMpD3rm5iplPHlRovylFMwyWZVXp6rgTkrnmw4tyHYZDRi+GzSyS9bJY4gb6UVFeTrbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121466; c=relaxed/simple;
	bh=9ZGFls6Wc4YkbHehUV1q2pSXo7q62XqE2ggwM8kW4WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIcb/Q9l3RkxNOGdiPsc5B2b8Ry37T5X6Ss7spLrtmps3BHjLE5r02pPb0N30WOq3EWd3iMirnTHvFSr6xIwNmNZcmWttWNnDiM9ChlN8N3omkkzEm82dmX2be3hy4MTAsgvYRzKfZSNhcZNRT3FmcnWDCiEKi49LlArAsPei6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S8J2E9Cb; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUm1r053754;
	Wed, 16 Oct 2024 18:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729121448;
	bh=9SV5h8xedLWD+ge5L6A7dBrptUEb+vs8XnTxh54IE50=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=S8J2E9Cbslmqv2F3lVzPZQc7xpFtqPRhd2REiXnX9pqg7AJsJTGCCBaav9JhBqLDi
	 Qk4HhRXXGZTD/Xdz4aiOKP41LzANOQJQhOWoJa68t28OL6Q8FD/r3hkKBgaoWGuCwL
	 iegmiStOzWaM5pJNVSHKYsXHXhfpndKUZvjYGr3g=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUmvD104267;
	Wed, 16 Oct 2024 18:30:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 18:30:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 18:30:47 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUj7m070988;
	Wed, 16 Oct 2024 18:30:47 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/5] arm64: dts: ti: k3-am64: Add PCIe ctrl node to main_conf region
Date: Wed, 16 Oct 2024 18:30:44 -0500
Message-ID: <20241016233044.240699-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016233044.240699-1-afd@ti.com>
References: <20241016233044.240699-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This region is used for controlling the function of the PCIe IP. It is
compatible with "ti,j784s4-pcie-ctrl", add this here and use it with
the PCIe node.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 7eae18399caa6..66587f20aa0fe 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -51,6 +51,11 @@ chipid@14 {
 			reg = <0x00000014 0x4>;
 		};
 
+		pcie0_ctrl: pcie-ctrl@4070 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4070 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x4080 0x4>;
@@ -1036,7 +1041,7 @@ pcie0_rc: pcie@f102000 {
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&main_conf 0x4070>;
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
 		max-link-speed = <2>;
 		num-lanes = <1>;
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
-- 
2.39.2


