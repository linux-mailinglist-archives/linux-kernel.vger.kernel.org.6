Return-Path: <linux-kernel+bounces-573846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA8CA6DD16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3CE3ACFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A549B25E44B;
	Mon, 24 Mar 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skDP9JoD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8CEEC5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826805; cv=none; b=O32h6FQ2gxzzcrVvWCP7c7rusNLlf+bYlxq5xdi9CRIjA/pbyEGCeOzkP0lLfCzExQmL9tO5G036josUnrZAyfA6YbWrodv724OZ3yxcpBlvVVjjdppyZixikyWTv7uqgDJvR3IH1T0y+iMFxE9MT02kDtyz9ss0KsaCqIsOgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826805; c=relaxed/simple;
	bh=G8cKiW2vpJb2eugsp8SM6GevyFixi97OXtCapEgWzFk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=EbnyTm6MrhvLrxcT0FxzJxHnior33CrZZmxfOIQi0LfpZz4nULZrNzIGXWd62D6M6ZnmFxd3tYU+3XV6dyIo+oiCGzVaF0rjz+ScJR8CjhX2d76sxct633yyRxtObYP1ovn+6RAqIRpsGLdcCn1McziCwNsMqDc2zN1GnOMkNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skDP9JoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D82C4CEDD;
	Mon, 24 Mar 2025 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826804;
	bh=G8cKiW2vpJb2eugsp8SM6GevyFixi97OXtCapEgWzFk=;
	h=From:To:Cc:Subject:Date:From;
	b=skDP9JoD3NYPdwU53BOmd76gngw/oGrjFChkNCR6E52W8qwEkf+l6ZchdAuCu1LsD
	 ECsr0AHht8xyFyMBfH/ceOuH9sEw/CPnDhKK3kDe5hVpBKJY5iQ7DuGImEV/8ctpIH
	 C1bWr7Jhs19esG/WPux7km5Ka6kw1FPt2nc5fYxaN67X1M6U41WNiLVAbJ0f0zvcUI
	 UiGYb+qEGCp3vidvXF4K8h1ApXoW6zJb1YbpMKjKBLMqCy28jFRXgAlCt6RcLRxmQ+
	 RSBpzPyDVWHfqkvE1vfju0mqGCLwEcpqvyZxRYi6wgfs7HFz7pLngZUTQHKQtorotQ
	 DhkeEds4dB+Ow==
Message-ID: <c3bcfe47f04670e9fb5e49afee560a09.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.15
Date: Mon, 24 Mar 2025 14:33:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.15

for you to fetch changes up to c94764d3f4e503c0c4d56c8f64a8a63645091898:

  regulator: axp20x: AXP717: dcdc4 doesn't have delay (2025-03-19 12:28:26 +0000)

----------------------------------------------------------------
regulator: Updates for v6.15

This has been a very quiet release, we've got support for one device
added, another removed, and some smaller fixes and API improvements.
The main thing of note is the rework of the PCA9450 LDO5 handling:

 - A rework of the handling of LDO5 on the PCA9450, this was quite wrong
   in how it handled the SD_VSEL conrol and only worked for some system
   designs.  This includes a DTS update since there was a not quite ABI
   compatible change as part of the fix.
 - A devres change introducing devm_kmemdup_array() was pulled in so it
   could be used with some regulator conversions to that function, this
   pulled in some other devres and IIO stuff that was part of the same pull
   request.
 - Removal of the PCF50633 driver, the SoC for the OpenMoko platform
   that used it has been removed.
 - Support for the NXP PF9453.

----------------------------------------------------------------
Andy Shevchenko (2):
      driver core: Split devres APIs to device/devres.h
      iio: imu: st_lsm9ds0: Replace device.h with what is needed

ChiYuan Huang (2):
      regulator: dt-bindings: rtq2208: Mark fixed LDO VOUT property as deprecated
      regulator: dt-bindings: rtq2208: Cleanup whitespace

Colin Ian King (1):
      regulator: rtq6752: make const read-only array fault_mask static

Dheeraj Reddy Jonnalagadda (1):
      regulator: ad5398: Fix incorrect power down bit mask

Dr. David Alan Gilbert (1):
      regulator: pcf50633-regulator: Remove

Frank Li (1):
      regulator: dt-bindings: pca9450: Add nxp,pf9453 compatible string

Frieder Schrempf (7):
      dt-bindings: regulator: pca9450: Add properties for handling LDO5
      arm64: dts: imx8mp-skov-reva: Use hardware signal for SD card VSELECT
      Revert "regulator: pca9450: Add SD_VSEL GPIO for LDO5"
      regulator: pca9450: Fix control register for LDO5
      regulator: pca9450: Fix enable register for LDO5
      regulator: pca9450: Remove duplicate code in probe
      regulator: pca9450: Handle hardware with fixed SD_VSEL for LDO5

Isaac Scott (2):
      regulator: ad5398: change enable bit name to improve readibility
      regulator: ad5398: Add device tree support

Joy Zou (1):
      regulator: pf9453: add PMIC PF9453 support

Mark Brown (3):
      regulator: Add device tree support to AD5398
      Fix RK3588 power domain problems
      Convert regulator drivers to use

Philippe Simons (1):
      regulator: axp20x: AXP717: dcdc4 doesn't have delay

Raag Jadav (4):
      err.h: move IOMEM_ERR_PTR() to err.h
      devres: Introduce devm_kmemdup_array()
      regulator: devres: use devm_kmemdup_array()
      regulator: cros-ec: use devm_kmemdup_array()

Sebastian Reichel (1):
      regulator: Add (devm_)of_regulator_get()

 .../bindings/regulator/nxp,pca9450-regulator.yaml  |  51 +-
 .../bindings/regulator/richtek,rtq2208.yaml        |   3 +-
 .../arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi |   5 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   2 +-
 drivers/regulator/Kconfig                          |  14 +-
 drivers/regulator/Makefile                         |   2 +-
 drivers/regulator/ad5398.c                         |  30 +-
 drivers/regulator/axp20x-regulator.c               |  14 +-
 drivers/regulator/cros-ec-regulator.c              |   4 +-
 drivers/regulator/devres.c                         |  22 +-
 drivers/regulator/of_regulator.c                   |  21 +
 drivers/regulator/pca9450-regulator.c              |  91 ++-
 drivers/regulator/pcf50633-regulator.c             | 124 ---
 drivers/regulator/pf9453-regulator.c               | 879 +++++++++++++++++++++
 drivers/regulator/rtq6752-regulator.c              |   2 +-
 include/linux/device.h                             | 119 +--
 include/linux/device/devres.h                      | 129 +++
 include/linux/err.h                                |   3 +
 include/linux/io.h                                 |   2 -
 include/linux/regulator/consumer.h                 |   6 +
 21 files changed, 1221 insertions(+), 304 deletions(-)
 delete mode 100644 drivers/regulator/pcf50633-regulator.c
 create mode 100644 drivers/regulator/pf9453-regulator.c
 create mode 100644 include/linux/device/devres.h

