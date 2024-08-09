Return-Path: <linux-kernel+bounces-280616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C936E94CCDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65751B21844
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DE18FDDB;
	Fri,  9 Aug 2024 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="BQvzHAlZ"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7418FDD0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194176; cv=none; b=q/HZpFTGaObBLkH1dc1occxuNyj6rzV0rWem0luHx3AS1uAV84XnqY5sdGgcWRWkYIDnsonBwvFXnXu/VYDyhO31iJ6Cp5PUIzpQjjS+dQYKnkjxbb49dxIf7i+Q1kPVg2c85/N8aTR9K8wPY9stvuCdH5htI31j1mGqESX97Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194176; c=relaxed/simple;
	bh=hUutMxc7Exclw5WuhTQlzC/S71ST0PeZg6Nw//eMU10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=M6D6a8TjLEDDO3zT+ZX3i82hDOi/LISnbxAGj2WP4/SFybCKEVHU3schF8lnSpmIx9JaEtDwuEkwMsG4c1HbT1dMnMoC1REMOA8rI05fFk9EHedG53xpMPUUHT72A5AnOpLQ4VUERWMSh/Oz5pjGRePgB0RIAnTJ//AuoP9kIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=BQvzHAlZ; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723194170; x=1725786170;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hUutMxc7Exclw5WuhTQlzC/S71ST0PeZg6Nw//eMU10=;
	b=BQvzHAlZWYHq1V1GMjSicWBtQqcB2qga1v90CP5iJ/24UTyHPXVX/ZtKMc66+kLV
	qEPzcfCnAf8+2HGQoja014OGT66AFvbcF0XNer3DUQ6peetZk4GGINH4hQP8vnmU
	1bT79A/QMjRK2TV5SrGzs58f49z30Ii+m/mVZ2kdpTE=;
X-AuditID: ac14000a-03e52700000021bc-46-66b5db3937b4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CC.80.08636.93BD5B66; Fri,  9 Aug 2024 11:02:50 +0200 (CEST)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 9 Aug 2024
 11:02:49 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 9 Aug 2024 11:02:31 +0200
Subject: [PATCH v3] arm64: dts: freescale: imx8mp-phyboard-pollux: Add and
 enable TPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240809-imx8mp-tpm-v3-1-c1cd80deff16@phytec.de>
X-B4-Tracking: v=1; b=H4sIACbbtWYC/23MTQ6DIBCG4asY1qUB/ANXvUfThZWZykIlYIjGe
 PeOrmzSzOqb5Hk3FiE4iKzJNhYgueimkUZ+y1jXt+MHuLO0mRKqEFqU3A2LHjyf/cBzi5Wo3xJ
 LlIyAD4BuOWPPF+3exXkK69lO8vj+zSTJ6UAbFKrSxpiH79cZursFdmSSutL6hyqitsiRONai7
 a503/cvjL3vZ98AAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
	<t.remmet@phytec.de>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Peng
 Fan <peng.fan@nxp.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723194169; l=1993;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=hUutMxc7Exclw5WuhTQlzC/S71ST0PeZg6Nw//eMU10=;
 b=3blqmdmkHdaXVLvFAjvZZJTgizxxHa2X0wLB6qx0355Z27tKrCewTj/4XM+kVTPBi9qemS1bb
 gwf+qB5xLqJBSPABywWDaOPyYMkLvgjvT8F3Z6AUAwXUN1pZVXNMgi+
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8nAo2t1e2uawaooizV7zzFZzD9yjtXi
	4VV/i5n3WtksVk3dyWLxctY9NotNj6+xWlzeNYfN4seqL6wW//fsYLf4u30Ti8WLLeIOPB47
	Z91l99i0qpPNY/OSeo8Xm2cyemx8t4PJo/+vgcfnTXIB7FFcNimpOZllqUX6dglcGdOvrmUu
	OM1fcb/3K1sDYxNvFyMnh4SAiURr9xkWEFtIYAmTxMbJQV2MXED2A0aJ91dXMYMk2ATUJHa9
	ec0KYrMIqEhcvjGTDcQWFgiX+L7zNiOIzSsgKHFy5hOgQRwczAKaEut36YOEmQXkJba/ncMM
	UWIr8fLBURaQ+RICvxklNi7fD9YrIrCDSeJxvyFIglngEKPEoq6TLBDXCUt83r2GDaJjN5PE
	7R87WUE2SAgkSux8LQdxtazEzfNb2CDq5SWmnXvNDGGHSmz9sp1pAqPwLCT3zUK4bxaS+xYw
	Mq9iFMrNTM5OLcrM1ivIqCxJTdZLSd3ECIoxEQauHYx9czwOMTJxMALdx8GsJMLbHL4pTYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVAOjlobl7Jd3Zmhz
	3rwQ2dr6a5nO1PbIRQdeNd3aO9XhgObTB+y3l0R/Nf5xnu///mWzdmzZ+b6nyFijqlg7ed4B
	94QjV1yc5ocxKhf86lcpiDO/cShvqq1czk8v8+3sZumXNn01SDll9scsY1luXdjSizPXv33S
	dD5iWq7xuX09cdUbHm8wEWV9rMRSnJFoqMVcVJwIALBf8GafAgAA

Add support for TPM for phyBOARD Pollux.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v3:
- remove status okay for tpm node
- Link to v2: https://lore.kernel.org/r/20240807-imx8mp-tpm-v2-1-d43f1e8f70ac@phytec.de

Changes in v2:
- renamed tpm node to tpm@0
- removed num-cs
- cleanup pinctrl
- Link to v1: https://lore.kernel.org/r/20240805-imx8mp-tpm-v1-1-1e89f0268999@phytec.de
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 00a240484c25..09bd10627b11 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -103,6 +103,22 @@ reg_vcc_3v3_sw: regulator-vcc-3v3-sw {
 	};
 };
 
+/* TPM */
+&ecspi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	tpm: tpm@0 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <38000000>;
+	};
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -300,6 +316,15 @@ &gpio4 {
 };
 
 &iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO   0x80
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI   0x80
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK   0x80
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09     0x00
+		>;
+	};
+
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC			0x2

---
base-commit: 17712b7ea0756799635ba159cc773082230ed028
change-id: 20240805-imx8mp-tpm-3df607b1f5f1

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


