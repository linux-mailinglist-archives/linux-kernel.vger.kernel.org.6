Return-Path: <linux-kernel+bounces-216973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3D90A949
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0551F23AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C656193073;
	Mon, 17 Jun 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/jvXbUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D971922E1;
	Mon, 17 Jun 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615629; cv=none; b=AA2udZ/t13KxIUda+rFveF8rETOg5+T6vwmQVVz4f8w/VojDf1Q8Icz+fc57+6hisOFRz0VagPrtP3mUmHffXW8XmtPPtPxkDXnWJu424ObxNxlODnSMb2YsJ4bLTYE0CGmymWnCDOcth0VTiTrYWxcXCNNh3uUbabPfg1iMQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615629; c=relaxed/simple;
	bh=gJOo7WNeyvV5BitAzjnu0XlIydfEGJWMn3PyLBsZvzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qplKXSfDZnMX0Nbhx80+D0bErg8UOE1gJ1v6wWBNtM/8R0wDnDOpj1GwR72usXWp0jpWSqAKTzO8KgsXrpjAx/vePaOWlWCCfNRy0UtN0cyADDYYODnHm2G0w6zzJ0RgiEmhZsB5v7EIcwbZ+JsrCJhJM45+oajfdCxpm+03KH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/jvXbUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCA6C4AF1A;
	Mon, 17 Jun 2024 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718615629;
	bh=gJOo7WNeyvV5BitAzjnu0XlIydfEGJWMn3PyLBsZvzU=;
	h=From:To:Cc:Subject:Date:From;
	b=l/jvXbUxEgCzLBbCmOBsGuxeQUaGpBgpN6UEyh2EvYLYCoPVfsDw4Cbo2/INupj4e
	 kfBlvRp55NXO85T05yT+l5nAx5qbx1wnnsLlBB3IhGdYpM2rQoIG+6J6cCZk1V41M7
	 TfC4IHMFFtrnz1yLvZQQH8T5+/puB+Q6vFA0j9BDtqG9ERXDPNYdeutPbyLTEIsDT/
	 CVzqiIbi10Lg61i7IVvG+pMvx084RG0kczX/2zrFBLIGc3s4w4jlR09a5/RnPZuSWK
	 KAk25lCLU8TYWE21zGLmrnYszj9Uh04U9wM6p7YQI5AAIKMKwUxQAUt4hykOsudmOt
	 7p4XIOFcrT4Tw==
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
Subject: [PATCH v3 00/13] ARM: dts: kontron-samx6i: various fixes
Date: Mon, 17 Jun 2024 11:13:28 +0200
Message-Id: <20240617091341.2375325-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on a new PHY support for this board I've noticed quite
a few errors. Fix these and introduce an actual board for the
module. For now, there was just a dtsi and no actual user of it.

v3:
 - fix typos and property order. Thanks Shawn.

v2:
 - new patch to fix the node names to make the schema happy
 - new patch to fix the PCIe reset line polarity
 - new patch to remove the unused and invalid wake-up-gpio property
 - add required poperties for the supply voltages to the wm8904 node
 - enable PCIe in the ADS2 device tree include

Michael Walle (13):
  ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
  ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
  ARM: dts: imx6qdl-kontron-samx6i: fix board reset
  ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
  ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
  ARM: dts: imx6qdl-kontron-samx6i: fix product name
  ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
  ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
  ARM: dts: imx6qdl-kontron-samx6i: fix node names
  ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity
  ARM: dts: imx6qdl-kontron-samx6i: remove wake-up-gpio property
  dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
  ARM: dts: imx6qdl-kontron-samx6i: add actual device trees

 .../devicetree/bindings/arm/fsl.yaml          |  12 ++
 arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
 .../nxp/imx/imx6dl-kontron-samx6i-ads2.dts    |  12 ++
 .../dts/nxp/imx/imx6dl-kontron-samx6i.dtsi    |   2 +-
 .../dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts |  12 ++
 .../dts/nxp/imx/imx6q-kontron-samx6i.dtsi     |  25 +--
 .../nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi  | 148 ++++++++++++++++++
 .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   |  58 ++++---
 8 files changed, 225 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi

-- 
2.39.2


