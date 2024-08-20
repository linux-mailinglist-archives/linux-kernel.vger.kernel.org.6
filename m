Return-Path: <linux-kernel+bounces-294389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0711958D19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE52D1C2226F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577821BE225;
	Tue, 20 Aug 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZZAs9/cP"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E571C2334
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174369; cv=none; b=rQI36oQ/f+IpR9cLMcDnwNYGXDXrc9DsZJmoMr54r3KHFSJ4xi9xnSQvz5GQmsjc4rvB4JoEscLg2LZt6sffu4qD1y9kauoKNucd+jFlAljqes3eWqhxlckYysNtbIShvppH+zBpI0RH5aVktNagIkM6V/kNdgAok3EXa3cQFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174369; c=relaxed/simple;
	bh=GkHo9Tromo+pUehKvOxhHRY39SHY2zUI1k6gURUv1XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ir2ULqj6m8cvb6AW2XZVE141fOtweYlPvXxukHQKMvVFMxQEWkMRBqSGscCzo5soOGsOFqtsKdioVrAVaqFGP69pTZYPAZqexpCtzjBd3b1CEAIFJ3qUTCcehaeuc0gFoPwec+qBO3GJyIkM+JkV5soxi/A52KJU7/F/OrMi3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ZZAs9/cP; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724174356; x=1726766356;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GkHo9Tromo+pUehKvOxhHRY39SHY2zUI1k6gURUv1XQ=;
	b=ZZAs9/cPF322ebHbeHf3LcDd52JWrADVSB6K6S4Mdje7vESq0nmUiUpPIMgmB4NV
	5skxG/Xeg8D2xLWmlYxQTDvWOlnkd1NEucXnIk3fr6Il/JiamXhCwU1nNE4t6RGP
	SY+t2o7ZfapPTqCMWLK9TqX+xi6tOFEFLyvOv6zwcjw=;
X-AuditID: ac14000a-03e52700000021bc-17-66c4d014331a
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 01.70.08636.410D4C66; Tue, 20 Aug 2024 19:19:16 +0200 (CEST)
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
Subject: [PATCH v2 2/3] arm64: boot: dts: freescale: Add no-spiflash overlay
Date: Tue, 20 Aug 2024 19:18:47 +0200
Message-ID: <20240820171848.177926-3-y.varakala@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42JZI8nAqyty4UiawfJWVos1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DK6Dt5iqng
	sUDFr/vtLA2Mz/i6GDk5JARMJO7e+87WxcjFISSwhEni0+JHUM5TRolfjT+YQarYBPQlVqxb
	xAqSEBFYxijx7XQ3C4jDLLCdUeLExHdMXYwcHMICPhLnO01AGlgEVCV6HkxlBbF5Bawkzjdd
	Y4VYJy+x/+BZZpByTgFriVU/M0DCQkAl+1fvYIQoF5Q4OfMJC4jNDFTevHU2M4QtIXHwxQtm
	iHpFifcPO9hhRk4795oZwg6VmL/mO/sERqFZSEbNQjJqFpJRCxiZVzEK5WYmZ6cWZWbrFWRU
	lqQm66WkbmIERZMIA9cOxr45HocYmTgYDzFKcDArifB2vzyYJsSbklhZlVqUH19UmpNafIhR
	moNFSZx3dUdwqpBAemJJanZqakFqEUyWiYNTqoFxbd2aYKdd3YVHbG+udLy9ft/y/Y8TU+pv
	JqnV8HKGaj9a2dW4TnHxVDOTnDP/LH+uXRbalvadrf+UhmDeK9XZmw+nKVWH/Z2o68MUeq/7
	e2rJNfZz8r+iOiOZLrZI3Etf9riau+7EorL6Kam/Vs36krHAUaO2ov3AROH5Irc9+Nj2pb5a
	8pNNiaU4I9FQi7moOBEAkfbLsJQCAAA=

Add devicetree overlay to disable SPI NOR if the module does
not supports or not equipped with SPI NOR flash.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
Changes in v2:
- Updated license
- Updated with TAB space in devicetree property

 arch/arm64/boot/dts/freescale/Makefile           |  2 ++
 .../freescale/imx8mp-phycore-no-spiflash.dtso    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-spiflash.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8f41db93c3d9..dedea4b5c319 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -176,8 +176,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 imx8mp-phyboard-pollux-rdk-no-rtc-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-rtc.dtbo
+imx8mp-phyboard-pollux-rdk-no-spiflash-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-spiflash.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-rtc.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-spiflash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-spiflash.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-spiflash.dtso
new file mode 100644
index 000000000000..2ad1312113f0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-spiflash.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Cem Tenruh <c.tenruh@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&flexspi {
+	status = "disabled";
+};
+
+&som_flash {
+	status = "disabled";
+};
-- 
2.34.1


