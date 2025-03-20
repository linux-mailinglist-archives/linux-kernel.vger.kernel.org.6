Return-Path: <linux-kernel+bounces-569693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34CA6A63A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE121890C77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B4221F30;
	Thu, 20 Mar 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAW0TabX"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB37221DA2;
	Thu, 20 Mar 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473401; cv=none; b=ewy7NBA6zEsNCKqknPvzarGpXgt9Oy2jB1N5f3wcDZo+1itjQIq9BglE4SfHGAGwpsfATjBHjMyPQhbrlmJtbLxgmJdJjBtbh+hTbfeAZH3k8j5OTNrhLux5gI+k4Iy16lFkFx9XPEm5QaclLw+EO9hDbFvRGRFHCTg2IxuijZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473401; c=relaxed/simple;
	bh=f4KhCY7bcfBrkhnTkOOzVY+RsDfGSFIQqsamnbA2WB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmW9q/ziKpbQ3VbFnKtBMEk+SvXCtMSY+LVNzfcUSj/ao3EWKE+V/P+G1/4+Vv281szYOJeYS3AseZ64ZKqX7GlF3nmR6UJ0a0lAlemZArauUiLOXHetCtCv9d27lBh6+7Wwdu+YlY0kP2OsZ4uCk+7/o5mAVZ+cWAG8D2hOe6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAW0TabX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so117001866b.0;
        Thu, 20 Mar 2025 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742473396; x=1743078196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTcHUPBi4RdnLMm/SKiBQfh0LKxbXErOyxRh8CzLSYw=;
        b=WAW0TabXGDAZc38arFMChNvuLik1CDkDFEbkQIhURgRA6xvAS+m/WgL3yMeHPonG4g
         wD4eODykn0U/fn1YmMANqw1uTVJsKuli5v+xGsEh2S2N1OEEafZGjtF6YyC7pa1XeUNS
         9LTNphiOL1eHcGG74ASinZmXEz3Bs/bQD38cJZaI9em8hsRamwY88WiPA6n+XsgP1psW
         1Tj9GUaRfNyuagMrKJyRUuRxXiR9dWPuY2c0t57es2yxoTiYO56Khtn6fhLyB19DdrZ+
         4Hsuc9xrqb6h/8W+XPshJtGJKwHX0+StPRmSmMtN7SPqK6kcRXf584VvdDUmcwyS/EY0
         Ds2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742473396; x=1743078196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTcHUPBi4RdnLMm/SKiBQfh0LKxbXErOyxRh8CzLSYw=;
        b=dbHiHmeDiIUt7PbsREWwcwwRb1wjAWM2o87HooCnlIsVoHsoUTyWhiISeV/yjgH0oa
         t46TmaJAGIO45Y/XCwo+lXMIVxqO/s/9QUgo1yIwzswG6WlkuXsx4M6ny3TShuB7Cgoj
         jnL77b1EyDBEqOlnawBeM+IkPTGptmJRzkLSGvQwkX3slKRpBJEWUCdkzwpAk9m37XV/
         XoNkqLhZ6dCfFeMQ0z6GylbKIUInb0mojn5dMurUnqe99nWN6Xn+AFgxLpvja5EOPn49
         0UkvvhuoUZZaA432gSUyaEm+of4IaUUF8bSbE0UMON4hdYAaCCLsNuMwu3w2SHpH0lhh
         4XWA==
X-Forwarded-Encrypted: i=1; AJvYcCUnSAhjvHiAvj5aE/COemczX9r7V9j0gDml/u0qxlBbbzrtszYsBQWLL7ocRhauo9fU9mx9q2KxGZE7@vger.kernel.org, AJvYcCVF2Iz2H7m+OewQo5xmx86jgdbl824f6nbes2xavZ8iGxNEH4FHC/DLaFHX2N4GRNa01KaGiLkRNsIETjiD@vger.kernel.org
X-Gm-Message-State: AOJu0YxAudgy3nfvkn8/U5H9L3kNgP3a4QkgfLYULfce7nCvV7W4PzFG
	/iFI5dnrpOgnVyoj6+MZR+zwht5Lk9UMcwcarkA9mVCc3bIxLS6e
X-Gm-Gg: ASbGncv+zuMNwEqbUX9hVNOfbFl4k29tP06tHpGJ5XBc/jYSF9rStqcxnnxe/mMGbae
	fP+uZ9kPUbQWrNxrW4qMFj3RYcZEaZr0qNHPMcY+QUeFRLEVV3dP8QIXEbGABGv4MAeiKy7dQoY
	pHurfCZjTiWsKsB+68g+ZCVtKGWkGQ9/W/ttwlGFfLubyp6SNGgJnJQ6h0/dE60OSa0X0Hl3j/T
	xEuzB1dsAlnVVCErvUAk0BbgbVRw0sPyIAMYjacRPjk6O0OsQlFS5aPW2Zzw+BOzraM9T9LjwNl
	Ln70NqClzyDyPPkEwBkraWOohu8Od140MEkTy6KHqMGTzyJMcMsJ/h4zC+fcWknKNl2fHLUtrr+
	uJ2Qa34Pbauc7cM61WeN4A/krqqo=
X-Google-Smtp-Source: AGHT+IHZMteGa3S1nkmn4PeuohC1rXzkLQoqtOFH7dp6eE3wLhlL4YTQF8Nz3QxqVr/GwwINnhAUaQ==
X-Received: by 2002:a17:907:3d94:b0:ac3:3f13:98aa with SMTP id a640c23a62f3a-ac3ce0736fbmr333129766b.32.1742473396168;
        Thu, 20 Mar 2025 05:23:16 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ed1e4sm1169211366b.66.2025.03.20.05.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 05:23:15 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: k3-j784s4-main: Enable ACSPCIE outputs for PCIe interfaces
Date: Thu, 20 Mar 2025 13:22:59 +0100
Message-Id: <20250320122259.525613-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

TI J784S4-based devices, such as the AM69 SoC, provide PCIE_REFCLK outputs
from the SoC, which can be used to clock external PCIe endpoint devices.
Each PCIE_REFCLK output is enabled via the corresponding ACSPCIE clock buffer,
with each buffer supporting two PADs to provide reference clocks for two
associated PCIe instances. The mappings are as follows:
        - PCIe0 -> ACSPCIE1 PAD0
        - PCIe1 -> ACSPCIE0 PAD0
        - PCIe2 -> ACSPCIE1 PAD1
        - PCIe3 -> ACSPCIE0 PAD1

This patch enables each ACSPCIE module and its corresponding PADs to ensure
that all PCIE_REFCLK outputs are functional.

This change have been tested on an AM69-based custom hardware platform,
where all four PCIe instances (PCIe0, PCIe1, PCIe2, and PCIe3) with the
internal PCIE_REFCLK are utilized with various endpoint devices such as
a WiFi card, NVMe SSD, and PCIe-to-USB bridge.

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1484211/am69-pcie-refclk-out-and-acspcie-mappings
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
This change depends on https://lore.kernel.org/all/20241209085157.1203168-1-s-vadapalli@ti.com/
---
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi      | 10 ++++++++--
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi             | 10 ++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 591609f3194c..854fdf7b771e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -132,6 +132,11 @@ acspcie0_proxy_ctrl: clock-controller@1a090 {
 			compatible = "ti,j784s4-acspcie-proxy-ctrl", "syscon";
 			reg = <0x1a090 0x4>;
 		};
+
+		acspcie1_proxy_ctrl: clock-controller@1a094 {
+			compatible = "ti,j784s4-acspcie-proxy-ctrl", "syscon";
+			reg = <0x1a094 0x4>;
+		};
 	};
 
 	main_ehrpwm0: pwm@3000000 {
@@ -1067,11 +1072,12 @@ pcie0_rc: pcie@2900000 {
 		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
 		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
+		ti,syscon-acspcie-proxy-ctrl = <&acspcie1_proxy_ctrl 0x1>;
 		max-link-speed = <3>;
 		num-lanes = <4>;
 		power-domains = <&k3_pds 332 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 332 0>;
-		clock-names = "fck";
+		clocks = <&k3_clks 332 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
+		clock-names = "fck", "pcie_refclk";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		bus-range = <0x0 0xff>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 0160fe0da983..ebbc315649d0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -34,8 +34,8 @@ pcie2_rc: pcie@2920000 {
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 334 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 334 0>;
-		clock-names = "fck";
+		clocks = <&k3_clks 334 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
+		clock-names = "fck", "pcie_refclk";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		bus-range = <0x0 0xff>;
@@ -45,6 +45,7 @@ pcie2_rc: pcie@2920000 {
 		dma-coherent;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
 		ti,syscon-pcie-ctrl = <&pcie2_ctrl 0x0>;
+		ti,syscon-acspcie-proxy-ctrl = <&acspcie1_proxy_ctrl 0x3>;
 		status = "disabled";
 	};
 
@@ -63,8 +64,8 @@ pcie3_rc: pcie@2930000 {
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 335 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 335 0>;
-		clock-names = "fck";
+		clocks = <&k3_clks 335 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
+		clock-names = "fck", "pcie_refclk";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		bus-range = <0x0 0xff>;
@@ -74,6 +75,7 @@ pcie3_rc: pcie@2930000 {
 		dma-coherent;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
 		ti,syscon-pcie-ctrl = <&pcie3_ctrl 0x0>;
+		ti,syscon-acspcie-proxy-ctrl = <&acspcie0_proxy_ctrl 0x3>;
 		status = "disabled";
 	};
 
-- 
2.34.1


