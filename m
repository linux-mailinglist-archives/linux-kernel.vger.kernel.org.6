Return-Path: <linux-kernel+bounces-216980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7FD90A952
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9447E1C2463A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F91957E2;
	Mon, 17 Jun 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2QE5Huz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E2191487;
	Mon, 17 Jun 2024 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615657; cv=none; b=C7HJbBeLg1lInuQ4siiE0Vcky4ZbhpjbAhLmyajSyvwBGzRlLw3octAmSHrup2rT19sfmumw2HtU0wF25TnRj7zJRW2rVJ7Y8uOyU6mQZuhYEMf3y7mFvItK0N1YkODjUuuTCBn1ltlZbTn+N33Vftu9n2PZnPhWX/eWZXAJlww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615657; c=relaxed/simple;
	bh=bp4RUBBoDBNxBmueQhwpMXLVezAaB2zJTWzVJs7lfD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjUn/wWfu3bCbDdDNPf1g9+YSfA6wIYICgpEKQynFIISkbaQAJmLJoJzpmncbvZrahbUiLZT8R77e0ETeFizmEbFWxfbSZIcfSA4JcQk4d/I91yjHjHKWUwVGmZruZgjUIxT+Mu6qzjfDAFGrlXBNmv0PKFrgKL2o/8WFOcE0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2QE5Huz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C1EC4AF49;
	Mon, 17 Jun 2024 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615656;
	bh=bp4RUBBoDBNxBmueQhwpMXLVezAaB2zJTWzVJs7lfD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2QE5HuzOFuX81SdBqF4480CA19sd5iLeOJJU9ZxbBKVBbJCzu5zUDDIlY5aeSPEZ
	 EZkImFPY/kjCSwyESbZhfOAcytLWvavHjA6HF18YqZBX5CDEHn8g5iz2+JZkJC15YK
	 xgxN3PuqG7lVS/3WYF76f8QDjqxwszq/cz9iCYtxIkSnzkpb+aqD2qRDVkV3ujDZWU
	 ooza4qMLdSWx8/pf7F/3hG1Cujt68+pfIZ14tGJ6J64UbCl7754fZv9Ql/3saSGG6U
	 uy/ww3l0BhFWsSMgubbglDdXDwQcGL2TZxDSsJEsnCMQ9pvjjfx9atup7PevQStyhe
	 evgbGwhvKlBhA==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Li Yang <leoyang.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v3 07/13] ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
Date: Mon, 17 Jun 2024 11:13:35 +0200
Message-Id: <20240617091341.2375325-8-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617091341.2375325-1-mwalle@kernel.org>
References: <20240617091341.2375325-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no variants of this module without an eMMC.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index 4a6ab7e7908a..4d3cd338a707 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -800,7 +800,6 @@ &usdhc3 {
 
 /* SDMMC */
 &usdhc4 {
-	/* Internal eMMC, optional on some boards */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc4>;
 	bus-width = <8>;
@@ -809,6 +808,7 @@ &usdhc4 {
 	non-removable;
 	vmmc-supply = <&reg_3p3v_s0>;
 	vqmmc-supply = <&reg_1p8v_s0>;
+	status = "okay";
 };
 
 &wdog1 {
-- 
2.39.2


