Return-Path: <linux-kernel+bounces-355438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297A995243
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0580C287D69
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DDE1E04BA;
	Tue,  8 Oct 2024 14:46:49 +0000 (UTC)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081041E00B1;
	Tue,  8 Oct 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398809; cv=none; b=M/Fy4tt/AJGmFsbWuUw4Zf/U/QmOT3nnLh12IPxFpo5RGRpN/o/DSGOL12j2JxDoDTnHW0yRJ30sQqJDP0URt06glnq5G6eSu4RQBjMxKwpvUcH+Ty54F50JlgKPfhX2p0LbpochZYi0c39A8yMvx9HdIgjxd6TgJfa6mWwqn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398809; c=relaxed/simple;
	bh=bpIUOcVa+SVwDFs5HB5td6RIujhDxy3RzHcNfO/9I9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0Nk+bixs41S6yA50Hl5S6Z12StY9NvbL/yCmwv9m7tXpdpZNVZudZYqMPGrmTQwg15Kpuutf61DKEricuJdF8Dudvd5o++LyrolNd+Tzm8PgZQaGrT6QROgdV7YUo4IILN3d0aZkYXuQMG/lhHv/QWqAFLxMwpiGK/qGhckwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37971BFB0D;
	Tue,  8 Oct 2024 16:38:25 +0200 (CEST)
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
Cc: Frieder Schrempf <frieder@fris.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
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
Subject: [PATCH v3 0/4] arm64: dts: imx8mm-kontron: Add HDMI and LVDS display support
Date: Tue,  8 Oct 2024 16:37:42 +0200
Message-ID: <20241008143804.126795-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This add support for the display bridges (DSI->LVDS and DSI->HDMI)
on the BL i.MX8MM and the 7" LVDS panel in a separate overlay.

Only one of the interfaces (HDMI or LVDS) is supported at the same
time. Enabling the LVDS overlay will disable the HDMI interface.

* Patch 1 and 2: Add the necessary binding changes
* Patch 3: Extend the BL devicetree
* Patch 4: Add the LVDS panel overlay

Changes for v3:
* Add A-b tag from Krzysztof
* Fix LVDS bridge input port reference

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


