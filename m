Return-Path: <linux-kernel+bounces-435074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874B79E6F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E061881E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A61B207660;
	Fri,  6 Dec 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PAfOyoi0"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970F206F3C;
	Fri,  6 Dec 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491458; cv=none; b=nr03o6qGTUB/4wspEdfwLVzzDluP/KVygaNI/W645LfmHb/yrHhW+1yauYdYm6lfyqxRTxcNi2kUtjCqgw+/2C9zbUCalwSjJeyLW5122TDcdIS7WzNIHMpuKasGf78cDoeJhW547yM7r0Q3Z/W623CmBRCK6TPJC54H3Zlgfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491458; c=relaxed/simple;
	bh=Tkvv8nbrTos3ISh3g/s4VfKOXQX2n66Cr94kyLv8jtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0tsKh3rDO7Ek0HC4sZtlmspmeHOzXcQkXJajRSmk4807Hz4Nnp94bND2hN5qXCRAyhjBwgHqrNoKUcGJ6s+/j6Qpd0/zMjv3d34/KmbjutK1Yi3gwrNvBFvqJWcCJfdBraoE0ieFmR0NmsINBqZTOao5kgP/r4acM+iKv6HCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=PAfOyoi0; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout1.routing.net (Postfix) with ESMTP id 7F727403F7;
	Fri,  6 Dec 2024 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733491447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2CpAbRbq9u9WtuDg3cZhOuMl7YhAj8Mt6ZON6tTJ5Ls=;
	b=PAfOyoi0HQt9BPx4rQNXYUrByAoZD+VvnaGCs69Ep0un7VbrsSm2YYrzbk85lVkRHfEadF
	V4ezwHEJapO4MpjdqldDhgG2dHgjczBxNnZUNyRCF9av1DXEeNzBvHozSvsIu6X7ttZII9
	U8CkCOK7Kx6Zca0fJ74ejQ/GLFuwj2k=
Received: from frank-u24.. (fttx-pool-194.15.84.200.bambit.de [194.15.84.200])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 918A640044;
	Fri,  6 Dec 2024 13:24:06 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4] arm64: dts: mt7986: add overlay for SATA power socket on BPI-R3
Date: Fri,  6 Dec 2024 14:23:59 +0100
Message-ID: <20241206132401.70259-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 7d988917-a59f-423f-be98-36300de87045

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R3 has a Power socket entended for using external SATA drives.
This Socket is off by default but can be switched with gpio 8.

Add an overlay to activate it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4:
- rebased on 6.13-rc1 without the full-dtb patch
v3:
- make sata overlay better readable
v2:
- rebase on the patch "add dtbs with applied overlays for bpi-r3"
- add sata-overlay to the full dtbs
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mt7986a-bananapi-bpi-r3-sata.dtso         | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a15..d844c4ce9863 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-mini.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
new file mode 100644
index 000000000000..17659545470e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Frank Wunderlich <frank-w@public-files.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	reg_sata12v: regulator-sata12v {
+		compatible = "regulator-fixed";
+		regulator-name = "sata12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&pio 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_sata5v: regulator-sata5v {
+		compatible = "regulator-fixed";
+		regulator-name = "sata5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		vin-supply = <&reg_sata12v>;
+	};
+
+};
+
-- 
2.43.0


