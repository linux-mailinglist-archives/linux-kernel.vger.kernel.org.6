Return-Path: <linux-kernel+bounces-278142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D494ACAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039FA1C20E46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816C12FB0A;
	Wed,  7 Aug 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="sJp3RhL1"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074A352F62
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043941; cv=none; b=VH9bbtrJuau1wMh0QWG9ryURqlKWa9bhDsomPOxZ1o4mgKJSm1KXkpD1xs9AjCBdG3a/nGjaIH7AnAlEFNafhIVMOlmfCSLnnyFiTAOMp8KnZLK4IH2G8v/4p7NObt68u5HQOj+AkK9U0DNXHr088h430l+TnveXzAvtOsNqDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043941; c=relaxed/simple;
	bh=lYKP4jlnJQ6qy18txJgXJHYM8dA1dqMocHmQGEgVKG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RB4VxdjSOt40M3I9sdYT2fHgeMt4xQDM5Z/IVIw4rvcXLUFodym9lF1mXiDLozwp9rH+SEGVnVeItWRUZaf0ki4Dxoeyk0V4TaXEgRnHhFP1haqRHiUHpyCtv64MYSJwhnj3IKMU2X0MjXViiy0mBBXIQrTXwp8dol7OqgklPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=sJp3RhL1; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723043933; x=1725635933;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lYKP4jlnJQ6qy18txJgXJHYM8dA1dqMocHmQGEgVKG4=;
	b=sJp3RhL17qPn0GbNGMrpWViLknwsSUH6QPWT0fLg/he0WVxTRX34QjadtE9bzx3a
	n29VFjBi2AHw1uJfNhh8xXhl/eY/ytYf/yVatR1ayW23XpEA3z3cDtODnd5/tvZy
	6SFmqQ9+ydnXnM+yD2/TEQmBOGvUAqG5g9IqbtnaXKY=;
X-AuditID: ac14000a-03e52700000021bc-c0-66b3905c93ec
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7A.C6.08636.D5093B66; Wed,  7 Aug 2024 17:18:53 +0200 (CEST)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 7 Aug 2024
 17:18:52 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 7 Aug 2024 17:18:45 +0200
Subject: [PATCH v2] arm64: dts: freescale: imx8mp-phyboard-pollux: Add and
 enable TPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240807-imx8mp-tpm-v2-1-d43f1e8f70ac@phytec.de>
X-B4-Tracking: v=1; b=H4sIAFSQs2YC/22MwQ7CIBAFf6XZsxhAW8GT/2F60LLIHmgJENKm4
 d/Fns07zUtmdkgYCRPcux0iFkq0zA3kqYPJveYPMjKNQXJ55Yr3jPyqfGA5eHYxduC3t7C9FdC
 EENHSesSeY2NHKS9xO9pF/N6/mSJYGyptuRyU1voR3JZxOhuEsdb6BYpjRp6kAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
	<t.remmet@phytec.de>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723043932; l=1781;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=lYKP4jlnJQ6qy18txJgXJHYM8dA1dqMocHmQGEgVKG4=;
 b=pz9z8SjBnAc8U4WIi3QE5fAAkH4to7rcO48THerSVJ7guPCRvkaJ9omfpvNMCwqsQExz7zfvW
 KNS1qZRKCgODhrcf7YsrE/whAB9NpQMdHq6TcJZGm2KUp3LNzTDVYg5
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42JZI8nAoxs7YXOawZF9jBZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuAO3x85Zd9k9
	Nq3qZPPYvKTe48XmmYwe/X8NPD5vkgtgi+KySUnNySxLLdK3S+DKmNt9m73gO2/FzEmX2RsY
	j3F3MXJySAiYSFzdtpOli5GLQ0hgCZPE5QPXGCGcB4wSD+7fZgSpYhNQk9j15jUriM0ioCJx
	aPMCFhBbWCBc4u7hLiYQm1dAUOLkzCdAcQ4OZgFNifW79EHCzALyEtvfzmGGKLGV6JgKMV9C
	4A6jxISdW8HmiwjsYJJ43G8IkmAWWMoocWf6N1aI84QlPu9ewwbRsZtJYvmKXrANEgKJEjtf
	y4HUCAnIStw8v4UNol5eYtq518wQdqjE1i/bmSYwCs9Cct8shPtmIblvASPzKkah3Mzk7NSi
	zGy9gozKktRkvZTUTYygmBJh4NrB2DfH4xAjEwfjIUYJDmYlEd7m8E1pQrwpiZVVqUX58UWl
	OanFhxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhi1wlYsKTQ6uCb73M+C6VL37L5f
	ZOMICXkn1v/gaI7NX85jsufyXb55x3MfEJLnM631yXB3t18yVUa7/1uUtvYBt8OTT6ctWit2
	7EaeHcPEk4Uz+974B9XNqBUE6oy33nan2Pq7v4/O96ZDOZYJFamZrJ+tOubcm3OXY/PRpZ5z
	GowXHbflUGIpzkg01GIuKk4EAIHbMPeXAgAA

Add support for TPM for phyBOARD Pollux.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v2:
- renamed tpm node to tpm@0
- removed num-cs
- cleanup pinctrl
- Link to v1: https://lore.kernel.org/r/20240805-imx8mp-tpm-v1-1-1e89f0268999@phytec.de
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 00a240484c25..0e8200413557 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -103,6 +103,23 @@ reg_vcc_3v3_sw: regulator-vcc-3v3-sw {
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
+		status = "okay";
+	};
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -300,6 +317,15 @@ &gpio4 {
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


