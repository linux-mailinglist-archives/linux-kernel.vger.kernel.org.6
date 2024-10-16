Return-Path: <linux-kernel+bounces-368892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B19A162E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD8E1F23655
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3C1D5CC9;
	Wed, 16 Oct 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o69j6gGs"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCF1D1747;
	Wed, 16 Oct 2024 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121464; cv=none; b=SIO97xYCKaPVIjvVq/cScnOST4h5pgZQNRlOMdsmNBUrWeZSqRyXFGI3uZxn9GSLYAYXL7Ntfx3qmDvUvj0NP2ZOS5rTJj9nnn/Uy7lcNQAS7gCBP+4q/MMtQ9+ld+A4Dnm+lMy/7S9rsj33GEBQA25UfSd6w65EeTDJ67Luzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121464; c=relaxed/simple;
	bh=Ihq9yKIeH+aoD6Yk6tRdFeC137TsNgMKdDmhpt2dfUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKvQDe3+OJdg0syYayHpHaTiOVg6hwbIQaXlTHLMe57cGH+FKjOygBCv6/NZnFvBzKV5QgMwHr1bSGgl8atHivN9dZ2KwyGG9dvoJcgSCtXD9rP0x1UMWZX3l0zDc2JcC6wxN1R+0yzGDIGtST2MooFbpy8o3kHoHQQEIgsxwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o69j6gGs; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUkAi016130;
	Wed, 16 Oct 2024 18:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729121446;
	bh=RJdIXxeQZdLKxRUVJuHwy/nEqfURaOs7bbsYKHNkBFU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=o69j6gGsn5BQhDdKgQGWCFQC58P6g1yLegtOnN8Q7Gz8y5ueDDcsYzMRAaeztnYXS
	 pXyehI92st1robpEE3NPTielXWbQf1RnWd1kJEbCoIpUPqLfu1K83vemd0DlGvlTVP
	 cIBvc+CgBSIX76CeSMHs2rk++SttAaYCnl30s+tE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GNUkgH086782
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 18:30:46 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 18:30:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 18:30:46 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUj7j070988;
	Wed, 16 Oct 2024 18:30:46 -0500
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
Subject: [PATCH 2/5] arm64: dts: ti: k3-j721e: Add PCIe ctrl node to scm_conf region
Date: Wed, 16 Oct 2024 18:30:41 -0500
Message-ID: <20241016233044.240699-3-afd@ti.com>
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
the PCIe nodes.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso    |  2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 28 ++++++++++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
index 4062709d65792..a8a502a6207f6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
@@ -38,7 +38,7 @@ pcie0_ep: pcie-ep@2900000 {
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
 		max-link-speed = <3>;
 		num-lanes = <1>;
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 0da785be80ff4..3b08e71081df3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -44,6 +44,26 @@ scm_conf: scm-conf@100000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
+		pcie0_ctrl: pcie-ctrl@4070 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4070 0x4>;
+		};
+
+		pcie1_ctrl: pcie-ctrl@4074 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4074 0x4>;
+		};
+
+		pcie2_ctrl: pcie-ctrl@4078 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4078 0x4>;
+		};
+
+		pcie3_ctrl: pcie-ctrl@407c {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x407c 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x4080 0x50>;
@@ -945,7 +965,7 @@ pcie0_rc: pcie@2900000 {
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
@@ -974,7 +994,7 @@ pcie1_rc: pcie@2910000 {
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
@@ -1003,7 +1023,7 @@ pcie2_rc: pcie@2920000 {
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
+		ti,syscon-pcie-ctrl = <&pcie2_ctrl 0x0>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
@@ -1032,7 +1052,7 @@ pcie3_rc: pcie@2930000 {
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
+		ti,syscon-pcie-ctrl = <&pcie3_ctrl 0x0>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
-- 
2.39.2


