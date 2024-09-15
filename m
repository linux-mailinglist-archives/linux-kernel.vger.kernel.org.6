Return-Path: <linux-kernel+bounces-329819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA2979664
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3182822B3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821C1C3F04;
	Sun, 15 Sep 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B1pnSQvQ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89087184E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726397638; cv=none; b=n2whJGdyz10Do/mU1l2rdnYNXy5ViZYVp/1tLN7ks4T00P/jPUqGh7dgm6nsrC9ZoU42eu4gJL/Lvax4O/S5npMXh+dHAryP1cAOsC6S8h6QBfww/V7wPWMSZDEF8VLdDGAtdTrcx9Iyr0FDLwS14sneK7b+zDqXtz87gxRNd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726397638; c=relaxed/simple;
	bh=X0K/JGGFiLk2GX0wtlZ2Adl7BZrgq3vTbLJ1el+GIz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iwc+vGUaMXhASosEXGGmOm08jRN2HhqIi7r7yN9rnEM65Xv3yHG7k0YerIDo8rL97diEmCK8jV9ymaAh+q8BQn0NBZZQQHfUFjnre4bq0OZXW59bpvlXNPcthSYqiLZi4iaOZesa+Er7sGEyYDKLA2/RLMmnXb8ql9mn+hR1o+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B1pnSQvQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E641C0002;
	Sun, 15 Sep 2024 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726397628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Kqw1C0q7Av2ujK9VWUkigU4yK9rhKQmLHREq3gViJY=;
	b=B1pnSQvQrQLQQCtND4+Jcx92VNUWWrfVCf3sUMgKV039WpKs7ajeWsfulJ7FBA7o1/uvxm
	vP/3U0lnGJrzUyCw1BRD8+/8VHOgZAn5VsI8LXLsAPaeNqACZw6S2FTyb+QC03brUbDL5L
	RNkeHxiNZpKVz5X4OIUJ7ArlgV7GNwoZKo5faalpA3OwZGa6T9OO3MBlIvgyEvlg6CG3gc
	ZRWBC7NWmkQhDpRmr2/vDrdARdGj5qXAzpSZf/mDBYAvsHTgE9d5kD6urbH76TbgJrufOB
	5wEn7lgoJS1XZnYQtEIKEn6xDWlxWquyskYF9jA9gn4Wv3vWCfM9fxH2NR2O5g==
Date: Sun, 15 Sep 2024 12:53:44 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 6.12-rc1
Message-ID: <20240915125344.5a449216@xps-13>
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

This is the MTD PR for v6.12-rc1.

Thanks,
Miqu=C3=A8l

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-=
6.12

for you to fetch changes up to 869acb874f2b61c34063b677c2bd29595bf446a1:

  Merge tag 'nand/for-6.12' into mtd/next (2024-09-15 12:38:22 +0200)

----------------------------------------------------------------
* MTD changes

No particularly important patchset this cycle, but we have a few usual
improvements: like using a better/more recent helper or checking a
return value.

* Raw NAND changes

The use of for_each_child_of_node_scoped() has been spread into the
subsystem drivers. Aside from that, a couple of exit path have been
fixed (mtk, denali), the TI GPMC bindings have been enhanced to comply
with up-to-date partition descriptions and as always there is a load of
small and misc fixes.

* SPI-NAND changes

The most impacting series this cycle is bringing support for continuous
reads in the SPI-NAND subsystem. This is a feature already merged in the
raw NAND subsystem which allows optimizing the internal fetch times in
the chip while reading sequential pages within an eraseblock. For now
only Macronix NANDs benefit from this feature. While we are talking
about Macronix, some of their chip need an explicit action for selecting
a different plane, and support for it has also been brought.

The bitflip threshold has also been set to the same arbitrary level as
in the raw NAND subsystem to optimize wear leveling decisions, and
finally support for a new Winbond chip has been added.

* SPI NOR changes

Notable changes:
- Add Write Protect support for N25Q064A.
- New flash support for Zetta ZD25Q128C and Spansion S28HS256T.
- Fix a NULL dereference in probe path for flashes without a name. The
  probe path tries to access the name without checking its existence
  first. S28HS256T is the first flash to define its entry without a
  name, uncovering this issue.

----------------------------------------------------------------
Alexander Dahl (1):
      mtd: rawnand: atmel: Add message on DMA usage

Bartosz Golaszewski (1):
      mtd: rawnand: davinci: make platform_data private

Brian Norris (1):
      mtd: spi-nor: micron-st: Add n25q064a WP support

Charles Han (1):
      mtd: powernv: Add check devm_kasprintf() returned value

Chen Ridong (1):
      mtd: rawnand: denali: Fix missing pci_release_regions in probe and re=
move

Cheng Ming Lin (2):
      mtd: spinand: Add support for setting plane select bits
      mtd: spinand: macronix: Flag parts needing explicit plane select

Colin Ian King (1):
      mtd: parsers: bcm47xxpart: make read-only array possible_nvram_sizes =
static const

Cs=C3=B3k=C3=A1s, Bence (1):
      mtd: spi-nor: sst: Factor out common write operation to `sst_nor_writ=
e_data()`

Daniel Golle (1):
      mtd: spinand: set bitflip_threshold to 75% of ECC strength

Jinjie Ruan (11):
      mtd: rawnand: denali: Use the devm_clk_get_enabled() helper function
      mtd: rawnand: arasan: Use for_each_child_of_node_scoped()
      mtd: rawnand: cadence: Use for_each_child_of_node_scoped()
      mtd: rawnand: pl353: Use for_each_child_of_node_scoped()
      mtd: rawnand: marvell: drm/rockchip: Use for_each_child_of_node_scope=
d()
      mtd: rawnand: rockchip: Use for_each_child_of_node_scoped()
      mtd: rawnand: meson: Use for_each_child_of_node_scoped()
      mtd: rawnand: mtk: Use for_each_child_of_node_scoped()
      mtd: rawnand: renesas: Use for_each_child_of_node_scoped()
      mtd: rawnand: stm32_fmc2: Use for_each_child_of_node_scoped()
      mtd: rawnand: sunxi: Use for_each_child_of_node_scoped()

Michael Walle (2):
      mtd: spi-nor: winbond: add Zetta ZD25Q128C support
      mtd: spi-nor: fix flash probing

Miquel Raynal (14):
      mtd: nand: Rename the NAND IO iteration helper
      mtd: nand: Introduce a block iterator
      mtd: spi-nand: Isolate the MTD read logic in a helper
      mtd: spi-nand: Add continuous read support
      mtd: spi-nand: Expose spinand_write_reg_op()
      mtd: spi-nand: macronix: Fix helper name
      mtd: spi-nand: macronix: Extract the bitflip retrieval logic
      mtd: spi-nand: macronix: Add a possible bitflip status flag
      mtd: spi-nand: macronix: Continuous read support
      mtd: rawnand: meson: Fix typo in function name
      mtd: rawnand: mtk: Factorize out the logic cleaning mtk chips
      mtd: rawnand: mtk: Fix init error path
      Merge tag 'spi-nor/for-6.12' into mtd/next
      Merge tag 'nand/for-6.12' into mtd/next

Mirsad Todorovac (1):
      mtd: slram: insert break after errors in parsing the map

Rob Herring (Arm) (1):
      mtd: Use of_property_read_bool()

Robert Marko (1):
      mtd: spinand: winbond: add support for W25N01KV

Roger Quadros (1):
      dt-bindings: mtd: ti, gpmc-nand: support partitions node

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Add support for S28HS256T

Yan Zhen (1):
      mtd: concat: Use kmemdup_array instead of kmemdup for multiple alloca=
tion

 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml |   5 +-
 drivers/mtd/devices/powernv_flash.c                     |   3 +
 drivers/mtd/devices/slram.c                             |   2 +
 drivers/mtd/mtdconcat.c                                 |   2 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c           |   5 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c            |   5 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c          |   4 +-
 drivers/mtd/nand/raw/davinci_nand.c                     |  70 ++++++++++-
 drivers/mtd/nand/raw/denali_dt.c                        |  29 +----
 drivers/mtd/nand/raw/denali_pci.c                       |  11 +-
 drivers/mtd/nand/raw/marvell_nand.c                     |  12 +-
 drivers/mtd/nand/raw/meson_nand.c                       |  10 +-
 drivers/mtd/nand/raw/mtk_nand.c                         |  36 +++---
 drivers/mtd/nand/raw/pl35x-nand-controller.c            |   5 +-
 drivers/mtd/nand/raw/renesas-nand-controller.c          |  12 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c         |   5 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                  |   7 +-
 drivers/mtd/nand/raw/sunxi_nand.c                       |   4 +-
 drivers/mtd/nand/spi/core.c                             | 223 ++++++++++++=
++++++++++++++++++++----
 drivers/mtd/nand/spi/macronix.c                         | 146 ++++++++++++=
+++++------
 drivers/mtd/nand/spi/winbond.c                          |  26 +++++
 drivers/mtd/parsers/bcm47xxpart.c                       |   2 +-
 drivers/mtd/parsers/ofpart_core.c                       |   4 +-
 drivers/mtd/spi-nor/core.c                              |   3 +-
 drivers/mtd/spi-nor/micron-st.c                         |   2 +
 drivers/mtd/spi-nor/spansion.c                          |   4 +
 drivers/mtd/spi-nor/sst.c                               |  39 +++----
 drivers/mtd/spi-nor/winbond.c                           |  26 +++++
 include/linux/mtd/nand.h                                |  90 ++++++++++++=
+--
 include/linux/mtd/spinand.h                             |  19 +++
 include/linux/platform_data/mtd-davinci-aemif.h         |  36 ------
 include/linux/platform_data/mtd-davinci.h               |  88 ------------=
--
 32 files changed, 621 insertions(+), 314 deletions(-)
 delete mode 100644 include/linux/platform_data/mtd-davinci-aemif.h
 delete mode 100644 include/linux/platform_data/mtd-davinci.h

