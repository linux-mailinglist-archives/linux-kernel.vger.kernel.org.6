Return-Path: <linux-kernel+bounces-330916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D4197A60F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3AA1C26D69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A01B5AA;
	Mon, 16 Sep 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nxuFFmEk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxNXyCX6"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBFE17753
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504368; cv=none; b=ew8ahfvCeAFUCEYqM86M4me+799nkBL+QNiXM+lx6pnSriTy9nQVwJL+G47q/Fq8p8WG65zRRxbPI5RHwNrYEECcg3MlQlqyH6sQsTlosaITFLQapRgjOGzgNyvTZl0MmOhbgCUJDFP5fW1oYygEZgVW5XOp9HBSc0ZBjxTkrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504368; c=relaxed/simple;
	bh=MF4s/lNdFzvA/+8RVrZGRMqrabeAS2P0MAgiJBUZLig=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AHHo4MT1cFL3AsK2xqI/hKM0X1LudQ+EjGlphP8teiAmMeP//9JRjddnnI58oKfnvwd2azn3Q2DepQnyWK9oISSqv7ISo/w8IGngagK8NOSvGXyEXGuXFq6dVGZBGeK12XpFGEJrf0hwIZVP/V2P3pMuo9aWye+JlboXcxXs9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nxuFFmEk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxNXyCX6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58FDD1140193;
	Mon, 16 Sep 2024 12:32:45 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 12:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726504365;
	 x=1726590765; bh=8RP0FW//mvPeDdQFY2BUjXlSRAxK7/F7viwRwGbc9Nw=; b=
	nxuFFmEkFmTmggCptLO7hL1DgobS4Ya4ta5dE5Y2MUdFI41EJUTrhpkwATcLKGGP
	gBDvqxJp8DUwsCtFnGbZw0OLHPsDfEUslDbpsk1LyW+Xtw6+EwAt0/6nSJxWoqSy
	R5PPlXHZsAkKPUz31L2363GqW+mbNsuYaljt1KSqof+JS/yLACkZsr+BJh7kJ8l3
	GJdAbUNCsaUQ2FA1wRT/EexrtcWmNsqNBC9X3ES2+SGbB72XC8VKg3FlG8fMze2/
	R+eYqO6GNFGPfaHTBA//yHeyRLesrBKnP7sAGr5CooeUz6bVBVLYuveeyLRM/ijG
	E4XG2UJaONDom0imm1xhaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726504365; x=
	1726590765; bh=8RP0FW//mvPeDdQFY2BUjXlSRAxK7/F7viwRwGbc9Nw=; b=l
	xNXyCX6JKbqeBDswchsXM20FnyQOFala2ea7imgPC1g3mG9HUEwE8EVSc/Jkd8EW
	yL/8ByN2CdwwKgKO42Xppdfp8P1GkpITKreBK6MWhN7sB1RmunQaUKKhm75GjXkh
	NwrfclI7j0DEiyv4tgxd4I3vrGAWCWTw/CviD52ts71rZN1cSEJESs5fY2nxQa0Q
	L0fKqdwQgNqpyMfpnkdVI+v7hwV/BIrgy397MDaG106qV6FsSTi4TPTIBWXRijri
	sM8/L1JwvyeWKnydvrTnfRpHn6h8aHNfS/2yypjIL5gBIWQbP358dm9JuHTzxBkU
	JieOWKuRCOWobg1/dhKLQ==
X-ME-Sender: <xms:rV3oZlVlpOL594nW64Z07E2lozXDquqXCxqQsl90_26d5mF9cANZ3Q>
    <xme:rV3oZlmfW5vLwhDJFRB491cmCHACX5Ib_ar8ieipqWi136Hp2FX0eLrbVxFAhz8wg
    ctW1mFDWeyNBVUGSd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeejfefhleeigfevudekleekkeeujeeutdeigefg
    veektdejieffudegtdejueelueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhdpphgvnhhguhhtrhhonhhigidruggvnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhotges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgv
    lheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rV3oZhYnmYIbph6GwH6dUZtOIdaimYX8UVGlGDIWXv46hf7e9NvnMw>
    <xmx:rV3oZoXUfpXgrEcg3USp0zkYEJxbxfqDUZ6ULcEGRL8TGLRfdAJvLA>
    <xmx:rV3oZvm-zxawT9d14XLLmpUO7O2SgNsj3LxhGm_tP3KuS51j5AnR9A>
    <xmx:rV3oZleiethF6M1B0Al9J9ivQAe_XyEdlB9FRa-KZdo37-240RjSAg>
    <xmx:rV3oZthb3ndppRWzavPMBtbhmZ4fvIcB_CQJ8jkufr1Pe-y-fwBk-nap>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F32B2222006F; Mon, 16 Sep 2024 12:32:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 16:32:23 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <8253b661-af65-48ea-8630-24e4b722ad58@app.fastmail.com>
In-Reply-To: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com>
References: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com>
Subject:  [GIT PULL 2/4] soc: driver updates for 6.12
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208=
399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.12

for you to fetch changes up to b62800736f61521547d50fd8cc332cf9b74cbaff:

  Merge tag 'memory-controller-drv-6.12-2' of https://git.kernel.org/pub=
/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers (2024-09-11 0=
9:46:31 +0000)

----------------------------------------------------------------
soc: driver updates for 6.12

The driver updates seem larger this time around, with changes
is many of the SoC specific drivers, both the custom drivers/soc
ones and the closely related subsystems (memory, bus, firmware,
reset, ...).

The at91 platform gains support for sam9x7 chips in the soc and
power management code. This is the latest variant of one of the
oldest still supported SoC families, using the ARM9 (ARMv5) core.

As usual, the qualcomm snapdragon platform gets a ton of updates in many
of their drivers to add more features and additional SoC support. Most
of these are somewhat firmware related as the platform has a number of
firmware based interfaces to the kernel. A notable addition here is the
inclusion of trace events to two of these drivers.

Herve Codina and Christophe Leroy are now sending updates for
drivers/soc/fsl/ code through the SoC tree, this contains both PowerPC
and Arm specific platforms and has previously been problematic to
maintain. The first update here contains support for newer PowerPC
variants and some cleanups.

The turris mox firmware driver has a number of updates, mostly cleanups.

The Arm SCMI firmware driver gets a major rework to modularize
the existing code into separately loadable drivers for the various
transports, the addition of custom NXP i.MX9 interfaces and a
number of smaller updates.

The Arm FF-A firmware driver gets a feature update to support
the v1.2 version of the specification.

The reset controller drivers have some smaller cleanups and a newly
added driver for the Intel/Mobileye EyeQ5/EyeQ6 MIPS SoCs.

The memory controller drivers get some cleanups and refactoring
for Tegra, TI, Freescale/NXP and a couple more platforms.

Finally there are lots of minor updates to firmware (raspberry pi,
tegra, imx), bus (sunxi, omap, tegra) and soc (rockchips, tegra, amlogic,
mediatek) drivers and their DT bindings.

----------------------------------------------------------------
Aakarsh Jain (1):
      dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt binding

Alex Bee (1):
      soc: rockchip: grf: Set RK3128's vpu main clock

AngeloGioacchino Del Regno (1):
      soc: mediatek: mtk-mutex: Reduce type size for mtk_mutex_data memb=
ers

Arnd Bergmann (23):
      Merge tag 'samsung-drivers-6.12' of https://git.kernel.org/pub/scm=
/linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.12' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'v6.12-rockchip-drivers-1' of https://git.kernel.org/pub=
/scm/linux/kernel/git/mmind/linux-rockchip into soc/drivers
      Merge tag 'versatile-soc-for-v6.12' of https://git.kernel.org/pub/=
scm/linux/kernel/git/linusw/linux-integrator into soc/drivers
      Merge tag 'ffa-updates-6.12' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'scmi-updates-6.12' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'tegra-for-6.12-soc' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.12-firmware' of https://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'soc_fsl-6.12-2' of https://github.com/chleroy/linux int=
o soc/drivers
      Merge tag 'ti-driver-soc-for-v6.12' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'integrator-v6.12' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/linusw/linux-integrator into soc/drivers
      Merge tag 'reset-for-v6.12' of git://git.pengutronix.de/pza/linux =
into soc/drivers
      Merge tag 'imx-drivers-6.12' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'omap-for-v6.12/drivers-signed' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/khilman/linux-omap into soc/drivers
      Merge tag 'at91-soc-6.12' of https://git.kernel.org/pub/scm/linux/=
kernel/git/at91/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.12' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.12' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'sunxi-drivers-for-6.12' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/sunxi/linux into soc/drivers
      firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()
      Merge tag 'v6.11-next-soc' of https://git.kernel.org/pub/scm/linux=
/kernel/git/mediatek/linux into soc/drivers
      Merge tag 'v6.12-rockchip-drivers-2' of https://git.kernel.org/pub=
/scm/linux/kernel/git/mmind/linux-rockchip into soc/drivers
      Merge tag 'arm-soc/for-6.12/drivers' of https://github.com/Broadco=
m/stblinux into soc/drivers
      Merge tag 'memory-controller-drv-6.12-2' of https://git.kernel.org=
/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers

Bartosz Golaszewski (4):
      memory: ti-aemif: remove platform data support
      memory: ti-aemif: use devm_clk_get_enabled() and shrink the code
      memory: ti-aemif: don't needlessly iterate over child nodes
      memory: ti-aemif: Revert "memory: ti-aemif: don't needlessly itera=
te over child nodes"

Biju Das (1):
      memory: renesas-rpc-if: Use Hi-Z state as the default setting for =
IOVF pins

Bjorn Andersson (1):
      Merge branch 'drivers-fixes-for-6.11' into HEAD

Christophe JAILLET (4):
      soc: mediatek: pwrap: Constify struct pmic_wrapper_type
      soc: mediatek: pwrap: Constify some struct int[]
      soc: mediatek: pwrap: Use devm_clk_bulk_get_all_enable()
      soc: ti: k3-ringacc: Constify struct k3_ring_ops

Christophe Leroy (2):
      Merge branch 'support-for-quicc-engine-tsa-and-qmc'
      soc: fsl: cpm1: qmc: Fix dependency on fsl_soc.h

Cl=C3=A9ment L=C3=A9ger (1):
      reset: core: add get_device()/put_device on rcdev

Cristian Marussi (11):
      firmware: arm_scmi: Fix double free in OPTEE transport
      firmware: arm_scmi: Introduce packet handling helpers
      firmware: arm_scmi: Add support for standalone transport drivers
      firmware: arm_scmi: Make MBOX transport a standalone driver
      firmware: arm_scmi: Make SMC transport a standalone driver
      firmware: arm_scmi: Make OPTEE transport a standalone driver
      firmware: arm_scmi: Make VirtIO transport a standalone driver
      firmware: arm_scmi: Remove legacy transport-layer code
      firmware: arm_scmi: Update various protocols versions
      firmware: arm_scmi: Remove const from transport descriptors
      firmware: arm_scmi: Use max-rx-timeout-ms from devicetree

Dan Carpenter (1):
      platform: cznic: turris-omnia-mcu: Fix error check in omnia_mcu_re=
gister_trng()

Danila Tikhonov (4):
      dt-bindings: arm: qcom,ids: Add IDs for SM7325 family
      soc: qcom: socinfo: Add Soc IDs for SM7325 family
      soc: qcom: pd_mapper: Add SM7325 compatible
      dt-bindings: soc: qcom: qcom,pmic-glink: Document SM7325 compatible

David Wu (1):
      soc: rockchip: io-domain: Add RK3308 IO voltage domains

Detlev Casanova (3):
      dt-bindings: soc: rockchip: Add rk3576 syscon compatibles
      soc: rockchip: grf: Add rk3576 default GRF values
      dt-bindings: arm: rockchip: Add rk3576 compatible string to pmu.ya=
ml

Dhruva Gole (1):
      bus: ti-sysc: Remove excess struct member 'disable_on_idle' descri=
ption

Diogo Ivo (7):
      memory: tegra: Remove periodic compensation duplicate calls
      memory: tegra: Move DQSOSC measurement to common place
      memory: tegra: Reword and correct comments
      memory: tegra: Change macros to interpret parameter as integer
      memory: tegra: Loop update_clock_tree_delay()
      memory: tegra: Move compare/update current delay values to a funct=
ion
      memory: tegra: Rework update_clock_tree_delay()

Dmitry Baryshkov (3):
      Revert "soc: qcom: smd-rpm: Match rpmsg channel instead of compati=
ble"
      dt-bindings: soc: qcom: smd-rpm: add generic compatibles
      soc: qcom: smd-rpm: add qcom,smd-rpm compatible

Etienne Carriere (1):
      firmware: arm_scmi: Fix voltage description in failure cases

Gaosheng Cui (1):
      ARM: OMAP2+: Remove obsoleted declaration for gpmc_onenand_init

Herve Codina (37):
      soc: fsl: cpm1: qmc: Update TRNSYNC only in transparent mode
      soc: fsl: cpm1: qmc: Enable TRNSYNC only when needed
      soc: fsl: cpm1: tsa: Fix tsa_write8()
      soc: fsl: cpm1: tsa: Use BIT(), GENMASK() and FIELD_PREP() macros
      soc: fsl: cpm1: tsa: Fix blank line and spaces
      soc: fsl: cpm1: tsa: Add missing spinlock comment
      dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine (QE) TSA controller
      soc: fsl: cpm1: tsa: Remove unused registers offset definition
      soc: fsl: cpm1: tsa: Use ARRAY_SIZE() instead of hardcoded integer=
 values
      soc: fsl: cpm1: tsa: Make SIRAM entries specific to CPM1
      soc: fsl: cpm1: tsa: Introduce tsa_setup() and its CPM1 compatible=
 version
      soc: fsl: cpm1: tsa: Isolate specific CPM1 part from tsa_serial_{d=
is}connect()
      soc: fsl: cpm1: tsa: Introduce tsa_version
      soc: fsl: cpm1: tsa: Add support for QUICC Engine (QE) implementat=
ion
      MAINTAINERS: Add QE files related to the Freescale TSA controller
      soc: fsl: cpm1: tsa: Introduce tsa_serial_get_num()
      soc: fsl: cpm1: qmc: Rename QMC_TSA_MASK
      soc: fsl: cpm1: qmc: Use BIT(), GENMASK() and FIELD_PREP() macros
      soc: fsl: cpm1: qmc: Fix blank line and spaces
      soc: fsl: cpm1: qmc: Remove unneeded parenthesis
      soc: fsl: cpm1: qmc: Fix 'transmiter' typo
      soc: fsl: cpm1: qmc: Add missing spinlock comment
      dt-bindings: soc: fsl: cpm_qe: Add QUICC Engine (QE) QMC controller
      soc: fsl: cpm1: qmc: Introduce qmc_data structure
      soc: fsl: cpm1: qmc: Re-order probe() operations
      soc: fsl: cpm1: qmc: Introduce qmc_init_resource() and its CPM1 ve=
rsion
      soc: fsl: cpm1: qmc: Introduce qmc_{init,exit}_xcc() and their CPM=
1 version
      soc: fsl: cpm1: qmc: Rename qmc_chan_command()
      soc: fsl: cpm1: qmc: Handle RPACK initialization
      soc: fsl: cpm1: qmc: Rename SCC_GSMRL_MODE_QMC
      soc: fsl: cpm1: qmc: Introduce qmc_version
      soc: fsl: qe: Add resource-managed muram allocators
      soc: fsl: qe: Add missing PUSHSCHED command
      soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementat=
ion
      soc: fsl: cpm1: qmc: Handle QUICC Engine (QE) soft-qmc firmware
      MAINTAINERS: Add QE files related to the Freescale QMC controller
      soc: fsl: qe: ucc: Export ucc_mux_set_grant_tsa_bkpt

Jingyi Wang (2):
      dt-bindings: arm: qcom,ids: add SoC ID for QCS8275/QCS8300
      soc: qcom: socinfo: add QCS8275/QCS8300 SoC ID

Jinjie Ruan (1):
      soc/tegra: pmc: Simplify with scoped for each OF child loop

Jonas Karlman (1):
      dt-bindings: power: rockchip: Document RK3308 IO voltage domains

Konrad Dybcio (2):
      firmware: qcom: scm: Allow QSEECOM on ThinkPad T14s
      firmware: qcom: scm: Allow QSEECOM on Surface Laptop 7 models

Kousik Sanagavarapu (4):
      soc: ti: pruss: factor out memories setup
      soc: ti: pruss: do device_node auto cleanup
      soc: ti: knav_qmss_queue: do device_node auto cleanup
      soc: ti: pm33xx: do device_node auto cleanup

Krzysztof Kozlowski (45):
      memory: tegra186-emc: drop unused to_tegra186_emc()
      soc: qcom: apr: simplify with scoped for each OF child loop
      soc: qcom: aoss: simplify with scoped for each OF child loop
      soc: qcom: ice: use scoped device node handling to simplify error =
paths
      soc: qcom: ocmem: use scoped device node handling to simplify erro=
r paths
      soc: qcom: pbs: use scoped device node handling to simplify error =
paths
      soc: qcom: smp2p: use scoped device node handling to simplify erro=
r paths
      firmware: arm_scmi: Simplify with scoped for each OF child loop
      dt-bindings: samsung: exynos-usi: add missing constraints
      dt-bindings: memory-controllers: renesas,rpc-if: add top-level con=
straints
      memory: atmel-ebi: use scoped device node handling to simplify err=
or paths
      memory: atmel-ebi: simplify with scoped for each OF child loop
      memory: samsung: exynos5422-dmc: simplify dmc->dev usage
      memory: samsung: exynos5422-dmc: use scoped device node handling t=
o simplify error paths
      memory: stm32-fmc2-ebi: simplify with scoped for each OF child loop
      memory: stm32-fmc2-ebi: simplify with dev_err_probe()
      memory: tegra-mc: simplify with scoped for each OF child loop
      memory: tegra124-emc: simplify with scoped for each OF child loop
      memory: tegra20-emc: simplify with scoped for each OF child loop
      memory: tegra30-emc: simplify with scoped for each OF child loop
      memory: ti-aemif: simplify with dev_err_probe()
      memory: ti-aemif: simplify with scoped for each OF child loop
      memory: emif: drop unused 'irq_state' member
      memory: emif: simplify locking with guard()
      memory: omap-gpmc: simplify locking with guard()
      memory: pl172: simplify with dev_err_probe()
      memory: pl172: simplify with devm_clk_get_enabled()
      memory: pl353-smc: simplify with dev_err_probe()
      memory: pl353-smc: simplify with devm_clk_get_enabled()
      firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
      firmware: tegra: bpmp: Use scoped device node handling to simplify=
 error paths
      soc: versatile: integrator: fix OF node leak in probe() error path
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove
      soc: versatile: enable compile testing
      memory: pl172: simplify releasing AMBA regions with devm
      memory: pl353-smc: simplify with scoped for each OF child loop
      ARM: versatile: fix OF node leak in CPUs prepare
      bus: integrator-lm: fix OF node leak in probe()
      dt-bindings: reset: socionext,uniphier-glue-reset: add top-level c=
onstraints
      reset: berlin: fix OF node leak in probe() error path
      reset: k210: fix OF node leak in probe() error path
      reset: simplify locking with guard()
      reset: lpc18xx: simplify with dev_err_probe()
      reset: lpc18xx: simplify with devm_clk_get_enabled()

Lu Baolu (1):
      soc: fsl: qbman: Use iommu_paging_domain_alloc()

Luke Parkin (5):
      firmware: arm_scmi: Remove superfluous handle_to_scmi_info
      firmware: arm_scmi: Add support for debug metrics at the interface
      firmware: arm_scmi: Track basic SCMI communication debug metrics
      firmware: arm_scmi: Create debugfs files for SCMI communication de=
bug metrics
      firmware: arm_scmi: Add support to reset the debug metrics

Marek Beh=C3=BAn (16):
      firmware: turris-mox-rwtm: Use macro constant instead of hardcoded=
 4096
      firmware: turris-mox-rwtm: Use ETH_ALEN instead of hardcoded 6
      firmware: turris-mox-rwtm: Use the boolean type where appropriate
      firmware: turris-mox-rwtm: Hide signature related constants behind=
 macros
      firmware: turris-mox-rwtm: Fix driver includes
      firmware: turris-mox-rwtm: Use sysfs_emit() instead of sprintf()
      firmware: turris-mox-rwtm: Don't create own kobject type
      firmware: turris-mox-rwtm: Simplify debugfs code
      firmware: turris-mox-rwtm: Convert rest to devm_* and get rid of d=
river .remove()
      firmware: turris-mox-rwtm: Use dev_err_probe() where possible
      firmware: turris-mox-rwtm: Drop redundant device pointer
      firmware: turris-mox-rwtm: Use devm_mutex_init() instead of mutex_=
init()
      firmware: turris-mox-rwtm: Use container_of() instead of hwrng .pr=
iv member
      firmware: turris-mox-rwtm: Use EOPNOTSUPP instead of ENOSYS
      firmware: turris-mox-rwtm: Use ALIGN() instead of hardcoding
      firmware: turris-mox-rwtm: Deduplicate command execution code

Mukesh Ojha (3):
      firmware: qcom: scm: Disable SDI and write no dump to dump mode
      firmware: qcom: scm: Refactor code to support multiple dload mode
      firmware: qcom: scm: Add multiple download mode support

Peng Fan (10):
      dt-bindings: firmware: arm,scmi: Add support for system power prot=
ocol
      firmware: arm_scmi: Introduce setup_shmem_iomap
      dt-bindings: firmware: arm,scmi: Introduce property max-rx-timeout=
-ms
      dt-bindings: firmware: Add i.MX95 SCMI Extension protocol
      firmware: arm_scmi: Add NXP i.MX95 SCMI documentation
      firmware: arm_scmi: Add initial support for i.MX BBM protocol
      firmware: arm_scmi: Add initial support for i.MX MISC protocol
      firmware: imx: Add i.MX95 MISC driver
      input: keyboard: support i.MX95 BBM module
      rtc: support i.MX95 BBM RTC

Rajendra Nayak (1):
      soc: qcom: llcc: Update configuration data for x1e80100

Rob Herring (Arm) (5):
      memory: emif: Use of_property_read_bool()
      bus: ti-sysc: Use of_property_present()
      soc: ti: knav: Drop unnecessary check for property presence
      soc: ti: knav: Use of_property_read_variable_u32_array()
      dt-bindings: memory-controllers: fsl,imx-weim: Fix "fsl,weim-cs-ti=
ming" schema

Rong Qianfeng (1):
      memory: mtk-smi: Use devm_clk_get_enabled()

Shivnandan Kumar (1):
      soc: qcom: icc-bwmon: Add tracepoints in bwmon_intr_thread

Stefan Wahren (1):
      firmware: raspberrypi: Improve timeout warning

Stephan Gerhold (2):
      soc: qcom: pd_mapper: Add X1E80100
      soc: qcom: pd_mapper: Add more older platforms without domains

Sudeep Holla (10):
      firmware: arm_ffa: Some coding style fixes
      firmware: arm_ffa: Update the FF-A command list with v1.2 additions
      firmware: arm_ffa: Move the function ffa_features() earlier
      firmware: arm_ffa: Add support for FFA_PARTITION_INFO_GET_REGS
      firmware: arm_ffa: Add support for FFA_MSG_SEND_DIRECT_{REQ,RESP}2
      firmware: arm_ffa: Add support for FFA_YIELD in direct messaging
      firmware: arm_ffa: Fetch the Rx/Tx buffer size using ffa_features()
      firmware: arm_scmi: Fix trivial whitespace/coding style issues
      firmware: arm_scmi: Replace the use of of_node_put() to __free(dev=
ice_node)
      firmware: arm_scmi: Replace comma with the semicolon

Sudeepgoud Patil (1):
      soc: qcom: smp2p: Introduce tracepoint support

Th=C3=A9o Lebrun (2):
      Revert "dt-bindings: reset: mobileye,eyeq5-reset: add bindings"
      reset: eyeq: add platform driver

Varshini Rajendran (5):
      dt-bindings: atmel-sysreg: add sam9x7
      ARM: at91: pm: add support for sam9x7 SoC family
      ARM: at91: pm: add sam9x7 SoC init config
      ARM: at91: add support in SoC driver for new sam9x7
      ARM: at91: Kconfig: add config flag for SAM9X7 SoC

Wu Bo (2):
      bus: imx-weim: support compile test
      bus: imx-weim: change to use devm_clk_get_enabled() helper

Xianwei Zhao (2):
      dt-bindings: arm: amlogic: meson-gx-ao-secure: support more SoCs
      soc: amlogic: meson-gx-socinfo: add new SoCs id

Xiaolei Wang (1):
      soc: fsl: qbman: Remove redundant warnings

Zelong Dong (2):
      dt-bindings: reset: Add Amlogic T7 reset controller
      reset: reset-meson: Add support for Amlogic T7 SoC reset controller

Zhang Zekun (1):
      bus: sunxi-rsb: Simplify code with dev_err_probe()

 .mailmap                                           |   2 +
 .../arm/amlogic/amlogic,meson-gx-ao-secure.yaml    |  16 +-
 .../devicetree/bindings/arm/atmel-sysregs.txt      |   6 +-
 .../devicetree/bindings/arm/rockchip/pmu.yaml      |   2 +
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |   2 +-
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  20 +-
 .../bindings/firmware/nxp,imx95-scmi.yaml          |  43 +
 .../devicetree/bindings/media/s5p-mfc.txt          |   0
 .../memory-controllers/fsl/fsl,imx-weim.yaml       |  25 +-
 .../memory-controllers/renesas,rpc-if.yaml         |   4 +-
 .../bindings/power/rockchip-io-domain.yaml         |  24 +
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   |   2 +-
 .../bindings/remoteproc/qcom,rpm-proc.yaml         |   4 +-
 .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  43 -
 .../reset/socionext,uniphier-glue-reset.yaml       |   8 +-
 .../bindings/soc/fsl/cpm_qe/fsl,qe-tsa.yaml        | 210 +++++
 .../bindings/soc/fsl/cpm_qe/fsl,qe-ucc-qmc.yaml    | 197 +++++
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   5 +
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |  74 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |   2 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml      |  16 +
 .../bindings/soc/samsung/exynos-usi.yaml           |  15 +-
 MAINTAINERS                                        |  10 +-
 arch/arm/mach-at91/Kconfig                         |  22 +-
 arch/arm/mach-at91/Makefile                        |   1 +
 arch/arm/mach-at91/generic.h                       |   2 +
 arch/arm/mach-at91/pm.c                            |  29 +
 arch/arm/mach-at91/sam9x7.c                        |  33 +
 arch/arm/mach-versatile/platsmp-realview.c         |   1 +
 drivers/bus/Kconfig                                |   2 +-
 drivers/bus/arm-integrator-lm.c                    |   1 +
 drivers/bus/imx-weim.c                             |  14 +-
 drivers/bus/sunxi-rsb.c                            |  34 +-
 drivers/bus/ti-sysc.c                              |   7 +-
 drivers/firmware/arm_ffa/driver.c                  | 240 ++++--
 drivers/firmware/arm_scmi/Kconfig                  | 120 +--
 drivers/firmware/arm_scmi/Makefile                 |  14 +-
 drivers/firmware/arm_scmi/base.c                   |   6 +-
 drivers/firmware/arm_scmi/clock.c                  |   1 +
 drivers/firmware/arm_scmi/common.h                 | 208 +++--
 drivers/firmware/arm_scmi/driver.c                 | 241 +++---
 drivers/firmware/arm_scmi/msg.c                    |  32 +-
 drivers/firmware/arm_scmi/perf.c                   |   2 +-
 drivers/firmware/arm_scmi/pinctrl.c                |   1 +
 drivers/firmware/arm_scmi/power.c                  |   2 +-
 drivers/firmware/arm_scmi/reset.c                  |   2 +-
 drivers/firmware/arm_scmi/sensors.c                |   2 +-
 drivers/firmware/arm_scmi/shmem.c                  |  85 +-
 drivers/firmware/arm_scmi/system.c                 |   2 +-
 drivers/firmware/arm_scmi/transports/Kconfig       | 123 +++
 drivers/firmware/arm_scmi/transports/Makefile      |  16 +
 .../firmware/arm_scmi/{ =3D> transports}/mailbox.c   |  84 +-
 drivers/firmware/arm_scmi/{ =3D> transports}/optee.c | 131 ++-
 drivers/firmware/arm_scmi/{ =3D> transports}/smc.c   |  62 +-
 .../firmware/arm_scmi/{ =3D> transports}/virtio.c    | 103 +--
 drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  25 +
 drivers/firmware/arm_scmi/vendors/imx/Makefile     |   3 +
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c | 383 +++++++++
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 318 ++++++++
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst    | 886 ++++++++++++++=
+++++++
 drivers/firmware/arm_scmi/voltage.c                |   6 +-
 drivers/firmware/imx/Kconfig                       |  11 +
 drivers/firmware/imx/Makefile                      |   1 +
 drivers/firmware/imx/sm-misc.c                     | 119 +++
 drivers/firmware/qcom/Kconfig                      |  11 -
 drivers/firmware/qcom/qcom_scm-smc.c               |   2 +-
 drivers/firmware/qcom/qcom_scm.c                   |  72 +-
 drivers/firmware/qcom/qcom_tzmem.c                 |  32 +-
 drivers/firmware/raspberrypi.c                     |   3 +-
 drivers/firmware/tegra/bpmp.c                      |  20 +-
 drivers/firmware/turris-mox-rwtm.c                 | 380 ++++-----
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/imx-sm-bbm-key.c            | 225 ++++++
 drivers/memory/atmel-ebi.c                         |  35 +-
 drivers/memory/emif.c                              |  31 +-
 drivers/memory/mtk-smi.c                           |   6 +-
 drivers/memory/omap-gpmc.c                         |  24 +-
 drivers/memory/pl172.c                             |  58 +-
 drivers/memory/pl353-smc.c                         |  57 +-
 drivers/memory/renesas-rpc-if.c                    |   2 +-
 drivers/memory/samsung/exynos5422-dmc.c            |  90 +--
 drivers/memory/stm32-fmc2-ebi.c                    |  23 +-
 drivers/memory/tegra/mc.c                          |  11 +-
 drivers/memory/tegra/tegra124-emc.c                |   7 +-
 drivers/memory/tegra/tegra186-emc.c                |   5 -
 drivers/memory/tegra/tegra20-emc.c                 |   7 +-
 drivers/memory/tegra/tegra210-emc-cc-r21021.c      | 429 ++--------
 drivers/memory/tegra/tegra30-emc.c                 |   7 +-
 drivers/memory/ti-aemif.c                          |  74 +-
 drivers/platform/cznic/turris-omnia-mcu-trng.c     |   4 +-
 drivers/reset/Kconfig                              |  13 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  17 +-
 drivers/reset/reset-berlin.c                       |   3 +-
 drivers/reset/reset-eyeq.c                         | 570 +++++++++++++
 drivers/reset/reset-k210.c                         |   3 +-
 drivers/reset/reset-lpc18xx.c                      |  43 +-
 drivers/reset/reset-meson.c                        |   6 +
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-imx-sm-bbm.c                       | 162 ++++
 drivers/soc/Makefile                               |   2 +-
 drivers/soc/amlogic/meson-gx-socinfo.c             |  10 +
 drivers/soc/atmel/soc.c                            |  23 +
 drivers/soc/atmel/soc.h                            |   9 +
 drivers/soc/fsl/qbman/qman_ccsr.c                  |   2 -
 drivers/soc/fsl/qbman/qman_portal.c                |   5 +-
 drivers/soc/fsl/qe/Kconfig                         |  17 +-
 drivers/soc/fsl/qe/qe_common.c                     |  80 ++
 drivers/soc/fsl/qe/qmc.c                           | 667 ++++++++++++--=
--
 drivers/soc/fsl/qe/tsa.c                           | 659 +++++++++++----
 drivers/soc/fsl/qe/tsa.h                           |   3 +
 drivers/soc/fsl/qe/ucc.c                           |   1 +
 drivers/soc/mediatek/mtk-mutex.c                   |  52 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 118 +--
 drivers/soc/qcom/Kconfig                           |   2 +-
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/apr.c                             |   5 +-
 drivers/soc/qcom/cmd-db.c                          |   2 +-
 drivers/soc/qcom/icc-bwmon.c                       |   6 +-
 drivers/soc/qcom/ice.c                             |  14 +-
 drivers/soc/qcom/llcc-qcom.c                       |  32 +-
 drivers/soc/qcom/ocmem.c                           |   7 +-
 drivers/soc/qcom/qcom-pbs.c                        |  16 +-
 drivers/soc/qcom/qcom_aoss.c                       |   8 +-
 drivers/soc/qcom/qcom_pd_mapper.c                  |  17 +-
 drivers/soc/qcom/smd-rpm.c                         |  41 +-
 drivers/soc/qcom/smp2p.c                           |  25 +-
 drivers/soc/qcom/socinfo.c                         |   4 +
 drivers/soc/qcom/trace-smp2p.h                     |  98 +++
 drivers/soc/qcom/trace_icc-bwmon.h                 |  48 ++
 drivers/soc/rockchip/grf.c                         |  32 +-
 drivers/soc/rockchip/io-domain.c                   |  40 +
 drivers/soc/tegra/pmc.c                            |  12 +-
 drivers/soc/ti/k3-ringacc.c                        |  12 +-
 drivers/soc/ti/knav_dma.c                          |  22 +-
 drivers/soc/ti/knav_qmss_queue.c                   | 105 +--
 drivers/soc/ti/pm33xx.c                            |  52 +-
 drivers/soc/ti/pruss.c                             | 176 ++--
 drivers/soc/versatile/Kconfig                      |   4 +-
 drivers/soc/versatile/soc-integrator.c             |   1 +
 drivers/soc/versatile/soc-realview.c               |  20 +-
 include/dt-bindings/arm/qcom,ids.h                 |   4 +
 include/dt-bindings/soc/qe-fsl,tsa.h               |  13 +
 include/linux/arm_ffa.h                            |  12 +
 include/linux/firmware/imx/sm.h                    |  23 +
 include/linux/firmware/qcom/qcom_qseecom.h         |  45 --
 include/linux/omap-gpmc.h                          |  10 -
 include/linux/platform_data/ti-aemif.h             |  45 --
 include/linux/scmi_imx_protocol.h                  |  59 ++
 include/soc/fsl/qe/qe.h                            |  23 +-
 153 files changed, 6727 insertions(+), 2520 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/nxp,imx95=
-scmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.txt
 delete mode 100644 Documentation/devicetree/bindings/reset/mobileye,eye=
q5-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl=
,qe-tsa.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl=
,qe-ucc-qmc.yaml
 create mode 100644 arch/arm/mach-at91/sam9x7.c
 create mode 100644 drivers/firmware/arm_scmi/transports/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/transports/Makefile
 rename drivers/firmware/arm_scmi/{ =3D> transports}/mailbox.c (85%)
 rename drivers/firmware/arm_scmi/{ =3D> transports}/optee.c (89%)
 rename drivers/firmware/arm_scmi/{ =3D> transports}/smc.c (86%)
 rename drivers/firmware/arm_scmi/{ =3D> transports}/virtio.c (94%)
 create mode 100644 drivers/firmware/arm_scmi/vendors/imx/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/vendors/imx/Makefile
 create mode 100644 drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
 create mode 100644 drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
 create mode 100644 drivers/firmware/arm_scmi/vendors/imx/imx95.rst
 create mode 100644 drivers/firmware/imx/sm-misc.c
 create mode 100644 drivers/input/keyboard/imx-sm-bbm-key.c
 create mode 100644 drivers/reset/reset-eyeq.c
 create mode 100644 drivers/rtc/rtc-imx-sm-bbm.c
 create mode 100644 drivers/soc/qcom/trace-smp2p.h
 create mode 100644 drivers/soc/qcom/trace_icc-bwmon.h
 create mode 100644 include/dt-bindings/soc/qe-fsl,tsa.h
 create mode 100644 include/linux/firmware/imx/sm.h
 delete mode 100644 include/linux/platform_data/ti-aemif.h
 create mode 100644 include/linux/scmi_imx_protocol.h

