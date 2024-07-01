Return-Path: <linux-kernel+bounces-236603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F88F91E4B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA02283429
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A629CE5;
	Mon,  1 Jul 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Rqn0PzPH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2XMR0WI"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F9EEB5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849624; cv=none; b=vFuQouD/houtM4fdry1ORKbqY7KgdhK4pcHX45TjWyp8N1iXj12aYrJex03qOqSqYu/CTWg1T6/uo7Li6eAKny3qrnL077sidx7oinmt8etgCSB18tI2hJHkY8m3nFl0p8LbSIs8BAWdCQIRl0XYFfop9S2Vs8nRwoXSJzYWnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849624; c=relaxed/simple;
	bh=dYRSqFGLnDej4U5jaDcFGh7vpYSSZ3/3IKuLxhf0Rsw=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=P9i3HBhq5wWpgzL7ilXcCqRrAmFvGV4bxquDAUrMkvr52cZEJiKjdKpFzPkdBPK8aER9nd+ThFv8spKvtUh5fJjEtXCEHXrflh8efSsw0GgpLhwJjQgEISqROa7m6NkcciVmmH0BJC/0DtOnXneiyEiOH6/F/5Tl+KG26C0mOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Rqn0PzPH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2XMR0WI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4A53911401F0;
	Mon,  1 Jul 2024 12:00:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 01 Jul 2024 12:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1719849621; x=1719936021; bh=h6fE83anxF02AGO1T4u96HnJH1nch6MP
	lPNBjCqR5BY=; b=Rqn0PzPHLbWdIcHG68T4+WYdjrjXMjt2/cC/qASPTiTZ8ak4
	+uxZmI/LqRV+mRq/LG0nZbh6PlNnyix2PKIr2x/yiaM6GJzY3D65Bx5J05o4QnRF
	kpIkODzBT1Pu3si5ZH9FuhUox4H+QXuDVm6MD9gbtLAm+ljSCRfa+l/J2IiXKIGr
	TMnU8OHG607gd3IrkdBYdLYYCyWb3XRejMPRocY6nSnVlpLBnWS/xpGy8uTDfATi
	fxXgFIzEorTozCjxaycD6xWCq0TzrsZ4vzK+v8Ub6dPT9QNpuOTErNbQRm+io3AJ
	dX2bzVYDiesjLwRTOdSK/w1+a50t4nl+LtW9pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1719849621; x=1719936021; bh=h6fE83anxF02AGO1T4u96HnJH1nch6MPlPN
	BjCqR5BY=; b=I2XMR0WIcQFXh0xVWT05xUwW6J2aGuj358GPfs5eZYdRb1dMIcH
	YM8bBW/MpCXHaUg809Dq3FRp8mCt9m3Jts0HdeipUYP/jx9bZL64NoRWJk9y6P4Q
	jdg/aGuTHqzheVn8c0E7mC+zmAbfsFV75nJ61EpSTiKms+dsfBd7jpbRmRUACCwI
	/8gxuUditynggPghIA5h4F+8haeKaEI7C8kHdgJYXUp9j5V//pq12x4WnhbY5Bbm
	QGDcl5Os1fY+ActJ7Mv+JV0scs6X+dYalYn8ZUQ3OMzCnrwQNVYai8HiRhmACsit
	ea/Sih+xy3XIqMQJoP+dDuHGI9b4bnyPmMA==
X-ME-Sender: <xms:lNKCZhIgGbQWpvE6peL2jZaVGKtgbQ8cLAKEVGAJH432DRnfuybmnQ>
    <xme:lNKCZtLvELZ-qtpqBbXdg-KR-FhgxhMrdfOR7VdpUckbV0dUwLPXitFt7_7JddwUi
    lpCTYKKjnThGFbaX9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeejfeefheegudffudfgjeffteduvdekteejgefhiedtfedugeehfedtuedulefgffen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhpvghnghhuthhrohhnihigrdguvgdplh
    hinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lNKCZpsgpeVTLHZfzOvX377t7hfAl3Dbxo-0nQhWFAH9uwJBEzsXkg>
    <xmx:lNKCZiaQYeDbeCWWln_gHpYivBsj-IvF6_wyPgh7NXRX1UVdhd4y-Q>
    <xmx:lNKCZoZIWEQAf25ipwT87Tl3xb8P1Dl_SY6vDjA7SkkBOjCsO77sJg>
    <xmx:lNKCZmDhLfumKNTNOGGd1F9qIbsW4NpbL_iElJX6WvHU_5Wkd9d3LA>
    <xmx:ldKCZvWcAwFKtXzTAVdC-ZywA05Mlby4QwntkmWaX-gx_ZV4KBrbEJ39>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CE622B6008F; Mon,  1 Jul 2024 12:00:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3040c98f-940b-4380-9a90-dfcae18a47b6@app.fastmail.com>
Date: Mon, 01 Jul 2024 18:00:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] SoC fixes for 6.10, part 2
Content-Type: text/plain

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.10-2

for you to fetch changes up to 07917ee08723e6c46074a2655a380126acee3898:

  Merge tag 'v6.10-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes (2024-07-01 14:33:27 +0200)

----------------------------------------------------------------
SoC fixes for 6.10, part 2

A number of devicetree fixes came in for the rockchip platforms, correcting
some of the address information, and reverting a change to the MMC controller
configuration that caused regressions.

Four drivers have one code change each, addressing minor build issues for
the optee firmware driver, the litex SoC platform driver and two reset
drivers.

The riscv fixes as also simple, mainly turning off device nodes in the
canaan dts files unless they are actually usable on a particular board.

Finally, Drew takes over maintaining the THEAD RISC-V SoC platform.

----------------------------------------------------------------
Alex Bee (1):
      arm64: dts: rockchip: Add sound-dai-cells for RK3368

Andy Yan (1):
      arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B

Arnd Bergmann (4):
      Merge tag 'riscv-dt-fixes-for-v6.10-rc5+' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'reset-fixes-for-v6.10' of git://git.pengutronix.de/pza/linux into arm/fixes
      Merge tag 'optee-fix-for-v6.11' of https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'v6.10-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes

Dragan Simic (1):
      arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on Quartz64 Model B

FUKAUMI Naoki (3):
      Revert "arm64: dts: rockchip: remove redundant cd-gpios from rk3588 sdmmc nodes"
      arm64: dts: rockchip: make poweroff(8) work on Radxa ROCK 5A
      arm64: dts: rockchip: fix PMIC interrupt pin on ROCK Pi E

Geert Uytterhoeven (2):
      riscv: dts: canaan: Clean up serial aliases
      riscv: dts: canaan: Disable I/O devices unless used

Heiko Stuebner (1):
      arm64: dts: rockchip: set correct pwm0 pinctrl on rk3588-tiger

Hsin-Te Yuan (1):
      arm64: dts: rockchip: Fix the value of `dlg,jack-det-rate` mismatch on rk3399-gru

Jean Delvare (1):
      drivers/soc/litex: drop obsolete dependency on COMPILE_TEST

Jeff Johnson (1):
      reset: hisilicon: hi6220: add missing MODULE_DESCRIPTION() macro

Jisheng Zhang (1):
      MAINTAINERS: thead: update Maintainer

Johan Jonker (1):
      ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node

Jonas Karlman (3):
      arm64: dts: rockchip: Fix rk3308 codec@ff560000 reset-names
      arm64: dts: rockchip: Fix SD NAND and eMMC init on rk3308-rock-pi-s
      arm64: dts: rockchip: Rename LED related pinctrl nodes on rk3308-rock-pi-s

Mark Brown (1):
      reset: gpio: Fix missing gpiolib dependency for GPIO reset controller

Mark-PK Tsai (1):
      tee: optee: ffa: Fix missing-field-initializers warning

Shengyu Qu (1):
      riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on JH7110 boards

 MAINTAINERS                                        |  2 +-
 arch/arm/boot/dts/rockchip/rk3066a.dtsi            |  1 +
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts  | 18 ++++++++++++-----
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  2 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts  |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  3 +++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  2 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts |  2 +-
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   |  1 +
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |  5 +++++
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |  2 ++
 arch/riscv/boot/dts/canaan/canaan_kd233.dts        |  7 ++++++-
 arch/riscv/boot/dts/canaan/k210.dtsi               | 23 +++++++++++++++-------
 arch/riscv/boot/dts/canaan/k210_generic.dts        |  5 ++++-
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts     |  9 ++++++++-
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts    |  7 ++++++-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts      |  9 ++++++++-
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts    | 10 ++++++++--
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |  2 +-
 drivers/reset/Kconfig                              |  1 +
 drivers/reset/hisilicon/hi6220_reset.c             |  1 +
 drivers/soc/litex/Kconfig                          |  2 +-
 drivers/soc/litex/litex_soc_ctrl.c                 |  4 +---
 drivers/tee/optee/ffa_abi.c                        | 12 ++++++++---
 27 files changed, 105 insertions(+), 35 deletions(-)

