Return-Path: <linux-kernel+bounces-209068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E379902C95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90A61F22D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632A152DE7;
	Mon, 10 Jun 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P0L5OI6U"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C7152515;
	Mon, 10 Jun 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062995; cv=none; b=rvaqQyfWAQ4FkR9/W93d62Enxa4gt84WS/kfDhPR3xcU4BIsNe5EdBw1icM02xOCYWD+3tjeEMbykTineearUl5Giw23un9FsCfLbqhitg7hmcwpkIUciLq8ugUwutKYE8i1UYbHx9+eKzT4JVKBaQyOvpBe+zLQ1k4budMi3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062995; c=relaxed/simple;
	bh=F/dtIUCdOUNRKmF2bXQiMpR51m7pA3X1q5z5OPUpR/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJFikDq4uMxG3XR/WDsNwnptkRjekAc3PNHCoYP2mkbbGIEoG1heKOKky8Lf2tUxQS01iBGz2kjk5HgJUEgpEhNRx9lxjQI/ujNc/ZePcTWjJ0WNv3cHDtNJvc/kkYupGpV8/2r6ntiKWERfY4PszVNj4ZYX8Nel3uR1gK7LahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P0L5OI6U; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718062992;
	bh=F/dtIUCdOUNRKmF2bXQiMpR51m7pA3X1q5z5OPUpR/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0L5OI6UvwvGcMo12a3s5S9KgHNOtr0MlaQhurOnE0UmLNApidGfr2CZXJuXYhVGz
	 2yeibDRPZLI8Ihpky/EYMDHpk0koeYJoWwsxLYQWmeQ/m+ODmwXxNlk3hOUy0sQYpj
	 V3vP4/+a9e6676aO7mcSJcPD6TmL2/UPdcFgbYqhswrRdSJ5YI6bBI2psd0qyfvu7q
	 9HEpNrnG8wEQ0104UVb8usfTeMUihh/YJzjhc8oxGaHBs1cGO9ZHN9A2+SB6jsZUAc
	 OhFN7L9Q8cy42k5xEHWnw2liOMFFYQjWYB8bdfnsKskzz1Yr7U7nEiipnVCtMwHkgC
	 CAM4H+vYtv5rA==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA34E3781FE6;
	Mon, 10 Jun 2024 23:43:11 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/1] arm64: dts: imx8mp-debix-model-a: Enable HDMI output
Date: Tue, 11 Jun 2024 00:42:38 +0100
Message-ID: <20240610234307.96766-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240610234307.96766-1-chris.obbard@collabora.com>
References: <20240610234307.96766-1-chris.obbard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HDMI output on the Debix Model A SBC, using the HDMI encoder
present in the i.MX8MP SoC.

This has been tested with a generic 1080p HDMI display, along with a
smaller 1280x800 HDMI display.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

Changes in v2:
- Do not set SION (Software Input ON) bit in pinmux pin config register.
- Small changes to commit log/cover letter.
- v1: https://lore.kernel.org/linux-arm-kernel/20240415114135.25473-1-chris.obbard@collabora.com/

 .../dts/freescale/imx8mp-debix-model-a.dts    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
index 9b8f97a84e61..af02af9e5334 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
@@ -20,6 +20,18 @@ chosen {
 		stdout-path = &uart2;
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -94,6 +106,28 @@ ethphy0: ethernet-phy@0 { /* RTL8211E */
 	};
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -239,6 +273,10 @@ &i2c6 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -356,6 +394,15 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16				0x19
 		>;
 	};
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL			0x1c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA			0x1c3
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD				0x19
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC				0x19
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL					0x400001c2
-- 
2.45.1


