Return-Path: <linux-kernel+bounces-203929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398FE8FE214
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A2C28BE1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA5714D6E7;
	Thu,  6 Jun 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNjPGWpR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67962E3E5;
	Thu,  6 Jun 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664540; cv=none; b=CS4zZ8jm+VDVapIfj3DMDxgVg1BJvbbcj5sxKUehYXqcm1PWAIXJJ1BHncFfVHWviI7jW905kywhp+BE7IjHsAaS3ljJ7xebETSa45RMhLW0nvpejadit5My79fZxebejJk+rMkBuJd/R8ZaGk9NAayzC+li0h52bU3pSvhMcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664540; c=relaxed/simple;
	bh=aI1uY2JkIFv49wkndJdFla4RkxMA1ro2reo6rPm40Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cF/zLY3H8j2IDcsAtLw7eZ5kxN84JY4mAFiJMApGI9+A7RJUUWzaQAq+zIci0ZddNsfMzz3et0JvPEEUVr14Lo79s1T8KHiVcMXAFqRYu+BsAE2MYwyKKBv6YAtIZbdWJ88M4KrJCWsSVaCQJPoKHPwCkW61TGcsqlltnjtAcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNjPGWpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E221C3277B;
	Thu,  6 Jun 2024 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717664539;
	bh=aI1uY2JkIFv49wkndJdFla4RkxMA1ro2reo6rPm40Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=DNjPGWpRTKgNoFfrNShpv8HfmT32GYqbdvbxB96anseRQkVufCH7u1hQPI34iHI/F
	 eOriX6W0KiC0mbFTscBG4842Okh+GnpYAR4ogQzjzLTBjQnb4KHgT57pkjMM8C77HR
	 0KKThcg0p55reSWy9rgCmfftGczF/e3e8GReYaIwtvl11pifEoSX5dY97QhCS/DhP0
	 Ax5puUo9CkA3AogUQs72WezouRsBzuCu7XQ8CzWCp7wglsg3YExXxAWZzOe4U28037
	 YZYaLZN4qeia3Q4JVdr56KU5tnKzMhVT/ArqKnVLZcMUs/o8dssTvKYooiXijmJ4ED
	 n1PsG6pqdXVAw==
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
Subject: [PATCH v2 00/13] ARM: dts: kontron-samx6i: various fixes
Date: Thu,  6 Jun 2024 11:01:53 +0200
Message-Id: <20240606090206.2021237-1-mwalle@kernel.org>
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


