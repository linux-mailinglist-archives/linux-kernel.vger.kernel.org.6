Return-Path: <linux-kernel+bounces-262008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B193BF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF87F1F219A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F2198E99;
	Thu, 25 Jul 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="RXDyVU6N"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE1198E7B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900779; cv=none; b=hZhtStxTCwg3LjxpxeDGgvyXWz97Nro2y37o9L72VecgUbrNwXopOJZ6UckFNWEidPk/1//LLVPqOO35P1pFfSXLrrwfKlPiwwitmHkvxAxQCmiLxRppMSbWBN5I5jXVHr3JTdWfkv8mBuRgBOcnDsLW5jSb9aaFFxf/vBMGkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900779; c=relaxed/simple;
	bh=knpkfnvnvwcrz9cZx6YcJrflh2oifIF3IzZO/sdQ7vI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEKah+0Jg+6im0l/Ty68LVV3V7/c1LPHlbR3S5Jtiwm5EpaO9DrV84zhiJWpkxbykMbAToRfSFQG5j8uGxOa2vS14ruHYxEgO6etDpJWWX2GOFeTQxyYkOQOPdcDaX2Ma+kNzRIhBk0ygmMVOd4nQ2LBOT7Pm5ku/UcR6k8UKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=RXDyVU6N; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1721900762; x=1724492762;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=knpkfnvnvwcrz9cZx6YcJrflh2oifIF3IzZO/sdQ7vI=;
	b=RXDyVU6N/Yiojvuln01aUvNBIfe20PWmzTIDp+2irDR1WqvCWZ59NT+SU512KucS
	RJQN2wunka0JxbyhzFAuQr/kbBO66x1EUEy3HQG3uXexzmyNS5QZv0MjjslmYCXN
	KgsEw3VwzZw9W+HDuIfLHSVFJLVTeJtdegp8AD2tbhY=;
X-AuditID: ac14000a-03251700000021bc-f0-66a21edaf27f
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 16.CC.08636.ADE12A66; Thu, 25 Jul 2024 11:46:02 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 25 Jul
 2024 11:46:02 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
Date: Thu, 25 Jul 2024 11:44:57 +0200
Message-ID: <20240725094457.37739-4-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725094457.37739-1-y.varakala@phytec.de>
References: <20240725094457.37739-1-y.varakala@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42JZI8nAq3tLblGawaV1ChZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVseubU0Gv
	RMXJ3SeYGhh3i3QxcnJICJhI/J15nqWLkYtDSGAJk8TiA/vZIZynjBKrbn9mBqliE9CXWLFu
	EStIQkRgGaPEt9PdYC3MAtsZJU5MfMcEUiUs4CRxZ1oXO4jNIqAq0dz7EKybV8BSYt2qI6wQ
	++Ql9h88CxbnFLCSuP6nCaxXCKjmX8seNoh6QYmTM5+wgNjMQPXNW2czQ9gSEgdfvGCGqFeU
	eP+wgx1m5rRzr5kh7FCJ+Wu+s09gFJqFZNQsJKNmIRm1gJF5FaNQbmZydmpRZrZeQUZlSWqy
	XkrqJkZQPIkwcO1g7JvjcYiRiYPxEKMEB7OSCO+y+wvThHhTEiurUovy44tKc1KLDzFKc7Ao
	ifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTCGmTrdWiJfsSzj5N0u3bRfvFvdXBlS9mSf1T//
	s079ZdmCee4xZ6JSe3dPEe5tV45gyNu3aO+hKV4bIw++4b6VZrWedfbFSq/dSoaHW3T0Ew77
	JHg9iD6xSOZ+ttP9spccfAkanXYa/HcNN5kITE/+l3H+h0tngaeTWOnX4EvLAjl32wS/W6bE
	UpyRaKjFXFScCABv7KTTlQIAAA==

Adds a devicetree containing reserved memory regions used for intercore
communication between A53 and M7 cores.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../dts/freescale/imx8mp-phycore-rpmsg.dtso   | 57 +++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index dedea4b5c319..80cc87d50301 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -177,9 +177,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 imx8mp-phyboard-pollux-rdk-no-rtc-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-rtc.dtbo
 imx8mp-phyboard-pollux-rdk-no-spiflash-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-spiflash.dtbo
+imx8mp-phyboard-pollux-rdk-rpmsg-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-rpmsg.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-rtc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-spiflash.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-rpmsg.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso
new file mode 100644
index 000000000000..a5694f3aecaa
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Dominik Haller <d.haller@phytec.de>
+ * 	   Cem Tenruh <c.tenruh@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+&{/} {
+	imx8mp-cm7 {
+		compatible = "fsl,imx8mn-cm7";
+		clocks = <&clk IMX8MP_CLK_M7_DIV>;
+		mboxes = <&mu 0 1
+			&mu 1 1
+			&mu 3 1>;
+		mbox-names = "tx", "rx", "rxdb";
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>, <&rsc_table>;
+		rsc-da = <0x55000000>;
+		status = "okay";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		m7_reserved: m7@0x80000000 {
+			no-map;
+			reg = <0 0x80000000 0 0x1000000>;
+		};
+
+		rsc_table: rsc_table@550ff000 {
+			no-map;
+			reg = <0 0x550ff000 0 0x1000>;
+		};
+
+		vdevbuffer: vdevbuffer@55400000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0 0x55400000 0 0x100000>;
+		};
+
+		vdev0vring0: vdev0vring0@55000000 {
+			no-map;
+			reg = <0 0x55000000 0 0x8000>;
+		};
+
+		vdev0vring1: vdev0vring1@55008000 {
+			no-map;
+			reg = <0 0x55008000 0 0x8000>;
+		};
+	};
+};
-- 
2.34.1


