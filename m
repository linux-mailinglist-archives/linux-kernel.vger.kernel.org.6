Return-Path: <linux-kernel+bounces-227301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD4914EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6710D1F20F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693E13DDD5;
	Mon, 24 Jun 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XzyWoDE9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ji7jBq/4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13813DB88;
	Mon, 24 Jun 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236587; cv=none; b=qsphMfwonZHicIdJw4t44hvp3vAFmH1tD8j7HOplcmPbOHr0uG/cgOoWC8V3kbKTfmhjm3Rh6RXVTDIVrz6Lv2ZBwhKFWwCdozHbz+Z5e9unO12NPR795Zs+VmYXJXY89dmK78fLPfmEVlff5pEHeMlpaxKoV11UXtTntCsDD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236587; c=relaxed/simple;
	bh=I8476btsLqg4aJAeSSDebyL6wpge2aBm0eFLnaYE2hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W7uNbPe36044OKHVfRlCcn4AyRNL5WJMyM0hEP/7VpI3m+uFmvdqgbr/yHK6YEWcg33gAB8mjaaMGT5oH4kH6JSo7B5+GVgJjlUyGb1PSQ3j+7x3MFEWnsW+AfG4NFunmjdRVc4/AdZ3eZMiS2LkSSc2vTuPm0fNt/YfIq46UeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XzyWoDE9; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ji7jBq/4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719236584; x=1750772584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2DPHEkgZ7R75Xt+0qmmV1YKtyxYw1BQWMR5WZofqK1Q=;
  b=XzyWoDE90Zb95RWtxwgC29LgqlWvk4nAESZVuiogoPdCH5gaXhwrAPZM
   PHYnXgab0a3x2c5jIpDzkVrSaKSUQkBYTnFbRnkyotp2ui7ax5m6T1J1U
   m+rYvSJaiciC4BasmCyt+GXM1eerm3iP080J5QvdbxlTrzTbHTmLp7HG+
   NraZFPQGvFM2OZEcyGoNqZMoHkpWUQ9v+nFQYd08+jVyKyuQfDVAwTy0B
   hlK7LX8A8CD04NcIRjnvxsHaPIsHXx/eWGRPLFoaMr1hQz2iyk8vsEFLg
   E9iwadPiTTaHTOMwn7DlbmLCUzMZbwgbQAJw1a1EFBaRZY+TC7cuD8BIN
   A==;
X-CSE-ConnectionGUID: wY/cFS7CQ56DOqf3NYz12Q==
X-CSE-MsgGUID: H3t8Ipp5QT6b/JoFLHFnRw==
X-IronPort-AV: E=Sophos;i="6.08,262,1712613600"; 
   d="scan'208";a="37554370"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2024 15:43:01 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D72A16747D;
	Mon, 24 Jun 2024 15:42:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719236577;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2DPHEkgZ7R75Xt+0qmmV1YKtyxYw1BQWMR5WZofqK1Q=;
	b=Ji7jBq/41bMdkMDoOq/Z4Ac7GQYB6gz80EiXxEwzlvYJ+ZB6YOfkONVgIX3ZbO1cw/n84k
	z/7DSb0eD622sgOnfIJ50oUz1pGJYGuMO3A4DUeEcev6UDSr7igANNBwzr7GANr+GbW7M1
	BUEQRkq1+I+EpdoNJztrAkZswSmZkMWCeTH20AFCWwuok2lpsK1nY0rwKhMYQzx6VoCAgR
	PRBjPWjLwJUMszK1kvizZUf90Np/h2RzpzAC4vh6tEN6GVjO5mU1c61CjE2RhUERdyO2xR
	tr9VXaWKUctMTmIEoi0H4USgEFAqBYIDvq6lRC7WFfPsH2y905YXj702Mox2vQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU Ethernet support
Date: Mon, 24 Jun 2024 15:42:35 +0200
Message-ID: <20240624134235.202243-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add PRU Ethernet controller and PHY nodes, as it was previously done for
the AM64x EVM Device Trees.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:
- Dropped binding change patch
- Moved prueth device node to DTS toplevel, matching the AM64x EVM
- Update firmware filenames to match EVM

 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 1f4dc5ad1696a..204f5e48a9c63 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -24,6 +24,8 @@ / {
 
 	aliases {
 		ethernet0 = &cpsw_port1;
+		ethernet1 = &icssg1_emac0;
+		ethernet2 = &icssg1_emac1;
 		i2c1 = &mcu_i2c0;
 		mmc1 = &sdhci1;
 		serial0 = &mcu_uart0;
@@ -71,6 +73,66 @@ led-1 {
 		};
 	};
 
+	icssg1_eth: icssg1-eth {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pru_icssg1_rgmii1_pins>, <&pru_icssg1_rgmii2_pins>;
+		interrupt-parent = <&icssg1_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+		sram = <&oc_sram>;
+		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
+		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
+		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+		ti,mii-g-rt = <&icssg1_mii_g_rt>;
+		ti,mii-rt = <&icssg1_mii_rt>;
+		ti,iep = <&icssg1_iep0>,  <&icssg1_iep1>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			icssg1_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg1_phy0c>;
+				phy-mode = "rgmii-id";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+
+			icssg1_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg1_phy03>;
+				phy-mode = "rgmii-id";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
+
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		pinctrl-names = "default";
@@ -154,6 +216,42 @@ &epwm5 {
 	status = "okay";
 };
 
+&icssg1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pru_icssg1_mdio_pins>;
+	status = "okay";
+
+	/* phy-mode is fixed up to rgmii-rxid by prueth driver to account for
+	 * the SoC integration, so the only rx-internal-delay and no
+	 * tx-internal-delay is set for the PHYs.
+	 */
+
+	icssg1_phy03: ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x3>;
+		reset-gpios = <&main_gpio1 47 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	icssg1_phy0c: ethernet-phy@c {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0xc>;
+		reset-gpios = <&main_gpio1 51 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+};
+
+
 &main_gpio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_gpio0_digital_pins>,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


