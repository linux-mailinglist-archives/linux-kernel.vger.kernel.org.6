Return-Path: <linux-kernel+bounces-220935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8423E90E95B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC7BCB23422
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6D13E043;
	Wed, 19 Jun 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="op8WDozz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZmoiVL+S"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644E13D625;
	Wed, 19 Jun 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796279; cv=none; b=RYXiWy+FRfh+1s4cEpUn3HIbZlRIiyI6tdNzdOWf0/A0KOaeXqpJI5nYDlyY3A6m/YB2Dx9A1et/LhvkZerT6DOmZdZPSAOdAYsnNS4EsaRBbTZPGxOsTICZ7V01JKmDpaKio3c6inN2M8LegxaitZmUZCkFJ/1690R80I/Tvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796279; c=relaxed/simple;
	bh=8rfpGs7JzwTkpbq1mkSaDGKS7FWCrhFS/Qy7lFa2Q8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptjYzVeQqkzak7fztFx70uA7qWYS9xk/xMpLxKRmM3gvNUinp1qDawuqTYyTA1tGxvEPHwS5Wei89isJewLm/y4qT//3fQeHL02O8ZYD1aXwaeMmHWi4j3zsF2qhOdAaLwu74asD1knLeQRdW5WRdtuO8pk3STPLcbF4xLkX5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=op8WDozz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZmoiVL+S reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718796276; x=1750332276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iNCg5Yfxo+yi57fLJRdraGxrmBw0QNUTJqDZy4I2bmg=;
  b=op8WDozzBzRo4hbRVfBJD83WooFg36cIoGCChkSUyMoBLRmxExgUG9Q2
   /8SJ+qQ5o201uPR1BOQOzMGkL3owAefgAzmFgeszMh5yVbZr9nN+FMx8d
   L5wG0eKDQNbdpcKShYyJp37KFhCgmF+OFPKktQw3MeIyCCLqxAPxCAYKD
   1h5p3KgCX2PuV768PbXog4jUy98/f/yww+gxjheK9gqGaaGbq/YAmzWyo
   x/2XBSDsVUa9SvsBwgFvcWdYC6FJTYTXsjj9htnCUepwlJYZ0gDMbtmHe
   oWKuxeg1aL4IQQb05KgDuBi6QW0d/JWFWgskUWvO5YrK3cldcvhu761r7
   Q==;
X-CSE-ConnectionGUID: G/Nx2jDdTlGM5EJYS6yGFA==
X-CSE-MsgGUID: 7EkOx4TqS6+QGeHHKVgvtw==
X-IronPort-AV: E=Sophos;i="6.08,250,1712613600"; 
   d="scan'208";a="37474781"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Jun 2024 13:24:34 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 465E616697D;
	Wed, 19 Jun 2024 13:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718796269;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iNCg5Yfxo+yi57fLJRdraGxrmBw0QNUTJqDZy4I2bmg=;
	b=ZmoiVL+SI3BIRs898kH6F5sdnh1MGcHHcnf2GJs1NCkLtlEIJli+2tdp+o//xXhJWUS2Ht
	qlN4wJjyLr88d1IoX5r4ySsk1e3qMTGsxYl14nvc6Fttj1ac6BgsVw62JTJOajnnm3rBcp
	unVFTk986HB1hl3UPAGWwTuPF1lRUQY9ViRhyL766+lpPxfS1G+XA8/tTiLdAS+/27B8Kk
	IRmFYrboYXu7tfNLyqW9PCOxUUSOqZZT1kE9bDhU3jQJfqy0vSF8uBefVEIyo9xf2ahsAI
	QB9TaRJ7IJ+TtDbApB0E90RJ+sj8gLqQ+pWj015TP1gPzVRALnVhP0gjMK5VsQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Suman Anna <s-anna@ti.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU Ethernet support
Date: Wed, 19 Jun 2024 13:24:06 +0200
Message-ID: <20240619112406.106223-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
References: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
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

Differing from the EVM, we add the virtual ethernet controller device
below &icssg1 instead of the top level. Besides being slighly more
accurate, this has the advantage that the node is implicitly disabled
when &icssg1 has status = "disabled" (which the TQMa64xxL bootloader
adds as a fixup when running on an AM64x variant without ICSSG support),
thus avoiding leaving the ethernet device in EPROBE_DEFER limbo forever.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

k3-am642-evm.dts uses "ti-pruss/am64x-sr2-*" filenames instead of
"ti-pruss/am65x-sr2-*", however it is not clear to me where these would
come from - I'm not aware of any firmwares named like that.

So far, these firmwares are not in mainline linux-firmware; TI's
reference BSPs include firmware from ti-linux-firmware [1], and the same
"am65x-sr2" firmwares are used on AM65x and AM64x SoCs.

[1] https://git.ti.com/gitweb?p=processor-firmware/ti-linux-firmware.git;a=tree;f=ti-pruss;h=a220bdc6dce5e11845b5c6337ff9b2d329aee196;hb=refs/heads/ti-linux-firmware

 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 1f4dc5ad1696a..0eff392a29b00 100644
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
@@ -154,6 +156,104 @@ &epwm5 {
 	status = "okay";
 };
 
+&icssg1 {
+	icssg1_eth: ethernet {
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
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
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
+};
+
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


