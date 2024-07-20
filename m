Return-Path: <linux-kernel+bounces-257952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FE93815A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A56328183D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF6128369;
	Sat, 20 Jul 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e9afm9Wa"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696761B86DD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721479121; cv=none; b=M6Ojmugk/d3KLCE9utR7my6JLP4NPPzBU4gVSkKLcS9aumjwc0G0rehdQ0YO2oy7kY+Nby6pZ9pUkPewqVodwDcsvyo4X9/drCUqA24SdvkXm3i30A+3Mbo5K0b86BTkC7z3cvLEgGH5rO9Qz3K9Q6bK+WGcfmtOi5iak+Cre2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721479121; c=relaxed/simple;
	bh=gTe+iu1QgSPc8BSdz9VGwr3fJDWbSrEm8EmdnrEeIzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=daeHJLHBgev1qjKEKSEmES0ZQvN8CqKTncIEcS+dC0fECnDMAAFO5l4d2hj7Qe9tUlJcsppxueCLiFZwUIxd1H6PoYUtUyqqS09Y6C6C4OjPGRwk4Y0Le/HylNz9fkJ7/JMlTJyeYigcq8qOjxlRryi3QNGbDf0WsgABTfaH+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e9afm9Wa; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6A8F40004;
	Sat, 20 Jul 2024 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721479111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EXqe4uCmBSMeMnDxXrxmXb4ytri2O4buSnMP2mBx/F0=;
	b=e9afm9Wah/VjjPQLLIrvFJmEhtphl+w79O6sY3usR4rpZt/h6SuhKKbggXPJjbKCccmbCg
	hgzrzarV/wazmt9mDnusOrwXES1quSmXcU+HFcws4CsognI0uv4OrPRxCsUg8Ts3ZV0Xvj
	o9bcRdlHIDzXOeSwSyxAcrG4iHUEq3gyqWwmCotxhP+W87FmgGy/q3LcvK6aJfUOxZpHSk
	uAp7x5ay2Yw5nHmW8zNskc91cB9MdVZtQtwUKyg3KHMzllaEbcAm+SO5t92Z2srrgwKgrW
	RLPKAK/q3+uhMGAkphLkUQR38nxAqd3NEDnE+ZvP0xaCf3+Ud+BtKOcHXAVqyA==
Date: Sat, 20 Jul 2024 14:38:26 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 6.11
Message-ID: <20240720143826.00dec422@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Linus,

This is the MTD PR for 6.11.

Thanks,
Miqu=C3=A8l

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.11

for you to fetch changes up to 78a0b13f5744bd270d0c2391973605d9960a402a:

  Merge tag 'nand/for-6.11' into mtd/next (2024-07-20 14:24:38 +0200)

----------------------------------------------------------------
MTD changes:

- Nothing stands out for this merge window, mostly minor fixes, such as
  module descriptions, the use of debug macros and Makefile improvements.

Raw NAND changes;

- The Freescale MXC driver has been converted to the newer ->exec_op()
  interface. The meson driver now supports handling the boot ROM area
  with very specific ECC needs. Support for the iMX8QXP has been added
  to the GPMI driver. The lpx32xx driver now can get the DMA channels
  using DT entries. The Qcom binding has been improved to be more future
  proof by Rob. And then there is the usual load of misc and minor
  changes.

SPI-NAND changes:

- The Macronix vendor driver has been improved to support an extended ID
  to avoid conflicting with older devices after an ID reuse issue.

SPI NOR changes:

- Drop support for Xilinx S3AN flashes. These flashes are for the very
  old Xilinx Spartan 3 FPGAs and they need some awkward code in the core
  to support. Drop support for these flashes, along with the special
  handling we needed for them in the core like non-power-of-2 page size
  handling and the .setup() callback.

- Fix regression for old w25q128 flashes without SFDP tables. Commit
  83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
  dropped support for such devices under the assumption that they aren't
  being used anymore. Users have now surfaced [0] so fix the regression
  by supporting both kind of devices.

- Core cleanups including removal of SPI_NOR_NO_FR flag and
  simplification of spi_nor_get_flash_info().

[0] https://lore.kernel.org/r/CALxbwRo_-9CaJmt7r7ELgu+vOcgk=3DxZcGHobnKf=3D=
oT2=3Du4d4aA@mail.gmail.com/

----------------------------------------------------------------
Andy Shevchenko (2):
      mtd: cfi: Get rid of redundant 'else'
      mtd: physmap: Use *-y instead of *-objs in Makefile

Arnd Bergmann (1):
      mtd: make mtd_test.c a separate module

Arseniy Krasnov (3):
      dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
      mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
      mtd: rawnand: meson: read/write access for boot ROM pages

Cheng Ming Lin (2):
      mtd: spinand: macronix: Add support for reading Device ID 2
      mtd: spinand: macronix: Add support for serial NAND flash

Cs=C3=B3k=C3=A1s, Bence (1):
      mtd: cmdlinepart: Replace `dbg()` macro with `pr_debug()`

Dr. David Alan Gilbert (1):
      mtd: rawnand: cadence: remove unused struct 'ecc_info'

Frank Li (2):
      dt-bindings: mtd: gpmi-nand: Add 'fsl,imx8qxp-gpmi-nand' compatible s=
tring
      mtd: rawnand: gpmi: add 'support_edo_timing' in gpmi_devdata

Han Xu (1):
      mtd: rawnand: gpmi: add iMX8QXP support.

Jeff Johnson (1):
      mtd: add missing MODULE_DESCRIPTION() macros

Michael Walle (6):
      mtd: spi-nor: Remove support for Xilinx S3AN flashes
      mtd: spi-nor: get rid of non-power-of-2 page size handling
      mtd: spi-nor: remove .setup() callback
      mtd: spi-nor: get rid of SPI_NOR_NO_FR
      mtd: spi-nor: simplify spi_nor_get_flash_info()
      mtd: spi-nor: winbond: fix w25q128 regression

Miquel Raynal (2):
      Merge tag 'spi-nor/for-6.11' into mtd/next
      Merge tag 'nand/for-6.11' into mtd/next

Piotr Wojtaszczyk (2):
      mtd: rawnand: lpx32xx: Request DMA channels using DT entries
      mtd: rawnand: lpx32xx: Fix dma_request_chan() error checks

Rob Herring (Arm) (1):
      dt-bindings: mtd: qcom,nandc: Define properties at top-level

Sascha Hauer (3):
      mtd: rawnand: mxc: separate page read from ecc calc
      mtd: rawnand: mxc: implement exec_op
      mtd: rawnand: mxc: support software ECC

Wolfram Sang (2):
      mtd: rawnand: mxc: use 'time_left' variable with wait_for_completion_=
timeout()
      mtd: rawnand: intel: use 'time_left' variable with wait_for_completio=
n_timeout()

 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml |  18 +++
 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml          |  22 +++
 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml         |  38 ++---
 drivers/mtd/chips/cfi_cmdset_0020.c                           |   1 +
 drivers/mtd/chips/cfi_util.c                                  |   1 +
 drivers/mtd/maps/Makefile                                     |  11 +-
 drivers/mtd/maps/map_funcs.c                                  |   1 +
 drivers/mtd/nand/raw/cadence-nand-controller.c                |   5 -
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                    |  20 ++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h                    |   6 +-
 drivers/mtd/nand/raw/intel-nand-controller.c                  |   6 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                            |  26 ++--
 drivers/mtd/nand/raw/lpc32xx_slc.c                            |  26 ++--
 drivers/mtd/nand/raw/meson_nand.c                             |  86 ++++++=
+----
 drivers/mtd/nand/raw/mxc_nand.c                               | 708 ++++++=
+++++++++++++++++++++++++++++++++++++--------------------------------------=
-------
 drivers/mtd/nand/spi/macronix.c                               |  64 ++++++=
--
 drivers/mtd/parsers/brcm_u-boot.c                             |   1 +
 drivers/mtd/parsers/cmdlinepart.c                             |  18 +--
 drivers/mtd/parsers/tplink_safeloader.c                       |   1 +
 drivers/mtd/spi-nor/Makefile                                  |   1 -
 drivers/mtd/spi-nor/core.c                                    | 206 ++++++=
++++----------------
 drivers/mtd/spi-nor/core.h                                    |  12 --
 drivers/mtd/spi-nor/everspin.c                                |  19 ++-
 drivers/mtd/spi-nor/winbond.c                                 |   2 +
 drivers/mtd/spi-nor/xilinx.c                                  | 169 ------=
---------------
 drivers/mtd/tests/Makefile                                    |  34 ++---
 drivers/mtd/tests/mtd_test.c                                  |   9 ++
 include/linux/mtd/cfi.h                                       |  32 ++--
 28 files changed, 724 insertions(+), 819 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/xilinx.c

