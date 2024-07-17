Return-Path: <linux-kernel+bounces-254978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5F933A17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C1E1C225F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2271D48CCC;
	Wed, 17 Jul 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U56LELKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3447F4D;
	Wed, 17 Jul 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209090; cv=none; b=Hev7pj4VO3l05vdPjOGiL8PXETs/JwlZTZ0s72KCH7/FvrBhbt+AIp/K5y+/LeIOoAFRiSjv7m1c4+Rz8+cOfUKtJg1vT9Sg45KvcMsERPp7zYXdeliv6nSql3okacLrR3RAPqrm9362zsS7FwpidZfYUVLgYQvsqK+eLR6ITgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209090; c=relaxed/simple;
	bh=ubP44NuaGuAY90GjTboVKQYzq7RaHydSJd5UcJwCg9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtYuq3vuy35Bfhgry7YVKUGCOKUA4VkLoB9s+1I2ZGxuaC17a5NspWCZgsWdTdE4pP2ci7aPALBuT/2UFlstomj49KNpws5xJ7XTMw6GBFgsN2ryJhVhhcxlEhYDzlUueFLsxjhLjD1g/3fndxe+Kpq9Nz7iAETjuDLAqnMxdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U56LELKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3C6C4AF0F;
	Wed, 17 Jul 2024 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721209090;
	bh=ubP44NuaGuAY90GjTboVKQYzq7RaHydSJd5UcJwCg9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U56LELKcbq6iDWxH6yGU5DkmtU0YvxhK9MJhlwBfbqw6xKV02nzIlPuAuF4KNjZqH
	 y8Cv227swF7p2+VP/eR5zV08eYKkqjgdxBuClvaR8ARhvnxLwfKv5tTO5ONm3sFSGy
	 mQNRtxqXVGHckwWcaHJTedH1/WuA6h/wZyYFU+nv9kpmdWfM7V8RTEbqA1aCWg2Wpe
	 IyqeWo21mcd26X1CRJFrCU7A+ortkj2oof0AnuMbR/Nwe+XnKi2UHD7G6Ykb8Pkrrx
	 HnL538xZXBAxTA42/rwXOJukM76egtIHilXAw7aBmIsx18Q1rm8+4LaGUB3fjLgaaD
	 UGFhebyC96Qag==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	imx@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: [PATCH v1 1/4] arm64: dts: imx8: remove non-existent DACs
Date: Wed, 17 Jul 2024 10:37:53 +0100
Message-ID: <20240717-alkalize-bouncy-83e748284bc7@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717-anvil-ashy-544e80a1317c@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=sKkWMQCF3ZOs6V++WZsAxf1OgaX475Y80SVGf7Gc4Hg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTJ3y022HU6njk6TlvlsxsNff2Ob/envY/rbfonqXGG h/x18tvdJSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiduwMf3jC9q/ddzZoY/TE KDXdpyz3cvUtY7b29smoGJi9q1g7j5WRoc9rQ859nrX/O4W/mXDNaM05/VfSujnKJ8zGtq3RMec VHwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Neither the imx8dxl-evk or imx8qm-mek have a Rohm DAC on them as far as
I can tell from online documentation, and they certainly do not have a
dh2228fv, as this device does not actually exist! Remove the DAC nodes
from the devicetrees as it is not acceptable to pretend to have a device
on a board in order to bind the spidev driver in Linux.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 6 ------
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 1a74ac3ee4ee..4caaecc19227 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -722,12 +722,6 @@ &lpspi3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpspi3>;
 	status = "okay";
-
-	spidev0: spi@0 {
-		reg = <0>;
-		compatible = "rohm,dh2228fv";
-		spi-max-frequency = <30000000>;
-	};
 };
 
 &iomuxc {
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 778741dbbb33..3f0fd147bbd0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -287,12 +287,6 @@ &lpspi2 {
 	pinctrl-0 = <&pinctrl_lpspi2 &pinctrl_lpspi2_cs>;
 	cs-gpios = <&lsio_gpio3 10 GPIO_ACTIVE_LOW>;
 	status = "okay";
-
-	spidev0: spi@0 {
-		reg = <0>;
-		compatible = "rohm,dh2228fv";
-		spi-max-frequency = <30000000>;
-	};
 };
 
 &lsio_mu5 {
-- 
2.43.0


