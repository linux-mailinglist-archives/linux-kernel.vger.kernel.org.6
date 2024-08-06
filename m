Return-Path: <linux-kernel+bounces-276330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBF949233
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89A1282D48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01299201279;
	Tue,  6 Aug 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="nsESuk2s"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C31D47C5;
	Tue,  6 Aug 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952318; cv=none; b=p5+YqvYEHqNP5fACbeFAf0Obe0HFZZK7W8do9gNsC/SMGSBB/lAMlwokz//gcdkPCjNYr6X+bYC6bX9XD5UklJlnzIKTki3YDoqY1oJdohrPJvuZTQw8lmbhD6XIR67/+KYc7h6Z9fF+GufuBDEcOlzrzJjoyDC9rE1pFWl19zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952318; c=relaxed/simple;
	bh=8rybmepnuNG/Fm0NjZD4Qp7/jNS4BX4w/ave4TQ7X1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qA+H+6i3tJQ3q2XGl2oiiPAYtl/78YlXGPzQKgTvwLQwGoGmAHj+ebIoumJmxdKUta0ZnkT9fUpFYTOXc7tDvdcAwBHFngy6++q6SoFWY/u54zmZWiTOAchcBNC0g1lQ2VKTlf38qbtW+m6WRDEUYFwTkWGfJfBtb7dL1yVwnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=nsESuk2s; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88FF1BFB06;
	Tue,  6 Aug 2024 15:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1722951281; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=cyPHxdswqOb5N+EqzIxpN2i+5Izf1AnteHGpt/ataIA=;
	b=nsESuk2sVBWj2SesqVt3A1EOdeQ4/vRf6w6WccdSt2uhfIqTmi27B07agGlrLJ/m/A9Ku9
	qYJSFQk02oVwssdIZH6GL6EtTzm2GsZO14f0QCmTxiIGcK57DgSAQCnaOJG6XfLN25KTTf
	xHiwKKb2lvidS5m5qJYCAhByorTU2cLwIklqrTYNRID7jtNTqjJzD1xhYf1Y3bcNEm05S/
	WLltmZXvc25z2h03u8boQGeybd9E0IxrPB6GYAhRR9+959NN0XzN7ZcgsyA75AtTZhCVth
	UTAZOkw4AgI4lrPn4LlLGL8KiTvyX5nD7kTPxtcW5FhmFB+GcFbfZCHz6obyEg==
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
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH 0/4] arm64: dts: imx8mm-kontron: Add HDMI and LVDS display support
Date: Tue,  6 Aug 2024 15:32:58 +0200
Message-ID: <20240806133352.440922-1-frieder@fris.de>
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
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 146 ++++++++++++
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 210 ++++++++++++++++++
 5 files changed, 364 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso

-- 
2.45.2


