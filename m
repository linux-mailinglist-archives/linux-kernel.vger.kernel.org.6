Return-Path: <linux-kernel+bounces-427007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70359DFB25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0477B164EEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0A1FBEB2;
	Mon,  2 Dec 2024 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="gHhv5Kn6"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7971FBCB7;
	Mon,  2 Dec 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124092; cv=none; b=JUR+uX6PR8lcQ7ml8DdpsyJHzsHObdMMZbNSATAl3Oi8Bpo8La9hz4+3uWxR0+3+5b1MK/VxOyqLltkX0NiPjbNfuS2wHvgX50QJGSeqBdx1rB54G7DhYIlmCpH8oDzhrdghX2UJaEuL9bySweUBhsqe+9Hd2Ar6TDW91pBJ8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124092; c=relaxed/simple;
	bh=m/CStDYik1XPw56Ca4UVOxx9VrnUv0tgdJxVt314jKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWcMfyrHs01qtqYBcYwTPLn83Xre/VFPfXSsrQWMzY+OzunWjmMa2rNxwKWl8A/yb+07nCh9o0WMbsEqXCmpmjn+vctmHrRx8K7q11oDElHG6WNLmpw79W7o/pIfwdlotgX8wHEiFPrM133El3N25QcsEf8+WMYSBdBbfQuZ3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=gHhv5Kn6; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yykSqevAva+lBH0Va1bVk1QAH4KbCgytBLMT8VwX7U4=; b=gHhv5Kn67+kKUIdTiGgM//i6Hj
	d0pGr7r3St6s+bL0tmearvYjK67oeKkYNe59tDu+uku1yK6+7SXHK7CfPcA9MjueWuNOCHuCDBNK4
	WxzXOiZmJqQTWcK2QazzQCxXfvUWpq0NShJLHwd0zjMxxx1o50MfeQhA54ImTcnODVC3TEzlOjvtc
	UaYK9LzSV6vHQKWCsTA2pf34uKLbpZL3EdiYGVcR4145GhCtmfTS57eGY6YBcGDRhg8zmep7g9AQ2
	4XE9BZSJGW8AiMnaOiHWi+o2AuV11jBPxxTfzTSXdL6Wdxvj70h3F0GuAql/L+XLSpNLvmn2xuV2q
	kxswUxFQ==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0kL-007Bva-0L;
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
Subject: [PATCH v2 13/15] arm64: dts: imx8mm-phycore-som: Add overlay for rproc
Date: Mon,  2 Dec 2024 08:20:50 +0100
Message-Id: <20241202072052.2195283-14-andrej.picej@norik.com>
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

From: Dominik Haller <d.haller@phytec.de>

Adds a devicetree overlay containing reserved memory regions used
for intercore communication between A53 and M4 cores.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change.
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../dts/freescale/imx8mm-phycore-rpmsg.dtso   | 55 +++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 99be36a04db9..5bc083a7b778 100644
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
index 000000000000..0c61946f0cf8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Dominik Haller <d.haller@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/imx8mm-clock.h>
+
+&{/} {
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


