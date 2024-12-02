Return-Path: <linux-kernel+bounces-427009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16D9DFB29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4F1165266
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA621FC0EB;
	Mon,  2 Dec 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="lvDr9KMw"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3391FBCB6;
	Mon,  2 Dec 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124093; cv=none; b=XUkSBkQAOa93q3K5I4ejg8kIL5Ke0gmb9jWFQ2Ibfq01OFkbWgyBaY00ZVE9glY7qrQ/m5QN7zYhSmW0L/qZtlJJ/b5TdnkZnx8QUKVSIFjpZTQeh3evcdIZIS36+rI2MaVCpxv+v1lZwgGAzs0iTv5GIKroOpe/Bu6uV7CIOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124093; c=relaxed/simple;
	bh=rHic5IzRZgoHr+kddtOq9kzilx5r4zHV74WhXMZUi1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lu9X97Lng9McO2OTLSOqCb+5HaEoAcCSv+73ZtjXOWaCMnGbX12J2IgER9fCOfYeBdK+DSbo2oa2OCJl+jHbE8Pz9uvvFyvMqE95nFlvX/Tp5J9hytjJaq7vGv+xwsGOI4tpepj9pFYTFBuaNQZFVj7MGWv/c67TAozcvCqih80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=lvDr9KMw; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cG2xOtfHFuhOgbTSnjFFp3cDu4M2Sf8eSDUv8xZDtW0=; b=lvDr9KMweTYwcYTBNdNjxPOUOg
	jCJagkRlx9gdry/pA8f8/w1EfQZnDZzTRlCO1RwDWGyw0eSxr01vEcA4DHK7k9JwUVBrBSxk6nT/U
	ux7xBT6WkNUcHDIKk1ojIWEZ53gdL/ex5C9jr+ui7waE7RyB383eZbzDu55zG3ism+tM3D2calB3X
	sZs5UuVrpAG3VX9XQCoFCGN52YVP9Xw3lFQSxzxuanM0C2c1VhNrIK4JMBZUv4WrWkO5ztig5ESSO
	p31KocBfmxItHokGm66OtrA7rFRrKnYHMKLs/Y4YYoFRj6R5mExU+POr71X2Uo//JrjXA0kY0Avlt
	7qGh9LOw==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0kL-007Bva-03;
	Mon, 02 Dec 2024 08:21:29 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 12/15] arm64: dts: imx8mm-phyboard-polis: Add overlay for PEB-EVAL-01
Date: Mon,  2 Dec 2024 08:20:49 +0100
Message-Id: <20241202072052.2195283-13-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202072052.2195283-1-andrej.picej@norik.com>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Janine Hagemann <j.hagemann@phytec.de>

Add support for the PEB-EVAL-01 expansion board for
phyBOARD-Polis-i.MX8MM.

Signed-off-by: Janine Hagemann <j.hagemann@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change.
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx8mm-phyboard-polis-peb-eval-01.dtso    | 72 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index b411d76c3d1d..99be36a04db9 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -124,8 +124,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
 
 imx8mm-phyboard-polis-peb-av-10-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-av-10.dtbo
+imx8mm-phyboard-polis-peb-eval-01-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-eval-01.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-av-10.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-eval-01.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-prt8mm.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso
new file mode 100644
index 000000000000..2ca4ae6e2bf2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-peb-eval-01.dtso
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Janine Hagemann <j.hagemann@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include "imx8mm-pinfunc.h"
+
+&{/} {
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		button-0 {
+			label = "home";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		button-1 {
+			label = "menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	user-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_user_leds>;
+
+		user-led1 {
+			gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		user-led2 {
+			gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		user-led3 {
+			gpios = <&gpio5 28 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_gpio_keys: gpio_keysgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17	0x16
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x16
+		>;
+	};
+
+	pinctrl_user_leds: user_ledsgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15	0x16
+			MX8MM_IOMUXC_UART4_RXD_GPIO5_IO28	0x16
+			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14	0x16
+		>;
+	};
+};
-- 
2.34.1


