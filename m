Return-Path: <linux-kernel+bounces-293414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCC957EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE78284696
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D03218C009;
	Tue, 20 Aug 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vNPXR8Eq"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C692176249;
	Tue, 20 Aug 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137582; cv=none; b=S+00OjEpN+VyM/bHEKFzaTuB60bpp60UCfwbZgvPj8HWAg9z2SB6oBcSK5Rr5jXs/Pz1xA8L2lV3f90K4Ztx73qGb27jaKuCqL53p82a8BDem3zIAywZuKaYU0R1JOZOLhWsdsTs72jb6Zwqp4Zx8NtKF8QD3EOJvq38AVoVvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137582; c=relaxed/simple;
	bh=Fe+rWJrb0SPEzQOf/GnltZmSNDX6SEOvMnvp2CEWjyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snsbPKuU4cYtFH6qH9yuJdMTeO3nwJOiVqmSploI+84Be8Ucb3BBwQh19/z4mQi/3FWtTeOCteKnxnTmmqjS7A+dt360kHkbOVmbfcaZBbBoa9Q07bWmfmjrYU6l1PLOspu2B3l6lYt2leoqPuLF83JXUbqx1kE1Hj38T2dRyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vNPXR8Eq; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47K76AbS045227;
	Tue, 20 Aug 2024 02:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724137570;
	bh=+4l8TGmHjp7lAUWWLu9C17ULqkfasvc5VTXMnL3774s=;
	h=From:To:CC:Subject:Date;
	b=vNPXR8EqzK/77Xw/Ks33BZLI/Xsb5ZXnoPhdd47Lf9uwDGu8jyPTVyvv2yq6uxYld
	 NHcF6m3I/4L4ZkM5HZalJjUC4D4jOMo94n3vKubY/k3d7s7ApFSiodyAJ3UEbwxqn1
	 D2yfnX7C0L3tiY3x1Cas8t4X0qAJr+TvZ7HVsjP8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47K76AoZ022563
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 02:06:10 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 02:06:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 02:06:10 -0500
Received: from localhost ([10.249.128.135])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47K7681C015213;
	Tue, 20 Aug 2024 02:06:09 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH] arm64: dts: ti: Add PWM and ECAP overlay for J722S-EVM
Date: Tue, 20 Aug 2024 12:36:07 +0530
Message-ID: <20240820070607.30628-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The J722S-EVM has 3 PWM outputs and 1 ECAP output routed
to the J28 connector. This overlay will set the appropriate
pinmux and enable PWM and ECAP on the pins.

Currently enabled PWM output on J28: 29, 31, 33 pins
and ECAP output on J28: 32 pin

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile              |  1 +
 arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso | 53 ++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e20b27ddf901..61d51284dcba 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -111,6 +111,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
 
 # Boards with J722s SoC
 dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-pwm.dtbo
 
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso b/arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso
new file mode 100644
index 000000000000..f6d1f072b140
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm-pwm.dtso
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT Overlay for enabling PWM output on User Expansion header on J722S-EVM
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&main_pmx0 {
+
+	main_epwm0_pins_default: main-epwm0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01b4, PIN_OUTPUT, 2) /* (B20) EHRPWM0_A */
+		>;
+	};
+
+	main_epwm1_pins_default: main-epwm1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01bc, PIN_OUTPUT, 2) /* (D20) EHRPWM1_A */
+			J722S_IOPAD(0x01c0, PIN_OUTPUT, 2) /* (E19) EHRPWM1_B */
+		>;
+	};
+
+	main_ecap0_pins_default: main-ecap0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01b8, PIN_OUTPUT, 3) /* (C20) ECAP0_IN_APWM_OUT */
+		>;
+	};
+};
+
+&epwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_epwm0_pins_default>;
+	status = "okay";
+};
+
+&epwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_epwm1_pins_default>;
+	status = "okay";
+};
+
+&ecap0 {
+	/* ECAP in APWM mode */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_ecap0_pins_default>;
+	status = "okay";
+};
-- 
2.34.1


