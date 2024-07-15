Return-Path: <linux-kernel+bounces-253090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19E931C54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988CF1C21A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033313AA2A;
	Mon, 15 Jul 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dMRzN1C/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmnriC8U"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D6C15B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077417; cv=none; b=WIabnNgCXj3YPrEWs4+SbFwxfk8fGGUkE2fZdo2cpjI3Try/AE08K4pKMKBbctB8JpPovjsCAx2ojwEXjl326NAZu+VnJ1EXEvm8EtB2fP4nDsl1ucFDawga2raW+EE5dCSispx7pPsSvAFNOOsW7qnKdFGhap2aAiMEa6l6oUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077417; c=relaxed/simple;
	bh=2bvp44dgyOVN0aLI1AlXyz1f0iy21KZSWsZw3F6HuG0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=kG0hs3RbsbrW4p2RWbWmjaqqBI2p09Z0m5T4KufSOkRlOqg3Q9hk7KY/CSAGCVk8QSCwYqYuriBFE+B5PqrRV9wBbBWAR5zsrmn3CGYNlmLaCDHgIHJNj0qnxoNHDK8lv7aAr7YcE+xN6idVklXcQONJbejCNrus/lf7ScAKQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dMRzN1C/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmnriC8U; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B11A51388B1F;
	Mon, 15 Jul 2024 17:03:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 17:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721077410;
	 x=1721163810; bh=5i4IRofGV/WODSgwvcWpdMWNKYoUmJ+7Vay6YRl45P8=; b=
	dMRzN1C/Mwz6ILBmmhuTyKVsac02lqz/oEm94wjvUm1KSKiOODzlo6fMWYF7XsRS
	0jF8f/aP8TgZzWhTBPSHRR6d7SvT/OssjXw0x9eg14abOcUjMoy6sVDYVmnQF+Dw
	kr2eIBcU4wlomhpDDKVfplMq8CjGtK3Ef9ClqrI350MsDV1i25xQvOTN5mZ+HpIf
	n/n+RyrIbsvZMIj7vgCVuXsP+I5MqSHMW5lSaLAGKDu/WHTNN1gg+hOxQiBFE6qE
	oir1Tn4E9f8DP8yKRoQ/U8BA0n53sFbqNQKVz0dhDvExuTZH8dvgTJVA212EQcA8
	+i3JJVIT3Z7i9Tci08KGfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721077410; x=
	1721163810; bh=5i4IRofGV/WODSgwvcWpdMWNKYoUmJ+7Vay6YRl45P8=; b=b
	mnriC8Up0YlYEyXbK+1ghA950tVK92fsC47YbqpHaCa+TicyiLQh6oSALRx3fXg1
	wme/xIH2jp+MXa9X7Ryw6etqX5Dpl/WCMuCDDCqh1Hn/SLxrCqu7AYp0klIs+zAZ
	IVFt3fAgLIi8IDho1H+K4kAFnXEE+ncFFqmDmzN9SgDnvyg7BQVJCJtxwYtFOEq0
	nFdjwmLi9q4i8HsXP4E3X44qZwjGAOwiApFhMZTBYuf+m/NFsJ1ld74kpZ2+xdHa
	4IwAEJVRpqLeZmdyDSZvhF+rB2c5BPBnhEiG9TZDAPE/fiSbIGe2ELOKwLvicdMq
	zqNW7+EmI7aBlte7J50Ww==
X-ME-Sender: <xms:oY6VZrpgeqoOm9mpj2ReylJJpHlDwO4LSKcSxLDO3wjQiKaGAewk4w>
    <xme:oY6VZlpncEiR9ntXigO99_MdrzBOb8XIW6RaC98w0QTWxHa-zGVy4YFZR1BZdzYWJ
    lKTJ9uqFQQ2sxomR7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:oY6VZoM1Dx_WjTqkbb9b_cNNFsqAq3-V5lizVBAP09zfKGaTaU9MKA>
    <xmx:oY6VZu7mNBe7xJwVryXwLlnPfHbPvgStNdclj0GIIMi3WBgfkdu2Yg>
    <xmx:oY6VZq7rq-xdpWQxt60BIdz9uriwWsI-cDOw_dqAYLbRQo-Hj-moOA>
    <xmx:oY6VZmhJQOTHkbkVqCHyT5ANxefcz0aeybLqeZb70l50KMAj5pW3Uw>
    <xmx:oo6VZgl0kXPfmIYCno7oUlnlph8cvB2uXDqJWtQ60pCV3JtKj0mH0a7l>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 716DFB6008D; Mon, 15 Jul 2024 17:03:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b55b7bb8-97b6-4d25-9592-8213ecfe7b6c@app.fastmail.com>
In-Reply-To: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
Date: Mon, 15 Jul 2024 23:10:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Subject: [GIT PULL 2/4] soc: dt updates for 6.11
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8=
454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.11

for you to fetch changes up to 48d2245586452b8279a854970ce82f43477669d3:

  Merge tag 'sunxi-dt-for-6.11-2' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/sunxi/linux into soc/dt (2024-07-10 22:23:02 +0200)

----------------------------------------------------------------
soc: dt updates for 6.11

The devicetree updates are fairly well spread out across platforms,
with Qualcomm making up about a third of the total.

There are three new SoCs in existing product families this:

 - NXP i.MX95 is a variant of i.MX93, now with six Cortex-A55 cores
   instead of just two as well as a GPU and more high-speed I/O
   devices.

 - Qualcomm QCS8550 is a variant of SM8550 for IOT devices

 - Airoha EN7581 is a 10G-PON network chip and related to
   the MT7981 Wireless router chip from its parent Mediatek.

In total there are 58 new machines, including four riscv
boards and eight for 32-bit arm.

The most exciting new addition is probably a pair of laptops
based on the Qualcomm x1e80100 (Snapdragon X1 Elite) chip,
the Asus Vivobook S15 and the Lenovo Yoga Slim7x.

Other noteworthy new additions are:

 - A total of 20 Qualcomm based machines, mostly Android devices
   from Samsung, Motorola and LG, as well as a wireless router
   and some reference designs

 - Six NXP i.MX based machines, mostly industrial boards along
   with some reference designs

 - Mediatek sees some interesting Filogic based routers
   including the "OpenWRT One", a few new Chromebooks as
   well as single-board computers.

 - Four machines from Solidrun based on Marvell cn913x,
   replacing the older Armada 8000 based counterparts

 - The four Amlogic machines are all set top boxes or reference
   designs for them

 - The nine new Rockchips machines are mostly single-board
   computers including some interesting ones based on the
   rk3588 chip like the ROCK 5 ITX board and the CM3588
   with its four NVMe slots

 - The RISC-V boards are all single-board computers based on
   Starfive JH7110, Microchip MPFS and Allwinner D1, which all
   had similar boards already

There are also a lot of updates to already supported machines,
notably for the TI K3, Rockchips, Freescale and of course
Qualcomm platforms.

--------
Note: a couple of commits for qualcomm device drivers accidentally
slipped into this branch and may show up in the merge: there is
at least one from the clk tree plus one from the soc-drivers-6.11
tag. It wasn't worth rebasing when I noticed, as the changesets
would get merged anyway

----------------------------------------------------------------
Abel Vesa (10):
      arm64: dts: qcom: x1e80100-crd: Fix USB PHYs regulators
      arm64: dts: qcom: x1e80100-qcp: Fix USB PHYs regulators
      arm64: dts: qcom: x1e80100-crd: Fix the PHY regulator for PCIe 6a
      arm64: dts: qcom: x1e80100-qcp: Fix the PHY regulator for PCIe 6a
      arm64: dts: qcom: x1e80100: Describe the PCIe 6a resources
      arm64: dts: qcom: x1e80100: Disable the SMB2360 4th instance by de=
fault
      arm64: dts: qcom: x1e80100: Add remote endpoints between PHYs and =
DPs
      arm64: dts: qcom: x1e80100-crd: Add pmic-glink node with all 3 con=
nectors
      arm64: dts: qcom: x1e80100-qcp: Add pmic-glink node with all 3 con=
nectors
      arm64: dts: qcom: x1e80100: Fix USB HS PHY 0.8V supply

Aboothahir U (1):
      arm64: dts: qcom: pm660: Add rradc, charger

Adam Ford (4):
      arm64: dts: imx8mp-beacon-kit: Enable HDMI bridge HPD
      arm64: dts: imx8mp-beacon-kit: Fix errors found from CHECK_DTBS
      arm64: dts: imx8mp: Fix pgc_mlmix location
      arm64: dts: imx8mp: Fix pgc vpu locations

Adam Honse (1):
      ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3

Adam Skladowski (4):
      arm64: dts: qcom: msm8976: Add IOMMU nodes
      arm64: dts: qcom: msm8976: Add MDSS nodes
      arm64: dts: qcom: msm8976: Add Adreno GPU
      arm64: dts: qcom: msm8976: Add WCNSS node

Akhil P Oommen (1):
      arm64: dts: qcom: x1e80100: Add gpu support

Alain Volmat (2):
      ARM: dts: stm32: add DCMIPP pinctrl on STM32MP13x SoC family
      ARM: dts: stm32: enable camera support on stm32mp135f-dk board

Alex Bee (9):
      dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
      ARM: dts: rockchip: Add D-PHY for RK3128
      ARM: dts: rockchip: Add DSI for RK3128
      ARM: dts: rockchip: Add i2s nodes for RK3128
      ARM: dts: rockchip: Add spdif node for RK3128
      ARM: dts: rockchip: Add SFC for RK3128
      dt-bindings: vendor-prefixes: Add Neardi Technology
      dt-bindings: arm: rockchip: Add Neardi LBA3368
      arm64: dts: rockchip: Add Neardi LBA3368 board

Alexander Stein (11):
      arm64: dts: mba93xxla: Add USB support
      arm64: dts: mba93xxca: Add USB support
      arm64: dts: freescale: tqma9352: Add partitions subnode to spi-nor
      arm64: dts: freescale: tqma8mqml: Add partitions subnode to spi-nor
      arm64: dts: freescale: tqma8mqnl: Add partitions subnode to spi-nor
      arm64: dts: freescale: tqma8mpql: Add partitions subnode to spi-nor
      arm64: dts: freescale: tqma8mq: Add partitions subnode to spi-nor
      arm64: dts: freescale: tqma8xx: Add partitions subnode to spi-nor
      arm64: dts: imx8mp-tqma8mpql-mba8mpxl: Remove unused ocram node
      arm64: dts: imx8mp: Add imx8mp-specific irqsteer compatible
      dt-bindings: arm: add MBa8MP-RAS314 SBC

Alexandre Messier (2):
      ARM: dts: qcom: Add initial support for HTC One (M8)
      dt-bindings: arm: qcom: add HTC One (M8)

Alexandre Torgue (2):
      ARM: dts: stm32: order stm32mp13-pinctrl nodes
      ARM: dts: stm32: omit unused pinctrl groups from stm32mp13 dtb fil=
es

Alexandru Gagniuc (1):
      arm64: dts: qcom: ipq9574: add MDIO bus

Alexandru Marc Serdeliuc (2):
      dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
      arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5

Alexey Charkov (9):
      arm64: dts: rockchip: add rfkill node for M.2 Key E Bluetooth on R=
ock 5B
      arm64: dts: rockchip: add thermal zones information on RK3588
      arm64: dts: rockchip: enable thermal management on all RK3588 boar=
ds
      arm64: dts: rockchip: add passive GPU cooling on RK3588
      arm64: dts: rockchip: enable automatic fan control on Rock 5B
      arm64: dts: rockchip: Add CPU/memory regulator coupling for 2 RK35=
88 boards
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j
      arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j

Amelie Delaunay (1):
      arm64: dts: st: add HPDMA nodes on stm32mp251

Andre Przywara (2):
      arm64: dts: allwinner: h616: add IOMMU node
      arm64: dts: allwinner: h616: add crypto engine node

Andreas Kemnade (1):
      ARM: dts: e60k02: fix aliases for mmc

Andrejs Cainikovs (1):
      arm64: dts: k3-am625-verdin: enable nau8822 pll

Andrew Davis (10):
      arm64: dts: ti: k3-am642-sk: Add power supply temperature sensors
      ARM: dts: nspire: Add unit name addresses to memory nodes
      ARM: dts: nspire: Add full compatible for watchdog node
      arm64: dts: ti: k3-am65: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j7200: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j721e: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j721s2: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j784s4: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-am62a: Add cpsw-mac-efuse node to wkup_conf
      arm64: dts: ti: k3-am62: Add cpsw-mac-efuse node to wkup_conf

Andr=C3=A9 Apitzsch (3):
      ARM: dts: qcom: msm8926-motorola-peregrine: Add accelerometer, mag=
netometer, regulator
      ARM: dts: qcom: msm8926-motorola-peregrine: Update temperature sen=
sor
      ARM: dts: qcom: msm8926-motorola-peregrine: Add framebuffer suppli=
es

Andr=C3=A9 Draszik (2):
      arm64: dts: exynos: gs101: reorder properties as per guidelines
      arm64: dts: exynos: gs101-oriole: add placeholder regulators for U=
SB phy

AngeloGioacchino Del Regno (21):
      arm: dts: mediatek: Declare drive-strength numerically
      arm64: dts: mediatek: Complete chassis-type for MT8183 Chromebooks
      arm64: dts: mediatek: Add missing chassis-type to MT8192 Chromeboo=
ks
      dt-bindings: soc: mediatek: Add support for MT8188 VPPSYS
      arm64: dts: mediatek: mt8195: Fix GPU thermal zone name for SVS
      arm64: dts: mediatek: mt8192: Fix GPU thermal zone name for SVS
      arm64: dts: mediatek: mt8183: Refactor thermal zones
      arm64: dts: medaitek: mt8395-nio-12l: Set i2c6 pins to bias-disable
      arm64: dts: mediatek: mt8395-nio-12l: Define RSEL in microamperes
      arm64: dts: mediatek: mt8395-nio-12l: Enable PHYs and USB role swi=
tch
      arm64: dts: mediatek: mt8395-nio-12l: Add power supplies for CPU/G=
PU scaling
      arm64: dts: mediatek: mt8195-cherry: Specify sound DAI links and r=
outing
      arm64: dts: mediatek: mt8186-corsola: Specify sound DAI links and =
routing
      dt-bindings: arm: mediatek: Add MT8195 HP Chromebook x360 13b-ca00=
02sa
      arm64: mediatek: mt8195-cherry: Introduce the MT8195 Dojo Chromebo=
ok
      arm64: dts: mediatek: mt8188: Add Global Command Engine mailboxes
      arm64: dts: mediatek: mt8188: Add VDOSYS0/1 support for multimedia
      arm64: dts: mediatek: mt8188: Add support for SoC power domains
      arm64: dts: mediatek: mt8188: Add support for Mali GPU on Panfrost
      arm64: dts: mediatek: Makefile: Generate symbols for DTBO support
      arm64: dts: mediatek: Declare drive-strength numerically

Anton Bambura (1):
      arm64: dts: qcom: msm8916-lg-c50: add initial dts for LG Leon LTE

Arnd Bergmann (36):
      arm64: dts: amlogic: ad402: move thermal-zones to top node
      Merge tag 'renesas-dts-for-v6.11-tag1' of git://git.kernel.org/pub=
/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'juno-updates-6.11' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/sudeep.holla/linux into soc/dt
      Merge tag 'zynqmp-soc-for-6.11' of https://github.com/Xilinx/linux=
-xlnx into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.11' of git://git.kernel.org/=
pub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'sti-dt-for-v6.11-round1' of https://git.kernel.org/pub/=
scm/linux/kernel/git/pchotard/sti into soc/dt
      Merge tag 'mtk-dts64-for-v6.11' of https://git.kernel.org/pub/scm/=
linux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'mtk-dts32-for-v6.11' of https://git.kernel.org/pub/scm/=
linux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.11-tag1' of git://git.kernel=
.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'v6.11-rockchip-dts64-1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.11-rockchip-dts32-1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'renesas-dts-for-v6.11-tag2-v2' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'microchip-dt64-6.11' of https://git.kernel.org/pub/scm/=
linux/kernel/git/at91/linux into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.11' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'tegra-for-6.11-arm64-dt' of https://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'samsung-dt64-6.11' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux into soc/dt
      Merge tag 'dt64-cleanup-6.11' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'dt-cleanup-6.11' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'imx-bindings-6.11' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.11' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.11' of https://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.11' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'qcom-arm32-for-6.11' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'stm32-dt-for-v6.11-1' of https://git.kernel.org/pub/scm=
/linux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'ti-k3-dt-for-v6.11' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/ti/linux into soc/dt
      Merge tag 'mvebu-dt-6.11-1' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'mvebu-dt64-6.11-1' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'qcom-arm64-for-6.11' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'riscv-dt-for-v6.11' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/conor/linux into soc/dt
      Merge tag 'v6.11-rockchip-dts64-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.11-rockchip-dts32-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.11-rockchip-dts64-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'riscv-sophgo-dt-for-v6.11' of https://github.com/sophgo=
/linux into soc/dt
      Merge tag 'qcom-arm32-for-6.11-2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.11-2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.11-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/sunxi/linux into soc/dt

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (1):
      arm64: dts: qcom: msm8996: add reset for display subsystem

Bartosz Golaszewski (7):
      arm64: dts: qcom: sm8550-qrd: add the Wifi node
      arm64: dts: qcom: sm8650-qrd: add the Wifi node
      arm64: dts: qcom: qrb5165-rb5: add the Wifi node
      arm64: dts: qcom: sa8775p: add a dedicated memory carveout for TZ
      dt-bindings: arm: qcom: add sa8775p-ride Rev 3
      arm64: dts: qcom: move common parts for sa8775p-ride variants into=
 a .dtsi
      arm64: dts: qcom: sa8775p-ride-r3: add new board file

Beleswar Padhi (1):
      arm64: dts: ti: k3-j721e-sk: Add support for multiple CAN instances

Beniamin Sandu (1):
      arm64: dts: socfpga: stratix10: add L2 cache info

Bhavya Kapoor (1):
      arm64: dts: ti: k3-j784s4-evm: Add support for multiple CAN instan=
ces

Bjorn Andersson (8):
      arm64: dts: qcom: sc8180x: Drop ipa-virt interconnect
      arm64: dts: qcom: sc8180x: Fix aoss_qmp node
      arm64: dts: qcom: sc8180x: Correct PCIe slave ports
      Merge branch 'arm64-fixes-for-6.10' into arm64-for-6.11
      Merge branch '20240606-topic-rb1_gpu-v4-1-4bc0c19da4af@linaro.org'=
 into arm64-for-6.11
      arm64: dts: qcom: c630: Add Embedded Controller node
      Merge branch '20240602114439.1611-1-quic_jkona@quicinc.com' into a=
rm64-for-6.11
      Merge branch '20240430064214.2030013-3-quic_varada@quicinc.com' in=
to arm64-for-6.11

Bryant Mairs (2):
      dt-bindings: arm: qcom: Document samsung,milletwifi device
      ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 8.0 Wi-Fi

Caleb Connolly (3):
      dt-bindings: arm: qcom: Add QCM6490 SHIFTphone 8
      arm64: dts: qcom: add QCM6490 SHIFTphone 8
      arm64: dts: qcom: sm6115: add resets for sdhc_1

Chen Wang (1):
      riscv: dts: add clock generator for Sophgo SG2042 SoC

Chen-Yu Tsai (8):
      Merge branch 'sunxi/shared-clk-ids-for-6.11' into sunxi/dt-for-6.11
      arm64: dts: mediatek: mt8183-kukui: Drop bogus output-enable prope=
rty
      arm64: dts: mediatek: Drop mediatek,drive-strength-adv usage
      arm64: dts: mediatek: mt8183-pico6: Fix wake-on-X event node names
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add ports node for anx=
7625
      dt-bindings: arm: mediatek: Add MT8186 Voltorb Chromebooks
      arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks
      riscv: dts: allwinner: d1s-t113: Add system LDOs

Chintan Vankar (2):
      arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in phy=
_gmii_sel node
      arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G

Chris Morgan (3):
      dt-bindings: clock: sun50i-h616-ccu: Add GPADC clocks
      arm64: dts: allwinner: h616: Add GPADC device node
      arm64: dts: allwinner: anbernic-rg35xx-h: Add ADC joysticks

Chris Packham (1):
      ARM: dts: marvell: Add 7-segment LED display on x530

Christian Gmeiner (1):
      arm64: dts: imx8qm: Add GPU nodes

Christian Hewitt (8):
      dt-bindings: arm: amlogic: add GXLX/S905L/p271 reference board
      arm64: dts: meson: add GXLX/S905L/p271 support
      arm64: dts: meson: radxa-zero2: add pwm-fan support
      dt-bindings: arm: amlogic: add OSMC Vero 4K
      arm64: dts: meson: add support for OSMC Vero 4K
      dt-bindings: add dream vendor prefix
      dt-bindings: arm: amlogic: add support for Dreambox One/Two
      arm64: dts: meson: add initial support for Dreambox One/Two

Christophe Roullier (6):
      ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
      ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
      ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
      arm64: dts: st: add ethernet1 and ethernet2 support on stm32mp25
      arm64: dts: st: add eth2 pinctrl entries in stm32mp25-pinctrl.dtsi
      arm64: dts: st: enable Ethernet2 on stm32mp257f-ev1 board

Christopher Obbard (1):
      arm64: dts: imx8mp-debix-model-a: Enable HDMI output

Chukun Pan (7):
      arm64: dts: qcom: ipq6018: add sdhci node
      arm64: dts: rockchip: fix regulator name for Lunzn Fastrhino R6xS
      arm64: dts: rockchip: fix usb regulator for Lunzn Fastrhino R6xS
      arm64: dts: rockchip: fix pmu_io supply for Lunzn Fastrhino R6xS
      arm64: dts: rockchip: remove unused usb2 nodes for Lunzn Fastrhino=
 R6xS
      arm64: dts: rockchip: disable display subsystem for Lunzn Fastrhin=
o R6xS
      arm64: dts: rockchip: fixes PHY reset for Lunzn Fastrhino R68S

Cl=C3=A9ment L=C3=A9ger (1):
      ARM: dts: renesas: r9a06g032: Describe GMAC1

Conor Dooley (2):
      dt-bindings: riscv: microchip: document beaglev-fire
      riscv: dts: microchip: add an initial devicetree for the BeagleV F=
ire

Cristian Ciocaltea (4):
      arm64: dts: rockchip: Drop invalid mic-in-differential on rk3568-r=
ock-3a
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3566-roc-=
pc
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3568-evb1=
-v10
      arm64: dts: rockchip: Add missing power-domains for rk356x vop_mmu

Cristian Cozzolino (1):
      arm64: dts: qcom: msm8916-lg-m216: Add initial device tree

Dang Huynh (1):
      arm64: dts: qcom: qrb4210-rb2: Correct max current draw for VBUS

Daniel Danzberger (1):
      arm64: dts: Add Airoha EN7581 SoC and EN7581 Evaluation Board

Dasnavis Sabiya (2):
      arm64: dts: ti: k3-am69-sk: Add PCIe support
      arm64: dts: ti: k3-j784s4-main: Add node for EHRPWMs

David Heidelberg (1):
      ARM: dts: qcom: msm8960: correct memory base

David Wronek (1):
      arm64: dts: qcom: sm8550-samsung-q5q: fix typo

Devarsh Thakkar (3):
      arm64: dts: ti: k3-am62x-sk-common: Add bootph-all for I2C1 instan=
ce pinmux
      arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
      arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA

Dhruva Gole (2):
      arm64: dts: ti: k3-am62p5-sk: fix graph_child_address warnings
      arm64: dts: ti: k3-am62x-sk-common: Fix graph_child_address warns

Diederik de Haas (3):
      arm64: dts: rockchip: Add dma-names to uart1 on quartz64-b
      arm64: dts: rockchip: Add avdd supplies to hdmi on rock64
      arm64: dts: rockchip: Add dma-names to uart1 on Pine64 rk3566 devi=
ces

Dmitry Baryshkov (57):
      arm64: dts: qcom: sm8150: move USB graph to the SoC dtsi
      arm64: dts: qcom: sm8350: move USB graph to the SoC dtsi
      arm64: dts: qcom: sm8450: move USB graph to the SoC dtsi
      arm64: dts: qcom: sm8550: move USB graph to the SoC dtsi
      arm64: dts: qcom: sm8650: move USB graph to the SoC dtsi
      arm64: dts: qcom: sm8350: move PHY's orientation-switch to SoC dtsi
      arm64: dts: qcom: sm8450: move PHY's orientation-switch to SoC dtsi
      arm64: dts: qcom: sm8550: move PHY's orientation-switch to SoC dtsi
      arm64: dts: qcom: sm8650: move PHY's orientation-switch to SoC dtsi
      arm64: dts: qcom: sm8650-mtp: connect USB-C SS port to QMP PHY
      arm64: dts: qcom: delete wrong usb-role-switch properties
      arm64: dts: qcom: x1e80100: drop wrong usb-role-switch properties
      arm64: dts: qcom: sc7180: drop extra UFS PHY compat
      arm64: dts: qcom: sc8180x: add power-domain to UFS PHY
      arm64: dts: qcom: sdm845: add power-domain to UFS PHY
      arm64: dts: qcom: sm6115: add power-domain to UFS PHY
      arm64: dts: qcom: sm6350: add power-domain to UFS PHY
      arm64: dts: qcom: sm8250: add power-domain to UFS PHY
...

Dmitry Rokosov (3):
      arm64: dts: amlogic: a1: add cooling-cells for DVFS feature
      arm64: dts: amlogic: a1: introduce cpu temperature sensor
      arm64: dts: amlogic: ad402: setup thermal-zones

Dragan Simic (9):
      arm64: dts: allwinner: Add cache information to the SoC dtsi for H6
      dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
      arm64: dts: allwinner: Correct the model names for Pine64 boards
      arm64: dts: allwinner: Add cache information to the SoC dtsi for A=
64
      arm64: dts: allwinner: Add cache information to the SoC dtsi for H=
616
      arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for per-varian=
t OPPs
      arm64: dts: rockchip: Delete the SoC variant dtsi for RK3399Pro
      arm64: dts: rockchip: Add GPU OPP voltage ranges to RK356x SoC dtsi
      arm64: dts: rockchip: Update GPU OPP voltages in RK356x SoC dtsi

Etienne Carriere (2):
      arm64: dts: st: OP-TEE async notif on PPI 15 for stm32mp25
      ARM: dts: stm32: OP-TEE async notif interrupt for ST STM32MP15x bo=
ards

FUKAUMI Naoki (4):
      arm64: dts: rockchip: add SFC support for Radxa ROCK 5B
      arm64: dts: rockchip: add (but disabled) SFC node for Radxa ROCK 5A
      arm64: dts: rockchip: change spi-max-frequency for Radxa ROCK 3C
      arm64: dts: rockchip: fix mmc aliases for Radxa ZERO 3E/3W

Fabio Estevam (4):
      arm64: dts: imx8mm-iot-gateway: Add initial support
      dt-bindings: arm: fsl: Document Compulab IOT-GATE-iMX8
      arm64: dts: imx8qxp-mek: Pass memory-region to the DSP node
      arm64: dts: imx8mp: Remove 'snps,rx-sched-sp'

Francesco Dolcini (1):
      arm64: dts: freescale: imx8mp-verdin: add HDMI support

Frank Li (42):
      arm64: dts: imx8dxl-ss-adma: delete unused node
      arm64: dts: imx8dxl-ss-adma: update audio node power domains and I=
RQ number
      arm64: dts: imx8dxl-evk: add audio nodes
      arm64: dts: imx8-ss-audio: remove memory-region =3D <&dsp_reserved=
>;
      arm64: dts: imx8qm-ss-audio: add audio nodes
      arm64: dts: imx8qm-mek: add sai and wm8960 support
      arm64: dts: imx8x: add cm41 subsystem dtsi
      arm64: dts: imx8qm-mek: add i2c0 and children devices
      arm64: dts: imx8qm-mek: add cm41_i2c and children devices
      arm64: dts: imx8qm-mek: add flexcan support
      arm64: dts: imx8qm-mek: add lsio mu5 and mu6
      arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
      arm64: dts: imx8qm-mek: add fec2 support
      arm64: dts: freescale: ls1028a: Remove undocumented 'fsl,ls-pcie-e=
p'
      arm64: dts: freescale: ls1028a: Reorder sai dma-names to fix warni=
ng
      arm64: dts: ls1012a: Reorder sai dma-names to clean up DTB_CHECK w=
arning
      arm64: dts: ls1043a: Change I2C clock name to ipg to fix DTB_CHECK=
 warning
      arm64: dts: ls208xa: Change I2C clock name to ipg to fix DTB_CHECK=
 warning
      arm64: dts: ls2160a: Change I2C clock name to ipg to fix DTB_CHECK=
 warning
      arm64: dts: layerscape: Change node name from 'esdhc' to 'mmc'
      arm64: dts: layerscape: change thermal node name
...

Frank Wunderlich (3):
      dt-bindings: arm64: mediatek: add BananaPi R3 Mini
      arm64: dts: mediatek: Add mt7986 based Bananapi R3 Mini
      arm64: dts: mt7622: fix switch probe on bananapi-r64

Gabor Juhos (2):
      dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
      arm64: dts: qcom: add TP-Link Archer AX55 v1

Gabriel Fernandez (1):
      arm64: dts: st: enable STM32 access controller for RCC

Garrett Giordano (4):
      arm64: dts: ti: k3-am62a: Enable AUDIO_REFCLKx
      arm64: dts: ti: Add am62x-phyboard-lyra carrier board
      dt-bindings: arm: ti: Add bindings for PHYTEC AM62Ax based hardware
      arm64: dts: ti: Add basic support for phyBOARD-Lyra-AM62Ax

Geert Uytterhoeven (14):
      arm64: dts: renesas: condor-i: Add I2C EEPROM
      dt-bindings: fuse: Document R-Car E-FUSE / PFC
      dt-bindings: fuse: Document R-Car E-FUSE / OTP_MEM
      arm64: dts: mediatek: mt7986a: bpi-r3: Convert to sugar syntax
      arm64: dts: renesas: r8a779h0: Drop "opp-shared" from opp-table-0
      arm64: dts: renesas: r8a779a0: Add missing hypervisor virtual time=
r IRQ
      arm64: dts: renesas: r8a779f0: Add missing hypervisor virtual time=
r IRQ
      arm64: dts: renesas: r8a779g0: Add missing hypervisor virtual time=
r IRQ
      arm64: dts: renesas: r9a07g043u: Add missing hypervisor virtual ti=
mer IRQ
      arm64: dts: renesas: r9a07g044: Add missing hypervisor virtual tim=
er IRQ
      arm64: dts: renesas: r9a07g054: Add missing hypervisor virtual tim=
er IRQ
      arm64: dts: renesas: r9a08g045: Add missing hypervisor virtual tim=
er IRQ
      ARM: dts: renesas: Add interrupt-names to arch timer nodes
      arm64: dts: renesas: Add interrupt-names to arch timer nodes

Georgi Djakov (2):
      arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
      arm64: dts: qcom: sc7280: Add DT nodes for the TBUs

Gianluca Boiano (1):
      arm64: dts: qcom: pmi8950: add pwm node

Guido G=C3=BCnther (1):
      arm64: dts: imx8mq-librem5: Don't wake up on volume key press

Heiko Stuebner (3):
      Merge branch 'v6.11-shared/clkids' into v6.11-armsoc/dts32
      dt-bindings: arm: rockchip: Add ROCK 5 ITX board
      arm64: dts: rockchip: add ROCK 5 ITX board

Henry Bell (2):
      dt-bindings: riscv: starfive: add Star64 board compatible
      riscv: dts: starfive: add Star64 board devicetree

Hsin-Te Yuan (1):
      arm64: dts: mediatek: mt8183-kukui: Fix the value of `dlg,jack-det=
-rate` mismatch

Inochi Amaoto (1):
      riscv: dts: thead: th1520: Add PMU event node

Jagadeesh Kona (8):
      dt-bindings: clock: qcom: Update SM8450 videocc header file name
      dt-bindings: clock: qcom: Add SM8650 video clock controller
      clk: qcom: videocc-sm8550: Add support for videocc XO clk ares
      clk: qcom: videocc-sm8550: Add SM8650 video clock controller
      dt-bindings: clock: qcom: Update the order of SC8280XP camcc header
      dt-bindings: clock: qcom: Add SM8650 camera clock controller
      clk: qcom: camcc-sm8650: Add SM8650 camera clock controller driver
      arm64: dts: qcom: sm8650: Add video and camera clock controllers

Jai Luthra (7):
      arm64: dts: ti: k3-am62x: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62a7: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-beagleplay: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5-sk: Fix pinmux for McASP1 TX

James McGregor (2):
      dt-bindings: input: sun4i-lradc-keys: Add H616 compatible
      ARM: dts: sun50i: Add LRADC node

Jared McArthur (1):
      arm64: dts: ti: k3-j722s: Add gpio-ranges properties

Jayesh Choudhary (8):
      arm64: dts: ti: k3-am62-main: Fix the reg-range for main_pktdma
      arm64: dts: ti: k3-am62a-main: Fix the reg-range for main_pktdma
      arm64: dts: ti: k3-am62p-main: Fix the reg-range for main_pktdma
      arm64: dts: ti: k3-j722s-main: Add audio_refclk node
      arm64: dts: ti: k3-j722s-evm: Enable analog audio support
      arm64: dts: ti: k3-j784s4-main: Add McASP nodes
      arm64: dts: ti: k3-j784s4-main: Add audio_refclk node
      arm64: dts: ti: k3-j784s4-evm: Enable analog audio support

Jens Reidel (1):
      arm64: dts: qcom: pm6150: Add vibrator

Jerome Brunet (5):
      arm64: dts: amlogic: sm1: fix spdif compatibles
      arm64: dts: amlogic: g12: bump spdif output drive strength
      arm64: dts: amlogic: add power domain to hdmitx
      arm64: dts: amlogic: gx: correct hdmi clocks
      arm64: dts: amlogic: setup hdmi system clock

Jie Gan (1):
      arm64: dts: qcom: Add coresight nodes for SA8775p

Joe Mason (2):
      arm64: dts: qcom: msm8916-samsung-fortuna: Add BMC150 acceleromete=
r/magnetometer
      arm64: dts: qcom: msm8916-samsung-gprimeltecan: Add NFC

Johan Hovold (1):
      arm64: dts: qcom: sc8280xp-x13s: enable pm8008 camera pmic

Johan Jonker (4):
      ARM: dts: rockchip: add hdmi-sound node to rk3066a
      ARM: dts: rockchip: enable hdmi_sound and i2s0 for mk808 hdmi
      ARM: dts: rockchip: add #sound-dai-cells to hdmi node no rk3036
      ARM: dts: rockchip: add #sound-dai-cells to hdmi node on rk3128

Jonas Karlman (16):
      dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
      arm64: dts: rockchip: Add Radxa ZERO 3W/3E
      arm64: dts: rockchip: Add sdmmc related properties on rk3308-rock-=
pi-s
      arm64: dts: rockchip: Add pinctrl for UART0 to rk3308-rock-pi-s
      arm64: dts: rockchip: Add mdio and ethernet-phy nodes to rk3308-ro=
ck-pi-s
      arm64: dts: rockchip: Add OTP device node for RK3308
      arm64: dts: rockchip: Add rk3308 IO voltage domains
      arm64: dts: rockchip: Add io-domains to rk3308-rock-pi-s
      arm64: dts: rockchip: Update WIFi/BT related nodes on rk3308-rock-=
pi-s
      dt-bindings: arm: rockchip: Add Radxa ROCK S0
      arm64: dts: rockchip: Add Radxa ROCK S0
      arm64: dts: rockchip: Increase VOP clk rate on RK3328
      dt-bindings: arm: rockchip: Add Radxa ROCK 3B
      arm64: dts: rockchip: Add Radxa ROCK 3B
      dt-bindings: arm: rockchip: Add Xunlong Orange Pi 3B
      arm64: dts: rockchip: Add Xunlong Orange Pi 3B

Josua Mayer (6):
      arm64: dts: ti: k3-am642-hummingboard-t: correct rs485 rts polarity
      dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
      dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation =
board
      arm64: dts: add description for solidrun cn9130 som and clearfog b=
oards
      arm64: dts: add description for solidrun cn9131 solidwan board
      arm64: dts: add description for solidrun cn9132 cex7 module and cl=
earfog board

Joy Zou (2):
      arm64: dts: imx93-11x11-evk: fix duplicated lpi2c3 labels
      arm64: dts: imx93-11x11-evk: reorder lpi2c2, lpi2c3, mu1 and mu2 l=
abel

Junyi Zhao (1):
      arm64: dts: amlogic: Add Amlogic S4 PWM

Kamlesh Gurudasani (2):
      arm64: dts: ti: k3-am62a-main: Enable crypto accelerator
      arm64: dts: ti: k3-am62*-main: Remove unwanted properties from cry=
pto

Kaushal Kumar (1):
      arm64: dts: qcom: sdx75: Add modem SMP2P node

Komal Bajaj (5):
      arm64: dts: qcom: qdu1000: Add USB3 and PHY support
      arm64: dts: qcom: qdu1000-idp: enable USB nodes
      arm64: dts: qcom: qru1000-idp: enable USB nodes
      arm64: dts: qcom: qdu1000: Add secure qfprom node
      arm64: dts: qcom: qdu1000: fix usb interrupts properties

Konrad Dybcio (47):
      arm64: dts: qcom: x1e80100-pmics: Add the missing PMICs
      arm64: dts: qcom: ipq6018-*: Remove thermal zone polling delays
      arm64: dts: qcom: ipq8074-*: Remove thermal zone polling delays
      arm64: dts: qcom: ipq9574-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8916-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8939-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8953-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8976-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8996-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8998-*: Remove thermal zone polling delays
      arm64: dts: qcom: pm7550ba: Remove thermal zone polling delays
      arm64: dts: qcom: pms405: Remove thermal zone polling delays
      arm64: dts: qcom: pmx75: Remove thermal zone polling delays
      arm64: dts: qcom: qcm2290-*: Remove thermal zone polling delays
      arm64: dts: qcom: qcs404-*: Remove thermal zone polling delays
      arm64: dts: qcom: sa8775p-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc7180-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc7280-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8180x-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8280xp-*: Remove thermal zone polling delays
....

Krishna Kurapati (10):
      arm64: dts: qcom: sc7180: Disable SuperSpeed instances in park mode
      arm64: dts: qcom: sc7280: Disable SuperSpeed instances in park mode
      arm64: dts: qcom: ipq6018: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: ipq8074: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: msm8998: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sdm630: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sm6115: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sm6350: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: msm8996: Disable SS instance in Parkmode for USB
      arm64: dts: qcom: sdm845: Disable SS instance in Parkmode for USB

Krishna chaitanya chundru (2):
      arm64: dts: qcom: sm8450: Add interconnect path to PCIe node
      arm64: dts: qcom: sm8450: Add OPP table support to PCIe

Krzysztof Kozlowski (52):
      arm64: dts: qocm: sdx75: align smem node name with coding style
      arm64: dts: stratix10: socdk: drop unneeded flash address/size-cel=
ls
      arm64: dts: stratix10: socdk_nand: drop unneeded flash address/siz=
e-cells
      arm64: dts: agilex: socdk: drop unneeded flash address/size-cells
      arm64: dts: n5x: socdk: drop unneeded flash address/size-cells
      arm64: dts: microchip: sparx5_pcb134: move non-MMIO nodes out of a=
xi
      arm64: dts: microchip: sparx5_pcb135: move non-MMIO nodes out of a=
xi
      arm64: dts: qcom: use defines for interrupts
      arm64: dts: qcom: sm6350-pdx213: correct touchscreen interrupt fla=
gs
      arm64: dts: qcom: sm6375-pdx225: correct touchscreen interrupt fla=
gs
      arm64: dts: qcom: sm8250-sony-xperia: correct touchscreen interrup=
t flags
      arm64: dts: qcom: sm8450-sony-xperia: correct touchscreen interrup=
t flags
      ARM: dts: vt8500: align panel timings node name with dtschema
      ARM: dts: cirrus: align panel timings node name with dtschema
      ARM: dts: imx: align panel timings node name with dtschema
....

Kuninori Morimoto (2):
      arm64: dts: renesas: r8a779g0: Tidy up sound DT settings
      arm64: dts: renesas: r8a779h0: R-Car Sound support

Lad Prabhakar (3):
      arm64: dts: renesas: r9a09g011: Update fallback string for SDHI no=
des
      arm64: dts: renesas: rzg2l: Update fallback string for SDHI nodes
      arm64: dts: renesas: r9a08g045: Update fallback string for SDHI no=
des

Lin, Meng-Bo (2):
      arm64: dts: qcom: msm8916-gplus-fl8005a: Add sound and modem
      arm64: dts: qcom: msm8916-gplus-fl8005a: Add BMS

Linus Walleij (1):
      ARM: dts: ixp4xx: nslu2: beeper uses PWM

Liu Ying (1):
      arm64: dts: imx8mp-evk: Add MX8-DLVDS-LCD1 display module support

Lorenzo Bianconi (1):
      dt-bindings: arm64: dts: airoha: Add en7581 entry

Luca Ceresoli (1):
      arm64: dts: imx8mp-msc-sm2s: Add HDMI output

Luca Weiss (32):
      arm64: dts: qcom: sc7280: Add APR nodes for sound
      ARM: dts: qcom: msm8974-hammerhead: Hook up backlight
      dt-bindings: arm: qcom: Add Samsung Galaxy Note 3
      ARM: dts: qcom: msm8974-hammerhead: Update gpio hog node name
      arm64: dts: qcom: qcs404: Use qcs404-hfpll compatible for hfpll
      ARM: dts: qcom: msm8974: Use proper compatible for APCS syscon
      arm64: dts: qcom: pmi632: Add vibrator
      arm64: dts: qcom: sdm632-fairphone-fp3: Enable vibrator
      arm64: dts: qcom: pm7250b: Add node for PMIC VBUS booster
      arm64: dts: qcom: pm7250b: Add a TCPM description
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable USB role switching
      ARM: dts: qcom: msm8974: Use mboxes properties for APCS
      arm64: dts: qcom: msm8916: Use mboxes properties for APCS
      arm64: dts: qcom: msm8939: Use mboxes properties for APCS
      arm64: dts: qcom: msm8953: Use mboxes properties for APCS
      arm64: dts: qcom: msm8976: Use mboxes properties for APCS
      arm64: dts: qcom: msm8994: Use mboxes properties for APCS
      arm64: dts: qcom: qcm6490-fairphone-fp5: Use .mbn firmware for IPA
      arm64: dts: qcom: qcm6490-fairphone-fp5: Name the regulators
      arm64: dts: qcom: qcm6490-shift-otter: Name the regulators
      arm64: dts: qcom: sm7225-fairphone-fp4: Configure PM8008 regulators
      arm64: dts: qcom: qcm6490-fairphone-fp5: Configure PM8008 regulato=
rs
      ARM: dts: qcom: msm8974: Use mboxes in smsm node
      arm64: dts: qcom: msm8916: Use mboxes in smsm node
      arm64: dts: qcom: msm8939: Use mboxes in smsm node
      arm64: dts: qcom: msm8953: Use mboxes in smsm node
      arm64: dts: qcom: msm8976: Use mboxes in smsm node
      arm64: dts: qcom: sm7225-fairphone-fp4: Name the regulators
      arm64: dts: qcom: sm6350: Add missing qcom,non-secure-domain prope=
rty
      arm64: dts: qcom: sm7225-fairphone-fp4: Add PMK8003 thermals
      arm64: dts: qcom: sm7225-fairphone-fp4: Add PM6150L thermals
      mailmap: Update Luca Weiss's email address

MD Danish Anwar (2):
      arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add overlay for mii =
mode
      arm64: dts: ti: k3-am642-evm: Enable "SYNC_OUT0" output

Macpaul Lin (3):
      dt-bindings: arm64: mediatek: add mt8390-evk board
      arm64: dts: mediatek: add device-tree for Genio 700 EVK board
      arm64: dts: mediatek: mt8395-genio-1200-evk: add u3port1 for xhci1

Manivannan Sadhasivam (1):
      arm64: dts: qcom: sm8650: Use "pcie" as the node name instead of "=
pci"

Marc Gonzalez (2):
      arm64: dts: qcom: msm8998: enable adreno_smmu by default
      arm64: dts: qcom: msm8998: set qcom,no-msa-ready-indicator for wifi

Marek Beh=C3=BAn (7):
      ARM: dts: armada-{370-xp,375,38x,39x}: Drop #size-cells from mpic =
node
      dt-bindings: interrupt-controller: convert marvell,mpic binding to=
 YAML
      ARM: dts: turris-omnia: Add MCU system-controller node
      ARM: dts: turris-omnia: Add GPIO key node for front button
      ARM: dts: armada-{370-xp,375,38x,39x}: Drop #size-cells from mpic =
node
      ARM: dts: turris-omnia: Add MCU system-controller node
      ARM: dts: turris-omnia: Add GPIO key node for front button

Marek Vasut (11):
      ARM: dts: stm32: Add arm,no-tick-in-suspend to STM32MP15xx STGEN t=
imer
      dt-bindings: arm: stm32: Add compatible string for DH electronics =
STM32MP13xx DHCOR DHSBC board
      arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2 and PDK3
      ARM: dts: imx: Add LVDS port data mapping on M53 Menlo
      arm64: dts: imx8mp: Do not reconfigure Audio PLL2 on DH i.MX8M Plu=
s DHCOM SoM
      arm64: dts: imx8mp: Update Fast ethernet PHY MDIO addresses to mat=
ch DH i.MX8MP DHCOM rev.200
      ARM: dts: rockchip: Drop ethernet-phy-ieee802.3-c22 from PHY compa=
tible string on edgeble-neu2
      arm64: dts: rockchip: Drop ethernet-phy-ieee802.3-c22 from PHY com=
patible string on all RK3588 boards
      ARM: dts: stm32: Add pinmux nodes for DH electronics STM32MP13xx D=
HCOR SoM and DHSBC board
      ARM: dts: stm32: Add support for STM32MP13xx DHCOR SoM and DHSBC b=
oard
      ARM: dts: stm32: Add ethernet support for DH STM32MP13xx DHCOR DHS=
BC board

Martijn Braam (1):
      arm64: dts: qcom: Add Motorola Moto G 2015 (osprey)

Martin Schmiedel (1):
      arm64: dts: freescale: add TQMa8MPQL on MBa8MP-RAS314

Matt Ranostay (2):
      arm64: dts: ti: k3-j784s4-main: Add support for USB
      arm64: dts: ti: k3-j784s4-evm: Enable USB3 support

Matthias Brugger (1):
      riscv: dts: starfive: Update flash partition layout

Matthias Schiffer (1):
      arm64: dts: ti: k3-am64-tqma64xxl: relicense to GPL-2.0-only OR MIT

Max Krummenacher (2):
      arm64: dts: freescale: imx8mm-verdin: don't limit i2c2 max. clock
      arm64: dts: freescale: imx8mp-verdin: don't limit i2c2 max. clock

Michael Walle (16):
      dt-bindings: Drop Li Yang as maintainer for all bindings
      dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
      ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
      ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
      ARM: dts: imx6qdl-kontron-samx6i: fix board reset
      ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
      ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
      ARM: dts: imx6qdl-kontron-samx6i: fix product name
      ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
      ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
      ARM: dts: imx6qdl-kontron-samx6i: fix node names
      ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity
      ARM: dts: imx6qdl-kontron-samx6i: remove wake-up-gpio property
      ARM: dts: imx6qdl-kontron-samx6i: add actual device trees
      dt-bindings: arm64: mediatek: add Kontron 3.5"-SBC-i1200
      arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200

Michal Simek (9):
      arm64: zynqmp: Align nvmem node with dt schema
      arm64: zynqmp: Use fpga-region as node name
      arm64: zynqmp: Add missing description for efuses
      arm64: zynqmp: Describe USB wakeup interrupt
      arm64: zynqmp: Describe OCM controller
      arm64: zynqmp: Remove address/size-cells from ams node
      arm64: zynqmp: Add compatible string for kv260
      arm64: zynqmp: Add description for ina260 on kv260
      arm64: zynqmp: Add support for K26 rev2 boards

Mike Looijmans (1):
      arm64: dts: ls1028a-rdb: Add EEPROM nodes to I2C bus

Minda Chen (1):
      riscv: dts: starfive: add PCIe dts configuration for JH7110

Mohammad Shehar Yaar Tausif (1):
      ARM: dts: vt8500: replace "uhci" nodename with generic name "usb"

Mrinmay Sarkar (3):
      arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
      arm64: dts: qcom: sa8775p: Add ep pcie1 controller node
      arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache cohere=
nt

Mukesh Ojha (2):
      arm64: dts: qcom: sm8650: Enable download mode register write
      arm64: dts: qcom: sc7280: Enable download mode register write

Naina Mehta (2):
      arm64: dts: qcom: sdx75: Add SDHCI node
      arm64: dts: qcom: sdx75-idp: add SDHCI for SD Card

Nathan Morrisson (9):
      arm64: dts: ti: phycore-am64: Add PMIC
      arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase cpu fr=
equency to 1.4 GHz
      arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
      arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe
      arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
      arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth p=
hy
      arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
      arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable spi n=
or
      arm64: dts: ti: k3-am6xx-phycore-qspi-nor: Add overlay to enable Q=
SPI NOR

Neha Malcom Francis (4):
      arm64: boot: dts: ti: k3-*: Add memory node to bootloader stage
      arm64: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287 nodes
      arm64: dts: ti: k3-am69-sk: Add TPS62873 node
      arm64: dts: ti: k3-j784s4-evm: Add TPS62873 node

Neil Armstrong (27):
      arm64: dts: qcom: sm8450: correct pcie1 phy clocks inputs to gcc
      arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk and add pcie1_=
phy pcie1_phy_aux_clk
      arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk and add pcie1_=
phy pcie1_phy_aux_clk
      dt-bindings: arm: qcom: Document the HDK8650 board
      arm64: dts: qcom: sm8650: add support for the SM8650-HDK board
      arm64: dts: qcom: sm8650-hdk: enable GPU
      arm64: dts: qcom: sdm450: add Lenovo Smart Tab M10 DTS
      dt-bindings: arm: qcom: Add Lenovo Smart Tab M10 (WiFi)
      arm64: dts: qcom: sm8650-hdk: allow more IOMMU SID for the first Q=
UP instance
      Merge branch 'dt' of https://git.kernel.org/pub/scm/linux/kernel/g=
it/ulfh/linux-pm into v6.11/arm64-dt
      arm64: dts: sm8650-hdk: add support for the Display Card overlay
      arm64: dts: amlogic: meson-g12b-bananapi: remove invalid fan on wr=
ong pwm_cd controller
      arm64: dts: amlogic: move ao_pinctrl into aobus
      arm64: dts: amlogic: sm1: fix tdm audio-controller clock order
      arm64: dts: amlogic: sm1: fix tdm controllers compatible
      arm64: dts: amlogic: g12a-u200: drop invalid sound-dai-cells
      arm64: dts: amlogic: g12a-u200: add missing AVDD-supply to acodec
      arm64: dts: amlogic: axg: fix tdm audio-controller clock order
      arm64: dts: amlogic: c3: use correct compatible for gpio_intc node
      arm64: dts: amlogic: a1: use correct node name for mmc controller
      arm64: dts: amlogic: a1: drop the invalid reset-name for usb@fe004=
400
      arm64: dts: amlogic: gxbb-odroidc2: fix invalid reset-gpio property
      arm64: dts: qcom: sm8650-hdk: add the Wifi node
      arm64: dts: amlogic: ad402: fix thermal zone node name
      arm64: dts: qcom: sm8650-hdk: add port mapping to speakers
      arm64: dts: qcom: sm8650-mtp: add port mapping to speakers
      arm64: dts: qcom: sm8650-qrd: add port mapping to speakers

Nikita Travkin (2):
      dt-bindings: arm: qcom: Add msm8916 based Motorola devices
      dt-bindings: arm: qcom: Add msm8916 based LG devices

Niklas Cassel (2):
      arm64: dts: rockchip: Add PCIe endpoint mode support
      arm64: dts: rockchip: Add rock5b overlays for PCIe endpoint mode

Niklas S=C3=B6derlund (3):
      arm64: dts: renesas: r8a779g0: Use MDIO node for all AVB devices
      arm64: dts: renesas: white-hawk: ethernet: Describe AVB1 and AVB2
      arm64: dts: renesas: r8a779h0: Add video capture nodes

Nishanth Menon (2):
      arm64: dts: ti: k3-pinctrl: Define a generic GPIO MUX Mode
      arm64: dts: ti: k3-am62p: Add gpio-ranges properties

Nitin Yadav (1):
      arm64: dts: ti: k3-am62: Add GPMC and ELM nodes

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: qcom: sc7180-trogdor: Disable pwmleds node where unused

Odelu Kukatla (1):
      arm64: dts: qcom: sc7280: Add clocks for QOS configuration

Parthiban Nallathambi (2):
      arm64: dts: phygate-tauri-l: enable pcie phy
      arm64: dts: phygate-tauri-l: add overlays for RS232 and RS485

Pascal Paillet (3):
      regulator: Add STM32MP25 regulator bindings
      arm64: dts: st: add scmi regulators on stm32mp25
      arm64: dts: st: describe power supplies for stm32mp257f-ev1 board

Patrick Delaunay (1):
      arm64: dts: st: add power domain on stm32mp25

Pavel L=C3=B6bl (1):
      ARM: dts: sunxi: remove duplicated entries in makefile

Peng Fan (5):
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts
      arm64: dts: freescale: Support i.MX93 9x9 Quick Start Board
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      dt-bindings: arm: fsl: add i.MX93 9x9 QSB board

Peter Robinson (4):
      arm64: dts: rockchip: Enable SPI flash on PinePhone Pro
      arm64: dts: rockchip: Add Pinephone Pro support for GPIO LEDs
      arm64: dts: rockchip: Enable PinePhone Pro IMU sensor
      arm64: dts: rockchip: Enable PinePhone Pro vibrator

Pierre-Hugues Husson (1):
      arm64: dts: qcom: msm8998: add venus node

Pin-yen Lin (2):
      arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us for pp33=
00_mipibrdg
      arm64: dts: mt8173: Add G2Touch touchscreen node

Rafa=C5=82 Mi=C5=82ecki (16):
      ARM: dts: nxp: imx6: convert NVMEM content to layout syntax
      dt-bindings: vendor-prefixes: add Cudy
      dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
      arm64: dts: mediatek: mt7981: add pinctrl
      arm64: dts: mediatek: Add Cudy WR3000 V1
      arm64: dts: mediatek: mt7988: add XHCI controllers
      arm64: dts: mediatek: mt7981: add watchdog & WiFi controllers
      arm64: dts: mediatek: mt7981: fix code alignment for PWM clocks
      arm64: dts: mediatek: mt7981: add efuse block
      dt-bindings: vendor-prefixes: add OpenWrt
      dt-bindings: arm64: dts: mediatek: Add OpenWrt One
      arm64: dts: mediatek: Add OpenWrt One
      arm64: dts: mediatek: mt7988: add PWM controller
      arm64: dts: mediatek: mt7988: add I2C controllers
      arm64: dts: mediatek: mt7622: fix "emmc" pinctrl mux
      arm64: dts: mediatek: mt7981: add I2C controller

Rajendra Nayak (1):
      arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes

Raphael Gallais-Pou (2):
      ARM: dts: st: add thermal property on stih410.dtsi and stih418.dtsi
      ARM: dts: sti: add thermal-zones support on stih418

Raymond Hackley (8):
      arm64: dts: qcom: msm8916/39-samsung-a2015: Add PMIC and charger
      arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add connector for=
 MUIC
      arm64: dts: qcom: msm8916-samsung-rossa: Add LIS2HH12 accelerometer
      arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add S3FWRN5 NFC
      arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add PMIC and char=
ger
      arm64: dts: qcom: msm8916-acer-a1-724: Add sound and modem
      dt-bindings: arm: qcom: Document samsung,ms013g
      ARM: dts: qcom: qcom-msm8226-samsung-ms013g: Add initial device tr=
ee

Rayyan Ansari (1):
      ARM: dts: qcom: msm8226-microsoft-common: Enable smbb explicitly

Richard Acayan (1):
      arm64: dts: qcom: sdm670: add smem region

Rob Herring (2):
      arm64: dts: sprd: Split PMU nodes for heterogeneous CPUs
      arm: dts: arm: Drop redundant fixed-factor clocks

Rob Herring (Arm) (4):
      arm64: dts: qcom: Split PMU nodes for heterogeneous CPUs
      arm: dts: nuvoton: Use standard 'i2c' bus node name
      arm: dts: aspeed: Use standard 'i2c' bus node name
      arm/arm64: dts: arm: Use generic clock and regulator nodenames

Robin Murphy (1):
      arm64: dts: juno: Enable GPU

Roger Quadros (3):
      arm64: dts: ti: am642-evm: Add overlay for NAND expansion card
      arm64: dts: ti: am62-lp-sk: Add overlay for NAND expansion card
      arm: dts: k3-am642-evm-nand: Add bootph-all to NAND related nodes

Rohit Agarwal (4):
      arm64: dts: qcom: sdx75: Add IPCC node
      arm64: dts: qcom: sdx75: Add TCSR register space
      arm64: dts: qcom: sdx75: Add AOSS node
      arm64: dts: qcom: sdx75: Support for I2C and SPI

Ruby Iris Juric (1):
      arm64: dts: qcom: Add device tree for Motorola Moto G4 Play (harpi=
a)

Ryan Walklin (2):
      arm64: dts: allwinner: h616: add additional CPU OPPs for the H700
      arm64: dts: allwinner: rg35xx: Enable DVFS CPU frequency scaling

Sagar Cheluvegowda (1):
      arm64: dts: qcom: sa8775p: mark ethernet devices as DMA-coherent

Sam Protsenko (1):
      arm64: dts: exynos850: Enable TRNG

Samuel Holland (1):
      riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees

Satya Priya Kakitapalli (1):
      arm64: dts: qcom: sm8150: Add video clock controller node

Sean Anderson (1):
      arm64: zynqmp: Add coresight cpu debug support

Sean Nyekjaer (2):
      ARM: dts: stm32: osd32: move usb phy power to common
      ARM: dts: stm32: osd32: move pwr_regulators to common

Sebastian Kropatsch (2):
      dt-bindings: arm: rockchip: Add FriendlyElec CM3588 NAS
      arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board

Shawn Guo (1):
      Merge tag 'imx-fixes-6.10' into imx/dt64

Shengjiu Wang (4):
      arm64: dts: imx8mp: Initialize audio PLLs from audiomix subsystem
      arm64: dts: imx8mp-evk: add bt-sco sound card support
      arm64: dts: imx8mp: Add audio XCVR device node
      arm64: dts: imx8mp-evk: Add audio XCVR sound card

Sibi Sankar (2):
      arm64: dts: qcom: x1e80100: Add BWMONs
      arm64: dts: qcom: x1e80100: Add fastrpc nodes

Siddharth Manthan (1):
      arm64: dts: qcom: msm8916-samsung-fortuna: Add LSM303C acceleromet=
er/magnetometer

Siddharth Vadapalli (16):
      arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
      arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add ali=
ases for it
      arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with =
CPSW9G
      arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
      arm64: dts: ti: k3-am62p: use eFuse MAC Address for CPSW3G Port 1
      arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
      arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
      arm64: dts: ti: k3-j784s4-evm: Add overlay for PCIe0 and PCIe1 EP =
Mode
      arm64: dts: ti: am62p: Rename am62p-{}.dtsi to am62p-j722s-common-=
{}.dtsi
      arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to am62p-=
main.dtsi
      arm64: dts: ti: k3-j722s: Add main domain peripherals specific to =
J722S
      arm64: dts: ti: k3-j722s: Switch to k3-am62p-j722s-common-{}.dtsi =
includes
      arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros =
for J722S
      arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
      arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM
      arm64: dts: ti: k3-am62p-j722s: Move SoC-specific node properties

Sinthu Raja (1):
      arm64: dts: ti: k3-am68-sk-som: Add support for OSPI flash

Srinivas Kandagatla (4):
      arm64: dts: qcom: msm8996: add fastrpc nodes
      arm64: dts: qcom: x1e80100-qcp: add audio support
      dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x
      arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga slim 7x devic=
etree

Stanislav Jakubek (1):
      ARM: dts: qcom: motorola-falcon: add accelerometer, magnetometer

Stephen Boyd (3):
      arm64: dts: qcom: sc7180: quackingstick: Disable instead of delete=
 usb_c1
      arm64: dts: qcom: sc7180: pazquel: Add missing comment header
      arm64: dts: qcom: sc7180-trogdor: Make clamshell/detachable fragme=
nts

Suman Anna (2):
      arm64: dts: ti: k3-am64-main: Add PRU system events for virtio
      arm64: dts: ti: k3-am65-main: Add PRU system events for virtio

Sumit Garg (3):
      dt-bindings: vendor-prefixes: Add Schneider Electric
      dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
      arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS

Tanmay Shah (1):
      dts: zynqmp: add properties for TCM in remoteproc

Tejas Bhumkar (1):
      arm64: zynqmp: Disable Tri-state for SDIO

Tengfei Fan (10):
      arm64: dts: qcom: sm4450: Add cpufreq support
      arm64: dts: qcom: sa8775p: Add llcc support for the SA8775p platfo=
rm
      dt-bindings: soc: qcom: add qcom,sa8775p-imem compatible
      arm64: dts: qcom: sa8775p: Add IMEM and PIL info region
      arm64: dts: qcom: sm8550: Move usb-role-switch to SoC dtsi
      arm64: dts: qcom: sm8550: Remove usb default dr_mode
      dt-bindings: arm: qcom: Document QCS8550 SoC and the AIM300 AIoT b=
oard
      arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
      arm64: dts: qcom: add base AIM300 dtsi
      arm64: dts: qcom: aim300: add AIM300 AIoT

Tim Harvey (4):
      arm64: dts: freescale: imx8m*-venice-*: fix gw,gsc dt-schema warni=
ngs
      arm64: dts: imx8mm-venice-gw700x: add support for PHY LED's
      arm64: dts: imx8mp-venice-gw702x: add support for PHY LED's
      arm64: dts: imx8mp-venice-gw74xx: add DP83867 configuration

Tomi Valkeinen (1):
      arm64: dts: ti: k3-j721e: Add overlay for J721E Infotainment Expan=
sion Board

Trevor Woerner (1):
      arm64: dts: rockchip: add gpio-line-names to radxa-zero-3

Umang Chheda (1):
      arm64: dts: qcom: qcs6490-rb3gen2: Enable PMK8350 RTC module

Unnathi Chalicheemala (3):
      arm64: dts: qcom: sm8450: Add Broadcast_AND register in LLCC block
      arm64: dts: qcom: sm8550: Add Broadcast_AND register in LLCC block
      arm64: dts: qcom: sm8650: Add Broadcast_AND register in LLCC block

Uwe Kleine-K=C3=B6nig (1):
      ARM: dts: stm32: Document output pins for PWMs on stm32mp135f-dk

Vaishnav Achath (1):
      arm64: dts: ti: k3-j722s: Fix main domain GPIO count

Valentin Caron (3):
      arm64: dts: st: add usart nodes on stm32mp25
      arm64: dts: st: add usart6 pinctrl used on stm32mp257f-ev1 board
      arm64: dts: st: add usart6 on stm32mp257f-ev1 board

Valeriy Klimin (3):
      ARM: dts: qcom: Add Sony Xperia Z3 Compact smartphone
      ARM: dts: qcom: msm8974-sony-shinano: increase load on l21 for sdh=
c2
      dt-bindings: arm: qcom: Add Sony Xperia Z3 Compact

Varadarajan Narayanan (2):
      dt-bindings: interconnect: Add Qualcomm IPQ9574 support
      arm64: dts: qcom: ipq9574: Add icc provider ability to gcc

Vedant Deshpande (1):
      arm64: tegra: Restructure Orin NX/Nano device tree

Venkata Prahlad Valluru (1):
      arm64: dts: qcom: qcs6490-rb3gen2: enable hdmi bridge

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62a-wakeup: Enable RTC node

Viken Dadhaniya (2):
      arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
      arm64: dts: qcom: sc7280: Remove CTS/RTS configuration

Vishal Patel (1):
      arm64: zynqmp: Add pwm-fan node and fix ttc0 pwm-cells property

Vishal Sagar (1):
      arm64: zynqmp: Describe DisplayPort connector for Kria

Vitor Soares (1):
      arm64: dts: imx8mm-verdin: add TPM device

Wiktor Strz=C4=99ba=C5=82a (1):
      arm64: dts: qcom: Add Motorola Moto E 2015 LTE (surnia)

Wolfram Sang (4):
      arm64: dts: renesas: gray-hawk-single: Add aliases for I2C buses
      arm64: dts: renesas: white-hawk-cpu: Add aliases for I2C buses
      arm64: dts: renesas: spider-cpu: Add aliases for I2C buses
      arm64: dts: renesas: s4sk: Add aliases for I2C buses

Xianwei Zhao (2):
      dt-bindings: power: add Amlogic A4 power domains
      arm64: dts: amlogic: a4: add power domain controller node

Xilin Wu (2):
      dt-bindings: arm: qcom: Add ASUS Vivobook S 15
      arm64: dts: qcom: Add device tree for ASUS Vivobook S 15

Yangyu Chen (1):
      dt-bindings: riscv: Add T-HEAD C908 compatible

Yanjun Yang (1):
      ARM: dts: stm32: Missing clocks for stm32f429's syscfg.

Yannick Fertre (1):
      ARM: dts: stm32: add goodix touchscreen on stm32mp135f-dk

   0.0% Documentation/devicetree/bindings/arm/marvell/
   0.0% Documentation/devicetree/bindings/arm/stm32/
   0.0% Documentation/devicetree/bindings/arm/ti/
   0.3% Documentation/devicetree/bindings/arm/
   0.1% Documentation/devicetree/bindings/clock/
   0.1% Documentation/devicetree/bindings/fuse/
   0.0% Documentation/devicetree/bindings/input/
   0.1% Documentation/devicetree/bindings/interrupt-controller/
   0.0% Documentation/devicetree/bindings/power/
   0.0% Documentation/devicetree/bindings/riscv/
   0.0% Documentation/devicetree/bindings/soc/fsl/
   0.0% Documentation/devicetree/bindings/soc/hisilicon/
   0.0% Documentation/devicetree/bindings/soc/mediatek/
   0.0% Documentation/devicetree/bindings/soc/sti/
   0.0% Documentation/devicetree/bindings/sram/
   0.0% Documentation/devicetree/bindings/
   0.1% arch/arm/boot/dts/allwinner/
   0.4% arch/arm/boot/dts/arm/
   0.0% arch/arm/boot/dts/aspeed/
   0.0% arch/arm/boot/dts/cirrus/
   0.0% arch/arm/boot/dts/intel/ixp/
   0.5% arch/arm/boot/dts/marvell/
   0.0% arch/arm/boot/dts/mediatek/
   0.0% arch/arm/boot/dts/nspire/
   0.0% arch/arm/boot/dts/nuvoton/
   0.5% arch/arm/boot/dts/nxp/imx/
   0.0% arch/arm/boot/dts/nxp/mxs/
   2.3% arch/arm/boot/dts/qcom/
   0.0% arch/arm/boot/dts/renesas/
   0.2% arch/arm/boot/dts/rockchip/
   2.4% arch/arm/boot/dts/st/
   0.0% arch/arm/boot/dts/ti/davinci/
   0.0% arch/arm/boot/dts/ti/omap/
   0.0% arch/arm/boot/dts/vt8500/
   0.2% arch/arm64/boot/dts/airoha/
   0.4% arch/arm64/boot/dts/allwinner/
   0.0% arch/arm64/boot/dts/altera/
   1.6% arch/arm64/boot/dts/amlogic/
   0.0% arch/arm64/boot/dts/apm/
   0.0% arch/arm64/boot/dts/arm/
   0.0% arch/arm64/boot/dts/exynos/google/
   0.0% arch/arm64/boot/dts/exynos/
  15.7% arch/arm64/boot/dts/freescale/
   0.0% arch/arm64/boot/dts/hisilicon/
   0.0% arch/arm64/boot/dts/intel/
   3.3% arch/arm64/boot/dts/marvell/
   5.6% arch/arm64/boot/dts/mediatek/
   0.0% arch/arm64/boot/dts/microchip/
   0.1% arch/arm64/boot/dts/nvidia/
  24.6% arch/arm64/boot/dts/qcom/
   1.2% arch/arm64/boot/dts/renesas/
  18.6% arch/arm64/boot/dts/rockchip/
   0.0% arch/arm64/boot/dts/sprd/
   0.7% arch/arm64/boot/dts/st/
  10.7% arch/arm64/boot/dts/ti/
   0.4% arch/arm64/boot/dts/xilinx/
   0.0% arch/arm64/boot/dts/
   0.3% arch/riscv/boot/dts/allwinner/
   0.3% arch/riscv/boot/dts/microchip/
   0.0% arch/riscv/boot/dts/sophgo/
   0.3% arch/riscv/boot/dts/starfive/
   0.2% arch/riscv/boot/dts/thead/
   5.9% drivers/clk/qcom/
   0.4% include/dt-bindings/clock/
   0.1% include/dt-bindings/interconnect/
   0.0% include/dt-bindings/power/
   0.0% include/dt-bindings/regulator/
   0.0% include/dt-bindings/reset/

 813 files changed, 60639 insertions(+), 10026 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,juno-fpga-=
apb-regs.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,qcm2290=
-gpucc.yaml
 create mode 100644 Documentation/devicetree/bindings/fuse/renesas,rcar-=
efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/fuse/renesas,rcar-=
otp.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controll=
er/marvell,armada-370-xp-mpic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controll=
er/marvell,mpic.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/hisilicon/hisi=
licon,hi3660-usb3-otg-bc.yaml
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2=
.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.=
dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads=
2.dtsi
 create mode 100644 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwi=
fi.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-samsung-ms013g.d=
ts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974-samsung-hlte.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-s=
hinano-aries.dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
 create mode 100644 arch/arm64/boot/dts/airoha/Makefile
 create mode 100644 arch/arm64/boot/dts/airoha/en7581-evb.dts
 create mode 100644 arch/arm64/boot/dts/airoha/en7581.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-one.=
dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox-two.=
dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-vero4k.d=
ts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-iot-gateway.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l=
-rs232-rs232.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l=
-rs232-rs485.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l=
-rs232-rts-cts.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-ucm-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-l=
cd1.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8m=
p-ras314.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-clock.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-power.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx95.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.=
dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3=
-mini.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-=
sku589824.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-=
sku589825.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.=
dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.d=
ts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-=
i1200.dts
 rename arch/arm64/boot/dts/nvidia/{tegra234-p3768-0000.dtsi =3D> tegra2=
34-p3768-0000+p3767.dtsi} (90%)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-=
v1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-lg-c50.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-lg-m216.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-motorola-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dt=
si
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.d=
tsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650-hdk-display-card.dtso
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650-hdk.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.=
dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x=
.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
 delete mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v1.1=
.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b-v2.1=
.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
 rename arch/arm64/boot/dts/rockchip/{rk3588s-pinctrl.dtsi =3D> rk3588-b=
ase-pinctrl.dtsi} (100%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
 rename arch/arm64/boot/dts/rockchip/{rk3588-pinctrl.dtsi =3D> rk3588-ex=
tra-pinctrl.dtsi} (100%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3=
588-nas.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3=
588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-ep.=
dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b-pcie-srn=
s.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-gh=
z-opp.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.d=
ts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dt=
si
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi =3D> k3-am62p-j722s-co=
mmon-mcu.dtsi} (94%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-thermal.dtsi =3D> k3-am62p-j722=
s-common-thermal.dtsi} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi =3D> k3-am62p-j722s=
-common-wakeup.dtsi} (93%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-=
mii.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pci=
e-usb2.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-=
phy.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.=
dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-=
nor.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board-in=
fotainment.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.=
dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-e=
xp1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-ex=
p2.dtso
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-=
v3.14.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.1=
4.dts
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabr=
ic.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
 create mode 100644 drivers/clk/qcom/camcc-sm8650.c
 create mode 100644 include/dt-bindings/clock/qcom,qcm2290-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8650-videocc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
 create mode 100644 include/dt-bindings/power/amlogic,a4-pwrc.h
 create mode 100644 include/dt-bindings/regulator/st,stm32mp25-regulator=
.h

