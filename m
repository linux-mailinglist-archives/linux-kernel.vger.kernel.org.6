Return-Path: <linux-kernel+bounces-242472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3D928887
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DE21C23C53
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584E14B945;
	Fri,  5 Jul 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="qsqXzEVs"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C314A616
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181704; cv=none; b=HFhsv1B6yWftDQDQjLAOYbwqcvqNFcMfZ5E+S7UzrLZ9DaQ5AXcG1ewah2ArPbtLfPbpF0j4KIiD9rqKSXcmgdtzExgw6PRIU+3eHUjEBpCUpLq1JY8DkZYKFiFq7PjW/yzIHDH0Ta9tTGIqJEgBZU9RK6jChZGZjN9WrSPrja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181704; c=relaxed/simple;
	bh=JWyKeJnwPE5FLDgWLdisaVJBPLO4uUaBwzWlAvyiqek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JMOPZB7/3lWfKSvKalWcUtjUyYoReTvj/UH4tye59NicUuZWp7CrE3Cz6ap+FacFARs4Sm3oUqjitV559qaqgZm0k2rzOcdD9+PxN0Xl9iFu75zAhJZdpOGGDXR7CUGyvfDtZJvIxgXw3APD1XvNN9tSwQJ37OAWjI8rhuM8Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=qsqXzEVs; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1720181692; x=1722773692;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JWyKeJnwPE5FLDgWLdisaVJBPLO4uUaBwzWlAvyiqek=;
	b=qsqXzEVskgSqieyH/cjmlHzuLZRnTYa6CeSck79YgMEbqfYUsEu7mX3oSQkGnf/R
	Crz2taKKOO2hHkCfZ3AgUwlSQM2C4AKrEUasLGSAf/k6IXQ9bsTawKvojoD/O4KE
	Gsdj9TuJt+94l8Othfq91UBNBOioO8tzibj0z+cr4ho=;
X-AuditID: ac14000a-03e52700000021bc-b7-6687e3bc24f3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4A.FC.08636.CB3E7866; Fri,  5 Jul 2024 14:14:52 +0200 (CEST)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 5 Jul 2024
 14:14:51 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 5 Jul 2024 14:14:32 +0200
Subject: [PATCH v2] arm64: dts: freescale: imx8mp-phycore: Add no-eth
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240705-bspimx8m-3180-v2-1-dc1a7e1689be@phytec.de>
X-B4-Tracking: v=1; b=H4sIAKfjh2YC/13MSw6CMBSF4a2QO7amL2xl5D4Mg5Ze5Q54pCUEQ
 rp3K84c/ic53wEJI2GCpjog4kqJprGEvFTQ9W58I6NQGiSXmt+EYT7NNGx2YEpYzrTxGITVztY
 aymeO+KLt9J5t6Z7SMsX95FfxXX+S4epPWgUTDLVCrmp399I95n5fsLsGhDbn/AG+2X9NqgAAA
 A==
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: <upstream@lists.phytec.de>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720181691; l=1985;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=JWyKeJnwPE5FLDgWLdisaVJBPLO4uUaBwzWlAvyiqek=;
 b=NyxBIwgwKgl3BLxAdAsLzMomFBWGcn5TS5uIpa491WXciW13Lf3bRuvP1elG7NZISwfbmyyTL
 HpeKLXTKwvMAbCNljbXR8w2bkrApItMMjmVpJKcFGQ9M5RpTq8XFFMq
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWyRpKBR3fP4/Y0gydHhC3W7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLRd+Lh8wWmx5fY7W4vGsOm0Xr3iPsFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTzuHNtD5vH5iX1Hi82z2T06O9uYfXo/2vg8XmTXABHFJdNSmpOZllqkb5dAlfG
	4yVNLAWH+Ss2PuhlbGA8ydvFyMkhIWAi0btxAlMXIxeHkMASJoklbctYIJwHjBLtz56xgVSx
	CahJ7HrzmhXEZhFQkViydSJQBweHsIC/xNlLFiBhXgFBiZMzn7CAhJkFNCXW79IHCTMLyEts
	fzuHGaLEQWLytj/MIOMlBF4zSkyZvB7MEQFZ3H7wBNgVzAIHGSU+fPrFBjJJQkBYYtNOLYiO
	3UwSd78+YYaIJ0rsfC0HMlVIQFbi5vktbBDfyEtMO/eaGcIOldj6ZTvTBEbhWUjum4Vw3ywk
	9y1gZF7FKJSbmZydWpSZrVeQUVmSmqyXkrqJERRtIgxcOxj75ngcYmTiYDzEKMHBrCTCK/W+
	OU2INyWxsiq1KD++qDQntfgQozQHi5I47+qO4FQhgfTEktTs1NSC1CKYLBMHp1QDY0O11MNq
	vqMcknwbb7ulnSqS8LnM33lMIL4+IsNN6mLrnrbkvS6ntm3YLD7Ddl+JUFLZBKkwttNHHBzy
	wpR2sP861+IX3bSJ8+4Nc/FW+QZnJcnDQRJf+a95f9LWUPXpWqLCGPXi59xZIs5nZmoaP7S7
	wajBGXz7tN2EH7zGauor9Hbe29OqxFKckWioxVxUnAgALEYeHaQCAAA=

Add a devicetree overlay to disable ethernet for boards where it is not
populated.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v2:
- Remove the compatible from the overlay
- Link to v1: https://lore.kernel.org/r/20240703-bspimx8m-3180-v1-1-e43e035a9b2a@phytec.de
---
 arch/arm64/boot/dts/freescale/Makefile                   |  2 ++
 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-eth.dtso | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

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
index 000000000000..5f0278bf61ee
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-no-eth.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Cem Tenruh <c.tenruh@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
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


