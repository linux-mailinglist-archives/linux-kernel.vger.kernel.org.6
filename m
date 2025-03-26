Return-Path: <linux-kernel+bounces-577496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9ADA71DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3873A7C54
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10533219300;
	Wed, 26 Mar 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="as6N+Qw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BG611Piy"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB92192EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011996; cv=none; b=HB9zcO+qu+LHc5ix4MSBU14joWfzlqBA2emNTpIFKr4Gzp+j+5wA/hTbfNxC28ef3hbI8j5iP68ZuVwXy6nMLaMMcb2BYcBjr1BtGIF4Fkk2nOo+3WJHw4Wwcsx1Fz4zZK+y350nH9ew4llBOgj7BFfwEX4VFt7NPEF416f/Bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011996; c=relaxed/simple;
	bh=lmEem6o/O9/SlsDN9hid3DMEoRV/wTFMaVL9CKQUwiQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dggA6DuXlXuj6JSM/PaEdc3YrL+qthPLr6C3osIHYSpUWyBr8QiKxGlAap8Ef9gM8VqfZNh++UYBFtJkJLtBCej3GSBdmh0Y67veuhKAjuQMJd23lWLrBXivSKz2RNozhUI+AD24UQe1bXWCnojP5p8gFXkaa46ItmzHmfj/VqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=as6N+Qw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BG611Piy; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A487225400C3;
	Wed, 26 Mar 2025 13:59:50 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 13:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743011990;
	 x=1743098390; bh=nX78AaVrQBajHUBIGsAX2O85FASWD97E/7UQQ6XAPHU=; b=
	as6N+Qw6LvC1D5/qfkWseRFltTJEJSzqFDvHypryBZk+tz/3pb6w+I2DypDgH1OE
	RkuftMQCK6bZwhPEQ+QlxVZgWziqWuFcfaBh7g+WhzifUHeuNCXCpT0Iq+SQckg/
	tqhK5pKT1eaut4GgIRsD8M1BdqCpdfFL7N3/g2dnOdMKtJNmxk3VM28GL0Dp1Fjt
	ST8YtkTsNe9M5I5H4OGDBgBP2HHh+a9MW5dW5LEZphA067UTn1r2ptxtXCLVZk7M
	rsLLgT+x36/Up4BH3+WqgHCho8i+Odq1onLF525S/XCgTcN4ZdAGAh7g9/LWawYH
	j6FnWmvaeJ+r/hfRUfQR4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743011990; x=
	1743098390; bh=nX78AaVrQBajHUBIGsAX2O85FASWD97E/7UQQ6XAPHU=; b=B
	G611Piy7fOgA+xj1HDbNk8BZFIo6hTHrTVojb+1UN2rzeHc/ktLK7bLeeDOdJgW1
	HhMs15avemedBaoXG7ute5op4SoDA9sgkCfL9diHKPvZf/27wM4AG/RdH3KwQpEE
	DNfsHd0G1deUn/gJsMktSKoNMz/AMwU23CYog3Ox+tkRFXrTbA8cVundj7AsUza+
	VDiNUQEbxIDTzQpJTYCzHq+qoCvXMjr490P3UyGYG6iq8B+W+Pohw4IPUK9OasFq
	XLOom6bRPZ7gUFCFHJqD4QOVi6Os+9F3gYtk5SsUdGIj516f6NwnO2XdUfcQ17Ow
	/K9aM7IXkLLvWLZUmEc8w==
X-ME-Sender: <xms:lkDkZ0JaKcrNcC3uqLTdxlFktao8xfQ1urOxpeKML-anSaX1JtvgXA>
    <xme:lkDkZ0LWgPPSxKT-AlTa3pHL6a70z7rpbUyBEgGp5a-CPCPF3uAYcwnJve3OvlzwU
    BToXuUWdoTjuLdjoco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfeeugeekffevueegheeiheeiudekgeefhfff
    uedttedtffetleeuhfehteekkedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlh
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsohgtsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lkDkZ0vekiZDu7eQcSffmhFsvHtSeJXoQTSi105HENaD2w_p3YpvJA>
    <xmx:lkDkZxZ0R5xD4F6ng4KYXqscPgd7Jk6FjK30fNGVa3iPGBcwKt5YyQ>
    <xmx:lkDkZ7b1QxF4CfZkYXU-7crabE_vvZPUi5n2NtlSPoBTvub822vkHQ>
    <xmx:lkDkZ9C-X0FJTRgfaLaYhO74y_7m_FbCDuAN4wjS22-RwD7JGs0hAg>
    <xmx:lkDkZ3Euk46xfIKOdLP_z7mK1uCgL79qD3XS7rYbiYBz3pJCxNkYrUKa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 394E22220072; Wed, 26 Mar 2025 13:59:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2e1b8447a49b63d2
Date: Wed, 26 Mar 2025 18:59:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev
Message-Id: <cd6b28a3-7e46-40a0-b846-8b44031eaed9@app.fastmail.com>
In-Reply-To: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
References: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
Subject: [GIT PULL 1/4] soc: devicetree updates for 6.15
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64=
319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.15

for you to fetch changes up to b82310b5729ef3ca0aefdc0cf0c575d52f227235:

  Merge tag 'amlogic-arm-dt-for-v6.15' of https://git.kernel.org/pub/scm=
/linux/kernel/git/amlogic/linux into soc/dt (2025-03-20 17:53:00 +0100)

----------------------------------------------------------------
soc: devicetree updates for 6.15

There is new support for additional on-chip devices on Apple, Mediatek,
Renesas, Rockchip, Samsung, Google, TI, ST, Nvidia and Amlogic devices.

The Arm Morello reference platform gets a devicetree for booting in
normal aarch64 mode. The hardware supports experimental CHERI support,
which requires a modified kernel.

The AMD (formerly Xilinx) Versal NET SoC gets added, this is a combined
FPGA with Cortex-A78 CPUs in a SoC.

Six new ST STM32MP2 SoC variants are added. Like the earlier STM32MP25,
the MP211, MP213, MP215, MP231, MP233 and MP235 models are based on one
or two Cortex-A35 cores but each feature a different set of I/O devices.

Mediatek MT8370 is a minor variation of MT8390 with fewer CPU and
GPU cores

Apple T2 is the baseboard management controller on earlier Intel CPU
based Macs, with 16 models now gaining initial support.

All the above come with dts files for the reference boards. In
addition, these boards are added for the SoCs that are already supported.

 - The Milk-V Jupiter board based on SpacemiT K1/M1

 - NetCube Systems Kumquat board based on the 32-bit Allwinner V3s SoC

 - Three boards based on 32-bit stm32mp1

 - 11 distinct board variants from Toradex and one from Variscite,
   all based on i.MX6

 - Google Pixel Pro 6 phone based on gs101 (Tensor)

 - Three additional variants of the i.MX8MP based "Skov" board

 - A second variant of the i.MX95 EVK board

 - Two boards based on Renesas SoCs

 - Four boards based the Rockchip RK35xx series, plus the RK3588
   "MNT Reform 2" laptop

----------------------------------------------------------------
Ahmad Fatoum (13):
      arm64: dts: imx8mp-skov: correct PMIC board limits
      arm64: dts: imx8mp-skov: operate CPU at 850 mV by default
      arm64: dts: imx8mp-skov: use I2C5 for DDC
      arm64: dts: imx8mp-skov: configure uart1 for RS485
      arm64: dts: imx8mp: Add optional nominal drive mode DTSI
      arm64: dts: imx8mp: add fsl,nominal-mode property into nominal.dtsi
      arm64: dts: freescale: imx8mp-skov: configure LDB clock automatica=
lly
      arm64: dts: freescale: imx8mp-skov: operate SoC in nominal mode
      dt-bindings: arm: fsl: add more compatibles for Skov i.MX8MP varia=
nts
      arm64: dts: imx8mp-skov: move I2C2 pin control group into DTSI
      arm64: dts: imx8mp-skov: describe I2C bus recovery for all control=
lers
      arm64: dts: imx8mp-skov: add revC BD500 board
      arm64: dts: imx8mp-skov: support new 7" panel board

Alexander Stein (19):
      ARM: dts: imx7s: Move csi-mux to below root
      arm64: dts: imx8-ss-hsio: Wire up DMA IRQ for PCIe
      arm64: dts: tqma8xx: Add vcc-supply for spi-nor
      arm64: dts: tqma8xx: enable jpeg encode and decode
      arm64: dts: tqma8xx: Remove GPU TODO
      arm64: dts: mba8xx: Add PCIe support
      arm64: dts: freescale: imx93-tqma9352-mba93xxca: sort pinctrl nodes
      arm64: dts: mba93xxca: Do not assert power-down pins
      arm64: dts: tqma9352-mba93xx[cl]a: swap ethernet aliases
      arm64: dts: freescale: tqma8mpql: Add vcc-supply for spi-nor
      arm64: dts: freescale: tqma8mq: Add vcc-supply for spi-nor
      arm64: dts: freescale: tqma8mqml: Add vcc-supply for spi-nor
      arm64: dts: freescale: tqma8mqnl: Add vcc-supply for spi-nor
      ARM: dts: imx6qdl-tqma6: Order DT properties
      ARM: dts: imx6ul-tqma6ul: Order DT properties
      ARM: dts: imx6ul-tqma6ul: Add vcc-supply for spi-nor
      ARM: dts: imx7-tqma7: Add vcc-supply for spi-nor
      arm64: dts: imx8qm-ss-hsio: Wire up DMA IRQ for PCIe
      arm64: dts: mba8xx: Remove invalid property disable-gpio

Alexandre Mergnat (2):
      arm64: dts: mediatek: add display blocks support for the MT8365 SoC
      arm64: dts: mediatek: add display support for mt8365-evk

Alexandre Torgue (3):
      arm64: dts: st: add stm32mp257f-dk board support
      arm64: dts: st: introduce stm32mp23 SoCs family
      arm64: dts: st: introduce stm32mp21 SoCs family

Alexey Charkov (5):
      arm64: dts: rockchip: Add finer-grained PWM states for the fan on =
Rock 5C
      arm64: dts: rockchip: Enable automatic fan control on Radxa Rock 5C
      arm64: dts: rockchip: switch Rock 5C to PMIC-based TSHUT reset
      arm64: dts: rockchip: Add SPDIF nodes to RK3588(s) device trees
      arm64: dts: rockchip: Enable SPDIF output on H96 Max V58

Amelie Delaunay (7):
      dt-bindings: stm32: document stm32mp257f-dk board
      arm64: Kconfig: expand STM32 Armv8 SoC with STM32MP21/STM32MP23 So=
Cs family
      dt-bindings: stm32: add STM32MP21 and STM32MP23 compatibles for sy=
scon
      dt-bindings: stm32: document stm32mp235f-dk board
      arm64: dts: st: add stm32mp235f-dk board support
      dt-bindings: stm32: document stm32mp215f-dk board
      arm64: dts: st: add stm32mp215f-dk board support

Andreas Kemnade (1):
      ARM: dts: ti/omap: omap4-serial: fix interrupts syntax

Andrej Picej (3):
      arm64: dts: imx8mm-phycore-som: Fix bluetooth wakeup source
      arm64: dts: imx8mm-phyboard-polis: Set RTC as wakeup-source
      arm64: dts: imx8mm-phygate-tauri-l: Set RTC as wakeup-source

Andr=C3=A9 Draszik (7):
      dt-bindings: arm: google: add gs101-raven
      arm64: dts: exynos: gs101-oriole: configure simple-framebuffer
      arm64: dts: exynos: gs101-oriole: move common Pixel6 & 6Pro parts =
into a .dtsi
      arm64: dts: exynos: gs101-raven: add new board file
      arm64: dts: exynos: gs101: drop explicit regmap from reboot nodes
      arm64: dts: exynos: gs101: align poweroff writes with downstream
      arm64: dts: exynos: gs101: add reboot-mode support (SYSIP_DAT0)

Andy Yan (5):
      arm64: dts: rockchip: Enable USB3 OTG on rk3588s Cool Pi 4B
      arm64: dts: rockchip: Add vop for rk3576
      arm64: dts: rockchip: Add hdmi for rk3576
      arm64: dts: rockchip: Enable hdmi display on sige5
      arm64: dts: rockchip: Enable hdmi out display for rk3576-evb-v10

AngeloGioacchino Del Regno (11):
      arm64: dts: mediatek: mt8188: Add VDO0's DSC and MERGE block nodes
      arm64: dts: mediatek: mt8188: Add tertiary eMMC/SD/SDIO controller
      dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP
      arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describ=
e USB
      arm64: dts: mediatek: mt8390-genio-700: Add USB, TypeC Controller,=
 MUX
      arm64: dts: mediatek: mt8188: Add base display controller graph
      arm64: dts: mediatek: mt8188-geralt: Add graph for DSI and DP disp=
lays
      arm64: dts: mediatek: mt8390-genio-common: Configure touch vreg pi=
ns
      arm64: dts: mediatek: mt8195: Add base display controller graph
      arm64: mediatek: mt8195-cherry: Add graph for eDP and DP displays
      arm64: dts: mediatek: mt8395-nio-12l: Preconfigure DSI0 pipeline

Antonin Godard (3):
      ARM: dts: imx6ul: Add Variscite VAR-SOM-MX6UL SoM support
      ARM: dts: imx6ul: Add Variscite Concerto board support
      dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and Concerto board

Arnd Bergmann (34):
      Merge tag 'asahi-soc-dt-6.15' of https://github.com/AsahiLinux/lin=
ux into soc/dt
      Merge tag 'ixp4xx-dts-soc-for-v6.15' of https://git.kernel.org/pub=
/scm/linux/kernel/git/linusw/linux-integrator into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.15-tag1' of https://git.kern=
el.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.15-tag1' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'asahi-soc-dt-6.15-v2' of https://github.com/AsahiLinux/=
linux into soc/dt
      Merge tag 'juno-updates-6.15' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into soc/dt
      Merge tag 'mtk-dts64-for-v6.15' of https://git.kernel.org/pub/scm/=
linux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'renesas-dts-for-v6.15-tag2' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'tegra-for-6.15-dt-bindings' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.15-arm64-dt-v2' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'v6.15-rockchip-dts64-1' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'asahi-soc-dt-6.15-v3' of https://github.com/AsahiLinux/=
linux into soc/dt
      Merge tag 'samsung-dt64-6.15' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux into soc/dt
      Merge tag 'davinci-updates-for-v6.15-rc1' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/brgl/linux into soc/dt
      Merge tag 'spacemit-dt-for-6.15-1' of https://github.com/spacemit-=
com/linux into soc/dt
      Merge tag 'imx-bindings-6.15' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.15' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.15' of https://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.15' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/ti/linux into soc/dt
      Merge tag 'stm32-dt-for-v6.15-1' of https://git.kernel.org/pub/scm=
/linux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'at91-dt-6.15' of https://git.kernel.org/pub/scm/linux/k=
ernel/git/at91/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.15' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'zynqmp-dt-for-6.14' of https://github.com/Xilinx/linux-=
xlnx into soc/dt
      Merge tag 'zynq-dt-for-6.15' of https://github.com/Xilinx/linux-xl=
nx into soc/dt
      Merge tag 'v6.15-rockchip-dts64-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'mvebu-dt64-6.15-1' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'riscv-sophgo-dt-for-v6.15' of https://github.com/sophgo=
/linux into soc/dt
      Merge tag 'omap-for-v6.15/dt-signed' of https://git.kernel.org/pub=
/scm/linux/kernel/git/khilman/linux-omap into soc/dt
      Merge tag 'riscv-dt-for-v6.15' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/conor/linux into soc/dt
      Merge tag 'hisi-arm64-dt-for-6.15' of https://github.com/hisilicon=
/linux-hisi into soc/dt
      Merge tag 'tegra-for-6.15-arm-dt' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'dt-cleanup-6.15' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.15-v2' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'amlogic-arm-dt-for-v6.15' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/dt

Biju Das (2):
      arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
      arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog

Chancel Liu (6):
      ARM: dts: imx6ul-14x14-evk: Complete WM8960 power supplies
      ARM: dts: imx7d-sdb: Complete WM8960 power supplies
      arm64: dts: imx8mp-evk: Complete WM8960 power supplies
      arm64: dts: imx8dxl-evk: Complete WM8960 power supplies
      arm64: dts: imx8qm-mek: Complete WM8960 power supplies
      arm64: dts: imx8qxp-mek: Complete WM8960 power supplies

Chen Wang (3):
      riscv: sophgo: dts: add pwm controller for SG2042 SoC
      riscv: sophgo: dts: add pwm-fan for Milk-V Pioneer
      riscv: sophgo: dts: add cooling maps for Milk-V Pioneer

Chen-Yu Tsai (4):
      arm64: dts: mediatek: mt8173-elm: Drop pmic's #address-cells and #=
size-cells
      arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string
      arm64: dts: mediatek: mt8173: Fix some node names
      arm64: dts: rockchip: Remove bluetooth node from rock-3a

Chris Morgan (5):
      arm64: dts: rockchip: remove rk3588 optee node
      arm64: dts: allwinner: h700: Set cpusldo to always-on for RG35XX
      arm64: dts: allwinner: h700: Add LED1 for Anbernic RG35XX
      arm64: dts: allwinner: h700: Add USB Host for RG35XX-H
      arm64: dts: allwinner: rg35xx: Add no-thermistor property for batt=
ery

Christian Marangi (3):
      arm64: dts: airoha: en7581: Add Clock Controller node
      arm64: dts: airoha: en7581: Add SNAND node
      arm64: dts: airoha: en7581: Add default partition table for EVB bo=
ard

Chukun Pan (4):
      dt-bindings: mfd: syscon: Add rk3528 QoS register compatible
      arm64: dts: rockchip: Add rk3528 QoS register node
      arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
      arm64: dts: rockchip: Move rk356x scmi SHMEM to reserved memory

Ciprian Marian Costea (4):
      arm64: dts: s32g: add I2C[0..2] support for s32g2 and s32g3
      arm64: dts: s32g: add common 'S32G-EVB' and 'S32G-RDB' board suppo=
rt
      arm64: dts: s32g399a-rdb3: Add INA231 sensor entry over I2C4
      arm64: dts: s32g: add FlexCAN[0..3] support for s32g2 and s32g3

Claudiu Beznea (5):
      arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describ=
e different switches
      arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
      arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
      arm64: dts: renesas: r9a08g045: Enable SYS node
      arm64: dts: renesas: r9a08g045: Add OPP table

Conor Dooley (3):
      riscv: dts: microchip: update pcie reg properties to new format
      loongarch: dts: remove non-existent DAC from 2k1000-ref
      riscv: dts: starfive: remove non-existent dac from jh7110

Cristian Ciocaltea (8):
      arm64: dts: rockchip: Enable HDMI0 PHY clk provider on RK3588
      arm64: dts: rockchip: Add HDMI0 PHY PLL clock source to VOP2 on RK=
3588
      arm64: dts: rockchip: Add PHY node for HDMI1 TX port on RK3588
      arm64: dts: rockchip: Add HDMI1 node on RK3588
      arm64: dts: rockchip: Enable HDMI1 on rock-5b
      arm64: dts: rockchip: Enable HDMI1 PHY clk provider on RK3588
      arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2 on RK=
3588
      arm64: dts: rockchip: Enable HDMI1 on rk3588-evb1

Damon Ding (1):
      arm64: dts: rockchip: Fix label name of hdptxphy for RK3588

Daniel Schultz (1):
      arm64: dts: ti: am64-phyboard-electra: Add DT overlay for X27 conn=
ector

Dario Binacchi (5):
      ARM: dts: stm32: add led to stm32f746 Discovery board
      ARM: dts: stm32: add push button to stm32f746 Discovery board
      ARM: dts: stm32: rename LEDs nodes for stm32f769-disco
      ARM: dts: stm32: add usr3 LED node to stm32f769-disco
      ARM: dts: stm32: use IRQ_TYPE_EDGE_FALLING on stm32mp157c-dk2

Detlev Casanova (6):
      dt-bindings: arm: rockchip: Add Radxa ROCK 4D board
      arm64: dts: rockchip: Add HDMI audio outputs for rk3588
      arm64: dts: rockchip: Enable HDMI audio outputs for Rock 5B
      arm64: dts: rockchip: Add HDMI support for rock-4d
      arm64: dts: rockchip: Add SFC nodes for rk3576
      arm64: dts: rockchip: Add SPI NOR device on the ROCK 4D

Devang Tailor (1):
      arm64: dts: exynosautov920: add CPU cache information

Diederik de Haas (1):
      arm64: dts: rockchip: add 'chassis-type' property on PineNote

Diogo Ivo (4):
      arm64: tegra: p2597: Fix gpio for vdd-1v8-dis regulator
      arm64: tegra: Define pinmuxing for gpio pads on Tegra210
      arm64: tegra: p2597: Enable TCA9539 as IRQ controllers
      arm64: tegra: p2180: Add TMP451 temperature sensor node

Dominik Haller (1):
      arm64: dts: imx8mm-phycore-som: Add overlay for rproc

Dragan Simic (3):
      arm64: dts: rockchip: Describe why is HWRNG disabled in RK356x bas=
e dtsi
      arm64: dts: rockchip: Use "dma-noncoherent" in base RK3588 SoC dtsi
      arm64: dts: rockchip: linewrap gmac assigned-clocks on Quartz64 Mo=
del A/B files a bit

E Shattow (2):
      riscv: dts: starfive: jh7110: pciephy0 USB 3.0 configuration regis=
ters
      riscv: dts: starfive: jh7110-pine64-star64: enable USB 3.0 port

Ernest Van Hoecke (2):
      ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
      ARM: dts: apalis/colibri-imx6: Add support for v1.2

FUKAUMI Naoki (1):
      arm64: dts: rockchip: Enable USB OTG for Radxa ROCK Pi E

Fabien Parent (1):
      arm64: dts: mediatek: mt8395-genio-1200-evk: add support for TCPC =
port

Fabio Estevam (9):
      ARM: dts: imx53-ppd: Fix touchscreen reset-gpios
      ARM: dts: vfxxx: Fix the CAAM job ring node names
      ARM: dts: imx5: Fix the CCM interrupts description
      ARM: dts: vf610-bk4: Use the more specific "lwn,bk4-spi"
      ARM: dts: imx28-sps1: Fix GPIO LEDs description
      arm64: dts: imx8mn-bsh-smm-s2pro: Remove invalid audio codec clock
      ARM: dts: vfxxx: Fix the order of the DMA entries
      ARM: dts: imx31: Use nand-controller as node name
      ARM: dts: imx53-mba53: Fix the PCA9554 compatible

Francesco Dolcini (6):
      arm64: dts: freescale: imx8mm-verdin: Remove LVDS panel and backli=
ght
      arm64: dts: ti: k3-am62p: Enable AUDIO_REFCLKx
      dt-bindings: arm: fsl: drop usage of Toradex SOMs compatible alone
      ARM: dts: imx6qdl-apalis/colibri: Remove compatible from SoM dtsi
      ARM: dts: vf610-colibri: Remove compatible from SoM dtsi
      arm64: dts: imx8qm-apalis: Remove compatible from SoM dtsi

Frank Li (13):
      arm64: dts: imx8mq-librem5: remove undocument property 'extcon' fo=
r usb-pd@3f
      arm64: dts: imx8qm-mek: add audio-codec cs42888 and related nodes
      arm64: dts: imx8-ss-hsio: fix indentation in pcie node
      arm64: dts: imx8q: add PCIe EP for i.MX8QM and i.MX8QXP
      arm64: dts: imx8q: add PCIe EP overlay file for i.MX8QXP mek board
      arm64: dts: imx95: add PCIe's msi-map and iommu-map property
      arm64: dts: imx95: Add #io-channel-cells =3D <1> for adc node
      arm64: dts: imx95: Add i3c1 and i3c2
      arm64: dts: imx95: Add imx95-15x15-evk support
      dt-bindings: arm: fsl: add i.MX95 15x15 EVK board
      arm64: dts: im8mq-librem5: move dwc3 usb port under ports
      arm64: dts: imx95: add ref clock for pcie nodes
      arm64: dts: imx93: add ddr edac support

Frieder Schrempf (3):
      arm64: dts: imx8mm-kontron: Add support for reading SD_VSEL signal
      arm64: dts: imx93-kontron: Fix SD card IO voltage control
      arm64: dts: imx8mp-kontron: Add support for reading SD_VSEL signal

Geert Uytterhoeven (6):
      arm64: dts: renesas: r8a774c0: Re-add voltages to OPP table
      arm64: dts: renesas: r8a77990: Re-add voltages to OPP table
      arm64: dts: renesas: gray-hawk-single: Restore sort order
      arm64: dts: renesas: r8a779g0: Restore sort order
      arm64: dts: renesas: r8a779f0: Disable rswitch ports by default
      ARM: dts: renesas: r9a06g032: Fix UART dma channel order

Hector Martin (1):
      arm64: dts: apple: t8103: Fix spi4 power domain sort order

Heiko Stuebner (5):
      dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
      arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
      arm64: dts: rockchip: add rk3576 otp node
      Merge branch 'v6.15-shared/clkids' into v6.15-armsoc/dts64
      arm64: dts: rockchip: add usb typec host support to rk3588-jaguar

Hrushikesh Salunke (1):
      arm64: dts: ti: k3-j722s-evm: Fix USB2.0_MUX_SEL to select Type-C

Hsin-Te Yuan (1):
      arm64: dts: mediatek: mt8183: Switch to Elan touchscreen driver

Hugues KAMBA MPIANA (1):
      arm64: dts: corstone1000: Add definitions for secondary CPU cores

Igor Belwon (3):
      dt-bindings: clock: exynos990: Add CMU_PERIS block
      arm64: dts: exynos990: Add CMU_PERIS and MCT nodes
      arm64: dts: exynos990: Rename and sort PMU nodes

Inochi Amaoto (1):
      MAINTAINERS: update info for SOPHGO DEVICETREES and DRIVERS

Ivaylo Ivanov (6):
      dt-bindings: soc: samsung: usi: add USIv1 and samsung,exynos8895-u=
si
      arm64: dts: exynos8895: add syscon nodes for peric0/1 and fsys0/1
      arm64: dts: exynos8895: define all usi nodes
      arm64: dts: exynos8895: add a node for mmc
      arm64: dts: exynos8895-dreamlte: enable support for microSD storage
      arm64: dts: exynos8895-dreamlte: enable support for the touchscreen

Jagan Teki (1):
      arm64: dts: rockchip: Enable HDMI1 out for Edgeble-6TOPS Modules

Janine Hagemann (1):
      arm64: dts: imx8mm-phyboard-polis: Add overlay for PEB-EVAL-01

Janne Grunau (4):
      arm64: dts: apple: t8103: Add spi controller nodes
      arm64: dts: apple: t8112: Add spi controller nodes
      arm64: dts: apple: t600x: Add spi controller nodes
      arm64: dts: apple: Add SPI NOR nvram partition to all devices

Javier Martinez Canillas (2):
      dt-bindings: riscv: spacemit: Add Milk-V Jupiter board compatible
      riscv: dts: spacemit: Add Milk-V Jupiter board device tree

Jayesh Choudhary (1):
      arm64: dts: ti: k3-j784s4-evm-quad-port-eth-exp1: Remove duplicate=
 hogs

Jianfeng Liu (5):
      arm64: dts: rockchip: Enable HDMI on armsom-sige7
      arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
      arm64: dts: rockchip: Add AP6275P wireless support to ArmSoM Sige7
      arm64: dts: rockchip: Enable HDMI audio output for ArmSoM Sige7
      arm64: dts: rockchip: Fix pcie reset gpio on Orange Pi 5 Max

Jimmy Hon (10):
      arm64: dts: rockchip: Enable HDMI1 on Orange Pi 5 Max
      arm64: dts: rockchip: Adapt to differences between Orange Pi 5 Max=
 and Ultra
      dt-bindings: arm: rockchip: Add Xunlong Orange Pi 5 Ultra
      arm64: dts: rockchip: Add Orange Pi 5 Ultra board
      arm64: dts: rockchip: Enable HDMI1 on Orange Pi 5 Ultra
      arm64: dts: rockchip: Enable HDMI1 audio output for Orange Pi 5 Ul=
tra
      arm64: dts: rockchip: Enable HDMI0 audio output for Orange Pi 5/5B
      arm64: dts: rockchip: Enable HDMI audio outputs for Orange Pi 5 Max
      arm64: dts: rockchip: Enable HDMI1 on Orange Pi 5 Plus
      arm64: dts: rockchip: Enable HDMI audio outputs for Orange Pi 5 Pl=
us

John Madieu (3):
      dt-bindings: soc: renesas: Add RZ/G3E variant SYS binding
      arm64: dts: renesas: r9a09g047: Add SYS node
      arm64: dts: renesas: r9a09g057: Enable SYS node

Jon Hunter (1):
      arm64: tegra: Resize aperture for the IGX PCIe C5 slot

Jonas Karlman (9):
      dt-bindings: soc: rockchip: Add RK3528 ioc grf syscon
      arm64: dts: rockchip: Add pinctrl and gpio nodes for RK3528
      arm64: dts: rockchip: Add uart0 pinctrl to Radxa E20C
      arm64: dts: rockchip: Add leds node to Radxa E20C
      arm64: dts: rockchip: Add user button to Radxa E20C
      arm64: dts: rockchip: Add SARADC node for RK3528
      arm64: dts: rockchip: Add maskrom button to Radxa E20C
      arm64: dts: rockchip: Add SDHCI controller for RK3528
      arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C

Julien Massot (4):
      dt-bindings: soc: renesas: Document MYIR Remi Pi board
      arm64: dts: renesas: Add initial support for MYIR Remi Pi
      arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI DSI port
      arm64: dts: mediatek: mt8395-radxa-nio-12l: Add Radxa 8 HD panel

Junhao Xie (3):
      dt-bindings: vendor-prefixes: Add prefix for Ariaboard
      dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
      arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568

Keerthy (1):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size

Kever Yang (1):
      dt-bindings: vendor-prefixes: Update rockchip company name

Krzysztof Kozlowski (15):
      ARM: dts: ti: davinci: Align GPIO hog name with bindings
      Merge branch 'for-v6.15/samsung-clk-dt-bindings' into next/dt64
      Merge branch 'for-v6.15/samsung-soc-dt-bindings' into next/dt64
      ARM: dts: ti: omap: Align GPIO hog name with bindings
      arm64: dts: exynos8895: Rename PMU nodes to fixup sorting
      ARM: dts: cirrus: ep7211: Align GPIO hog name with bindings
      ARM: dts: nxp: vf: Align GPIO hog name with bindings
      arm64: dts: renesas: eagle-function-expansion: Align GPIO hog name=
 with bindings
      arm64: dts: rockchip: Add ES8388 audio codec fallback on RK3399 RO=
C PC PLUS
      arm64: dts: rockchip: Add ES8388 audio codec fallback on RK3588 bo=
ards
      arm64: dts: exynos: gs101: Change labels to lower-case
      arm64: dts: tesla: Change labels to lower-case
      arm64: dts: marvell: armada-8040: Align GPIO hog name with bindings
      ARM: dts: marvell: kirkwood-openrd: Align GPIO hog name with bindi=
ngs
      ARM: dts: marvell: armada: Align GPIO hog name with bindings

Kuninori Morimoto (1):
      arm64: dts: renesas: ulcb/kf: Use TDM Split Mode for capture

Lad Prabhakar (2):
      arm64: dts: renesas: r9a09g057: Add Mali-G31 GPU node
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable Mali-G31

Larisa Grigore (1):
      arm64: dts: s32g: add the eDMA nodes

Laurentiu Mihalcea (2):
      arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
      arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz

Leo Yan (1):
      arm64: dts: hi3660: Add property for fixing CPUIdle

Leonard G=C3=B6hrs (2):
      dt-bindings: arm: stm32: add compatible strings for Linux Automati=
on GmbH LXA FairyTux 2
      ARM: dts: stm32: lxa-fairytux2: add Linux Automation GmbH FairyTux=
 2

Linus Walleij (3):
      ARM: dts: Properly assign NPE to ethA
      ARM: dts: ixp4xx: Fix up PCI on WG302
      ARM: dts: ixp4xx: Add Netgear WG302 v1 GPIOs

Lorenzo Bianconi (2):
      arm64: dts: airoha: en7581: Add more nodes to EN7581 SoC evaluatio=
n board
      arm64: dts: airoha: en7581: Fix clock-controller address

Louis-Alexis Eyraud (5):
      dt-bindings: arm: mediatek: add mt8370-evk board
      arm64: dts: mediatek: add support for MT8370 SoC
      arm64: dts: mediatek: mt8390-genio-700-evk: Move common parts to d=
tsi
      arm64: dts: mediatek: add device-tree for Genio 510 EVK board
      arm64: dts: mediatek: mt8390-genio-common: Fix duplicated regulato=
r name

Lucas Stach (1):
      arm64: dts: imx8mp: configure GPU and NPU clocks to overdrive rate

Lukas Schmid (4):
      dt-bindings: vendor-prefixes: Add NetCube Systems Austria name
      dt-bindings: arm: sunxi: Add NetCube Systems Kumquat board
      ARM: dts: sunxi: add uart1_pe pinctrl for sun8i-v3s
      ARM: dts: sunxi: add support for NetCube Systems Kumquat

Lukasz Majewski (2):
      dt-bindings: arm: Document the btt3 i.MX28 based board
      ARM: dts: mxs: Add descriptions for imx287 based btt3-[012] devices

Macpaul Lin (2):
      arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec
      dt-bindings: usb: mtu3: Add ports property

Marek Vasut (9):
      arm64: dts: renesas: r8a779f0: Add labels for rswitch ports
      arm64: dts: renesas: spider-ethernet: Access rswitch ports via pha=
ndles
      arm64: dts: renesas: s4sk: Access rswitch ports via phandles
      arm64: dts: renesas: spider-ethernet: Add ethernetN aliases for rs=
witch
      arm64: dts: renesas: s4sk: Fix ethernet0 alias for rswitch
      ARM: dts: renesas: rcar-gen2: Add boot phase tags
      arm64: dts: renesas: rcar: Add boot phase tags
      arm64: dts: renesas: rzg2: Add boot phase tags
      ARM: dts: stm32: Add support for STM32MP13xx DHCOR SoM and DHSBC r=
ev.200 board

Markus Niebel (10):
      ARM: dts: imx6qdl-mba6: change sound card model name
      ARM: dts: imx7-mba7: change sound card model name
      ARM: dts: mba6ul: change sound card model name
      ARM: dts: imx6qdl-tqma6: limit PMIC SW4 to 3.3V
      ARM: dts: imx6qdl-tqma6: use sw4_reg as 3.3V supply
      ARM: dts: imx6qdl-tqma6: Add partitions subnode to spi-nor
      ARM: dts: tqma6ul: Add partitions subnode to spi-nor
      ARM: dts: tqma7: Add partitions subnode to spi-nor
      arm64: dts: imx8mp-tqma8mpql-mba8mpxl: change sound card model name
      arm64: dts: mba8mx: change sound card model name

Markus Schneider-Pargmann (2):
      arm64: dts: ti: k3-am62x-sk-common: Add serial aliases
      arm64: dts: ti: k3-am62a7-sk: Add serial alias

Martin Blumenstingl (5):
      ARM: dts: amlogic: meson8: switch to the new PWM controller binding
      ARM: dts: amlogic: meson8b: switch to the new PWM controller bindi=
ng
      arm64: dts: amlogic: gx: switch to the new PWM controller binding
      arm64: dts: amlogic: axg: switch to the new PWM controller binding
      arm64: dts: amlogic: g12: switch to the new PWM controller binding

Mathew McBride (1):
      arm64: dts: freescale: ten64: add usb hub definition

Max Merchel (1):
      ARM: dts: imx6ul-tqma6ul1: Change include order to disable fec2 no=
de

Michael Walle (2):
      arm64: dts: ti: k3-am62p: fix pinctrl settings
      arm64: dts: ti: k3-j722s: fix pinctrl settings

Michal Simek (16):
      ARM: zynq: Remove deprecated device_type property
      ARM: zynq: DT: List OCM memory for all platforms
      ARM: zynq: Mark boot-phase-specific device nodes
      ARM: zynq: Wire smcc with nand/nor memories on zc770 platform
      ARM: zynq: Define u-boot bootscrip addr via DT
      ARM: zynq: Point via nvmem0 alias to eeprom on zc702/zc706
      ARM: zynq: Define rtc alias on zc702/zc706
      ARM: zynq: Rename i2c?-gpio to i2c?-gpio-grp
      ARM: zynq: Fix fpga region DT nodes name
      ARM: zynq: Enable QSPIs on platforms
      ARM: zynq: Add sdhci to alias node
      ARM: zynq: Remove ethernet0 alias from Microzed
      ARM: zynq: Do not define address/size-cells for nand-controller
      arm64: versal-net: Add description for b2197-00 revA board
      arm64: zynqmp: Use DT header for firmware constants
      dt-bindings: xilinx: Deprecate header with firmware constants

Mihai Sain (2):
      ARM: dts: microchip: sama7d65: Add flexcom 10 node
      ARM: dts: microchip: sama7d65_curiosity: Add power monitor support

Naman Trivedi (1):
      arm64: zynqmp: add clock-output-names property in clock nodes

Nayab Sayed (1):
      ARM: dts: microchip: sama7g5: add ADC hw trigger edge type

Nick Chan (29):
      arm64: dts: apple: Split s8000/s8003 SoC DTS files
      dt-bindings: arm: apple: Add T2 devices
      arm64: dts: apple: Add T2 devices
      dt-bindings: arm: apple: apple,pmgr: Add A7-A11, T2 compatibles
      dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11, T2 compa=
tibles
      arm64: dts: apple: s5l8960x: Add PMGR node
      arm64: dts: apple: t7000: Add PMGR node
      arm64: dts: apple: t7001: Add PMGR node
      arm64: dts: apple: s800-0-3: Add PMGR nodes
      arm64: dts: apple: s8001: Add PMGR nodes
      arm64: dts: apple: t8010: Add PMGR nodes
      arm64: dts: apple: t8011: Add PMGR nodes
      arm64: dts: apple: t8012: Add PMGR nodes
      arm64: dts: apple: t8015: Add PMGR nodes
      arm64: dts: apple: s5l8960x: Add cpufreq nodes
      arm64: dts: apple: t7000: Add cpufreq nodes
      arm64: dts: apple: t7001: Add cpufreq nodes
      arm64: dts: apple: Add cpufreq nodes for S8000/S8003
      arm64: dts: apple: s8001: Add cpufreq nodes
      arm64: dts: apple: t8010: Add cpufreq nodes
      arm64: dts: apple: t8011: Add cpufreq nodes
      arm64: dts: apple: t8012: Add cpufreq nodes
      arm64: dts: apple: t8015: Add cpufreq nodes
      arm64: dts: apple: t7000: Add missing CPU p-state 7 for J96 and J97
      arm64: dts: apple: s5l8960x: Add backlight nodes
      arm64: dts: apple: t7000: Add backlight nodes
      arm64: dts: apple: s800-0-3: Add backlight nodes
      arm64: dts: apple: t8010: Add backlight nodes
      arm64: dts: apple: t8015: Add backlight nodes

Nicolas Frattaroli (4):
      arm64: dts: rockchip: Add rng node to RK3588
      dt-bindings: clock: rk3576: add SCMI clocks
      arm64: dts: rockchip: fix RK3576 SCMI clock IDs
      arm64: dts: rockchip: remove ethm0_clk0_25m_out from Sige5 gmac0

Niklas S=C3=B6derlund (7):
      arm64: dts: renesas: r8a779h0: Remove #address- and #size-cells fr=
om AVB[0-2]
      arm64: dts: renesas: gray-hawk-single: Describe AVB1 and AVB2
      arm64: dts: renesas: r8a779a0: Add FCPVX instances
      arm64: dts: renesas: r8a779a0: Add VSPX instances
      arm64: dts: renesas: r8a779h0: Add FCPVX instance
      arm64: dts: renesas: r8a779h0: Add VSPX instance
      arm64: dts: renesas: white-hawk-csi-dsi: Use names for CSI-2 data =
line orders

Ninad Malwade (1):
      arm64: tegra: Remove the Orin NX/Nano suspend key

Nishanth Menon (1):
      arm64: dts: ti: k3-am625-beagleplay: Reserve 128MiB of global CMA

Nobuhiro Iwamatsu (4):
      dt-bindings: soc: renesas: Document more Renesas RZ/V2H SoC varian=
ts
      dt-bindings: vendor-prefixes: Add Yuridenki-Shokai Co. Ltd.
      dt-bindings: soc: renesas: Document Yuridenki-Shokai Kakip board
      arm64: dts: renesas: Add initial device tree for Yuridenki-Shokai =
Kakip board

N=C3=ADcolas F. R. A. Prado (3):
      arm64: dts: mediatek: mt8188: Assign apll1 clock as parent to avoi=
d hang
      arm64: dts: mediatek: mt8390-genio-common: Add routes for DMIC
      arm64: dts: mediatek: mt8390-genio-common: Add delay codec for DMIC

Oleksij Rempel (12):
      arm64: dts: imx8mp-skov: describe HDMI display pipeline
      arm64: dts: imx8mp-skov: describe LVDS display pipeline
      arm64: dts: imx8mp-skov: describe mains fail detection
      arm64: dts: imx8mp-skov: fix phy-mode
      arm64: dts: imx8mp-skov: increase I2C clock frequency for RTC
      dt-bindings: vendor-prefixes: Add prefix for Priva
      dt-bindings: arm: stm32: Add Priva E-Measuringbox board
      arm64: dts: imx8mp-skov: add basic board as fallback
      dt-bindings: sound: convert ICS-43432 binding to YAML
      dt-bindings: arm: stm32: Add Plymovent AQM board
      ARM: dts: stm32: Add pinmux groups for Plymovent AQM board
      ARM: dts: stm32: Add Plymovent AQM devicetree

Patrick Wildt (2):
      dt-bindings: arm: rockchip: Add MNT Reform 2 (RCORE)
      arm64: dts: rockchip: add MNT Reform 2 laptop

Peter Griffin (1):
      arm64: dts: exynos: gs101: disable pinctrl_gsacore node

Quentin Schulz (17):
      arm64: dts: rockchip: add support for sound output over HDMI on RK=
3399 Puma Haikou
      arm64: dts: rockchip: add overlay test for WolfVision PF5
      arm64: dts: rockchip: add overlay test for Edgeble NCM6A/NCM6B
      arm64: dts: rockchip: add overlay tests for Rock 5B PCIe overlays
      arm64: dts: rockchip: minimal support for Pre-ICT tester adapter f=
or RK3588 Jaguar
      arm64: dts: rockchip: add support for HAIKOU-LVDS-9904379 adapter =
for PX30 Ringneck
      arm64: dts: rockchip: add overlay for PX30 Ringneck Haikou Video D=
emo adapter
      arm64: dts: rockchip: add overlay for RK3399 Puma Haikou Video Dem=
o adapter
      arm64: dts: rockchip: enable UART5 on RK3588 Tiger Haikou
      arm64: dts: rockchip: move DDC bus from Haikou carrierboard to RK3=
399 Puma DTSI
      arm64: dts: rockchip: move I2C6 from Haikou carrierboard to Puma D=
TSI
      arm64: dts: rockchip: disable I2C6 on Puma DTSI
      arm64: dts: rockchip: enable I2S0 in Haikou carrierboard, not Puma=
 DTSI
      arm64: dts: rockchip: add EEPROM found on RK3399 Puma Haikou
      arm64: dts: rockchip: enable Ethernet in Haikou carrierboard, not =
Puma DTSI
      arm64: dts: rockchip: enable I2C3 in Haikou carrierboard, not Ring=
neck DTSI
      arm64: dts: rockchip: disable I2C2 bus by default on RK3588 Tiger

Rafael Beims (1):
      arm64: dts: colibri-imx8x: Add missing gpio-line-names

Roan van Dijk (2):
      ARM: dts: stm32: Add thermal support for STM32MP131
      ARM: dts: stm32: Add Priva E-Measuringbox devicetree

Rob Herring (Arm) (14):
      dt-bindings: marvell: armada-37xx: Add glinet,gl-mv1000 compatible
      dt-bindings: marvell: armada-7k-8k: Move Armada 8KPlus to schema
      dt-bindings: marvell: armada-7k-8k: Add missing 7040 and 8040 boar=
d compatibles
      arm64: dts: marvell: Drop incomplete root compatible/model propert=
ies
      arm64: dts: marvell: Fix missing/incorrect "marvell,armada3710" co=
mpatible
      arm64: dts: marvell: Add missing board compatible for IEI-Puzzle-M=
801
      arm64: dts: nvidia: Remove unused and undocumented "regulator-ramp=
-delay-scale" property
      arm64: dts: amd/seattle: Base Overdrive B1 on top of B0 version
      arm64: dts: amd/seattle: Move and simplify fixed clocks
      arm64: dts: amd/seattle: Fix bus, mmc, and ethernet node names
      arm64: dts: amd/seattle: Drop undocumented "spi-controller" proper=
ties
      arm64: dts: marvell: Move arch timer and pmu nodes to top-level
      arm64: dts: marvell: Drop unused CP11X_TYPE define
      arm64: dts: marvell: Use preferred node names for "simple-bus"

Ryan Wanner (9):
      ARM: dts: microchip: sama7d65: Add chipID for sama7d65
      ARM: dts: microchip: sama7d65: Add DMAs to sama7d65 SoC
      ARM: dts: microchip: sama7d65: Enable DMAs
      ARM: dts: microchip: sama7d65: Add Reset Controller to sama7d65 SoC
      ARM: dts: microchip: sama7d65: Add Shutdown controller support
      ARM: dts: microchip: sama7d65: Add RTC support for sama7d65
      ARM: dts: microchip: sama7d65: Add SFRBU support to sama7d65
      ARM: dts: microchip: sama7d65: Enable shutdown controller
      ARM: dts: microchip: sama7d65: Add watchdog for sama7d65

Sai Krishna Potthuri (1):
      ARM: zynq: Replace 'io-standard' with 'power-source' property

Sai Sree Kartheek Adivi (1):
      arm64: dts: ti: k3-am62a-mcu: enable mcu domain pinmux

Sandie Cao (1):
      riscv: dts: starfive: fml13v01: enable pcie1

Sasha Finkelstein (2):
      arm64: dts: apple: Add touchbar digitizer nodes
      arm64: dts: apple: Add touchbar screen nodes

Sebastian Reichel (2):
      arm64: dts: rockchip: Add GPU power domain regulator dependency fo=
r RK3588
      arm64: dts: rockchip: Enable HDMI receiver on rock-5b

Shengyu Qu (1):
      riscv: dts: starfive: Unify regulator naming scheme

Shreeya Patel (1):
      arm64: dts: rockchip: Add device tree support for HDMI RX Controll=
er

Shubhrajyoti Datta (1):
      dt-bindings: soc: Add new VN-X board description based on Versal N=
ET

Shuosheng Huang (1):
      arm64: dts: allwinner: a100: Add CPU Operating Performance Points =
table

Siddharth Vadapalli (6):
      arm64: dts: ti: k3-am62a7-sk: Add boot phase tag for USB0
      arm64: dts: ti: k3-am62p5-sk: Add boot phase tag for USB0
      arm64: dts: ti: k3-j721e-common-proc-board: Add boot phase tag to =
SERDES3
      arm64: dts: ti: k3-j721e-sk: Add boot phase tag to SERDES3
      arm64: dts: ti: k3-am62p5-sk: Support SoC wakeup using USB1 wakeup
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix serdes_ln_ctrl r=
eg-masks

Sowon Na (1):
      arm64: dts: exynosautov920: add ufs phy for ExynosAutov920 SoC

Stefan Eichenberger (2):
      arm64: dts: imx8-apalis: add clock configuration for 44.1 kHz hdmi=
 audio
      arm64: dts: ti: k3-am62-verdin-dahlia: add Microphone Jack to soun=
d card

Stephen Chen (1):
      arm64: dts: rockchip: Add Radxa ROCK 4D device tree

Svyatoslav Ryhel (5):
      ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114
      ARM: tegra: Add ARM PMU node on Tegra114
      ARM: tegra: Add HDA node on Tegra114
      ARM: tegra: Add DSI-A and DSI-B nodes on Tegra124
      ARM: tegra: tf101: Add al3000a illuminance sensor node

Teresa Remmet (5):
      arm64: dts: imx8mm-phycore-som: Keep LDO3 on in suspend
      arm64: dts: imx8mm-phycore-som: Remove magic-packet property
      arm64: dts: imx8mm-phyboard-polis: Add support for PEB-AV-10
      arm64: dts: imx8mm-phycore-som: Add no-eth phy overlay
      arm64: dts: imx8mm-phycore-som: Add overlay to disable SPI NOR fla=
sh

Thierry Reding (2):
      dt-bindings: display: tegra: Document Tegra124 MIPI
      dt-bindings: Document Tegra114 HDA support

Tom Rini (2):
      dt-bindings: omap: Add TI Pandaboard A4 variant
      ARM: dts: omap4-panda-a4: Add missing model and compatible propert=
ies

Tudor Ambarus (3):
      arm64: dts: exynos: gs101: add SRAM node
      arm64: dts: exynos: gs101: add AP to APM mailbox node
      arm64: dts: exynos: gs101: add ACPM protocol node

Udit Kumar (1):
      arm64: dts: ti: k3-j721s2-som-p0: Add flash partition details

Vaishnav Achath (3):
      arm64: dts: ti: k3-j722s-main: Add BCDMA CSI overrides
      arm64: dts: ti: k3-j722s-main: Add CSI2RX nodes
      arm64: dts: ti: k3-j722s-evm: Add camera peripherals

Vibhore Vardhan (3):
      arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
      arm64: dts: ti: k3-am62p-j722s-common-wakeup: Configure ti-sysc fo=
r wkup_uart0
      arm64: dts: ti: k3-am62p5-sk: Add serial alias

Vincenzo Frascino (9):
      arm64: Kconfig: Update description for CONFIG_ARCH_VEXPRESS
      dt-bindings: arm: Add Morello compatibility
      dt-bindings: arm: Add Morello fvp compatibility
      dt-bindings: arm: Add Rainier compatibility
      dt-bindings: arm-pmu: Add support for ARM Rainier PMU
      arm64: dts: morello: Add support for common functionalities
      arm64: dts: morello: Add support for soc dts
      arm64: dts: morello: Add support for fvp dts
      MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer

Wadim Egorov (7):
      arm64: dts: ti: k3-am64-phycore-som: Reserve RTOS IPC memory
      arm64: dts: ti: k3-am62-phycore-som: Reserve RTOS IPC memory
      arm64: dts: ti: k3-am62x-phyboard-lyra: Add boot phase tags
      arm64: dts: ti: k3-am62a-phycore-som: Add boot phase tags
      arm64: dts: ti: k3-am642-phyboard-electra: Add boot phase tags
      arm64: dts: ti: k3-am642-phyboard-electra: Reorder properties per =
DTS coding style
      arm64: dts: ti: k3-am62a-phycore-som: Reorder properties per DTS c=
oding style

Wolfram Sang (7):
      ARM: dts: at91: calao_usb: fix wrong polarity for LED
      ARM: dts: at91: calao_usb: remove heartbeat for User LEDs
      ARM: dts: at91: use correct vendor name for Calao boards
      ARM: dts: at91: calao_usb: fix button nodes
      ARM: dts: at91: usb_a9g20_lpw: use proper mmc node name
      ARM: dts: microchip: usb_a9263: fix wrong vendor
      ARM: dts: microchip: fix faulty ohci/ehci node names

Xianwei Zhao (2):
      arm64: dts: Add gpio_intc node for Amlogic A4 SoCs
      arm64: dts: Add gpio_intc node for Amlogic A5 SoCs

Xu Yang (2):
      arm64: dts: imx95: add usb3 related nodes
      arm64: dts: imx95-19x19-evk: add typec nodes and enable usb3 node

Yannic Moog (3):
      arm64: dts: imx8mm-phycore-som: add descriptions to nodes
      arm64: dts: imx8mm-phyboard-polis: add RTC description
      arm64: dts: imx8mm: move bulk of rtc properties to carrierboards

Yao Zi (6):
      dt-bindings: clock: Document clock and reset unit of RK3528
      arm64: dts: rockchip: Add clock generators for RK3528 SoC
      arm64: dts: rockchip: Add UART clocks for RK3528 SoC
      dt-bindings: soc: rockchip: Add RK3528 VO GRF syscon
      dt-bindings: soc: rockchip: Add RK3528 VPU GRF syscon
      arm64: dts: rockchip: Fix PWM pinctrl names

Yashwanth Varakala (2):
      arm64: dts: imx8mm-phycore-som: Assign regulator for dsi to lvds b=
ridge
      arm64: dts: imx8mm-phyboard-polis: Assign missing regulator for bl=
uetooth

Yixun Lan (1):
      MAINTAINERS: spacemit: update various info

 Documentation/devicetree/bindings/arm/apple.yaml   |   41 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    5 +
 .../devicetree/bindings/arm/arm,morello.yaml       |   35 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    1 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |   27 +-
 Documentation/devicetree/bindings/arm/google.yaml  |    3 +-
 .../bindings/arm/marvell/armada-37xx.yaml          |    1 +
 .../bindings/arm/marvell/armada-7k-8k.yaml         |   25 +
 .../devicetree/bindings/arm/marvell/armada-8kp.txt |   15 -
 .../devicetree/bindings/arm/mediatek.yaml          |    5 +
 Documentation/devicetree/bindings/arm/pmu.yaml     |    1 +
 .../devicetree/bindings/arm/rockchip.yaml          |   25 +-
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |    2 +
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   22 +
 Documentation/devicetree/bindings/arm/sunxi.yaml   |    5 +
 Documentation/devicetree/bindings/arm/ti/omap.yaml |    7 +
 .../devicetree/bindings/ata/ceva,ahci-1v84.yaml    |    4 +-
 .../bindings/clock/rockchip,rk3528-cru.yaml        |   64 +
 .../bindings/clock/samsung,exynos990-clock.yaml    |   19 +
 .../display/tegra/nvidia,tegra114-mipi.yaml        |    1 +
 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml   |    3 +-
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |    3 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    2 +
 .../devicetree/bindings/net/cdns,macb.yaml         |    7 +-
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    5 +
 .../devicetree/bindings/riscv/spacemit.yaml        |    1 +
 .../soc/renesas/renesas,r9a09g057-sys.yaml         |    5 +-
 .../devicetree/bindings/soc/renesas/renesas.yaml   |   16 +
 .../devicetree/bindings/soc/rockchip/grf.yaml      |    3 +
 .../bindings/soc/samsung/exynos-usi.yaml           |   99 +-
 .../devicetree/bindings/soc/xilinx/xilinx.yaml     |   11 +-
 .../devicetree/bindings/sound/ics43432.txt         |   19 -
 .../bindings/sound/invensense,ics43432.yaml        |   51 +
 .../bindings/sound/nvidia,tegra30-hda.yaml         |    1 +
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |    3 +-
 .../devicetree/bindings/usb/dwc3-xilinx.yaml       |    3 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |    4 +
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |   12 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   10 +-
 MAINTAINERS                                        |   14 +-
 arch/arm/boot/dts/allwinner/Makefile               |    2 +
 .../dts/allwinner/sun8i-v3s-netcube-kumquat.dts    |  276 ++++
 arch/arm/boot/dts/allwinner/sun8i-v3s.dtsi         |    6 +
 arch/arm/boot/dts/amlogic/meson8.dtsi              |   18 +-
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts        |    2 -
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts          |    2 -
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts     |    2 -
 arch/arm/boot/dts/amlogic/meson8b.dtsi             |   18 +-
 arch/arm/boot/dts/cirrus/ep7211-edb7211.dts        |    2 +-
 .../dts/intel/ixp/intel-ixp42x-netgear-wg302v1.dts |   40 +-
 arch/arm/boot/dts/intel/ixp/intel-ixp4xx.dtsi      |    2 +-
 .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi  |    8 +-
 .../boot/dts/marvell/armada-388-clearfog-base.dts  |    2 +-
 arch/arm/boot/dts/marvell/kirkwood-openrd.dtsi     |    4 +-
 arch/arm/boot/dts/microchip/aks-cdu.dts            |    2 +-
 arch/arm/boot/dts/microchip/animeo_ip.dts          |    2 +-
 arch/arm/boot/dts/microchip/at91-foxg20.dts        |    2 +-
 arch/arm/boot/dts/microchip/at91-qil_a9260.dts     |    2 +-
 arch/arm/boot/dts/microchip/at91-sam9_l9260.dts    |    2 +-
 .../boot/dts/microchip/at91-sama5d27_som1_ek.dts   |    4 +-
 .../arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts |    4 +-
 .../boot/dts/microchip/at91-sama5d2_xplained.dts   |    4 +-
 .../boot/dts/microchip/at91-sama5d3_xplained.dts   |    4 +-
 .../boot/dts/microchip/at91-sama5d4_ma5d4evk.dts   |    4 +-
 .../boot/dts/microchip/at91-sama5d4_xplained.dts   |    4 +-
 arch/arm/boot/dts/microchip/at91-sama5d4ek.dts     |    4 +-
 .../boot/dts/microchip/at91-sama7d65_curiosity.dts |   73 +
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts     |    1 +
 arch/arm/boot/dts/microchip/at91-vinco.dts         |    4 +-
 arch/arm/boot/dts/microchip/at91rm9200.dtsi        |    2 +-
 arch/arm/boot/dts/microchip/at91rm9200ek.dts       |    2 +-
 arch/arm/boot/dts/microchip/at91sam9260.dtsi       |    2 +-
 arch/arm/boot/dts/microchip/at91sam9260ek.dts      |    2 +-
 arch/arm/boot/dts/microchip/at91sam9261.dtsi       |    2 +-
 arch/arm/boot/dts/microchip/at91sam9261ek.dts      |    2 +-
 arch/arm/boot/dts/microchip/at91sam9263.dtsi       |    2 +-
 arch/arm/boot/dts/microchip/at91sam9263ek.dts      |    2 +-
 .../boot/dts/microchip/at91sam9g20ek_common.dtsi   |    2 +-
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi       |    4 +-
 arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts   |    4 +-
 arch/arm/boot/dts/microchip/at91sam9n12.dtsi       |    2 +-
 arch/arm/boot/dts/microchip/at91sam9n12ek.dts      |    2 +-
 arch/arm/boot/dts/microchip/at91sam9x5.dtsi        |    4 +-
 arch/arm/boot/dts/microchip/ethernut5.dts          |    2 +-
 arch/arm/boot/dts/microchip/evk-pro3.dts           |    2 +-
 arch/arm/boot/dts/microchip/mpa1600.dts            |    2 +-
 arch/arm/boot/dts/microchip/pm9g45.dts             |    4 +-
 arch/arm/boot/dts/microchip/sam9x60.dtsi           |    4 +-
 arch/arm/boot/dts/microchip/sama5d2.dtsi           |    4 +-
 arch/arm/boot/dts/microchip/sama5d3.dtsi           |    4 +-
 arch/arm/boot/dts/microchip/sama5d3xmb.dtsi        |    4 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi           |    4 +-
 arch/arm/boot/dts/microchip/sama7d65.dtsi          |   95 ++
 arch/arm/boot/dts/microchip/tny_a9260.dts          |    2 +-
 arch/arm/boot/dts/microchip/tny_a9260_common.dtsi  |    2 +-
 arch/arm/boot/dts/microchip/tny_a9263.dts          |    2 +-
 arch/arm/boot/dts/microchip/tny_a9g20.dts          |    2 +-
 arch/arm/boot/dts/microchip/usb_a9260.dts          |    2 +-
 arch/arm/boot/dts/microchip/usb_a9260_common.dtsi  |   11 +-
 arch/arm/boot/dts/microchip/usb_a9263.dts          |   11 +-
 arch/arm/boot/dts/microchip/usb_a9g20-dab-mmx.dtsi |   10 +-
 arch/arm/boot/dts/microchip/usb_a9g20.dts          |    2 +-
 arch/arm/boot/dts/microchip/usb_a9g20_common.dtsi  |    2 +-
 arch/arm/boot/dts/microchip/usb_a9g20_lpw.dts      |    4 +-
 arch/arm/boot/dts/nvidia/tegra114.dtsi             |   34 +-
 arch/arm/boot/dts/nvidia/tegra124.dtsi             |   40 +
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts    |   11 +
 arch/arm/boot/dts/nxp/imx/Makefile                 |   10 +
 arch/arm/boot/dts/nxp/imx/imx31.dtsi               |    2 +-
 arch/arm/boot/dts/nxp/imx/imx50.dtsi               |    2 +-
 arch/arm/boot/dts/nxp/imx/imx51.dtsi               |    2 +-
 arch/arm/boot/dts/nxp/imx/imx53-mba53.dts          |    2 +-
 arch/arm/boot/dts/nxp/imx/imx53-ppd.dts            |    2 +-
 arch/arm/boot/dts/nxp/imx/imx53.dtsi               |    2 +-
 .../boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts |   11 +
 .../dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts    |   11 +
 .../dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts    |   11 +
 .../boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts  |   11 +
 .../dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts    |   11 +
 .../boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dts    |   11 +
 .../dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts   |   11 +
 .../dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts   |   11 +
 .../boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts   |   11 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi |   57 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi      |    2 -
 .../arm/boot/dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi |   57 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi     |    2 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi        |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi       |   25 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi      |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi      |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi    |   32 +
 .../boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi    |   11 +-
 .../boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts   |    3 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi     |    2 -
 .../boot/dts/nxp/imx/imx6ul-var-som-concerto.dts   |  320 +++++
 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi      |  233 ++++
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi           |    2 +-
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi          |    7 +
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts            |   32 +
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi               |   56 +-
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi             |    2 +-
 arch/arm/boot/dts/nxp/mxs/Makefile                 |    3 +
 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts         |   12 +
 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts         |    8 +
 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts         |   39 +
 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi          |  313 +++++
 arch/arm/boot/dts/nxp/mxs/imx28-sps1.dts           |   13 +-
 arch/arm/boot/dts/nxp/vf/vf610-bk4.dts             |    4 +-
 arch/arm/boot/dts/nxp/vf/vf610-colibri.dtsi        |    1 -
 arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-c.dts   |    4 +-
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi                |   21 +-
 arch/arm/boot/dts/renesas/r8a7790-lager.dts        |    1 +
 arch/arm/boot/dts/renesas/r8a7790-stout.dts        |    1 +
 arch/arm/boot/dts/renesas/r8a7790.dtsi             |    7 +
 arch/arm/boot/dts/renesas/r8a7791-koelsch.dts      |    1 +
 arch/arm/boot/dts/renesas/r8a7791-porter.dts       |    1 +
 arch/arm/boot/dts/renesas/r8a7791.dtsi             |    7 +
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts      |    1 +
 arch/arm/boot/dts/renesas/r8a7792-wheat.dts        |    1 +
 arch/arm/boot/dts/renesas/r8a7792.dtsi             |    6 +
 arch/arm/boot/dts/renesas/r8a7793-gose.dts         |    1 +
 arch/arm/boot/dts/renesas/r8a7793.dtsi             |    7 +
 arch/arm/boot/dts/renesas/r8a7794-alt.dts          |    1 +
 arch/arm/boot/dts/renesas/r8a7794-silk.dts         |    1 +
 arch/arm/boot/dts/renesas/r8a7794.dtsi             |    7 +
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           |   20 +-
 arch/arm/boot/dts/st/Makefile                      |    4 +
 arch/arm/boot/dts/st/stm32f746-disco.dts           |   18 +
 arch/arm/boot/dts/st/stm32f769-disco.dts           |    7 +-
 arch/arm/boot/dts/st/stm32mp131.dtsi               |   35 +
 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts        |  496 +++++++
 arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dts   |   30 +-
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi        |  292 ++++
 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts        |  376 ++++++
 .../boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.dts |  103 ++
 .../boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.dts |  147 ++
 .../arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi |  397 ++++++
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts           |    2 +-
 arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts    |   10 +-
 .../dts/ti/omap/omap3-evm-processor-common.dtsi    |    2 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |    8 +-
 arch/arm/boot/dts/ti/omap/omap4-panda-a4.dts       |    5 +
 arch/arm/boot/dts/xilinx/zynq-7000.dtsi            |   33 +-
 arch/arm/boot/dts/xilinx/zynq-cc108.dts            |   41 +-
 arch/arm/boot/dts/xilinx/zynq-ebaz4205.dts         |    2 +
 arch/arm/boot/dts/xilinx/zynq-microzed.dts         |   10 +-
 arch/arm/boot/dts/xilinx/zynq-parallella.dts       |    1 -
 arch/arm/boot/dts/xilinx/zynq-zc702.dts            |   85 +-
 arch/arm/boot/dts/xilinx/zynq-zc706.dts            |   67 +-
 arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts      |   39 +-
 arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts      |   31 +
 arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts      |   35 +
 arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts      |   41 +-
 arch/arm/boot/dts/xilinx/zynq-zed.dts              |   43 +-
 arch/arm/boot/dts/xilinx/zynq-zturn-common.dtsi    |    8 +
 arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts          |   10 +-
 arch/arm/boot/dts/xilinx/zynq-zybo.dts             |    9 +-
 arch/arm64/Kconfig.platforms                       |    9 +-
 arch/arm64/boot/dts/airoha/en7581-evb.dts          |   44 +
 arch/arm64/boot/dts/airoha/en7581.dtsi             |   91 ++
 .../dts/allwinner/sun50i-a100-allwinner-perf1.dts  |    5 +
 .../boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi    |   90 ++
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi     |    8 +
 .../allwinner/sun50i-h700-anbernic-rg35xx-2024.dts |   18 +-
 .../allwinner/sun50i-h700-anbernic-rg35xx-h.dts    |   23 +
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts   |    2 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts   |   61 +-
 arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi      |   24 +-
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |    8 +-
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi    |   32 +-
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |   21 +
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |   12 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |   24 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   33 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts  |    4 -
 .../boot/dts/amlogic/meson-g12a-radxa-zero.dts     |    4 -
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  |    4 -
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    |    2 -
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts |    4 -
 .../dts/amlogic/meson-g12b-a311d-libretech-cc.dts  |    2 -
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi  |    4 -
 .../boot/dts/amlogic/meson-g12b-bananapi.dtsi      |    4 -
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |    4 -
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi |    4 -
 .../boot/dts/amlogic/meson-g12b-radxa-zero2.dts    |    8 -
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi   |    6 -
 .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi    |    6 -
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |    2 -
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |    8 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |    2 -
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |    2 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |    2 -
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |    2 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi  |    2 -
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   25 +
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      |    2 -
 .../amlogic/meson-gxl-s905w-jethome-jethub-j80.dts |    2 -
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |    2 -
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |    2 -
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |    2 -
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |    2 -
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   25 +
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |    4 -
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |    2 -
 .../dts/amlogic/meson-libretech-cottonwood.dtsi    |    6 -
 arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi   |    6 -
 .../arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi |    2 -
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |    2 -
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi  |    2 -
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |    6 -
 arch/arm64/boot/dts/apple/Makefile                 |   16 +
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi         |    9 +
 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi       |    5 +
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi      |    5 +
 arch/arm64/boot/dts/apple/s5l8960x-opp.dtsi        |   45 +
 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi       |  610 +++++++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi            |   30 +
 arch/arm64/boot/dts/apple/s5l8965x-opp.dtsi        |   45 +
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi     |    4 +
 arch/arm64/boot/dts/apple/s800-0-3-pmgr.dtsi       |  757 +++++++++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi            |  179 +++
 arch/arm64/boot/dts/apple/s8000.dtsi               |  162 +--
 arch/arm64/boot/dts/apple/s8001-common.dtsi        |    1 +
 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi     |   26 +
 arch/arm64/boot/dts/apple/s8001-j98a.dts           |    1 +
 arch/arm64/boot/dts/apple/s8001-j99a.dts           |    1 +
 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi          |  822 ++++++++++++
 arch/arm64/boot/dts/apple/s8001.dtsi               |   81 ++
 arch/arm64/boot/dts/apple/s8003.dtsi               |   63 +-
 arch/arm64/boot/dts/apple/s800x-6s.dtsi            |    4 +
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi         |    4 +
 arch/arm64/boot/dts/apple/s800x-se.dtsi            |    4 +
 arch/arm64/boot/dts/apple/spi1-nvram.dtsi          |   39 +
 arch/arm64/boot/dts/apple/t600x-common.dtsi        |    7 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |   28 +
 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi     |   14 +
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |    2 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi          |    2 +
 arch/arm64/boot/dts/apple/t7000-6.dtsi             |    8 +
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi      |    4 +
 arch/arm64/boot/dts/apple/t7000-j42d.dts           |    5 +
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi         |   12 +
 arch/arm64/boot/dts/apple/t7000-n102.dts           |    4 +
 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi          |  641 +++++++++
 arch/arm64/boot/dts/apple/t7000.dtsi               |   73 +
 arch/arm64/boot/dts/apple/t7001-air2.dtsi          |    1 +
 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi          |  650 +++++++++
 arch/arm64/boot/dts/apple/t7001.dtsi               |   65 +
 arch/arm64/boot/dts/apple/t8010-7.dtsi             |   12 +
 arch/arm64/boot/dts/apple/t8010-common.dtsi        |    4 +
 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi         |   12 +
 arch/arm64/boot/dts/apple/t8010-n112.dts           |    4 +
 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi          |  772 +++++++++++
 arch/arm64/boot/dts/apple/t8010.dtsi               |  115 ++
 arch/arm64/boot/dts/apple/t8011-common.dtsi        |    1 +
 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi          |  806 +++++++++++
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi          |    8 +
 arch/arm64/boot/dts/apple/t8011.dtsi               |  101 ++
 arch/arm64/boot/dts/apple/t8012-j132.dts           |   14 +
 arch/arm64/boot/dts/apple/t8012-j137.dts           |   14 +
 arch/arm64/boot/dts/apple/t8012-j140a.dts          |   14 +
 arch/arm64/boot/dts/apple/t8012-j140k.dts          |   14 +
 arch/arm64/boot/dts/apple/t8012-j152f.dts          |   15 +
 arch/arm64/boot/dts/apple/t8012-j160.dts           |   14 +
 arch/arm64/boot/dts/apple/t8012-j174.dts           |   14 +
 arch/arm64/boot/dts/apple/t8012-j185.dts           |   14 +
 arch/arm64/boot/dts/apple/t8012-j185f.dts          |   14 +
 arch/arm64/boot/dts/apple/t8012-j213.dts           |   15 +
 arch/arm64/boot/dts/apple/t8012-j214k.dts          |   15 +
 arch/arm64/boot/dts/apple/t8012-j215.dts           |   15 +
 arch/arm64/boot/dts/apple/t8012-j223.dts           |   15 +
 arch/arm64/boot/dts/apple/t8012-j230k.dts          |   14 +
 arch/arm64/boot/dts/apple/t8012-j680.dts           |   15 +
 arch/arm64/boot/dts/apple/t8012-j780.dts           |   15 +
 arch/arm64/boot/dts/apple/t8012-jxxx.dtsi          |   44 +
 arch/arm64/boot/dts/apple/t8012-pmgr.dtsi          |  837 ++++++++++++
 arch/arm64/boot/dts/apple/t8012-touchbar.dtsi      |   20 +
 arch/arm64/boot/dts/apple/t8012.dtsi               |  281 ++++
 arch/arm64/boot/dts/apple/t8015-8.dtsi             |    4 +
 arch/arm64/boot/dts/apple/t8015-common.dtsi        |    1 +
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |  931 +++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi               |  151 +++
 arch/arm64/boot/dts/apple/t8103-j293.dts           |   58 +
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi          |    2 +
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi          |   18 +-
 arch/arm64/boot/dts/apple/t8103.dtsi               |  137 ++
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   54 +
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi          |    2 +
 arch/arm64/boot/dts/apple/t8112.dtsi               |  105 +-
 arch/arm64/boot/dts/arm/Makefile                   |    1 +
 arch/arm64/boot/dts/arm/corstone1000-fvp.dts       |   26 +
 arch/arm64/boot/dts/arm/corstone1000.dtsi          |    3 +-
 arch/arm64/boot/dts/arm/morello-fvp.dts            |   77 ++
 arch/arm64/boot/dts/arm/morello-sdp.dts            |  157 +++
 arch/arm64/boot/dts/arm/morello.dtsi               |  323 +++++
 arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts |   72 +
 arch/arm64/boot/dts/exynos/exynos8895.dtsi         |  956 +++++++++++++-
 arch/arm64/boot/dts/exynos/exynos990.dtsi          |   92 +-
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi     |  138 ++
 arch/arm64/boot/dts/exynos/google/Makefile         |    1 +
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |  267 +---
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi |  294 ++++
 arch/arm64/boot/dts/exynos/google/gs101-raven.dts  |   29 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |   66 +-
 arch/arm64/boot/dts/freescale/Makefile             |   21 +
 .../arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts |   44 +
 .../arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi |   16 +
 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi    |   30 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |   42 +
 .../arm64/boot/dts/freescale/imx8mm-kontron-bl.dts |   10 +-
 .../boot/dts/freescale/imx8mm-kontron-osm-s.dtsi   |    7 +-
 .../freescale/imx8mm-phyboard-polis-peb-av-10.dtso |  237 ++++
 .../imx8mm-phyboard-polis-peb-eval-01.dtso         |   72 +
 .../dts/freescale/imx8mm-phyboard-polis-rdk.dts    |   17 +-
 .../boot/dts/freescale/imx8mm-phycore-no-eth.dtso  |   12 +
 .../dts/freescale/imx8mm-phycore-no-spiflash.dtso  |   16 +
 .../boot/dts/freescale/imx8mm-phycore-rpmsg.dtso   |   58 +
 .../boot/dts/freescale/imx8mm-phycore-som.dtsi     |   22 +-
 .../boot/dts/freescale/imx8mm-phygate-tauri-l.dts  |   11 +
 .../arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi |    1 +
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi   |   21 -
 .../boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts    |    1 -
 .../arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi |    1 +
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |   22 +
 .../boot/dts/freescale/imx8mp-kontron-osm-s.dtsi   |    7 +-
 arch/arm64/boot/dts/freescale/imx8mp-nominal.dtsi  |   64 +
 .../arm64/boot/dts/freescale/imx8mp-skov-basic.dts |   10 +
 .../arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi |  126 +-
 .../boot/dts/freescale/imx8mp-skov-revb-hdmi.dts   |   45 +-
 .../boot/dts/freescale/imx8mp-skov-revb-lt6.dts    |   60 +
 .../freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts  |   30 +-
 .../boot/dts/freescale/imx8mp-skov-revc-bd500.dts  |   91 ++
 .../dts/freescale/imx8mp-skov-revc-tian-g07017.dts |   81 ++
 .../dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts    |    2 +-
 .../arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi |    1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   23 +-
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   |   25 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi  |   26 +-
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi  |    1 +
 .../boot/dts/freescale/imx8qm-apalis-v1.1.dtsi     |    2 -
 arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi   |    2 -
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       |  112 ++
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi  |   24 +-
 .../boot/dts/freescale/imx8qxp-mek-pcie-ep.dtso    |   22 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |   32 +
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   |    4 +-
 .../boot/dts/freescale/imx93-kontron-osm-s.dtsi    |    5 +-
 .../dts/freescale/imx93-tqma9352-mba93xxca.dts     |   54 +-
 .../dts/freescale/imx93-tqma9352-mba93xxla.dts     |    6 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |    8 +
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  | 1130 +++++++++++++=
+++
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  |   83 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi           |  108 +-
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          |    2 +-
 arch/arm64/boot/dts/freescale/mba8xx.dtsi          |   31 +-
 arch/arm64/boot/dts/freescale/s32g2.dtsi           |  141 ++
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts     |    1 +
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts    |    1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi           |  150 +++
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts    |    9 +
 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi    |  222 ++++
 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi    |  170 +++
 arch/arm64/boot/dts/freescale/tqma8xx.dtsi         |   12 +-
 .../arm64/boot/dts/hisilicon/hi3660-coresight.dtsi |    8 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi      |    2 +-
 arch/arm64/boot/dts/marvell/armada-371x.dtsi       |   17 -
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |    2 +-
 .../dts/marvell/armada-3720-espressobin-emmc.dts   |    2 +-
 .../dts/marvell/armada-3720-espressobin-ultra.dts  |    2 +-
 .../marvell/armada-3720-espressobin-v7-emmc.dts    |    2 +-
 .../dts/marvell/armada-3720-espressobin-v7.dts     |    2 +-
 .../boot/dts/marvell/armada-3720-espressobin.dts   |    2 +-
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |    2 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |    2 +-
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |    3 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |    4 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |    6 -
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |    6 -
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |    6 -
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |    8 +-
 .../boot/dts/marvell/armada-8040-puzzle-m801.dts   |    2 +-
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |    6 -
 arch/arm64/boot/dts/marvell/armada-8080.dtsi       |    6 -
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |    3 -
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |    3 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |    6 -
 arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi |    3 -
 arch/arm64/boot/dts/marvell/armada-ap807.dtsi      |    6 -
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi      |   33 +-
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    |    1 -
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  |   24 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |    4 -
 arch/arm64/boot/dts/marvell/armada-cp115.dtsi      |    4 -
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi      |    4 +-
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     |    3 -
 arch/arm64/boot/dts/mediatek/Makefile              |    3 +
 arch/arm64/boot/dts/mediatek/mt6359.dtsi           |    3 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi       |    2 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   12 +-
 .../dts/mediatek/mt8183-kukui-jacuzzi-damu.dts     |    9 +-
 .../mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts  |    8 +-
 .../mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts  |    8 +-
 .../mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts  |    8 +-
 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi    |  173 ++-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi           |  307 ++++-
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |  184 ++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |  129 ++
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        |  245 +++-
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           |  336 +++++
 .../boot/dts/mediatek/mt8370-genio-510-evk.dts     |   19 +
 arch/arm64/boot/dts/mediatek/mt8370.dtsi           |   64 +
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 1033 +------------=
--
 .../boot/dts/mediatek/mt8390-genio-common.dtsi     | 1223 +++++++++++++=
++++
 .../boot/dts/mediatek/mt8395-genio-1200-evk.dts    |  102 ++
 .../mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso  |   84 ++
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     |   71 +
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |   13 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   20 +-
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   10 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   10 +
 .../dts/nvidia/tegra234-p3740-0002+p3701-0008.dts  |   10 +
 .../boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi |    7 -
 arch/arm64/boot/dts/renesas/Makefile               |    5 +
 .../arm64/boot/dts/renesas/beacon-renesom-som.dtsi |    1 +
 arch/arm64/boot/dts/renesas/condor-common.dtsi     |    1 +
 arch/arm64/boot/dts/renesas/draak.dtsi             |    1 +
 arch/arm64/boot/dts/renesas/ebisu.dtsi             |    1 +
 arch/arm64/boot/dts/renesas/hihope-common.dtsi     |    1 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |    8 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          |    8 +
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |    1 +
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |   11 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi          |    8 +
 arch/arm64/boot/dts/renesas/r8a77951.dtsi          |    7 +
 arch/arm64/boot/dts/renesas/r8a77960.dtsi          |    8 +
 arch/arm64/boot/dts/renesas/r8a77961.dtsi          |    8 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |    8 +
 .../renesas/r8a77970-eagle-function-expansion.dtso |    2 +-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |    1 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |    1 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |    7 +
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |    1 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |    7 +
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |   11 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |    7 +
 .../boot/dts/renesas/r8a779a0-falcon-cpu.dtsi      |    1 +
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi          |   88 ++
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi      |    1 +
 .../boot/dts/renesas/r8a779f0-spider-ethernet.dtsi |  104 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi          |   17 +-
 arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts      |   69 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |   88 +-
 .../boot/dts/renesas/r8a779h0-gray-hawk-single.dts |  154 ++-
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi          |   34 +-
 .../arm64/boot/dts/renesas/r9a07g044l2-remi-pi.dts |  339 +++++
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi         |   29 +-
 .../renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso  |   48 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi         |   37 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi         |   52 +-
 .../boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts    |   15 +
 arch/arm64/boot/dts/renesas/r9a09g057h48-kakip.dts |  136 ++
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi   |    4 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi   |   20 +-
 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h |   40 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi       |   13 +
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |    1 +
 .../ulcb-kf-audio-graph-card-mix+split.dtsi        |   73 +-
 .../ulcb-kf-audio-graph-card2-mix+split.dtsi       |   66 +-
 .../ulcb-kf-simple-audio-card-mix+split.dtsi       |   53 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    1 +
 .../boot/dts/renesas/white-hawk-cpu-common.dtsi    |    1 +
 .../arm64/boot/dts/renesas/white-hawk-csi-dsi.dtsi |    8 +-
 arch/arm64/boot/dts/rockchip/Makefile              |   63 +
 .../px30-ringneck-haikou-lvds-9904379.dtso         |  130 ++
 .../rockchip/px30-ringneck-haikou-video-demo.dtso  |  190 +++
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     |    2 +
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    |    4 -
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |    2 +-
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    |    4 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts  |    8 +
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |    2 +-
 .../rockchip/rk3399-puma-haikou-video-demo.dtso    |  166 +++
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   26 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |   10 +-
 .../arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts |    2 +-
 arch/arm64/boot/dts/rockchip/rk3528-pinctrl.dtsi   | 1397 +++++++++++++=
+++++++
 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts |  133 ++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi           |  378 +++++-
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  |    2 +
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts |    8 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts |    8 +-
 arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts |  588 ++++++++
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts    |   14 -
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi      |   30 +-
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      |   50 +-
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   |   47 +
 arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts     |  736 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    |  751 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  205 ++-
 .../arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi |    4 +
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   75 ++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  110 +-
 .../boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts    |    2 +-
 .../dts/rockchip/rk3588-coolpi-cm5-genbook.dts     |    2 +-
 .../arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi |    4 +
 .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |    4 +
 .../boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi |   47 +
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |   50 +-
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi     |  186 +++
 arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi |    4 +
 .../dts/rockchip/rk3588-firefly-core-3588j.dtsi    |    4 +
 .../dts/rockchip/rk3588-firefly-icore-3588q.dtsi   |  443 +++++++
 .../boot/dts/rockchip/rk3588-firefly-itx-3588j.dts |    2 +-
 .../rockchip/rk3588-friendlyelec-cm3588-nas.dts    |    2 +-
 .../dts/rockchip/rk3588-friendlyelec-cm3588.dtsi   |    4 +
 .../arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts |   30 +-
 .../dts/rockchip/rk3588-jaguar-pre-ict-tester.dtso |  171 +++
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     |  224 +++-
 .../arm64/boot/dts/rockchip/rk3588-mnt-reform2.dts |  336 +++++
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi |    6 +-
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |    4 +
 .../dts/rockchip/rk3588-orangepi-5-compact.dtsi    |   11 +-
 .../boot/dts/rockchip/rk3588-orangepi-5-max.dts    |   67 +-
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   |   56 +-
 .../boot/dts/rockchip/rk3588-orangepi-5-ultra.dts  |   83 ++
 .../arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi |    6 +-
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |    6 +-
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts |   53 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |   83 +-
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts      |    4 +-
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |    5 +-
 .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |    4 +
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |    4 +
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts |   31 +-
 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts  |    6 +-
 .../boot/dts/rockchip/rk3588s-gameforce-ace.dts    |    6 +-
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  |    8 +-
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts     |    4 +
 .../arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi |    6 +-
 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts |    6 +-
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi      |   16 +-
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |    6 +-
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts   |   42 +-
 arch/arm64/boot/dts/st/Makefile                    |    6 +-
 arch/arm64/boot/dts/st/stm32mp211.dtsi             |  128 ++
 arch/arm64/boot/dts/st/stm32mp213.dtsi             |    9 +
 arch/arm64/boot/dts/st/stm32mp215.dtsi             |    9 +
 arch/arm64/boot/dts/st/stm32mp215f-dk.dts          |   49 +
 arch/arm64/boot/dts/st/stm32mp21xc.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp21xf.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp231.dtsi             | 1214 +++++++++++++=
++++
 arch/arm64/boot/dts/st/stm32mp233.dtsi             |   94 ++
 arch/arm64/boot/dts/st/stm32mp235.dtsi             |   16 +
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts          |  113 ++
 arch/arm64/boot/dts/st/stm32mp23xc.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp23xf.dtsi            |    8 +
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts          |  113 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi                 |   26 +-
 arch/arm64/boot/dts/ti/Makefile                    |    3 +
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi    |   25 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi  |    6 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |    8 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |    1 -
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi   |   19 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |    4 +
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |    8 -
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |   36 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi          |   26 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |    4 +-
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi |    9 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |    2 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    |   33 +-
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  |   19 +-
 ...m642-phyboard-electra-x27-gpio1-spi1-uart3.dtso |   63 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |    1 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |    1 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |   41 +
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts            |   30 +-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi          |  208 ++-
 .../dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso   |    7 -
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  |    6 +-
 arch/arm64/boot/dts/xilinx/Makefile                |    2 +
 arch/arm64/boot/dts/xilinx/versal-net-clk.dtsi     |  231 ++++
 .../dts/xilinx/versal-net-vn-x-b2197-01-revA.dts   |  116 ++
 arch/arm64/boot/dts/xilinx/versal-net.dtsi         |  752 +++++++++++
 arch/arm64/boot/dts/xilinx/xlnx-zynqmp-clk.h       |  126 ++
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     |   17 +-
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts    |    5 -
 .../boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi |    5 +-
 .../boot/dts/microchip/mpfs-m100pfs-fabric.dtsi    |    5 +-
 .../boot/dts/microchip/mpfs-polarberry-fabric.dtsi |    5 +-
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |   36 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             |    9 +
 arch/riscv/boot/dts/spacemit/Makefile              |    1 +
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   27 +
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |    8 +-
 .../dts/starfive/jh7110-deepcomputing-fml13v01.dts |   34 +
 .../boot/dts/starfive/jh7110-pine64-star64.dts     |    5 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi           |    2 +
 include/dt-bindings/clock/rockchip,rk3528-cru.h    |  453 +++++++
 include/dt-bindings/clock/rockchip,rk3576-cru.h    |    5 +
 include/dt-bindings/clock/samsung,exynos990.h      |   21 +
 include/dt-bindings/clock/xlnx-zynqmp-clk.h        |    7 +
 include/dt-bindings/reset/rockchip,rk3528-cru.h    |  241 ++++
 include/dt-bindings/soc/samsung,exynos-usi.h       |   17 +-
 646 files changed, 35688 insertions(+), 2992 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,morello.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/arm/marvell/armada=
-8kp.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3=
528-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
 create mode 100644 Documentation/devicetree/bindings/sound/invensense,i=
cs43432.yaml
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumqua=
t.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.=
dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v=
3.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v=
2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.d=
ts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.=
2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1=
.1.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1=
.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
 create mode 100644 arch/arm/boot/dts/st/stm32mp133c-prihmb.dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen1.=
dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2-gen2.=
dts
 create mode 100644 arch/arm/boot/dts/st/stm32mp153c-lxa-fairytux2.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dt=
si
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8965x-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800-0-3-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800-0-3.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/spi1-nvram.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j132.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j137.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j140a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j140k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j152f.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j160.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j174.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j185.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j185f.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j213.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j214k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j215.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j223.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j230k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j680.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j780.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-jxxx.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012-touchbar.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/morello-fvp.dts
 create mode 100644 arch/arm64/boot/dts/arm/morello-sdp.dts
 create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-pixel-common=
.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-raven.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-=
peb-av-10.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-=
peb-eval-01.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-eth.=
dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-no-spif=
lash.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.d=
tso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nominal.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-skov-basic.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-skov-revc-bd500=
.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-skov-revc-tian-=
g07017.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek-pcie-ep.dt=
so
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/armada-371x.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8370.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l-8-=
hd-panel.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-remi-pi.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1=
-type-3a.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g057h48-kakip.dts
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-lv=
ds-9904379.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-vi=
deo-demo.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-vide=
o-demo.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-firefly-icore-35=
88q.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-jaguar-pre-ict-t=
ester.dtso
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-mnt-reform2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-ultra=
.dts
 create mode 100644 arch/arm64/boot/dts/st/stm32mp211.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp213.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp215.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp215f-dk.dts
 create mode 100644 arch/arm64/boot/dts/st/stm32mp21xc.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp21xf.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp231.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp233.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp235.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp235f-dk.dts
 create mode 100644 arch/arm64/boot/dts/st/stm32mp23xc.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp23xf.dtsi
 create mode 100644 arch/arm64/boot/dts/st/stm32mp257f-dk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-x27=
-gpio1-spi1-uart3.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-clk.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-vn-x-b2197-01-=
revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/xlnx-zynqmp-clk.h
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
 create mode 100644 include/dt-bindings/clock/rockchip,rk3528-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h

