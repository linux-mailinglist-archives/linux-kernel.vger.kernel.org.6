Return-Path: <linux-kernel+bounces-216976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAE90A98A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A47AB24ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDE1946D2;
	Mon, 17 Jun 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR7PI9wj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FA1946C2;
	Mon, 17 Jun 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615642; cv=none; b=BagaZN6stq/H6TBipxQPW16vgpe++HRIE/b5Dy+iEMb3YrJDMf0bVMignXLbkDq8x5S5Cnk8KzeDHjX1ZD/awOXmhiOdChCmjYwc/0LHZfGkbTXjXF+bRf/FvKQPdWlwsKeWmDtIBnHyEywReKNuvBN+c+oN1ehmWvu0MhfaB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615642; c=relaxed/simple;
	bh=u7AHMpJ6hxJGCGVBQb96kcRwezvJLSM7EQzp7Un9VP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwYi8BDhXu/lWXEZyVfGIUiKMWXKiVUdeCAW7Ho3ZDE+ik9euLaVn2/dxhYS8Aj41hFmBi5rx9p4+yZvvgZZLjq8l+jKqoy12TwcaNh4GAMh0klIirqKMQwSEbL40R5lfcY12WB7oGQGUHLxoNIFhqWKwjUe/pyJDt4teVZM7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR7PI9wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE493C2BD10;
	Mon, 17 Jun 2024 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615641;
	bh=u7AHMpJ6hxJGCGVBQb96kcRwezvJLSM7EQzp7Un9VP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TR7PI9wjEpaJiLESintGheMjzmDq2dUthpz5G1LxNSpGs/ZMdn1VOiCC3xq2hnw9I
	 GU/VdpJifNfe0Pvl6XzDu9WEbUmNzNI5sUTWz5Y2jEjJUuExdSVHrI2CmOhJjBgxCm
	 kReeR9kpYd3C0IzjZcSIj74JYmuRpLW39ZKeRrjsvfMauZIrDmbWpIBDusERxbB1N6
	 NruwfvQVUI3S1naqijfp5Ll8WXYRdzsVZBMLDhIIFYtf3MKzbr6SgzYegtJmaJnw0X
	 EakdtNY0tXXwDkgX/2n/J02LjL6rvRRBTuWo9/R/kzBJ/nk3RaIjbmgryY/iZgq1rX
	 ggFklxvaBxP+Q==
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
Subject: [PATCH v3 03/13] ARM: dts: imx6qdl-kontron-samx6i: fix board reset
Date: Mon, 17 Jun 2024 11:13:31 +0200
Message-Id: <20240617091341.2375325-4-mwalle@kernel.org>
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

On i.MX6 the board is reset by the watchdog. But in turn to do a
complete board reset, we have to assert the WDOG_B output which is
routed also to the CPLD which then do a complete power-cycle of the
board.

Fixes: 2125212785c9 ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
index d6c049b9a9c6..700780bf64f5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
@@ -817,5 +817,6 @@ &wdog1 {
 	/* CPLD is feeded by watchdog (hardwired) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
 	status = "okay";
 };
-- 
2.39.2


