Return-Path: <linux-kernel+bounces-239469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8F926074
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485E01C2226E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D2176AC4;
	Wed,  3 Jul 2024 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="lPEiOMpa"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5471176255
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010160; cv=none; b=G9F1o2msXXwCDxgp4EQEuuUdZS6TMzADR7y4+7FyUfyBHLpoHP/45iZZ7KIdV3dHg71nJevTaIdhi9f06BszTEAC5dXQ0ilQDQXZVRUOcR1PvFb6/FNByuN+RtWhSie1Dg05vpviVGCZYZgAz931hX04yz/qqQJOQhopAmbT4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010160; c=relaxed/simple;
	bh=SgVEUNRWJOk07fURUytX7s42U4rwXhqHvehG/BsupB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JOCTx16kqI52H6FLN5j/10LtCH/vIm4aVQINjZi7RU5VIMjq7KaGYA4tW+Qh7eYDwu+8GZIYvcvNfme+zMsqHfsFLGicz2xIX+0z0P4d/ANNOgNAXlh2DdxLcB01jXIoAMHo+fX2KwvApTiyikPmR6DYLXk8efIK2yOrb6YTcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=lPEiOMpa; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1720010148; x=1722602148;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SgVEUNRWJOk07fURUytX7s42U4rwXhqHvehG/BsupB4=;
	b=lPEiOMpa3Rqsx0uC/vJbKcVzmgoPtzgmNvr8L0WGQTwrWVQZyU86xEJlIPHj6IqH
	4ClRHCex6pYZeHn/wOLplZMKd1me6+1Aq8tM7hV1LIfK7D89XskT/O6Eq43mgKre
	nQ5pFensofdR9TkI9XHOhOw4oY3hnOah8wAS3gpGdhg=;
X-AuditID: ac14000a-03251700000021bc-39-668545a493bb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9D.F0.08636.4A545866; Wed,  3 Jul 2024 14:35:48 +0200 (CEST)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 14:35:48 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 3 Jul 2024 14:35:38 +0200
Subject: [PATCH] arm64: dts: freescale: imx8mp-phycore: Add no-eth overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240703-bspimx8m-3180-v1-1-e43e035a9b2a@phytec.de>
X-B4-Tracking: v=1; b=H4sIAJlFhWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3aTigszcCotcXWNDCwNdE/Ok1BRDC5NEC1MTJaCegqLUtMwKsHn
 RsbW1AAuaVj1fAAAA
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: <upstream@lists.phytec.de>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720010148; l=1888;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=SgVEUNRWJOk07fURUytX7s42U4rwXhqHvehG/BsupB4=;
 b=GGNUbTtygcGXN+Gk85yx3NjyvbyhF7/u2ej26fEsUZsbxqe9IAdu4K47r54cOuZsWdVhxJ3hN
 gtWAB4auXQVAQt9Ki5h7zpkWZDM+xD6S5nunMs9/Zys9c8r0SzF9zHf
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWyRpKBR3eJa2uawZ5T8hZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPFou/FQ2aLTY+vsVpc3jWHzaJ17xF2i7/bN7FYvNgibtH9Tt2Bx2Pn
	rLvsHptWdbJ53Lm2h81j85J6jxebZzJ69He3sHr0/zXw+LxJLoAjissmJTUnsyy1SN8ugStj
	5eQbTAWP+Coe9f5kamD8yNPFyMEhIWAisftYRBcjF4eQwBImievb9rFBOA8YJRasv8vYxcjJ
	wSagJrHrzWtWEJtFQEXiX9NtNhBbWMBLYv7LhWA1vAKCEidnPmEBGcosoCmxfpc+SJhZQF5i
	+9s5zBAlDhJ9V3pYQOZLCKxhlHi0agUziCMCsrn94AkmEIdZ4CCjxIdPv9ggzhOW2LRTC6Jj
	N5PEh49dLBDxRImdr+VApgoJyErcPL8F7CAJoG3Tzr1mhrBDJbZ+2c40gVF4FpL7ZiHcNwvJ
	fQsYmVcxCuVmJmenFmVm6xVkVJakJuulpG5iBEWbCAPXDsa+OR6HGJk4GA8xSnAwK4nwSr1v
	ThPiTUmsrEotyo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAmGPfNPV3
	/pqupzv/7nxfUDr7U8XFk8c61GoqWBdJTKw4cbHmqleddDVf+1nDy0/za7V5avaJFH167fE3
	/9Mdrt7GFfJfTieW3zyikNLHN+tCnMK1BVKFjGX7owPeJhZ7SnBtFJ/1JnPu90/xD6cvruYu
	nam5hJ3XfW1zqqHF1x2rn+8uMH+0QYmlOCPRUIu5qDgRAK2grm2kAgAA

Add a devicetree overlay to disable ethernet for boards where it is not
populated.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile               |  2 ++
 .../boot/dts/freescale/imx8mp-phycore-no-eth.dtso    | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2cb0212b63c6..16e06e6f055c 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -164,6 +164,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
+imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-eth.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-eth.dtso
new file mode 100644
index 000000000000..2a9fe1d6db9d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-eth.dtso
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Cem Tenruh <c.tenruh@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "phytec,imx8mp-phycore-som";
+};
+
+&ethphy1 {
+	status = "disabled";
+};
+
+&fec {
+	status = "disabled";
+};

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240617-bspimx8m-3180-47bed184a854

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


