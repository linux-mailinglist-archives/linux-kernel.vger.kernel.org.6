Return-Path: <linux-kernel+bounces-573240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E45A6D4A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB5216A447
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05818DB3D;
	Mon, 24 Mar 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Rokle0Mo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AmDV1bBx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE52505B0;
	Mon, 24 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800281; cv=none; b=Bb0ff2VDyJUncvZPyQDr/c+n3eTEWLxuHvxb+LkAtXDAaCS2b4DBckdBPScTBAcShBVC/tBwwl+dp3jgedEF+XudJ2KG6ihpLHIGtk35vBhppmviHvRpQjGClb8jGs+chaIGzMT5tTM/Da5sCn8Oj3fHl03UUFiia5ce5h6fDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800281; c=relaxed/simple;
	bh=BttsNcvtEAY8qENbSaiuaP5GuCIWfW/xnhjxPwDqsaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X19vGj894JnY5vFJRlFRLqyFzgvcWkD4MlwpxQ6f149M8evRnBdAIa2++FtwCeP713FN3IiWZYMNA/PiTIjXNVYzhHR/MG56NffQE9FoFYUZ125QG6M+A3KzBEGFmD142BONJLBtYUhm02jfj438sumIpU5wXGwgo14IopJzYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Rokle0Mo; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AmDV1bBx reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1742800279; x=1774336279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1QOn/VcMgwylA5HZCOMHYuUc7B18NcLU+TTD9nGA3U=;
  b=Rokle0Mo2n8Hb3fVG8HDs8req2M6g/hWKmtkajVJqarQJ1KS1DzfpOg9
   yuq7V6Dqcf1BExXfV8wTq/Lhj0Dp3PB/2s/TYOzWr2RAT+5zwtJPmJkw9
   e6EJZk0B3osMIROvH2wD6bR9X9X5ntIFpG4DEHGlQFI6grlqN7L+4C/5A
   s4pBeaeOnmJaBCHYstlHvLfkM8Cjnw5DyB02nsUvDYWxJW0rfdYh/eM+R
   AAAwoi6DFJBVEo74Np/lHna9sAOCEABpQrv0AcQbTFrhX4oNWrKHenfoF
   7NuxQyYsQHSkqifgOYqoVi+CCGfEodnIwGqHaOsn6/xBedQ827/8A7Kob
   A==;
X-CSE-ConnectionGUID: R2RcUQH0QHKr7eY47sYCAw==
X-CSE-MsgGUID: euw65TumQUiD3LV0HcNb2A==
X-IronPort-AV: E=Sophos;i="6.14,271,1736809200"; 
   d="scan'208";a="43112358"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Mar 2025 08:11:17 +0100
X-CheckPoint: {67E10595-25-7141A0B0-E6EDEC14}
X-MAIL-CPID: DE93D7253E7B8E57C27EA670D1C70106_3
X-Control-Analysis: str=0001.0A006376.67E10590.0052,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C975B1677DC;
	Mon, 24 Mar 2025 08:11:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1742800273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1QOn/VcMgwylA5HZCOMHYuUc7B18NcLU+TTD9nGA3U=;
	b=AmDV1bBx6EU8XY42jN2crps/6ShfPysTFohyDm8g6juNs6bn3iiWQ7w1vGpmH8o+FjJzN7
	ygmW3VgheLrTJ01/QT81Z5EzM4c1a0XOlUC3bTntUgS8RCQFWODa9jDfY+TcSgKfMy5O28
	RvlIFvaUiXN5leMUQwXsR/waPCvBTS0WhDRvkEcTuOsa0Zw7EPHPijF+D3KCVzEJcZw98t
	RAxFRsb92y1NT5QSj4R1+W2/AegI/wijGyqK2LGKOSdqxAiSgWAOtqZiP6675RZ584mVkO
	n95I0wYKGzmsa30VscHWSZIgX6juwiAzF0opnLP/Wn8FAyF5IpIJeU4t8bNTsw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 2/2] arm64: dts: imx8mp-tqma8mpql-mba8mp-ras314: Add Raspberry Pi Camera V2 overlay
Date: Mon, 24 Mar 2025 08:11:00 +0100
Message-ID: <20250324071102.23765-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324071102.23765-1-alexander.stein@ew.tq-group.com>
References: <20250324071102.23765-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This overlay configures IMX219 MIPI-CSI-2 camera attached to ISP1.
Also add additional overlay both using LVDS display and camera.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 ...imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtso | 107 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index d7ac8dda4bde5..b5cd2efd260cb 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -247,10 +247,14 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk-pcie-ep.dtb
 
 imx8mp-tqma8mpql-mba8mpxl-lvds-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds.dtbo
 imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtbo
+imx8mp-tqma8mpql-mba8mp-ras314-imx219-dtbs += imx8mp-tqma8mpql-mba8mp-ras314.dtb imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtbo
 imx8mp-tqma8mpql-mba8mp-ras314-lvds-dtbs += imx8mp-tqma8mpql-mba8mp-ras314.dtb imx8mp-tqma8mpql-mba8mpxl-lvds.dtbo
+imx8mp-tqma8mpql-mba8mp-ras314-lvds-imx219-dtbs += imx8mp-tqma8mpql-mba8mp-ras314.dtb imx8mp-tqma8mpql-mba8mpxl-lvds.dtbo imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl-lvds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314-lvds.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314-lvds-imx219.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtso
new file mode 100644
index 0000000000000..0bc96d242f33f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314-imx219.dtso
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/media/video-interfaces.h>
+
+#include "imx8mp-pinfunc.h"
+
+&{/} {
+	/*
+	 * The three camera regulators are controlled by a single GPIO. Declare
+	 * a single regulator for the three supplies.
+	 */
+	reg_cam: regulator-cam {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_cam";
+		/* pad muxing already done in gpio2grp */
+		gpio = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_vcc_3v3>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	cam24m: cam24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "cam24m";
+	};
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	camera@1a {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+		clocks = <&cam24m>;
+		VANA-supply = <&reg_cam>;
+		VDIG-supply = <&reg_cam>;
+		VDDL-supply = <&reg_cam>;
+		orientation = <2>;
+		rotation = <0>;
+
+		port {
+			sony_imx219: endpoint {
+				remote-endpoint = <&imx8mp_mipi_csi_in>;
+				clock-lanes = <0>;
+				clock-noncontinuous;
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64 <456000000>;
+			};
+		};
+	};
+};
+
+&isi_0 {
+	status = "disabled";
+
+	ports {
+		port@0 {
+			/delete-node/ endpoint;
+		};
+	};
+};
+
+&isp_0 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			isp0_in: endpoint {
+				bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
+				remote-endpoint = <&mipi_csi_0_out>;
+			};
+		};
+	};
+};
+
+&mipi_csi_0 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			imx8mp_mipi_csi_in: endpoint {
+				remote-endpoint = <&sony_imx219>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&mipi_csi_0_out {
+	remote-endpoint = <&isp0_in>;
+};
-- 
2.43.0


