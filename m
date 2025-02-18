Return-Path: <linux-kernel+bounces-518750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E51A3940D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3763B6F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A91DE2D7;
	Tue, 18 Feb 2025 07:43:00 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A31DE2BC;
	Tue, 18 Feb 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864579; cv=none; b=aMP/wfXxuc4nXu9XMXqxlt15Eq2AGebOHyWDd6algK9XMxM+wmtitapWIXYIbS3fyiSFPhDJ0SErjX8o3WRJGp1MqggAWquuf6kysEAr4xkpn1CsPWWbvj7YPJjoCmXDVN744ZGsBRsgtCjNRCyJwQRL8e1tsESnZMBthj4nGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864579; c=relaxed/simple;
	bh=181kaWNaGjBhyZTmRFrjgfsKp25rrab/bDDvrYVH/nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7I5jcb5PLQlRDldCKLzpUMSa8DS9dhh9F93npd/f0BydT9RBFwHmKNRvlGw8NQqlu37QBrM/MVE1vbzEQTG8KEA3ZIpeIh86iZnUVOEKtq8addOT7Frhv/nzztQCl4LIjq/naPqU0B5U0GY87MeXEN0B9hChlmmPxG6oeL/ftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFt-00G0MD-0s;
	Tue, 18 Feb 2025 08:42:56 +0100
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
Subject: [PATCH v3 13/15] arm64: dts: imx8mm-phycore-som: Add overlay for rproc
Date: Tue, 18 Feb 2025 08:41:54 +0100
Message-Id: <20250218074156.807214-14-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218074156.807214-1-andrej.picej@norik.com>
References: <20250218074156.807214-1-andrej.picej@norik.com>
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

From: Dominik Haller <d.haller@phytec.de>

Adds a devicetree overlay containing reserved memory regions used
for intercore communication between A53 and M4 cores.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- updated copyright year,
- added address-cells and size-cells to the root node to fix a dts
  check warning.
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../dts/freescale/imx8mm-phycore-rpmsg.dtso   | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 7e0fef7ed9de..a10c8b5c2c4a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -125,9 +125,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
 
 imx8mm-phyboard-polis-peb-av-10-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-av-10.dtbo
 imx8mm-phyboard-polis-peb-eval-01-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-eval-01.dtbo
+imx8mm-phycore-rpmsg-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phycore-rpmsg.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-av-10.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-eval-01.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-phycore-rpmsg.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-prt8mm.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso
new file mode 100644
index 000000000000..43d5905f3d72
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Dominik Haller <d.haller@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/imx8mm-clock.h>
+
+&{/} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		m4_reserved: m4@80000000 {
+			reg = <0 0x80000000 0 0x1000000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@b8000000 {
+			reg = <0 0xb8000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@b8008000 {
+			reg = <0 0xb8008000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: rsc_table@b80ff000 {
+			reg = <0 0xb80ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@b8400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xb8400000 0 0x100000>;
+			no-map;
+		};
+	};
+
+	core-m4 {
+		compatible = "fsl,imx8mm-cm4";
+		clocks = <&clk IMX8MM_CLK_M4_DIV>;
+		mboxes = <&mu 0 1
+			&mu 1 1
+			&mu 3 1>;
+		mbox-names = "tx", "rx", "rxdb";
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>, <&rsc_table>;
+		syscon = <&src>;
+	};
+};
-- 
2.34.1


