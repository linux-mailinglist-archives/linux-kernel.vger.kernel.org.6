Return-Path: <linux-kernel+bounces-206941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5F90101C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C401C21082
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B6176AA6;
	Sat,  8 Jun 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="fAggY7pv"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF7179BD;
	Sat,  8 Jun 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834344; cv=none; b=lr0NnF9+8pM01ZlEVJMkGf5Czz2P01pu9rmXQo/39N6Q8Jd/tmxlQ0D82bUcBoqgvTVrZUsM8Y6XSmsTYxlGLmny2Awcwx0HtMrlcAI0lotMpP6dxUgRTvRBKMmOUmcuyIIDBs9KFI9FnySDAPWdqK+zr+Kcw7+UItHiPWXgKg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834344; c=relaxed/simple;
	bh=u9h2ASGk3dgMRL3ClbaO/j9atbgc18++9OC0IL2p5Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MadXP8uo1rV4+kObXjEgD2oaQ+lM9S2a6BVVZOfD6Sr7teaCrsrxNEd6UEusZUYcUruXbIOTdbw5F8Ry3QyWLnWFtnNwCVLnmNi0nLbkdX1O2hHOu2Yvh+5Q9Y7lOi5e24tVWBN+SlNSsFfnuOgYYPRd8KZMGmw6eK2gDAFIpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=fAggY7pv; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout2.routing.net (Postfix) with ESMTP id A141F601D3;
	Sat,  8 Jun 2024 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1717833951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COBqnfw9jmd19Qe8P9hzoCORT/LkJpn4G+nYf3HB3Xk=;
	b=fAggY7pv+SXUz/Qh75i6O6aIBroOhGi+H1zgEjYVfOhB8vshCA6ZZXuosdug81T7JDkpNr
	F3/wd83pLAnPB3DM/EAFRb63WmV7f0uKq3xvlxUciChKXSaZe7CtzsQQmDuooOGAsSplUC
	zdQznpXiUbyLnPE4VZlcYbvL9JX2V3s=
Received: from frank-G5.. (fttx-pool-217.61.155.199.bambit.de [217.61.155.199])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id CCC398010F;
	Sat,  8 Jun 2024 08:05:50 +0000 (UTC)
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
	devicetree@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v3 2/2] arm64: dts: mt7986: add overlay for SATA power socket on BPI-R3
Date: Sat,  8 Jun 2024 10:05:30 +0200
Message-Id: <20240608080530.9436-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240608080530.9436-1-linux@fw-web.de>
References: <20240608080530.9436-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d825f04a-d61b-4af0-a7c3-99149f58adbc

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R3 has a Power socket entended for using external SATA drives.
This Socket is off by default but can be switched with gpio 8.

Add an overlay to activate it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- make sata overlay better readable
v2:
- rebase on the patch "add dtbs with applied overlays for bpi-r3"
- add sata-overlay to the full dtbs
---
 arch/arm64/boot/dts/mediatek/Makefile         | 13 ++++---
 .../mt7986a-bananapi-bpi-r3-sata.dtso         | 35 +++++++++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 0ec5b904d35d..ac0af5ffe97d 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -14,26 +14,31 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
 mt7986a-bananapi-bpi-r3-emmc-nand-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-emmc.dtbo \
-	mt7986a-bananapi-bpi-r3-nand.dtbo
+	mt7986a-bananapi-bpi-r3-nand.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nand.dtb
 mt7986a-bananapi-bpi-r3-emmc-nor-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-emmc.dtbo \
-	mt7986a-bananapi-bpi-r3-nor.dtbo
+	mt7986a-bananapi-bpi-r3-nor.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nor.dtb
 mt7986a-bananapi-bpi-r3-sd-nand-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-sd.dtbo \
-	mt7986a-bananapi-bpi-r3-nand.dtbo
+	mt7986a-bananapi-bpi-r3-nand.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nand.dtb
 mt7986a-bananapi-bpi-r3-sd-nor-dtbs := \
 	mt7986a-bananapi-bpi-r3.dtb \
 	mt7986a-bananapi-bpi-r3-sd.dtbo \
-	mt7986a-bananapi-bpi-r3-nor.dtbo
+	mt7986a-bananapi-bpi-r3-nor.dtbo \
+	mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nor.dtb
 
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
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
2.34.1


