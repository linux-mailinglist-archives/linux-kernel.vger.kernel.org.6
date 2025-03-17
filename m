Return-Path: <linux-kernel+bounces-564848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD211A65BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3514206DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959721E51FB;
	Mon, 17 Mar 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hjjc1uJg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zFGUb18k"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55501E1DE6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234303; cv=none; b=CIX3ggMw6vLgNXeM3VUyxAcwCXmxQHaf6you7MnhLosEFkJCw6Z2nMlAIXkC0XDQy1azc1kg/b7AZjFEu09CIFeTWSstHzre1OF7HYWBl8EdjyYfOC2QF0pUI9v9iZ/+6zyREHKfzt/He9uFAkpr/hwldqPpce3CVkl34THfZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234303; c=relaxed/simple;
	bh=h84uNUyXFRLMGFkRxHlWBveRiKgBb5DxOOWBRiArUUM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=bhDCZBy84mC5pi7jE3kmVG2bzJJExWa031L+du1gN/cUEsstPWjI6a7w65Vs/smZ8D4zcw+b/DAFpBwEkE0x2HbQYxuNR9D7wOIavV5gUYKcDhJ0FA8BuZR2ZHeLb0Ed4iJmrs5n3BPd+q1STK3CpSu03NILyuzvSCt42XiSCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hjjc1uJg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zFGUb18k; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3ED82540237;
	Mon, 17 Mar 2025 13:58:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 17 Mar 2025 13:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1742234298; x=1742320698; bh=Mz
	xT2e/1eJk/FLQ+z6SIGo3gYKC2SmKVBiMJMl5+j/U=; b=hjjc1uJg4PhsiEgWQo
	OMxm2CMBEPIrx/7vOWkwvPEKqHphiLNsP3CnkWd47JEOY7ho+E7ExZOhZLu5lmbf
	eUOXNYD/eck3CGcXxYwL11jXZMhRhKJ5TFqH+PFB7z5hhJYluq35YjEr2OwJbLdN
	DwzWZvmuHHwYCJN1gbpPv2AE2Oyahus4g7wgwktg6M79KNPze8r93gPgsP639ZGV
	nMdsoUTLESP3RzqFI4tnPROJ/q46SXG5AGESIrmwBRQznx2YpEXAi/VV8ktM630v
	a50yPkNGZ2COsQP6f6Rt5VFSQCVemvQG//FF8MLdRWXduwQ8Yy/Cnk37sCDhVUlu
	mCQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1742234298; x=1742320698; bh=MzxT2e/1eJk/FLQ+z6SIGo3gYKC2
	SmKVBiMJMl5+j/U=; b=zFGUb18klaAUN6qg1l1KJEqdHuyRxcYzBrf0N1mDdwM9
	17ng2JJU3x1fyE4nXuVaWYEh/iLMNDVSjRxivLX8RfI/F6zVhjZm6k7OJQkiX8lg
	KZVuGksu3bOC4o4y70AzyyEmz9snpOLVVrrv9tPpuqzk+2myrJ74GmOpdEfKJZ1b
	MhAbZao9561K8tYffhmR4YnFUJZdOPVy500620tDLVhPiCz/cOAXS1t+oV3HWdJr
	P2R4nMhdzl9gyKi7kGLiUk97F5BctQ4jVb8HHkd9fiMVx2AYA8LRm+3iWFEQhBfE
	wvfQ75IY87SqohpWMuHT8XrDldExc9wpeybdT69P4Q==
X-ME-Sender: <xms:umLYZ_KK0XxyakjqPhEU3Xf0QIZlkwtxDYJSdSwR5z1a7WjlyEjsbw>
    <xme:umLYZzKxG6NTm7ySlKS_0j40uFUUsBQlQyjEmhvQ4piG3syxXtNW2ylbX_ZL46JtJ
    EK2V5g-89uoYOY4z5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepteetgfejvdfgtdeiteelvedvieduieekteeludet
    gfdtuedtuddvtefgvdduuedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhith
    hhuhgsrdgtohhmpdhpvghnghhuthhrohhnihigrdguvgenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhrvhgr
    lhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:umLYZ3u2dQHKYAb_Ye6xaZ7SZAutcFRFp71Ae_2oe6djLi1aNpzDtw>
    <xmx:umLYZ4agWIkeWprDC-sIYQNgyIfU0YN0mhgf9-IQ9UebcYIii2OSPw>
    <xmx:umLYZ2aBwIbjvwwKdGbbRKgxUGFL3EpHbnn2B-nWu9n9v3BZzeIp9Q>
    <xmx:umLYZ8BYJ5PKZ9qb-kDvY2an5H50MC4_MQd2LndvjddwkRFxybT6jw>
    <xmx:umLYZ2EWmmHjfDiOT7jzCg1f0DWTq8c1OHxnwe699l35U5C9klh-mWPZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3761A2220072; Mon, 17 Mar 2025 13:58:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Mar 2025 18:57:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev
Message-Id: <860b2eaa-1aea-45e0-8bf5-3645b3840966@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.14, part 2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 7eb172143d5508b4da468ed59ee857c6e5e01da6:

  Linux 6.14-rc5 (2025-03-02 11:48:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.14-2

for you to fetch changes up to 45d5fe1c53baaed1fb3043f45d1e15ebb4bbe86a:

  ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX (2025-03-14 18:24:05 +0100)

----------------------------------------------------------------
soc: fixes for 6.14, part 2

The majority of the last fixes are for devicetree files. This address two
important regressions for the Qualcomm SMMU and the Raspberry Pi 4 USB
controller, as well as a larger number of patches fixing minor mistakes
in board specific files for Rockchips, i.MX, starfive and broadcom.

The non-DT changes are

 - A fix for an old boot regression on Renesas shmobile chips

 - Another boot time regression for for the Qualcomm PDR SoC driver,
   among a few other Qualcomm firmware driver fixes for efivars
   and tzmem.

 - Minor Kconfig fixes for davinci and OMAP1

 - Minor code fixes for sparx5 reset controllers, OMAP memory controller,
   i.MX SCU, cpufreq and SoC drivers and a Hisilicon SoC driver.

 - One more update to the Asahi maintainers, adding Neal Gompa as a
   reviewer

----------------------------------------------------------------
Alexander Stein (1):
      arm64: dts: freescale: tqma8mpql: Fix vqmmc-supply

Arnd Bergmann (12):
      Merge tag 'arm-soc/for-6.14/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'arm-soc/for-6.14/devicetree-arm64-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'imx-fixes-6.14' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'riscv-dt-fixes-for-v6.14-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      ARM: OMAP1: select CONFIG_GENERIC_IRQ_CHIP
      Merge tag 'arm-soc/for-6.14/devicetree-fixes-part2' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'v6.14-rockchip-dtsfixes2' of https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'asahi-soc-maintainers-6.14-fixes' of https://github.com/AsahiLinux/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.14' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-drivers-fixes-for-6.14' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'renesas-fixes-for-v6.14-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes
      Merge tag 'reset-fixes-for-v6.14' of git://git.pengutronix.de/pza/linux into arm/fixes

Chester A. Unal (2):
      ARM: dts: BCM5301X: Fix switch port labels of ASUS RT-AC5300
      ARM: dts: BCM5301X: Fix switch port labels of ASUS RT-AC3200

Dan Carpenter (1):
      firmware: qcom: scm: Fix error code in probe()

David Lechner (1):
      ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX

Dragan Simic (2):
      arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi
      arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board dtsi

E Shattow (1):
      riscv: dts: starfive: Fix a typo in StarFive JH7110 pin function definitions

Geert Uytterhoeven (1):
      ARM: shmobile: smp: Enforce shmobile_smp_* alignment

Hector Martin (1):
      MAINTAINERS: Add apple-spi driver & binding files

Heiko Stuebner (2):
      arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
      arm64: dts: rockchip: remove supports-cqe from rk3588 tiger

Horatiu Vultur (1):
      reset: mchp: sparx5: Fix for lan966x

Huisong Li (1):
      soc: hisilicon: kunpeng_hccs: Fix incorrect string assembly

Jianfeng Liu (1):
      arm64: dts: rockchip: slow down emmc freq for rock 5 itx

Joe Hattori (1):
      firmware: imx-scu: fix OF node leak in .probe()

Johan Hovold (1):
      firmware: qcom: uefisecapp: fix efivars registration race

Justin Klaassen (1):
      arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S

Konrad Dybcio (1):
      Revert "arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu"

Krzysztof Kozlowski (1):
      soc: qcom: pmic_glink: Drop redundant pg assignment before taking lock

Neal Gompa (1):
      MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple support

Peng Fan (1):
      soc: imx8m: Unregister cpufreq and soc dev in cleanup path

Phil Elwell (3):
      ARM: dts: bcm2711: PL011 UARTs are actually r1p5
      arm64: dts: bcm2712: PL011 UARTs are actually r1p5
      ARM: dts: bcm2711: Don't mark timer regs unconfigured

Quentin Schulz (2):
      arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou
      arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck on Haikou

Roger Quadros (1):
      memory: omap-gpmc: drop no compatible check

Saranya R (1):
      soc: qcom: pdr: Fix the potential deadlock

Stefan Eichenberger (3):
      ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
      arm64: dts: freescale: imx8mp-verdin-dahlia: add Microphone Jack to sound card
      arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack to sound card

Stefan Wahren (1):
      ARM: dts: bcm2711: Fix xHCI power-domain

Yao Zi (1):
      arm64: dts: rockchip: Remove undocumented sdmmc property from lubancat-1

 MAINTAINERS                                        |  3 +++
 arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi        |  5 -----
 arch/arm/boot/dts/broadcom/bcm2711.dtsi            | 12 +++++-----
 .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   |  8 +++----
 .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  |  8 +++----
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi      | 10 ++++-----
 arch/arm/mach-davinci/Kconfig                      |  1 +
 arch/arm/mach-omap1/Kconfig                        |  1 +
 arch/arm/mach-shmobile/headsmp.S                   |  1 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi          |  2 +-
 .../boot/dts/freescale/imx8mm-verdin-dahlia.dtsi   |  6 ++---
 .../arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi | 16 ++++---------
 .../boot/dts/freescale/imx8mp-verdin-dahlia.dtsi   |  6 ++---
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  1 -
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     | 12 ++++++++++
 .../arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 14 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     |  1 -
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts |  3 +--
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |  1 -
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h      |  2 +-
 drivers/firmware/imx/imx-scu.c                     |  1 +
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c    | 18 +++++++--------
 drivers/firmware/qcom/qcom_scm.c                   |  4 ++--
 drivers/memory/omap-gpmc.c                         | 20 -----------------
 drivers/reset/reset-microchip-sparx5.c             | 19 +++++++++++-----
 drivers/soc/hisilicon/kunpeng_hccs.c               |  4 ++--
 drivers/soc/imx/soc-imx8m.c                        | 26 ++++++++++++++++++++--
 drivers/soc/qcom/pdr_interface.c                   |  8 +------
 drivers/soc/qcom/pmic_glink.c                      |  2 +-
 31 files changed, 119 insertions(+), 99 deletions(-)

