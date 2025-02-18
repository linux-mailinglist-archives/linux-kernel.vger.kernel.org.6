Return-Path: <linux-kernel+bounces-518752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FAA39406
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C8A174E07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8A1DE3BF;
	Tue, 18 Feb 2025 07:43:00 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159E1DE2C2;
	Tue, 18 Feb 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864580; cv=none; b=udJpaJl1ntNNqIIZoSaP5zoUfOM8JHr9tPiftgaa8cVPWKQ7QRnRMVb9oA/Tmh+lMBZYkr7PLTxkTJK04A9ElCzApyw4XjDaoFVSeQtMZIL7K9c+zBeSMcaskxiQRZYND1yEz3qmijsp1dVpNBPrWWCxdm5ZZ4QjHDrJ3SUJJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864580; c=relaxed/simple;
	bh=BiUV62mf2nwxx1jDx46P+ko85ephu7710hKtThBs5y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4tUcRjCD7WytAk1uS1UtKsuMn8PNzG3ibfUgElBa8WH9xsYe3iJUYxnwND2WeN1qZAjYgD2msKOE/8sZAXIy/V0gaeJgwl9Y+eqX+heHRrHeRE6qwkZOtZZxZZ+mQKYWituIlh3HWB8hPigrFpH69AIUSXOP63qYJPNKL/64DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFt-00G0MD-1R;
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
Subject: [PATCH v3 15/15] arm64: dts: imx8mm-phycore-som: Add overlay to disable SPI NOR flash
Date: Tue, 18 Feb 2025 08:41:56 +0100
Message-Id: <20250218074156.807214-16-andrej.picej@norik.com>
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

From: Teresa Remmet <t.remmet@phytec.de>

There are SoM variants with no SPI NOR flash populated. Add overlay to be
able to support this.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- updated copyright year.
---
 arch/arm64/boot/dts/freescale/Makefile           |  2 ++
 .../freescale/imx8mm-phycore-no-spiflash.dtso    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 7f3d8fb8123b..664438aa2e26 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -126,11 +126,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
 imx8mm-phyboard-polis-peb-av-10-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-av-10.dtbo
 imx8mm-phyboard-polis-peb-eval-01-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-eval-01.dtbo
 imx8mm-phycore-no-eth-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phycore-no-eth.dtbo
+imx8mm-phycore-no-spiflash-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phycore-no-spiflash.dtbo
 imx8mm-phycore-rpmsg-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phycore-rpmsg.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-av-10.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-eval-01.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phycore-no-eth.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-phycore-no-spiflash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phycore-rpmsg.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso
new file mode 100644
index 000000000000..7bfc366c1689
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
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


