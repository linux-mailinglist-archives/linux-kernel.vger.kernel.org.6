Return-Path: <linux-kernel+bounces-330915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D197A610
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9EB26F01
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5D1591F1;
	Mon, 16 Sep 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pVPDGWqh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iruG6ibM"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC41598EE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504323; cv=none; b=Dug3FtIHue9B/WCjWXKMhMbJUPMuefzMBI8HJ6s3APpt0DwApp/gLFnRhu037P1xvBZvgyt5hge+0ksKHO1RoS6SCiKVklsgPNs0iVxIBPGhs/cLkwiEfxnieg+Ir0fQqCIEItnPqlcMpA6u/wzhgTteCob+NgKdDMy03ujqjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504323; c=relaxed/simple;
	bh=KVYQu9mpKMc33UDRJWbUJBaYryLnXxKjB7C5CdSeU/0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ipCnt2UCFJWH5BD/yLt+Pnhpq3tb1Yb01M6rxFJdMOaz42biC3eDXH6FtLTPWLi/NMIteQuCjSgGj9Nv9QKbiS/73TcMErsaAFCQAK0pViMYeN6fOpzkLE9clRgIdbwMOPejNnIrx+hGFCe84vFVEyGk9Wmqguev4z0d4vKbNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pVPDGWqh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iruG6ibM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E8E5513803C0;
	Mon, 16 Sep 2024 12:31:58 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 12:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726504318;
	 x=1726590718; bh=KhDXFf6pKLEngzY9mT+p8rOsoT2UCZzt+yYgrMBpCcI=; b=
	pVPDGWqhu9aLywxBNekvaDbEdHv90elZK47oG/7DKPOkSx9V+rGmRdC2fyQFsC0t
	n29wQISEJxRy5A2zUB2Y27w4TLxgLPrDLatFNWbpXECb2FHgQ5hojRmu0N7yz+0H
	AO9JnbjdxiUaaB5Jj6ko1DETu6jU7SgDBXIoJXEmQuY1/0eVU7rhI1DbDV0aLoV8
	yQvXRH0Jd3pqNskeoY3D+STYJJ92sEx5cohJLc83v+bSF8D3uaGwegoFRQu7gS5d
	+ZN3pabEkYLko9la7D5g09fjmfVBwjLOQYGaTFv1mS+vn2y2DkSMrKXfzTZwJDuq
	emSxYjnHuM4L5eTYcitKjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726504318; x=
	1726590718; bh=KhDXFf6pKLEngzY9mT+p8rOsoT2UCZzt+yYgrMBpCcI=; b=i
	ruG6ibMHL/OGTx5LS+H5SL/t+AqjR5OLeqKN9oWoRmWHOum8PjPSd0K9cbiWsY2m
	7/VnwTq4mDHa5TbTeYjnDbrH/2LjLXeVDH9Fz+hveGqkAbSHpE0uMLLF/hgice/5
	3s1C4filMCrwgAwxDRDmXzggGoJH6z3cQJTaeKxRRX/IGUXx6k+Paw9HUK8PNX2e
	lfFVFEzxEA1ICejSBh/f3koir00yzr5NSEypREB5Wd9G2wcof1ctJ49tbKgEdt5G
	65uoJElLx9cWVBkWYc3gXyeNqtH/yPKfk9YzqZxzb7VtMfBWik/ZqyWPT6Mxc7gi
	OtA2dwuU2s0R2ChdnhICg==
X-ME-Sender: <xms:fl3oZv5BnVNNwfljqv3zhW8QjVJUQqMvpfqS1JRvKB9rMtqryRxSHw>
    <xme:fl3oZk5pXUXMN7aDeyVbYZKnUnPJC6hSY6vzCeS_X-Tb_kIvfAh9izOpS3QVJkCu-
    d_kO7xeMfXUQgnw9Gs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefueegkeffveeugeehieehiedukeegfefhffeu
    tdettdffteeluefhheetkeekvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsohgtsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:fl3oZmdCqiRwa1s9-1f8GkryGsPEqRivoYlOVeIsD3IMd0bFSbheyg>
    <xmx:fl3oZgI8_mGGQ1PZA8wCa8GFnITtSEIwaJwDhtB9gPSJ965s0swBLg>
    <xmx:fl3oZjIdRW2cRyzpaHdaK91X56s8682MxJgLqDQwLbYKFAFy0NSbLw>
    <xmx:fl3oZpz2pmXd4-u0x_Kaow95cB2wf6YkfeTnvD7hNadvrVnF9Sw52g>
    <xmx:fl3oZr0T5TuINK5QxpYTHqRHfTm-zQtY8nRtVil4QQTrXpaYBJY7kahX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92081222006F; Mon, 16 Sep 2024 12:31:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 16:31:29 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <212ba952-faee-42f8-959d-c2a8d3dc89a7@app.fastmail.com>
In-Reply-To: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com>
References: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com>
Subject: [GIT PULL 1/4] soc: devicetree updates for 6.12
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208=
399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.12

for you to fetch changes up to 168c3e0d443599dd370710243fbf5c815fad7890:

  Merge tag 'sunxi-dt-for-6.12-2' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/sunxi/linux into soc/dt (2024-09-12 14:25:36 +0000)

----------------------------------------------------------------
soc: devicetree updates for 6.12

New SoC support for Broadcom bcm2712 (Raspberry Pi 5) and Renesas
R9A09G057 (RZ/V2H(P)) and Qualcomm Snapdragon 414 (MSM8929), all three
of these are variants of already supported chips, in particular the last
one is almost identical to MSM8939.

Lots of updates to Mediatek, ASpeed, Rockchips, Amlogic, Qualcomm,
STM32, NXP i.MX, Sophgo, TI K3, Renesas, Microchip at91, NVIDIA Tegra,
and T-HEAD.

The added Qualcomm platform support once again dominates the changes,
with seven phones and three laptops getting added in addition to
many new features on existing machines. The Snapdragon X1E support
specifically keeps improving.

The other new machines are:

 - eight new machines using various 64-bit Rockchips SoCs, both
   on the consumer/gaming side and developer boards
 - three industrial boards with 64-bit i.MX, which is a very
   low number for them.
 - four more servers using a 32-bit Speed BMC
 - three boards using STM32MP1 SoCs
 - one new machine each using allwinner, amlogic, broadcom
   and renesas chips.

----------------------------------------------------------------
Abel Vesa (2):
      arm64: dts: qcom: x1e80100: Add orientation-switch to all USB+DP Q=
MP PHYs
      arm64: dts: qcom: x1e80100: Fix PHY for DP2

Adam Ford (1):
      arm64: dts: imx8mp-beacon: Enable DW HDMI Bridge

Adam S=C5=82abo=C5=84 (1):
      arm64: dts: qcom: msm8939-wingtech-wt82918: Add Lenovo Vibe K5 dev=
ices

Ajit Pandey (4):
      dt-bindings: clock: qcom: add DISPCC clocks on SM4450
      dt-bindings: clock: qcom: add CAMCC clocks on SM4450
      dt-bindings: clock: qcom: add GPUCC clocks on SM4450
      arm64: dts: qcom: sm4450: add camera, display and gpu clock contro=
ller

Alessandro Zini (1):
      arm64: dts: ti: k3-am62: Enable CPU freq throttling on thermal ale=
rt

Alex Bee (3):
      arm64: dts: rockchip: Add sdmmc_ext for RK3328
      arm64: dts: rockchip: Add sdmmc/sdio/emmc reset controls for RK3328
      ARM: dts: rockchip: Add vpu nodes for RK3128

Alex Zhao (1):
      arm64: dts: rockchip: rk3588s fix sdio pins to pull up

Alexander Dahl (2):
      ARM: dts: microchip: sam9x60: Move i2c address/size to dtsi
      ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks

Alexander Reimelt (2):
      dt-bindings: arm: qcom: Add LG G4 (h815)
      arm64: dts: qcom: msm8992-lg-h815: Initial support for LG G4 (H815)

Alexander Stein (11):
      arm64: dts: imx8-ss-dma: add #address-cells and #size-cells to LPI=
2C nodes
      arm64: dts: imx8-ss-dma: Fix adc0 closing brace location
      arm64: dts: imx8mm-tqma8mqml-mba8mx: Increase frequency for i2c bu=
sses
      arm64: dts: mba8mx: Add Ethernet PHY IRQ support
      arm64: dts: freescale: imx93-tqma9352: Add PMIC node
      arm64: dts: freescale: imx93-tqma9352: add eMMC regulators
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: enable LPSPI6 int=
erface
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: add missing pad c=
onfigurations
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: Add ethernet alia=
ses
      arm64: dts: freescale: imx93-tqma9352-mba93xxca: add missing pad c=
onfigurations
      arm64: dts: freescale: imx93-tqma9352-mba93xxca: Add ethernet alia=
ses

Alexandre Mergnat (2):
      arm64: dts: mediatek: add afe support for mt8365 SoC
      arm64: dts: mediatek: add audio support for mt8365-evk

Amit Pundir (1):
      arm64: dts: qcom: sm8550-hdk: add the Wifi node

Andrea della Porta (1):
      arm64: dts: broadcom: Add minimal support for Raspberry Pi 5

Andrei Simion (5):
      ARM: dts: microchip: at91-sama7g5ek: Add reg_5v to supply PMIC nod=
es
      ARM: dts: microchip: at91-sama7g54_curiosity: Add reg_5v to supply=
 PMIC nodes
      ARM: dts: microchip: at91-sama5d2_icp: Add reg_5v to supply PMIC n=
odes
      ARM: dts: microchip: at91-sama5d27_wlsom1: Add reg_5v to supply PM=
IC nodes
      ARM: dts: microchip: sama5d29_curiosity: Add reg_5v to supply PMIC=
 nodes

Andrei Stefanescu (1):
      arm64: dts: s32g: add the pinctrl node

Andrej Picej (1):
      arm64: dts: imx8mp-phyboard-pollux: Disable write-protect on SD ca=
rd

Andrew Davis (8):
      dt-bindings: soc: ti: am654-serdes-ctrl: Add simple-mfd to compati=
ble items
      arm64: dts: ti: k3-am65: Add simple-mfd compatible to SerDes contr=
ol nodes
      arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations
      arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout=
 locations
      arm64: dts: ti: k3-am65: Include entire FSS region in ranges
      arm64: dts: ti: k3-j721e: Include entire FSS region in ranges
      arm64: dts: ti: k3-j721s2: Include entire FSS region in ranges
      arm64: dts: ti: k3-j784s4: Include entire FSS region in ranges

Andrew Jeffery (7):
      ARM: dts: aspeed: Fix coprocessor interrupt controller node name
      ARM: dts: aspeed: Specify correct generic compatible for CVIC
      ARM: dts: aspeed: Specify required properties for sram node
      ARM: dts: aspeed: Remove undocumented XDMA nodes
      ARM: dts: aspeed: Clean up AST2500 pinctrl properties
      ARM: dts: aspeed-g6: Use generic 'ethernet' for ftgmac100 nodes
      ARM: dts: aspeed-g6: Drop cells properties from ethernet nodes

Andr=C3=A9 Apitzsch (4):
      arm64: dts: qcom: msm8916-longcheer-l8910: Add rear flash
      arm64: dts: qcom: msm8939-longcheer-l9100: Add rear flash
      arm64: dts: qcom: msm8939-longcheer-l9100: Add rear flash
      Revert "arm64: dts: qcom: msm8939-longcheer-l9100: Add rear flash"

Andy Yan (2):
      dt-bindings: arm: rockchip: Add Cool Pi CM5 GenBook
      arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 Gen=
Book

AngeloGioacchino Del Regno (4):
      arm64: dts: mediatek: mt8186: Fix supported-hw mask for GPU OPPs
      arm64: dts: mediatek: Add ADC node on MT6357, MT6358, MT6359 PMICs
      dt-bindings: clock: gcc-msm8998: Add Q6 and LPASS clocks definitio=
ns
      arm64: dts: qcom: msm8998: Add disabled support for LPASS iommu fo=
r Q6

Animesh Agarwal (1):
      arm64: dts: layerscape: remove unused num-viewport

Ankit Sharma (1):
      arm64: dts: qcom: sa8775p: Add capacity and DPC properties

Anton Bambura (1):
      arm64: dts: qcom: msm8916-wingtech-wt865x8: Add Lenovo A6000/A6010

Apurva Nandan (2):
      arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote processor no=
des
      arm64: dts: ti: k3-j722s-evm: Enable Inter-Processor Communication

Arnd Bergmann (33):
      Merge tag 'thead-dt-for-v6.12' of https://github.com/pdp7/linux in=
to soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.12-tag1' of https://git.kern=
el.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.12-tag1' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'samsung-dt64-6.12' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux into soc/dt
      Merge tag 'juno-update-6.12' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/sudeep.holla/linux into soc/dt
      Merge tag 'tegra-for-6.12-dt-bindings' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.12-arm-dt' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.12-arm64-dt' of https://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'at91-dt-6.12' of https://git.kernel.org/pub/scm/linux/k=
ernel/git/at91/linux into soc/dt
      Merge tag 'v6.12-rockchip-dts64-1' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.12-rockchip-dts32-1' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'renesas-dts-for-v6.12-tag2' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'ti-k3-dt-for-v6.12' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/ti/linux into soc/dt
      Merge tag 'riscv-sophgo-dt-for-6.12' of https://github.com/sophgo/=
linux into soc/dt
      Merge tag 'imx-bindings-6.12' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.12' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.12' of https://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/dt
      Merge tag 'omap-for-v6.12/dt-signed' of https://git.kernel.org/pub=
/scm/linux/kernel/git/khilman/linux-omap into soc/dt
      Merge tag 'stm32-dt-for-v6.12-1' of https://git.kernel.org/pub/scm=
/linux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'qcom-arm32-for-6.12' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.12' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'amlogic-arm-dt-for-v6.11' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.12' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.12' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'dt64-cleanup-6.12' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'dt-cleanup-6.12' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'arm-soc/for-6.12/devicetree' of https://github.com/Broa=
dcom/stblinux into soc/dt
      Merge tag 'v6.12-rockchip-dts64-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.12-rockchip-dts32-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'aspeed-6.12-devicetree' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/joel/bmc into soc/dt
      Merge tag 'v6.11-next-dts64' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'arm-soc/for-6.12/devicetree-arm64' of https://github.co=
m/Broadcom/stblinux into soc/dt
      Merge tag 'sunxi-dt-for-6.12-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/sunxi/linux into soc/dt

Artur Weber (2):
      ARM: dts: broadcom: bcm21664: Move chosen node into Garnet DTS
      ARM: dts: bcm-mobile: Split out nodes used by both BCM21664 and BC=
M23550

Aurelien Jarno (1):
      arm64: dts: rockchip: add DT entry for RNG to RK356x

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (2):
      arm64: dts: qcom: pm8950: Add resin node
      arm64: dts: qcom: msm8976: Add restart node

Bartosz Golaszewski (4):
      arm64: dts: qcom: sm8650-qrd: use the PMU to power up bluetooth
      arm64: dts: qcom: sa8775p-ride: enable remoteprocs
      arm64: dts: qcom: sa8775p: add CPU idle states
      arm64: dts: qcom: sa8775p: fix the fastrpc label

Beleswar Padhi (14):
      arm64: dts: ti: k3-j7200-som-p0: Switch MAIN R5F cluster to Split-=
mode
      arm64: dts: ti: k3-j721e-som-p0: Switch MAIN R5F clusters to Split=
-mode
      arm64: dts: ti: k3-j721e-sk: Switch MAIN R5F clusters to Split-mode
      arm64: dts: ti: k3-j721s2-som-p0: Switch MAIN R5F clusters to Spli=
t-mode
      arm64: dts: ti: k3-am68-sk-som: Switch MAIN R5F clusters to Split-=
mode
      arm64: dts: ti: k3-j784s4-evm: Switch MAIN R5F clusters to Split-m=
ode
      arm64: dts: ti: k3-am69-sk: Switch MAIN R5F clusters to Split-mode
      arm64: dts: ti: k3-j7200-som-p0: Change timer nodes status to rese=
rved
      arm64: dts: ti: k3-j721e-som-p0: Change timer nodes status to rese=
rved
      arm64: dts: ti: k3-j721e-sk: Change timer nodes status to reserved
      arm64: dts: ti: k3-j721s2-som-p0: Change timer nodes status to res=
erved
      arm64: dts: ti: k3-am68-sk-som: Change timer nodes status to reser=
ved
      arm64: dts: ti: k3-j784s4-evm: Change timer nodes status to reserv=
ed
      arm64: dts: ti: k3-am69-sk: Change timer nodes status to reserved

Benjamin Hahn (3):
      arm64: dts: freescale: imx8mp-phycore: Add no-eth overlay
      arm64: dts: freescale: imx8mp-phyboard-pollux: Add and enable TPM
      arm64: dts: imx8mp-phyboard-pollux-rdk: Add support for PCIe

Bhavya Kapoor (5):
      arm64: dts: ti: k3-j721s2-som-p0: Update mux-controller node name
      arm64: dts: ti: k3-j7200-som-p0: Update mux-controller node name
      arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux for mmc1
      arm64: dts: ti: k3-j722s-evm: Describe main_uart5
      arm64: dts: ti: k3-j722s-evm: Add support for multiple CAN instanc=
es

Biju Das (7):
      arm64: dts: renesas: r9a07g0{43,44,54}: Move regulator-vbus device=
 node
      arm64: dts: renesas: r9a07g043u: Add FCPVD node
      arm64: dts: renesas: r9a07g043u: Add VSPD node
      arm64: dts: renesas: r9a07g043u: Add DU node
      arm64: dts: renesas: rzg2l-smarc: Enable HDMI audio
      arm64: dts: renesas: rzg2lc-smarc: Enable HDMI audio
      arm64: dts: renesas: r9a07g043u11-smarc: Enable DU

Bingwu Zhang (1):
      ARM: dts: qcom: msm8974pro-samsung-klte: Add pstore node

Bjorn Andersson (14):
      Merge branch 'arm64-fixes-for-6.11' into HEAD
      dt-bindings: clock: qcom: Add missing USB MP resets
      Merge branch '20240730-sc8180x-usb-mp-v2-1-a7dc4265b553@quicinc.co=
m' into arm64-for-6.12
      arm64: dts: qcom: sc8180x-pmics: Add second PMC8180 GPIO
      arm64: dts: qcom: sc8180x: Align USB nodes with binding
      arm64: dts: qcom: sc8180x: Add USB MP controller and phys
      arm64: dts: qcom: sc8180x-primus: Enable the two MP USB ports
      arm64: dts: qcom: sc8180x-lenovo-flex-5g: Enable USB multiport con=
troller
      Merge branch '20240731062916.2680823-7-quic_skakitap@quicinc.com' =
into arm64-for-6.12
      Merge branch '20240717-dispcc-sm8550-fixes-v2-7-5c4a3128c40b@linar=
o.org' into arm64-for-6.12
      arm64: dts: qcom: sc8180x: Enable the power key
      Merge branch '20240611133752.2192401-1-quic_ajipan@quicinc.com' in=
to arm64-for-6.12
      Merge branch '20240814-lpass-v1-1-a5bb8f9dfa8b@freebox.fr' into ar=
m64-for-6.12
      Merge branch '20240730054817.1915652-2-quic_varada@quicinc.com' in=
to arm64-for-6.12

Bryan O'Donoghue (1):
      arm64: dts: qcom: sc8280xp-x13s: Enable RGB sensor

Chanh Nguyen (5):
      ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
      ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias por=
ts
      ARM: dts: aspeed: mtmitchell: Add Riser cards
      ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
      ARM: dts: aspeed: mtmitchell: Add LEDs

Chen Wang (2):
      riscv: sophgo: dts: add mmc controllers for SG2042 SoC
      riscv: sophgo: dts: add gpio controllers for SG2042 SoC

Chen-Yu Tsai (7):
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Simplify DSI endpoint =
replacement
      arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disa=
bled
      arm64: dts: mediatek: mt8395-nio-12l: Mark USB 3.0 on xhci1 as dis=
abled
      arm64: dts: mediatek: mt8195: Assign USB 3.0 PHY to xhci1 by defau=
lt
      arm64: dts: mt8183-kukui: clean up regulator tree
      arm64: dts: mediatek: mt8195: Correct clock order for dp_intf*
      arm64: dts: mediatek: mt8186-corsola: Disable DPI display interface

Chris Morgan (7):
      dt-bindings: arm: sunxi: Add Anbernic RG35XXSP
      arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes
      arm64: dts: allwinner: h616: Change RG35XX Series from r_rsb to r_=
i2c
      arm64: dts: allwinner: h700: Add Anbernic RG35XX-SP
      arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX
      dt-bindings: arm: rockchip: Add GameForce Ace
      arm64: dts: rockchip: Add GameForce Ace

Christopher Obbard (3):
      dt-bindings: arm: rockchip: Add Firefly Core-PX30-JD4 on baseboard
      arm64: dts: rockchip: add Firefly Core-PX30-JD4 SoM
      arm64: dts: rockchip: add Firefly JD4 baseboard with Core-PX30-JD4=
 SoM

Chukun Pan (4):
      arm64: dts: rockchip: use generic Ethernet PHY reset bindings for =
Lunzn Fastrhino R68S
      arm64: dts: rockchip: remove useless tx/rx_delay for Lunzn Fastrhi=
no R68S
      arm64: dts: rockchip: Enable UHS-I SDR-50 for Lunzn FastRhino R66S
      arm64: dts: rockchip: disable display subsystem only for Radxa E25

Ciprian Costea (1):
      arm64: dts: s32g: Disable usdhc write-protect

Clark Wang (2):
      arm64: dts: imx8-ss-dma: enable dma support for lpspi
      arm64: dts: imx93: add lpi2c1 and st lsm6dso node

Claudiu Beznea (6):
      arm64: dts: renesas: r9a08g045: Add DMAC node
      ARM: dts: microchip: at91-sama7g5ek: add EEPROMs
      arm64: dts: renesas: r9a08g045: Add I2C nodes
      arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
      arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node
      ARM: dts: microchip: sama7g5: Fix RTT clock

Colin Foster (1):
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert time

Conor Dooley (1):
      arm64: dts: imx8: remove non-existent DACs

Dang Huynh (11):
      arm64: dts: qcom: sm6115-pro1x: Add Hall Switch and Camera Button
      arm64: dts: qcom: sm6115-pro1x: Add PCA9534 IO Expander
      arm64: dts: qcom: sm6115-pro1x: Add Goodix Touchscreen
      arm64: dts: qcom: sm6115-pro1x: Add Caps Lock LED
      arm64: dts: qcom: sm6115-pro1x: Enable SD card slot
      arm64: dts: qcom: sm6115-pro1x: Enable MDSS and GPU
      arm64: dts: qcom: sm6115-pro1x: Hook up USB3 SS
      arm64: dts: qcom: sm6115-pro1x: Add PMI632 Type-C property
      arm64: dts: qcom: sm6115-pro1x: Enable RGB LED
      arm64: dts: qcom: sm6115-pro1x: Enable remoteprocs
      arm64: dts: qcom: sm6115-pro1x: Enable ATH10K WLAN

Danila Tikhonov (1):
      arm64: dts: qcom: sm7125-xiaomi-common: Add reset-gpios for ufs_me=
m_hc

Dara Stotland (7):
      arm64: tegra: Add common nodes to AGX Orin module
      arm64: tegra: Combine AGX Orin board files
      arm64: tegra: Combine IGX Orin board files
      arm64: tegra: Move AGX Orin nodes to correct location
      arm64: tegra: Move padctl supply nodes to AGX Orin module
      arm64: tegra: Move BPMP nodes to AGX Orin module
      arm64: tegra: Add thermal nodes to AGX Orin SKU8

David Heidelberg (1):
      dt-bindings: arm: tegra: Document Nyan, all revisions in kernel tr=
ee

David Jander (3):
      ARM: dts: stm32: Add MECIO1 and MECT1S board variants
      arm64: dts: rockchip: add CAN-FD controller nodes to rk3568
      arm64: dts: rockchip: add CAN0 and CAN1 interfaces to mecsbc board

David Virag (4):
      arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM amount to 4=
GB
      dt-bindings: clock: exynos7885: Fix duplicated binding
      dt-bindings: clock: exynos7885: Add CMU_TOP PLL MUX indices
      dt-bindings: clock: exynos7885: Add indices for USB clocks

Debbie Martin (1):
      arm64: dts: fvp: Set stdout-path to serial0 in the chosen node

Devarsh Thakkar (1):
      arm64: dts: ti: k3-am62a: Add E5010 JPEG Encoder

Diederik de Haas (1):
      arm64: dts: rockchip: Add missing tshut props to tsadc on quartz64=
-b

Diogo Ivo (3):
      arm64: tegra: Fix gpio for P2597 vmmc regulator
      arm64: tegra: Add wp-gpio for P2597's external card slot
      arm64: dts: ti: iot2050: Declare Ethernet PHY leds

Dmitry Baryshkov (5):
      dt-bindings: clock: qcom,sm8650-dispcc: replace with symlink
      ARM: dts: qcom: add generic compat string to RPM glink channels
      arm64: dts: qcom: add generic compat string to RPM glink channels
      arm64: dts: qcom: sm8350: add MDSS registers interconnect
      arm64: dts: qcom: sm8350: add refgen regulator

Dominik Haller (1):
      ARM: dts: ti: omap: am335x-wega: Fix audio clock provider

Dragan Simic (4):
      arm64: dts: rockchip: Correct the Pinebook Pro battery design capa=
city
      arm64: dts: rockchip: Move RK3399 OPPs to dtsi files for SoC varia=
nts
      arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM fre=
quency
      arm64: dts: allwinner: a64: Add GPU thermal trips to the SoC dtsi

Drew Fustini (6):
      riscv: dts: thead: Add TH1520 AP_SUBSYS clock controller
      riscv: dts: thead: change TH1520 uart nodes to use clock controller
      riscv: dts: thead: change TH1520 mmc nodes to use clock controller
      riscv: dts: thead: update TH1520 dma and timer nodes to use clock =
controller
      riscv: dts: thead: add clock to TH1520 gpio nodes
      riscv: dts: thead: change TH1520 SPI node to use clock controller

Duy Nguyen (1):
      arm64: dts: renesas: r8a779h0: Add CAN-FD node

Eddie James (5):
      dt-bindings: arm: aspeed: add IBM P11 BMC boards
      ARM: dts: aspeed: Add IBM P11 FSI devices
      ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
      ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
      ARM: dts: aspeed: Add IBM P11 Fuji BMC system

Elinor Montmasson (2):
      ARM: dts: imx6: update spdif sound card node properties
      arm64: dts: imx8m: update spdif sound card node properties

Emanuele Ghidoli (1):
      arm64: dts: colibri-imx8x: Add usb support

Emmanuel Gil Peyrot (1):
      arm64: dts: rockchip: Add VEPU121 to RK3588

Eric Chanudet (1):
      arm64: dts: ti: k3-j784s4-main: Align watchdog clocks

FUKAUMI Naoki (4):
      arm64: dts: rockchip: drop dr_mode for Radxa ZERO 3W/3E
      arm64: dts: rockchip: remove unnecessary properties for Radxa ROCK=
 5A
      arm64: dts: rockchip: enable PCIe on M.2 E key for Radxa ROCK 5A
      arm64: dts: rockchip: remove duplicate nodes from dts for ROCK 4SE

Fabio Estevam (10):
      ARM: dts: imx6sx-udoo-neo: Properly configure ENET_REF
      arm64: dts: imx8mm-phygate-tauri-l: Remove compatible from dtso
      arm64: dts: imx8mm-venice-gw72xx-0x: Remove compatible from dtso
      ARM: dts: imx1/imx27: Use dma-controller as node name
      arm64: dts: imx8mm/n-beacon-kit: Fix the order of ADV7535 reg entr=
ies
      arm64: dts: imx93-tqma9352-mba93: Fix USB hub node name
      ARM: dts: rockchip: Do not describe unexisting DAC device on rv110=
8-elgin-r1
      ARM: dts: imx28-apx4devkit: Fix the regulator description
      ARM: dts: imx23/8: Rename apbh and apbx nodes
      ARM: dts: imx28-tx28: Fix the fsl,saif-master usage

Faiz Abbas (1):
      arm64: dts: ti: k3-am654-idk: Add Support for MCAN

Fei Shao (1):
      arm64: dts: mediatek: mt8186-corsola: Update ADSP reserved memory =
region

Florian Klink (1):
      arm64: dts: rockchip: add rfkill node for M.2 E wifi on orangepi-5=
-plus

Francesco Dolcini (3):
      arm64: dts: colibri-imx8x: Add fxl6408 gpio expander
      arm64: dts: colibri-imx8x: Add PMIC thermal zone
      arm64: dts: colibri-imx8x: Add USB3803 HUB

Frank Li (43):
      arm64: dts: imx95: add edma[1..3] nodes
      arm64: dts: imx95: add sai[1..6], xcvr and micfill
      arm64: dts: imx95-19x19-evk: Add audio related nodes
      arm64: dts: imx95: add flexspi node
      arm64: dts: imx95-19x19-evk: add flexspi and child node
      arm64: dts: imx95: add thermal_zone label
      arm64: dts: imx95-19x19-evk: add pwm fan control
      arm64: dts: layerscape: rename aux-bus to bus
      arm64: dts: layerscape: rename rcpm as wakeup-control from power-c=
ontrol
      arm64: dts: layerscape: use common pcs-handle property
      arm64: dts: fsl-ls1043a: change uqe to uqe-bus and remove #address=
-cells
      arm64: dts: fsl-ls1028a: add fsl,ls1028-reset for syscon
      arm64: dts: layerscape: add msi-cell =3D <1> for gic its
      arm64: dts: layerscape: remove big-endian for mmc nodes
      arm64: dts: fsl-ls1046a: remove big-endian at memory-controller
      arm64: dts: layerscape: remove undocumented fsl,ls-pcie-ep
      arm64: dts: fsl,ls2085a: remove fsl,ls2085a-pcie
      arm64: dts: fsl-ls1028a: remove undocumented 'little-endian' for d=
spi node
      arm64: dts: fsl-ls208xa: move reboot node under syscon
      arm64: dts: imx8mm-venice-gw7901: add #address(size)-cells for gsc=
@20
      arm64: dts: imx8mp-data-modul-edm-sbc: remove #clock-cells for sai3
      arm64: dts: imx8mp-venice-gw74xx-imx219: remove compatible in over=
lay file
      dt-bindings: arm: fsl: add fsl-ls2081a-rdb board
      arm64: dts: imx8-ss-img: remove undocument slot for jpeg
      arm64: dts: fsl-ls1043a: move "fsl,ls1043a-qdma" ahead "fsl,ls1021=
a-qdma"
      arm64: dts: fsl-ls1012a-frdm: move clock-sc16is7xx under root node
      arm64: dts: layerscape: rename mdio-mux-emi to mdio-mux@<addr>
      arm64: dts: fsl-ls1028: add missed supply for wm8904
      arm64: dts: imx8mm-venice-gw7902(3): add #address-cells for gsc@20
      arm64: dts: fsl-lx2160a-tqmlx2160a: change "vcc" to "vdd" for hub*
      arm64: dts: imx8mp-venice: add vddl and vana for sensor@10
      arm64: dts: fsl-ls1088a-ten64: change to low case hex value
      arm64: dts: s32v234: remove fallback compatible string arm,cortex-=
a9-gic
      arm64: dts: imx8mm-beacon-kit: add DVDD-supply and DOVDD-supply
      arm64: dts: imx8: add basic lvds0 and lvds1 subsystem
      arm64: dts: imx8qm: add lvds subsystem
      arm64: dts: imx8: add basic mipi subsystem
      arm64: dts: imx8qm: add mipi subsystem
      arm64: dts: imx8qm-mek: add cm4 remote-proc and related memory reg=
ion
      arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
      arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
      arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes
      arm64: dts: imx: rename gpio hog as <gpio name>-hog

Frieder Schrempf (2):
      dt-bindings: arm: fsl: Add Kontron i.MX93 OSM-S based boards
      arm64: dts: Add support for Kontron i.MX93 OSM-S SoM and BL carrie=
r board

Geert Uytterhoeven (16):
      arm64: dts: renesas: r8a774a1: Add missing iommus properties
      arm64: dts: renesas: r8a774b1: Add missing iommus properties
      arm64: dts: renesas: r8a774c0: Add missing iommus properties
      arm64: dts: renesas: r8a774e1: Add missing iommus properties
      arm64: dts: renesas: r8a77960: Add missing iommus properties
      arm64: dts: renesas: r8a77961: Add missing iommus properties
      arm64: dts: renesas: r8a77965: Add missing iommus properties
      arm64: dts: renesas: r8a77970: Add missing iommus property
      arm64: dts: renesas: r8a77980: Add missing iommus properties
      arm64: dts: renesas: r8a779a0: Add missing iommus properties
      arm64: dts: renesas: r8a779g0: Add missing iommus properties
      arm64: dts: renesas: r8a779h0: Add missing iommus properties
      arm64: dts: renesas: gray-hawk-single: Add push switches
      arm64: dts: renesas: gray-hawk-single: Add GP LEDs
      arm64: dts: renesas: gray-hawk-single: Add CAN-FD support
      Merge tag 'renesas-r9a09g057-dt-binding-defs-tag' into renesas-dts=
-for-v6.12

Haibo Chen (1):
      arm64: dts: imx95: add flexcan[1..5] support

Heiko Stuebner (22):
      ARM: dts: rockchip: use constant for HCLK_SFC on rk3128
      arm64: dts: rockchip: add PCIe supply regulator to Qnap-TS433
      arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS=
433
      arm64: dts: rockchip: enable uart0 on Qnap-TS433
      arm64: dts: rockchip: enable usb ports on Qnap-TS433
      arm64: dts: rockchip: add stdout path on Qnap-TS433
      arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
      arm64: dts: rockchip: add board-aliases for Qnap-TS433
      arm64: dts: rockchip: add hdd leds to Qnap-TS433
      arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
      arm64: dts: rockchip: add gpio-keys to Qnap-TS433
      arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
      arm64: dts: rockchip: add missing pmic information on Qnap-TS433
      arm64: dts: rockchip: enable gpu on Qnap-TS433
      arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
      arm64: dts: rockchip: actually enable pmu-io-domains on qnap-ts433
      arm64: dts: rockchip: add product-data eeproms to QNAP TS433
      arm64: dts: rockchip: drop obsolete reset-names from rk356x rng no=
de
      arm64: dts: rockchip: use correct fcs,suspend-voltage-selector on =
NanoPC-T6
      arm64: dts: rockchip: drop unsupported regulator property from Nan=
oPC-T6
      arm64: dts: rockchip: drop unsupported regulator-property from Nan=
oPC-T6
      arm64: dts: rockchip: drop hp-pin-name property from audio card on=
 nanopc-t6

Huqiang Qin (1):
      arm64: dts: amlogic: add watchdog node for A4 SoCs

Inochi Amaoto (5):
      riscv: dts: sophgo: cv18xx: add DMA controller
      riscv: dts: sophgo: Add sdhci0 configuration for Huashan Pi
      riscv: dts: sophgo: Use common "interrupt-parent" for all peripher=
als for sg2042
      riscv: dts: sophgo: Add i2c device support for sg2042
      riscv: dts: sophgo: Add mcu device for Milk-V Pioneer

Jacky Huang (3):
      arm64: dts: nuvoton: Add syscon to the system-management node
      arm64: dts: nuvoton: ma35d1: Add pinctrl and gpio nodes
      arm64: dts: nuvoton: ma35d1: Add uart pinctrl settings

Jan Kiszka (2):
      arm64: dts: ti: k3-am642-evm: Silence schema warning
      arm64: dts: ti: iot2050: Add overlays for M.2 used by firmware

Jared McArthur (2):
      arm64: dts: ti: k3-am62p: Add gpio-reserved-ranges for main_gpio1
      arm64: dts: ti: k3-j722s: Add gpio-reserved-ranges for main_gpio1

Jianfeng Liu (2):
      arm64: dts: rockchip: Add VPU121 support for RK3588
      arm64: dts: rockchip: Add RGA2 support to rk3588

Johan Hovold (6):
      arm64: dts: qcom: sc8280xp-crd: disable PCIe perst pull downs
      arm64: dts: qcom: sc8280xp-crd: clean up PCIe2a pinctrl node
      arm64: dts: qcom: sc8280xp-x13s: disable PCIe perst pull downs
      arm64: dts: qcom: sc8280xp-x13s: clean up PCIe2a pinctrl node
      arm64: dts: qcom: x1e80100: add PCIe5 nodes
      arm64: dts: qcom: x1e80100-crd: enable SDX65 modem

Jon Hunter (1):
      arm64: tegra: Correct location of power-sensors for IGX Orin

Jonas Karlman (6):
      dt-bindings: arm: rockchip: Correct vendor for Hardkernel ODROID-M1
      arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-=
M1
      dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
      arm64: dts: rockchip: Add Hardkernel ODROID-M1S
      dt-bindings: arm: rockchip: Add Hardkernel ODROID-M2
      arm64: dts: rockchip: Add Hardkernel ODROID-M2

Jonathan Liu (1):
      arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK 4C+

Joy Zou (1):
      arm64: dts: ls1088ardb: add new RTC PCF2131 support

Jo=C3=A3o Paulo Gon=C3=A7alves (6):
      arm64: dts: imx8mp-verdin: add HDMI audio support
      arm64: dts: colibri-imx8x: Add analog inputs
      arm64: dts: colibri-imx8x: Add sound card
      arm64: dts: colibri-imx8x: Add vpu support
      arm64: dts: colibri-imx8x: Add adma_pwm
      arm64: dts: colibri-imx8x: Cleanup comments

Judith Mendez (5):
      arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
      arm64: dts: ti: k3-am62: Add comments to ESM nodes
      arm64: dts: ti: k3-am62a: Add ESM nodes
      arm64: dts: ti: k3-am64: Add more ESM interrupt sources
      arm64: dts: ti: k3-am65: Add ESM nodes

Junhao Xie (3):
      dt-bindings: vendor-prefixes: Add Shenzhen JLC Technology Group LC=
KFB
      dt-bindings: arm: rockchip: Add LCKFB Taishan Pi RK3566
      arm64: dts: rockchip: add dts for LCKFB Taishan Pi RK3566

Kanak Shilledar (1):
      riscv: dts: thead: add basic spi node

Karthikeyan Krishnasamy (3):
      ARM: dts: rockchip: Add i2c3 node for RV1126
      ARM: dts: rockchip: Add i2s0 node for RV1126
      ARM: dts: rockchip: Add pwm node for RV1126

Khanh Le (1):
      arm64: dts: renesas: r8a779h0: Add PWM device nodes

Konrad Dybcio (9):
      arm64: dts: qcom: x1e80100: Fix up hex style
      arm64: dts: qcom: x1e80100: Disable SMB2360_2 by default
      arm64: dts: qcom: x1e80100: Add USB Multiport controller
      dt-bindings: arm: qcom: Add Surface Laptop 7 devices
      arm64: dts: qcom: x1e80100-pmics: Add PMC8380C PWM
      arm64: dts: qcom: x1e80100: Add UART2
      arm64: dts: qcom: Add support for X1-based Surface Laptop 7 devices
      dt-bindings: arm: qcom: Add Lenovo ThinkPad T14s Gen 6
      arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6

Krishna Kurapati (1):
      arm64: dts: qcom: sa8295p-adp: Enable the four USB Type-A ports

Kry=C5=A1tof =C4=8Cern=C3=BD (2):
      arm64: dts: allwinner: h5: NanoPi Neo Plus2: Fix regulators
      arm64: dts: allwinner: h5: NanoPi NEO Plus2: Use regulators for pio

Krzysztof Kozlowski (19):
      ARM: dts: amlogic: meson8b-ec100: align GPIO keys node name with b=
indings
      dt-bindings: soc: bcm: document brcm,bcm2711-avs-monitor
      ARM: dts: microchip: at91: align LED node name with bindings
      ARM: dts: nuvoton: wpcm450: align LED and GPIO keys node name with=
 bindings
      arm64: dts: qcom: sm8150-mtp: drop incorrect amd,imageon
      Merge branch 'for-v6.12/clk-dt-bindings' into next/dt64
      Merge branch 'for-v6.12/clk-dt-bindings' into next/dt64
      MAINTAINERS: correct TQ Systems DTS patterns
      ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
      ARM: dts: imx7: align pin config nodes with bindings
      ARM: dts: imx7d-sdb: align pin config nodes with bindings
      dt-bindings: arm: fsl: drop usage of VAR-SOM-MX8MM SoM compatible =
alone
      ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp pinctrl
      ARM: dts: imx6ull-seeed-npi: fix fsl,pins property in tscgrp pinct=
rl
      ARM: dts: imx6ul-tx6ul: drop empty pinctrl placeholder
      ARM: dts: imx6ul: align pin config nodes with bindings
      ARM: dts: imx6sl: align pin config nodes with bindings
      ARM: dts: imx6qdl: align pin config nodes with bindings
      arm64: dts: imx8mm-var-som: drop unused top-level compatible

Kuninori Morimoto (1):
      arm64: dts: renesas: gray-hawk-single: Add Sound support

Kwanghoon Son (3):
      dt-bindings: clock: exynosautov9: add dpum clock
      arm64: dts: exynosautov9: add dpum clock DT nodes
      arm64: dts: exynosautov9: Add dpum SysMMU

Lad Prabhakar (14):
      arm64: dts: renesas: r9a08g045: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g043u: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g054: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g044: Correct GICD and GICR sizes
      dt-bindings: clock: renesas: Document RZ/V2H(P) SoC CPG
      dt-bindings: soc: renesas: Document RZ/V2H EVK board
      arm64: dts: renesas: Add initial SoC DTSI for RZ/V2H(P) SoC
      arm64: dts: renesas: Add initial DTS for RZ/V2H EVK board
      arm64: dts: renesas: r9a09g057: Add OSTM0-OSTM7 nodes
      arm64: dts: renesas: r9a09g057: Add RIIC0-RIIC8 nodes
      arm64: dts: renesas: r9a09g057: Add SDHI0-SDHI2 nodes
      arm64: dts: renesas: r9a09g057: Add WDT0-WDT3 nodes
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable OSTM, I2C, and=
 SDHI
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable watchdog

Laurent Pinchart (1):
      arm64: dts: imx8mp: Clarify csis clock frequency

Li Hua Qian (1):
      arm64: dts: ti: iot2050: Disable lock-step for all iot2050 boards

Lin, Meng-Bo (3):
      arm64: dts: qcom: msm8916-samsung-grandmax: Add touchscreen
      dt-bindings: qcom: Document samsung,j3ltetw
      arm64: dts: qcom: msm8916-samsung-j3ltetw: Add initial device tree

Ling Xu (1):
      arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes

Liu Ying (4):
      ARM: dts: imx53-qsb-hdmi: Do not disable TVE
      ARM: dts: imx53-qsb-hdmi: Merge display0 node
      arm64: dts: imx8mp-evk: Add native HDMI output
      arm64: dts: imx93-11x11-evk: Add PWM backlight for "LVDS" connector

Logan Bristol (1):
      arm64: dts: ti: k3-am64*: Disable ethernet by default at SoC level

Luca Weiss (3):
      ARM: dts: qcom: msm8226: Add CPU frequency scaling support
      ARM: dts: qcom: msm8226: Hook up CPU cooling
      ARM: dts: qcom: msm8226: Convert APCS usages to mbox interface

Lukasz Majewski (3):
      ARM: dts: imx28-lwe: Fix partitions definitions
      ARM: dts: imx28-lwe: Reduce maximal SPI frequency
      ARM: dts: imx28-lwe: Remove saif[01] definitions

MD Danish Anwar (1):
      arm64: dts: ti: k3-am654-idk: Fix dtbs_check warning in ICSSG dmas

Manikandan Muralidharan (4):
      ARM: dts: microchip: change to simple-mfd from simple-bus for PIO3=
 pinumux controller
      ARM: dts: microchip: Remove additional compatible string from PIO3=
 pinctrl nodes
      ARM: dts: microchip: sam9x60: Remove additional compatible string =
from GPIO node
      dt-bindings: pinctrl: Convert Atmel PIO3 pinctrl to json-schema

Marcel Ziswiler (1):
      arm64: dts: imx8mp-verdin: drop limit to sdio wi-fi frequency to 1=
00 mhz

Marcin Juszkiewicz (9):
      dt-bindings: arm: rockchip: Add NanoPC-T6 LTS
      arm64: dts: rockchip: prepare NanoPC-T6 for LTS board
      arm64: dts: rockchip: move NanoPC-T6 parts to DTS
      arm64: dts: rockchip: add NanoPC-T6 LTS
      arm64: dts: rockchip: add SPI flash on NanoPC-T6
      arm64: dts: rockchip: add IR-receiver to NanoPC-T6
      arm64: dts: rockchip: enable GPU on NanoPC-T6
      arm64: dts: rockchip: enable USB-C on NanoPC-T6
      arm64: dts: rockchip: add Mask Rom key on NanoPC-T6

Marek Vasut (10):
      arm64: dts: apm: storm: Rename menetphy@3 to ethernet-phy@3
      arm64: dts: imx8mp: Enable HDMI to Data Modul i.MX8M Plus eDM SBC
      arm64: dts: imx8mm: Update Data Modul i.MX8M Mini eDM SBC DT to re=
v.A01
      ARM: dts: stm32: Keep MDIO bus in AF across suspend DH STM32MP13xx=
 DHCOR DHSBC board
      ARM: dts: stm32: Disable PHY clock output on DH STM32MP13xx DHCOR =
DHSBC board
      ARM: dts: stm32: Add ethernet MAC nvmem cells to DH STM32MP13xx DH=
COR DHSBC board
      ARM: dts: stm32: Describe PHY LEDs in DH STM32MP13xx DHCOR DHSBC b=
oard DT
      ARM: dts: stm32: Sort properties in audio endpoints on STM32MP15xx=
 DHCOM PDK2
      ARM: dts: stm32: Switch bitclock/frame-master to flag on STM32MP15=
xx DHCOM PDK2
      ARM: dts: stm32: Use SAI to generate bit and frame clock on STM32M=
P15xx DHCOM PDK2

Markus Niebel (14):
      arm64: dts: freescale: imx93-tqma9352: improve pad configuration
      ARM: dts: imx7-mba7: add iio-hwmon support
      ARM: dts: imx7-mba7: improve compatible for LM75 temp sensor
      ARM: dts: imx6qdl-tqma6: move i2c3 pinmux to imx6qdl-tqma6b
      ARM: dts: imx6qdl-tqma6: improve compatible for LM75 temp sensor
      ARM: dts: imx6qdl-mba6: improve compatible for LM75 temp sensor
      ARM: dts: imx6qdl-mba6b: remove doubled entry for I2C1 pinmux
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: improve pad confi=
guration
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: add irq for temp =
sensor
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: add GPIO line nam=
es
      arm64: dts: freescale: imx93-tqma9352-mba93xxca: add RTC / temp se=
nsor IRQ
      arm64: dts: freescale: imx93-tqma9352-mba93xxca: improve pad confi=
guration
      arm64: dts: freescale: imx93-tqma9352-mba93xxca: add GPIO line nam=
es
      arm64: dts: freescale: imx93-tqma9352: set SION for cmd and data p=
ad of USDHC

Matthias Schiffer (1):
      arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU Ethernet supp=
ort

Max Merchel (1):
      dt-bindings: arm: fsl: correct spelling of TQ-Systems

Michael Riesch (1):
      arm64: dts: rockchip: add wolfvision pf5 visualizer display

Naina Mehta (3):
      arm64: dts: qcom: sdx75: update reserved memory regions for mpss
      arm64: dts: qcom: sdx75: Add remoteproc node
      arm64: dts: qcom: sdx75-idp: enable MPSS remoteproc node

Neil Armstrong (4):
      arm64: dts: qcom: sm8650-hdk: use the PMU to power up bluetooth
      arm64: dts: qcom: sm8550-qrd: use the PMU to power up bluetooth
      arm64: dts: amlogic: add clock and clock-names to sound cards
      arm64: dts: amlogic: gxlx-s905l-p271: drop saradc gxlx compatible

Nicolas Pitre (4):
      arm64: dts: mediatek: mt8186: add lvts definitions
      arm64: dts: mediatek: mt8186: add default thermal zones
      arm64: dts: mediatek: mt8188: add lvts definitions
      arm64: dts: mediatek: mt8188: add default thermal zones

Nikita Travkin (2):
      dt-bindings: arm: qcom: Add msm8916/39 based Lenovo devices
      arm64: dts: qcom: msm8916-samsung-gt58: Enable the touchkeys

Niklas S=C3=B6derlund (8):
      arm64: dts: renesas: r8a779g0: R-Car Ethernet TSN support
      arm64: dts: renesas: white-hawk-single: Wire-up Ethernet TSN
      arm64: dts: renesas: r8a779g0: Add family fallback for VIN IP
      arm64: dts: renesas: r8a779a0: Add family fallback for VIN IP
      arm64: dts: renesas: r8a779h0: Add family fallback for VIN IP
      arm64: dts: renesas: r8a779g0: Add family fallback for CSISP IP
      arm64: dts: renesas: r8a779a0: Add family fallback for CSISP IP
      arm64: dts: renesas: r8a779h0: Add family fallback for CSISP IP

Ninad Palsule (1):
      ARM: dts: aspeed: System1: Updates to BMC board

Nishanth Menon (2):
      arm64: dts: ti: k3-am642-evm-nand: Rename pinctrl node and gpio-ho=
g names
      arm64: dts: ti: k3-j721s2-evm-gesi-exp-board: Rename gpio-hog node=
 name

N=C3=ADcolas F. R. A. Prado (4):
      arm64: dts: mediatek: cherry: Specify pull resistance for RSEL GPI=
Os
      arm64: dts: mediatek: mt8195-cherry: Remove keyboard-backlight node
      arm64: dts: mediatek: mt8195: Add SCP phandle to MDP3 DMA controll=
er
      arm64: dts: mediatek: mt8183-kukui: Disable unused efuse at 8000000

Oleksij Rempel (2):
      ARM: dts: stm32: stm32mp151a-prtt1l: Fix QSPI configuration
      dt-bindings: arm: stm32: Add compatible strings for Protonic boards

Oliver Rhodes (3):
      dt-bindings: soc: renesas: Document RZ/G2M v3.0 (r8a774a3) SoC
      dt-bindings: power: renesas: Document RZ/G2M v3.0 (r8a774a3) SYSC =
binding
      dt-bindings: reset: renesas: Document RZ/G2M v3.0 (r8a774a3) reset=
 module

Paul Barker (6):
      arm64: dts: renesas: rzg2l: Enable Ethernet TXC output
      arm64: dts: renesas: rzg2lc: Enable Ethernet TXC output
      arm64: dts: renesas: rzg2ul: Enable Ethernet TXC output
      arm64: dts: renesas: rzg2l: Set Ethernet PVDD to 1.8V
      arm64: dts: renesas: rzg2lc: Set Ethernet PVDD to 1.8V
      arm64: dts: renesas: rzg2ul: Set Ethernet PVDD to 1.8V

Paul Elder (1):
      arm64: dts: imx8mp: Add DT nodes for the two ISPs

Peng Fan (5):
      arm64: dts: imx95: add p2a reply channel
      arm64: dts: imx93: drop duplicated properties
      dt-bindings: arm: fsl: add i.MX93 14x14 EVK board
      arm64: dts: imx93: support i.MX93-14x14-EVK board
      arm64: dts: imx93: add cache info

Peter Griffin (1):
      arm64: dts: exynos: gs101: add syscon-poweroff and syscon-reboot n=
odes

Peter Yin (11):
      ARM: dts: aspeed: harma: Revise hsc chip
      ARM: dts: aspeed: harma: Add VR devices
      ARM: dts: aspeed: harma: Add sgpio name
      ARM: dts: aspeed: harma: Add ina238
      ARM: dts: aspeed: harma: Add power monitor xdp710
      ARM: dts: aspeed: harma: Remove multi-host property
      ARM: dts: aspeed: harma: Add fru device
      ARM: dts: aspeed: harma: Add temperature device
      ARM: dts: aspeed: harma: Enable mctp controller
      ARM: dts: aspeed: harma: Fix spi-gpio dtb_check warnings
      ARM: dts: aspeed: harma: Remove pca9546

Philippe Schenker (1):
      arm64: dts: colibri-imx8x: Add 50mhz clock for eth

Pi-Hsun Shih (1):
      arm64: dts: mt8183: add dpi node to mt8183

Pin-yen Lin (1):
      arm64: dts: mediatek: mt8183: Remove clock from mfg_async power do=
main

Potin Lai (4):
      dt-bindings: arm: aspeed: add Meta Catalina board
      ARM: dts: aspeed: catalina: add Meta Catalina BMC
      ARM: dts: aspeed: catalina: Add pdb cpld io expander
      ARM: dts: aspeed: catalina: Update io expander line names

Prasanth Babu Mantena (1):
      arm64: dts: ti: k3-am68-sk-som: Update Partition info for OSPI Fla=
sh

Qingqing Zhou (1):
      arm64: dts: qcom: sa8775p: Mark APPS and PCIe SMMUs as DMA coherent

Rafa=C5=82 Mi=C5=82ecki (4):
      ARM: dts: broadcom: convert NVMEM content to layout syntax
      ARM: dts: omap: am335x-bone: convert NVMEM content to layout syntax
      arm64: dts: mediatek: mt7981: add SPI controllers
      ARM: dts: aspeed: convert ASRock SPC621D8HM3 NVMEM content to layo=
ut syntax

Rajendra Nayak (1):
      arm64: dts: qcom: x1e80100: add rpmh-stats node

Raymond Hackley (2):
      arm64: dts: qcom: msm8916-samsung-rossa: Add touchscreen
      arm64: dts: qcom: msm8916-samsung-fortuna: Add touch keys

Rayyan Ansari (12):
      arm64: dts: qcom: pmi8994: Add label to wled node
      arm64: dts: qcom: pmi8950: Remove address from lpg node
      ARM: dts: qcom: pma8084: add pon node
      ARM: dts: qcom: apq8064-pins: correct error in drive-strength prop=
erty
      ARM: dts: qcom: asus,nexus7-flo: remove duplicate pinctrl handle i=
n i2c nodes
      ARM: dts: qcom: apq8064: adhere to pinctrl dtschema
      ARM: dts: qcom: ipq8064: adhere to pinctrl dtschema
      ARM: dts: qcom: ipq4019: adhere to pinctrl dtschema
      ARM: dts: qcom: apq8064: drop reg-names on sata-phy node
      arm64: dts: qcom: msm8939-samsung-a7: rename pwm node to conform t=
o dtschema
      ARM: dts: qcom: {a,i}pq8064: correct clock-names in sata node
      ARM: dts: qcom: msm8226-microsoft-common: Add inertial sensors

Rob Clark (1):
      arm64: dts: qcom: x1e80100-yoga: Update panel bindings

Rob Herring (2):
      arm64: dts: toshiba: Fix pl011 and pl022 clocks
      ARM: dts: Fix undocumented LM75 compatible nodes

Rob Herring (Arm) (1):
      arm: dts: realview: Add/drop missing/spurious unit-addreses

Robert Nelson (2):
      dt-bindings: arm: ti: Add BeagleY-AI
      arm64: dts: ti: Add k3-am67a-beagley-ai

Rohit Agarwal (2):
      arm64: dts: mediatek: mt8186: Add power domain for DPI
      arm64: dts: mediatek: mt8186: Add svs node

Sachin Gupta (1):
      arm64: dts: qcom: qcm6490-idp: Add SD Card node

Sagar Cheluvegowda (1):
      arm64: dts: qcom: sa8775p: Add interconnects for ethernet

Sam Protsenko (1):
      dt-bindings: clock: exynos850: Add TMU clock

Santhosh Kumar K (1):
      arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM

Satya Priya Kakitapalli (2):
      dt-bindings: clock: qcom: Add SM8150 camera clock controller
      arm64: dts: qcom: Add camera clock controller for sm8150

Sean Nyekjaer (1):
      ARM: dts: stm32: Add missing gpio options for sdmmc2_d47_pins_d

Sergey Bostandzhyan (2):
      dt-bindings: arm: rockchip: Add NanoPi R2S Plus
      arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus

Shengjiu Wang (4):
      arm64: dts: imx93: Add #sound-dai-cells property
      arm64: dts: imx93-11x11-evk: add bt-sco sound card support
      arm64: dts: imx93-11x11-evk: Add PDM microphone sound card support
      arm64: dts: imx93-11x11-evk: Add audio XCVR sound card

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j784s4-evm: Use 4 lanes for PCIe0 on EVM

Srinivas Kandagatla (4):
      arm64: dts: qcom: x1e80100: add soundwire controller resets
      arm64: dts: x1e80100-crd: fix wsa soundwire port mapping
      arm64: dts: x1e80100-qcp: fix wsa soundwire port mapping
      arm64: dts: qcom: sm8250: move lpass codec macros to use clks dire=
ctly

Stanislav Jakubek (3):
      arm64: dts: sprd: rename SDHCI and fuel gauge nodes to match bindi=
ngs
      arm64: dts: sprd: reorder clock-names after clocks
      arm64: dts: sprd: move/add SPDX license to top of the file

Stefan Wahren (3):
      ARM: dts: bcm2837/bcm2712: adjust local intc node names
      dt-bindings: timer: convert bcm2835-system-timer bindings to YAML
      dt-bindings: interrupt-controller: convert bcm2836-l1-intc to yaml

Steffen Hemer (1):
      ARM: dts: ti: omap: am335x-regor: Fix RS485 settings

Stephan Gerhold (1):
      arm64: dts: qcom: x1e80100-crd: Add LID switch

Sunyeal Hong (2):
      dt-bindings: clock: add ExynosAuto v920 SoC CMU bindings
      arm64: dts: exynosautov920: add initial CMU clock nodes in ExynosA=
uto v920

Svyatoslav Ryhel (11):
      ARM: tegra: tf701t: Use unimomentary pinmux setup
      ARM: tegra: tf701t: Bind VDE device
      ARM: tegra: tf701t: Correct and complete PMIC and PMC bindings
      ARM: tegra: tf701t: Add HDMI bindings
      ARM: tegra: tf701t: Add Bluetooth node
      ARM: tegra: tf701t: Adjust sensors nodes
      ARM: tegra: tf701t: Complete sound bindings
      ARM: tegra: tf701t: Bind WIFI SDIO and EMMC
      ARM: tegra: tf701t: Re-group GPIO keys
      ARM: tegra: tf701t: Use dedicated backlight regulator
      ARM: tegra: tf701t: Configure USB

Tarang Raval (3):
      arm64: dts: imx8mm-emtop-baseboard: Add Ethernet Support
      dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX=
8MP SoM
      arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board =
and VAR-SOM-MX8MP SoM

Tengfei Fan (3):
      arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON
      dt-bindings: mailbox: qcom-ipcc: Add GPDSP0 and GPDSP1 clients
      arm64: dts: qcom: sa8775p: add ADSP, CDSP and GPDSP nodes

Teresa Remmet (1):
      arm64: dts: imx8mp-phyboard-pollux: Add SD-Card vqmmc supply

Thomas Bonnefille (2):
      dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
      dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles

Th=C3=A9o Lebrun (1):
      arm64: dts: ti: k3-am64: add USB fallback compatible to J721E

Tim Harvey (2):
      dt-bindings: arm: fsl: rename gw7905 to gw75xx
      arm64: dts: freescale: rename gw7905 to gw75xx

Tomasz Maciej Nowak (4):
      arm64: tegra: Wire up power sensors on Jetson TX1 DevKit
      arm64: tegra: Wire up Bluetooth on Jetson TX1 module
      arm64: tegra: Wire up WiFi on Jetson TX1 module
      ARM: tegra: Wire up two front panel LEDs on TrimSlice

Uwe Kleine-K=C3=B6nig (1):
      arm64: dts: rockchip: Simplify network PHY connection on qnap-ts433

Varadarajan Narayanan (2):
      dt-bindings: interconnect: Add Qualcomm IPQ5332 support
      arm64: dts: qcom: ipq5332: Add icc provider ability to gcc

Vedant Deshpande (4):
      arm64: tegra: Add DMA properties for Tegra234 UARTA
      arm64: tegra: enable same UARTs for Orin NX/Nano
      arm64: tegra: Add Tegra234 PCIe C4 EP definition
      arm64: tegra: Add p3767 PCIe C4 EP details

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62p5-sk: Remove CTS/RTS from wkup_uart0 pinct=
rl

Vladimir Zapolskiy (2):
      arm64: dts: qcom: sm8550: add description of CCI controllers
      arm64: dts: qcom: sm8650: add description of CCI controllers

Wadim Egorov (1):
      arm64: dts: ti: am642-phyboard-electra: Add PRU-ICSSG nodes

Wei Fang (1):
      arm64: dts: imx95: Add NETCMIX block control support

Xianwei Zhao (10):
      arm64: dts: amlogic: a5: add power domain controller node
      arm64: dts: amlogic: enable some device nodes for S4
      arm64: dts: amlogic: s4: add ao secure node
      arm64: dts: amlogic: c3: add ao secure node
      arm64: dts: amlogic: t7: add ao secure node
      arm64: dts: amlogic: a4: add ao secure node
      dt-bindings: clock: fix C3 PLL input parameter
      arm64: dts: amlogic: add some device nodes for C3
      arm64: dts: amlogic: add C3 AW419 board
      arm64: dts: amlogic: c3: fix dtbcheck warning

Xu Yang (1):
      arm64: dts: imx95: add DDR Perf Monitor node

Yang Chen (18):
      ARM: dts: aspeed: minerva: change the address of tmp75
      ARM: dts: aspeed: minerva: change aliases for uart
      ARM: dts: aspeed: minerva: add eeprom on i2c bus
      ARM: dts: aspeed: minerva: change RTC reference
      ARM: dts: aspeed: minerva: enable mdio3
      ARM: dts: aspeed: minerva: remove unused bus and device
      ARM: dts: aspeed: minerva: Define the LEDs node name
      ARM: dts: aspeed: minerva: Add adc sensors for fan board
      ARM: dts: aspeed: minerva: add linename of two pins

Yannic Moog (3):
      arm64: dts: imx8mp-phyboard-pollux: add rtc aux-voltage-chargeable
      arm64: dts: imx8mm-phyboard-polis: add rtc aux-voltage-chargeable
      arm64: dts: imx8mm-phygate-tauri-l: add rtc aux-voltage-chargeable

Yashwanth Varakala (5):
      arm64: dts: imx8mp-phycore: Add VDD_IO regulator
      arm64: dts: imx8mp-phycore: Assign regulator to EEPROM node
      arm64: dts: imx8mp-phyboard-pollux: Assign regulator to EEPROM node
      arm64: dts: imx8mp-phyboard-pollux: Add VCC_5V_SW regulator
      arm64: dts: imx8mp-phyboard-pollux: Add usb3_phy1 regulator refere=
nce

Yoshihiro Shimoda (2):
      arm64: dts: renesas: r8a779g0: Add PCIe Host and Endpoint nodes
      arm64: dts: renesas: white-hawk-cpu-common: Enable PCIe Host ch0

