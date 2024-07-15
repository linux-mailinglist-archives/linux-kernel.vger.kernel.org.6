Return-Path: <linux-kernel+bounces-253088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6127931C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E92B2181D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC113C67B;
	Mon, 15 Jul 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ixQFn8HK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaf35ZZA"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E513A3E8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077158; cv=none; b=DIitngGo2fpkavoHWfiYMX0kTiH16OB2HuU7+P1VB0iF0/psyTsUDFRmOKR2HptNYiA6HsZoOzeH4MpnnjJg9HyrlD9Sjd3hVp7pYyQfsY2LCZvw3uokI0szQ9ujJ8OGgfYXSFb5zoig0EBtQIykLSRY0mdk55WnquOBShlKbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077158; c=relaxed/simple;
	bh=L221tXAEj3kgGkLLyvnDt9kifbqr+MhwzY3e8gJ9gHw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=d4D7Xzpm0V4G6O/0GY4GmSP+wufCIJUawdnICHNXCz6KBShAWzscB/rRdnJZkeYeew6RBR9/swJ2uhcyDIkdFptVKWc80kB+zAmnip0KJQ3xZXVHRmkCCDrefggApZeiefcz6byI7S7SC6eiIizJA8MnWBOc4s9kt4WpKfNrcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ixQFn8HK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kaf35ZZA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EBD621388B9D;
	Mon, 15 Jul 2024 16:59:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 16:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721077154;
	 x=1721163554; bh=eig9VGJ/hXCtYtrahp02YQs1skfAhmMWZt9Zg2abKvY=; b=
	ixQFn8HKDqwvra2LCqBaUA/TSfXutttZfAoBwjE6nPHTajwIlzXBu9RLKONUvzdn
	CztEJvN088+Yncebe1Zd7eQxPdWtOQHqqEiA9AVoNkJbG2btQ78GGMC21a/vJwqw
	XdenlcFqFUhbLz4BheSpMNm//9JEnYBNLNtk8a7NVJEbfRead/qBD60V8iUjZgLX
	ec+cKDSgkzMcalVIL0tQ4ZhgdteQFpxA9UpAVes6o8fwzVkV9/aikav46thg253P
	FcsbzbErzLcNuRTwFI0xL/yUekC3Ln0mli+w+jo+X4FF4xhIDeAg/OBiW5ohIPYe
	jGlD8EqXeK7IBqm3jLTv6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721077154; x=
	1721163554; bh=eig9VGJ/hXCtYtrahp02YQs1skfAhmMWZt9Zg2abKvY=; b=k
	af35ZZA/XLyppWxETKOfBQqkxWFX6AcUegKiAxwf3zSFHUgbG9ukOp0Cao9lY54Z
	s8ScldeXABafJm0voKmsCkCt1h0NT5jugrmiyEH/xhHEB8lb4J/kPJeilBH/T6+s
	L4DAavLJGTIO1CzOQ16eeAuUwga0lwXOnkPU+Q2l9cmXWAY/Uvn4OXzR3H5s4e+L
	ERn7hcC22WiWxpskJuJXiOTxSMRHQbGmql3PM5DmevSN8+wjOJx/L0Z0/ajOxQa5
	XJr65JCPQUTOmr7O6Pxd4D3oggOlEavqAX+gqkQQDLzfSZ9vCIHrCYsoOt9xWpDK
	wp1pilRw972qI8IJrVbUw==
X-ME-Sender: <xms:oY2VZiPE8hsB9AvzrRbhJccNi9PtY-LSldrOSYzDXxeRY_bbIQ7ImQ>
    <xme:oY2VZg8Rz3RSIAfDKqvtibng8DDN0aHU47KPyIE9J5xdODQpLYYtNWYIHoXuv5s4B
    AB9cBrGutYbwdBuKDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeejgfejffejveejgfetkeehueejleekhefgfedtiedvheehhfetjeeljeei
    gfdukeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhpvghnghhuthhrohhnihigrd
    guvgdplhhinhgrrhhordhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oY2VZpQVsnjHpGhe_FtMDj16ByPSW8HA2gNV_hrDzNuw_vG-h67TPA>
    <xmx:oY2VZiuUieSSV9Vo7UeTu2AelS05qREYgk4mzPi2fxtKOA2sF97pIg>
    <xmx:oY2VZqd8mgf93CPjtTNq4wMVdwz9vnokytJcZ8ncO28aEfmNcCHYZA>
    <xmx:oY2VZm25n0WyiPhEcRTUvriye123RLn8tE-TM3cdJIfH9tfIh8U7uw>
    <xmx:oo2VZq7_KpOMZ18rAxCfhEZ4B4Sd02fRGKPuMtko4WURsW-4fN5T7VIf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B27D0B6008D; Mon, 15 Jul 2024 16:59:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1df9dda1-1f40-4e13-b79b-350690295ab5@app.fastmail.com>
In-Reply-To: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
Date: Mon, 15 Jul 2024 23:05:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Subject: [GIT PULL 1/4] soc: driver updates for 6.11
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8=
454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.11

for you to fetch changes up to 49e24c80d3c81c43e2a56101449e1eea32fcf292:

  firmware: turris-mox-rwtm: Initialize completion before mailbox (2024-=
07-15 16:57:57 +0200)

----------------------------------------------------------------
soc: driver updates for 6.11

The updates to the mediatek, allwinner, ti, tegra, microchip, stm32,
samsung, imx, zynq and amlogic platoforms are farily small maintenance
changes, either addressing minor mistakes or enabling additional hardwar=
e.

The qualcomm platform changes add a number of features and are larger
than the other ones combined, introducing the use of linux/cleanup.h
across several drivers, adding support for Snapdragon X1E and other
SoCs in platform drivers, a new "protection domain mapper" driver, and a
"shared memory bridge" driver.

The cznic "turris omnia" router based on Marvell Armada gets a platform
driver that talks to the board specific microcontroller.

The reset and cache subsystems get a few minor updates to SoC specific
drivers, while the ff-a, scmi and optee firmware drivers get some
code refactoring and new features.

----------------------------------------------------------------
Abel Vesa (1):
      soc: qcom: pmic_glink: Increase max ports to 3

AngeloGioacchino Del Regno (1):
      soc: mediatek: mtk-mutex: Add MDP_TCC0 mod to MT8188 mutex table

Arnd Bergmann (18):
      Merge tag 'scmi-updates-6.11' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'ffa-updates-6.11' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'reset-for-v6.11' of git://git.pengutronix.de/pza/linux =
into soc/drivers
      Merge tag 'optee-notif-wait-timeout-for-v6.11' of https://git.lina=
ro.org/people/jens.wiklander/linux-tee into soc/drivers
      Merge tag 'mtk-soc-for-v6.11' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/mediatek/linux into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.11' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'tegra-for-6.11-soc' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'riscv-cache-for-v6.11' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/conor/linux into soc/drivers
      Merge tag 'riscv-firmware-for-v6.11' of https://git.kernel.org/pub=
/scm/linux/kernel/git/conor/linux into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.11' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.11' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'reset-for-v6.11-2' of git://git.pengutronix.de/pza/linu=
x into soc/drivers
      Merge tag 'sunxi-drivers-for-6.11' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/sunxi/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.11' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'zynqmp-soc2-for-6.11' of https://github.com/Xilinx/linu=
x-xlnx into soc/drivers
      Merge tag 'qcom-drivers-for-6.11-2' of https://git.kernel.org/pub/=
scm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'sunxi-drivers-for-6.11-2' of https://git.kernel.org/pub=
/scm/linux/kernel/git/sunxi/linux into soc/drivers
      platform: cznic: turris-omnia-mcu: fix Kconfig dependencies

Bartosz Golaszewski (14):
      dt-bindings: firmware: qcom,scm: add memory-region for sa8775p
      firmware: qcom: add a dedicated TrustZone buffer allocator
      firmware: qcom: scm: enable the TZ mem allocator
      firmware: qcom: scm: smc: switch to using the SCM allocator
      firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocat=
or
      firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ alloca=
tor
      firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
      firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ=
 allocator
      firmware: qcom: qseecom: convert to using the TZ allocator
      firmware: qcom: scm: add support for SHM bridge operations
      firmware: qcom: tzmem: enable SHM Bridge support
      firmware: qcom: scm: add support for SHM bridge memory carveout
      firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_imag=
e()
      firmware: qcom: tzmem: export devm_qcom_tzmem_pool_new()

Biju Das (6):
      reset: rzg2l-usbphy-ctrl: Move reset controller registration
      regulator: core: Add helper for allow HW access to enable/disable =
regulator
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document USB VBUS r=
egulator
      reset: renesas: Add USB VBUS regulator device as child
      phy: renesas: phy-rcar-gen3-usb2: Control VBUS for RZ/G2L SoCs
      arm64: dts: renesas: rz-smarc: Replace fixed regulator for USB VBUS

Bjorn Andersson (3):
      firmware: qcom: uefisecapp: Allow on X1E devices
      Merge branch '20240430-a750-raytracing-v3-2-7f57c5ac082d@gmail.com=
' into drivers-for-6.11
      Merge branch '20240622-qcom-pd-mapper-v9-0-a84ee3591c8e@linaro.org=
' into drivers-for-6.11

Chen Ni (1):
      soc: qcom: pmic_glink: Handle the return value of pmic_glink_init

Chris Lew (1):
      soc: qcom: smp2p: Use devname for interrupt descriptions

Christian Hewitt (1):
      soc: amlogic: meson-gx-socinfo: Add S905L ID

Christophe JAILLET (1):
      soc: ti: knav_qmss: Constify struct knav_range_ops

Connor Abbott (1):
      firmware: qcom: scm: Add gpu_init_regs call

Conor Dooley (6):
      firmware: microchip: support writing bitstream info to flash
      firmware: microchip: move buffer allocation into mpfs_auto_update_=
set_image_address()
      firmware: microchip: use scope-based cleanup where possible
      MAINTAINERS: add cache binding directory to cache driver entry
      MAINTAINERS: add microchip soc binding directory to microchip soc =
driver entry
      MAINTAINERS: drop riscv list from cache controllers

Dan Carpenter (1):
      MAINTAINERS: Add mailing list for SCMI drivers

Dmitry Baryshkov (6):
      soc: qcom: pdr: protect locator_addr with the main mutex
      soc: qcom: pdr: fix parsing of domains lists
      soc: qcom: pdr: extract PDR message marshalling data
      soc: qcom: add pd-mapper implementation
      soc: qcom: add missing pd-mapper dependencies
      firmware: qcom: tzmem: blacklist more platforms for SHM Bridge

Dr. David Alan Gilbert (1):
      soc: sunxi: sram: Remove unused list 'claimed_sram'

Esben Haabendal (1):
      memory: fsl_ifc: Make FSL_IFC config visible and selectable

Gavin Liu (1):
      optee: add timeout value to optee_notif_wait() to support timeout

Geert Uytterhoeven (1):
      reset: RESET_IMX8MP_AUDIOMIX should depend on ARCH_MXC

Hsiao Chien Sung (1):
      soc: mediatek: Disable 9-bit alpha in ETHDR

Jason-JH.Lin (1):
      soc: mtk-cmdq: Add cmdq_pkt_logic_command to support math operation

Javier Carrasco (2):
      soc: sunxi: sram: Constify struct regmap_config
      bus: sunxi-rsb: Constify struct regmap_bus

Jay Buddhabhatti (3):
      soc: xilinx: rename cpu_number1 to dummy_cpu_number
      soc: xilinx: Add cb event for subsystem restart
      drivers: soc: xilinx: check return status of get_api_version()

Jeff Johnson (3):
      soc: qcom: spm: add missing MODULE_DESCRIPTION()
      firmware: meson_sm: add missing MODULE_DESCRIPTION() macro
      soc: add missing MODULE_DESCRIPTION() macros

Jon Hunter (1):
      soc/tegra: pmc: Simplify resource lookup

Joshua Yeong (2):
      dt-bindings: cache: Add docs for StarFive Starlink cache controller
      cache: Add StarFive StarLink cache management

Kathiravan Thirumoorthy (3):
      dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
      soc: qcom: socinfo: Add SoC ID for IPQ5321
      cpufreq: qcom-nvmem: add support for IPQ5321

Ken Sloat (1):
      pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM mode.

Konrad Dybcio (3):
      soc: qcom: socinfo: Update X1E PMICs
      soc: qcom: Move some socinfo defines to the header
      soc: qcom: smem: Add a feature code getter

Krzysztof Kozlowski (6):
      firmware: qcom: tzmem: simplify returning pointer without cleanup
      soc: qcom: llcc: simplify with cleanup.h
      soc: qcom: mdt_loader: simplify with cleanup.h
      soc: qcom: ocmem: simplify with cleanup.h
      soc: qcom: pdr: simplify with cleanup.h
      soc: qcom: wcnss: simplify with cleanup.h

Luca Weiss (5):
      dt-bindings: soc: qcom,smp2p: Mark qcom,ipc as deprecated
      dt-bindings: soc: qcom,smsm: Allow specifying mboxes instead of qc=
om,ipc
      soc: qcom: smsm: Support using mailbox interface
      soc: qcom: smsm: Add missing mailbox dependency to Kconfig
      soc: qcom: socinfo: Add PM6350 PMIC

MD Danish Anwar (1):
      MAINTAINERS: Add entry for ti,pruss.yaml to TI KEYSTONE MULTICORE =
NAVIGATOR DRIVERS

Marek Beh=C3=BAn (11):
      dt-bindings: firmware: add cznic,turris-omnia-mcu binding
      platform: cznic: Add preliminary support for Turris Omnia MCU
      platform: cznic: turris-omnia-mcu: Add support for MCU connected G=
PIOs
      platform: cznic: turris-omnia-mcu: Add support for poweroff and wa=
keup
      platform: cznic: turris-omnia-mcu: Add support for MCU watchdog
      platform: cznic: turris-omnia-mcu: Add support for MCU provided TR=
NG
      platform: cznic: turris-omnia-mcu: Depend on OF
      platform: cznic: turris-omnia-mcu: Depend on WATCHDOG
      firmware: turris-mox-rwtm: Do not complete if there are no waiters
      firmware: turris-mox-rwtm: Fix checking return value of wait_for_c=
ompletion_timeout()
      firmware: turris-mox-rwtm: Initialize completion before mailbox

Michael Walle (1):
      dt-bindings: memory: fsl: replace maintainer

Neha Malcom Francis (1):
      soc: ti: k3-socinfo: Add J721E SR2.0

Pascal Paillet (1):
      arm64: stm32: enable scmi regulator for stm32

Peng Fan (3):
      firmware: arm_scmi: Add support for system suspend in power contro=
l driver
      dt-bindings: firmware: arm,scmi: Add support for notification comp=
letion channel
      firmware: arm_scmi: Add support for platform to agent channel comp=
letion

Peter Griffin (1):
      soc: samsung: exynos-pmu: add support for PMU_ALIVE non atomic reg=
isters

Philipp Zabel (5):
      reset: sti: allow building under COMPILE_TEST
      reset: meson-audio-arb: Use devm_clk_get_enabled()
      reset: zynqmp: allow building under COMPILE_TEST
      reset: tegra-bpmp: allow building under COMPILE_TEST
      Merge tag 'regulator-hw-enable-helper' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/broonie/regulator into reset/next

Richard Acayan (2):
      dt-bindings: arm: qcom,ids: Add SoC ID for SDM670
      soc: qcom: socinfo: Add SDM670 SoC ID table entry

Richard Genoud (2):
      dt-bindings: ti: fix TISCI protocol URL link
      firmware: ti_sci: fix TISCI protocol URL link

Roger Quadros (1):
      dt-bindings: soc: ti: Move ti,j721e-system-controller.yaml to soc/=
ti

Rohit Agarwal (1):
      dt-bindings: soc: qcom,aoss-qmp: Document the SDX75 AOSS channel

Ronak Jain (1):
      firmware: xilinx: Move FIRMWARE_VERSION_MASK to xlnx-zynqmp.h

Samuel Holland (1):
      dt-bindings: sram: sunxi-sram: Add regulators child

Shengjiu Wang (1):
      reset: imx8mp-audiomix: Add AudioMix Block Control reset driver

Sibi Sankar (4):
      soc: qcom: icc-bwmon: Fix refcount imbalance seen during bwmon_rem=
ove
      dt-bindings: interconnect: qcom,msm8998-bwmon: Remove opp-table fr=
om the required list
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add X1E80100 BWMON =
instances
      soc: qcom: icc-bwmon: Allow for interrupts to be shared across ins=
tances

Stephen Boyd (1):
      soc: qcom: rpmh-rsc: Ensure irqs aren't disabled by rpmh_rsc_send_=
data() callers

Sudeep Holla (2):
      firmware: arm_ffa: Move the FF-A v1.0 NULL UUID workaround to bus =
notifier
      firmware: arm_ffa: Split bus and driver into distinct modules

Tengfei Fan (2):
      dt-bindings: cache: qcom,llcc: Add SA8775p description
      soc: qcom: llcc: Add llcc configuration support for the SA8775p pl=
atform

Unnathi Chalicheemala (3):
      firmware: qcom-scm: Remove QCOM_SMC_WAITQ_FLAG_WAKE_ALL
      dt-bindings: arm: msm: Add llcc Broadcast_AND register
      soc: qcom: llcc: Add regmap for Broadcast_AND region

Vasyl Gomonovych (1):
      soc: ti: pm33xx: Fix missing newlines in log statements

Viacheslav Bocharov (1):
      soc: amlogic: meson-gx-socinfo: add new A113X SoC id

 .../testing/sysfs-bus-i2c-devices-turris-omnia-mcu |  113 ++
 .../devicetree/bindings/arm/keystone/ti,sci.yaml   |    2 +-
 .../devicetree/bindings/cache/qcom,llcc.yaml       |   55 +-
 .../cache/starfive,jh8100-starlink-cache.yaml      |   66 ++
 .../devicetree/bindings/clock/ti,sci-clk.yaml      |    2 +-
 .../devicetree/bindings/firmware/arm,scmi.yaml     |   12 +-
 .../bindings/firmware/cznic,turris-omnia-mcu.yaml  |   86 ++
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   15 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    3 +-
 .../bindings/memory-controllers/fsl/fsl,ifc.yaml   |    2 +-
 .../bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml  |   10 +
 .../devicetree/bindings/reset/ti,sci-reset.yaml    |    2 +-
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    1 +
 .../devicetree/bindings/soc/qcom/qcom,smp2p.yaml   |    3 +-
 .../devicetree/bindings/soc/qcom/qcom,smsm.yaml    |   30 +-
 .../devicetree/bindings/soc/ti/sci-pm-domain.yaml  |    2 +-
 .../ti}/ti,j721e-system-controller.yaml            |    4 +-
 .../sram/allwinner,sun4i-a10-system-control.yaml   |   28 +
 Documentation/power/regulator/consumer.rst         |    6 +
 MAINTAINERS                                        |   17 +-
 arch/arm64/Kconfig.platforms                       |    2 +
 arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi   |   11 +-
 drivers/bus/sunxi-rsb.c                            |    2 +-
 drivers/cache/Kconfig                              |    9 +
 drivers/cache/Makefile                             |    5 +-
 drivers/cache/starfive_starlink_cache.c            |  130 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |    1 +
 drivers/firmware/arm_ffa/Makefile                  |    6 +-
 drivers/firmware/arm_ffa/bus.c                     |   22 +-
 drivers/firmware/arm_ffa/common.h                  |    2 -
 drivers/firmware/arm_ffa/driver.c                  |   57 +-
 drivers/firmware/arm_scmi/common.h                 |    1 +
 drivers/firmware/arm_scmi/mailbox.c                |   57 +-
 drivers/firmware/arm_scmi/scmi_power_control.c     |   21 +-
 drivers/firmware/arm_scmi/shmem.c                  |    5 +
 drivers/firmware/meson/meson_sm.c                  |    1 +
 drivers/firmware/microchip/mpfs-auto-update.c      |  136 ++-
 drivers/firmware/qcom/Kconfig                      |   31 +
 drivers/firmware/qcom/Makefile                     |    1 +
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c    |  256 ++---
 drivers/firmware/qcom/qcom_scm-smc.c               |   30 +-
 drivers/firmware/qcom/qcom_scm.c                   |  197 +++-
 drivers/firmware/qcom/qcom_scm.h                   |    9 +
 drivers/firmware/qcom/qcom_tzmem.c                 |  469 +++++++++
 drivers/firmware/qcom/qcom_tzmem.h                 |   13 +
 drivers/firmware/ti_sci.h                          |    2 +-
 drivers/firmware/turris-mox-rwtm.c                 |   23 +-
 drivers/firmware/xilinx/zynqmp.c                   |    3 -
 drivers/memory/Kconfig                             |    2 +-
 drivers/mtd/nand/raw/Kconfig                       |    3 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |    8 +-
 drivers/platform/Kconfig                           |    2 +
 drivers/platform/Makefile                          |    1 +
 drivers/platform/cznic/Kconfig                     |   50 +
 drivers/platform/cznic/Makefile                    |    8 +
 drivers/platform/cznic/turris-omnia-mcu-base.c     |  408 ++++++++
 drivers/platform/cznic/turris-omnia-mcu-gpio.c     | 1095 +++++++++++++=
+++++++
 .../cznic/turris-omnia-mcu-sys-off-wakeup.c        |  260 +++++
 drivers/platform/cznic/turris-omnia-mcu-trng.c     |  103 ++
 drivers/platform/cznic/turris-omnia-mcu-watchdog.c |  130 +++
 drivers/platform/cznic/turris-omnia-mcu.h          |  194 ++++
 drivers/regulator/core.c                           |   28 +
 drivers/reset/Kconfig                              |   14 +
 drivers/reset/Makefile                             |    7 +-
 drivers/reset/reset-imx8mp-audiomix.c              |  128 +++
 drivers/reset/reset-meson-audio-arb.c              |    9 +-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c            |   63 +-
 drivers/reset/sti/Kconfig                          |    4 +-
 drivers/reset/tegra/Kconfig                        |    3 +-
 drivers/soc/amlogic/meson-clk-measure.c            |    1 +
 drivers/soc/amlogic/meson-gx-socinfo.c             |    2 +
 drivers/soc/imx/soc-imx8m.c                        |    1 +
 drivers/soc/ixp4xx/ixp4xx-npe.c                    |    1 +
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                   |    1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c             |   35 +
 drivers/soc/mediatek/mtk-mmsys.c                   |    1 +
 drivers/soc/mediatek/mtk-mutex.c                   |    1 +
 drivers/soc/qcom/Kconfig                           |   18 +
 drivers/soc/qcom/Makefile                          |    2 +
 drivers/soc/qcom/icc-bwmon.c                       |   16 +-
 drivers/soc/qcom/llcc-qcom.c                       |   57 +-
 drivers/soc/qcom/mdt_loader.c                      |    6 +-
 drivers/soc/qcom/ocmem.c                           |   10 +-
 drivers/soc/qcom/pdr_interface.c                   |   46 +-
 drivers/soc/qcom/pdr_internal.h                    |  318 +-----
 drivers/soc/qcom/pmic_glink.c                      |   13 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |    2 +-
 drivers/soc/qcom/qcom_pd_mapper.c                  |  677 ++++++++++++
 drivers/soc/qcom/qcom_pdr_msg.c                    |  353 +++++++
 drivers/soc/qcom/rpmh-rsc.c                        |    7 +-
 drivers/soc/qcom/rpmh.c                            |    1 -
 drivers/soc/qcom/smem.c                            |   33 +
 drivers/soc/qcom/smp2p.c                           |   11 +-
 drivers/soc/qcom/smsm.c                            |   51 +-
 drivers/soc/qcom/socinfo.c                         |   14 +-
 drivers/soc/qcom/spm.c                             |    1 +
 drivers/soc/qcom/wcnss_ctrl.c                      |   11 +-
 drivers/soc/samsung/exynos-pmu.c                   |   22 +-
 drivers/soc/sunxi/sunxi_sram.c                     |    4 +-
 drivers/soc/tegra/pmc.c                            |    8 +-
 drivers/soc/ti/k3-socinfo.c                        |    2 +-
 drivers/soc/ti/knav_qmss.h                         |    2 +-
 drivers/soc/ti/knav_qmss_acc.c                     |    2 +-
 drivers/soc/ti/knav_qmss_queue.c                   |    2 +-
 drivers/soc/ti/pm33xx.c                            |    4 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |   16 +-
 drivers/soc/xilinx/zynqmp_power.c                  |  155 ++-
 drivers/tee/optee/notif.c                          |    9 +-
 drivers/tee/optee/optee_private.h                  |    5 +-
 drivers/tee/optee/optee_rpc_cmd.h                  |    1 +
 drivers/tee/optee/rpc.c                            |   10 +-
 include/clocksource/timer-xilinx.h                 |    2 +-
 include/dt-bindings/arm/qcom,ids.h                 |    2 +
 include/linux/firmware/qcom/qcom_qseecom.h         |    8 +-
 include/linux/firmware/qcom/qcom_scm.h             |   37 +-
 include/linux/firmware/qcom/qcom_tzmem.h           |   56 +
 include/linux/firmware/xlnx-event-manager.h        |   10 +
 include/linux/firmware/xlnx-zynqmp.h               |    3 +
 include/linux/regulator/consumer.h                 |    7 +
 include/linux/soc/mediatek/mtk-cmdq.h              |   42 +
 include/linux/soc/qcom/llcc-qcom.h                 |    4 +-
 include/linux/soc/qcom/smem.h                      |    1 +
 include/linux/soc/qcom/socinfo.h                   |   34 +
 include/linux/soc/samsung/exynos-regs-pmu.h        |    4 +
 include/linux/turris-omnia-mcu-interface.h         |  249 +++++
 125 files changed, 6025 insertions(+), 847 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-turr=
is-omnia-mcu
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8=
100-starlink-cache.yaml
 create mode 100644 Documentation/devicetree/bindings/firmware/cznic,tur=
ris-omnia-mcu.yaml
 rename Documentation/devicetree/bindings/{mfd =3D> soc/ti}/ti,j721e-sys=
tem-controller.yaml (96%)
 create mode 100644 drivers/cache/starfive_starlink_cache.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
 create mode 100644 drivers/platform/cznic/Kconfig
 create mode 100644 drivers/platform/cznic/Makefile
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-base.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-gpio.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-sys-off-wake=
up.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-trng.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu-watchdog.c
 create mode 100644 drivers/platform/cznic/turris-omnia-mcu.h
 create mode 100644 drivers/reset/reset-imx8mp-audiomix.c
 create mode 100644 drivers/soc/qcom/qcom_pd_mapper.c
 create mode 100644 drivers/soc/qcom/qcom_pdr_msg.c
 create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
 create mode 100644 include/linux/turris-omnia-mcu-interface.h

