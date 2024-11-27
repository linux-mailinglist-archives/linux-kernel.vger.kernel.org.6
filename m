Return-Path: <linux-kernel+bounces-423732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D319DABFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4524916699E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4B201003;
	Wed, 27 Nov 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="dEM1yq0j"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E620102A;
	Wed, 27 Nov 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725894; cv=none; b=k/8RyAoTE5tC+uFK6zHxL2bs0ytdwSURZ7A/rO830bcMNNXmhU62X89UA780M5/Lco28fqPUsTTx7+uAsbKPcWXzlhvvagmY03Ku9hWh4O4z+w86bGnYUbo6BVIZPRm308Hs3/zqNI3eHtiPC+O8p5pL9IuMAtnqLTKcHYx5leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725894; c=relaxed/simple;
	bh=Dst3lRgZfCn0jt4o8GB3zk2DwsdtMafO6CwVb8n1pKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZv//YoI3KRa4ABHaDgK92AecCZ3Np2fTgybi/VneXq3kx75G4ptsgbVsNF11yjqcpWw+Gznk05AJNTihU5K9tB8+Gv9W2DCTgNqP3sFfhvCS96QsZ0smCjorVw1WC+gYCVU15BZK44Sr4UcV0C2t/rioE6B6PwtOpo/WRLy6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=dEM1yq0j; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C01BEBFB93;
	Wed, 27 Nov 2024 17:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725890; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7zl3FVHQMKuhP3XVJBG/Ttr48W93+v0BfVf6Zw4g7fc=;
	b=dEM1yq0jm86SeDL3LgsMmo8o8DyGwbeDsnltKY2YZ2vqhEAtUFHm+zfOObUWy42IiZuvmz
	xoZcLo51owZKhNeu/APDsSbmQ1dncvJqm5OPpBZ6x2j3BzrgSFdPe5bhEYDF2y3kJhcJdD
	fe+Sa5iPBsjulub/Ui/fEZVHN+7TH2Z1j8P4jU0LSi1QRniY3SEq/6AjMXhIeG4uZou0uX
	T1JWQWErldLCAHGbbKjNE4ikIYiVlyKKwYpR4H1psxCSrbxMA5V02PVKDd+eD0Avyt+dl9
	WsMz/eNxiHEr+afpYj/BgWXY/MU8svW8dpYl+aWeyGHiLAtYIimWdeyAbccyRg==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 09/11] arm64: dts: imx8mm-kontron: Add support for reading SD_VSEL signal
Date: Wed, 27 Nov 2024 17:42:25 +0100
Message-ID: <20241127164337.613915-10-frieder@fris.de>
In-Reply-To: <20241127164337.613915-1-frieder@fris.de>
References: <20241127164337.613915-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This fixes the LDO5 regulator handling of the pca9450 driver by
taking the status of the SD_VSEL into account to determine which
configuration register is used for the voltage setting.

Even without this change there is no functional issue, as the code
for switching the voltage in sdhci.c currently switches both, the
VSELECT/SD_VSEL signal and the regulator voltage at the same time
and doesn't run into an invalid corner case.

We should still make sure, that we always use the correct register
when controlling the regulator. At least in U-Boot this fixes an
actual bug where the wrong IO voltage is used and it makes sure
that the correct voltage can be read from sysfs.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* rebase to current master
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts    | 10 +++++++---
 .../arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi |  7 ++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index a8ef4fba16a9e..d16490d876874 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -254,6 +254,10 @@ &pwm2 {
 	status = "okay";
 };
 
+&reg_nvcc_sd {
+	sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -454,7 +458,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x40000d0
 		>;
 	};
 
@@ -467,7 +471,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x40000d0
 		>;
 	};
 
@@ -480,7 +484,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xd0
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x40000d0
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 663ae52b48526..d455429652305 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -342,6 +342,7 @@ reg_nvcc_sd: LDO5 {
 				regulator-name = "NVCC_SD (LDO5)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 			};
 		};
 	};
@@ -794,7 +795,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0 /* SDIO_A_D1 */
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0 /* SDIO_A_D2 */
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0 /* SDIO_A_D3 */
 			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6 /* SDIO_A_WP */
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x40000090
 		>;
 	};
 
@@ -807,7 +808,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4 /* SDIO_A_D1 */
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4 /* SDIO_A_D2 */
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4 /* SDIO_A_D3 */
 			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6 /* SDIO_A_WP */
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x40000090
 		>;
 	};
 
@@ -820,7 +821,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6 /* SDIO_A_D1 */
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6 /* SDIO_A_D2 */
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6 /* SDIO_A_D3 */
 			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6 /* SDIO_A_WP */
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x40000090
 		>;
 	};
 
-- 
2.46.1


