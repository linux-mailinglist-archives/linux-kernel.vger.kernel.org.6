Return-Path: <linux-kernel+bounces-423740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D859DAC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B083C28309A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D473C201026;
	Wed, 27 Nov 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="CjlxwcOY"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F017C96;
	Wed, 27 Nov 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726325; cv=none; b=aQ4+0YIOnVtWw7T6R9OXMuWJsoGnAwGKhno8DOOkgfECpJuJ0q2DPks2bq1UAya7B917q9hUMYVyuOGc5d1KK79BVfHwBqtaic8Q+GT0nzjsO8gP/UteLn1Tn8+LrJidwmBC9OxjMoU5hXhF/pdSAJ6vGT5JlHWrYDRQwv0R/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726325; c=relaxed/simple;
	bh=s7KBG8DmIQU8LbwcUDScsWRdDr/Bq7Ew+hOww8HVFx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4T2gV5DWJGoKVwncPBlq+jOLBdvjKIGMSmy3ArYUrDN0pykZVTWGQcNGU6MSUU0EOmx6YDQLYpe6jc3nKBxO/XJa5yki9AgYiBUgmAMu0h1mIKnSucwhkfgeO+52IPMgb/1qSFs7NXFk02O7Z+JatIZNG40iZK/3aNTrIkX6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=CjlxwcOY; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1C53BFB2F;
	Wed, 27 Nov 2024 17:44:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725869; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=GJsG2K/qyWxkx8maHy/IhNjKC6mBJMwLIPF3uPuwRJo=;
	b=CjlxwcOYmL1v1mau6RhjuYSMW/BXNA+PJ2FSZ8CSUzXYphR82MTOLS8V1n+WwTeoevCH39
	5YmWAuruAuOeqHcmLdGR9vIUjKBbyrAvQEd4gWwgdr8aFcLMeTSmeX7bkcZp78qZ2dthl+
	RND3vkVqcCEprE+n28ohd6EEBlAOikoHSusRYNyOk7Me2KE4rwSCyJ8q739+WhYJRCY/DC
	VNqGB+ERiNspRHXa69DpcUWnEg4tjXWxfNTvT/UWuw3txkN2q+e9Qj3z8fZ5K+UBr8VUvN
	S5OtBZJjYmw2YVOaxM/xVniN9BLz1WynHhHveyS2zlFZqIDM133pkJUjIOAwug==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Bo Liu <liubo03@inspur.com>,
	Fabio Estevam <festevam@gmail.com>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 00/11] Use correct LDO5 control registers for PCA9450
Date: Wed, 27 Nov 2024 17:42:16 +0100
Message-ID: <20241127164337.613915-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This is a follow-up of [1].

The main objective of this is to fix the PCA9450 driver to
use the correct control register for the LDO5 regulator.

Currently the control register to use for LDO5 is hardcoded to
LDO5CTRL_H. This is wrong for two reasons:

1. LDO5CTRL_H doesn't contain the bits for enabling/disabling
   the regulator. Only LDO5CTRL_L does.

2. The actual output voltage of the regulator is determined by
   the LDO5CTRL_H only if the SD_VSEL input is HIGH. If it is
   low, then LDO5CTRL_L is used. The driver does not take this
   into account.

This can cause several problems:

1. LDO5 can not be turned on/off and we rely on the bootloader
   to leave it turned on. On the other hand we can't save
   power if LDO5 is unused.

2. There is a potential for corner-cases where switching
   SD_VSEL via USDHC_VSELECT and writing to the (wrong)
   control register can cause wrong output voltage and therfore
   SD card failures (not observed yet).

3. Reading the current voltage of the LDO5 regulator (e. g. via
   sysfs can yield the wrong value as the voltage is read from
   the wrong control register.

At the same time there is now hardware that hardwires SD_VSEL
to a fixed LOW level and therefore relies on switching the
voltage only via a single control register. We add support for
this through an additional property "nxp,sd-vsel-fixed-low" in
the LDO5 node.

Summary of binding changes (patch 1-3):

1. Adjust the bindings to remove the old and abandoned use of
   sd-vsel-gpios property.

2. Adjust the bindings to use sd-vsel-gpios in the LDO5 node to
   retrieve an input that can be used to sample the SD_VSEL
   status.

3. Adjust bindings to allow "nxp,sd-vsel-fixed-low" to be used
   for boards that have SD_VSEL hardwired to low level.

Summary of driver changes (patch 4-7):

1. Remove the old sd-vsel-gpios handling.

2. Use the new sd-vsel-gpios property to determine the correct
   control register for LDO5.

3. Fix the enable register for LDO5.

4. Support hardware with fixed low level of SD_VSEL.

Summary of devicetree changes (patch 8-10):

Implement the changes in the devicetrees for Kontron hardware
(i.MX8MM, i.MX8MP and i.MX93).

Changelog:

v1 -> v2:

* Split binding patch
* Add solution for hardwired SD_VSEL
* Leave regulator core untouched as requested by Mark
* Add devicetree changes for i.MX8MP and i.MX93

[1] https://lore.kernel.org/lkml/20230213155833.1644366-1-frieder@fris.de/

Frieder Schrempf (11):
  Revert "regulator: pca9450: Add sd-vsel GPIO"
  dt-bindings: regulator: pca9450: Add sd-vsel-gpios to read back LDO5
    status
  dt-bindings: regulator: pca9450: Document nxp,sd-vsel-fixed-low
    property for LDO5
  arm64: dts: imx8mp-skov-reva: Use hardware signal for SD card VSELECT
  Revert "regulator: pca9450: Add SD_VSEL GPIO for LDO5"
  regulator: pca9450: Fix control register for LDO5
  regulator: pca9450: Fix enable register for LDO5
  regulator: pca9450: Handle hardware with fixed SD_VSEL for LDO5
  arm64: dts: imx8mm-kontron: Add support for reading SD_VSEL signal
  arm64: dts: imx93-kontron: Fix SD card IO voltage control
  arm64: dts: imx8mp-kontron: Add support for reading SD_VSEL signal

 .../regulator/nxp,pca9450-regulator.yaml      | 29 ++++--
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 10 ++-
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   |  7 +-
 .../dts/freescale/imx8mp-kontron-osm-s.dtsi   |  7 +-
 .../boot/dts/freescale/imx8mp-skov-reva.dtsi  |  5 +-
 .../dts/freescale/imx93-kontron-osm-s.dtsi    |  5 +-
 drivers/regulator/pca9450-regulator.c         | 88 ++++++++++++++++---
 7 files changed, 119 insertions(+), 32 deletions(-)

-- 
2.46.1


