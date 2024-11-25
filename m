Return-Path: <linux-kernel+bounces-420572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D49D7CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51318281986
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FC18BB8E;
	Mon, 25 Nov 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="FmmNpQy3"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18B17BB1A;
	Mon, 25 Nov 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522729; cv=none; b=eDtR5g0tQdFFWleA+Ip98gfpVrs03RErccGFA1yVw9pmmOq9PODi5N2WNqt+lYEIimXMvrCr4yVAlCZolu3IgyS9S5ITlTdgEjG2QGS6yOWYoS5jYpQ3ckNUl/PAFOSC7Fl5CC2PTCZu+YFAxmRuuGWCQsHydi6P76kiiPf4L5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522729; c=relaxed/simple;
	bh=HSGbcxcpCnIjzIER8Q65nHkgT1znY/xVpPQxT3m2tjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtGWwNuwJvOiaEt2WHgE7EUIB2W/yzHlpR3g04wugJPBCyTYqqRaMZZ4dXIrpXdDkuCGfiy9LD8D5XGshjhJ855c3THSBESjW9VsMExz1xFF6xUG/8nR1yeI8RM5YWPor0YzGsQc/806N7DGVT63OqBMDXvyZNmre9Jci42CzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=FmmNpQy3; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=haW48oQXOuo8ByUf64fZOxiyomoePVLzMuucW0s/YDA=; b=FmmNpQy3Y2OUKU8QsWyab3YgxQ
	kt9YVOu1iwPNj5HOSzxrljCP2W4HMbKt4sQhwTGE7mpEBmuy7epTYDOD1FTXQudE7wj4uAcr3/y7V
	J5J2hz+PuTWV8WxcNGEulDVup68bqltIPl0aa9H4jG2v7yYJt8UZslyau6ZPUMpCqOh2eHXzWROyK
	IL4nQinY0D82rQwsgvhOu3CauC51avWauksQI7RZebe7/eBJTWakirubF2keCGr/Ag7Yll8Mwz4ko
	DUXmjUGg/Di65WTAP1LSeUrjh5ysmHcfA38l0kdSZlpoKsLLAgMSQ6C2hYFg86FcaaveFAlhnUV9b
	zO6OkBOg==;
Received: from [91.26.50.162] (port=58340 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tFUIw-00Eq70-1B;
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
Subject: [PATCH 14/15] arm64: dts: imx8mm-phycore-som: Add no-eth phy overlay
Date: Mon, 25 Nov 2024 09:18:13 +0100
Message-Id: <20241125081814.397352-15-andrej.picej@norik.com>
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

There are SoM variants with no eth phy populated. Add overlay to be
able to support this.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm64/boot/dts/freescale/Makefile               |  2 ++
 .../boot/dts/freescale/imx8mm-phycore-no-eth.dtso    | 12 ++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-eth.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 5bc083a7b778..da6ddce6b7c7 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -125,10 +125,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
 
 imx8mm-phyboard-polis-peb-av-10-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-av-10.dtbo
 imx8mm-phyboard-polis-peb-eval-01-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phyboard-polis-peb-eval-01.dtbo
+imx8mm-phycore-no-eth-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phycore-no-eth.dtbo
 imx8mm-phycore-rpmsg-dtbs += imx8mm-phyboard-polis-rdk.dtb imx8mm-phycore-rpmsg.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-av-10.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-peb-eval-01.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-phycore-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phycore-rpmsg.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-no-eth.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phycore-no-eth.dtso
new file mode 100644
index 000000000000..dd66ccfbb4d7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-no-eth.dtso
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Teresa Remmet <t.remmet@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&ethphy0 {
+	status = "disabled";
+};
-- 
2.34.1


