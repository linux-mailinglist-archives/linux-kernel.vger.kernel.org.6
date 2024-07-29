Return-Path: <linux-kernel+bounces-265760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AD93F599
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8012828227F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296671487C4;
	Mon, 29 Jul 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpPFeofe"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2571465BE;
	Mon, 29 Jul 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256653; cv=none; b=I7gRKuRiUcLH2rBXZMFkq80R/Sj+FrvtQ0KtnqMhmMaxJXdg60KKIYQidoQVFyPbrt5f5OBk1f/22vtFkzIGxpC/4tEDRwxYhCiVyUQSxYsGQip7l4J4BIX1z0jZDE476hkupqhdlhulqPJIDnXUeYXC7KMRZj3DTSuEZ4BtwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256653; c=relaxed/simple;
	bh=v/UdfaszXLVUAktOPHAg8IjIS8dJ6yoJdT16feuIrQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GxTmMJMO78ixWqBGdQ072HKmGi5yzhu8Bqzu8E4lErLuTnET+RQBCx8ObPQfsYk7ZzdjWwN+F1/E8azKW16aoaSBnfxeVVCKA3DDrGonV0cdWAX0AGkkf7xn+RyY6FLFriloshzozXRly4YRx5G1dCcT7x5yCEOLfikKQ4DCe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpPFeofe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so1813096a91.2;
        Mon, 29 Jul 2024 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722256650; x=1722861450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NZITpfAHD8JXe97iGR8siEXB5NDSsMSDkZ3Z4QQ/T4=;
        b=GpPFeofe31nP2/u2weljH0e0ovPnPlGQesdPSyVW7w5mCgRKhdPToYMesynbx6CHz9
         2MSYc2OjrkUqrc/1177dYZD4fgkW48QlxybSE0rMMAxe2gaHzxfpgj7qiwnfCsfMdGbd
         Xox+WvZGYax+STqBNvY6/sHbhVeeMPo2shyaDoewCBM13w3d0wPnw7C01GwP7/E+ibFL
         RQ0QDC2x2WxI1iHezfjoRpcQkKG0ASAJoUH37HSFg4ISGvkWgmj4ecVe+BpB87GxO81G
         PO10xh82rvgGBJONQSc2kB5pAf7YPAretTBMRv76psWd2QbIohsBQoJqdNuq3ct3FHBt
         rOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256650; x=1722861450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NZITpfAHD8JXe97iGR8siEXB5NDSsMSDkZ3Z4QQ/T4=;
        b=aD8GGDN0SMG5MTx3y0Ii3mg4FDWxMrB2FdKZlNUSuA6zElN7aRkA6tQzU+1Y1SqR67
         tMK5RsHqszTLYZATIMYVyTS5XYx6Gcf5UkWONdmqXXjtlfGRaKHETq5mZuAkyt8MkJwB
         EHanBAza1J4Z+HKtp04f2zs192yl48KURzyUvXgImdyy3mKXOL5y/XzXfyf5rWiQ5dho
         I+qY0ItcCf44W4A+GTPbDLbgk4uI+N78M1KteJKRgDhJ3hmKlpfPPcC9KbCT5FUCyw6J
         zzfMG7/LlByHY4SI5yL+KqvA81vmok83DxPYOaXdCxUflIn1ofTfACkZsCmXvqIZ8Nb+
         iHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbOJUmLTlp0D+pDAUh2dKh9pJnxb7pzbcipSHec5xDyaJIWsttKVCr0/ev5pbc00/VrM0g1hGnTl8virL3SJ0AYLSpmB8lefsIDbz/B3XCVwse3KGoWCcRBJixEN/JV78EgtRqjO7dfw==
X-Gm-Message-State: AOJu0YzScC48QYc92+wi4TkPFc3zn9F6/H+xg17gvLfau0Wgmjjrh+G3
	560zAuhh6uECcvOVxv/pc6yYrZHVU7JUywTlx84aEUI1WohXWbQn
X-Google-Smtp-Source: AGHT+IFyQ9DhUPSpERL815jrQzcyMO8O7mgJl28wdppTnye7TQwm3hhu4PhWWh7+rQJKr3HKhOfIqw==
X-Received: by 2002:a17:90b:1282:b0:2c9:7e9d:8424 with SMTP id 98e67ed59e1d1-2cf7e5f50f8mr5046382a91.30.1722256649932;
        Mon, 29 Jul 2024 05:37:29 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738842bsm10569248a91.6.2024.07.29.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:37:29 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] arm64: dts: rockchip: Add missing pinctrl wake and clkreq for PCIe node
Date: Mon, 29 Jul 2024 18:07:07 +0530
Message-ID: <20240729123709.2981-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings WAKE and CLKREQ for PCIe 3.0 x4, PCIe 3.0 x1
and PCIe 2.1 x1 nodes. Each component of PCIe communication have the
following control signals: PERST, WAKE, CLKREQ, and REFCLK.
These signals work to generate high-speed signals and communicate with
other PCIe devices. Used by root complex to endpoint depending on
the power state.

PERST# is referred to as a fundamental reset. PERST should be held
low until all the power rails in the system and the reference clock
are stable. A transition from low to high in this signal usually
indicates the beginning of link initialization.

WAKE# signal is an active-low signal that is used to return the PCIe
interface to an active state when in a low-power state.

CLKREQ# signal is also an active-low signal and is used to request the
reference clock.  L1 sub-states is providing a digital signal
(CLKREQ#) for PHYs to use to wake up and resume normal operation.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5: Merged all 3 patch into single patch, reabse on master
    Fix the $subject and commit message.
    Drop the RK_FUNC_GPIO for WAKE and CLKREQ as these seignal are
    ment for was introduced to allow PCI Express devices to enter
    even deeper power savings states (“L1.1” and “L1.2”) while still
     appearing to legacy software to be in the “L1” state
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 46 +++++++++++++------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 966bbc582d89..a1e83546f1be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -318,7 +318,7 @@ map2 {
 
 &pcie2x1l0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_0_rst>;
+	pinctrl-0 = <&pcie30x1_pins>;
 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
 	status = "okay";
@@ -326,7 +326,7 @@ &pcie2x1l0 {
 
 &pcie2x1l2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_2_rst>;
+	pinctrl-0 = <&pcie20x12_pins>;
 	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
 	status = "okay";
@@ -338,7 +338,7 @@ &pcie30phy {
 
 &pcie3x4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_rst>;
+	pinctrl-0 = <&pcie30x4_pins>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
@@ -363,28 +363,48 @@ hp_detect: hp-detect {
 		};
 	};
 
-	pcie2 {
-		pcie2_0_rst: pcie2-0-rst {
-			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+	pcie20x1 {
+		pcie20x12_pins: pcie20x12-pins {
+			rockchip,pins =
+				/* PCIE20_1_2_CLKREQn_M1_L */
+				<3 RK_PC7 4 &pcfg_pull_up>,
+				/* PCIE_PERST_L */
+				<3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
+				/* PCIE20_1_2_WAKEn_M1_L */
+				<3 RK_PD0 4 &pcfg_pull_up>;
 		};
+	};
 
+	pcie30x1 {
 		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		pcie2_2_rst: pcie2-2-rst {
-			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie30x1_pins: pcie30x1-pins {
+			rockchip,pins =
+				/* PCIE30x1_0_CLKREQn_M1_L */
+				<4 RK_PA3 4 &pcfg_pull_down>,
+				/* PCIE30x1_0_PERSTn_M1_L */
+				<4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* PCIE30x1_0_WAKEn_M1_L */
+				<4 RK_PA4 4 &pcfg_pull_down>;
 		};
 	};
 
-	pcie3 {
-		pcie3_rst: pcie3-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
+	pcie30x4 {
 		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		pcie30x4_pins: pcie30x4-pins {
+			rockchip,pins =
+				/* PCIE30X4_CLKREQn_M1_L */
+				<4 RK_PB4 4 &pcfg_pull_up>,
+				/* PCIE30X4_PERSTn_M1_L */
+				<4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* PCIE30X4_WAKEn_M1_L */
+				<4 RK_PB5 4 &pcfg_pull_down>;
+		};
 	};
 
 	usb {

base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
-- 
2.44.0


