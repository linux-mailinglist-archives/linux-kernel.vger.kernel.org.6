Return-Path: <linux-kernel+bounces-277884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FD94A7A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D9AB2242F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3A1E4F13;
	Wed,  7 Aug 2024 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mfTfp811";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="d6Xurfcv"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572481C37B0;
	Wed,  7 Aug 2024 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033271; cv=none; b=CwuglKQebaPvjRmXYX4KDBkp5aVdPYHSXFrgRRfAOUFZUlGgjucAx/d2Hm9foFGvC2RtifRSqzEZ4fbzZqZgxmJ82tUjdtaAkjWUu/kPJ7LWeZGOOelrDADNNi3CCbBJF3V6vkx0cJJ4StT0jyB21s66OXQV3jOugAI6dJygbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033271; c=relaxed/simple;
	bh=1A6K0pJ8eOSKcVLh3x1qr1Ju0aPsXSm3yyGHkt973JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=It2uL9WwLDjsE+VTHpFBs0rdFh+DfvTwghOXzqlvScaL64nM/gQoXb6dUUTBNEQ34tuLUM58UOUffmX6oQaxRInUpwLyRjM1xtbyQwaEzHab860rQ9wiue53azm2A7bpC2ACtw93jheLrFkdKp2TC+akXZVOj0ARXNulMTTRZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mfTfp811; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=d6Xurfcv reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723033265; x=1754569265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W9AoAUndBtl0FZOFTVxj/U4a/ipvfy1DskBxqtse6Ck=;
  b=mfTfp811cugFyTwMiucItVG8bNHUNJhoDTcb6z8/8zuP8WXyctlok3ky
   4MEbWeSd6Kg5k1oHoQte1vbqeCyIWwjoa6aFsvaHZssIUX0m5t4f+E7Su
   fkzy+3+33w4LC4+bXvYrRB05AcORyofdktayAVNPFdFnzjiBgZWSN9ZWC
   FAkzxfCt5hatAx8IsSvtyvv8pZ3TQ7CXzFzigdOaQsYxovlG4+D9T70wy
   hTy3Aw80U0vIajsuijxVN3XCKktfFeFUbJzZiwJQl+2lZ2G6N3yqDgE06
   p+5v/TuKxKb4T4TQxzSlJLEpoutDxp0vB5cVMnvGDpBtb5a2M0Hqu27Oh
   Q==;
X-CSE-ConnectionGUID: Fd6x0rHaSHaE8RRvLnygkQ==
X-CSE-MsgGUID: Fn4xV/B5QCKZw1Y0KFIT4w==
X-IronPort-AV: E=Sophos;i="6.09,269,1716242400"; 
   d="scan'208";a="38292858"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Aug 2024 14:21:03 +0200
X-CheckPoint: {66B366AE-35-CC8A42C9-EEB26961}
X-MAIL-CPID: E035F2E2B0B4EEB6A9ADCD96DF82BD37_2
X-Control-Analysis: str=0001.0A782F28.66B366AF.0039,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46CAB167598;
	Wed,  7 Aug 2024 14:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723033258;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=W9AoAUndBtl0FZOFTVxj/U4a/ipvfy1DskBxqtse6Ck=;
	b=d6XurfcvyQJaIjifnCrU8gLOsTnA1AkDYGp/Z+dhweUxfDcWa4aHtYhJ3fd5uzk1voF1OI
	Z7jv+kap0fFa+X6JN/aKvCim6MM2ZLsYjAVUApTkFFGVDbvv9LGEYL8qLPHHT9O08jcjlo
	hIicu6t++ox1XzbzkZL8A7k3DzlgIc2N3nsR9w+llHc7cs1O6MseRuEC4NQrpLwhyDVnft
	6gwMJqa+YRmHQZC/IF+h93aptCTD02+TqEMzcVOL1fGz8BxO9I7xquHdR+7wd4E8RsVMfD
	zMpAGG+6+DwaZT8sPI4j8JCbg7X32g3RM5W/OehDNK7e9TQGK8nDfu7vW8fuZg==
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
Subject: [PATCH v3] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU Ethernet support
Date: Wed,  7 Aug 2024 14:19:21 +0200
Message-ID: <20240807121922.3180213-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
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

v3:
- Rebased to v6.11-rc1

v2:
- Dropped binding change patch
- Moved prueth device node to DTS toplevel, matching the AM64x EVM
- Update firmware filenames to match EVM

 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index c40ad67cee019..c2a62cb763a59 100644
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


