Return-Path: <linux-kernel+bounces-304563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57969621DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B39C1F2163E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6015B99E;
	Wed, 28 Aug 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="YvrfdGUq"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB2157A67;
	Wed, 28 Aug 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831817; cv=none; b=FkGsyXJhtBe/6j0KiLMbH244MbmUKd90bBMTBz0etgYAeW1S3QwvFiyaEyqNUSxteaMqdkJp8mLCIs3mhPDVV+QsVv0C9/ND8ueJ4b4h3nuflvfAJapnD47N8HmE3Cf2QGWSLvr2FPt/gmKcOjaXdicz71B0yc+/UN0hCJ2y2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831817; c=relaxed/simple;
	bh=o1/M+3PhzxTC2Qyi5wfEU2L4YbYB8ba3gjqhV8GQ+II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U925wh4HJe1SmkvkJenFBeORfnw8s8OfRNL8XuwNlD0rscTUwHeoAPHHxaYWL4xUReVAcCKR9Tu5GZbWo/NGVed01URHORRCs/XmJnRqeLJJUEchyxhvH2Zu3JMd3j0kPQjjRkiUwStkvg7xd+2uFO1jsX4pUUAEQ5ZTA+LA8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=YvrfdGUq; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39EFDBFB0B;
	Wed, 28 Aug 2024 09:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1724831308; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Sk/iSLcWW34am2lJOyTQ6p5QG/I58ELhkbjR/9vSduk=;
	b=YvrfdGUqoG4TzSdQg8ZLh0JBKEYm6E1giJ2JsfZgxSqv8fABfEYoiZLjhW/+uMUXz3S+N+
	1v5O13rt7wvMMYaq9ozDvngd1pXSruN2C1UhHAZG37az6rYZHqapTwKF1wPPRm/6VrEqyd
	IpCPdfcE1GNXDew711fXv7ZN0JQjvzC5yI5BKkTp+YR/Jy5RjapErNFPuPipV9QlzcTPY+
	YRJGbDtv9nLhSzFSYM5mHYfWxOtYAN0xhVto4hTuscSsznenOYOKF9/vNLjjUSmYv9ToZq
	zNlfYy6QedCo0Z+8mXqeM7BZIMZ3n3WJkpG0+o7C9hRBuf4Jr9+9vOKnO8HoeQ==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH v2 0/4] arm64: dts: imx8mm-kontron: Add HDMI and LVDS display support
Date: Wed, 28 Aug 2024 09:46:52 +0200
Message-ID: <20240828074753.25401-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This add support for the display bridges (DSI->LVDS and DSI->HDMI)
on the BL i.MX8MM and the 7" LVDS panel in a separate overlay.

Only one of the interfaces (HDMI or LVDS) is supported at the same
time. Enabling the LVDS overlay will disable the HDMI interface.

* Patch 1 and 2: Add the necessary binding changes
* Patch 3: Extend the BL devicetree
* Patch 4: Add the LVDS panel overlay

Changes for v2:
* Patch 1: Add link to commit message
* Patch 2: Add Conors A-b tag
* Patch 3: Remove blank lines from hdmi node
* Patch 3: Fix order of lvds and hdmi nodes within i2c
* Patch 3: Remove the unneeded deletion of samsung,pll-clock-frequency
* Patch 3: Use the existing MIPI DSI output port from imx8mm.dtsi
* Patch 4: Update copyright year
* Patch 4: Use exisitng MIPI DSI output port from imx8mm.dtsi
* Patch 4: Fix pinctrl for GPIO hogs
* Patch 4: Fix property order in i2c2 node
* Patch 4: Use generic node name for touchscreen

Frieder Schrempf (4):
  dt-bindings: vendor-prefixes: Add Jenson Display
  dt-bindings: display: panel-lvds: Add compatible for Jenson
    BL-JT60050-01A
  arm64: dts: imx8mm-kontron: Add support for display bridges on BL
    i.MX8MM
  arm64: dts: imx8mm-kontron: Add DL (Display-Line) overlay with LVDS
    support

 .../bindings/display/panel/panel-lvds.yaml    |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 131 ++++++++++++
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 189 ++++++++++++++++++
 5 files changed, 328 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso

-- 
2.46.0


