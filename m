Return-Path: <linux-kernel+bounces-176197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72008C2B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E4DB222D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B6313B590;
	Fri, 10 May 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C6YBVCMS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9iAg/o3"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809734CDD
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375510; cv=none; b=pZ89LO96XuOO6mMWyFgssJZv90emBtTCMrw6mfMyAEMYvvLsEAGSfTRDAkinVw4C1GVqGp389NcGR53/Q6dDshL+Tfz9d1TubXsqOWPOi6ANxPqBmCa2tEBEYZye9uqJVwTl2hPlva2HoyOm8PvJfwrX2OA99HmYwBQ5R0NFh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375510; c=relaxed/simple;
	bh=h89N1rx5tKaHVBiYhIKdIRsW7FJZFPGF3BJtjolqb8k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BtjbVMUp81nmjEX5wlQL4WxB/l4tHiMZHtqLS+Sanxy09ay/xJ+SvERHQoDEnadb5NMqHi1ODCKfJYjLgVWEWcAbSHnVsBhv4r+ol/FnPrXWbPqwMXBEr9HhlpTnTCUWLMYDvsQUHUl/yOCHAf6aSLSefag1Z7oZGTl9Ygg+gyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=C6YBVCMS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9iAg/o3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 50B6611400E5;
	Fri, 10 May 2024 17:11:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 May 2024 17:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715375505;
	 x=1715461905; bh=9X/mzINfw7IgW6QKNgOQktbMubUCWrFc0CEi1C9lU0k=; b=
	C6YBVCMSybUwlR36qDkBdZ2avSpMUbz/dpPsrnWvd2f+dgTA94X8glCtf0Hu4wKj
	kjUXQ1jpPspBgN82iovvgmUOEvxpuj1z4PZpGAUHMJxiT0Je9JbPM7lxX8aRT8PU
	A0c5vjiXS8SPyL8J9IquR75AQ5Sv/C7NoRdVzXBbV+AqiHeO5n10FQAx/dIcNqak
	itsspei/1NlcpnL7xlrBCDHNAe+J7k+mm+llZVw0fl1B4g8eo3vvsUPbuXuxMYKx
	nZWKysviUC3uI1xEuUC50bkSlFd+OqJCHxPxJZ5b2Ub+TjNZUIuG2UncGM9PL8dB
	a3i5nh4t07W8aATbIUDvEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715375505; x=
	1715461905; bh=9X/mzINfw7IgW6QKNgOQktbMubUCWrFc0CEi1C9lU0k=; b=V
	9iAg/o3eC1c8/jOibJ2dCTBHq22qWp+VWls/O95Lynz/Ijck82EQtXhYl7bHabn+
	vV0ICS5Ll8F7/yl17o0dQQfUyPIYca6qCDrzw9LH4o5vyvgvo+londJQn2T5fb9H
	xhlA+7batPfYWpVpde2mL7cS/8piXLsmR7MYpkXA+bzb3HW2ZqRv8uwETHgFQoHk
	ZsKd84GXfw2+HtkcKegUnm4Cd4Y3OwS9I90NPPHD4FQ67VJVzV64KQhjMBPOlh5k
	JVH6mFZhRlh9TIbjmjYmzPtfBl+h31jV0lXe3x7QroXau0kqAb3sp90mzbWJjeUy
	Q9Vo6N6o29aAbHhFVJ7zA==
X-ME-Sender: <xms:kI0-ZqekKw3Ki2GRHgg5XQ8SWrkgnK0DxldCYHModCHMvXvMBqUOWA>
    <xme:kI0-ZkNBbbVCiBt5wt4eBFNE6XtCebQWaW066XTPlZTf6l6wGUfgSrEPcO5hOeVnn
    iwri_TF_9zV9jUfQrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekhfehtedvtefhjeekiefghedtffeiveeffeetffetjeffheelhfdt
    ueevjeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgu
    segrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kI0-ZrhTS6MdUjUlMbWxJezbZGC9Te2Vit-NMSgEct8kfkWeyDLq-w>
    <xmx:kI0-Zn9hzTYQOVidjQ-Jxorz_K4VQnbz0324DsXJ9y3EgQrRa7BjdA>
    <xmx:kI0-ZmthYhpMTi1LCLcaG19J5ymKM_1c1uKXd-NRyQFwiAIymubVbw>
    <xmx:kI0-ZuE49Li3EylM5ZGdmoNCoJK59b01hlRcUw2gtqgR7GS1TrcTjQ>
    <xmx:kY0-ZqJ5_GM5kEvqcqftAyfv-9IZoxtPSNjDcIjQm1vj24NLYkP7JB5J>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BADB8B6008D; Fri, 10 May 2024 17:11:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <54b241db-fa39-41d4-8a2f-d44c18745249@app.fastmail.com>
In-Reply-To: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
References: <fa20b5a4-a131-49b4-9597-15886435a288@app.fastmail.com>
Date: Fri, 10 May 2024 23:11:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/4] soc: devicetree updates for 6.10, part 1
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit fec50db7033ea478773b159e0e2efb135270e=
3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.10

for you to fetch changes up to 0cb7e0c617c6aa3da46514ee5982bd7de11a2b2e:

  Merge tag 'qcom-arm64-for-6.10-2' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/qcom/linux into soc/dt (2024-05-08 09:06:06 +0200)

----------------------------------------------------------------
soc: devicetree updates for 6.10, part 1

The updates this time are a bit smaller than most times, mainly because
it is not totally dominated by new Qualcomm hardware support. Instead,
we larger than average updates for Rockchips, NXP, Allwinner and TI.
The only two new SoCs this time are both from NXP and are minor variants
of already supported ones.

The updates for aspeed, amlogic and mediatek came a little late, so
I'm saving those for part 2 in a few days if everything turns out fine.

New machines this time contain:

 - two Broadcom SoC based wireless routers from Asus

 - Five allwinner based consumer devices for gaming, set-top-box and
   eboot reader applications

 - Three older phones based on Qualcomm chips, plus the more recent
   Sony Xperia 1 V

 - 14 industrial and embedded boards based on NXP i.MX6, i.MX8,
   layerscape and s32g3 SoCs

 - six rockchips boards including another handheld game console
   and a few single-board computers

On top of these, we have the usual cleanups for dtc warnings and
updates to add more features to already merged machines.

----------------------------------------------------------------
Abel Vesa (7):
      arm64: dts: qcom: x1e80100: Add SPMI support
      arm64: dts: qcom: x1e80100: Add dedicated pmic dtsi
      arm64: dts: qcom: x1e80100-crd: Add repeater nodes
      arm64: dts: qcom: x1e80100-qcp: Add repeater nodes
      arm64: dts: qcom: x1e80100: Drop the link-frequencies from mdss_dp=
3_in
      arm64: dts: qcom: x1e80100-crd: Add data-lanes and link-frequencie=
s to DP3
      arm64: dts: qcom: x1e80100-qcp: Add data-lanes and link-frequencie=
s to DP3

Akhil R (1):
      arm64: tegra: Add Tegra Security Engine DT nodes

Alain Volmat (6):
      arm64: dts: st: add all 8 i2c nodes on stm32mp251
      arm64: dts: st: add i2c2/i2c8 pins for stm32mp25
      arm64: dts: st: add i2c2 / i2c8 properties on stm32mp257f-ev1
      arm64: dts: st: add all 8 spi nodes on stm32mp251
      arm64: dts: st: add spi3/spi8 pins for stm32mp25
      arm64: dts: st: add spi3 / spi8 properties on stm32mp257f-ev1

Alexander Stein (8):
      arm64: dts: imx8mm: Add empty DSI output endpoint
      arm64: dts: imx8mn: Add empty DSI output endpoint
      arm64: dts: imx8mq: Add empty DSI output endpoint
      arm64: dts: imx8mp: Add empty DSI output endpoint
      arm64: dts: mba8mx: Simplify DSI connection
      ARM: dts: imx6qdl: mba6: Add missing vdd-supply for on-board USB h=
ub
      ARM: dts: imx6qdl: Remove LCD.CONTRAST pinctrl from muxing
      arm64: dts: imx8mp: Enable HDMI on TQMa8MPxL/MBa8MPxL

Alexandre Torgue (1):
      ARM: dts: stm32: put ETZPC as an access controller for STM32MP13x =
boards

Alice Guo (1):
      arm64: dts: imx8dxl: add lpuart device in cm40 subsystem

Anand Moon (2):
      arm64: dts: rockchip: Support poweroff on Edgeble Neural Compute M=
odule
      arm64: dts: rockchip: Add USB3 on Edgeble NCM6A-IO board

Andre Przywara (3):
      arm64: dts: allwinner: h616: Fix I2C0 pins
      dt-bindings: arm: sunxi: document Tanix TX1 name
      arm64: dts: allwinner: Add Tanix TX1 support

Andreas Kemnade (2):
      ARM: dts: imx6sl: tolino-shine2hd: fix IRQ config of touchscreen
      ARM: dts: imx6: fix IRQ config of RC5T619

Andrejs Cainikovs (1):
      arm64: dts: ti: verdin-am62: dahlia: fix audio clock

Andrew Davis (14):
      ARM: dts: ti: keystone: k2g: Remove ti,system-reboot-controller pr=
operty
      dt-bindings: arm: keystone: Remove ti,system-reboot-controller pro=
perty
      arm64: dts: ti: k3-am65: Remove UART baud rate selection
      arm64: dts: ti: k3-am64: Remove UART baud rate selection
      arm64: dts: ti: k3-j7200: Remove UART baud rate selection
      arm64: dts: ti: k3-j721e: Remove UART baud rate selection
      arm64: dts: ti: k3-j721s2: Remove UART baud rate selection
      arm64: dts: ti: k3-j784s4: Remove UART baud rate selection
      arm64: dts: ti: k3-am65: Add full compatible to SerDes control nod=
es
      arm64: dts: ti: k3-am65: Move SerDes mux nodes under the control n=
ode
      arm64: dts: ti: k3-am65: Use exact ranges for FSS node
      arm64: dts: ti: k3-j7200: Use exact ranges for FSS node
      arm64: dts: ti: k3-j721e: Use exact ranges for FSS node
      arm64: dts: ti: k3-j784s4: Use exact ranges for FSS node

Andr=C3=A9 Draszik (9):
      arm64: dts: exynos: gs101: reorder pinctrl-* properties
      dt-bindings: clock: google,gs101-clock: add HSI0 clock management =
unit
      arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller
      arm64: dts: exynos: gs101: add USB & USB-phy nodes
      arm64: dts: exynos: gs101-oriole: enable USB on this board
      arm64: dts: exynos: gs101: specify bus clock for pinctrl (far) ali=
ve
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_peric[01]
      arm64: dts: exynos: gs101: specify bus clock for pinctrl_hsi2
      arm64: dts: exynos: gs101: specify empty clocks for remaining pinc=
trl

Andy Yan (2):
      arm64: dts: rockchip: Enable gpu on Cool Pi CM5
      arm64: dts: rockchip: Enable gpu on Cool Pi 4B

Anton Bambura (5):
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: fix GPU firmware path
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: set names for i2c hid no=
des
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: move pinctrl to appropri=
ate nodes
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: set touchpad i2c frequen=
cy to 1 MHz
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Allow UFS regulators loa=
d/mode setting

Aren Moynihan (1):
      arm64: dts: allwinner: pinephone: add multicolor LED node

Arnd Bergmann (31):
      Merge tag 'renesas-dt-bindings-for-v6.10-tag1' of git://git.kernel=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.10-tag1' of git://git.kernel.org/pub=
/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'omap-for-v6.10/dt-signed' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'samsung-dt-6.10' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux into soc/dt
      Merge tag 'samsung-dt64-6.10' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux into soc/dt
      Merge tag 'hisi-arm64-dt-for-6.10' of https://github.com/hisilicon=
/linux-hisi into soc/dt
      Merge tag 'stm32-dt-for-v6.10-1' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'v6.10-rockchip-dts64-1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'renesas-dts-for-v6.10-tag2' of git://git.kernel.org/pub=
/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'sunxi-dt-for-6.10-1' of https://git.kernel.org/pub/scm/=
linux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'tegra-for-6.10-dt-bindings' of git://git.kernel.org/pub=
/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.10-arm-dt' of git://git.kernel.org/pub/scm/=
linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.10-arm64-dt' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.10-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'qcom-arm32-for-6.10' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.10' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'imx-bindings-6.10' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.10' of git://git.kernel.org/pub/scm/linux/kern=
el/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.10' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into soc/dt
      Merge tag 'dt64-cleanup-6.10' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'dt-cleanup-6.10' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'microchip-dt64-6.10' of https://git.kernel.org/pub/scm/=
linux/kernel/git/at91/linux into soc/dt
      Merge tag 'arm-soc/for-6.10/devicetree' of https://github.com/Broa=
dcom/stblinux into soc/dt
      Merge tag 'arm-soc/for-6.10/devicetree-arm64' of https://github.co=
m/Broadcom/stblinux into soc/dt
      Merge tag 'riscv-sophgo-dt-for-v6.10' of https://github.com/sophgo=
/linux into soc/dt
      Merge tag 'ti-keystone-dt-for-v6.10' of https://git.kernel.org/pub=
/scm/linux/kernel/git/ti/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.10' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/ti/linux into soc/dt
      Merge tag 'mvebu-dt64-6.10-1' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'v6.10-rockchip-dts64-2' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'samsung-dt64-6.10-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.10-2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/dt

Arthur Demchenkov (1):
      ARM: dts: n900: set charge current limit to 950mA

Artur Weber (1):
      ARM: dts: exynos4212-tab3: limit usable memory range

Ar=C4=B1n=C3=A7 =C3=9CNAL (9):
      ARM: dts: BCM5301X: use color and function on ASUS RT-AC3100 and R=
T-AC88U
      ARM: dts: BCM5301X: provide address for SoC MACs on ASUS RT-AC3100=
 & AC88U
      ARM: dts: BCM5301X: remove duplicate compatible on ASUS RT-AC3100 =
& AC88U
      ARM: dts: BCM5301X: remove earlycon on ASUS RT-AC3100 and ASUS RT-=
AC88U
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
      ARM: dts: BCM5301X: Conform to DTS Coding Style on ASUS RT-AC3100 =
& AC88U

Bhavya Kapoor (2):
      arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mo=
de
      arm64: dts: ti: k3-j722s-evm: Enable UHS support for MMCSD

Biju Das (1):
      arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, G=
PIO and ONKEY

Bjorn Andersson (9):
      arm64: dts: qcom: qcs6490-rb3gen2: Name the regulators
      Merge branch 'arm64-for-6.10' onto 'v6.9-rc1'
      Merge branch 'arm32-for-6.10' onto 'v6.9-rc1'
      arm64: dts: qcom: sc7280: Enable MDP turbo mode
      arm64: dts: qcom: qcs6490-rb3gen2: Add DP output
      arm64: dts: qcom: qcs6490-rb3gen2: Enable adsp and cdsp
      arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB redriver
      arm64: dts: qcom: qcs6490-rb3gen2: Enable USB Type-C display
      arm64: dts: qcom: qcs6490-rb3gen2: Enable UFS

Boris Brezillon (3):
      arm64: dts: rockchip: Add rk3588 GPU node
      arm64: dts: rockchip: Enable GPU on rk3588-rock5b
      arm64: dts: rockchip: Enable GPU on rk3588-evb1

Brandon Brnich (1):
      arm64: dts: ti: k3-am62a-main: Add Wave5 Video Encoder/Decoder Node

Caleb Connolly (1):
      arm64: dts: qcom: sdm845-db845c: make pcie0_3p3v_dual always-on

Carlos Song (1):
      arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recove=
ry

Chris Morgan (9):
      arm64: dts: rockchip: Add additional properties for WiFi on Anbern=
ic rgxx3
      arm64: dts: rockchip: Add optional node for chasis-type on Anberni=
c rgxx3
      arm64: dts: rockchip: Correct model name for Anbernic RGxx3 Devices
      arm64: dts: rockchip: Add chasis-type for Powkiddy rk3566 devices
      arm64: dts: rockchip: Correct model name for Powkiddy RK3566 Devic=
es
      dt-bindings: arm: rockchip: Add GameForce Chi
      arm64: dts: rockchip: Add GameForce Chi
      arm64: dts: rockchip: Add USB-C Support for rk3588s-indiedroid-nova
      arm64: dts: allwinner: h616: Add NMI device node

Christian Marangi (1):
      ARM: dts: qcom: ipq4019: add QCA8075 PHY Package nodes

Chukun Pan (5):
      dt-bindings: arm: rockchip: correct the model name for Radxa ROCK =
3A
      arm64: dts: rockchip: correct the model name for Radxa ROCK 3A
      dt-bindings: arm: rockchip: add Radxa ROCK 3C
      arm64: dts: rockchip: Add Radxa ROCK 3C
      arm64: dts: rockchip: enable onboard spi flash for rock-3a

Claudiu Beznea (1):
      arm64: dts: renesas: rzg3s-smarc-som: Fix Ethernet aliases

Connor Abbott (1):
      arm64: dts: qcom: sm8650: Fix GPU cx_mem size

Danila Tikhonov (3):
      arm64: dts: qcom: pm6150: define USB-C related blocks
      arm64: dts: qcom: sc7180: Fix UFS PHY clocks
      arm64: dts: qcom: pm6150l: add Light Pulse Generator device node

Dario Binacchi (1):
      ARM: dts: stm32: move can3 node from stm32f746 to stm32f769

Dasnavis Sabiya (1):
      arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode

David Heidelberg (2):
      ARM: dts: qcom: include cpu in idle-state node names
      ARM: dts: qcom: msm8916: idle-state compatible require the generic=
 idle-state

David Jander (1):
      arm64: dts: rockchip: add Protonic MECSBC device-tree

Denis Burkov (2):
      dt-bindings: arm: sunxi: Add PocketBook 614 Plus
      ARM: dts: sun5i: Add PocketBook 614 Plus support

Diederik de Haas (1):
      arm64: dts: rockchip: Fix ordering of nodes on rk3588s

Dmitry Baryshkov (15):
      arm64: dts: qcom: qrb2210-rb1: enable USB-C port handling
      arm64: dts: qcom: sc8180x: drop legacy property #stream-id-cells
      arm64: dts: qcom: sc8180x: Drop flags for mdss irqs
      arm64: dts: qcom: sc8180x: add dp_p1 register blocks to DP nodes
      arm64: dts: qcom: sm8350: Add interconnects to UFS
      dt-bindings: arm: qcom: drop dtbTool-specific compatibles
      arm64: dts: qcom: msm8916: drop dtbTool-specific compatibles
      arm64: dts: qcom: sm8150-hdk: enable WiFI support
      dt-bindings: soc: qcom: pmic-glink: allow orientation-gpios
      arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
      arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orienta=
tion GPIOs
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GP=
IOs
      arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi=
 node
      arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi=
 node

Dmitry Yashin (3):
      dt-bindings: arm: rockchip: add Forlinx FET3588-C
      arm64: dts: rockchip: add Forlinx FET3588-C
      arm64: dts: rockchip: add Forlinx OK3588-C

Dong Aisheng (1):
      arm64: dts: imx8: add cm40 subsystem dtsi

Dragan Simic (7):
      arm64: dts: rockchip: Add cache information to the SoC dtsi for RK=
3328
      arm64: dts: rockchip: Add cache information to the SoC dtsi for RK=
356x
      arm64: dts: rockchip: Enable the GPU on quartzpro64
      dt-bindings: arm: rockchip: Correct the descriptions for Radxa boa=
rds
      arm64: dts: rockchip: Correct the model names for Radxa ROCK 5 boa=
rds
      dt-bindings: arm: rockchip: Correct the descriptions for Pine64 bo=
ards
      arm64: dts: rockchip: Correct the model names for Pine64 boards

Duy Nguyen (1):
      arm64: dts: renesas: r8a779h0: Add thermal nodes

Elliot Berman (1):
      arm64: dts: qcom: sm8650: Add missing reserved memory for chipinfo

Fabio Estevam (8):
      ARM: dts: imx7s: Add snvs-poweroff support
      ARM: dts: imx6qdl-udoo: Enable USB host
      arm64: dts: imx8m/qxp: Pass the tcpci compatible
      arm64: dts: imx8mn-evk: Fix ADV7535 dt-schema warnings
      arm64: dts: imx8mn-evk: Describe the OV5640 supplies
      arm64: dts: imx8mm-evk: Describe the OV5640 supplies
      arm64: dts: imx8mp-debix-som-a-bmb-08: Remove 'phy-supply' from eq=
os
      arm64: dts: imx8-ss-img: Remove JPEG clock-names

Florian Fainelli (1):
      arm: dts: bcm2711: Describe Ethernet LEDs

Folker Schwesinger (2):
      arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on RO=
CK Pi 4
      arm64: dts: rockchip: Add enable-strobe-pulldown to emmc phy on RO=
CK 4C+

Francesco Dolcini (3):
      arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
      arm64: dts: ti: verdin-am62: mallow: fix GPIOs pinctrl
      arm64: dts: ti: k3-am625-verdin: add PCIe reset gpio hog

Frank Li (10):
      arm64: dts: imx8qm-mek: add adc0 support
      arm64: dts: imx8qm-mek: add lpspi2 support
      arm64: dts: imx8qm-mek: add flexspi0 support
      arm64: dts: imx8: fix audio lpcg index
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0 and sai[4,5]
      arm64: dts: imx8dxl: update cm40 irq number information
      arm64: dts: imx8dxl-evk: add lpuart1 and cm40 uart
      ARM: dts: nxp: imx6sx: fix esai related warning when do dtb_check
      ARM: dts: nxp: imx6qdl: fix esai clock warning when do dtb_check
      arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960 and sai[0,1,4,5]

Frank Oltmanns (1):
      arm64: dts: allwinner: a64: Run GPU at 432 MHz

Gabriel Fernandez (1):
      arm64: dts: st: add rcc support for STM32MP25

Garrett Giordano (2):
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add Audio Codec
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add USB-C

Gatien Chevallier (4):
      arm64: dts: st: add RIFSC as an access controller for STM32MP25x b=
oards
      ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
      ARM: dts: stm32: put ETZPC as an access controller for STM32MP15x =
boards
      ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards

Geert Uytterhoeven (11):
      ARM: dts: renesas: r8a73a4: Add TMU nodes
      ARM: dts: renesas: rzg1: Add TMU nodes
      ARM: dts: renesas: rcar-gen2: Add TMU nodes
      arm64: dts: renesas: r8a779h0: Add remaining HSCIF nodes
      arm64: dts: renesas: r8a779h0: Add SCIF nodes
      arm64: dts: renesas: gray-hawk-single: Add second debug serial port
      ARM: dts: renesas: r9a06g032: Remove duplicate interrupt-parent
      arm64: dts: renesas: gray-hawk-single: Enable nfsroot
      arm64: dts: renesas: s4sk: Fix ethernet0 alias
      arm64: dts: renesas: r8a779h0: Add INTC-EX node
      arm64: dts: renesas: r8a779h0: Link IOMMU consumers

Ghennadi Procopciuc (2):
      arm64: dts: s32g: add SCMI firmware node
      arm64: dts: s32g: add uSDHC node

Gilles Talis (3):
      dt-bindings: vendor-prefixes: Add Emcraft Systems
      dt-bindings: arm: Add Emcraft Systems i.MX8M Plus NavQ+ Kit
      arm64: dts: freescale: Add device tree for Emcraft Systems NavQ+ K=
it

Haibo Chen (1):
      arm64: dts: imx93: assign usdhc[1..3] root clock to 400MHz

Heiko Stuebner (8):
      arm64: dts: rockchip: enable gpu on rk3588-jaguar
      arm64: dts: rockchip: enable gpu on rk3588-tiger
      arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
      arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
      arm64: dts: rockchip: fix pcie-refclk frequency on rk3588 tiger
      arm64: dts: rockchip: fix comment for upper usb3 port
      arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
      arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Hai=
kou

Hiago De Franco (5):
      arm64: dts: freescale: Add i.MX8DX dtsi
      arm64: dts: freescale: Add Toradex Colibri iMX8DX
      dt-bindings: arm: fsl: remove reduntant toradex,colibri-imx8x
      dt-bindings: arm: fsl: Add Colibri iMX8DX
      arm64: dts: freescale: imx8m[mp]-verdin: Update audio card name

Hugues Fruchet (1):
      media: dt-bindings: add access-controllers to STM32MP25 video code=
cs

Hui Liu (1):
      arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and Power buttons

Ian Ray (2):
      arm64: dts: imx8mp-msc-sm2s: correct i2c{1..6} pad drive strength
      arm64: dts: imx8mp-msc-sm2s: Add i2c{1,6} sda-/scl-gpios

Inochi Amaoto (6):
      riscv: dts: sophgo: add clock generator for Sophgo CV1800 series S=
oC
      riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
      riscv: dts: sophgo: cv18xx: Add spi devices
      riscv: dts: sophgo: cv18xx: Add i2c devices
      riscv: dts: sophgo: use real clock for sdhci
      riscv: dts: sophgo: add reserved memory node for CV1800B

Jacopo Mondi (1):
      arm64: dts: debix-a: Disable i2c2 in base .dts

Jai Luthra (1):
      arm64: dts: ti: Fix csi2-dual-imx219 dtb names

Jan Kiszka (1):
      arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG1 devices

Jean-Michel Hautbois (1):
      ARM: dts: bcm2835: Add Unicam CSI nodes

Jianfeng Liu (3):
      dt-bindings: vendor-prefixes: add ArmSoM
      dt-bindings: arm: rockchip: Add ArmSoM Sige7
      arm64: dts: rockchip: Add ArmSom Sige7 board

Jianhua Lu (2):
      arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd negotiation supp=
ort
      arm64: dts: qcom: sm8250-xiaomi-elish: set pm8150b_vbus regulator-=
min-microamp and regulator-max-microamp

Jimmy Hon (2):
      arm64: dts: rockchip: Enable GPU on Orange Pi 5
      arm64: dts: rockchip: add USB-C support to rk3588s-orangepi-5

Jing Luo (1):
      arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boa=
rds

Jisheng Zhang (1):
      riscv: dts: sophgo: add sdcard support for milkv duo

Joe Mason (1):
      arm64: dts: qcom: msm8916-samsung-fortuna: Add touchscreen

Johan Hovold (4):
      arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
      arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
      arm64: dts: qcom: sc8280xp-x13s: enable USB MP and fingerprint rea=
der
      arm64: dts: qcom: qcs404: fix bluetooth device address

Josua Mayer (2):
      arm64: dts: fsl-lx2162a-som: add description for rtc
      arm64: dts: fsl-lx2162a-clearfog: add alias for i2c bus iic6

Joy Zou (2):
      arm64: dts: imx93-11x11-evk: add pca9451a support
      arm64: dts: imx93-11x11-evk: add RTC PCF2131 support

Judith Mendez (2):
      arm64: dts: ti: k3-am65-main: Fix sdhci node properties
      arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci no=
des

Komal Bajaj (2):
      arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
      arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs

Konrad Dybcio (12):
      arm64: dts: qcom: sc8280xp: Add missing LMH interrupts
      arm64: dts: qcom: sc8280xp: Add QFPROM node
      arm64: dts: qcom: sc8280xp: Add PS_HOLD restart
      arm64: dts: qcom: sc8280xp: Describe TCSR download mode register
      arm64: dts: qcom: msm8998-yoshino: Enable RGB led
      dt-bindings: arm: qcom: Add Xperia 1 V
      arm64: dts: qcom: sm8550: Mark QUPs and GPI dma-coherent
      arm64: dts: qcom: sm8550: Mark APPS SMMU as dma-coherent
      arm64: dts: qcom: sm8550: Add missing DWC3 quirks
      arm64: dts: qcom: sm8550: Mark DWC3 as dma-coherent
      arm64: dts: qcom: Add SM8550 Xperia 1 V
      arm64: dts: qcom: sc8280xp: Fill in EAS properties

Krishna Kurapati (2):
      arm64: dts: qcom: sc8280xp: Add missing hs_phy_irq in USB nodes
      arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller

Krzysztof Kozlowski (76):
      arm64: dts: qcom: x1e80100: correct SWR1 pack mode
      arm64: dts: qcom: x1e80100-crd: switch WSA8845 speakers to shared =
reset-gpio
      ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
      ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: fix keypad no-autorepeat
      ARM: dts: samsung: smdk4412: align keypad node names with dtschema
      ARM: dts: samsung: exynos5800-peach-pi: switch to undeprecated DP =
HPD GPIOs
      ARM: dts: samsung: s5pv210: align onenand node name with bindings
      ARM: dts: samsung: s5pv210: correct onenand size-cells
      arm64: dts: juno: fix thermal zone node names
      arm64: dts: amd: use capital "OR" for multiple licenses in SPDX
      arm64: dts: qcom: pm6150: correct Type-C compatible
      arm64: dts: marvell: ap80x: fix IOMMU unit address
      arm64: dts: marvell: cn9130-db: drop unneeded flash address/size-c=
ells
      arm64: dts: marvell: cn9131-db: drop unneeded flash address/size-c=
ells
      arm64: dts: marvell: cn9130-db: drop wrong unit-addresses
      arm64: dts: marvell: cn9130-crb: drop wrong unit-addresses
      arm64: dts: marvell: cn9130-crb: drop unneeded "status"
      arm64: dts: sprd: minor whitespace cleanup
      arm64: dts: qcom: apq8016-sbc: correct GPIO LEDs node names
      arm64: dts: microchip: sparx5: fix mdio reg
      arm64: dts: microchip: sparx5: correct serdes unit address
      arm64: dts: microchip: sparx5_pcb134: add missing I2C mux unit add=
resses
      arm64: dts: microchip: sparx5_pcb135: add missing I2C mux unit add=
resses
      arm64: dts: microchip: sparx5_pcb134: align I2C mux node name with=
 bindings
      arm64: dts: microchip: sparx5_pcb135: align I2C mux node name with=
 bindings
      arm64: dts: microchip: sparx5_pcb134: drop LED unit addresses
      arm64: dts: microchip: sparx5_pcb135: drop LED unit addresses
      arm64: dts: microchip: sparx5_pcb134: drop duplicated NOR flash
      arm64: dts: microchip: sparx5_pcb135: drop duplicated NOR flash
      arm64: dts: ti: k3-am62p5-sk: minor whitespace cleanup
      ARM: dts: ti: omap: minor whitespace cleanup
      arm64: dts: hisilicon: hip05: move non-MMIO node out of soc
      arm64: dts: hisilicon: hip05-d02: correct local-bus unit addresses
      arm64: dts: hisilicon: hip06: move non-MMIO node out of soc
      arm64: dts: hisilicon: hip06: correct unit addresses
      arm64: dts: allwinner: Pine H64: correctly remove reg_gmac_3v3
      arm64: dts: allwinner: drop underscore in node names
      arm64: dts: allwinner: Orange Pi: delete node by phandle
      arm: dts: allwinner: drop underscore in node names
      arm64: dts: hisilicon: hip07: move non-MMIO node out of soc
      arm64: dts: hisilicon: hip07: correct unit addresses
      arm64: dts: hisilicon: hi6220-hikey: add missing port@0 reg
      arm64: dts: hisilicon: hi6220-hikey: drop unit addresses from fixe=
d regulators
      arm64: dts: hisilicon: hi6220: correct tsensor unit addresses
      arm64: dts: qcom: sdx75: add unit address to soc node
      arm64: dts: imx8mm-var-som-symphony: drop redundant status from ty=
pec
      arm64: dts: imx8mn-var-som-symphony: drop redundant status from ty=
pec
      arm64: dts: sc9860: add missing aon-prediv unit address
      arm64: dts: sc9860: move GPIO keys to board
      arm64: dts: sc9860: move GIC to soc node
      arm64: dts: whale2: add missing ap-apb unit address
      arm64: dts: sharkl3: add missing unit addresses
      arm64: dts: uniphier: ld11-global: use generic node name for audio=
-codec
      arm64: dts: uniphier: ld11-global: drop audio codec port unit addr=
ess
      arm64: dts: uniphier: ld20-global: use generic node name for audio=
-codec
      arm64: dts: uniphier: ld20-global: drop audio codec port unit addr=
ess
      arm64: dts: realtek: rtd129x: add missing unit address to soc node
      arm64: dts: realtek: rtd139x: add missing unit address to soc node
      arm64: dts: realtek: rtc16xx: add missing unit address to soc node
      arm64: dts: cavium: move non-MMIO node out of soc
      arm64: dts: cavium: correct unit addresses
      arm64: dts: apm: storm: move non-MMIO node out of soc
      arm64: dts: apm: shadowcat: move non-MMIO node out of soc
      arm64: dts: amazon: alpine-v2: add missing io-fabric unit addresses
      arm64: dts: amazon: alpine-v2: move non-MMIO node out of soc
      arm64: dts: amazon: alpine-v3: add missing io-fabric unit addresses
      arm64: dts: amazon: alpine-v3: drop cache nodes unit addresses
      arm64: dts: amazon: alpine-v3: correct gic unit addresses
      arm64: dts: cavium: thunder2-99xx: drop redundant reg-names
      arm64: tegra: Correct Tegra132 I2C alias
      Merge branch 'for-v6.10/clk-gs101-bindings' into next/dt64
      arm64: dts: qcom: pm6150: correct USB VBUS regulator compatible
      arm64: dts: marvell: eDPU: drop redundant address/size-cells
      arm64: dts: marvell: turris-mox: drop unneeded flash address/size-=
cells
      arm64: dts: marvell: espressobin-ultra: fix Ethernet Switch unit a=
ddress

Lad Prabhakar (7):
      ARM: dts: renesas: r7s72100: Add interrupt-names to SCIF nodes
      dt-bindings: soc: renesas: Document Renesas RZ/V2H(P) SoC variants
      dt-bindings: arm: renesas: Document Renesas RZ/V2H(P) System Contr=
oller
      riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
      arm64: dts: renesas: r9a07g043: Move interrupt-parent property to =
common DTSI
      riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt pro=
perties from ETH0/1 nodes
      arm64: dts: renesas: rzg3s-smarc-som: Enable eMMC by default

Laurent Pinchart (5):
      dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add gpio chil=
d node
      firmware: raspberrypi: Use correct device for DMA mappings
      ARM: dts: bcm283x: Drop unneeded properties in the bcm2835-firmwar=
e node
      ARM: dts: bcm2835-rpi: Move duplicate firmware-clocks to bcm2835-r=
pi.dtsi
      ARM: dts: bcm2711-rpi-4-b: Add CAM1 regulator

Ling Xu (1):
      arm64: dts: qcom: sm8650: Add three missing fastrpc-compute-cb nod=
es

Loic Poulain (1):
      arm64: dts: qcom: qcm2290: Add LMH node

Luca Ceresoli (2):
      arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3 to rk3308
      arm64: dts: rockchip: add the internal audio codec on rk3308

Luca Weiss (16):
      arm64: dts: qcom: sm6350: Add Crypto Engine
      arm64: dts: qcom: sdm632-fairphone-fp3: enable USB-C port handling
      ARM: dts: qcom: msm8974pro-castor: Clean up formatting
      ARM: dts: qcom: msm8974pro-castor: Add mmc aliases
      ARM: dts: qcom: msm8974pro-castor: Remove camera button definitions
      ARM: dts: qcom: msm8974pro-castor: Add debounce-interval for keys
      ARM: dts: qcom: msm8974pro-castor: Rename wifi node name
      ARM: dts: qcom: msm8974-sony-castor: Split into shinano-common
      ARM: dts: qcom: Add Sony Xperia Z3 smartphone
      arm64: dts: qcom: sc7280: Add inline crypto engine
      dt-bindings: arm: qcom: Add Sony Xperia Z3
      ARM: dts: qcom: msm8974: Add @0 to memory node name
      ARM: dts: qcom: msm8974: Add empty chosen node
      ARM: dts: qcom: msm8974-sony-shinano: Enable vibrator
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add USB-C orientation GPIO
      arm64: dts: qcom: sm6350: Add DisplayPort controller

Lucas Stach (3):
      arm64: dts: imx8mp: add HDMI power-domains
      arm64: dts: imx8mp: add HDMI irqsteer
      arm64: dts: imx8mp: add HDMI display pipeline

Luke Wang (1):
      arm64: dts: imx93-11x11-evk: add different usdhc pinctrl for diffe=
rent timing usage

Manivannan Sadhasivam (20):
      ARM: dts: qcom: ipq8064: Add PCIe bridge node
      ARM: dts: qcom: ipq4019: Add PCIe bridge node
      ARM: dts: qcom: apq8064: Add PCIe bridge node
      ARM: dts: qcom: sdx55: Add PCIe bridge node
      arm64: dts: qcom: sm8250: Add PCIe bridge node
      arm64: dts: qcom: sdm845: Add PCIe bridge node
      arm64: dts: qcom: sm8150: Add PCIe bridge node
      arm64: dts: qcom: sm8350: Add PCIe bridge node
      arm64: dts: qcom: sm8450: Add PCIe bridge node
      arm64: dts: qcom: sm8550: Add PCIe bridge node
      arm64: dts: qcom: sm8650: Add PCIe bridge node
      arm64: dts: qcom: sa8775p: Add PCIe bridge node
      arm64: dts: qcom: sc8280xp: Add PCIe bridge node
      arm64: dts: qcom: msm8998: Add PCIe bridge node
      arm64: dts: qcom: sc7280: Add PCIe bridge node
      arm64: dts: qcom: qcs404: Add PCIe bridge node
      arm64: dts: qcom: sc8180x: Add PCIe bridge node
      arm64: dts: qcom: msm8996: Add PCIe bridge node
      arm64: dts: qcom: ipq8074: Add PCIe bridge node
      arm64: dts: qcom: ipq6018: Add PCIe bridge node

Marek Vasut (3):
      arm64: dts: imx8mp: Describe CSI2 GPIO expander on i.MX8MP DHCOM P=
DK3 board
      arm64: dts: imx8mp: Align both CSI2 pixel clock
      ARM: dts: stm32: add PWR regulators support on stm32mp131

Markus Schneider-Pargmann (1):
      arm64: dts: ti: k3-am62-lp-sk: Remove tps65219 power-button

Max Krummenacher (1):
      arm64: dts: ti: verdin-am62: Set memory size to 2gb

Michael Grzeschik (1):
      ARM: dts: imx27-phytec: Add USB support

Michael Riesch (4):
      dt-bindings: add wolfvision vendor prefix
      dt-bindings: arm: rockchip: add wolfvision pf5 mainboard
      arm64: dts: rockchip: add wolfvision pf5 mainboard
      arm64: dts: rockchip: add wolfvision pf5 io expander board

Michael Walle (3):
      arm64: dts: ti: k3-{am62p,j722s}: Disable ethernet by default
      arm64: dts: ti: k3-j722s-evm: Enable eMMC support
      arm64: dts: ls1028a: sl28: split variant 3/ads2 carrier

Miles Alan (1):
      arm64: dts: allwinner: pinephone: Retain LEDs state in suspend

Mohammad Shehar Yaar Tausif (1):
      ARM: tegra: tegra20-ac97: Replace deprecated "gpio" suffix

Muhammed Efe Cetin (10):
      arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas =
Edge 2
      arm64: dts: rockchip: Add PMIC to Khadas Edge 2
      arm64: dts: rockchip: Add TF card to Khadas Edge 2
      arm64: dts: rockchip: USB2, USB3 Host, PCIe2 to Khadas Edge 2
      arm64: dts: rockchip: Add ir receiver and leds to Khadas Edge 2
      arm64: dts: rockchip: Add saradc and adc buttons to Khadas Edge 2 =
and enable tsadc
      arm64: dts: rockchip: Add SFC to Khadas Edge 2
      arm64: dts: rockchip: Add UART9 (bluetooth) to Khadas Edge 2
      arm64: dts: rockchip: Add RTC to Khadas Edge 2
      arm64: dts: rockchip: enable GPU on khadas-edge2

Nathan Morrisson (4):
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Increase CAN max bitra=
te
      arm64: dts: ti: k3-am642-phyboard-electra-rdk: Increase CAN max bi=
trate
      arm64: dts: ti: am64-phyboard-electra: Add overlay to enable a GPI=
O fan
      arm64: dts: ti: Enable overlays for the am625-phyboard-lyra

Neil Armstrong (7):
      arm64: dts: qcom: sm8450: add missing qcom,non-secure-domain prope=
rty
      arm64: dts: qcom: sm8550: add missing qcom,non-secure-domain prope=
rty
      arm64: dts: qcom: sm8650: add missing qcom,non-secure-domain prope=
rty
      arm64: dts: qcom: sm8650: fix usb interrupts properties
      arm64: dts: qcom: sm8650: remove useless enablement of mdss_mdp
      arm64: dts: qcom: sm8650: add GPU nodes
      arm64: dts: qcom: sm8650-qrd: enable GPU

Nicolas Chauvet (1):
      ARM: tegra: paz00: Add emc-tables for ram-code 1

Niklas Cassel (1):
      arm64: dts: rockchip: add rk3588 pcie and php IOMMUs

Niklas S=C3=B6derlund (1):
      arm64: dts: renesas: eagle: Add capture overlay for Function expan=
sion board

Pankaj Gupta (1):
      arm64: dts: imx8ulp: add caam jr

Parthiban Nallathambi (2):
      ARM: dts: imx6ull: add seeed studio NPi dev board
      dt-bindings: arm: fsl: Add Seeed studio NPi based boards

Patrice Chotard (1):
      ARM: dts: stm32: add heartbeat led for stm32mp157c-ed1

Patrick Delaunay (1):
      arm64: dts: st: correct masks for GIC PPI interrupts on stm32mp25

Pawe=C5=82 Owoc (2):
      arm64: dts: qcom: ipq8074: Add QUP UART6 node
      arm64: dts: qcom: ipq8074: Remove unused gpio from QPIC pins

Peng Fan (9):
      arm64: dts: imx93: drop the 4th interrupt for ADC
      arm64: dts: imx93: use FSL_EDMA_RX for rx channel
      arm64: dts: imx93: add dma support for lpi2c[1..8]
      arm64: dts: imx93: add dma support for lpspi[1..8]
      arm64: dts: imx93: add nvmem property for fec1
      arm64: dts: imx93: add nvmem property for eqos
      arm64: dts: imx93-11x11-evk: update resource table address
      arm64: dts: imx93-11x11-evk: add sleep pinctrl for eqos and fec
      arm64: dts: imx93-11x11-evk: add sleep pinctrl for sdhc2

Peter Griffin (6):
      dt-bindings: clock: google,gs101-clock: add HSI2 clock management =
unit
      arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
      dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg=
 compatible
      arm64: dts: exynos: gs101: Add the hsi2 sysreg node
      arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
      arm64: dts: exynos: gs101: enable ufs, phy on oriole & define ufs =
regulator

Rafa=C5=82 Mi=C5=82ecki (1):
      arm64: dts: broadcom: bcmbca: bcm4908: set brcm,wp-not-connected

Raphael Gallais-Pou (4):
      dt-bindings: display: simple: allow panel-common properties
      ARM: dts: stm32: add LTDC support for STM32MP13x SoC family
      ARM: dts: stm32: add LTDC pinctrl on STM32MP13x SoC family
      ARM: dts: stm32: enable display support on stm32mp135f-dk board

Raymond Hackley (1):
      arm64: dts: qcom: msm8916/39-samsung-a2015: Add connector for MUIC

Richard Acayan (1):
      arm64: dts: qcom: sdm670-google-sargo: add panel

Ritesh Kumar (1):
      arm64: dts: qcom: qcm6490-idp: add display and panel

Rob Herring (2):
      arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
      arm64: dts: Add/fix /memory node unit-addresses

Rob Herring (Arm) (2):
      arm64: dts: freescale: ls1028a: Fix embedded PCI interrupt mapping
      arm64: dts: freescale: ls1028a: Add standard PCI device compatible=
 strings to ENETC

Roger Quadros (5):
      arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper node
      arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
      arm64: dts: ti: k3-am62p: add the USB sub-system
      arm64: dts: ti: k3-am62a: Disable USB LPM
      arm64: dts: ti: k3-am625-beagleplay: Fix Ethernet PHY RESET GPIOs

Rong Zhang (4):
      dt-bindings: arm: qcom: Add Samsung Galaxy S5 China (kltechn)
      ARM: dts: qcom: msm8974: Split out common part of samsung-klte
      ARM: dts: qcom: msm8974-klte-common: Pin WiFi board type
      ARM: dts: qcom: msm8974: Add DTS for Samsung Galaxy S5 China (klte=
chn)

Ryan Walklin (4):
      dt-bindings: arm: sunxi: document Anbernic RG35XX handheld gaming =
device variants
      arm64: dts: allwinner: h700: Add RG35XX 2024 DTS
      arm64: dts: allwinner: h700: Add RG35XX-Plus DTS
      arm64: dts: allwinner: h700: Add RG35XX-H DTS

Sam Protsenko (1):
      arm64: dts: exynos850: Add CPU clocks

Sascha Hauer (1):
      dt-bindings: arm: rockchip: Add Protonic MECSBC board

Sebastian Raase (2):
      arm64: dts: qcom: sdm630-nile: add pinctrl for camera key
      arm64: dts: qcom: msm8998-yoshino: fix volume-up key

Sebastian Reichel (8):
      ARM: dts: imx: Add UNI-T UTi260B thermal camera board
      arm64: dts: rockchip: fix usb2phy nodename for rk3588
      arm64: dts: rockchip: reorder usb2phy properties for rk3588
      arm64: dts: rockchip: add USBDP phys on rk3588
      arm64: dts: rockchip: add USB3 DRD controllers on rk3588
      arm64: dts: rockchip: add USB3 to rk3588-evb1
      arm64: dts: rockchip: add upper USB3 port to rock-5a
      arm64: dts: rockchip: add lower USB3 port to rock-5b

Shengjiu Wang (5):
      arm64: dts: imx8mp: Add AUD2HTX device node
      arm64: dts: imx8mp-evk: Add HDMI audio sound card support
      arm64: dts: imx8mp-evk: Add PDM micphone sound card support
      ARM: dts: imx6sx-nitrogen6sx: drop incorrect cpu-dai property
      ARM: dts: imx6: exchange fallback and specific compatible string

Siddharth Manthan (1):
      arm64: dts: qcom: msm8916-samsung-fortuna: Add PWM backlight

Stanislav Jakubek (2):
      dt-bindings: arm: qcom: Add Motorola Moto G (2013)
      ARM: dts: qcom: Add support for Motorola Moto G (2013)

Stefan Eichenberger (6):
      arm64: dts: freescale: imx8mp-verdin: replace sleep-moci hog with =
regulator
      arm64: dts: freescale: imx8mp-verdin-dahlia: support sleep-moci
      arm64: dts: freescale: imx8mm-verdin: replace sleep-moci hog with =
regulator
      arm64: dts: freescale: imx8mm-verdin-dahlia: support sleep-moci
      arm64: dts: ti: k3-am62-verdin: replace sleep-moci hog with regula=
tor
      arm64: dts: ti: k3-am62-verdin-dahlia: support sleep-moci

Stefan Wahren (1):
      ARM: dts: imx6ull-tarragon: Reduce SPI clock for QCA7000

Stephen Boyd (2):
      arm64: dts: qcom: sc7180: Disable pmic pinctrl node on Trogdor
      arm64: dts: qcom: sc7180: Disable DCC node by default

Sukrut Bellary (1):
      arm64: dts: ti: k3-am625-beagleplay: Use mmc-pwrseq for wl18xx ena=
ble

Thanh Le (1):
      arm64: dts: renesas: r8a779h0: Add IPMMU nodes

Thanh Quan (3):
      arm64: dts: renesas: r8a779h0: Add CMT nodes
      arm64: dts: renesas: r8a779h0: Add TMU nodes
      arm64: dts: renesas: r8a779h0: Add MSIOF nodes

Thierry Reding (1):
      dt-bindings: display: tegra: Allow dma-coherent on Tegra194 and la=
ter

Tim Harvey (5):
      arm64: dts: imx8mp-venice-gw74xx-imx219.dtso: fix dt warning
      arm64: dts: imx8mp-venice-gw74xx: add ADC rail for VDD_1P0
      arm64: dts: imx8mp-venice-gw72xx: add mac addr for eth1
      arm64: dts: imx8mp-venice-gw73xx: add mac addr for eth1
      arm64: dts: imx8m*-venice-gw7: Fix TPM schema violations

Tony Lindgren (12):
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_CORE
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_DSP
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_IVA
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_GPU
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_DRR
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_GMAC
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_EVE
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_CORE
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_ABE_PLL_SYS
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_PER
      ARM: dts: dra7: Use clksel binding for CM_CLKSEL_DPLL_USB
      ARM: dts: dra7: Use clksel binding for CTRL_CORE_SMA_SW_0

Tudor Ambarus (11):
      ARM: dts: samsung: exynos3250: specify the SPI FIFO depth
      ARM: dts: samsung: exynos4: specify the SPI FIFO depth
      ARM: dts: samsung: exynos5250: specify the SPI FIFO depth
      ARM: dts: samsung: exynos5420: specify the SPI FIFO depth
      arm64: dts: exynos5433: specify the SPI FIFO depth
      arm64: dts: exynosautov9: specify the SPI FIFO depth
      ARM: dts: samsung: s5pv210: specify the SPI FIFO depth
      arm64: dts: exynos: gs101: move serial_0 pinctrl-0/names to dtsi
      arm64: dts: exynos: gs101: move pinctrl-* properties after clocks
      arm64: dts: exynos: gs101: join lines close to 80 chars
      arm64: dts: exynos: gs101: define all PERIC USI nodes

Udipto Goswami (1):
      arm64: dts: qcom: sm8450: Update SNPS Phy parameters for QRD platf=
orm

Udit Kumar (4):
      arm64: dts: ti: k3-j784s4-evm: Fix UART pin type and macro type
      arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro type
      arm64: dts: ti: k3-j721s2: Add main esm address range
      arm64: dts: ti: k3-j784s4: Add main esm address range

Umang Chheda (1):
      arm64: dts: qcom: qcm6490-idp: Name the regulators

Uwe Kleine-K=C3=B6nig (51):
      ARM: dts: bcm2711-rpi: Add pinctrl-based multiplexing for I2C0
      ARM: dts: bcm2711-rpi-cm4-io: Add RTC on I2C0
      ARM: dts: imx51-ts4800: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx53-m53evk: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx53-ppd: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx53-kp: Drop redundant settings in pwm nodes
      ARM: dts: imx53-tqma: Use #pwm-cells =3D <3> for imx27-pwm devices
      ARM: dts: imx6dl-aristainetos_4: Use #pwm-cells =3D <3> for imx27-=
pwm device
      ARM: dts: imx6dl-aristainetos_7: Use #pwm-cells =3D <3> for imx27-=
pwm device
      ARM: dts: imx6dl-mamoj: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6q-ba16: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6q-bosch-acc: Use #pwm-cells =3D <3> for imx27-pwm de=
vice
      ARM: dts: imx6qdl-apf6dev: Use #pwm-cells =3D <3> for imx27-pwm de=
vices
      ARM: dts: imx6qdl-aristainetos2: Use #pwm-cells =3D <3> for imx27-=
pwm device
      ARM: dts: imx6qdl-cubox-i: Use #pwm-cells =3D <3> for imx27-pwm de=
vice
      ARM: dts: imx6qdl-emcon: Use #pwm-cells =3D <3> for imx27-pwm devi=
ce
      ARM: dts: imx6qdl-gw52xx: Use #pwm-cells =3D <3> for imx27-pwm dev=
ice
      ARM: dts: imx6qdl-gw53xx: Use #pwm-cells =3D <3> for imx27-pwm dev=
ice
      ARM: dts: imx6qdl-gw54xx: Use #pwm-cells =3D <3> for imx27-pwm dev=
ice
      ARM: dts: imx6qdl-gw560x: Use #pwm-cells =3D <3> for imx27-pwm dev=
ice
      ARM: dts: imx6qdl-gw5903: Use #pwm-cells =3D <3> for imx27-pwm dev=
ice
      ARM: dts: imx6qdl-gw5904: Use #pwm-cells =3D <3> for imx27-pwm dev=
ice
      ARM: dts: imx6qdl-icore: Use #pwm-cells =3D <3> for imx27-pwm devi=
ce
      ARM: dts: imx6qdl-nit6xlite: Use #pwm-cells =3D <3> for imx27-pwm =
device
      ARM: dts: imx6qdl-nitrogen6_max: Use #pwm-cells =3D <3> for imx27-=
pwm device
      ARM: dts: imx6qdl-nitrogen6_som2: Use #pwm-cells =3D <3> for imx27=
-pwm device
      ARM: dts: imx6qdl-nitrogen6x: Use #pwm-cells =3D <3> for imx27-pwm=
 device
      ARM: dts: imx6qdl-phytec-mira: Use #pwm-cells =3D <3> for imx27-pw=
m device
      ARM: dts: imx6qdl-sabreauto: Use #pwm-cells =3D <3> for imx27-pwm =
device
      ARM: dts: imx6qdl-sabrelite: Use #pwm-cells =3D <3> for imx27-pwm =
device
      ARM: dts: imx6qdl-sabresd: Use #pwm-cells =3D <3> for imx27-pwm de=
vice
      ARM: dts: imx6qdl-savageboard: Use #pwm-cells =3D <3> for imx27-pw=
m device
      ARM: dts: imx6qdl-skov-cpu: Use #pwm-cells =3D <3> for imx27-pwm d=
evice
      ARM: dts: imx6q-kp: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6q-novena: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6q-pistachio: Use #pwm-cells =3D <3> for imx27-pwm de=
vice
      ARM: dts: imx6q-prti6q: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6q-var-dt6customboard: Use #pwm-cells =3D <3> for imx=
27-pwm device
      ARM: dts: imx6sl-evk: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6sll-evk: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6sx-nitrogen6sx: Use #pwm-cells =3D <3> for imx27-pwm=
 device
      ARM: dts: imx6sx-sdb: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6sx-softing-vining-2000: Use #pwm-cells =3D <3> for i=
mx27-pwm device
      ARM: dts: imx6ul-14x14-evk: Use #pwm-cells =3D <3> for imx27-pwm d=
evice
      ARM: dts: imx6ul-ccimx6ulsbcpro: Use #pwm-cells =3D <3> for imx27-=
pwm device
      ARM: dts: imx6ul-geam: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6ul-imx6ull-opos6uldev: Use #pwm-cells =3D <3> for im=
x27-pwm device
      ARM: dts: imx6ul-isiot: Use #pwm-cells =3D <3> for imx27-pwm device
      ARM: dts: imx6ul-kontron-bl-43: Use #pwm-cells =3D <3> for imx27-p=
wm device
      ARM: dts: imx6ul-kontron-bl-common: Use #pwm-cells =3D <3> for imx=
27-pwm device
      ARM: dts: imx6ul-pico: Use #pwm-cells =3D <3> for imx27-pwm device

Vignesh Raghavendra (1):
      arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards

Vitor Soares (1):
      arm64: dts: freescale: verdin-imx8mp: enable Verdin I2C_3_HDMI int=
erface

Volodymyr Babchuk (1):
      arm64: dts: qcom: sa8155p-adp: lower min volt for L13C regulator

Wadim Mueller (2):
      dt-bindings: arm: fsl: add NXP S32G3 board
      arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3

Wei Fang (1):
      arm64: dts: imx93-11x11-evk: add reset gpios for ethernet PHYs

Xu Yang (7):
      dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
      ARM: dts: imx6: remove fsl,anatop property from usb controller node
      arm64: dts: imx8ulp: add usb nodes
      arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
      arm64: dts: imx93: add usb nodes
      arm64: dts: imx93-11x11-evk: enable usb and typec nodes
      arm64: dts: imx8mm/n remove clock-names property from usb controll=
er node

Yang Xiwen (3):
      arm64: dts: hi3798cv200: fix the size of GICR
      arm64: dts: hi3798cv200: add GICH, GICV register space and irq
      arm64: dts: hi3798cv200: add cache info

Zev Weiss (1):
      ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings

   0.1% Documentation/devicetree/bindings/arm/bcm/
   0.0% Documentation/devicetree/bindings/arm/keystone/
   0.5% Documentation/devicetree/bindings/arm/
   0.2% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/display/panel/
   0.0% Documentation/devicetree/bindings/display/tegra/
   0.1% Documentation/devicetree/bindings/gpio/
   0.0% Documentation/devicetree/bindings/media/
   0.0% Documentation/devicetree/bindings/soc/qcom/
   0.2% Documentation/devicetree/bindings/soc/renesas/
   0.0% Documentation/devicetree/bindings/soc/samsung/
   0.0% Documentation/devicetree/bindings/usb/
   0.0% Documentation/devicetree/bindings/
   1.2% arch/arm/boot/dts/allwinner/
   0.0% arch/arm/boot/dts/aspeed/
   1.3% arch/arm/boot/dts/broadcom/
   0.2% arch/arm/boot/dts/nvidia/
   5.5% arch/arm/boot/dts/nxp/imx/
   9.4% arch/arm/boot/dts/qcom/
   3.0% arch/arm/boot/dts/renesas/
   0.1% arch/arm/boot/dts/samsung/
  14.8% arch/arm/boot/dts/st/
   0.0% arch/arm/boot/dts/ti/keystone/
   1.3% arch/arm/boot/dts/ti/omap/
   0.0% arch/arm64/boot/dts/actions/
   2.1% arch/arm64/boot/dts/allwinner/
   0.0% arch/arm64/boot/dts/altera/
   0.1% arch/arm64/boot/dts/amazon/
   0.0% arch/arm64/boot/dts/amd/
   0.1% arch/arm64/boot/dts/apm/
   0.0% arch/arm64/boot/dts/arm/
   0.0% arch/arm64/boot/dts/broadcom/bcmbca/
   0.0% arch/arm64/boot/dts/broadcom/northstar2/
   0.0% arch/arm64/boot/dts/broadcom/stingray/
   0.1% arch/arm64/boot/dts/cavium/
   4.5% arch/arm64/boot/dts/exynos/google/
   0.1% arch/arm64/boot/dts/exynos/
  11.9% arch/arm64/boot/dts/freescale/
   0.8% arch/arm64/boot/dts/hisilicon/
   0.0% arch/arm64/boot/dts/intel/
   0.0% arch/arm64/boot/dts/lg/
   0.5% arch/arm64/boot/dts/marvell/
   0.0% arch/arm64/boot/dts/mediatek/
   0.4% arch/arm64/boot/dts/microchip/
   0.0% arch/arm64/boot/dts/nuvoton/
   0.1% arch/arm64/boot/dts/nvidia/
   9.8% arch/arm64/boot/dts/qcom/
   0.0% arch/arm64/boot/dts/realtek/
   3.3% arch/arm64/boot/dts/renesas/
  18.9% arch/arm64/boot/dts/rockchip/
   0.0% arch/arm64/boot/dts/socionext/
   0.3% arch/arm64/boot/dts/sprd/
   2.1% arch/arm64/boot/dts/st/
   0.0% arch/arm64/boot/dts/synaptics/
   0.0% arch/arm64/boot/dts/tesla/
   3.1% arch/arm64/boot/dts/ti/
   0.0% arch/arm64/boot/dts/xilinx/
   0.4% arch/riscv/boot/dts/renesas/
   0.6% arch/riscv/boot/dts/sophgo/
   0.0% drivers/firmware/
   0.8% include/dt-bindings/clock/


 565 files changed, 23914 insertions(+), 5102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,f=
irmware-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesa=
s,r9a09g057-sys.yaml
 create mode 100644 arch/arm/boot/dts/allwinner/sun5i-a13-pocketbook-614=
-plus.dts
 create mode 100644 arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
 create mode 100644 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.d=
ts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-boar=
d-emmc.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-boar=
d-nand.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-boar=
d.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts
 create mode 100644 arch/arm/boot/dts/qcom/msm8226-motorola-falcon.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte-=
common.dtsi
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltec=
hn.dts
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-s=
hinano-common.dtsi
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-s=
hinano-leo.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h313-tanix-tx1.=
dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-r=
g35xx-2024.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-r=
g35xx-h.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-r=
g35xx-plus.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl=
28-var3.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.d=
ts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3=
dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2=
dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-navqp.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx=
234.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970-eagle-function-=
expansion.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-gameforce-chi.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-i=
o-expander.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.d=
ts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-gpi=
o-fan.dtso

