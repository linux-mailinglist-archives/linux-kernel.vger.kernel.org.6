Return-Path: <linux-kernel+bounces-314601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7AF96B598
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C94287227
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7414619CC02;
	Wed,  4 Sep 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="mBO7W3sJ"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC718A6CF;
	Wed,  4 Sep 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440133; cv=none; b=Wl8cm76ClDoP0vcMilAHZRKU6Vle0DRmY5UJ8S3rCBfe/oiQakUbnQYe+1dtkAR+LvVkPx1qwc6ajdWKjJQMryVRyyeg5IctWrOD+7EYmmqXtGDHHBlMP+5JlGRLTPQM42k2cie/yyvgiAONWXdGf/v9+trbGMMy/oNy5SqrLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440133; c=relaxed/simple;
	bh=sJ1DPREOCwqu1OVMfYWKRaG4pLDx6igLH9g1iZYw91c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YeknVhP6xoIt1VgyJg1siKzdyeQ2b73KAvQeOrtzzR+uhiqDRjayonEcilJ2mtL5Uf9tTgnWrJxS6vHf90be7KG3OlQ7GH13PYOimylhaOe4mDdjhGKU8q3LMMiQVG1/M04PaE/FhO5NFXrQUT1fFOBpAINJ+Xll93BBE4TOnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=mBO7W3sJ; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4152BFB4B;
	Wed,  4 Sep 2024 10:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1725440121; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=tkvDCLWUEZYeYckxRogBfP+jECpYcjBnqLACL5yPBR0=;
	b=mBO7W3sJ0oKgkemCvBSn24vHqHZ0GRYfyBZLqDIH8geas2L3avZm0CeUMmn1U9sLtO5oyY
	tzbG5r1diqepvWh0EqzeRfS7QIrkeDscPVA6N0Rga1QFXjq6/DGd+Z8PtcjL/VnO0SIV/f
	atKffTZaMiNpYdg14GaJofln7Fl/xBsWDqnYp3GO1Jb3JYrFvvR6VvUWxJrUqIYJ6sAxCk
	gtbN6mIriob/oi4klAb7MIar4DJgzHDtQ8jkljR/TNp6eSgcSSsJUwjgmZmDY1A2PyVk1I
	B4En0p74nsxb6Bhoe0G9yV/OgHCHKPxbSsqdouwGGl9WA8tJDMxCaKZ+o0rBAQ==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 0/3] Add support for Kontron OSM-S i.MX8MP SoM and carrier boards
Date: Wed,  4 Sep 2024 10:53:18 +0200
Message-ID: <20240904085415.645031-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Patch 1: board DT bindings
Patch 2: OSM-S i.MX8MP SoM and BL carrier board devicetrees
Patch 3: i.MX8MP SMARC module and eval carrier board devicetrees

Changes for v3:

* Address Shawn's review comments (thanks!)
* Fix HDMI DDC interface
* Fix gpio-hog pinctrl in DL devicetree
* Fix DT check warnings in DL devicetree
* Adjust LVDS panel node to match that of proposed DL i.MX8MM

Changes for v2:

DT bindings (patch1):
* Add tags from Krzysztof and Conor (thanks!)

SMARC DTs (patch 3):
* Fix GPIO labels
* Add support for TPM chip on SMARC module
* Disable PWM in favor of GPIO5 on SMARC carrier
* Enable LCDIF node to make HDMI work
* Add support for GPIO expanders on SMARC carrier
* Remove SPI flash as its removable and should be in an overlay
* Add CAN regulators to fix transceiver enable

Frieder Schrempf (3):
  dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
  arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier
    board
  arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval
    carrier

 .../devicetree/bindings/arm/fsl.yaml          |  13 +
 arch/arm64/boot/dts/freescale/Makefile        |   6 +
 .../dts/freescale/imx8mp-kontron-bl-osm-s.dts | 305 ++++++
 .../boot/dts/freescale/imx8mp-kontron-dl.dtso | 110 +++
 .../dts/freescale/imx8mp-kontron-osm-s.dtsi   | 908 ++++++++++++++++++
 .../imx8mp-kontron-smarc-eval-carrier.dts     | 254 +++++
 .../dts/freescale/imx8mp-kontron-smarc.dtsi   | 280 ++++++
 7 files changed, 1876 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi

-- 
2.46.0


