Return-Path: <linux-kernel+bounces-203932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14D8FE21A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C740528BE94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69E15530F;
	Thu,  6 Jun 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr4KguAx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91E153804;
	Thu,  6 Jun 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664550; cv=none; b=Gbjow/vSjdwb9qgj3D1DWRqPm9VPSxN2jNk5jjeQ1eShLigabW4vl+ihoCLeE+z1Q6nNTF8xCKTZlJWarFt4PFiIhT5Hs51+EYR/TIA24QBjiD/7/nF/e+a3pU8cM6U0Xo1JJnYNy2d5zlW+MXRH0ObSyfsxgL3l5f+XoVBDnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664550; c=relaxed/simple;
	bh=pmxH+3/T6ldwrIaJrUq9EPud/gdsJYcTk1L1yQXC5Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eR8/pTEOg6dz7uf9sK8lAA4bpYiUDxCPmqtCniKiIEqbedTep90DUjaQxorNFiRo3uBJsP2bxVxX7NAa4xZlLmqFKk/ilnf8Xtzd924RvL8iBHkTpQCK/muXKZLYtK1sbo5wOzvJtoZ4vHSGZ6eKcR6jVuvlgkHnWeEc+y5RqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr4KguAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA777C4AF0E;
	Thu,  6 Jun 2024 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664549;
	bh=pmxH+3/T6ldwrIaJrUq9EPud/gdsJYcTk1L1yQXC5Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rr4KguAxRO83o1oOwBS82084EmVpU2HrIaegP7YxAzlq4g4czu3a1Ro+kefM9TDFi
	 zioF8hGypYGj1cPOcAjARo3WvpLvGWUOjUljkaU2VL3Shq0W7M5AzfUtYkPIiKyaXL
	 CqnT5PXEESZ2igkyT3KIs2/ro5ATDz/hVfOF0ZY8/3KY0x6L7Pavps9gITBlTiQFLp
	 1ihJpTpDspuVGBCim+VJKkRCuH8o3slYu4ManKirkXel0jVs6ZZmEH8oYTCAQ8p/nx
	 HrVsQcONfcgBuoorChbMRJlGar4fF57msBhgksLwp2yax0uZljlnvrmZoB0GvAs0j1
	 P8xmgq3kMLR+A==
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
Subject: [PATCH v2 03/13] ARM: dts: imx6qdl-kontron-samx6i: fix board reset
Date: Thu,  6 Jun 2024 11:01:56 +0200
Message-Id: <20240606090206.2021237-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606090206.2021237-1-mwalle@kernel.org>
References: <20240606090206.2021237-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On iMX.6 the board is reset by the watchdog. But in turn to do a
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


