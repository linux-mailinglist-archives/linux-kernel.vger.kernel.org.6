Return-Path: <linux-kernel+bounces-420574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA599D7CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD09D281547
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791DE18C92F;
	Mon, 25 Nov 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="GxoXJ/22"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFA187FFA;
	Mon, 25 Nov 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522729; cv=none; b=uSqU2QEd01a3RP1ObCr4FaLGjN2Ecpa1IECh7yGf0K6DF7A68Cme2TGVJc1yjkaY0yMp/k+Odn840u6/Cz3NzyII0MZ2ga6ETEAyeXT1bN1/VKHtddm13IYvPV4gm/NYwQ/85bnDWB4nYU5tl2tZ7sOFLnI+h/nsuMfpckerm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522729; c=relaxed/simple;
	bh=ZX1ZqI1YZjNHBFyWQbcbP5xLEDCCE8n1EjqmEndKfwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HkpMeuic74Wt9xEpAJ1vkGqtext9xi5ZeogkplLnC7XmIlUD9LuiTos/sToWpYdKbX/U/PWS5bUEEKGuBeDYX0OUVG1SYaySs6/Kv7JHgu+0J+6dkD1AfC4kfxpJLpjvE8M50ryu9R4G3eq1+PIv4UtLxGOpy2s7uNf1p9OZXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=GxoXJ/22; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Fz+uR78BPobXOPH4VNcUExmCEFHzoQ3zmdQQSjSRm7U=; b=GxoXJ/22YO08Nfly/PaSQVMVDF
	MFDzqtH5rkViWvXSw5zVi9dNzgF2gAwYLVQ/ESC53yGPfSuID2S+L16QqJBk3nbqDBZoQtXWD4qfS
	pQW0oADXfBY4JcFtEnVNbr+jNTWsOYDA+L3o3GD5sfGsYGHcR148W0t1d4i3RsnMKorEgaBRFaGkY
	VgmRs87Y8GpHk2tUqUlgcxWQMboCHd7sz3Z0EMohPTwZRd9QTScsr6W46hhrlo8rxKJFShjYXns0+
	cSSHMomdSIkSCyv/AElkJJo4XpLw+fufuGyFEn2azhL4OT6e0tRTlrmG3fd+ZkavxxL6oc3sqYfxt
	nKoFceTQ==;
Received: from [91.26.50.162] (port=58340 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tFUIx-00Eq70-0B;
	Mon, 25 Nov 2024 09:18:46 +0100
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
Subject: [PATCH 15/15] arm64: dts: imx8mm-phycore-som: Add overlay to disable SPI NOR flash
Date: Mon, 25 Nov 2024 09:18:14 +0100
Message-Id: <20241125081814.397352-16-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125081814.397352-1-andrej.picej@norik.com>
References: <20241125081814.397352-1-andrej.picej@norik.com>
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
 arch/arm64/boot/dts/freescale/Makefile           |  2 ++
 .../freescale/imx8mm-phycore-no-spiflash.dtso    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index da6ddce6b7c7..6dcefd58996d 100644
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
index 000000000000..71918a3241d5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spiflash.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
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


