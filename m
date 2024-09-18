Return-Path: <linux-kernel+bounces-332362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0514197B8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61471F22E73
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AA176FA7;
	Wed, 18 Sep 2024 07:57:52 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD3175562;
	Wed, 18 Sep 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646271; cv=none; b=mqTU9EPQbyA8TB0RtI7aEpgK33GVLKi+JgwVmgsSUeFjH0/BcZ7l3PtJWZEUQE288sPg5QYvTBom5q7UdXgUcs8n7KP/y7hF0ox7d4IfvXfM29xVX1OmYD0qy6z3TK3sZKASXVUaVsAfw4PHZ23PxzjNnP6alrp8YNg4I/Fd9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646271; c=relaxed/simple;
	bh=GD0bwZKzOB8h647iV+s7hMY4m4TtdxRwtdUWUFBlrYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udQdVm+/0aU8DzMdP9XCygAs+ZttAyupwxUFiTW7rXJOk1C3Oz1j4Otejdve2dHfb248KNSMBVGnVoI0dRUCduJfe2o+1TvP2JZL0UDiJ9nWd2kr21jIU3XNf7opZnijDDYjdb9BD7jzNaF8bPvk3wEG8MK1XvMpV/TKjfyw3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid10-sz.amlogic.com (10.28.11.69) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.39; Wed, 18 Sep 2024
 15:42:20 +0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>, Rob Herring
	<robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kelvin.zhang@amlogic.com>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH v3 2/3] arm64: dts: amlogic: Add Amlogic A4 reset controller
Date: Wed, 18 Sep 2024 15:42:10 +0800
Message-ID: <20240918074211.8067-3-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240918074211.8067-1-zelong.dong@amlogic.com>
References: <20240918074211.8067-1-zelong.dong@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zelong Dong <zelong.dong@amlogic.com>

Add the device node and related header file for Amlogic
A4 reset controller. The count and offset for A4 Soc
RESET registers are same as S4 Soc.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 .../arm64/boot/dts/amlogic/amlogic-a4-reset.h | 93 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi   | 10 ++
 2 files changed, 103 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h b/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
new file mode 100644
index 000000000000..f6a4c90bab3c
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __DTS_AMLOGIC_A4_RESET_H
+#define __DTS_AMLOGIC_A4_RESET_H
+
+/* RESET0 */
+/*						0-3 */
+#define RESET_USB				4
+/*						5-6*/
+#define RESET_U2PHY22				7
+#define RESET_USBPHY20				8
+#define RESET_U2PHY21				9
+#define RESET_USB2DRD				10
+#define RESET_U2H				11
+#define RESET_LED_CTRL				12
+/*						13-31 */
+
+/* RESET1 */
+#define RESET_AUDIO				32
+#define RESET_AUDIO_VAD				33
+/*						34*/
+#define RESET_DDR_APB				35
+#define RESET_DDR				36
+#define RESET_VOUT_VENC				37
+#define RESET_VOUT				38
+/*						39-47 */
+#define RESET_ETHERNET				48
+/*						49-63 */
+
+/* RESET2 */
+#define RESET_DEVICE_MMC_ARB			64
+#define RESET_IRCTRL				65
+/*						66*/
+#define RESET_TS_PLL				67
+/*						68-72*/
+#define RESET_SPICC_0				73
+#define RESET_SPICC_1				74
+/*						75-79*/
+#define RESET_MSR_CLK				80
+/*						81*/
+#define RESET_SAR_ADC				82
+/*						83-87*/
+#define RESET_ACODEC				88
+/*						89-90*/
+#define RESET_WATCHDOG				91
+/*						92-95*/
+
+/* RESET3 */
+/*						96-127 */
+
+/* RESET4 */
+/*						128-131 */
+#define RESET_PWM_AB				132
+#define RESET_PWM_CD				133
+#define RESET_PWM_EF				134
+#define RESET_PWM_GH				135
+/*						136-137*/
+#define RESET_UART_A				138
+#define RESET_UART_B				139
+/*						140*/
+#define RESET_UART_D				141
+#define RESET_UART_E				142
+/*						143-144*/
+#define RESET_I2C_M_A				145
+#define RESET_I2C_M_B				146
+#define RESET_I2C_M_C				147
+#define RESET_I2C_M_D				148
+/*						149-151*/
+#define RESET_SDEMMC_A				152
+/*						153*/
+#define RESET_SDEMMC_C				154
+/*						155-159*/
+
+/* RESET5 */
+/*						160-175*/
+#define RESET_BRG_AO_NIC_SYS			176
+/*						177*/
+#define RESET_BRG_AO_NIC_MAIN			178
+#define RESET_BRG_AO_NIC_AUDIO			179
+/*						180-183*/
+#define RESET_BRG_AO_NIC_ALL			184
+/*						185*/
+#define RESET_BRG_NIC_SDIO			186
+#define RESET_BRG_NIC_EMMC			187
+#define RESET_BRG_NIC_DSU			188
+#define RESET_BRG_NIC_CLK81			189
+#define RESET_BRG_NIC_MAIN			190
+#define RESET_BRG_NIC_ALL			191
+
+#endif
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index de10e7aebf21..3fd1c52fb55b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "amlogic-a4-common.dtsi"
+#include "amlogic-a4-reset.h"
 #include <dt-bindings/power/amlogic,a4-pwrc.h>
 / {
 	cpus {
@@ -48,3 +49,12 @@ pwrc: power-controller {
 		};
 	};
 };
+
+&apb {
+	reset: reset-controller@2000 {
+		compatible = "amlogic,a4-reset",
+			     "amlogic,meson-s4-reset";
+		reg = <0x0 0x2000 0x0 0x98>;
+		#reset-cells = <1>;
+	};
+};
-- 
2.35.1


