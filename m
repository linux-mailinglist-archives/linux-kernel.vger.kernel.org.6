Return-Path: <linux-kernel+bounces-294390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC691958D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94330285F09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E351C6880;
	Tue, 20 Aug 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="nPzowpGQ"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F11C4623
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174371; cv=none; b=Zk8OhqwOcwAuSSEUe67ItDOMVMYLpze0lSwKoaX2O/uTEzBxDadjGgcO+OUvP1nyV8lmSPXFsx1dcBSqt5as/P3PEAJnXknlADyzy0O6WvhZX1zcCKYWFkHM7/lana/VreqF1TR2nHN3eNFt2IWCh5Wjp8YIj6rfi+ew2qTSvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174371; c=relaxed/simple;
	bh=RPF2mQ37nvJ3f8062+c/Prugaw2ureejisesb3lQUkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o73QTB85G9DTZ0+fGGuxNt3WkCqG6IX7F4ApoGW3lkhuSKf2uEjp4Mg6LKuirLq4Bd1nIU840V4pcpthUl7gi5UgSicPE2ItGAJLljsZxKzdJQSCy4009MEK4EEN7rNLOoP/kg5MmfM6MgIRYT/WrroQPkYSal3qcHqJdhSJ1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=nPzowpGQ; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724174356; x=1726766356;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RPF2mQ37nvJ3f8062+c/Prugaw2ureejisesb3lQUkE=;
	b=nPzowpGQTzm8rtQhaRrU4Uy0ZGAllmLTWuBVtft82YnQ+OCNsVe7TzVGYsFW1qwo
	yUJdqNQm7qIJt6tzEyIb8fpxNBHk+GP3skQ/j+2f5+RCzJWBrkWU9/Ajqll9d4ZQ
	mo7u7Y0vAhdvlgWKuVe3dxmq7lTVAaotJJNX584RqFk=;
X-AuditID: ac14000a-03251700000021bc-18-66c4d014acc3
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D1.70.08636.410D4C66; Tue, 20 Aug 2024 19:19:16 +0200 (CEST)
Received: from llp-varakala.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 20 Aug
 2024 19:19:15 +0200
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <y.varakala@phytec.de>
Subject: [PATCH v2 3/3] arm64: dts: Add phyBOARD-Pollux dtso for rpmsg
Date: Tue, 20 Aug 2024 19:18:48 +0200
Message-ID: <20240820171848.177926-4-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820171848.177926-1-y.varakala@phytec.de>
References: <20240820171848.177926-1-y.varakala@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42JZI8nAqyty4UiawYVHfBZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CV0d31gbVg
	hWTF/DWdTA2M+0W7GDk5JARMJP7c2cnUxcjFISSwhEmiu7OZHcJ5yijxq/EHM0gVm4C+xIp1
	i1hBEiICyxglvp3uZgFxmAW2M0qcmPiOCaRKWMBN4vyuHewgNouAqsSc+1/BbF4BK4lN838y
	QeyTl9h/8CzQVA4OTgFriVU/M0DCQkAl+1fvYIQoF5Q4OfMJC4jNDFTevHU2M4QtIXHwxQtm
	iHpFifcPO9hhRk4795oZwg6VmL/mO/sERqFZSEbNQjJqFpJRCxiZVzEK5WYmZ6cWZWbrFWRU
	lqQm66WkbmIExZMIA9cOxr45HocYmTgYDzFKcDArifB2vzyYJsSbklhZlVqUH19UmpNafIhR
	moNFSZx3dUdwqpBAemJJanZqakFqEUyWiYNTqoHRwmXZprcXnm6/3lLg/0Lwd4bnx6pyL92S
	mVn/X1xT3FNruCrejePFtzVaWQxHzUI7+K7F1gU9m7i71Pl1PotEl/nTwtigR9JS7f4iqfPz
	axa2VfI/NjStq2GwUnom/LpAWcqzztsk9tCiXwL5DxPWftv0XWX/S9bZFnN+7l1w+626y3XF
	MmMlluKMREMt5qLiRAAuPywalQIAAA==

Adds a devicetree containing reserved memory regions used for intercore
communication between A53 and M7 cores.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
Changes in v2:
- Updated license.
- Updated devicetree properties.
- Replaced imx8mp-cm7 with core-m7 node name.
- Updated reserved-memory node unit addresses in ascending order.

 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../dts/freescale/imx8mp-phycore-rpmsg.dtso   | 55 +++++++++++++++++++
 2 files changed, 57 insertions(+)
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
index 000000000000..f9fba558dcb0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
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
+	core-m7 {
+		compatible = "fsl,imx8mn-cm7";
+		clocks = <&clk IMX8MP_CLK_M7_DIV>;
+		mboxes = <&mu 0 1>,
+			<&mu 1 1>,
+			<&mu 3 1>;
+		mbox-names = "tx", "rx", "rxdb";
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>, <&rsc_table>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
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
+
+		rsc_table: rsc-table@550ff000 {
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
+		m7_reserved: m7@80000000 {
+			no-map;
+			reg = <0 0x80000000 0 0x1000000>;
+		};
+	};
+};
-- 
2.34.1


