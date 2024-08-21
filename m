Return-Path: <linux-kernel+bounces-295772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C849A95A14D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8488B285716
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75C14D446;
	Wed, 21 Aug 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="r18FPPLc"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1921531E1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253837; cv=none; b=PoOcxwI3/EOhAh1DbKncy/H9z4cVHm5w401LJwOMjnVK+BJX8WQ8Zb/6XJX5RDQVrGjxQHClLq2J6v8X9fvxuzbTZEyLdbU1CLvKNVg0V6zl+A69sv8UZKYkdyZ2o/1g2qlPVFUNMx+k0XPruZuPK9YpiVYvoFEe8SHQsKGplYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253837; c=relaxed/simple;
	bh=lePPs/tbAtIOFouvZh9RmUIK3TsKRHNzE0VDc7ZAlf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=QvDJyVywBoqjiHQ2g300I2kc3f+S5PX+V0v6Jn5aKQUU8E3jUCZhMvP4Cb3xmybyk/MVTb6gYUP3vG7VLIHSTFUcpM1w9jUgtv33yrKBbVcSXhTGxNI1SVh4OsW+8pU88W9OfjjJDpTvm2MIKdcazm0FP4f1//szeR/9WqOuTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=r18FPPLc; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724253832; x=1726845832;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lePPs/tbAtIOFouvZh9RmUIK3TsKRHNzE0VDc7ZAlf8=;
	b=r18FPPLctrKH/OtSR+5oA4EotaGy5+ImmsBud/zN9d2wwBG2TLALIDhwMy3LAceT
	tpd+lL0b/r3/Cq5tTQCxaglzyTHELCq4Xkb1+k1ng+f4wIyaJvb1lEvrGHIbEs6t
	5GRyZ149j+ubviBS77g5ioR1HIwQhqlKwfU/oz5SLW8=;
X-AuditID: ac14000a-03251700000021bc-5e-66c606887179
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 6A.96.08636.88606C66; Wed, 21 Aug 2024 17:23:52 +0200 (CEST)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 21 Aug
 2024 17:23:52 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 21 Aug 2024 17:23:45 +0200
Subject: [PATCH v2] arm64: dts: imx8mp-phyboard-pollux-rdk: Add support for
 PCIe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240821-wip-bhahn-add_pcie_support-v2-1-9c92d8488ab2@phytec.de>
X-B4-Tracking: v=1; b=H4sIAIAGxmYC/43NTQ6CMBCG4auQWTuGVlRw5T0MIf2Z2tlA01aUE
 O5u5QQun2/xfiskikwJbtUKkWZOPI0F8lCB8Wp8ErItBlnLpm7FCd8cUHvlR1TWDsEwDekVwhQ
 z6k7b69mZxnYtlECI5Pizxx99seeUp7jsX7P4rX9lZ4ECjdC6vkjdkHD34JdM5mgJ+m3bvlap4
 LrEAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
	<t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724253832; l=2075;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=lePPs/tbAtIOFouvZh9RmUIK3TsKRHNzE0VDc7ZAlf8=;
 b=ej2uK8eU11SgY25SZ2OkDSoIo7033bcBd4k+CrULFBIf/k5KWxUY/murMPIE5B/Mgg3dFQR8N
 l5UuNUTteULDW2462qGGQurNqOixL6GsZuntH6BiDLqskQmA0gLQRqX
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8nAo9vBdizN4MBLFYs1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DK+NVwg7Fg
	rkDF9ZX7mRoYT/J2MXJySAiYSJz884y1i5GLQ0hgCZPEr4cb2SCch4wSB8/cYwOpYhNQk9j1
	5jVQFQcHi4CqxJQnyiBhYYEgib4v11lAbF4BQYmTM5+wgJQwC2hKrN+lDxJmFpCX2P52DjNE
	ia/Ehb5OdpDxEgLvGSWW393HBJIQEdjBJPG43xAkwSxwkFHiz/oH7BDXCUt83r2GDaJjN5PE
	l9mnmEE2SAgkSux8LQdSIyQgK3Hz/BY2iHp5iWnnXjND2KESW79sZ5rAKDwLyX2zEO6bheS+
	BYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCYkyEgWsHY98cj0OMTByMhxglOJiVRHiT7h1N
	E+JNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cBo+lzv/vHA
	W54c4q93anG6BN8TOVBw+OCRq/vmaWb3vw1YrJv+rEO8RcWd4eDCY5yZxg+FFtxrYVI4vynn
	EHucy664M6v6+607Kmbyy5VFTQtffkvE7mLQGhETwyU2L4z1OIo3mwhF8y2TcOfoeMip/DtU
	nXe5Cc8PhYn/stWumMvyRbVZr1RiKc5INNRiLipOBAAIljXVnwIAAA==

Add support for the Mini PCIe slot.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v2:
- change pcie regulator to reg_vcc_3v3_sw
- add wake gpio to pcie pinctrl and order the gpios
- Link to v1: https://lore.kernel.org/r/20240813-wip-bhahn-add_pcie_support-v1-1-c1bb062b4e1f@phytec.de
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 00a240484c25..b50b04dca2b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "imx8mp-phycore-som.dtsi"
@@ -195,6 +196,23 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+/* Mini PCIe */
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_vcc_3v3_sw>;
+	status = "okay";
+};
+
 &pwm3 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -366,6 +384,15 @@ MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x12
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08     0x40
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10     0x60
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x60 /* open drain, pull up */
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14     0x40
+		>;
+	};
+
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SPDIF_TX__PWM3_OUT		0x12

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240813-wip-bhahn-add_pcie_support-b9bd75fc4d98

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


