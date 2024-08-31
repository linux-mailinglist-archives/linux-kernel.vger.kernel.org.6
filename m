Return-Path: <linux-kernel+bounces-309811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26579670AC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E511C21615
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E7017B427;
	Sat, 31 Aug 2024 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mmPwsava";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EiH1GVer"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862217BB14
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098635; cv=none; b=iRzwZkI4StGjwAPAWPpLGbPjtQpsxU3kav0JmWiu7wQ+0udlEWY9X7NqawQX7F1Rw97/d87gJOPAJrPZpasEy0hIAMdj/SF0MgcOL3NR2RqO3y6Jg2MvqZqV0KhGgSX1V0WjNUL/RzwCMV7j5YR5bTDmSnS77nroBBpLsVw7Rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098635; c=relaxed/simple;
	bh=VyDxQrmoiDwvSz7iiXS8JSv8DrCiJHTSCWOmCuzMHbk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=WlJGpD8U31pBfmbgs+1p/oPhT4zUEP3F/PDvA8+9HAho72akq5y9E4A2UnBtSZNpUPHQ4vqcSp/yKFvrgGlZf1f5SAtzCJ5SxsOOph0/Cr3EhxqQUKO/cc4l7w666n57YMlSqB21hG5K/5sjbQV5udj+nC5RApwhKCi1Aptg4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mmPwsava; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EiH1GVer; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id DA0F31380391;
	Sat, 31 Aug 2024 06:03:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Sat, 31 Aug 2024 06:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1725098631; x=1725185031; bh=gr
	Bm3VWDHfZ6kUekZLI7L2+qgvjgpsfAHWJtdbs7jQA=; b=mmPwsava583znpSZCT
	a9eKDadecrQ8J2CUoJuEwy6qm+OWofTUTDmpQUwhZXkAQeJKqVl0RdHXAU+ouQqD
	VI2+RbDdCC0/4nDxU7HgMPSOTGxiz8USPB/qlOuc86+Qqm9tm+ERH30Melc41/Uy
	AMOGmOyGWq9VFTK6ocJp6QU80/9MJrxC1ytxj/lwCA/Avq4dEE8lk685dlZERw2E
	QbhYyUrCobyZdSVh6E+vkUr+inWv5E0TZZw48DZUtsOQgXVcFujyb9k1xnSQIyZ3
	t4VzY+4LVXQ0XbnDA73ScJXAEoud0jwXaNYHwa5jDnKWppN73JdX7CvhkUs8QECE
	rIMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1725098631; x=1725185031; bh=grBm3VWDHfZ6k
	UekZLI7L2+qgvjgpsfAHWJtdbs7jQA=; b=EiH1GVerDTc55ow1GSvKZyHJ4/GCx
	iG/whAIftFJu8lvd/0T+yAp33TIEW3FyU2/8BycpgNnhSvVo6ijOKbE/Hp/8Umgz
	Sjy9WymRF++S8cfAlMcKjCUSlspc7m18FT+I/IpFcvdbHye4EFUok/fa+HAJkGsL
	PrTVy0as5ub1K1JMp0Nsxymb0H9We+k70UR3r/W9k69q+JEvhrevrMIw/cgNmPom
	tSiS0pojJGeJ/q6di7YiAD3YA9sYIW/GIB9OIGcaIcNkT8lkcB37Ygi5PoYxxR3n
	/MSN46mouytElqftgSa+IWntsR+qyw5pONJ+6w406hleS4jJweKnOJajw==
X-ME-Sender: <xms:h-rSZl-Fyn7dXBxPJgDdMG6Y5DfsWv-LzEeqSM5JACc2qCEALZZXqA>
    <xme:h-rSZps_mI32-m3eiIHl_M3wZEBlFBKsnbVATUMZG9K3CQKmRSpgQCgarvkbT6SsX
    8Qu52VAz2STnUYUJeo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtqhertdertdejnecu
    hfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvg
    eqnecuggftrfgrthhtvghrnhepvdeigeeghffhhffguedvvdelvdfftdfgvdfftddvgfeg
    gefhkedtfeeutddvuefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehsohgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h-rSZjCvPBd72kN4C8hHwi7vN1TX3Za21n42jJfsCUP-Dzy5VxgtdQ>
    <xmx:h-rSZpcjX887SYlhBEg7j__H-OjsD728m0m1mtxTNLRNhu24pEs1fA>
    <xmx:h-rSZqOV88LxLayT_jG4_jFGmGYUh6xn7wZIrLz1N9koacU8F4EHsQ>
    <xmx:h-rSZrnEUae6UjvEYssqO36TKoO1wa_1JPbKUvALgYsGhggWaUjgxg>
    <xmx:h-rSZnqoHpYMryAt304a7psnX86qiZe_1DFRPXqnyx2E52jQKwuEjZ-T>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8E7F92220087; Sat, 31 Aug 2024 06:03:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 Aug 2024 10:03:51 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <a0cf5f32-3250-48de-bc04-445ae1459b0c@app.fastmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 6.11, part 2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208=
399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-f=
ixes-6.11-2

for you to fetch changes up to 9cc7b1705141d1a077493dc107ed626e8dc84681:

  Merge tag 'at91-fixes-6.11' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into arm/fixes (2024-08-30 19:52:28 +0000)

----------------------------------------------------------------
ARM: SoC fixes for 6.11, part 2

There is a fairly large number of bug fixes for Qualcomm platforms,
most of them addressing issues with the devicetree files for the
newly added Snapdragon X1 based laptops to make them more reliable.
The Qualcomm driver changes address a few build-time issues as well
as runtime problems in the tzmem and scm firmware, the USB Type-C
driver, and the cmd-db and pmic_glink soc drivers.

The NXP i.MX usually gets a bunch of devicetree fixes that is proportion=
al
to the number of supported machines. This includes both warning fixes
and correctness for the 64-bit i.MX9, i.MX8 and layerscape platforms,
as well as a single fix for a 32-bit i.MX6 based board.

The other changes are the usual minor changes, including an update to the
MAINTAINERS file, an omap3 dts file and a SoC driver for mpfs (risc-v).

----------------------------------------------------------------
Adam Ford (1):
      arm64: dts: imx8mp-beacon-kit: Fix Stereo Audio on WM8962

Andrei Simion (1):
      MAINTAINERS: Update DTS path for ARM/Microchip (AT91) SoC

Andrew Halaney (1):
      soc: qcom: pd-mapper: Depend on ARCH_QCOM || COMPILE_TEST

Arnd Bergmann (8):
      soc: qcom: pd-mapper: mark qcom_pdm_domains as __maybe_unused
      Merge tag 'omap-for-v6.11/fixes-signed' of https://git.kernel.org/=
pub/scm/linux/kernel/git/khilman/linux-omap into arm/fixes
      Merge tag 'imx-fixes-6.11' of https://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'qcom-drivers-fixes-for-6.11' of https://git.kernel.org/=
pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-arm64-defconfig-fixes-for-6.11' of https://git.ker=
nel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.11' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'riscv-soc-fixes-for-v6.11-rc6' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'at91-fixes-6.11' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/at91/linux into arm/fixes

Bartosz Golaszewski (2):
      firmware: qcom: tzmem: fix virtual-to-physical address conversion
      firmware: qcom: qseecom: remove unused functions

Bjorn Andersson (4):
      soc: qcom: pmic_glink: Fix race during initialization
      usb: typec: ucsi: Move unregister out of atomic section
      soc: qcom: pmic_glink: Actually communicate when remote goes down
      soc: qcom: pd-mapper: Fix singleton refcount

Dmitry Baryshkov (1):
      arm64: dts: qcom: disable GPU on x1e80100 by default

Frank Li (1):
      arm64: dts: imx8mm-phygate: fix typo pinctrcl-0

Johan Hovold (18):
      arm64: dts: qcom: x1e80100-crd: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100: fix PCIe domain numbers
      arm64: dts: qcom: x1e80100: add missing PCIe minimum OPP
      arm64: dts: qcom: x1e80100-crd: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-crd: disable PCIe6a perst pull down
      arm64: dts: qcom: x1e80100-crd: fix missing PCIe4 gpios
      arm64: dts: qcom: x1e80100-qcp: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100-qcp: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-qcp: disable PCIe6a perst pull down
      arm64: dts: qcom: x1e80100-qcp: fix missing PCIe4 gpios
      arm64: dts: qcom: x1e80100-vivobook-s15: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100-vivobook-s15: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-vivobook-s15: disable PCIe6a perst pull=
 down
      arm64: dts: qcom: x1e80100-vivobook-s15: fix missing PCIe4 gpios
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-yoga-slim7x: disable PCIe6a perst pull =
down
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix missing PCIe4 gpios

Konrad Dybcio (3):
      mailmap: Add an entry for Konrad Dybcio
      MAINTAINERS: Update Konrad Dybcio's email address
      arm64: dts: qcom: x1e80100: Fix Adreno SMMU global interrupt

Krzysztof Kozlowski (1):
      arm64: dts: layerscape: fix thermal node names length

Markus Niebel (2):
      arm64: dts: freescale: imx93-tqma9352: fix CMA alloc-ranges
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: fix typo

Michal Vok=C3=A1=C4=8D (1):
      ARM: dts: imx6dl-yapp43: Increase LED current to match the yapp4 H=
W design

Murali Nalajala (1):
      firmware: qcom: scm: Mark get_wq_ctx() as atomic call

Patrick Wildt (1):
      arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant

Peng Fan (2):
      arm64: dts: imx95: correct a55 power-domains
      arm64: dts: imx95: correct L3Cache cache-sets

Richard Acayan (1):
      firmware: qcom: tzmem: disable sdm670 platform

Sascha Hauer (1):
      arm64: dts: freescale: tqma9352: Fix watchdog reset

Shenwei Wang (1):
      arm64: dts: imx93: update default value for snps,clk-csr

Sicelo A. Mhlongo (1):
      ARM: dts: omap3-n900: correct the accelerometer orientation

Stephan Gerhold (2):
      arm64: defconfig: Add CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20
      arm64: dts: qcom: x1e80100-crd: Fix backlight

Steve Wilkins (1):
      firmware: microchip: fix incorrect error report of programming:tim=
eout on success

Varadarajan Narayanan (1):
      arm64: dts: qcom: ipq5332: Fix interrupt trigger type for usb

Volodymyr Babchuk (1):
      soc: qcom: cmd-db: Map shared memory as WC, not WB

 .mailmap                                           |  2 +
 MAINTAINERS                                        |  9 ++-
 .../arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi | 12 ++--
 arch/arm/boot/dts/ti/omap/omap3-n900.dts           |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  8 +--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  2 +-
 .../imx8mm-phygate-tauri-l-rs232-rs232.dtso        |  2 +-
 .../imx8mm-phygate-tauri-l-rs232-rs485.dtso        |  2 +-
 .../arm64/boot/dts/freescale/imx8mp-beacon-kit.dts | 12 ++--
 .../dts/freescale/imx93-tqma9352-mba93xxla.dts     |  2 +-
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi  |  3 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |  2 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 14 ++---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  4 +-
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   | 42 ++++++++++++-
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          | 70 +++++++++++++++=
+++----
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  | 54 ++++++++++++++-=
--
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          | 53 +++++++++++++---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 21 +++++--
 arch/arm64/configs/defconfig                       |  1 +
 drivers/firmware/microchip/mpfs-auto-update.c      |  2 +-
 drivers/firmware/qcom/qcom_scm-smc.c               |  2 +-
 drivers/firmware/qcom/qcom_tzmem.c                 | 33 ++++++----
 drivers/power/supply/qcom_battmgr.c                | 16 +++--
 drivers/soc/qcom/Kconfig                           |  2 +-
 drivers/soc/qcom/cmd-db.c                          |  2 +-
 drivers/soc/qcom/pmic_glink.c                      | 40 +++++++++----
 drivers/soc/qcom/pmic_glink_altmode.c              | 17 ++++--
 drivers/soc/qcom/qcom_pd_mapper.c                  |  4 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                | 43 +++++++++----
 include/linux/firmware/qcom/qcom_qseecom.h         | 45 --------------
 include/linux/soc/qcom/pmic_glink.h                | 11 ++--
 36 files changed, 366 insertions(+), 176 deletions(-)

