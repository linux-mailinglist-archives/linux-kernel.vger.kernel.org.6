Return-Path: <linux-kernel+bounces-247388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8292CECB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2392866B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB418FA3B;
	Wed, 10 Jul 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="epXu2/ac"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D018FA31
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605875; cv=none; b=B99EcUit5iaxgp140oAVeBdxzYZTLCIWPccACA2e++vX8S0wcSkj2SRLrPj50q1GpzzYFYHRxUE44Vy29JiNv7b7sqXDhwFVoEHzJ0lIlIXDRiXrt93cHxPq+7L5ywHpWUFFvmAtMldipOVlkYkkWOp04gmnI0BsLgW25905Trc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605875; c=relaxed/simple;
	bh=O/iKLOi01DL02R3LaUPQITYi6Ex6Mg2vmu5xThjEQd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hGu6QAbCATh/wHE4aYoYkl/yxK6bb5aS+/DKD/6ioejv5dxJ0zFoRyckFcFMAV3+LDABMsqXajhs9eL65tnuDupGasmrP4wtXWn60gPB1LjZnPpeXL62aRWmy+sIxKThXD1PHLoBQ8ohtteMYHQwTPgI25GdFzp3uQ9lUojx/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=epXu2/ac; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1720604949; x=1723196949;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O/iKLOi01DL02R3LaUPQITYi6Ex6Mg2vmu5xThjEQd0=;
	b=epXu2/acK3RTjp1fN3JkHmFk4hIJnM9RGaPIVHWXB6qw2IedCbMT4xgdA8gattbS
	p9NjLqmetlUD4A/e8unoHqIqt3i/BocgOBtAkh4KHZDtF1Cf1C5+XFfZNV02e9PJ
	6L/S0k8GcB00Unr6eHbZde08gH5zKV4NnQRyiLhS1z8=;
X-AuditID: ac14000a-03251700000021bc-0c-668e59142468
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C6.7F.08636.4195E866; Wed, 10 Jul 2024 11:49:08 +0200 (CEST)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jul
 2024 11:49:08 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 10 Jul 2024 11:48:54 +0200
Subject: [PATCH v3] arm64: dts: freescale: imx8mp-phycore: Add no-eth
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-bspimx8m-3180-v3-1-8ef55381172c@phytec.de>
X-B4-Tracking: v=1; b=H4sIAAVZjmYC/13MSw6DIBSF4a0YxqXhAgp21H00HYDcVgY+AoZoj
 Hsv2olxeE7yfyuJGDxG8ihWEjD56Ic+D3ErSNOa/ovUu7wJZ1yyChS1cfTdrDsqQDMqlUUHWhp
 dSpKbMeDHz4f3eufd+jgNYTn4BPv7lxQTFykBBYpSIBOlqS03z7FdJmzuDskuJX6uy2vNc+0aM
 Aqh0rXFc71t2w8ypN926AAAAA==
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720604948; l=2166;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=O/iKLOi01DL02R3LaUPQITYi6Ex6Mg2vmu5xThjEQd0=;
 b=54CcNOt2P672ZNgEbr8B9/EoettTLoQnRD4ejM/OwaOnkvJ5anrQiNuVgdnRHhpA6Z4IDbOhP
 4g83FLbkEh0DZ+8JbcD43Qwq0nBZePzbC42VEZe0ah2nzLtvtb19U1q
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8nAoysS2ZdmcP2DucWaveeYLOYfOcdq
	8fCqv8XMe61sFqum7mSxeDnrHpvFpsfXWC0u75rDZvF/zw52i7/bN7FYvNgibtH9Tt2Bx2Pn
	rLvsHptWdbJ5bF5S7/Fi80xGj/7uFlaP/r8GHp83yQWwR3HZpKTmZJalFunbJXBlPN66hK3g
	h0DF/ImlDYwv+LoYOTkkBEwkGrsesHcxcnEICSxhknjQOpcRwnnIKHF43ycmkCo2ATWJXW9e
	s4LYLAKqEgd+d7CB2MIC/hIX/8xhBrF5BQQlTs58wtLFyMHBLKApsX6XPkiYWUBeYvtbmBIH
	iTM/ephB5ksINDNJND78xgbiiAhMYpL4tn0mmMMscJBRYtfHK0wgkyQEhCU27dSC6NjNJDG9
	+QobRDxRYudrOZCpQgKyEjfPb2GDeEdeYtq518wQdqjEkU2rmSYwCs9Cct8shPtmIblvASPz
	Kkah3Mzk7NSizGy9gozKktRkvZTUTYygGBNh4NrB2DfH4xAjEwfjIUYJDmYlEd75N7rThHhT
	EiurUovy44tKc1KLDzFKc7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTByvum5NmPD6Ybe
	R9abJkqYRnN1+EVvOiY/vcBkIsvOhOvBenf4rPZKRLy+dCOiZfmxd93O5/L9uDstcjRbvla/
	KDidfuv5ad5EKUfuNfLfHs0MOdlaaZvfplN70k3/ypGI4IZ9OaaG3KmSSvv82ItqnTY5yxT1
	3dZ9spd7n4L7ohCzPX+kTyuxFGckGmoxFxUnAgCAcR9bnwIAAA==

Add a devicetree overlay to disable ethernet for boards where it is not
populated.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v3:
- rebase to master
- Link to v2: https://lore.kernel.org/r/20240705-bspimx8m-3180-v2-1-dc1a7e1689be@phytec.de

Changes in v2:
- Remove the compatible from the overlay
- Link to v1: https://lore.kernel.org/r/20240703-bspimx8m-3180-v1-1-e43e035a9b2a@phytec.de
---
 arch/arm64/boot/dts/freescale/Makefile                   |  2 ++
 arch/arm64/boot/dts/freescale/imx8mp-phycore-no-eth.dtso | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a4..647282cc861b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -173,6 +173,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
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
base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
change-id: 20240617-bspimx8m-3180-47bed184a854

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


