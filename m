Return-Path: <linux-kernel+bounces-395626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8C9BC0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1913E1C220DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97481FDF8C;
	Mon,  4 Nov 2024 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VTldCUix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cw+xHxVN"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5B1F7553
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758731; cv=none; b=KA4/QEzznzJzLjsVa65E9YPqNm658smStNmpm0AUbHxvRMt0mwFvoL1AzYeqMQo4o5K69Rbj55JZx4SaIuezSLddhc6atqMw/FDVpVOkxXmnMFpGKM9zztA8gEWamAwVR1aMW7MZYLBy9+kNeD+cqtP8A+Vo4lfENn+E15v9WVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758731; c=relaxed/simple;
	bh=aitZVY0fli6pGkFdb7pWjVGFhPMk5wPLlGVRR4T8IyM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=TKONPT4Oz3F47Q7u37rZCbteIgMRzTPeiZlDzWajZgxSmF0kCIgP5RiHCT4/wDMp79j2rrFLN+xg7V2gSPrjzGSSAcRHfQxZOX91iIwGXpzbM3LvTLEwEPOIVnhpi93uoqaAXSZOTuHbcXEy0Z1lLyG9QM+Tmxja9muMPm4del0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VTldCUix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cw+xHxVN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BF92114016F;
	Mon,  4 Nov 2024 17:18:47 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 04 Nov 2024 17:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1730758727; x=1730845127; bh=cg
	0BPd0OUFq0AFN/1eEIuwd5vYHx5Ji//4+whvquc5Y=; b=VTldCUixq9+OtHRy03
	/RyWRoGiylSD/npwiIvO7ngUXwLxJT2h5B0tROhw2TDtXaZywebAaL135ad8ZRUG
	m193oI0pDB1y7lZlZvLvQOdR3cwfB3X0V5wX6SHmcGpX94l7oCrD2QyyRIfrWmYs
	xu6saqieaF3onI1nLtD7zUFx5EBNw0ZnGd+QTXXLqS+GV4FytsC9LionG5vUwBOS
	NIWd1cRV+/+anWt0ldLi5cpRh4JJABJxaffZkOfIYuWIWSxuSoffO2vKmOqoYZng
	6KGAasgJYN2ma8sU/67mdyCh3jhVPJu/sWGFJ3eHuV6Kaz/soo0yzpgX2vbGjDmR
	Lh6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730758727; x=1730845127; bh=cg0BPd0OUFq0AFN/1eEIuwd5vYHx
	5Ji//4+whvquc5Y=; b=Cw+xHxVNJjnvCleATY5JdAJfOqei6o367MslmKmqul+E
	Dodr/Ri2sMWo77ZgP9etVb9DKAtMKp/UpDrgidOCoYK0m6OJC25d8NRpF/pWCeZo
	j9Ssa1n+lUEaqU8a1H0X2Bhhsr4WsjJRGx03gPZ3O7Bb+1nSoMu6JtI7BNGEFsUO
	+qnHH/RHTmcvq7rQcuhowvVTmck+KKpxZEl6PUhObIKdNQJmmHYwce6m86s+Cw3D
	jQUdEnAoDHOQTf1TNWOKwnhcmrJd49yK5th/uOc4/e3AoREmacXauSIAJ+FjX0pZ
	R77ZpjV9QZG63Fl9TPprc0oOTjcvllvc4idNSA1wMQ==
X-ME-Sender: <xms:RkgpZ8c9NurL7lIUmSQvzaX0az9LjEStYXFHBAGw1UllQwZoCrkxcw>
    <xme:RkgpZ-MzA0JXA_7iFYO8y1ZL-2Ui5bHyMrwENVFFM7JxJTu62haVSfxZUD1G8-Xjc
    2g2Z2ISj0LUdJio3zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeejhffguefgvddvgeffieefgfelfeekheejfeetieei
    ledvleegleekhfdthedtheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RkgpZ9hhn6Ip_cX_Ppa7QsxVkaHEtNk_6T8oCkQ8n6vbteZQGvrJOA>
    <xmx:RkgpZx8lyDfpR8ORO7nrAE_E2BqZnT-i_UXf203-RJxeS9MAc_fv2w>
    <xmx:RkgpZ4tsaejwS8eiFNo6q6aDRefVs-2Onw2NkhIop9_LjIGx6qCgjA>
    <xmx:RkgpZ4G1csd3QCum4xc7lDBJAFxOIRVaSxDfqYXcl-0I7t1MVXrg4Q>
    <xmx:R0gpZ0Lq0TTAODdXl1qzui0UP8LAyjmrqh9FSg7rfgbbSdCA537cEpT1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B81B32220072; Mon,  4 Nov 2024 17:18:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Nov 2024 23:18:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <89b2c3f7-2740-4d85-b17b-ff7cb30c38a6@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.12, part 2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600=
924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-f=
ixes-6.12-2

for you to fetch changes up to bbfbb57958635912ba472925622f2bb0bab5f06c:

  Merge tag 'qcom-drivers-fixes-for-6.12' of https://git.kernel.org/pub/=
scm/linux/kernel/git/qcom/linux into arm/fixes (2024-11-04 14:23:09 +010=
0)

----------------------------------------------------------------
soc: fixes for 6.12, part 2

Where the last set of fixes was mostly drivers, this time the devicetree
changes all come at once, targeting mostly the Rockchips, Qualcomm and
NXP platforms.

The Qualcomm bugfixes target the Snapdragon X Elite laptops, specifically
problems with PCIe and NVMe support to improve reliability, and a boot
regresion on msm8939. Also for Snapdragon platforms, there are a number
of correctness changes in the several platform specific device drivers,
but none of these are as impactful.

On the NXP i.MX platform, the fixes are all for 64-bit i.MX8 variants,
correcting individual entries in the devicetree that were incorrect and
causing the media, video, mmc and spi drivers to misbehave in minor
ways.

The Arm SCMI firmware driver gets fixes for a use-after-free bug and
for correctly parsing firmware information.

On the RISC-V side, there are three minor devicetree fixes for starfive
and sophgo, again addressing only minor mistakes. One device driver
patch fixes a problem with spurious interrupt handling.

----------------------------------------------------------------
Abel Vesa (2):
      arm64: dts: qcom: x1e80100: Add Broadcast_AND region in LLCC block
      arm64: dts: qcom: x1e80100: Fix PCIe 6a lanes description

Alexander Stein (1):
      arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs

Arnd Bergmann (8):
      Merge tag 'imx-fixes-6.12' of https://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into HEAD
      Merge tag 'riscv-sophgo-dt-fixes-for-v6.12-rc1' of https://github.=
com/sophgo/linux into HEAD
      Merge tag 'v6.12-rockchip-dtsfixes1' of https://git.kernel.org/pub=
/scm/linux/kernel/git/mmind/linux-rockchip into HEAD
      Merge tag 'riscv-soc-fixes-for-v6.12-rc6' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/conor/linux into HEAD
      Merge tag 'scmi-fixes-6.12-2' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into HEAD
      Merge tag 'qcom-arm64-fixes-for-6.12' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/qcom/linux into HEAD
      Merge tag 'qcom-arm64-fixes-for-6.12-2' of https://git.kernel.org/=
pub/scm/linux/kernel/git/qcom/linux into HEAD
      Merge tag 'qcom-drivers-fixes-for-6.12' of https://git.kernel.org/=
pub/scm/linux/kernel/git/qcom/linux into arm/fixes

Bartosz Golaszewski (1):
      firmware: qcom: scm: fix a NULL-pointer dereference

Bjorn Andersson (2):
      rpmsg: glink: Handle rejected intent request better
      soc: qcom: pmic_glink: Handle GLINK intent allocation rejections

Charles Han (1):
      soc: qcom: Add check devm_kasprintf() returned value

Conor Dooley (3):
      firmware: microchip: auto-update: fix poll_complete() to not repor=
t spurious timeout errors
      riscv: dts: starfive: disable unused csi/camss nodes
      MAINTAINERS: invert Misc RISC-V SoC Support's pattern

Cristian Ciocaltea (1):
      arm64: dts: rockchip: Drop invalid clock-names from es8388 codec n=
odes

Cristian Marussi (3):
      firmware: arm_scmi: Reject clear channel request on A2P
      dt-bindings: firmware: arm,scmi: Add missing vendor string
      firmware: arm_scmi: Use vendor string in max-rx-timeout-ms

Diederik de Haas (4):
      arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
      arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
      arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
      arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes

Diogo Silva (1):
      arm64: dts: imx8: Fix lvds0 device tree

Dmitry Baryshkov (1):
      arm64: dts: qcom: sm8450 fix PIPE clock specification for pcie1

Dragan Simic (2):
      arm64: dts: rockchip: Move L3 cache outside CPUs in RK3588(S) SoC =
dtsi
      arm64: dts: rockchip: Start cooling maps numbering from zero on RO=
CK 5B

E Shattow (1):
      riscv: dts: starfive: Update ethernet phy0 delay parameter values =
for Star64

Fabien Parent (1):
      arm64: dts: qcom: msm8939: revert use of APCS mbox for RPM

Geert Uytterhoeven (2):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-eaidk-=
610
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphi=
re-excavator

Haibo Chen (1):
      arm64: dts: imx8ulp: correct the flexspi compatible string

Heiko Stuebner (13):
      arm64: dts: rockchip: fix i2c2 pinctrl-names property on anbernic-=
rg353p/v
      arm64: dts: rockchip: Drop regulator-init-microvolt from two boards
      arm64: dts: rockchip: Fix bluetooth properties on rk3566 box demo
      arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
      arm64: dts: rockchip: Remove undocumented supports-emmc property
      arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma =
lion
      arm64: dts: rockchip: Fix LED triggers on rk3308-roc-cc
      arm64: dts: rockchip: remove num-slots property from rk3328-nanopi=
-r2s-plus
      arm64: dts: rockchip: remove orphaned pinctrl-names from pinephone=
 pro
      ARM: dts: rockchip: fix rk3036 acodec node
      ARM: dts: rockchip: drop grf reference from rk3036 hdmi
      ARM: dts: rockchip: Fix the spi controller on rk3036
      ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin

Johan Hovold (11):
      arm64: dts: qcom: x1e80100: fix PCIe4 and PCIe6a PHY clocks
      arm64: dts: qcom: x1e80100: fix PCIe5 PHY clocks
      firmware: qcom: scm: suppress download mode error
      arm64: dts: qcom: x1e78100-t14s: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100-crd: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100-vivobook-s15: fix nvme regulator boot g=
litch
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix nvme regulator boot gl=
itch
      arm64: dts: qcom: x1e80100-microsoft-romulus: fix nvme regulator b=
oot glitch
      arm64: dts: qcom: x1e80100-qcp: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100: fix PCIe4 interconnect
      arm64: dts: qcom: x1e80100: fix PCIe5 interconnect

Konrad Dybcio (1):
      arm64: dts: qcom: x1e80100: Fix up BAR spaces

Liu Ying (1):
      arm64: dts: imx8mp-skov-revb-mi1010ait-1cp1: Assign "media_isp" cl=
ock rate

Manikanta Mylavarapu (1):
      soc: qcom: socinfo: fix revision check in qcom_socinfo_probe()

Marek Vasut (1):
      arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1 frequency to 50=
6.8 MHz

Maya Matuszczyk (1):
      arm64: dts: qcom: x1e80100-crd Rename "Twitter" to "Tweeter"

Peng Fan (1):
      arm64: dts: imx8mp: correct sdhc ipg clk

Qingqing Zhou (1):
      firmware: qcom: scm: Return -EOPNOTSUPP for unsupported SHM bridge=
 enabling

Rajendra Nayak (1):
      EDAC/qcom: Make irq configuration optional

Sam Edwards (1):
      arm64: dts: rockchip: Designate Turing RK1's system power controll=
er

Simon Horman (1):
      MAINTAINERS: Qualcomm SoC: Match reserved-memory bindings

Uwe Kleine-K=C3=B6nig (1):
      riscv: dts: Replace deprecated snps,nr-gpios property for snps,dw-=
apb-gpio-port devices

Xinqi Zhang (1):
      firmware: arm_scmi: Fix slab-use-after-free in scmi_bus_notifier()

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  2 +-
 MAINTAINERS                                        | 12 ++---
 arch/arm/boot/dts/rockchip/rk3036-kylin.dts        |  4 +-
 arch/arm/boot/dts/rockchip/rk3036.dtsi             | 14 +++---
 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi   | 12 ++---
 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi     |  4 +-
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 12 +++++
 .../freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts  |  1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  6 +--
 arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi  |  8 ++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  2 +-
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     |  2 +
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   |  2 +
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          | 10 ++--
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  2 +
 .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  |  2 +
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          |  2 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 53 +++++++++++++--=
-------
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    |  1 -
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |  4 +-
 .../boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts   |  2 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  3 +-
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      |  1 -
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts  |  2 +-
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     |  2 -
 .../arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |  2 +-
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |  2 +-
 .../boot/dts/rockchip/rk3566-anbernic-rg353p.dts   |  2 +-
 .../boot/dts/rockchip/rk3566-anbernic-rg353v.dts   |  2 +-
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts   |  6 +--
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  |  6 +--
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts     |  3 --
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 20 ++++----
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   |  1 -
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  4 +-
 .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |  1 -
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |  1 +
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  |  1 -
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             |  6 +--
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |  2 -
 .../boot/dts/starfive/jh7110-pine64-star64.dts     |  3 +-
 drivers/edac/qcom_edac.c                           |  8 ++--
 drivers/firmware/arm_scmi/bus.c                    |  7 +--
 drivers/firmware/arm_scmi/common.h                 |  2 +
 drivers/firmware/arm_scmi/driver.c                 | 10 +++-
 drivers/firmware/microchip/mpfs-auto-update.c      | 42 +++------------=
--
 drivers/firmware/qcom/qcom_scm.c                   | 17 +++++--
 drivers/rpmsg/qcom_glink_native.c                  | 10 ++--
 drivers/soc/qcom/llcc-qcom.c                       |  3 ++
 drivers/soc/qcom/pmic_glink.c                      | 25 ++++++++--
 drivers/soc/qcom/socinfo.c                         |  8 +++-
 include/linux/soc/qcom/llcc-qcom.h                 |  2 +
 59 files changed, 213 insertions(+), 158 deletions(-)

