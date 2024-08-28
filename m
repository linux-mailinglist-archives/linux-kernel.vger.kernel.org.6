Return-Path: <linux-kernel+bounces-304535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5892E962171
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10768281D44
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875C15ADB3;
	Wed, 28 Aug 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="bKlbx7Ro"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA71158DC3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830752; cv=none; b=AlZGgcuN2yoK5mYiBxVL8/EEY16gnSuo9JP42qa/kNmD+CkrYIiVY95m0TI5cQzBlax8j94ySW1/NI7t6WWwsGYGf4KQ5AmGdjrB9knniCyK6D8v6mvQ4vRHwLqamsd5BgxSxfcTbTkPOvHiZC/R5TdwO5aB+9NRq4Iv96d/Sh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830752; c=relaxed/simple;
	bh=D3i8I29dnjYpY2YEOnJRatT2I/uzWa0wJQgTFNjqHio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq3lVL+3kYWFDMsHCvZ7goykt2uJMWO9DtM9V5No8EnRM4soeJCpD0ySUrhfRDGW6MkhcQdxIIwlOreq3lTu9OKZw5sTRHg/sIu4LZTP6Tn1hUi56K+XKMMJ7eFOXIFZngj3008odj8HpYuluJKJwx/PrYzs1HeYxNVARG85YRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=bKlbx7Ro; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202408280739039f607471c036ac5fb9
        for <linux-kernel@vger.kernel.org>;
        Wed, 28 Aug 2024 09:39:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pqZh8ugBUzS0KjKdpY21bkII61KbUFnlwl/MGSXTO4Q=;
 b=bKlbx7RoEJQSrMGJkWHFizfDg6uwmDrwowvoiDYQTWvjuqV9gazeQzdx5vFMWM4GNrQpCV
 PrpKxHTPacSopCR+AIU5boTK3r54SyR/baFmXdu+L1QBBawXzXJvW5x0Efq/9v7uN97qPbeT
 8zk5uMnCC85isQItjq0+lvQJiyCHyxQRgApg3QQBHWc6MwTMINF38UbPzXV/0fbIfrmnzTKB
 AOLkS69KDffYpgv/I3ag2KdQffU7fr7JUoUpaahdIwhSujj+nAnyxFDH15q9FAlpcse45R4C
 kit/IfTlGijJNzv6F42WbCStNTF1g5ijSQHZX9VpaV3aT3bUpV6TSOkg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: iot2050: Add overlays for M.2 used by firmware
Date: Wed, 28 Aug 2024 09:39:01 +0200
Message-ID: <91f8b825467651ebd51a4051f153ab136eeb1849.1724830741.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724830741.git.jan.kiszka@siemens.com>
References: <cover.1724830741.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

To allow firmware to pick up all DTs from here, move the overlays that
are normally applied during DT fixup to the kernel source as well. Hook
then into the build nevertheless to ensure that regular checks are
performed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  6 +++
 ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso | 27 +++++++++++
 ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso | 47 +++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e20b27ddf901..8dbe7b4979c7 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -73,10 +73,16 @@ k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
 	k3-am654-pcie-usb3.dtbo
 k3-am654-evm-dtbs := k3-am654-base-board.dtb k3-am654-icssg2.dtbo
 k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo k3-am654-pcie-usb2.dtbo
+k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-dtbs := k3-am6548-iot2050-advanced-m2.dtb \
+	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtbo
+k3-am6548-iot2050-advanced-m2-bkey-usb3-dtbs := k3-am6548-iot2050-advanced-m2.dtb \
+	k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-usb3.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-sm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
new file mode 100644
index 000000000000..666237f6d79c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOT2050 M.2 variant, overlay for B-key PCIE0_LANE0 + E-key PCIE1_LANE0
+ * Copyright (c) Siemens AG, 2022-2024
+ *
+ * Authors:
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&pcie0_rc {
+	num-lanes = <1>;
+	phys = <&serdes0 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy0";
+	reset-gpios = <&main_gpio1 15 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie1_rc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso
new file mode 100644
index 000000000000..0f86235c9771
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOT2050 M.2 variant, overlay for B-key USB3.0 + E-key PCIE1_LANE0
+ * Copyright (c) Siemens AG, 2022-2024
+ *
+ * Authors:
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&serdes0 {
+	assigned-clock-parents = <&k3_clks 153 7>, <&k3_clks 153 4>;
+};
+
+&pcie0_rc {
+	status = "disabled";
+};
+
+&pcie1_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&minipcie_pins_default>;
+
+	num-lanes = <1>;
+	phys = <&serdes1 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy0";
+	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&dwc3_0 {
+	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
+	phys = <&serdes0 PHY_TYPE_USB3 0>;
+	phy-names = "usb3-phy";
+};
+
+&usb0 {
+	maximum-speed = "super-speed";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+};
-- 
2.43.0


