Return-Path: <linux-kernel+bounces-184203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381158CA3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A583F1F22439
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A92139CE7;
	Mon, 20 May 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YKqFr78j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLNJeYSn"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554591847
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241803; cv=none; b=dSdeKgjwvdwsRcaDdxgOj7eSbICq3pRKdIERZueo8vZdqeKNZDTn+j70L7fVTgIqtekZceH4ub6ZTZlyJfEU2ppRaKNEVOO/UWIneIx8dOLanjgxduFFpmrkBQ1c2UMYhIi9WM0EWC4JOa3CAHONltjIkyNOPtVxpRe0qByuJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241803; c=relaxed/simple;
	bh=cQ7SSwhMeXNe8md0F8TOK8FcCHF6SuKjqwe5p+pl3WM=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=jkK6I8KzcyzwW7fsPSacQ3z6JPwyu3DGHYi33PHG3kAjIm8NyHRqjWhi06qYcAhNTTu7031II5gXy+c/nlRTGD8EAgpAPLoqPSp7UpNw4x837GGiAZJQacHiK/nt7uUMuKnlcfYutfV4AhKz+mcGNHvk44sr8T9JC1A0a1tYzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YKqFr78j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLNJeYSn; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D68721800122;
	Mon, 20 May 2024 17:49:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 20 May 2024 17:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1716241799; x=1716328199; bh=uiY0+F8tNTKaymEVhT+9GghBP7w/6w6L
	i9SG+N7ubIw=; b=YKqFr78jkfb2ESwInhsBsTbXz0E9n6mKx5zQ6wol/VtKauku
	n9Bfag7yTqdKR88M8xmGXSlPBeWG0EVj3gAtZNEDg3dx3m5+9Vv6YD+hj8VsfzmV
	Ve8/dnx+YPajAOI89GY8gZPTQNpNy/qkiqPJX1Iu1gPpyg9StRsB6y94sZfNtjHa
	I47SxywXmkEYYlrVZfYcpa1KJdaMRiY8JSc81diRP00CQ8sdjgvzj6yS5KJ3NweC
	aJ0LsOIP8KzOsRHVxxnFFuwgjU1mVORDHbcv3ol0xFpYDOvr/NT8L8M4+dmq/Rx/
	n1khPaXwGhnohdyUlj6ibSV7cSA3qCaEZsdTqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1716241799; x=1716328199; bh=uiY0+F8tNTKaymEVhT+9GghBP7w/6w6Li9S
	G+N7ubIw=; b=nLNJeYSn923oXi6TGOMYyUcdq57Xs0x6AR0TICrqOiKFMWqEtKJ
	kSPz/ebuYwgcZBE6fXlgli70FS7exBjotyZBGv0L0TPI6FKIbaTGnEIZBokjj+xM
	Ib6ZwXamTvgwTXw+KWinCviEMSADhIrfWkvVpyHNleY/00VWlXErtpUwTCGdSxnU
	C+tQ3b89q7n+4m63+pY++IombzY6EDdqoHXTvlSW68nlExXIonAZ+jW6j9yt0yxY
	fjC+mjCpm8KppQbG95alA3b2XxtMv1zNDgjRkbv7Ebs/7rwmFk/qqGelnSaaXWng
	trr88rVlRftv6hhynMdTNy4z70v5i4jxH9Q==
X-ME-Sender: <xms:h8VLZh_6mRKb07STvG-nRss5GYnCjjA6oZNqOkuN1exgPxSZ24yl0w>
    <xme:h8VLZlt10QCKmT0pm-CP24IMQVtTzmbbGtWPsPBveo1gzRHaR-5-U6p-vlrYbCsag
    rnNodmxNtj-YeymxT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:h8VLZvAR45lD2fatQP73v1Mj9SvWmSBmQbpuJP1Xgh-QyRw-EKZ4bg>
    <xmx:h8VLZlev73XbNO_7m2oRcJQZWvRAWnhutKAv7VtDuh-SlrbNnTFozA>
    <xmx:h8VLZmOWDeGN2Bjb_AgdujJljXSFNEx9ZscZSP3pCsQHpDOwvvBcEA>
    <xmx:h8VLZnmWEAYJRv1FEHDR9p7gm_uHyaocLmmBm-PxkjfgsIeIdMTEDA>
    <xmx:h8VLZiAlho6UzXXkL18pXpu26-4JWrwtUqv6Upbw9rRsEj0rdrCNdJXC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 186B0B6008D; Mon, 20 May 2024 17:49:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7b555e52-a83b-4218-9251-27dcb4e93268@app.fastmail.com>
Date: Mon, 20 May 2024 21:49:14 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 "Conor Dooley" <conor.dooley@microchip.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Joel Stanley" <joel@jms.id.au>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] soc: devicetree updates for v6.10, part 2
Content-Type: text/plain

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-late-6.10

for you to fetch changes up to 01a7f9e1a97ee48ed187b040afcda23886b9f48d:

  Merge tag 'riscv-dt-for-v6.10-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt-late (2024-05-08 22:23:00 +0200)

----------------------------------------------------------------
soc: devicetree updates for v6.10, part 2

This is a follow-up to an earlier pull request for device tree changes,
as three platform maintainers sent their contents too late to be included
in the main set, but had not caused any further problems since then:

 - The Amlogic platform now containts support for two new SoC types,
   the A4 and A5 chips for audio applications. Both come with a
   reference board, and one more dts file gets addded for the
   combination of the MNT Reform Laptop with the BPI-CM4 CPU
   module

 - The ASpeed platform adds support for six addititional server
   platforms that use ast2500 or ast2600 as their BMC, while
   another one gets removed.

 - The RISC-V platforms from Microchip, Starfive and and T-HEAD
   get additional features for existing hardware, plus the
   addition of the Milk-V Mars based on the StarFive VisionFive v2
   board.

----------------------------------------------------------------
Andrew Geissler (1):
      ARM: dts: aspeed: system1: IBM System1 BMC board

Arnd Bergmann (3):
      Merge tag 'amlogic-arm64-dt-for-v6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/dt-late
      Merge tag 'aspeed-6.10-devicetree' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc into soc/dt-late
      Merge tag 'riscv-dt-for-v6.10-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt-late

Conor Dooley (2):
      RISC-V: add Milkv Mars board devicetree
      riscv: dts: microchip: add pac1934 power-monitor to icicle

Delphine CC Chiu (2):
      ARM: dts: aspeed: yosemite4: Enable ipmb device for OCP debug card
      ARM: dts: aspeed: yosemite4: set bus13 frequency to 100k

Eddie James (2):
      ARM: dts: aspeed: FSI interrupt support
      ARM: dts: Aspeed: Bonnell: Fix NVMe LED labels

Hannah Peuckmann (2):
      riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware
      riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware

Jisheng Zhang (8):
      riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
      dt-bindings: riscv: starfive: add Milkv Mars board
      riscv: dts: starfive: visionfive 2: update sound and codec dt node name
      riscv: dts: starfive: visionfive 2: use cpus label for timebase freq
      riscv: dts: starfive: visionfive 2: add tf cd-gpios
      riscv: dts: starfive: visionfive 2: add "disable-wp" for tfcard
      riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards
      riscv: dts: starfive: add Milkv Mars board device tree

Kelly Hung (2):
      dt-bindings: arm: aspeed: add ASUS X4TF board
      ARM: dts: aspeed: x4tf: Add dts for asus x4tf project

Krzysztof Kozlowski (5):
      ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
      ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
      ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
      ARM: dts: aspeed: harma: correct Mellanox multi-host property
      ARM: dts: aspeed: drop unused ref_voltage ADC property

Neil Armstrong (4):
      dt-bindings: arm: amlogic: Document the MNT Reform 2 CM4 adapter with a BPI-CM4 Module
      arm64: meson: g12-common: add the MIPI DSI nodes
      arm64: meson: khadas-vim3l: add TS050 DSI panel overlay
      arm64: dts: amlogic: meson-g12b-bananapi-cm4: add support for MNT Reform2 with CM4 adaper

Ninad Palsule (1):
      dt-bindings: arm: aspeed: add IBM system1-bmc

Peter Yin (14):
      dt-bindings: arm: aspeed: add Meta Harma board
      ARM: dts: aspeed: Harma: Add Meta Harma (AST2600) BMC
      ARM: dts: aspeed: Harma: Revise SGPIO line name.
      ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
      ARM: dts: aspeed: Harma: Remove Vuart
      ARM: dts: aspeed: Harma: Add cpu power good line name
      ARM: dts: aspeed: Harma: Add spi-gpio
      ARM: dts: aspeed: Harma: Add PDB temperature
      ARM: dts: aspeed: Harma: Revise max31790 address
      ARM: dts: aspeed: Harma: Add NIC Fru device
      ARM: dts: aspeed: Harma: Add ltc4286 device
      ARM: dts: aspeed: Harma: Revise node name
      ARM: dts: aspeed: Harma: Add retimer device
      ARM: dts: aspeed: Harma: Modify GPIO line name

Renze Nicolai (5):
      dt-bindings: arm: aspeed: add Asrock X570D4U board
      ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
      ARM: dts: aspeed: Modify GPIO table for Asrock X570D4U BMC
      ARM: dts: aspeed: Disable unused ADC channels for Asrock X570D4U BMC
      ARM: dts: aspeed: Modify I2C bus configuration

Shengyu Qu (1):
      riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board

Tao Ren (1):
      ARM: dts: aspeed: Remove Facebook Cloudripper dts

Thomas Bonnefille (1):
      riscv: dts: thead: Fix node ordering in TH1520 device tree

Xianwei Zhao (6):
      arm64: dts: meson: fix S4 power-controller node
      dt-bindings: arm: amlogic: add A4 support
      dt-bindings: arm: amlogic: add A5 support
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for A4
      arm64: dts: add support for A4 based Amlogic BA400
      arm64: dts: add support for A5 based Amlogic AV400

Yang Chen (11):
      ARM: dts: aspeed: minerva: Revise the name of DTS
      ARM: dts: aspeed: minerva: Modify mac3 setting
      ARM: dts: aspeed: minerva: Change sgpio use
      ARM: dts: aspeed: minerva: Enable power monitor device
      ARM: dts: aspeed: minerva: Add temperature sensor
      ARM: dts: aspeed: minerva: correct the address of eeprom
      ARM: dts: aspeed: minerva: add bus labels and aliases
      ARM: dts: aspeed: minerva: add fan rpm controller
      ARM: dts: aspeed: minerva: Add led-fan-fault gpio
      ARM: dts: aspeed: minerva: add gpio line name
      ARM: dts: aspeed: minerva: add sgpio line name

Zelong Dong (1):
      arm64: dts: amlogic: Add Amlogic T7 reset controller

Zev Weiss (8):
      dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
      ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
      ARM: dts: aspeed: asrock: Use MAC address from FRU EEPROM
      ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
      ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
      dt-bindings: trivial-devices: add isil,isl69269
      dt-bindings: arm: aspeed: document ASRock E3C256D4I
      ARM: dts: aspeed: Add ASRock E3C256D4I BMC

 Documentation/devicetree/bindings/arm/amlogic.yaml |   13 +
 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    6 +
 .../devicetree/bindings/riscv/starfive.yaml        |    1 +
 .../bindings/serial/amlogic,meson-uart.yaml        |    4 +-
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 arch/arm/boot/dts/aspeed/Makefile                  |    9 +-
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts    |    1 -
 .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts     |    9 +
 .../dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts     |  322 ++++
 .../dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts     |   13 +-
 .../dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts   |  324 ++++
 .../boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  |  360 +++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  |  581 +++++++
 .../boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |    4 +-
 .../dts/aspeed/aspeed-bmc-facebook-cloudripper.dts |  544 -------
 .../dts/aspeed/aspeed-bmc-facebook-greatlakes.dts  |    4 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts  |  648 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts |  265 ----
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts     |  543 +++++++
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   |   15 +-
 .../dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts  |    2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |    8 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 1623 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |    4 +
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     |    2 +
 arch/arm64/boot/dts/amlogic/Makefile               |    7 +
 .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   |   42 +
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi |   66 +
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |   40 +
 .../boot/dts/amlogic/amlogic-a5-a113x2-av400.dts   |   42 +
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |   40 +
 arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h     |  197 +++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |    7 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   70 +
 .../meson-g12b-bananapi-cm4-mnt-reform2.dts        |  384 +++++
 .../boot/dts/amlogic/meson-khadas-vim3-ts050.dtso  |  108 ++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          |   13 +-
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts  |   32 +
 arch/riscv/boot/dts/starfive/Makefile              |    1 +
 arch/riscv/boot/dts/starfive/jh7100.dtsi           |    2 +-
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |  599 ++++++++
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts |   30 +
 .../dts/starfive/jh7110-starfive-visionfive-2.dtsi |  683 +-------
 arch/riscv/boot/dts/starfive/jh7110.dtsi           |    2 +-
 arch/riscv/boot/dts/thead/th1520.dtsi              |   54 +-
 45 files changed, 6181 insertions(+), 1545 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a5-a113x2-av400.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-khadas-vim3-ts050.dtso
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-common.dtsi
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts

