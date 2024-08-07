Return-Path: <linux-kernel+bounces-278556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D715F94B1CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA511F235D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA89149E1A;
	Wed,  7 Aug 2024 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="k3Q7SKBm"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A631149C7A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065164; cv=none; b=J+oIdNhCVd+7tpLhvPEkufKTmEnXHjkAIFOmr9cmwC7XyZ/8AEQHFwDbCtqMLsaYspHsjl9Jn2iwjSUVBI8sQQv3lZLbTacUbO/jo++o7jJTxHDuykycG1PeUjh9zWv68Kj3jLJENSeSuLgTRCr9L4m6K6+nnAc2eUZH764AMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065164; c=relaxed/simple;
	bh=6RdR14YQnCNy5Uqon5vlLjnN5lpkw0T2VkO1LShfkEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uxrb6Rclf1imx4ubOBYHo5bbeyxYW7ibFIAH9eXfPZDa2hq/Um82JftuahtzaarWDbatDnvBkBZpG9+Retl7HmpjYqexE5Vt+byK5eYhY6qbIcXcl36uExbBIJnjvj9//b8gjqhpXi8JXUmJqXlbFMrXJ3yAa3bHVKhe0MTcavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=k3Q7SKBm; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d9e13ef9aaso239043b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1723065161; x=1723669961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXwUhI+px9bG8x8a7373Azh9yF/JI6Km39m5m866Ga0=;
        b=k3Q7SKBmtthivSiRGc2xoolcQb+tTmf6hlI5jNibSrRYKX9fZ+nBVwgE6HpXTrYk18
         Oa4QC8lzjtI9ljBTfi8rbxbeIRek9yTdtssKJDCJxwQJnuvq6k2UoM24R+kyIvI3R4dj
         dbWDGGrLeZ2k7tYKZ4uMxDTlhWqOX3PLWRemnY5Ol71TaqeD5oO1Xq0ebFOxMS0Kk5vK
         utV1Zp5pM/EqAs0nhZW5OxHDf3Tr/sjDAQ+EXtr4wqZAlSlQi0pgLTDgGgdG6I7zrmBJ
         OkATMA3pkXwz6KWohFpz4I6itkR2fjoOqBn4XLFgnPAdqErTNlgSAUOFh1ZSh5yu82MV
         SFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065161; x=1723669961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXwUhI+px9bG8x8a7373Azh9yF/JI6Km39m5m866Ga0=;
        b=AcYIolt2wsCXH981pW+LLQhiH0Akxa5rx2smht8rphlfHfSbq3XJymgoCIz2GVVSLb
         G+4VuxjE8iwlFcueq9zeF1r2dYFijFZSYqfuvqKqqHU0mUkm9ALuWdbCn8YBLcuxKxiN
         7AnCMQ0Lds7pNoNYrwoGMPt1ETuUK1WJCLoQ6W/Zc1xVG8Zg+g+gl6U1iKd2cabk0q9H
         sg5mt3cunvUMXY7FfPRWYL2vXY5FUBX4zFG8njDWIKKbb7dN6A611zjMjMcqb+4lvEXh
         JRALWZxcVDZXCA/SOulYtGiKt1wL2TcNf5axWEgGYldiWMSPEKuwwcR99aCVyMb8FRUR
         mCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUikqrkaIXrfvjTa9c/lt63ybaTg+C54Zdolf1OO4gsok86dFH1i61cBUdG3/P/KItEfB3uhMBALAAGmsKn0zF8S/kLXoZo0Iz1Kcru
X-Gm-Message-State: AOJu0Yz7ui1tIuPylNluVZYnwvDYxAO/qMHoCReeV9CXzAIMN6zheUSc
	jpFhF+ZRbq13zMIVDOcxIGaADbzrhnb2jTKS1FcYm7dZ0ei0MtKz/Yn5JaqJCBs=
X-Google-Smtp-Source: AGHT+IGDCZHcrXNbQTVAMrvv0Gg/GEchiJyNC8rzCGiOlRhg+QOoiz7aY3RnMoBS7+SxtLpmECCipQ==
X-Received: by 2002:a05:6808:189a:b0:3db:1c0e:af55 with SMTP id 5614622812f47-3db55800ecfmr25869202b6e.13.1723065161188;
        Wed, 07 Aug 2024 14:12:41 -0700 (PDT)
Received: from localhost.localdomain ([2600:382:3517:d4e1:dc46:19f9:b4b7:9e75])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7142sm4415642b6e.37.2024.08.07.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:12:40 -0700 (PDT)
From: Logan Bristol <logan.bristol@utexas.edu>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nishanth Menon <nm@ti.com>
Cc: Josua Mayer <josua@solid-run.com>,
	Matt McKee <mmckee@phytec.com>,
	Wadim Egorov <w.egorov@phytec.de>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Logan Bristol <logan.bristol@utexas.edu>
Subject: [PATCH] arm64: dts: ti: k3-am64* Disable ethernet by default at SoC level
Date: Wed,  7 Aug 2024 16:13:42 -0500
Message-ID: <20240807211342.1660-1-logan.bristol@utexas.edu>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

External interfaces should be disabled at the SoC DTSI level, since 
the node is incomplete. The node should then be enabled in the board DTS. 
Disable ethernet switch and ports in SoC DTSI and enable them in the board 
DTS.

Reflect this change in SoM DTSIs by removing ethernet port disable.

Signed-off-by: Logan Bristol <logan.bristol@utexas.edu>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                 | 3 +++
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          | 4 ----
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                  | 3 +++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts       | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                   | 3 +++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi              | 4 ----
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts   | 6 ++----
 8 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f8370dd03350..69c5af58b727 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -677,6 +677,7 @@ cpsw3g: ethernet@8000000 {
 		assigned-clock-parents = <&k3_clks 13 9>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		dmas = <&main_pktdma 0xC500 15>,
 		       <&main_pktdma 0xC501 15>,
@@ -701,6 +702,7 @@ cpsw_port1: port@1 {
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
 				ti,syscon-efuse = <&main_conf 0x200>;
+				status = "disabled";
 			};
 
 			cpsw_port2: port@2 {
@@ -709,6 +711,7 @@ cpsw_port2: port@2 {
 				label = "port2";
 				phys = <&phy_gmii_sel 2>;
 				mac-address = [00 00 00 00 00 00];
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index ea7c58fb67e2..ec269742d060 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -210,10 +210,6 @@ &cpsw_port1 {
 	phy-handle = <&cpsw3g_phy1>;
 };
 
-&cpsw_port2 {
-	status = "disabled";
-};
-
 &mailbox0_cluster2 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6bb1ad2e56ec..82da21bd9aea 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -616,17 +616,20 @@ &cpsw3g {
 	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
+	status = "okay";
 };
 
 &cpsw_port1 {
 	bootph-all;
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
+	status = "okay";
 };
 
 &cpsw_port2 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy3>;
+	status = "okay";
 };
 
 &cpsw3g_mdio {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
index 5b5e9eeec5ac..90ffc426cae1 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
@@ -89,6 +89,14 @@ serdes_mux: mux-controller {
 	};
 };
 
+&cpsw3g {
+	status = "okay";
+};
+
+&cpsw_port1 {
+	status ="okay";
+};
+
 &main_gpio0 {
 	m2-reset-hog {
 		gpio-hog;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 30729b49dd69..d43270fad441 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -198,6 +198,14 @@ AM64X_IOPAD(0x0040, PIN_OUTPUT, 7)	/* (U21) GPMC0_AD1.GPIO0_16 */
 	};
 };
 
+&cpsw3g {
+	status = "okay";
+};
+
+&cpsw_port1 {
+	status = "okay";
+};
+
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 44ecbcf1c844..86369525259c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -527,16 +527,19 @@ &usb0 {
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
+	status = "okay";
 };
 
 &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
+	status = "okay";
 };
 
 &cpsw_port2 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy1>;
+	status = "okay";
 };
 
 &cpsw3g_mdio {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
index c19d0b8bbf0f..995e2703030b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -212,10 +212,6 @@ &cpsw_port1 {
 	phy-handle = <&ethernet_phy0>;
 };
 
-&cpsw_port2 {
-	status = "disabled";
-};
-
 &icssg1_mdio {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pru1_mdio0_default_pins>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index c40ad67cee01..8d7a0283c391 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -119,15 +119,13 @@ reg_sd: regulator-sd {
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cpsw_pins>;
+	status = "okay";
 };
 
 &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
-};
-
-&cpsw_port2 {
-	status = "disabled";
+	status = "okay";
 };
 
 &cpsw3g_mdio {
-- 
2.34.1


