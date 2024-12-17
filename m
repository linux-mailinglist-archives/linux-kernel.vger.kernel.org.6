Return-Path: <linux-kernel+bounces-448912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C09F471A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E07A7509
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9694F1F37C7;
	Tue, 17 Dec 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="kxy34DUi"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A01EF0A9;
	Tue, 17 Dec 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426787; cv=none; b=dkYqSzNWxUAZbhN8GJUuR/7Z5iwCc7MGr1toanLXOXi7bG+bdWUGspk9TYAswiumWV0oRRa6v8/aEBWe0q3BxstF2uSCtE9YCDj88tp+qL+pFiYOaMx3Jh0D8xe+OkQ6cnfk+j8n/NpYULQxr0eKgS1D+efW59BKX9LouhJbl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426787; c=relaxed/simple;
	bh=ZTHVyRxG0VN8NY4VmmqJc8S8Sl5xZGC5k0Q7h5YMc1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8mtHCqGVtFoM7dxy/MVcWg8zNJb6pS2Tbfuyboyvh3NfAdOmTM4XRHWm/PhHKft44ZEPbNVkjjdJGcAwTuQmqzA4xIJiuPpVnnVJECtYNnwDRbAg5+GHPdNayV8y36GQ4SBUiqnFWrPKWEdjO28o8dlLV0mJdJqQk2mqVEK3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=kxy34DUi; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout2.routing.net (Postfix) with ESMTP id 3598D60276;
	Tue, 17 Dec 2024 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vzw3HVGrS3X0rMv2pU+DkL1IXWaKv/Nmla/b6qqUPEw=;
	b=kxy34DUi5yzajm4SBMbVep7x9q9+DYHuLSCp8Hep+oTrm0YQv2GVATYVUsafLn918a1/z5
	nqLQqMiRx88XhUjhQ5myK7y5BwNBWZzyDccsNUeFCoVNFin2ifW8Tf8KydsPU+OuO9UEre
	lfxpMmZwyusQxsBOMX5maNxJ7INVQJ8=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 41CC5100532;
	Tue, 17 Dec 2024 09:13:00 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 13/22] arm64: dts: mediatek: mt7988a-bpi-r4: Add dt overlays for sd + emmc
Date: Tue, 17 Dec 2024 10:12:27 +0100
Message-ID: <20241217091238.16032-14-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217091238.16032-1-linux@fw-web.de>
References: <20241217091238.16032-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 8a752277-9aaa-48fa-ab9e-1a08dbf4967b

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R4 can use the mmc controller either with sd card or the onboard
emmc. The used device is selected through hardware-switches and probed in
bootloader.
Add devicetree overlays for both mmc configurations.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  3 ++
 .../mt7988a-bananapi-bpi-r4-emmc.dtso         | 33 +++++++++++++++++++
 .../mediatek/mt7988a-bananapi-bpi-r4-sd.dtso  | 31 +++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-sd.dtso

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a15..33e244898849 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4-emmc.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4-sd.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
@@ -90,3 +92,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
 # Device tree overlays support
 DTC_FLAGS_mt7986a-bananapi-bpi-r3 := -@
 DTC_FLAGS_mt7986a-bananapi-bpi-r3-mini := -@
+DTC_FLAGS_mt7988a-bananapi-bpi-r4 := -@
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso
new file mode 100644
index 000000000000..3e320b2f83d5
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Frank Wunderlich <frank-w@public-files.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
+};
+
+&{/soc/mmc@11230000} {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_emmc_51>;
+	pinctrl-1 = <&mmc0_pins_emmc_51>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x12814>;
+	vqmmc-supply = <&reg_1p8v>;
+	vmmc-supply = <&reg_3p3v>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-sd.dtso b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-sd.dtso
new file mode 100644
index 000000000000..663c6345dd31
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-sd.dtso
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Author: Frank Wunderlich <frank-w@public-files.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
+};
+
+&{/soc/mmc@11230000} {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_sdcard>;
+	pinctrl-1 = <&mmc0_pins_sdcard>;
+	cd-gpios = <&pio 12 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	max-frequency = <52000000>;
+	cap-sd-highspeed;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	no-mmc;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
-- 
2.43.0


