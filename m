Return-Path: <linux-kernel+bounces-200772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386698FB4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0441C2109B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC5146592;
	Tue,  4 Jun 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beELly/C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46ED143C6D;
	Tue,  4 Jun 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509623; cv=none; b=RNjHq+TLi44GjDJoS0hlC++6XUtgSrKtD+bqY31sIA5gnbptsf1JPDhMUYEna104gMIx59V8lKSrmYd83SVfE1/bP9HH9xiCd1+XXEM7+H2JLbqo/5DYuuJz0I6B/hWiNpO6dfiMcbqLWD11gcgZghhsavPGL9NFRqFUYl6zmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509623; c=relaxed/simple;
	bh=TuTC4xMc7GZShagg8C4/PapTgXr8QVOOxVdDj2YUO5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqxCBjZcPo//ZrKCUG6FgUNyzX7yljUEmBkATfO7ufv3wsp1ncysl5qB6jRqixAdpd+zaTS5S5Ey95mh4HmbW3MpS29q/58iHq51S0ZFnsw8nssicmBNdSsGgV99+X+O2bJPUCjQQqDLhT45CbeKjnghCSWpmCIM++VsNmwMDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beELly/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD3C4AF09;
	Tue,  4 Jun 2024 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509623;
	bh=TuTC4xMc7GZShagg8C4/PapTgXr8QVOOxVdDj2YUO5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beELly/CphT0spKfPrIMjBbO5t3cx+jVCiTq36qfzDNQjw0il4I6dzs2iUfkBKypM
	 F7jMyF/XKkAklCMlGdzkWifNgDZonhtqeN3tmQDnBLKs2Od3Scow1bRD9v/3nIwSXM
	 edownA4rOB3pMgM4a4Nt0fWHMFsT8iA5swWTp88PkMtT/8Ng6XLmIIZS+rKfy5/GZJ
	 D2gkPeVeWqQVQlN009nnVkAS69lEI0BFV2Pt/jhMpMAmcbDBzADyEDAFVZXcDtF9ev
	 L/dzAupQ4fqSucbVpG7NSjdlq/HQxNY4Iyuo6JVYLUhskLbmd0An/rUDGT6C6/xyjK
	 TZBqXSSZOEN1w==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Li Yang <leoyang.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 10/10] ARM: dts: imx6qdl-kontron-samx6i: add actual device trees
Date: Tue,  4 Jun 2024 15:59:34 +0200
Message-Id: <20240604135934.1951189-11-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604135934.1951189-1-mwalle@kernel.org>
References: <20240604135934.1951189-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, there wasn't any in-tree users of the dtsi files for the
Kontron SMARC-sAMX6i board. Let's add device trees, for this board on a
Kontron SMARC Eval 2.0 Carrier.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../nxp/imx/imx6dl-kontron-samx6i-ads2.dts    |  12 ++
 .../dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts |  12 ++
 .../nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi  | 121 ++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 231c0d73a53e..92e291603ea1 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -99,6 +99,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-icore.dtb \
 	imx6dl-icore-mipi.dtb \
 	imx6dl-icore-rqs.dtb \
+	imx6dl-kontron-samx6i-ads2.dtb \
 	imx6dl-lanmcu.dtb \
 	imx6dl-mamoj.dtb \
 	imx6dl-mba6a.dtb \
@@ -207,6 +208,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-icore-ofcap10.dtb \
 	imx6q-icore-ofcap12.dtb \
 	imx6q-icore-rqs.dtb \
+	imx6q-kontron-samx6i-ads2.dtb \
 	imx6q-kp-tpc.dtb \
 	imx6q-logicpd.dtb \
 	imx6q-marsboard.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
new file mode 100644
index 000000000000..6a0c53f23a15
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-kontron-samx6i.dtsi"
+#include "imx6qdl-kontron-samx6i-ads2.dtsi"
+
+/ {
+	model = "Kontron SMARC-sAMX6i Dual-Lite/Solo on SMARC Eval 2.0 carrier";
+	compatible = "kontron,imx6dl-samx6i-ads2", "kontron,imx6dl-samx6i", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
new file mode 100644
index 000000000000..94c395cc020e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-kontron-samx6i.dtsi"
+#include "imx6qdl-kontron-samx6i-ads2.dtsi"
+
+/ {
+	model = "Kontron SMARC-sAMX6i Quad/Dual on SMARC Eval 2.0 carrier";
+	compatible = "kontron,imx6q-samx6i-ads2", "kontron,imx6q-samx6i", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
new file mode 100644
index 000000000000..e5b3183d4ae0
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree include for the Kontron SMARC-sAMX6i board on a SMARC Eval
+ * 2.0 carrier (ADS2).
+ *
+ */
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	sound {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Out Jack",
+			"Microphone", "Microphone Jack",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"Line Out Jack", "LINEOUTR",
+			"Line Out Jack", "LINEOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Headphone Jack", "HPOUTL",
+			"IN1L", "Line In Jack",
+			"IN1R", "Line In Jack",
+			"Microphone Jack", "MICBIAS",
+			"IN2L", "Microphone Jack",
+			"IN2R", "Microphone Jack";
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&wm8904>;
+		};
+	};
+};
+
+&audmux {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+&ecspi4 {
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		m25p,fast-read;
+		spi-max-frequency = <100000000>;
+		reg = <1>;
+	};
+};
+
+&fec {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	wm8904: audio-codec@1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		clocks = <&clks IMX6QDL_CLK_CKO2>;
+		clock-names = "mclk";
+	};
+};
+
+&i2c3 {
+	eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+&usdhc3 {
+	status = "okay";
+};
-- 
2.39.2


