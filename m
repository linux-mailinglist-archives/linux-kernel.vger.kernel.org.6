Return-Path: <linux-kernel+bounces-340746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62E987756
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B832B22F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789315886D;
	Thu, 26 Sep 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Bt+rZ7yw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PK9eMoqD"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172813B5B4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367035; cv=none; b=ISvdgbZniC5mRp2BopNGrgMcnmN55UtmnhxfG/0bWDW7OQWCK/CeqcXJKyOdcsltua9x35IFFRZ2npgjDACSDJjxQTL6XPoPUXy2Nc6S7+hEwpN3iMeP0QPZrlptUAjLEuRA3S9sF+XtLYzMA6EKNIAyAdc417aAx6DnpU1/sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367035; c=relaxed/simple;
	bh=PuLMPjF+kQb9j9PHLY/qTIbTgDYwv8IGF9Q4WjGEuoM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=EmO1sO0/+OV0jFOhoBpinTnpPPsALBU5qagri09DSsSafXjIms0UyJuAG6FW/pg1vE2rqxMGtU9mBzbAdwsKY+CfIsZFLtiHwyfDDiJAPNPDjdQctZKVGBTlc2Ghzx353gTxC4e3pN2Ucw6PNYkb2B02+8+Bxn5gjbLMctdBcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Bt+rZ7yw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PK9eMoqD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB7BB1140241;
	Thu, 26 Sep 2024 12:10:31 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 12:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1727367031; x=1727453431; bh=Jc
	06wMqbMsMMM6Dedeo8uuj0dOH8ar9SCNKrEWOiBQk=; b=Bt+rZ7yw84q2CcM/zp
	PIHze68AA+Ocma2mxYkJUJ/WZtGwA9+fq/J4YGpGXYxNuiwtNLkb3WHe7mXvBdnT
	DmeXtgKo8lEmHBVHZNalCqj1mLfHMZ0GVLMEjjeV7pY5att1+MjthTIURbhPftS3
	8SQpYbPohv0+D391XkP/WzOO/ICzmfdxYI8yqP1kdXgS8B//VJxCYnEAt/NWSp/K
	m1087u668C39/1kinBtytwG0ZzM9pZvrQ4qt+6DsdR4vcWBB7JMyXBmxg4u1MXn7
	WgcwLNx2CAfMldH43Cl19jgnhmm3XS/v7Ep72wcWVbB3bFAfoloYVe3gMwdSfgbD
	gOlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727367031; x=1727453431; bh=Jc06wMqbMsMMM
	6Dedeo8uuj0dOH8ar9SCNKrEWOiBQk=; b=PK9eMoqDnJFoHt5KwcbIK7jq4Fm1E
	re+eOz5fsr2s5tJhDAFIboDAfaI/5LTYPr3zG+auU3AeCrSlJnlD/3wSjXovQepG
	zUSR9qHoAIxpMHjGwQqPbuZi0hvMo89+MZx/nbUV/jO8ad7GqJs5sHM3K4NG6TPp
	Nxydw7yBEq8GbAHiT1KJc7YHhEbMuBhxZLmQlZ7Du4Oigc8VOwgnJpO6tIWZuEwb
	uEuPXZkmF1nUka9bidGUW1wfbOj/r8BqjYhOdj1qjxsGDu6vknFJhyPBtx+9vR3g
	W7aFkMXSFfUmzACXNshQ9/D5q7OKSnLcZ69+kEAMhwWB+kjsd9QWzyK/g==
X-ME-Sender: <xms:d4f1ZnX-bh_ltdDXFC0e_7Q6TITuRVIvhRuB155_GrEZsaaeYDDlgQ>
    <xme:d4f1ZvmRsWxqYyRegzKEPLKlNpIpg7YCqbJ-AydP-BxbbG1qrSCVEpaxhUdWJvHPq
    kW343js1iMDr-klLVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddtnecu
    hfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvg
    eqnecuggftrfgrthhtvghrnhepudelieegkeevueegtedtjedttdelgeehhfdvhfeuheet
    hfduleffuddvueelveetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesghhmrghilhdrtghomhdprhgtphht
    thhopehsohgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslh
    hinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghr
    mhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    epnhhikhhithgrrdhshhhusghinhesmhgrqhhuvghfvghlrdhmvgdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d4f1ZjY1rUe5zD0SD4rOFIxfL2BkRX2wxGG6MuNy8Lpz2lorrfLKQw>
    <xmx:d4f1ZiWYOUm4qb83O5f_K-kwLF4ovdMigwhAG6EyoQiIQrvgjKCwTA>
    <xmx:d4f1ZhnKloCE--ZoWTz5YceRZQ4AT-SrpsMNLGk9Byc9JIbLyeHTLw>
    <xmx:d4f1Zvceube8MSE53_ATTWWK5dAuazVbiw86JZKb_UfRGK0ysKG0Zg>
    <xmx:d4f1ZkugUylkPBpxOeOAkJ-Ak4SQnujs3hKxVXl_0cgKBy1hqsuwk38M>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47A6B2220072; Thu, 26 Sep 2024 12:10:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 18:10:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Message-Id: <6c10bab5-e5a5-4969-b28d-11d8a1d5d587@app.fastmail.com>
Subject: [GIT PULL] soc: convert ep93xx to devicetree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 706ae6446494b4523d33b0d96ea1fd9d50ca9be6:

  clk: fixed-rate: add devm_clk_hw_register_fixed_rate_parent_data() (2024-09-05 13:48:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-ep93xx-dt-6.12

for you to fetch changes up to e3eb39e6bab564ed430172f37be835f84e923c23:

  dt-bindings: gpio: ep9301: Add missing "#interrupt-cells" to examples (2024-09-26 14:23:42 +0000)

----------------------------------------------------------------
soc: convert ep93xx to devicetree

This concludes a long journey towards replacing the old
board files with devicetree description on the Cirrus Logic
EP93xx platform.

Nikita Shubin has been working on this for a long time,
for details see the last post on
https://lore.kernel.org/lkml/20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me/

----------------------------------------------------------------

There are a few trivial merge conflicts here since this includes
the driver changes for bisectability. There were still a few
issues reported by last week, but I expect we are mostly done
with those.

Alexander Sverdlin (4):
      ASoC: ep93xx: Drop legacy DMA support
      ARM: dts: ep93xx: Add EDB9302 DT
      ASoC: cirrus: edb93xx: Delete driver
      dmaengine: cirrus: use snprintf() to calm down gcc 13.3.0

Arnd Bergmann (3):
      Merge branch 'ep93xx/clk-dependency' into ep93xx/dt-conversion
      clk: ep93xx: add module license
      spi: ep93xx: update kerneldoc comments for ep93xx_spi

Dan Carpenter (3):
      ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()
      clk: ep93xx: Fix off by one in ep93xx_div_recalc_rate()
      dmaengine: ep93xx: Fix a NULL vs IS_ERR() check in probe()

Lukas Bulwahn (1):
      soc: ep93xx: drop reference to removed EP93XX_SOC_COMMON config

Nikita Shubin (36):
      gpio: ep93xx: split device in multiple
      ARM: ep93xx: add regmap aux_dev
      clk: ep93xx: add DT support for Cirrus EP93xx
      pinctrl: add a Cirrus ep93xx SoC pin controller
      power: reset: Add a driver for the ep93xx reset
      dt-bindings: soc: Add Cirrus EP93xx
      soc: Add SoC driver for Cirrus ep93xx
      dt-bindings: dma: Add Cirrus EP93xx
      dmaengine: cirrus: Convert to DT for Cirrus EP93xx
      dt-bindings: pwm: Add Cirrus EP93xx
      pwm: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: spi: Add Cirrus EP93xx
      spi: ep93xx: add DT support for Cirrus EP93xx
      dt-bindings: net: Add Cirrus EP93xx
      net: cirrus: add DT support for Cirrus EP93xx
      dt-bindings: mtd: Add ts7200 nand-controller
      mtd: rawnand: add support for ts72xx
      dt-bindings: ata: Add Cirrus EP93xx
      ata: pata_ep93xx: add device tree support
      dt-bindings: input: Add Cirrus EP93xx keypad
      input: keypad: ep93xx: add DT support for Cirrus EP93xx
      wdt: ts72xx: add DT support for ts72xx
      gpio: ep93xx: add DT support for gpio-ep93xx
      ASoC: dt-bindings: ep93xx: Document DMA support
      ASoC: dt-bindings: ep93xx: Document Audio Port support
      ARM: dts: add Cirrus EP93XX SoC .dtsi
      ARM: dts: ep93xx: add ts7250 board
      ARM: ep93xx: DT for the Cirrus ep93xx SoC platforms
      pwm: ep93xx: drop legacy pinctrl
      ata: pata_ep93xx: remove legacy pinctrl use
      ARM: ep93xx: delete all boardfiles
      ARM: ep93xx: soc: drop defines
      dmaengine: cirrus: remove platform code
      pinctrl: ep93xx: Fix raster pins typo
      net: cirrus: use u8 for addr to calm down sparse
      MAINTAINERS: Update EP93XX ARM ARCHITECTURE maintainer

Rob Herring (1):
      dt-bindings: gpio: ep9301: Add missing "#interrupt-cells" to examples

 .../bindings/arm/cirrus/cirrus,ep9301.yaml         |   38 +
 .../bindings/ata/cirrus,ep9312-pata.yaml           |   42 +
 .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |   84 ++
 .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        |  144 ++
 .../devicetree/bindings/gpio/gpio-ep9301.yaml      |    9 +-
 .../bindings/input/cirrus,ep9307-keypad.yaml       |   87 ++
 .../devicetree/bindings/mtd/technologic,nand.yaml  |   45 +
 .../devicetree/bindings/net/cirrus,ep9301-eth.yaml |   59 +
 .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml |   53 +
 .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  |   94 ++
 .../bindings/sound/cirrus,ep9301-i2s.yaml          |   16 +
 .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml |   70 +
 MAINTAINERS                                        |    1 +
 arch/arm/Makefile                                  |    1 -
 arch/arm/boot/dts/cirrus/Makefile                  |    4 +
 arch/arm/boot/dts/cirrus/ep93xx-bk3.dts            |  125 ++
 arch/arm/boot/dts/cirrus/ep93xx-edb9302.dts        |  181 +++
 arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts         |  145 ++
 arch/arm/boot/dts/cirrus/ep93xx.dtsi               |  444 ++++++
 arch/arm/mach-ep93xx/Kconfig                       |   20 +-
 arch/arm/mach-ep93xx/Makefile                      |   11 -
 arch/arm/mach-ep93xx/clock.c                       |  733 ----------
 arch/arm/mach-ep93xx/core.c                        | 1018 --------------
 arch/arm/mach-ep93xx/dma.c                         |  114 --
 arch/arm/mach-ep93xx/edb93xx.c                     |  368 -----
 arch/arm/mach-ep93xx/ep93xx-regs.h                 |   38 -
 arch/arm/mach-ep93xx/gpio-ep93xx.h                 |  111 --
 arch/arm/mach-ep93xx/hardware.h                    |   25 -
 arch/arm/mach-ep93xx/irqs.h                        |   76 --
 arch/arm/mach-ep93xx/platform.h                    |   42 -
 arch/arm/mach-ep93xx/soc.h                         |  212 ---
 arch/arm/mach-ep93xx/timer-ep93xx.c                |  143 --
 arch/arm/mach-ep93xx/ts72xx.c                      |  422 ------
 arch/arm/mach-ep93xx/ts72xx.h                      |   94 --
 arch/arm/mach-ep93xx/vision_ep9307.c               |  321 -----
 drivers/ata/pata_ep93xx.c                          |  107 +-
 drivers/clk/Kconfig                                |    8 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-ep93xx.c                           |  850 ++++++++++++
 drivers/dma/ep93xx_dma.c                           |  287 +++-
 drivers/gpio/gpio-ep93xx.c                         |  345 ++---
 drivers/input/keyboard/ep93xx_keypad.c             |   74 +-
 drivers/mtd/nand/raw/Kconfig                       |    6 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/technologic-nand-controller.c |  222 +++
 drivers/net/ethernet/cirrus/ep93xx_eth.c           |   65 +-
 drivers/pinctrl/Kconfig                            |    7 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-ep93xx.c                   | 1434 ++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   10 +
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/ep93xx-restart.c               |   84 ++
 drivers/pwm/pwm-ep93xx.c                           |   26 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/cirrus/Kconfig                         |   17 +
 drivers/soc/cirrus/Makefile                        |    2 +
 drivers/soc/cirrus/soc-ep93xx.c                    |  252 ++++
 drivers/spi/spi-ep93xx.c                           |   68 +-
 drivers/watchdog/ts72xx_wdt.c                      |    8 +
 include/dt-bindings/clock/cirrus,ep9301-syscon.h   |   46 +
 include/linux/clk-provider.h                       |   14 +
 include/linux/platform_data/dma-ep93xx.h           |   94 --
 include/linux/platform_data/eth-ep93xx.h           |   10 -
 include/linux/platform_data/keypad-ep93xx.h        |   32 -
 include/linux/platform_data/spi-ep93xx.h           |   15 -
 include/linux/soc/cirrus/ep93xx.h                  |   47 +-
 sound/soc/cirrus/Kconfig                           |    9 -
 sound/soc/cirrus/Makefile                          |    4 -
 sound/soc/cirrus/edb93xx.c                         |  116 --
 sound/soc/cirrus/ep93xx-i2s.c                      |   19 -
 sound/soc/cirrus/ep93xx-pcm.c                      |   19 +-
 72 files changed, 5138 insertions(+), 4555 deletions(-)

