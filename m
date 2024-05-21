Return-Path: <linux-kernel+bounces-185505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC58CB5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD2B217A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA514A0A9;
	Tue, 21 May 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="jMz2d8Cb"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2CB149E05;
	Tue, 21 May 2024 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330188; cv=none; b=akB/qj+5DpeJvDzhzS4Fotc99iYUS+VbvugYnxHTIPXOoEdnG+VBDiDe8DpZp7UbBaKmjX/ABhwLHFDJMI4IvRwi+xPLPMJ2audoZDTQV09fS/a5NYHpG+cDXX/8vFY2X2P/eSEzAe8HDSSOSvpnXJCaskv+KBMspoMQ9+pnP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330188; c=relaxed/simple;
	bh=KRA0hzdbcQleJG9h2ccYEgi+Z4Omnx++qe9VSxqm0Jc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMagiMzrDJOJczx8WVdwIKzPWZjDofCblJZ6U8U+drDs0DSAbZ/m8Zitm18+B1m310RTqGmgd8n1vBtr4uR9H/86C1R/WSIO35mcTb35tdcvKeyJ3l4tKlY5iRz4jLK0rw8CCyGj99BSjdta9r0BvptaaPFDYMTiXeuGSqYdtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=jMz2d8Cb; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A01EC120013;
	Wed, 22 May 2024 01:23:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A01EC120013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1716330184;
	bh=Y5KLTru70ihF59JB6SdRG0BlaBrGNjPfEalirF6qzHI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jMz2d8CbRa4ExoilijE8iYZK44sfA7CHUu6dGsHZKIY1Pt7nYA3ICinNLPtxh2tzl
	 3rJTL/js632kKou6QQJnUXryCTCoxKJiWzCanIpI6KlwaWt9FMLCKzEAPu0s2K8mlo
	 qYUukLxlXKh+5vyfX31+XpcDEzDold0AQCUR/SekeOu247Em+YaNhY3bfMJtd8d+uA
	 vfgbH+pm5MmmGN8wjxFZjjSBNWMuPbj6PLt34ewHYEKQ7UgLa42vogXGrVxfghXhmF
	 CJaDtg/yRqaeAJX87nRq+beiUfXoxvqiMhaVLYzMpfVbO9y3dd7sswojkQ8YKp1uyC
	 oXijpUrF0X9ZA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 22 May 2024 01:23:04 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 May 2024 01:23:04 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Dmitry Rokosov
	<ddrokosov@sberdevices.ru>, Jerome Brunet <jbrunet@baylibre.com>, Kevin
 Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Lucas Tanure <tanure@linux.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Xianwei Zhao
	<xianwei.zhao@amlogic.com>
Subject: [PATCH 3/3] arch/arm64: dts: ac200: introduce initial support of the board
Date: Wed, 22 May 2024 01:21:55 +0300
Message-ID: <20240521222155.28094-4-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
References: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185400 [May 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/21 08:41:00 #25230763
X-KSMG-AntiVirus-Status: Clean, skipped

AC200 is Amlogic's reference board based on S905D3 SoC. The board has
support for USB, Ethernet, HDMI, WiFi, eMMC, micro SD, AV output, analog
audio.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 .../boot/dts/amlogic/meson-sm1-ac200.dts      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts
new file mode 100644
index 000000000000..68209a790460
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-sm1-ac2xx.dtsi"
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/meson-g12a-gpio.h>
+
+/ {
+	compatible = "amlogic,ac200", "amlogic,sm1";
+	model = "Amlogic AC200";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>; /* 2GB */
+	};
+};
-- 
2.34.1


