Return-Path: <linux-kernel+bounces-416399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4879D443F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C7A1F22CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF21D5CF4;
	Wed, 20 Nov 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rZX/BFi2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isyQUhiF"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15161D460B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143598; cv=none; b=pGY6pnr7+xzwPuk8yl2M9Li606J+jJKP+uiH52pkmCVgM9Bus//cAjkK+NFKUDw8ZsseodIK4686AyAiJHPnUfoidnUDMBG3oOJH1zlLOQ6c7WIJChYG3c7iH0nVMRnBO7lJAugp2cx/WoeZFYPDAhAGBFxkkgjuo3hIqWmqnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143598; c=relaxed/simple;
	bh=d7D96s1Grottwuv8H3wrSUGzpgg13SAZFtI24scQJfM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SqHBzufmW1s/y2pDgSowFlhuC1iIPoei9OUqOQIy1jBh10TN3BVriNyPvIWDNr3gOgKnjKO1CF/pCvpdFoXPqrvCO4bfTrTdw/1290zFOVS/+pWRtrS4vJGshgdhaFLdZI/tT/qYymUZIlYzaheZpFM6jA1lK0UST8Bk1pv2A2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rZX/BFi2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isyQUhiF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 055BB13806AD;
	Wed, 20 Nov 2024 17:59:52 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 17:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732143591;
	 x=1732229991; bh=ML5Qddo1m1Px8FFRVhH1zTjjiHWhJz3iSha7VbHnAjY=; b=
	rZX/BFi2bU3f4zsKZnV2Vt6CrCafUWQyExnk+3Je3tuaLBEvx0CuxNnYrbad9Xy8
	gpP+fyKZc/zJKCbesiKCf43uISkaRbw/1mZfrbJkxrhrXOvBU82UaKdms4HkWZPZ
	8BHwilXAdz0u3rGLgDXIWDktvM/RPfaIFNdlJHHtGpRXWu6mPbth26RKsxU23e7A
	+XatnlY97VUL3dOldLts+JXw1FAaiCnFZb+tadG0NFsdHAYzKZBL1SESi+jH2DpR
	uhtN1Hgk1dVSvMQwGEWm081cDaa7+hVZBexiYdqaiKGMMpc4K22MJKfhorBCzDB/
	YkxpYMwsSwqoQ+CnX6lwyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732143591; x=
	1732229991; bh=ML5Qddo1m1Px8FFRVhH1zTjjiHWhJz3iSha7VbHnAjY=; b=i
	syQUhiF2uski66T3eZcoRX+kgG/Fx1JTXQbRkfUMrb9E2h2yh6xn0xxkXAuzBC0n
	U2vDqrMkdU0bAVpOEXNfo3JH8bm1zPCRKQnpgKMpFeNWtBhBjVYkC7r4zGDk03y/
	vt62WYkxUa0QNk64L3HrA/zHSFpIYZmrhZUNG85Q+6GPTN3qhnC1aJKx6wh6O9Xn
	qy+3KsDudvGF6fnS/DDSc82paQOyO19v5QTA1R1fmiMCY4eIANQvvtShSLm7wwHh
	6LmOkOU022Cy3NLBQ4Vh0e3BZf68q2Albtz7cndIvkIzg0CKbBaYyLCNQWSeFVmR
	QuxjTq8UOBA7coDruS8dw==
X-ME-Sender: <xms:52k-Z2EbH0yqfgJQrka_1AUzYZ6dBUR8c4KL1U17FDNwM8g0mD14Ig>
    <xme:52k-Z3XqOf9pVNEqI9PRnfZkg-8E5_n8DYTPn_ZisjHtp02Srfn9zQe3CZTd79r_Z
    MJie_yqIaWYMXpX85U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefueegkeffveeugeehieehiedukeegfefhffeutdet
    tdffteeluefhheetkeekvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:52k-ZwJKikX9lBQWjYJNTKpWjLnMzLDBsRLYs8rKePZLl99fGxVkgw>
    <xmx:52k-ZwG7GhV045cn6xfLWysXYBL6xt3yMn0ny5xJABnHlsIsKyqc8Q>
    <xmx:52k-Z8VJlH-5JuRK8Tt-qJDlLQdNksoiHrxvRHIKlmnksee_FJB3hA>
    <xmx:52k-ZzMD7eSCWAn2HhLvR8cZzjf8g-zw3UHKzv0lOY8PJQ3nza-RUg>
    <xmx:52k-ZzR8kcCYVo3y39YDQlH2AGS7a6Bftx4zpMNgaUtWwYxHhaPhX5L0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 57BB02220071; Wed, 20 Nov 2024 17:59:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Nov 2024 23:59:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-Id: <8fa23f93-385f-4996-8298-2271d259b352@app.fastmail.com>
In-Reply-To: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
Subject: [GIT PULL 1/4] soc: devicetree updates for 6.13
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600=
924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.13

for you to fetch changes up to 9f5cbdaae5f760c218c82e0a5e0f9c58bac56f0c:

  arm64: dts: apm: Remove unused and undocumented "bus_num" property (20=
24-11-19 18:03:08 +0100)

----------------------------------------------------------------
soc: devicetree updates for 6.13

This release adds the devicetree files for an impressive number of new
SoC variants, though as expected these are all related to others we
already support:

 - The microchip sam9x7 devicetree is now added, after the device driver
   and platform code has already made it in. This is likely the last ARM=
v5
   (!)  platform to ever get added, updating the 20+ year old at91/sam9
   platform wtih DDR3 memory and gigabit ethernet.

 - On the Apple platform, there are now devicetree files for a number of
   A-series SoCs in addition to the M-series ones, these are used
   primarily in phones and tablets, but are closely related to the
   already supported chips.

 - Samsung Exynos 8895 and Exynos 990 are more phone SoCs used in older
   Samsung Galaxy phones.

 - Qualcomm Snapdragon 778G (SM7325) is another phone SoC, closely relat=
ed
   to the Snapdragon 7c+ Gen 3 (SC7280) used in low-end laptops.

 - Rockchip RK3528 and RK3576 are new variants of their TV box and Tablet
   chips, still using the older ARMv8.0 cores from RK3328/RK3399 but
   with a newer process and other improvements from the RK35xx (otherwise
   ARMv8.2) chips.  RK3566T and RK3399-S are also added, these are just
   lower-cost versions of their normal counterparts.

 - TI J742S2 is a feature-reduced version of the J784s4
   industrial/automotive SoC, with fewer CPU cores.

 - Sophgo SG2002 is an embedded SoC with one RISC-V (C906) and one ARM
   (Cortex-A53) core, at this point support is only added for running
   on the RISC-V side on the LicheeRV Nano board.

A total of 92 new .dts files describing individual machines is added,
which must be a new record. The majority of these is for the newly added
chips above, notably all the Apple phones and tablets.  The other new
machines include nine industrial/embedded boards with NXP i.MX6 or i.MX8
SoCs, eight for Rockchips RK35XX and one or two each for Rockchips RV110=
9,
RK3308, Allwinner A33, Tegra 234, Qualcomm qcs9100/sc8280xp/x1e80100,
TI AM625 and Starfive JH7110.

As usual there are also many newlyad added features in existing boards
as well as cleanups and minor bugfixes.

----------------------------------------------------------------

[trying the full 132KB diffstat this time, let's see if this makes it
to the mailing list]

Abel Vesa (2):
      arm64: dts: qcom: x1e80100-slim7x: Drop orientation-switch from US=
B SS[0-1] QMP PHYs
      arm64: dts: qcom: x1e80100-vivobook-s15: Drop orientation-switch f=
rom USB SS[0-1] QMP PHYs

Aleksandrs Vinarskis (4):
      dt-bindings: arm: qcom: Add Dell XPS 13 9345
      arm64: dts: qcom: Add support for X1-based Dell XPS 13 9345
      arm64: dts: qcom: x1e80100-dell-xps13-9345: route edp-panel enable=
 gpio
      arm64: dts: qcom: x1e80100-dell-xps13-9345: fix nvme regulator boo=
t glitch

Alexander Dahl (2):
      ARM: dts: microchip: Add trng labels for all at91 SoCs
      ARM: dts: microchip: Unify rng node names

Alexander Stein (2):
      ARM: dts: imx6qdl-mba6: Add reserved memory area for CMA memory
      arm64: dts: imx95: Add missing vendor string to SCMI property

Alper Nebi Yasak (1):
      arm64: dts: mediatek: mt8183-kukui: Disable DPI display interface

Amelie Delaunay (3):
      arm64: dts: st: add DMA support on U(S)ART instances of stm32mp25
      arm64: dts: st: add DMA support on I2C instances of stm32mp25
      arm64: dts: st: add DMA support on SPI instances of stm32mp25

Andre Przywara (1):
      ARM: dts: cubieboard4: Fix DCDC5 regulator constraints

Andreas Kemnade (13):
      ARM: dts: imx6sll: fix anatop thermal dtbs_check warnings
      ARM: dts: omap: omap4-epson-embt2ws: define GPIO regulators
      ARM: dts: omap: omap4-epson-embt2ws: wire up regulators
      ARM: dts: omap: omap4-epson-embt2ws: add unknown gpio outputs
      ARM: dts: omap: omap4-epson-embt2ws: add GPIO expander
      ARM: dts: ti/omap: use standard node name for twl4030 charger
      ARM: dts: ti/omap: dra7: fix redundant clock divider definition
      ARM: ti/omap: omap3-gta04a5: add Bluetooth
      ARM: dts: omap36xx: declare 1GHz OPP as turbo again
      ARM: dts: ti/omap: omap4-epson-embt2ws: add charger
      dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
      ARM: dts: imx: Add devicetree for Kobo Clara 2E
      ARM: dts: omap4-kc1: fix twl6030 power node

Andrei Simion (4):
      ARM: dts: microchip: sam9x60: Add missing property atmel,usart-mode
      ARM: dts: microchip: Rename the eeprom nodename
      ARM: dts: microchip: Rename the pmic node
      ARM: dts: microchip: Rename LED sub nodes name

Andrejs Cainikovs (2):
      arm64: dts: imx8qm: Remove adma pwm
      arm64: dts: imx8-apalis: Set thermal thresholds

Andy Yan (3):
      arm64: dts: rockchip: Enable HDMI0 for rk3588 Cool Pi CM5 EVB
      arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi 4B
      arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBo=
ok

AngeloGioacchino Del Regno (1):
      dt-bindings: arm: mediatek: mmsys: Add OF graph support for board =
path

Anurag Dutta (3):
      arm64: dts: ti: k3-j7200: Fix clock ids for MCSPI instances
      arm64: dts: ti: k3-j721e: Fix clock IDs for MCSPI instances
      arm64: dts: ti: k3-j721s2: Fix clock IDs for MCSPI instances

Arnaud Vrac (1):
      arm64: dts: qcom: msm8998: add HDMI nodes

Arnd Bergmann (35):
      Merge tag 'thead-dt-for-v6.13' of https://github.com/pdp7/linux in=
to soc/dt
      Merge tag 'thead-dt-for-v6.13-p2' of https://github.com/pdp7/linux=
 into soc/dt
      Merge tag 'renesas-dts-for-v6.13-tag1' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'ux500-dts-for-v6.13' of https://git.kernel.org/pub/scm/=
linux/kernel/git/linusw/linux-nomadik into soc/dt
      Merge tag 'tegra-for-6.13-dt-bindings' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.13-arm64-dt' of https://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'samsung-dt64-6.13' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/krzk/linux into soc/dt
      Merge tag 'v6.13-armsoc/dts64-1' of https://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'zynqmp-dt-for-6.13' of https://github.com/Xilinx/linux-=
xlnx into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.13' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'qcom-arm32-for-6.13' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'imx-bindings-6.13' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.13' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.13' of https://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/dt
      Merge tag 'mtk-dts64-for-v6.13' of https://git.kernel.org/pub/scm/=
linux/kernel/git/mediatek/linux into soc/dt
      Merge tag 'renesas-dts-for-v6.13-tag2' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'omap-for-v6.13/dt-signed-1' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/khilman/linux-omap into soc/dt
      Merge tag 'qcom-arm64-for-6.13' of https://git.kernel.org/pub/scm/=
linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'riscv-sophgo-dt-for-v6.13' of https://github.com/sophgo=
/linux into soc/dt
      Merge tag 'amlogic-arm-dt-for-v6.13' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.13' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'ti-k3-dt-for-v6.13' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/ti/linux into soc/dt
      Merge tag 'stm32-dt-for-v6.13-1' of https://git.kernel.org/pub/scm=
/linux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'mvebu-dt-6.13-1' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'mvebu-dt64-6.13-1' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'riscv-dt-for-v6.13' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/conor/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.13-2' of https://git.kernel.org/pub/scm/=
linux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'v6.13-rockchip-dts32-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'v6.13-rockchip-dts64-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'asahi-soc-dt-6.13' of https://github.com/AsahiLinux/lin=
ux into soc/dt
      Merge tag 'samsung-drivers-6.13' of https://git.kernel.org/pub/scm=
/linux/kernel/git/krzk/linux into soc/dt
      Merge tag 'v6.13-armsoc/drivers1' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'at91-dt-6.13' of https://git.kernel.org/pub/scm/linux/k=
ernel/git/at91/linux into soc/dt
      Merge tag 'at91-soc-6.13' of https://git.kernel.org/pub/scm/linux/=
kernel/git/at91/linux into soc/dt
      Merge tag 'sunxi-fixes-for-6.12' of https://git.kernel.org/pub/scm=
/linux/kernel/git/sunxi/linux into soc/dt

Ayush Singh (1):
      arm64: dts: ti: k3-am625-beagleplay: Enable MikroBUS PWM

Bartosz Golaszewski (7):
      arm64: dts: qcom: sm8650: extend the register range for UFS ICE
      arm64: dts: qcom: sm8550: extend the register range for UFS ICE
      arm64: dts: qcom: sa8775p: extend the register range for UFS ICE
      arm64: dts: qcom: sc8280xp-crd: model the PMU of the on-board wcn6=
855
      arm64: dts: qcom: sc8280xp-crd: enable bluetooth
      arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn=
6855
      arm64: dts: qcom: sm8450-hdk: model the PMU of the on-board wcn6855

Benjamin Hahn (1):
      arm64: dts: imx8mp-phyboard-pollux-rdk: update gpio-line-names

Bhavin Sharma (2):
      dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal S=
MARC Carrier Board
      arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMAR=
C Carrier Board

Biju Das (2):
      arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
      arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition tabl=
e for spi-nor flash

Bjorn Andersson (2):
      arm64: dts: qcom: qcs6490-rb3gen2: Specify i2c1 clock frequency
      Merge branch '20241011-sa8775p-mm-v4-resend-patches-v5-0-4a9f17dc6=
83a@quicinc.com' into arm64-for-6.13

Bryan Brattlof (4):
      arm64: dts: ti: k3-am62a: add opp frequencies
      arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
      arm64: dts: ti: k3-am62p: add opp frequencies
      arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry

Bryan O'Donoghue (6):
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Convert mezzanine =
riser to dtbo
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Convert mezz=
anine riser to dtso
      arm64: dts: qcom: sc8280xp-x13s: Drop redundant clock-lanes from c=
amera@10
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Drop redundant clo=
ck-lanes from camera@1a
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Add cma heap for l=
ibcamera softisp support
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Add cma heap=
 for libcamera softisp support

Carlos Song (6):
      arm64: dts: imx93-11x11-evk: remove redundant "sleep" pinctrl in l=
pi2c2 node
      arm64: dts: imx8qxp: Add LPSPI alias
      arm64: dts: imx8qm: Add LPSPI alias
      arm64: dts: imx8dxl: Add LPSPI alias
      arm64: dts: imx8ulp: Add LPSPI alias
      arm64: dts: imx93: Add LPSPI alias

Catalin Popescu (1):
      arm64: dts: imx8mp: add cpuidle state "cpu-pd-wait"

Cenk Uluisik (3):
      arm64: dts: rockchip: refactor common Orange Pi 5 board
      dt-bindings: arm: rockchip: Add Orange Pi 5b enum to Orange Pi 5 e=
ntry
      arm64: dts: rockchip: Add rk3588-orangepi-5b device tree

Chancel Liu (1):
      arm64: dts: imx93-11x11-evk: Enable sound-wm8962 sound card

Chen Wang (1):
      riscv: sophgo: dts: add power key for pioneer box

Chen-Yu Tsai (8):
      arm64: dts: mediatek: mt8186-corsola-voltorb: Merge speaker codec =
nodes
      arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to second so=
urce trackpad
      arm64: dts: mediatek: mt8186-corsola: Fix GPU supply coupling max-=
spread
      arm64: dts: mediatek: mt8186-corsola: Fix IT6505 reset line polari=
ty
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Fix DP bridge supply n=
ames
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add supplies for fixed=
 regulators
      arm64: dts: mediatek: mt8183-kukui: Drop bogus fixed regulators
      arm64: dts: rockchip: orangepi-5-plus: Enable GPU

Chris Morgan (5):
      dt-bindings: arm: rockchip: Add Powkiddy RGB20SX
      arm64: dts: rockchip: Add Powkiddy RGB20SX
      arm64: dts: rockchip: correct analog audio name on Indiedroid Nova
      arm64: dts: rockchip: Enable GPU on Indiedroid Nova
      arm64: dts: rockchip: Enable HDMI0 on Indiedroid Nova

Christophe Roullier (2):
      ARM: dts: stm32: add support of WLAN/BT on stm32mp157c-dk2
      ARM: dts: stm32: add support of WLAN/BT on stm32mp135f-dk

Ciprian Marian Costea (2):
      arm64: dts: s32g: Add S32G2/S32G3 uSDHC pinmux
      arm64: dts: s32g2: Disable support for SD/eMMC UHS mode

Claudiu Beznea (6):
      dt-bindings: clock: r9a08g045-cpg: Add power domain ID for RTC
      dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
      arm64: dts: renesas: r9a08g045: Add VBATTB node
      arm64: dts: renesas: r9a08g045: Add RTC node
      arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
      arm64: dts: renesas: rzg3s-smarc-som: Enable RTC

Cody Eksal (3):
      dt-bindings: phy: sun50i-a64: add a100 compatible
      dt-bindings: usb: Add A100 compatible string
      dt-bindings: usb: sunxi-musb: Add A100 compatible string

Cristian Ciocaltea (5):
      arm64: dts: rockchip: Add HDMI0 node to rk3588
      arm64: dts: rockchip: Enable HDMI0 on rock-5b
      arm64: dts: rockchip: Enable HDMI0 on rk3588-evb1
      arm64: dts: rockchip: Enable HDMI0 on orangepi-5-plus
      arm64: dts: rockchip: Enable HDMI0 on rock-5a

Cs=C3=B3k=C3=A1s, Bence (1):
      ARM: dts: allwinner: Remove accidental suniv duplicates

Damon Ding (2):
      dt-bindings: arm: rockchip: Add RK3588S EVB1 board
      arm64: dts: rockchip: Add RK3588S EVB1 board

Daniel Schultz (1):
      arm64: dts: ti: k3-am642-phyboard-electra-rdk: Enable trickle char=
ger

Daniel Semkowicz (1):
      arm64: dts: rockchip: Add power button for puma-haikou

Danila Tikhonov (4):
      arm64: dts: qcom: sc7280: Fix PMU nodes for Cortex A55 and A78
      dt-bindings: arm: cpus: Add qcom kryo670 compatible
      dt-bindings: vendor-prefixes: Add Nothing Technology Limited
      dt-bindings: arm: qcom: Add SM7325 Nothing Phone 1

Daolong Zhu (4):
      arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns

Dara Stotland (2):
      dt-bindings: arm: Tegra234 Industrial Module
      arm64: tegra: Create SKU8 AGX Orin board file

Detlev Casanova (4):
      dt-bindings: arm: rockchip: Add ArmSoM Sige 5
      arm64: dts: rockchip: Add rk3576 SoC base DT
      arm64: dts: rockchip: Add rk3576-armsom-sige5 board
      arm64: dts: rockchip: Remove non-removable flag from sdmmc on rk35=
76-sige5

Dhruva Gole (1):
      arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon

Diederik de Haas (5):
      arm64: dts: rockchip: Drop rockchip prefix of s-p-c PMIC prop from=
 px30
      arm64: dts: rockchip: Drop rockchip prefix of s-p-c PMIC prop from=
 rk3328
      arm64: dts: rockchip: Drop rockchip prefix of s-p-c PMIC prop from=
 rk3368
      arm64: dts: rockchip: Drop rockchip prefix of s-p-c PMIC prop from=
 rk3399
      arm64: dts: rockchip: Drop rockchip prefix of s-p-c PMIC prop from=
 rk356x

Diogo Ivo (2):
      arm64: tegra: Add SDMMC sdr104-offsets for Tegra X1
      arm64: tegra: smaug: Declare cros-ec extcon

Dmitry Baryshkov (15):
      arm64: dts: qcom: qcs6390-rb3gen2: use modem.mbn for modem DSP
      arm64: dts: qcom: sc7280: don't enable GPU on unsupported devices
      arm64: dts: qcom: qcm6490-idp: enable WiFi
      arm64: dts: qcom: qcm6490-rb3gen2: enable WiFi
      arm64: dts: qcom: sdm630: enable GPU SMMU and GPUCC
      arm64: dts: qcom: sda660-ifc6560: enable GPU
      arm64: dts: qcom: sda660-ifc6560: fix l10a voltage ranges
      arm64: dts: qcom: sdm630: enable A2NOC and LPASS SMMU
      arm64: dts: qcom: sdm630: add WiFI device node
      arm64: dts: qcom: sda660-ifc6560: enable mDSP and WiFi devices
      arm64: dts: qcom: msm8998-lenovo-miix-630: enable touchscreen
      arm64: dts: qcom: msm8998-lenovo-miix-630: enable aDSP and SLPI
      arm64: dts: qcom: msm8998-lenovo-miix-630: enable VolumeUp button
      arm64: dts: qcom: msm8998-clamshell: enable resin/VolDown
      arm64: dts: qcom: msm8998-lenovo-miix-630: add WiFi calibration va=
riant

Dmitry Yashin (2):
      dt-bindings: arm: rockchip: add Banana Pi P2 Pro board
      arm64: dts: rockchip: add Banana Pi P2 Pro board

Dragan Simic (7):
      arm64: dts: rockchip: Convert dts files used as parents to dtsi fi=
les
      arm64: dts: rockchip: Add dtsi file for RK3399S SoC variant
      arm64: dts: rockchip: Add OPP voltage ranges to RK3399 OP1 SoC dtsi
      arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
      arm64: dts: rockchip: Prepare RK356x SoC dtsi files for per-varian=
t OPPs
      arm64: dts: rockchip: Add new SoC dtsi for the RK3566T variant
      arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer

Drew Fustini (1):
      riscv: dts: thead: remove enabled property for spi0

Emanuele Ghidoli (1):
      arm64: dts: colibri-imx8x: Add ad7879_ts label to touchscreen cont=
roller

Emil Renner Berthing (8):
      riscv: dts: thead: Add TH1520 pin control nodes
      riscv: dts: thead: Add TH1520 GPIO ranges
      riscv: dts: thead: Adjust TH1520 GPIO labels
      riscv: dts: thead: Add Lichee Pi 4M GPIO line names
      riscv: dts: thead: Add TH1520 pinctrl settings for UART0
      riscv: dtb: thead: Add BeagleV Ahead LEDs
      riscv: dts: thead: Add missing GPIO clock-names
      riscv: dts: thead: Add TH1520 ethernet nodes

Eugene Lepshy (3):
      arm64: dts: qcom: sc7280: Add 0x81 Adreno speed bin
      arm64: dts: qcom: Add SM7325 device tree
      arm64: dts: qcom: sm7325: Add device-tree for Nothing Phone 1

FUKAUMI Naoki (6):
      arm64: dts: rockchip: add LED_FUNCTION_STATUS for RGB LEDs on Radx=
a E25
      arm64: dts: rockchip: add and enable gpu node for Radxa ROCK 5A
      arm64: dts: rockchip: sort rk3588s-rock5a properly in Makefile
      dt-bindings: arm: rockchip: add Radxa ROCK 5C
      arm64: dts: rockchip: add Radxa ROCK 5C
      arm64: dts: rockchip: use less broad pinctrl for pcie3x1 on Radxa =
E25

Fabien Parent (1):
      arm64: dts: mediatek: mt8183-pumpkin: add HDMI support

Fabio Estevam (18):
      ARM: dts: imx28-apx4devkit: Fix the rtc compatible
      dt-bindings: vendor-prefixes: Add an entry for ComVetia AG
      dt-bindings: arm: fsl: Document the Comvetia LXR board
      ARM: dts: imx6q-lxr: Add board support
      ARM: dts: imx6qdl-tx6: Remove 'turn-on-delay-ms'
      ARM: dts: imx6qdl-tx6: Fix 'fixed-clock' description
      ARM: dts: imx6sl/sll: Add the "fsl,imx6dl-gpt" fallback
      ARM: dts: imx6sx: Remove incorrect mmc fallback compatible
      ARM: dts: imx6sl: Remove incorrect mmc fallback compatible
      ARM: dts: imx7ulp: Remove incorrect mmc fallback compatible
      ARM: dts: imx6sll: Fix the last SPDIF clock name
      dt-bindings: soc: imx: fsl,imx-anatop: Fix the i.MX7 irq number
      dt-bindings: soc: imx: fsl,imx-anatop: Add additional regulators
      ARM: dts: imx6sll: Remove regulator-3p0 unit address
      ARM: dts: imx6sx: Fix tempmon description
      ARM: dts: imx6sl: Pass tempmon #thermal-sensor-cells
      dt-bindings: power: fsl,imx-gpc: Document fsl,imx6sll-gpc
      ARM: dts: imx6sll: Improve gpc description

Farouk Bouabid (4):
      arm64: dts: rockchip: add tsd,mule-i2c-mux on rk3588-jaguar
      arm64: dts: rockchip: add tsd,mule-i2c-mux on rk3399-puma
      arm64: dts: rockchip: add tsd,mule-i2c-mux on rk3588-tiger
      arm64: dts: rockchip: add tsd,mule-i2c-mux on px30-ringneck

Fei Shao (21):
      arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
      arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
      arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
      arm64: dts: mediatek: mt8188: Move SPI NOR *-cells properties
      arm64: dts: mediatek: mt8188: Add CPU performance controller for C=
PUFreq
      arm64: dts: mediatek: mt8188: Add SMI/LARB/IOMMU support
      arm64: dts: mediatek: mt8188: Add PWM nodes for display backlight
      arm64: dts: mediatek: mt8188: Add SPMI support for PMIC control
      arm64: dts: mediatek: mt8188: Add audio support
      arm64: dts: mediatek: mt8188: Add socinfo nodes
      arm64: dts: mediatek: mt8188: Assign GCE aliases
      arm64: dts: mediatek: mt8188: Add PCIe nodes
      arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
      arm64: dts: mediatek: mt8188: Add video decoder and encoder nodes
      arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
      arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
      arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
      arm64: dts: mediatek: mt8188: Add DP-INTF nodes
      arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes
      arm64: dts: mediatek: mt8188: Fix USB3 PHY port default status
      arm64: dts: mediatek: mt8195-cherry: Use correct audio codec DAI

Florian Klink (1):
      arm64: dts: rockchip: enable automatic fan control on Orange Pi 5+

Francesco Dolcini (4):
      arm64: dts: ti: k3-am625-verdin: add TPM device
      arm64: dts: ti: k3-am62-verdin: Fix SD regulator startup delay
      arm64: dts: freescale: imx8mm-verdin: Fix SD regulator startup del=
ay
      arm64: dts: freescale: imx8mp-verdin: Fix SD regulator startup del=
ay

Frank Li (22):
      arm64: dts: imx93-11x11-evk: add io-expander adi,adp5585-01
      arm64: dts: imx93-9x9-qsb: add I3C overlay file
      arm64: dts: fsl-lx2160a: add rev2 support
      arm64: dts: imx8mp-evk: add PCIe Endpoint function overlay file
      arm64: dts: layerscape: remove cooling-max-state and cooling-min-s=
tate
      arm64: dts: imx8qxp-mek: Add PCIe support
      arm64: dts: imx8qm-mek: Add PCIe and SATA
      arm64: dts: imx8qxp-mek: add bluetooth audio codec
      arm64: dts: imx8qxp-mek: add esai, cs42888 and related node
      arm64: dts: imx8qxp-mek: enable jpeg encode and decode
      arm64: dts: imx8qxp-mek: add flexcan1 and flexcan2
      arm64: dts: imx8qxp-mek: add usbotg1 and related node
      arm64: dts: imx8qxp-mek: add cm4 and related nodes
      arm64: dts: imx8mm-venice-gw73xx: remove compatible in overlay file
      arm64: dts: mba8mx: remove undocumented 'data-lanes' at panel
      arm64: dts: imx8: move samsung,burst-clock-frequency to imx8mn and=
 imx8mm mba8mx board file
      arm64: dts: imx8mp-kontron-dl: change touchscreen power-supply to =
AVDD28-supply
      arm64: dts: layerscape: remove en25s64 and only keep jedec,spi-nor=
 compatible string
      arm64: dts: imx8mn-tqma8mqnl-mba8mx-usbot: fix coexistence of outp=
ut-low and output-high in GPIO
      arm64: dts: imx8qxp-mek: replace hardcode 0 with IMX_LPCG_CLK_0
      arm64: dts: imx8qm-ss-hsio: fix interrupt-map indent under pci* no=
des
      arm64: dts: imx8qm-ss-hsio: fix PCI and SATA clock indices

Frank Wang (2):
      dt-bindings: soc: rockchip: add rk3576 vo1-grf syscon
      dt-bindings: soc: rockchip: add rk3576 usb2phy syscon

Frieder Schrempf (5):
      dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
      arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carri=
er board
      arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval =
carrier
      arm64: dts: imx8mm-kontron: Add support for display bridges on BL =
i.MX8MM
      arm64: dts: imx8mm-kontron: Add DL (Display-Line) overlay with LVD=
S support

Garrett Giordano (2):
      arm64: dts: ti: am62-phycore-som: Increase cpu frequency to 1.4 GHz
      Revert "arm64: dts: ti: am62-phyboard-lyra: Add overlay to increas=
e cpu frequency to 1.4 GHz"

Gatien Chevallier (1):
      arm64: dts: st: add RNG node on stm32mp251

Geert Uytterhoeven (33):
      arm64: dts: renesas: rcar-gen4: Switch PCIe to reset-gpios
      ARM: dts: renesas: rskrza1: Enable watchdog timer
      arm64: dts: rockchip: Switch to simple-audio-card,hp-det-gpios
      arm64: dts: rockchip: Switch to hp-det-gpios
      arm64: dts: renesas: beacon-renesom: Switch to mic-det-gpios
      ARM: dts: renesas: rcar-gen2: Switch HS-USB to renesas,enable-gpios
      arm64: dts: renesas: r8a779a0: Add E-FUSE node
      arm64: dts: renesas: r8a779f0: Add E-FUSE node
      arm64: dts: renesas: r8a779g0: Add OTP_MEM node
      arm64: dts: renesas: r8a779h0: Add OTP_MEM node
      ARM: dts: renesas: Use interrupts-extended for Ethernet MACs
      ARM: dts: renesas: Use interrupts-extended for Ethernet PHYs
      ARM: dts: renesas: Use interrupts-extended for HDMI bridges
      ARM: dts: renesas: Use interrupts-extended for PMICs
      ARM: dts: renesas: Use interrupts-extended for touchpanels
      ARM: dts: renesas: Use interrupts-extended for video decoders
      ARM: dts: renesas: iwg22d-sodimm: Use interrupts-extended for port=
 expander
      ARM: dts: renesas: r8a7742-iwg21m: Use interrupts-extended for RTC
      ARM: dts: renesas: kzm9g: Use interrupts-extended for I/O expander
      ARM: dts: renesas: kzm9g: Use interrupts-extended for sensors
      arm64: dts: renesas: Use interrupts-extended for DisplayPort bridg=
es
      arm64: dts: renesas: Use interrupts-extended for Ethernet PHYs
      arm64: dts: renesas: Use interrupts-extended for HDMI bridges
      arm64: dts: renesas: Use interrupts-extended for I/O expanders
      arm64: dts: renesas: Use interrupts-extended for PMICs
      arm64: dts: renesas: Use interrupts-extended for USB muxes
      arm64: dts: renesas: Use interrupts-extended for video decoders
      arm64: dts: renesas: Use interrupts-extended for WLAN
      arm64: dts: renesas: beacon-renesom: Use interrupts-extended for t=
ouchscreen
      arm64: dts: renesas: rzg3s-smarc: Use interrupts-extended for gpio=
-keys
      arm64: dts: renesas: white-hawk-cpu-common: Add pin control for DS=
I-eDP IRQ
      Merge tag 'renesas-r9a08g045-dt-binding-defs-tag3' into renesas-dt=
s-for-v6.13
      ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay t=
o 50ms

George Stark (2):
      arm64: dts: meson: a1: add definitions for meson PWM
      arm64: dts: meson: a1: bind power domain to temperature sensor

Gilles Talis (1):
      arm64: dts: imx8mp-navqp: Add HDMI support

Guodong Xu (2):
      riscv: dts: starfive: jh7110-common: revised device node
      riscv: dts: starfive: jh7110-common: move usb0 config to board dts

Haibo Chen (1):
      arm64: dts: imx93-11x11-evk: add flexcan support

Hari Nagalla (5):
      arm64: dts: ti: k3-am62: Add M4F remoteproc node
      arm64: dts: ti: k3-am625-sk: Add M4F remoteproc node
      arm64: dts: ti: k3-am64: Add M4F remoteproc node
      arm64: dts: ti: k3-am642-sk: Add M4F remoteproc node
      arm64: dts: ti: k3-am642-evm: Add M4F remoteproc node

Heiko Stuebner (6):
      arm64: dts: rockchip: fix the pcie refclock oscillator on Rock 5 I=
TX
      arm64: dts: rockchip: add HDMI pinctrl to rk3588-tiger SoM
      arm64: dts: rockchip: add HDMI support to rk3588-tiger-haikou
      arm64: dts: rockchip: add HDMI support to rk3588-jaguar
      arm64: dts: rockchip: Remove 'enable-active-low' from two boards
      dt-bindings: soc: rockchip: add rk3588 mipi dcphy syscon

Hiago De Franco (4):
      arm64: dts: imx8-apalis: Add nau8822 audio-codec to apalis eval v1=
.2
      ARM: dts: imx6qdl-apalis: Update audio card name
      ARM: dts: imx6qdl-colibri: Update audio card name
      ARM: dts: imx7-colibri: Update audio card name

Hsin-Te Yuan (3):
      arm64: dts: mt8183: Add encoder node
      arm64: dts: mt8183: krane: Fix the address of eeprom at i2c4
      arm64: dts: mt8183: kukui: Fix the address of eeprom at i2c4

Icenowy Zheng (3):
      dt-bindings: arm: sunxi: document RerVision A33-Vstar board
      ARM: dts: sunxi: add support for RerVision A33-Vstar board
      arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone

Igor Belwon (6):
      dt-bindings: hwinfo: exynos-chipid: Add compatible for Exynos 990 =
chipid
      soc: samsung: exynos-chipid: Add support for Exynos 990 chipid
      dt-bindings: arm: cpus: Add Samsung Mongoose M5
      dt-bindings: arm: samsung: samsung-boards: Add bindings for Exynos=
 990 boards
      arm64: dts: exynos: Add initial support for the Exynos 990 SoC
      arm64: dts: exynos: Add initial support for Samsung Galaxy Note20 =
5G (c1s)

Inochi Amaoto (4):
      riscv: dts: sophgo: cv1800b: add pinctrl support
      riscv: dts: sophgo: cv1812h: add pinctrl support
      riscv: dts: sophgo: Add sdio configuration for Huashan Pi
      riscv: dts: sophgo: Add emmc support for Huashan Pi

Ivaylo Ivanov (12):
      dt-bindings: arm: cpus: Add Samsung Mongoose M2
      dt-bindings: arm: samsung: Document dreamlte board binding
      dt-bindings: soc: samsung: exynos-pmu: Add exynos8895 compatible
      arm64: dts: exynos: Add initial support for exynos8895 SoC
      arm64: dts: exynos: Add initial support for Samsung Galaxy S8
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos8895 compati=
ble
      soc: samsung: exynos-chipid: add exynos8895 SoC support
      dt-bindings: clock: samsung: Add Exynos8895 SoC
      dt-bindings: timer: exynos4210-mct: Add samsung,exynos8895-mct com=
patible
      arm64: dts: exynos8895: Add clock management unit nodes
      arm64: dts: exynos8895: Add Multi Core Timer (MCT) node
      arm64: dts: exynos8895: Add spi_0/1 nodes

Jacobe Zang (1):
      arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: add attiny_rst_gate to Ringneck

Jared McArthur (1):
      arm64: dts: ti: k3-j7200: Fix register map for main domain pmx

Jasper Korten (2):
      arm64: dts: nvidia: tegra210-smaug: Add touchscreen node
      arm64: dts: nvidia: tegra210-smaug: Add TMP451 temperature sensor =
node

Jianfeng Liu (3):
      dt-bindings: arm: rockchip: Add ArmSoM LM7 SoM
      arm64: dts: rockchip: Add ArmSoM LM7 SoM
      arm64: dts: rockchip: Add ArmSoM W3 board

Jimmy Hon (4):
      arm64: dts: rockchip: Enable HDMI0 on Orange Pi 5
      arm64: dts: rockchip: analog audio on Orange Pi 5
      arm64: dts: rockchip: reorder audio/hdmi nodes in Orange Pi 5
      arm64: dts: rockchip: pwm-leds for Orange Pi 5

Johan Hovold (4):
      arm64: dts: qcom: x1e80100: describe tcsr download mode register
      arm64: dts: qcom: x1e80100: enable GICv3 ITS for PCIe
      arm64: dts: qcom: x1e80100: rename vph-pwr regulator nodes
      arm64: dts: qcom: x1e80100-crd: describe HID supplies

Johan Jonker (4):
      arm64: dts: rockchip: fix compatible string rk3328 cru node
      arm64: rockchip: add clocks property to cru node rk3328
      ARM: dts: rockchip: adapt regulator nodenames to preferred form
      arm64: dts: rockchip: adapt regulator nodenames to preferred form

John Ma (3):
      arm64: dts: ti: k3-am64-phycore-som: Fix bus-width property in MMC=
 nodes
      arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fix bus-width prope=
rty in MMC nodes
      arm64: dts: ti: k3-am62x-phyboard-lyra: Fix indentation in audio-c=
ard

Jonas Karlman (4):
      arm64: dts: rockchip: Enable HDMI0 on FriendlyElec CM3588 NAS
      arm64: dts: rockchip: Enable HDMI on Hardkernel ODROID-M2
      arm64: dts: rockchip: Enable GPU on NanoPi R6C/R6S
      arm64: dts: rockchip: Enable HDMI on NanoPi R6C/R6S

Jonathan Marek (3):
      arm64: dts: qcom: x1e80100: enable OTG on USB-C controllers
      arm64: dts: qcom: x1e80100-crd: enable otg on usb ports
      arm64: dts: qcom: x1e78100-t14s: enable otg on usb-c ports

Jo=C3=A3o Paulo Gon=C3=A7alves (12):
      arm64: dts: imx8-apalis: Add audio support
      arm64: dts: imx8-apalis: Add usb4 host support
      arm64: dts: freescale: imx8mm-verdin: add label to som adc node
      arm64: dts: freescale: imx8mm-verdin: Add Ivy carrier board
      dt-bindings: arm: freescale: Add verdin imx8mm ivy board
      dt-bindings: arm: freescale: Add verdin imx8mp ivy board
      arm64: dts: freescale: imx8mp-verdin: add labels to som nodes
      arm64: dts: freescale: imx8mp-verdin: Add Ivy carrier board
      arm64: dts: ti: k3-am62-verdin: Fix SoM ADC compatible
      dt-bindings: arm: ti: Add verdin am62 ivy board
      arm64: dts: ti: k3-am62-verdin: add label to som adc node
      arm64: dts: ti: k3-am62-verdin: Add Ivy carrier board

Judith Mendez (6):
      arm64: dts: ti: k3-am62-main: Add eQEP nodes
      arm64: dts: ti: k3-am62a-main: Add eQEP nodes
      arm64: dts: ti: k3-am62p-main: Add eQEP nodes
      arm64: dts: ti: k3-am64-main: Add eQEP nodes
      arm64: dts: ti: k3-am64x-sk: Enable eQEP
      arm64: dts: ti: k3-am62-main: Update otap/itap values

J=C3=A9r=C3=B4me de Bretagne (3):
      dt-bindings: arm: qcom: Document Microsoft Surface Pro 9 5G
      arm64: dts: qcom: sc8280xp: Add uart18
      arm64: dts: qcom: sc8280xp: Add Microsoft Surface Pro 9 5G

Karthikeyan Krishnasamy (5):
      dt-bindings: watchdog: rockchip: Add rockchip,rv1126-wdt string
      ARM: dts: rockchip: Add watchdog node for RV1126
      dt-bindings: vendor-prefixes: Add Relfor labs
      dt-bindings: arm: rockchip: Add Relfor Saib board
      ARM: dts: rockchip: Add Relfor Saib board

Kelvin Zhang (1):
      arm64: dts: amlogic: Add Amlogic C3 PWM

Konrad Dybcio (23):
      arm64: dts: qcom: qdu1000: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sc7180: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sc8180x: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sc8280xp: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sdm670: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sm6350: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sm8150: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sm8350: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: sm8450: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: x1e80100: Affirm IDR0.CCTW on apps_smmu
      arm64: dts: qcom: x1e80100-romulus: Add lid switch
      arm64: dts: qcom: x1e80100-romulus: Set up USB Multiport controller
      arm64: dts: qcom: qcs6490-rb3gen2: Enable PWR/VOL keys
      arm64: dts: apple: Add A7 devices
      arm64: dts: apple: Add A8 devices
      arm64: dts: apple: Add A8X devices
      arm64: dts: apple: Add A9 devices
      arm64: dts: apple: Add A9X devices
      arm64: dts: apple: Add A10 devices
      arm64: dts: apple: Add A10X devices
      arm64: dts: apple: Add A11 devices
      arm64: dts: qcom: x1e80100: Update C4/C5 residency/exit numbers

Krishna chaitanya chundru (1):
      arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes

Kry=C5=A1tof =C4=8Cern=C3=BD (1):
      arm64: dts: allwinner: Add disable-wp for boards with micro SD card

Krzysztof Kozlowski (26):
      ARM: dts: qcom: drop underscore in node names
      ARM: dts: qcom: minor whitespace cleanup
      arm64: dts: qcom: drop underscore in node names
      arm64: dts: qcom: minor whitespace cleanup
      Merge branch 'for-v6.13/clk-dt-bindings' into next/dt64
      arm64: dts: freescale: minor whitespace cleanup
      arm64: dts: qcom: ipq: change labels to lower-case
      arm64: dts: qcom: msm: change labels to lower-case
      arm64: dts: qcom: msm8992-libra: drop unused regulators labels
      arm64: dts: qcom: sc7180: change labels to lower-case
      arm64: dts: qcom: sc8280xp: change labels to lower-case
      ARM: dts: qcom: change labels to lower-case
      arm64: dts: qcom: sc: change labels to lower-case
      arm64: dts: qcom: sm6115: change labels to lower-case
      arm64: dts: qcom: sm6350: change labels to lower-case
      arm64: dts: qcom: sm8150: change labels to lower-case
      arm64: dts: qcom: sm8250: change labels to lower-case
      arm64: dts: qcom: sm8350: change labels to lower-case
      arm64: dts: qcom: sm8450: change labels to lower-case
      arm64: dts: qcom: sm8550: change labels to lower-case
      arm64: dts: qcom: sm8650: change labels to lower-case
      arm64: dts: qcom: sm: change labels to lower-case
      arm64: dts: qcom: sdm: change labels to lower-case
      arm64: dts: qcom: change labels to lower-case
      Merge branch 'for-v6.13/clk-dt-bindings' into next/dt64
      arm64: dts: ti: minor whitespace cleanup

Kuldeep Singh (2):
      arm64: dts: seattle: Update spi clock properties
      arm64: dts: lg131x: Update spi clock properties

Lad Prabhakar (2):
      arm64: dts: renesas: r9a09g057: Add OPP table
      arm64: dts: renesas: hihope: Drop #sound-dai-cells

Laurentiu Mihalcea (6):
      dt-bindings: dsp: fsl,dsp: fix power domain count
      arm64: dts: imx8-ss-audio: configure dsp node for rproc usage
      arm64: dts: imx8qxp-mek: add dsp rproc-related mem regions
      arm64: dts: imx8qm: drop dsp node from audio_subsys bus
      arm64: dts: imx8qm: add node for VPU dsp
      arm64: dts: imx8qm-mek: enable dsp node for rproc usage

Linus Walleij (2):
      ARM: dts: ux500: Add touchkeys to Codinas
      ARM: dts: Reconfigure the MC2 eMMC interface

Luca Weiss (2):
      arm64: dts: qcom: sm6350: Fix GPU frequencies missing on some spee=
dbins
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add thermistor for UFS/RAM

MD Danish Anwar (4):
      arm64: dts: ti: k3-am65-main: Add ti,pruss-pa-st node
      arm64: dts: ti: k3-am654-icssg2: Add ti,pa-stats property
      arm64: dts: ti: k3-am64-main: Add ti,pruss-pa-st node
      arm64: dts: ti: k3-am64: Add ti,pa-stats property

Macpaul Lin (7):
      arm64: dts: mediatek: mt8395-genio-1200-evk: Fix dtbs_check error =
for phy
      arm64: dts: mt8195: Fix dtbs_check error for mutex node
      arm64: dts: mt8195: Fix dtbs_check error for infracfg_ao node
      arm64: dts: mediatek: mt8390-genio-700-evk: enable pcie
      arm64: dts: mediatek: mt8390-genio-700-evk: update regulator names
      arm64: dts: mediatek: mt8390-genio-700-evk: add keys and USB HUB
      arm64: dts: mediatek: mt6358: fix dtbs_check error

Manish Pandey (1):
      arm64: dts: qcom: qcm6490-idp: Add UFS nodes

Manivannan Sadhasivam (5):
      ARM: dts: qcom: sdx55: Add 'linux,pci-domain' to PCIe EP controlle=
r node
      ARM: dts: qcom: sdx65: Add 'linux,pci-domain' to PCIe EP controlle=
r node
      arm64: dts: qcom: sa8775p: Add 'linux,pci-domain' to PCIe EP contr=
oller nodes
      arm64: dts: qcom: sm8450: Add 'global' interrupt to the PCIe RC no=
de
      arm64: dts: qcom: Use 'ufshc' as the node name for UFS controller =
nodes

Manorit Chawdhry (17):
      arm64: dts: ti: Refactor J784s4 SoC files to a common file
      arm64: dts: ti: Refactor J784s4-evm to a common file
      dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
      arm64: dts: ti: Introduce J742S2 SoC family
      arm64: dts: ti: Add support for J742S2 EVM board
      arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Move bootph from mcu_=
timer1 to mcu_timer0
      arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Remove parent nodes b=
ootph-*
      arm64: dts: ti: k3-j784s4: Add bootph-* properties
      arm64: dts: ti: k3-j721s2: Add bootph-* properties
      arm64: dts: ti: k3-j721e: Add bootph-* properties
      arm64: dts: ti: k3-j7200: Add bootph-* properties
      arm64: dts: ti: k3-j784s4-j742s2-evm-common: Remove parent nodes b=
ootph-*
      arm64: dts: ti: k3-j721s2-evm*: Add bootph-* properties
      arm64: dts: ti: k3-am68-sk*: Add bootph-* properties
      arm64: dts: ti: k3-j721e-evm*: Add bootph-* properties
      arm64: dts: ti: k3-j721e-sk*: Add bootph-* properties
      arm64: dts: ti: k3-j7200-evm*: Add bootph-* properties

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: add HDMI GPIOs

Marcin Juszkiewicz (1):
      arm64: dts: rockchip: Enable HDMI0 on rk3588-nanopc-t6

Marcus Folkesson (1):
      ARM: dts: ti: dra7: Remove double include of clock bindings

Marek Beh=C3=BAn (1):
      ARM: dts: turris-omnia: Add global LED brightness change interrupt

Marek Vasut (23):
      dt-bindings: arm: fsl: Document DH i.MX8MP DHCOM SoM on DRC02 carr=
ier board
      arm64: dts: imx8mp: Add DH i.MX8MP DHCOM SoM on DRC02 carrier board
      dt-bindings: arm: fsl: Document DH electronics i.MX8M Plus DHCOM P=
icoITX
      arm64: dts: imx8mp: Add support for DH electronics i.MX8M Plus DHC=
OM PicoITX
      ARM: dts: imx6qdl-dhcom: Fix model typo for i.MX6 DHSOM
      ARM: dts: imx6qdl-dhcom-som: Drop bogus regulator-suspend-mem-micr=
ovolt
      ARM: dts: imx6qdl-dhcom-pdk2: Drop incorrect size-cells in GPIO ke=
ys
      ARM: dts: imx6qdl-dhcom-pdk2: Fill in missing panel power-supply
      dt-bindings: arm: fsl: Document i.MX6DL DHCOM SoM on PDK2 carrier =
board
      ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM on PDK2 carrie=
r board
      ARM: dts: stm32: Add IWDG2 EXTI interrupt mapping and mark as wake=
up source
      ARM: dts: stm32: Describe M24256E write-lockable page in DH STM32M=
P13xx DHCOR SoM DT
      ARM: dts: imx35: Align pin config nodes with bindings
      ARM: dts: imx50: Align pin config nodes with bindings
      ARM: dts: imx51: Align pin config nodes with bindings
      ARM: dts: imx53: Align pin config nodes with bindings
      ARM: dts: imx6dl: Align pin config nodes with bindings
      ARM: dts: imx6q: Align pin config nodes with bindings
      ARM: dts: imx6qdl: Align pin config nodes with bindings
      ARM: dts: imx6qp: Align pin config nodes with bindings
      ARM: dts: imx6sl: imx6sll: Align pin config nodes with bindings
      ARM: dts: imx6sx: Align pin config nodes with bindings
      ARM: dts: imx6ul: Drop duplicate space in iomux node groups

Markuss Broks (5):
      dt-bindings: hwinfo: samsung,exynos-chipid: Add Samsung exynos9810=
 compatible
      soc: samsung: exynos-chipid: Add support for Exynos9810 SoC
      dt-bindings: arm: cpus: Add Samsung Mongoose M3
      dt-bindings: soc: samsung: exynos-pmu: Add exynos9810 compatible
      dt-bindings: arm: samsung: Document Exynos9810 and starlte board b=
inding

Maya Matuszczyk (1):
      arm64: dts: qcom: x1e80100: Add debug uart to Lenovo Yoga Slim 7x

Miaoqing Pan (1):
      arm64: dts: qcom: sa8775p-ride: add WiFi/BT nodes

Michal Vok=C3=A1=C4=8D (2):
      dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
      arm64: dts: imx: Add imx8mp-iota2-lumpy board

Mihai Sain (4):
      ARM: dts: microchip: sam9x60ek: Add power monitor support
      ARM: dts: microchip: sama5d2_icp: Add power monitor support
      ARM: dts: microchip: sama7g54_curiosity: Add power monitor support
      ARM: dts: microchip: sama7g5ek: Add power monitor support

Mukesh Ojha (1):
      arm64: dts: qcom: sa8775p: Add TCSR halt register space

Nathan Morrisson (2):
      arm64: dts: ti: k3-am62x-phyboard-lyra: Drop unnecessary McASP AFI=
FOs
      arm64: dts: ti: k3-am62a7-phyboard-lyra-rdk: Update ethernet inter=
nal delay

Neil Armstrong (12):
      ARM: dts: amlogic: meson6: fix clk81 node name
      ARM: dts: amlogic: meson8: fix soc thermal-zone node name
      ARM: dts: amlogic: meson8: fix ao_arc_sram node name
      ARM: dts: amlogic: meson6: remove support for ATV1200 board
      ARM: dts: amlogic: meson8b-odroidc1: fix invalid reset-gpio
      ARM: dts: amlogic: fix /memory node name
      ARM: dts: amlogic: meson8: use correct pinctrl bank node name
      ARM: dts: amlogic: add missing phy-mode in ethmac node
      ARM: dts: amlogic: meson8-minix-neo-x8: fix invalid pnictrl-names
      ARM: dts: amlogic: meson8b-ec100: add missing clocks property in s=
ound card
      ARM: dts: amlogic: meson8b-ec100: add missing gpio-line-names entry
      ARM: dts: amlogic: meson8/8b: remove invalid pinctrl reg

Nick Chan (12):
      dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
      dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
      dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
      dt-bindings: arm: apple: Add A7 devices
      dt-bindings: arm: apple: Add A8 devices
      dt-bindings: arm: apple: Add A8X devices
      dt-bindings: arm: apple: Add A9 devices
      dt-bindings: arm: apple: Add A9X devices
      dt-bindings: arm: apple: Add A10 devices
      dt-bindings: arm: apple: Add A10X devices
      dt-bindings: arm: apple: Add A11 devices
      arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE

N=C3=ADcolas F. R. A. Prado (2):
      arm64: dts: mediatek: mt8188: Add ethernet node
      arm64: dts: mediatek: mt8390-genio-700-evk: Enable ethernet

Pablo Sun (3):
      arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 pow=
er domain
      arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU
      arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU

Peng Fan (7):
      arm64: dts: imx95: set max-rx-timeout-ms
      arm64: dts: imx95: add bbm/misc/syspower scmi nodes
      arm64: dts: imx95: update a55 thermal trip points
      arm64: dts: imx95: add anamix temperature thermal zone and cooling=
 node
      arm64: dts: imx95: enable A55 cpuidle
      arm64: dts: imx95-19x19-evk: add nxp,ctrl-ids property
      arm64: dts: imx95-19x19-evk: add lpi2c[5,6] and sub-nodes

Pin-yen Lin (2):
      arm64: dts: mt8192-asurada-spherion: Add Synaptics trackpad support
      arm64: dts: mt8183: Add port node to dpi node

Rafa=C5=82 Mi=C5=82ecki (2):
      arm64: dts: mediatek: mt7988: add UART controllers
      arm64: dts: mediatek: mt7988: add efuse block

Richard Zhu (5):
      arm64: dts: imx8mq: Add dbi2 and atu reg for i.MX8MQ PCIe EP
      arm64: dts: imx8mp: Add dbi2 and atu reg for i.MX8MP PCIe EP
      arm64: dts: imx8mm: Add dbi2 and atu reg for i.MX8MM PCIe EP
      arm64: dts: imx8-ss-hsio: Add PCIe and SATA support
      arm64: dts: imx8dxl-evk: Add PCIe support

Rick Wertenbroek (1):
      arm64: dts: rockchip: enable USB3 on NanoPC-T6

Rob Herring (Arm) (8):
      ARM: dts: socfpga: Fix at24 EEPROM node names
      ARM: dts: ti/omap: Fix at24 EEPROM node names
      arm64: dts: qcom: Drop undocumented domain "idle-state-name"
      ARM: dts: marvell: kirkwood: Fix at24 EEPROM node name
      arm64: dts: marvell: Drop undocumented SATA phy names
      arm64: dts: amd: Remove unused and undocumented "amd,zlib-support"=
 property
      arm: dts: spear13xx: Remove unused and undocumented "pl022,slave-t=
x-disable" property
      arm64: dts: apm: Remove unused and undocumented "bus_num" property

Roger Quadros (3):
      ARM: dts: ti: drop linux,mtd-name from NAND nodes
      ARM: dts: ti: omap: am335x-baltos: drop "gpmc,device-nand" from NA=
ND node
      ARM: dts: ti: omap3434-sdp: drop linux,mtd-name from onenand node

Rosen Penev (1):
      ARM: dts: qcom: ipq4019: use nvmem-layout

Ryan Walklin (2):
      arm64: dts: allwinner: h616: Add audio codec node
      arm64: dts: allwinner: h313/h616/h618/h700: Enable audio codec for=
 all supported boards

Sachin Gupta (1):
      arm64: dts: qcom: qcs6490-rb3gen2: Add SD Card node

Sam Edwards (5):
      arm64: dts: rockchip: Split up RK3588's PCIe pinctrls
      arm64: dts: rockchip: Fix Turing RK1 PCIe3 hang
      arm64: dts: rockchip: Enable automatic fan control on Turing RK1
      arm64: dts: rockchip: Enable GPU on Turing RK1
      arm64: dts: rockchip: Enable all 3 USBs on Turing RK1

Sandie Cao (3):
      dt-bindings: vendor: add deepcomputing
      dt-bindings: riscv: starfive: add deepcomputing,fml13v01
      riscv: dts: starfive: add DeepComputing FML13V01 board device tree

Sean Anderson (8):
      arm64: zynqmp: Enable AMS for all boards
      arm64: zynqmp: Expose AMS to userspace as HWMON
      arm64: zynqmp: Add thermal zones
      arm64: dts: renesas: salvator-xs: Add SD/OE pin properties
      arm64: dts: renesas: ulcb: Add SD/OE pin properties
      arm64: dts: renesas: salvator-x: Add SD/OE pin properties
      arm64: dts: renesas: hihope: Add SD/OE pin properties
      arm64: dts: renesas: beacon: Add SD/OE pin properties

Sean Nyekjaer (2):
      ARM: dts: nxp: imx6ul: add dma support for all uarts
      ARM: dts: nxp: imx6ull: add dma support for uart8

Shengjiu Wang (6):
      arm64: dts: imx93-9x9-qsb: Enable sound-wm8962 sound card
      arm64: dts: imx93-9x9-qsb: add bt-sco sound card support
      arm64: dts: imx93-9x9-qsb: Add PDM microphone sound card support
      arm64: dts: imx8ulp: Add audio device nodes
      arm64: dts: imx8ulp-evk: Add bt-sco sound card support
      arm64: dts: imx8ulp-evk: Add spdif sound card support

Shoji Keita (1):
      arm64: dts: sun50i-a64-pinephone: Add mount-matrix for PinePhone m=
agnetometers

Sibi Sankar (1):
      arm64: dts: qcom: x1e80100: Resize GIC Redistributor register regi=
on

Siddharth Vadapalli (2):
      arm64: dts: ti: k3-j7200-evm: Add overlay for PCIE1 Endpoint Mode
      arm64: dts: ti: k3-am642-evm: Add overlay for PCIe0 EP mode

Srinivas Kandagatla (1):
      arm64: dts: qcom: x1e80100-t14s: add another trackpad support

Stefan Eichenberger (2):
      arm64: dts: imx8mm-verdin: add single-master property to all i2c n=
odes
      arm64: dts: imx8mp-verdin: add single-master property to all i2c n=
odes

Sunyeal Hong (2):
      dt-bindings: clock: exynosautov920: add peric1, misc and hsi0/1 cl=
ock definitions
      arm64: dts: exynosautov920: add peric1, misc and hsi0/1 clock DT n=
odes

Taniya Das (3):
      dt-bindings: clock: qcom: Add SA8775P video clock controller
      dt-bindings: clock: qcom: Add SA8775P camera clock controller
      dt-bindings: clock: qcom: Add SA8775P display clock controllers

Tarang Raval (1):
      arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support

Tengfei Fan (2):
      dt-bindings: arm: qcom: Document qcs9100-ride and qcs9100-ride Rev3
      arm64: dts: qcom: qcs9100: Add support for the QCS9100 Ride and Ri=
de Rev3 boards

Theo Debrouwere (1):
      arm64: dts: meson-g12-common: fix uart-ao-a typo

Thomas Bonnefille (4):
      riscv: dts: sophgo: Add initial SG2002 SoC device tree
      riscv: dts: sophgo: Add LicheeRV Nano board device tree
      riscv: dts: sophgo: Add SARADC description for Sophgo CV1800B
      riscv: dts: sophgo: fix pinctrl base-address

Tianling Shen (7):
      dt-bindings: arm: rockchip: Add FriendlyARM NanoPi R3S
      arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
      arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
      arm64: dts: rockchip: replace deprecated snps,reset props for Nano=
Pi R3S
      arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi=
 R3S
      arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
      arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S

Tim Harvey (5):
      arm64: dts: imx8mp-venice-gw74xx: add M2SKT_GPIO10 gpio configurat=
ion
      arm64: dts: imx8mm-venice-*: add RTC aliases
      arm64: dts: imx8m*-venice-gw75xx: add Accelerometer device
      dt-bindings: arm: fsl: Add Gateworks GW82XX-2x dev kit
      arm64: dts: imx: Add i.MX8M Plus Gateworks GW82XX-2X support

Tomasz Maciej Nowak (1):
      arm64: tegra: p2180: Add mandatory compatible for WiFi node

Valentin Caron (6):
      ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp15
      ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp13
      ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp157c-dk2
      ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp135f-dk
      arm64: dts: st: add RTC on stm32mp25x
      arm64: dts: st: enable RTC on stm32mp257f-ev1 board

Varshini Rajendran (4):
      dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x7 compatible
      ARM: dts: at91: sam9x7: add device tree for SoC
      dt-bindings: arm: add sam9x75 curiosity board
      ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board

Vedang Nagar (1):
      arm64: dts: qcom: qcs6460-rb3gen2: enable venus node

Viken Dadhaniya (2):
      arm64: dts: qcom: sa8775p: Populate additional UART DT nodes
      arm64: dts: qcom: sa8775p: Add GPI configuration

Vladimir Zapolskiy (9):
      arm64: dts: qcom: sm8350-hdk: remove a blank overwrite of dispcc n=
ode status
      arm64: dts: qcom: sm8450-qrd: explicitly disable dispcc on the boa=
rd
      arm64: dts: qcom: sm8450-sony-xperia-nagara: disable dispcc on der=
ived boards
      arm64: dts: qcom: sm8450: don't disable dispcc by default
      arm64: dts: qcom: sm8450-hdk: remove status property from dispcc d=
evice tree node
      arm64: dts: qcom: sm8650: don't disable dispcc by default
      arm64: dts: qcom: sm8650-hdk: remove status property from dispcc d=
evice tree node
      arm64: dts: qcom: sm8650-mtp: remove status property from dispcc d=
evice tree node
      arm64: dts: qcom: sm8650-qrd: remove status property from dispcc d=
evice tree node

Wadim Egorov (2):
      arm64: dts: ti: k3-am62-phycore-som: Add M4F remoteproc nodes
      arm64: dts: ti: k3-am64-phycore-som: Add M4F remoteproc nodes

WangYuli (1):
      arm64: dts: colibri-imx8x: Fix typo "rewritting"

Wolfram Sang (18):
      ARM: dts: renesas: genmai: Fix partition size for QSPI NOR Flash
      ARM: dts: renesas: genmai: Enable watchdog
      ARM: dts: renesas: genmai: Enable OS timer modules
      ARM: dts: renesas: genmai: Sort nodes
      ARM: dts: renesas: genmai: Define keyboard switch
      ARM: dts: renesas: Genmai: Update audio codec device node
      ARM: dts: renesas: Remove 'reg-io-width' properties from MMCIF nod=
es
      ARM: dts: renesas: marzen: Use interrupts-extended for gpio-keys
      ARM: dts: renesas: rskrza1: Use interrupts-extended for gpio-keys
      ARM: dts: renesas: rza2mevb: Use interrupts-extended for gpio-keys
      ARM: dts: renesas: Add proper node names to (L)BSC devices
      ARM: dts: renesas: r8a7778: Rename 'bsc' to 'lbsc'
      ARM: dts: renesas: Use proper node names for keys
      ARM: dts: renesas: r7s72100: 'bus-width' is a board property
      ARM: dts: renesas: genmai: Enable SDHI0
      ARM: dts: renesas: genmai: Enable MMCIF
      ARM: dts: renesas: r7s72100: Add DMAC node
      ARM: dts: renesas: r7s72100: Add DMA support to MMCIF

Xu Yang (5):
      ARM: dts: imx7ulp: add "nxp,sim" property for usbphy1
      arm64: dts: imx8dxl-ss-conn: change usbphy1 compatible
      arm64: dts: imx8qm: change usbphy1 compatible
      arm64: dts: imx8qxp: change usbphy1 compatible
      ARM: dts: imx6qdl: convert fsl,tx-d-cal to correct value

Yangtao Li (5):
      arm64: dts: allwinner: A100: Add PMU mode
      arm64: dts: allwinner: a100: add watchdog node
      arm64: dts: allwinner: a100: add usb related nodes
      arm64: allwinner: a100: Add MMC related nodes
      arm64: dts: allwinner: a100: perf1: Add eMMC and MMC node

Yangyu Chen (1):
      dt-bindings: vendor-prefixes: add spacemit

Yannic Moog (1):
      arm64: dts: imx8mp-phyboard-pollux-rdk: add gpio-fan

Yao Zi (3):
      dt-bindings: arm: rockchip: Add Radxa E20C board
      arm64: dts: rockchip: Add base DT for rk3528 SoC
      arm64: dts: rockchip: Add Radxa e20c board

Yoshihiro Shimoda (2):
      arm64: dts: renesas: r8a779h0: Add PCIe Host and Endpoint nodes
      arm64: dts: renesas: r8a779h0: gray-hawk-single: Enable PCIe Host

Yuvaraj Ranganathan (1):
      arm64: dts: qcom: sa8775p: add QCrypto nodes

max_weng (1):
      arm64: dts: mediatek: mt8186: add FHCTL node

 Documentation/devicetree/bindings/arm/apple.yaml   |  160 +-
 .../devicetree/bindings/arm/atmel-at91.yaml        |    6 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |   12 +-
 Documentation/devicetree/bindings/arm/fsl.yaml     |   45 +-
 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |   28 +
 Documentation/devicetree/bindings/arm/qcom.yaml    |   16 +
 .../devicetree/bindings/arm/rockchip.yaml          |   47 +-
 .../bindings/arm/samsung/samsung-boards.yaml       |   18 +
 Documentation/devicetree/bindings/arm/sunxi.yaml   |    6 +
 Documentation/devicetree/bindings/arm/tegra.yaml   |    5 +
 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    8 +
 .../bindings/clock/qcom,sa8775p-camcc.yaml         |   62 +
 .../bindings/clock/qcom,sa8775p-dispcc.yaml        |   79 +
 .../bindings/clock/qcom,sa8775p-videocc.yaml       |   62 +
 .../bindings/clock/renesas,r9a08g045-vbattb.yaml   |   84 +
 .../bindings/clock/samsung,exynos8895-clock.yaml   |  239 +
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml |   31 +-
 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |    3 +
 .../devicetree/bindings/mailbox/arm,mhuv2.yaml     |    2 +-
 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml |   10 +-
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    5 +
 .../devicetree/bindings/power/fsl,imx-gpc.yaml     |    1 +
 .../devicetree/bindings/riscv/starfive.yaml        |    1 +
 .../bindings/soc/imx/fsl,imx-anatop.yaml           |   20 +-
 .../soc/microchip/atmel,at91rm9200-tcb.yaml        |   20 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml      |    5 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |    2 +
 .../bindings/timer/samsung,exynos4210-mct.yaml     |    2 +
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     |    1 +
 .../devicetree/bindings/usb/generic-ehci.yaml      |    1 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   10 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    5 +
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  |    1 +
 arch/arm/boot/dts/allwinner/Makefile               |    5 +-
 .../boot/dts/allwinner/sun8i-a33-vstar-core1.dtsi  |   96 +
 arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dts    |  205 +
 .../boot/dts/allwinner/sun9i-a80-cubieboard4.dts   |    4 +-
 arch/arm/boot/dts/amlogic/Makefile                 |    2 -
 arch/arm/boot/dts/amlogic/meson6-atv1200.dts       |   33 -
 arch/arm/boot/dts/amlogic/meson6.dtsi              |   73 -
 arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts  |    5 +-
 arch/arm/boot/dts/amlogic/meson8.dtsi              |   32 +-
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts        |    8 +-
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts          |    2 +-
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts     |    4 +-
 arch/arm/boot/dts/amlogic/meson8b.dtsi             |   32 +-
 arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts  |    2 +-
 .../intel/socfpga/socfpga_cyclone5_vining_fpga.dts |    4 +-
 .../boot/dts/marvell/armada-385-turris-omnia.dts   |    1 +
 .../boot/dts/marvell/kirkwood-openblocks_a7.dts    |    2 +-
 arch/arm/boot/dts/microchip/Makefile               |    3 +
 arch/arm/boot/dts/microchip/aks-cdu.dts            |   12 +-
 arch/arm/boot/dts/microchip/animeo_ip.dts          |    8 +-
 .../boot/dts/microchip/at91-kizbox2-common.dtsi    |    2 +-
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts     |   37 +-
 .../boot/dts/microchip/at91-sam9x75_curiosity.dts  |  324 ++
 .../arm/boot/dts/microchip/at91-sama5d27_som1.dtsi |    2 +-
 .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   |    2 +-
 .../boot/dts/microchip/at91-sama5d29_curiosity.dts |    2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts   |   33 +-
 .../arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts |    2 +-
 .../boot/dts/microchip/at91-sama5d2_xplained.dts   |    2 +-
 .../boot/dts/microchip/at91-sama5d3_xplained.dts   |    2 +-
 .../boot/dts/microchip/at91-sama7g54_curiosity.dts |   31 +
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts     |   33 +-
 arch/arm/boot/dts/microchip/at91rm9200ek.dts       |    6 +-
 arch/arm/boot/dts/microchip/at91sam9260ek.dts      |    6 +-
 arch/arm/boot/dts/microchip/at91sam9261ek.dts      |    6 +-
 arch/arm/boot/dts/microchip/at91sam9263ek.dts      |    6 +-
 arch/arm/boot/dts/microchip/at91sam9g20ek.dts      |    4 +-
 .../boot/dts/microchip/at91sam9g20ek_common.dtsi   |    2 +-
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi       |    2 +-
 arch/arm/boot/dts/microchip/sam9x60.dtsi           |   14 +-
 arch/arm/boot/dts/microchip/sam9x7.dtsi            | 1220 +++++
 arch/arm/boot/dts/microchip/sama5d2.dtsi           |    2 +-
 arch/arm/boot/dts/microchip/sama5d3.dtsi           |    2 +-
 arch/arm/boot/dts/microchip/sama5d34ek.dts         |    2 +-
 arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi    |    2 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi           |    2 +-
 arch/arm/boot/dts/nxp/imx/Makefile                 |    4 +
 .../boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi    |   62 +-
 .../nxp/imx/imx35-eukrea-mbimxsd35-baseboard.dts   |   88 +-
 arch/arm/boot/dts/nxp/imx/imx35-pdk.dts            |   38 +-
 arch/arm/boot/dts/nxp/imx/imx35.dtsi               |    2 +-
 arch/arm/boot/dts/nxp/imx/imx50-evk.dts            |   62 +-
 arch/arm/boot/dts/nxp/imx/imx50.dtsi               |    2 +-
 arch/arm/boot/dts/nxp/imx/imx51-apf51.dts          |   56 +-
 arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts       |  176 +-
 arch/arm/boot/dts/nxp/imx/imx51-babbage.dts        |  438 +-
 .../dts/nxp/imx/imx51-digi-connectcore-jsk.dts     |   78 +-
 .../dts/nxp/imx/imx51-digi-connectcore-som.dtsi    |  292 +-
 .../boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi    |   68 +-
 .../nxp/imx/imx51-eukrea-mbimxsd51-baseboard.dts   |  192 +-
 arch/arm/boot/dts/nxp/imx/imx51.dtsi               |    2 +-
 arch/arm/boot/dts/nxp/imx/imx53-ard.dts            |  116 +-
 arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts         |   62 +-
 arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi            |   90 +-
 arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi           |   64 +-
 arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts         |  268 +-
 arch/arm/boot/dts/nxp/imx/imx53-m53menlo.dts       |  320 +-
 arch/arm/boot/dts/nxp/imx/imx53-mba53.dts          |  114 +-
 arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi    |  274 +-
 arch/arm/boot/dts/nxp/imx/imx53-qsrb.dts           |   10 +-
 arch/arm/boot/dts/nxp/imx/imx53-smd.dts            |  242 +-
 arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi        |  274 +-
 arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts      |  112 +-
 arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts      |   62 +-
 arch/arm/boot/dts/nxp/imx/imx53-tx53.dtsi          |  460 +-
 arch/arm/boot/dts/nxp/imx/imx53-voipac-bsb.dts     |  110 +-
 .../arm/boot/dts/nxp/imx/imx53-voipac-dmm-668.dtsi |  124 +-
 arch/arm/boot/dts/nxp/imx/imx53.dtsi               |    2 +-
 .../boot/dts/nxp/imx/imx6-logicpd-baseboard.dtsi   |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-aster.dts |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-dhcom-pdk2.dts    |   20 +
 arch/arm/boot/dts/nxp/imx/imx6dl-dhcom-picoitx.dts |    2 +-
 .../boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts   |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-mamoj.dts         |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts        |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-prtrvt.dts        |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts        |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi         |  446 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts     |  360 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tx6dl-comtft.dts  |    1 -
 arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi |    4 +-
 .../arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6q-arm2.dts           |  198 +-
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi          |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dhcom-pdk2.dts     |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts    |  232 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gk802.dts          |   92 +-
 arch/arm/boot/dts/nxp/imx/imx6q-h100.dts           |  200 +-
 arch/arm/boot/dts/nxp/imx/imx6q-logicpd.dts        |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6q-lxr.dts            |   87 +
 arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi          |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts         |   48 +-
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts         |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts         |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6q-sbc6x.dts          |   82 +-
 .../boot/dts/nxp/imx/imx6q-tx6q-1010-comtft.dts    |    1 -
 .../boot/dts/nxp/imx/imx6q-tx6q-1020-comtft.dts    |    1 -
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts    |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi      |    2 +-
 .../arm/boot/dts/nxp/imx/imx6qdl-aristainetos.dtsi |  428 +-
 .../boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi    |    6 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi     |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi     |  136 +-
 .../boot/dts/nxp/imx/imx6qdl-dfi-fs700-m60.dtsi    |  192 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-pdk2.dtsi  |   21 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-dhcom-som.dtsi   |    2 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-ds.dtsi          |    6 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi       |   39 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi      |    4 +-
 .../arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi |  160 +-
 .../dts/nxp/imx/imx6qdl-hummingboard2-emmc.dtsi    |   30 +-
 .../boot/dts/nxp/imx/imx6qdl-hummingboard2.dtsi    |  456 +-
 .../boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi        |   14 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi   |  354 +-
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi    |  506 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi  |  406 +-
 .../nxp/imx/imx6qdl-phytec-mira-peb-wlbt-05.dtsi   |    4 +-
 .../boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi    |  292 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi         |  274 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi   |  554 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi   |  428 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi     |  430 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-solidsense.dtsi  |   78 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-brcm.dtsi |   86 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-emmc.dtsi |   30 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-ti.dtsi   |   88 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som.dtsi      |   96 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi      |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi     |    1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi     |    2 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi         |    3 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-udoo.dtsi        |  224 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi    |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi     |    4 +-
 .../boot/dts/nxp/imx/imx6qdl-wandboard-revb1.dtsi  |   30 +-
 .../boot/dts/nxp/imx/imx6qdl-wandboard-revc1.dtsi  |   32 +-
 .../boot/dts/nxp/imx/imx6qdl-wandboard-revd1.dtsi  |   78 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard.dtsi   |  247 +-
 arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dts        |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts     |   40 +-
 arch/arm/boot/dts/nxp/imx/imx6qp-sabresd.dts       |   58 +-
 arch/arm/boot/dts/nxp/imx/imx6s-dhcom-drc02.dts    |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6sl-evk.dts           |  480 +-
 .../boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts    |   16 +-
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine3.dts |   16 +-
 .../arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts          |  208 +-
 arch/arm/boot/dts/nxp/imx/imx6sl.dtsi              |   11 +-
 arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts          |   12 +-
 .../boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |   23 +
 .../boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |   23 +
 .../dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi   |  511 ++
 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd.dts |   16 +-
 .../arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6sll.dtsi             |   24 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sabreauto.dts     |    4 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi          |  572 +-
 .../dts/nxp/imx/imx6sx-softing-vining-2000.dts     |   18 +-
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi              |   11 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi        |    2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi              |   16 +
 arch/arm/boot/dts/nxp/imx/imx6ull.dtsi             |    2 +
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi        |    2 +-
 arch/arm/boot/dts/nxp/imx/imx7ulp.dtsi             |    5 +-
 arch/arm/boot/dts/nxp/mxs/imx28-apx4devkit.dts     |    2 +-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           |   38 +-
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi           |   78 +-
 arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi |   19 +-
 arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts   |    2 +-
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi           |   10 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi           |    8 +-
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi           |    4 +-
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi           |   34 +-
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi           |    6 +-
 arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi       |    2 +-
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi           |    6 +-
 .../qcom/qcom-msm8974-lge-nexus5-hammerhead.dts    |    2 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |   92 +-
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |    1 +
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |   67 +-
 arch/arm/boot/dts/renesas/emev2-kzm9d.dts          |   11 +-
 arch/arm/boot/dts/renesas/iwg20d-q7-common.dtsi    |    3 +-
 arch/arm/boot/dts/renesas/iwg20d-q7-dbcm-ca.dtsi   |    3 +-
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts      |  199 +-
 arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts     |   14 +-
 arch/arm/boot/dts/renesas/r7s72100.dtsi            |   37 +-
 arch/arm/boot/dts/renesas/r7s9210-rza2mevb.dts     |    3 +-
 arch/arm/boot/dts/renesas/r8a73a4-ape6evm.dts      |    3 +-
 arch/arm/boot/dts/renesas/r8a73a4.dtsi             |    2 -
 .../boot/dts/renesas/r8a7740-armadillo800eva.dts   |    3 +-
 arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7.dts    |    3 +-
 arch/arm/boot/dts/renesas/r8a7742-iwg21m.dtsi      |    3 +-
 arch/arm/boot/dts/renesas/r8a7742.dtsi             |    2 -
 arch/arm/boot/dts/renesas/r8a7743-sk-rzg1m.dts     |    3 +-
 arch/arm/boot/dts/renesas/r8a7743.dtsi             |    1 -
 arch/arm/boot/dts/renesas/r8a7744.dtsi             |    1 -
 .../dts/renesas/r8a7745-iwg22d-sodimm-dbhd-ca.dts  |    3 +-
 .../arm/boot/dts/renesas/r8a7745-iwg22d-sodimm.dts |    3 +-
 arch/arm/boot/dts/renesas/r8a7745-sk-rzg1e.dts     |    3 +-
 arch/arm/boot/dts/renesas/r8a7745.dtsi             |    1 -
 arch/arm/boot/dts/renesas/r8a77470-iwg23s-sbc.dts  |    6 +-
 arch/arm/boot/dts/renesas/r8a7778-bockw.dts        |    5 +-
 arch/arm/boot/dts/renesas/r8a7778.dtsi             |    2 +-
 arch/arm/boot/dts/renesas/r8a7779-marzen.dts       |    9 +-
 arch/arm/boot/dts/renesas/r8a7779.dtsi             |    2 +-
 arch/arm/boot/dts/renesas/r8a7790-lager.dts        |   25 +-
 arch/arm/boot/dts/renesas/r8a7790-stout.dts        |   15 +-
 arch/arm/boot/dts/renesas/r8a7790.dtsi             |    2 -
 arch/arm/boot/dts/renesas/r8a7791-koelsch.dts      |   17 +-
 arch/arm/boot/dts/renesas/r8a7791-porter.dts       |   12 +-
 arch/arm/boot/dts/renesas/r8a7791.dtsi             |    1 -
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts      |    9 +-
 arch/arm/boot/dts/renesas/r8a7792-wheat.dts        |    3 +-
 arch/arm/boot/dts/renesas/r8a7792.dtsi             |    2 +-
 arch/arm/boot/dts/renesas/r8a7793-gose.dts         |   15 +-
 arch/arm/boot/dts/renesas/r8a7793.dtsi             |    1 -
 arch/arm/boot/dts/renesas/r8a7794-alt.dts          |   14 +-
 arch/arm/boot/dts/renesas/r8a7794-silk.dts         |    9 +-
 arch/arm/boot/dts/renesas/r8a7794.dtsi             |    1 -
 arch/arm/boot/dts/renesas/sh73a0-kzm9g.dts         |   17 +-
 arch/arm/boot/dts/renesas/sh73a0.dtsi              |    1 -
 arch/arm/boot/dts/rockchip/Makefile                |    1 +
 arch/arm/boot/dts/rockchip/rk3036-kylin.dts        |    2 +-
 arch/arm/boot/dts/rockchip/rk3066a-bqcurie2.dts    |    4 +-
 arch/arm/boot/dts/rockchip/rk3066a-marsboard.dts   |    6 +-
 arch/arm/boot/dts/rockchip/rk3066a-mk808.dts       |   12 +-
 arch/arm/boot/dts/rockchip/rk3066a-rayeager.dts    |   16 +-
 arch/arm/boot/dts/rockchip/rk3128-evb.dts          |    4 +-
 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts     |   28 +-
 arch/arm/boot/dts/rockchip/rk3188-bqedison2qc.dts  |   14 +-
 arch/arm/boot/dts/rockchip/rk3188-px3-evb.dts      |    2 +-
 arch/arm/boot/dts/rockchip/rk3188-radxarock.dts    |    8 +-
 arch/arm/boot/dts/rockchip/rk3228-evb.dts          |    2 +-
 arch/arm/boot/dts/rockchip/rk3229-evb.dts          |   16 +-
 arch/arm/boot/dts/rockchip/rk3229-xms6.dts         |   16 +-
 arch/arm/boot/dts/rockchip/rk3288-evb-act8846.dts  |    4 +-
 arch/arm/boot/dts/rockchip/rk3288-evb.dtsi         |    8 +-
 .../dts/rockchip/rk3288-firefly-reload-core.dtsi   |    2 +-
 .../boot/dts/rockchip/rk3288-firefly-reload.dts    |   18 +-
 arch/arm/boot/dts/rockchip/rk3288-firefly.dtsi     |   16 +-
 arch/arm/boot/dts/rockchip/rk3288-miqi.dts         |    8 +-
 arch/arm/boot/dts/rockchip/rk3288-phycore-rdk.dts  |    6 +-
 arch/arm/boot/dts/rockchip/rk3288-phycore-som.dtsi |    6 +-
 arch/arm/boot/dts/rockchip/rk3288-popmetal.dts     |   10 +-
 arch/arm/boot/dts/rockchip/rk3288-r89.dts          |    8 +-
 arch/arm/boot/dts/rockchip/rk3288-rock2-som.dtsi   |    4 +-
 arch/arm/boot/dts/rockchip/rk3288-rock2-square.dts |    6 +-
 arch/arm/boot/dts/rockchip/rk3288-tinker.dtsi      |    4 +-
 arch/arm/boot/dts/rockchip/rk3288-veyron-brain.dts |    6 +-
 .../dts/rockchip/rk3288-veyron-chromebook.dtsi     |   10 +-
 arch/arm/boot/dts/rockchip/rk3288-veyron-edp.dtsi  |    4 +-
 .../arm/boot/dts/rockchip/rk3288-veyron-fievel.dts |   10 +-
 .../arm/boot/dts/rockchip/rk3288-veyron-mickey.dts |    4 +-
 arch/arm/boot/dts/rockchip/rk3288-veyron-pinky.dts |    4 +-
 arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi      |    8 +-
 arch/arm/boot/dts/rockchip/rk3288-vmarc-som.dtsi   |    2 +-
 arch/arm/boot/dts/rockchip/rk3288-vyasa.dts        |   18 +-
 .../rockchip/rockchip-radxa-dalang-carrier.dtsi    |    8 +-
 arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts     |    2 +-
 arch/arm/boot/dts/rockchip/rv1108-evb.dts          |    2 +-
 arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts  |  422 ++
 .../boot/dts/rockchip/rv1126-edgeble-neu2-io.dts   |    6 +-
 .../arm/boot/dts/rockchip/rv1126-edgeble-neu2.dtsi |    2 +-
 arch/arm/boot/dts/rockchip/rv1126.dtsi             |    8 +
 arch/arm/boot/dts/st/spear1310-evb.dts             |    2 -
 arch/arm/boot/dts/st/spear1340-evb.dts             |    2 -
 arch/arm/boot/dts/st/ste-dbx5x0-pinctrl.dtsi       |   49 +
 .../boot/dts/st/ste-ux500-samsung-codina-tmo.dts   |    1 +
 arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts  |   27 +-
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi        |    7 +
 arch/arm/boot/dts/st/stm32mp135f-dk.dts            |   52 +
 arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi    |    6 +
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi        |    7 +
 arch/arm/boot/dts/st/stm32mp151.dtsi               |    2 +
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts           |   51 +-
 arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi       |    3 +-
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi  |   12 +-
 arch/arm/boot/dts/ti/omap/am335x-boneblue.dts      |    2 +-
 arch/arm/boot/dts/ti/omap/am335x-pdu001.dts        |    6 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts           |    2 +-
 arch/arm/boot/dts/ti/omap/am3517-som.dtsi          |    1 -
 arch/arm/boot/dts/ti/omap/am3874-iceboard.dts      |    8 +-
 arch/arm/boot/dts/ti/omap/am437x-cm-t43.dts        |    2 +-
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts       |    2 +-
 arch/arm/boot/dts/ti/omap/am437x-sbc-t43.dts       |    2 +-
 arch/arm/boot/dts/ti/omap/am437x-sk-evm.dts        |    2 +-
 arch/arm/boot/dts/ti/omap/am43x-epos-evm.dts       |    2 +-
 arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts  |    2 +-
 arch/arm/boot/dts/ti/omap/am57xx-sbc-am57x.dts     |    2 +-
 arch/arm/boot/dts/ti/omap/dm8148-evm.dts           |    1 -
 arch/arm/boot/dts/ti/omap/dm8168-evm.dts           |    1 -
 arch/arm/boot/dts/ti/omap/dra62x-j5eco-evm.dts     |    1 -
 arch/arm/boot/dts/ti/omap/dra7.dtsi                |    1 -
 arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi       |    1 -
 arch/arm/boot/dts/ti/omap/logicpd-som-lv.dtsi      |    1 -
 arch/arm/boot/dts/ti/omap/logicpd-torpedo-som.dtsi |    3 +-
 arch/arm/boot/dts/ti/omap/omap3-cm-t3x.dtsi        |    2 +-
 arch/arm/boot/dts/ti/omap/omap3-evm-37xx.dts       |    1 -
 arch/arm/boot/dts/ti/omap/omap3-evm.dts            |    1 -
 arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi         |    2 +-
 arch/arm/boot/dts/ti/omap/omap3-gta04a5.dts        |   10 +
 arch/arm/boot/dts/ti/omap/omap3-igep.dtsi          |    1 -
 arch/arm/boot/dts/ti/omap/omap3-ldp.dts            |    1 -
 arch/arm/boot/dts/ti/omap/omap3-overo-base.dtsi    |    1 -
 arch/arm/boot/dts/ti/omap/omap3-sb-t35.dtsi        |    2 +-
 arch/arm/boot/dts/ti/omap/omap3430-sdp.dts         |    2 -
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi            |    1 +
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts  |  211 +-
 arch/arm/boot/dts/ti/omap/omap4-kc1.dts            |    6 +-
 arch/arm/boot/dts/ti/omap/omap5-cm-t54.dts         |    2 +-
 arch/arm/boot/dts/ti/omap/omap5-sbc-t54.dts        |    2 +-
 arch/arm/boot/dts/ti/omap/twl4030.dtsi             |    2 +-
 arch/arm64/Kconfig.platforms                       |    4 +-
 .../dts/allwinner/sun50i-a100-allwinner-perf1.dts  |   18 +
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi     |  185 +-
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi   |   21 +
 .../boot/dts/allwinner/sun50i-h313-tanix-tx1.dts   |    5 +
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |    1 +
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |    1 +
 .../boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts |    1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |    1 +
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |    1 +
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts |    1 +
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |    1 +
 .../boot/dts/allwinner/sun50i-h6-beelink-gs1.dts   |    1 +
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts    |    1 +
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi     |    1 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |    1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi |    1 +
 .../dts/allwinner/sun50i-h616-orangepi-zero.dtsi   |    6 +
 .../boot/dts/allwinner/sun50i-h616-x96-mate.dts    |    6 +
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     |   44 +-
 .../boot/dts/allwinner/sun50i-h618-longanpi-3h.dts |    1 +
 .../dts/allwinner/sun50i-h618-orangepi-zero2w.dts  |    5 +
 .../allwinner/sun50i-h618-transpeed-8k618-t.dts    |    6 +
 .../allwinner/sun50i-h700-anbernic-rg35xx-2024.dts |   13 +-
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts   |    1 -
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts   |    1 -
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |    8 +-
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        |  364 ++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |  216 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |    2 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |    2 -
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |    1 -
 arch/arm64/boot/dts/apple/Makefile                 |   53 +
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi         |   51 +
 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi       |   51 +
 arch/arm64/boot/dts/apple/s5l8960x-common.dtsi     |   48 +
 arch/arm64/boot/dts/apple/s5l8960x-j71.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j72.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j73.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j85.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts        |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j86.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts        |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j87.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts        |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi      |   51 +
 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi      |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-n51.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x-n53.dts         |   14 +
 arch/arm64/boot/dts/apple/s5l8960x.dtsi            |  113 +
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi     |   48 +
 arch/arm64/boot/dts/apple/s8000-j71s.dts           |   15 +
 arch/arm64/boot/dts/apple/s8000-j72s.dts           |   15 +
 arch/arm64/boot/dts/apple/s8000-n66.dts            |   15 +
 arch/arm64/boot/dts/apple/s8000-n69u.dts           |   15 +
 arch/arm64/boot/dts/apple/s8000-n71.dts            |   15 +
 arch/arm64/boot/dts/apple/s8000.dtsi               |  144 +
 arch/arm64/boot/dts/apple/s8001-common.dtsi        |   48 +
 arch/arm64/boot/dts/apple/s8001-j127.dts           |   14 +
 arch/arm64/boot/dts/apple/s8001-j128.dts           |   14 +
 arch/arm64/boot/dts/apple/s8001-j98a.dts           |   14 +
 arch/arm64/boot/dts/apple/s8001-j99a.dts           |   14 +
 arch/arm64/boot/dts/apple/s8001-pro.dtsi           |   44 +
 arch/arm64/boot/dts/apple/s8001.dtsi               |  133 +
 arch/arm64/boot/dts/apple/s8003-j71t.dts           |   15 +
 arch/arm64/boot/dts/apple/s8003-j72t.dts           |   15 +
 arch/arm64/boot/dts/apple/s8003-n66m.dts           |   15 +
 arch/arm64/boot/dts/apple/s8003-n69.dts            |   15 +
 arch/arm64/boot/dts/apple/s8003-n71m.dts           |   15 +
 arch/arm64/boot/dts/apple/s8003.dtsi               |   21 +
 arch/arm64/boot/dts/apple/s800x-6s.dtsi            |   49 +
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi         |   43 +
 arch/arm64/boot/dts/apple/s800x-se.dtsi            |   49 +
 arch/arm64/boot/dts/apple/t7000-6.dtsi             |   50 +
 arch/arm64/boot/dts/apple/t7000-common.dtsi        |   36 +
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi      |   27 +
 arch/arm64/boot/dts/apple/t7000-j42d.dts           |   31 +
 arch/arm64/boot/dts/apple/t7000-j96.dts            |   14 +
 arch/arm64/boot/dts/apple/t7000-j97.dts            |   14 +
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi         |   51 +
 arch/arm64/boot/dts/apple/t7000-n102.dts           |   48 +
 arch/arm64/boot/dts/apple/t7000-n56.dts            |   14 +
 arch/arm64/boot/dts/apple/t7000-n61.dts            |   14 +
 arch/arm64/boot/dts/apple/t7000.dtsi               |  125 +
 arch/arm64/boot/dts/apple/t7001-air2.dtsi          |   74 +
 arch/arm64/boot/dts/apple/t7001-j81.dts            |   14 +
 arch/arm64/boot/dts/apple/t7001-j82.dts            |   14 +
 arch/arm64/boot/dts/apple/t7001.dtsi               |  123 +
 arch/arm64/boot/dts/apple/t8010-7.dtsi             |   43 +
 arch/arm64/boot/dts/apple/t8010-common.dtsi        |   48 +
 arch/arm64/boot/dts/apple/t8010-d10.dts            |   14 +
 arch/arm64/boot/dts/apple/t8010-d101.dts           |   14 +
 arch/arm64/boot/dts/apple/t8010-d11.dts            |   14 +
 arch/arm64/boot/dts/apple/t8010-d111.dts           |   14 +
 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi         |   44 +
 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi         |   14 +
 arch/arm64/boot/dts/apple/t8010-j171.dts           |   14 +
 arch/arm64/boot/dts/apple/t8010-j172.dts           |   14 +
 arch/arm64/boot/dts/apple/t8010-j71b.dts           |   14 +
 arch/arm64/boot/dts/apple/t8010-j72b.dts           |   14 +
 arch/arm64/boot/dts/apple/t8010-n112.dts           |   47 +
 arch/arm64/boot/dts/apple/t8010.dtsi               |  133 +
 arch/arm64/boot/dts/apple/t8011-common.dtsi        |   46 +
 arch/arm64/boot/dts/apple/t8011-j105a.dts          |   16 +
 arch/arm64/boot/dts/apple/t8011-j120.dts           |   16 +
 arch/arm64/boot/dts/apple/t8011-j121.dts           |   16 +
 arch/arm64/boot/dts/apple/t8011-j207.dts           |   16 +
 arch/arm64/boot/dts/apple/t8011-j208.dts           |   16 +
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi          |   42 +
 arch/arm64/boot/dts/apple/t8011.dtsi               |  141 +
 arch/arm64/boot/dts/apple/t8015-8.dtsi             |   13 +
 arch/arm64/boot/dts/apple/t8015-8plus.dtsi         |    9 +
 arch/arm64/boot/dts/apple/t8015-common.dtsi        |   48 +
 arch/arm64/boot/dts/apple/t8015-d20.dts            |   14 +
 arch/arm64/boot/dts/apple/t8015-d201.dts           |   14 +
 arch/arm64/boot/dts/apple/t8015-d21.dts            |   14 +
 arch/arm64/boot/dts/apple/t8015-d211.dts           |   14 +
 arch/arm64/boot/dts/apple/t8015-d22.dts            |   14 +
 arch/arm64/boot/dts/apple/t8015-d221.dts           |   14 +
 arch/arm64/boot/dts/apple/t8015-x.dtsi             |   13 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  234 +
 arch/arm64/boot/dts/exynos/Makefile                |    2 +
 arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts |  126 +
 arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi | 1094 ++++
 arch/arm64/boot/dts/exynos/exynos8895.dtsi         |  386 ++
 arch/arm64/boot/dts/exynos/exynos990-c1s.dts       |  115 +
 arch/arm64/boot/dts/exynos/exynos990-pinctrl.dtsi  | 2195 ++++++++
 arch/arm64/boot/dts/exynos/exynos990.dtsi          |  251 +
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi     |   50 +
 arch/arm64/boot/dts/freescale/Makefile             |   25 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |    2 +-
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts         |    2 -
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |    2 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |    3 -
 .../arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi |  169 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |    2 +-
 .../boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi  |   69 +
 .../arm64/boot/dts/freescale/imx8-apalis-eval.dtsi |   31 +-
 .../boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi |   31 +-
 .../boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi |   31 +-
 .../arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi |  135 +-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   |   19 +-
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |    2 +-
 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi    |  123 +
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |   33 +
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi |    4 +
 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi |   51 +
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi         |    6 +
 .../boot/dts/freescale/imx8mm-emtop-baseboard.dts  |  335 ++
 .../arm64/boot/dts/freescale/imx8mm-kontron-bl.dts |  131 +
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso      |  189 +
 .../boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts |    5 +
 .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   |    7 +-
 .../imx8mm-venice-gw73xx-0x-rs232-rts.dtso         |    4 -
 .../freescale/imx8mm-venice-gw73xx-0x-rs422.dtso   |    4 -
 .../freescale/imx8mm-venice-gw73xx-0x-rs485.dtso   |    4 -
 .../boot/dts/freescale/imx8mm-venice-gw75xx.dtsi   |   16 +
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |    4 +-
 .../boot/dts/freescale/imx8mm-venice-gw7902.dts    |    4 +-
 .../boot/dts/freescale/imx8mm-venice-gw7903.dts    |    4 +-
 .../boot/dts/freescale/imx8mm-venice-gw7904.dts    |    7 +-
 .../boot/dts/freescale/imx8mm-verdin-ivy.dtsi      |  471 ++
 .../dts/freescale/imx8mm-verdin-nonwifi-ivy.dts    |   18 +
 .../boot/dts/freescale/imx8mm-verdin-wifi-ivy.dts  |   18 +
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi   |    9 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |    8 +-
 .../freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso  |   29 +-
 .../boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts |    5 +
 .../boot/dts/freescale/imx8mn-venice-gw7902.dts    |    4 +-
 .../boot/dts/freescale/imx8mp-dhcom-drc02.dts      |  255 +
 .../boot/dts/freescale/imx8mp-dhcom-picoitx.dts    |  176 +
 .../boot/dts/freescale/imx8mp-evk-pcie-ep.dtso     |   17 +
 .../boot/dts/freescale/imx8mp-iota2-lumpy.dts      |  423 ++
 .../boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts |  305 ++
 .../boot/dts/freescale/imx8mp-kontron-dl.dtso      |  111 +
 .../boot/dts/freescale/imx8mp-kontron-osm-s.dtsi   |  908 +++
 .../imx8mp-kontron-smarc-eval-carrier.dts          |  254 +
 .../boot/dts/freescale/imx8mp-kontron-smarc.dtsi   |  280 +
 arch/arm64/boot/dts/freescale/imx8mp-navqp.dts     |   47 +
 .../dts/freescale/imx8mp-nitrogen-smarc-som.dtsi   |  348 ++
 .../imx8mp-nitrogen-smarc-universal-board.dts      |   17 +
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |   50 +-
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |    4 +-
 .../boot/dts/freescale/imx8mp-venice-gw702x.dtsi   |    4 +-
 .../boot/dts/freescale/imx8mp-venice-gw74xx.dts    |    7 +-
 .../boot/dts/freescale/imx8mp-venice-gw75xx.dtsi   |   16 +
 .../boot/dts/freescale/imx8mp-venice-gw82xx-2x.dts |   19 +
 .../boot/dts/freescale/imx8mp-venice-gw82xx.dtsi   |  533 ++
 .../boot/dts/freescale/imx8mp-verdin-ivy.dtsi      |  512 ++
 .../dts/freescale/imx8mp-verdin-nonwifi-ivy.dts    |   18 +
 .../boot/dts/freescale/imx8mp-verdin-wifi-ivy.dts  |   18 +
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi   |   12 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   25 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |    8 +-
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       |   89 +
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi |    4 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |    4 +
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |    3 +
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi  |  209 +
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |   34 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |  298 +-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi |    4 +
 arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi |   41 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |    6 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   70 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |  214 +
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   |    4 +-
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  115 +-
 .../boot/dts/freescale/imx93-9x9-qsb-i3c.dtso      |   72 +
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts    |  158 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |    8 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  |   86 +
 arch/arm64/boot/dts/freescale/imx95.dtsi           |   68 +-
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          |    6 -
 arch/arm64/boot/dts/freescale/s32g2.dtsi           |  153 +
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts     |    5 +
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts    |   13 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi           |  153 +
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts    |    4 +
 arch/arm64/boot/dts/lg/lg1312.dtsi                 |    8 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                 |    8 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |    1 -
 .../boot/dts/marvell/armada-7040-mochabin.dts      |    2 -
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |    1 -
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |    2 -
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |    1 -
 .../boot/dts/marvell/armada-8040-puzzle-m801.dts   |    2 -
 arch/arm64/boot/dts/mediatek/mt6358.dtsi           |    4 +-
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi          |   42 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi  |    8 +
 .../dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts   |    3 +
 .../dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts    |    2 +
 .../dts/mediatek/mt8183-kukui-jacuzzi-damu.dts     |    3 +
 .../dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi  |    3 +
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   30 +-
 .../boot/dts/mediatek/mt8183-kukui-kakadu.dtsi     |    4 +-
 .../boot/dts/mediatek/mt8183-kukui-katsu-sku32.dts |    2 +-
 .../boot/dts/mediatek/mt8183-kukui-katsu-sku38.dts |    2 +-
 .../boot/dts/mediatek/mt8183-kukui-kodama.dtsi     |    4 +-
 .../boot/dts/mediatek/mt8183-kukui-krane.dtsi      |    4 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   30 +-
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    |  123 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   21 +
 .../boot/dts/mediatek/mt8186-corsola-voltorb.dtsi  |   21 +-
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi   |   14 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi           |    7 +
 arch/arm64/boot/dts/mediatek/mt8188-evb.dts        |    2 -
 arch/arm64/boot/dts/mediatek/mt8188.dtsi           | 1124 +++-
 .../dts/mediatek/mt8192-asurada-spherion-r0.dts    |   11 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |    4 +-
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |    6 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |    4 +-
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     |  192 +-
 .../boot/dts/mediatek/mt8395-genio-1200-evk.dts    |   21 +-
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |   27 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |    2 +
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  |  544 +-
 .../dts/nvidia/tegra234-p3737-0000+p3701-0008.dts  |   11 +
 .../boot/dts/nvidia/tegra234-p3737-0000+p3701.dtsi |  547 ++
 arch/arm64/boot/dts/qcom/Makefile                  |   11 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |   10 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |   18 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   26 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   18 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |   52 +-
 .../boot/dts/qcom/msm8916-wingtech-wt86518.dts     |    2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  100 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  110 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |   68 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |   34 +-
 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts       |   12 +-
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts  |    4 +-
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |    4 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |   52 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   54 +-
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi    |   38 +-
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      |   68 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  220 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              |   68 +-
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |   40 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |   30 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   68 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  127 +-
 arch/arm64/boot/dts/qcom/qcs8550.dtsi              |    2 +-
 arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dts       |   11 +
 arch/arm64/boot/dts/qcom/qcs9100-ride.dts          |   11 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi              |   89 +-
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |   14 +-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |    4 +-
 ...anine.dts =3D> qrb5165-rb5-vision-mezzanine.dtso} |   19 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |    4 +-
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi         |  121 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |  701 ++-
 arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi  |   84 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |    8 +-
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |    8 +-
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |    8 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  366 +-
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |   10 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  397 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  166 +-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |  169 +
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  120 +-
 .../boot/dts/qcom/sc8280xp-microsoft-arcata.dts    | 1032 ++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  211 +-
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts |   32 +-
 arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts |    2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  190 +-
 arch/arm64/boot/dts/qcom/sdm632.dtsi               |   26 +-
 arch/arm64/boot/dts/qcom/sdm660.dtsi               |   16 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |  159 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |   74 +-
 ...dts =3D> sdm845-db845c-navigation-mezzanine.dtso} |   23 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |    4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  179 +-
 arch/arm64/boot/dts/qcom/sdx75.dtsi                |   90 +-
 arch/arm64/boot/dts/qcom/sm4250.dtsi               |   16 +-
 arch/arm64/boot/dts/qcom/sm4450.dtsi               |  160 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |  154 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi               |   54 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |  207 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |  160 +-
 arch/arm64/boot/dts/qcom/sm7125.dtsi               |   16 +-
 arch/arm64/boot/dts/qcom/sm7225.dtsi               |   16 +-
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts      | 1260 +++++
 arch/arm64/boot/dts/qcom/sm7325.dtsi               |   17 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  371 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  366 +-
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |    4 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  353 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |  161 +-
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts            |    4 +
 .../boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi   |    4 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  176 +-
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts    |    2 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  167 +-
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |    4 -
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |    4 -
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |    4 -
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  162 +-
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     |   25 +-
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   |   26 +-
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |   70 +-
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |  875 +++
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |   39 +-
 .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  |  104 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |  229 +-
 .../boot/dts/renesas/beacon-renesom-baseboard.dtsi |   10 +-
 .../arm64/boot/dts/renesas/beacon-renesom-som.dtsi |   11 +-
 arch/arm64/boot/dts/renesas/cat875.dtsi            |    3 +-
 arch/arm64/boot/dts/renesas/condor-common.dtsi     |    6 +-
 arch/arm64/boot/dts/renesas/draak.dtsi             |    6 +-
 arch/arm64/boot/dts/renesas/ebisu.dtsi             |   17 +-
 arch/arm64/boot/dts/renesas/hihope-common.dtsi     |    5 +-
 arch/arm64/boot/dts/renesas/hihope-rev2.dtsi       |    3 -
 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi       |    3 -
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    |    3 +-
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |    9 +-
 .../renesas/r8a77970-eagle-function-expansion.dtso |    7 +-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |    6 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |    6 +-
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |    6 +-
 .../boot/dts/renesas/r8a779a0-falcon-cpu.dtsi      |    3 +-
 arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts    |    3 +-
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi          |    8 +
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi      |    2 +-
 .../boot/dts/renesas/r8a779f0-spider-ethernet.dtsi |    9 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi          |    8 +
 arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts      |    6 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |    5 +
 .../dts/renesas/r8a779g2-white-hawk-single.dts     |    3 +-
 .../boot/dts/renesas/r8a779h0-gray-hawk-single.dts |   31 +-
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi          |   72 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi         |   34 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi         |   41 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi   |   21 +-
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi       |    3 +-
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi  |   18 +-
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi      |    3 +-
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi  |   51 +-
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi   |   22 +-
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi       |    9 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   11 +-
 arch/arm64/boot/dts/renesas/salvator-x.dtsi        |    2 +
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi       |    2 +
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   18 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    8 +-
 .../boot/dts/renesas/white-hawk-cpu-common.dtsi    |   19 +-
 .../boot/dts/renesas/white-hawk-ethernet.dtsi      |    6 +-
 arch/arm64/boot/dts/rockchip/Makefile              |   11 +-
 .../boot/dts/rockchip/px30-engicam-common.dtsi     |    4 +-
 .../boot/dts/rockchip/px30-engicam-px30-core.dtsi  |    2 +-
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |    4 +-
 .../boot/dts/rockchip/px30-firefly-jd4-core-mb.dts |    4 +-
 .../boot/dts/rockchip/px30-firefly-jd4-core.dtsi   |    4 +-
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     |   10 +-
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    |   39 +-
 arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts |  362 ++
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts        |   20 +-
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |   12 +-
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts  |   14 +-
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    |   12 +-
 .../boot/dts/rockchip/rk3326-anbernic-rg351m.dtsi  |    4 +-
 .../boot/dts/rockchip/rk3326-gameforce-chi.dts     |    4 +-
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi |    6 +-
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts         |    6 +-
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |   10 +-
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi |  394 ++
 .../boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts   |    3 +-
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts |   28 +-
 .../arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtsi |   35 +
 .../boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts   |   20 +-
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts |  399 +-
 .../arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtsi |   29 +
 .../dts/rockchip/rk3328-orangepi-r1-plus-lts.dts   |    6 +-
 .../boot/dts/rockchip/rk3328-orangepi-r1-plus.dts  |  346 +-
 .../boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi |  358 ++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |  379 +-
 arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts     |    3 +-
 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi       |  377 ++
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts  |   10 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    8 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    4 +-
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       |    6 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |    4 +-
 arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts    |   16 +-
 .../arm64/boot/dts/rockchip/rk3368-lion-haikou.dts |    6 +-
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      |    4 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |   18 +-
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |    4 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   14 +-
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts  |   20 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |   14 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |   18 +-
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |   22 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |    4 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |   20 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   20 +-
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |   20 +-
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |   16 +-
 .../boot/dts/rockchip/rk3399-kobol-helios64.dts    |   30 +-
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  |   16 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts  |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts  |   47 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtsi |   60 +
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts |    3 +-
 .../arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts |    6 +-
 .../dts/rockchip/rk3399-nanopi-r4s-enterprise.dts  |    3 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts |  124 +-
 .../arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi |  131 +
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |   16 +-
 arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi       |   52 +-
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   |   18 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   30 +-
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     |   37 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   20 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |   40 +-
 .../boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts  |    6 +-
 .../arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    |   22 +-
 .../boot/dts/rockchip/rk3399-rock-4c-plus.dts      |   14 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |   20 +-
 .../boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts   |    2 +-
 .../boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts   |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |   16 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |   24 +-
 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi         |  123 +
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |   18 +-
 .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     |    4 +-
 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts |   22 +
 arch/arm64/boot/dts/rockchip/rk3528.dtsi           |  189 +
 .../boot/dts/rockchip/rk3566-anbernic-rg-arc.dtsi  |    2 +-
 .../boot/dts/rockchip/rk3566-anbernic-rg353p.dts   |    2 +-
 .../boot/dts/rockchip/rk3566-anbernic-rg353ps.dts  |    2 +-
 .../boot/dts/rockchip/rk3566-anbernic-rg353v.dts   |    2 +-
 .../boot/dts/rockchip/rk3566-anbernic-rg353vs.dts  |    2 +-
 .../boot/dts/rockchip/rk3566-anbernic-rg503.dts    |    2 +-
 arch/arm64/boot/dts/rockchip/rk3566-base.dtsi      |   35 +
 arch/arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts |    2 +-
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts |   14 +-
 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts |  554 ++
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  |   16 +-
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi  |   22 +-
 .../boot/dts/rockchip/rk3566-powkiddy-rgb20sx.dts  |   89 +
 .../boot/dts/rockchip/rk3566-powkiddy-x55.dts      |    2 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts |   20 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts |   14 +-
 .../boot/dts/rockchip/rk3566-radxa-cm3-io.dts      |    6 +-
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi |   10 +-
 .../boot/dts/rockchip/rk3566-radxa-zero-3.dtsi     |    2 +-
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts     |   14 +-
 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts    |   18 +-
 .../boot/dts/rockchip/rk3566-soquartz-blade.dts    |    6 +-
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts      |    6 +-
 .../boot/dts/rockchip/rk3566-soquartz-model-a.dts  |   10 +-
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi  |    8 +-
 arch/arm64/boot/dts/rockchip/rk3566.dtsi           |  116 +-
 arch/arm64/boot/dts/rockchip/rk3566t.dtsi          |   90 +
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts |   24 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   |   18 +-
 .../boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi   |   12 +-
 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts |   18 +-
 .../arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi |   20 +-
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts  |   16 +-
 .../arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi |   12 +-
 arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts  |   17 +-
 arch/arm64/boot/dts/rockchip/rk3568-roc-pc.dts     |   20 +-
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts    |   28 +-
 .../rk3568-wolfvision-pf5-io-expander.dtso         |    7 +-
 .../boot/dts/rockchip/rk3568-wolfvision-pf5.dts    |   14 +-
 arch/arm64/boot/dts/rockchip/rk3568.dtsi           |  113 +-
 .../dts/rockchip/{rk356x.dtsi =3D> rk356x-base.dtsi} |   81 -
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      |  658 +++
 arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi   | 5775 +++++++++++++=
+++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 1678 ++++++
 .../arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi |  455 ++
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   12 +-
 arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts  |  408 ++
 .../boot/dts/rockchip/rk3588-base-pinctrl.dtsi     |  271 +-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |   41 +
 .../boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts    |   59 +-
 .../dts/rockchip/rk3588-coolpi-cm5-genbook.dts     |   63 +-
 .../arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi |    8 +-
 .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |    6 +-
 .../boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi |    8 +-
 .../dts/rockchip/rk3588-edgeble-neu6a-wifi.dtso    |    2 +-
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |   71 +-
 arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi |   12 +-
 .../rockchip/rk3588-friendlyelec-cm3588-nas.dts    |   49 +-
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     |   95 +-
 .../boot/dts/rockchip/rk3588-nanopc-t6-lts.dts     |    2 +-
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts  |    2 +-
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi |  103 +-
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |   16 +-
 .../boot/dts/rockchip/rk3588-orangepi-5-plus.dts   |   94 +-
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |   16 +-
 arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts |   40 +-
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |   61 +-
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts      |   67 +-
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |   35 +-
 .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   20 +-
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |  144 +-
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts |   67 +-
 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts  | 1170 ++++
 .../boot/dts/rockchip/rk3588s-gameforce-ace.dts    |   12 +-
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  |   69 +-
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts     |   26 +-
 .../arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi |  812 +++
 .../arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts |    2 +-
 .../arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts |  756 +--
 arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dts |   47 +
 .../arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts |  738 +--
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi      |  866 +++
 .../boot/dts/rockchip/rk3588s-orangepi-5b.dts      |   19 +
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |   75 +-
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts   |  920 ++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |   95 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |    6 +
 arch/arm64/boot/dts/ti/Makefile                    |   18 +-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |   74 +-
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |   13 +
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi    |   37 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi     |  655 +++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi         |   12 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |    9 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   12 +
 .../dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso |   20 -
 .../boot/dts/ti/k3-am625-verdin-nonwifi-ivy.dts    |   22 +
 .../arm64/boot/dts/ti/k3-am625-verdin-wifi-ivy.dts |   22 +
 arch/arm64/boot/dts/ti/k3-am625.dtsi               |    2 +-
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          |   27 +
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |    5 +
 .../boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts    |    4 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |    9 +
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi              |   51 +
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    |   27 +
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |    5 +
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |    9 +
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              |   47 +
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi |    6 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |   19 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |   37 +
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi            |   13 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    |   29 +-
 arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso  |   51 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |   22 +-
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  |    5 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |   36 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   15 +
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso        |    1 +
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso           |    2 +
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   |    8 +
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi         |    5 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |   15 +-
 arch/arm64/boot/dts/ti/k3-j7200-evm-pcie1-ep.dtso  |   53 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   40 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |   17 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |    6 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |   16 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |    2 +
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |   16 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |   18 +
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |    5 +
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |   14 +
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |   17 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |   19 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |    3 +
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi          |    2 +-
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           |   26 +
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi         |   45 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   98 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1488 +----
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  148 +
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1481 +++++
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2671 +++++++++
 ...tsi =3D> k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |   12 +-
 ...l.dtsi =3D> k3-j784s4-j742s2-thermal-common.dtsi} |    0
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +---------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  133 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts  |   18 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |    4 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |    4 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |    4 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts  |    4 -
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  101 +-
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi  |    4 +
 arch/riscv/boot/dts/sophgo/Makefile                |    1 +
 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts   |   49 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi            |   10 +
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts  |   23 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi            |   11 +
 arch/riscv/boot/dts/sophgo/cv181x.dtsi             |   21 +
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |   32 +
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     |   95 +
 arch/riscv/boot/dts/sophgo/sg2002.dtsi             |   43 +
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |   15 +
 arch/riscv/boot/dts/starfive/Makefile              |    1 +
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |   10 -
 .../dts/starfive/jh7110-deepcomputing-fml13v01.dts |   17 +
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts |   22 +
 .../boot/dts/starfive/jh7110-pine64-star64.dts     |   22 +
 .../dts/starfive/jh7110-starfive-visionfive-2.dtsi |   25 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  177 +-
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  158 +
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts  |   30 +-
 arch/riscv/boot/dts/thead/th1520.dtsi              |  120 +-
 drivers/soc/samsung/exynos-chipid.c                |    3 +
 include/dt-bindings/clock/qcom,sa8775p-camcc.h     |  108 +
 include/dt-bindings/clock/qcom,sa8775p-dispcc.h    |   87 +
 include/dt-bindings/clock/qcom,sa8775p-videocc.h   |   47 +
 include/dt-bindings/clock/r9a08g045-cpg.h          |    1 +
 .../dt-bindings/clock/renesas,r9a08g045-vbattb.h   |   13 +
 include/dt-bindings/clock/samsung,exynos8895.h     |  453 ++
 include/dt-bindings/clock/samsung,exynosautov920.h |   47 +
 1015 files changed, 64209 insertions(+), 19687 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sa8775p=
-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sa8775p=
-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sa8775p=
-videocc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a0=
8g045-vbattb.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exyn=
os8895-clock.yaml
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-a33-vstar-core1.dt=
si
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dts
 delete mode 100644 arch/arm/boot/dts/amlogic/meson6-atv1200.dts
 delete mode 100644 arch/arm/boot/dts/amlogic/meson6.dtsi
 create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.d=
ts
 create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-dhcom-pdk2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-lxr.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-commo=
n.dtsi
 create mode 100644 arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j72.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j73.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n51.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n53.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j71s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j72s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n66.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n69u.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j127.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j128.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j99a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pro.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j71t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j72t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n66m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n69.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n71m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-6s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-se.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-handheld.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j42d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j96.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j97.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-mini4.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n102.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n56.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n61.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j81.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j82.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d10.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d101.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d11.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d111.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j171.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j172.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j71b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j72b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-n112.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j105a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j120.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j121.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j207.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j208.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pro2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8plus.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d20.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d201.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d21.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d211.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d22.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d221.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8895.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos990-c1s.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos990-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos990.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-=
ivy.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-ivy=
.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-dhcom-drc02.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-dhcom-picoitx.d=
ts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-pcie-ep.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-=
s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.d=
tsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-e=
val-carrier.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.d=
tsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-=
som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-=
universal-board.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx-2=
x.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx.d=
tsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-=
ivy.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy=
.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701=
-0008.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701=
.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs9100-ride.dts
 rename arch/arm64/boot/dts/qcom/{qrb5165-rb5-vision-mezzanine.dts =3D> =
qrb5165-rb5-vision-mezzanine.dtso} (78%)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.d=
ts
 rename arch/arm64/boot/dts/qcom/{sdm845-db845c-navigation-mezzanine.dts=
 =3D> sdm845-db845c-navigation-mezzanine.dtso} (85%)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus=
.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rgb20sx=
.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi
 rename arch/arm64/boot/dts/rockchip/{rk356x.dtsi =3D> rk356x-base.dtsi}=
 (96%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi
 delete mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-gh=
z-opp.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-ivy.d=
ts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-ivy.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-evm-pcie1-ep.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.d=
tsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.=
dtsi
 rename arch/arm64/boot/dts/ti/{k3-j784s4-mcu-wakeup.dtsi =3D> k3-j784s4=
-j742s2-mcu-wakeup-common.dtsi} (99%)
 rename arch/arm64/boot/dts/ti/{k3-j784s4-thermal.dtsi =3D> k3-j784s4-j7=
42s2-thermal-common.dtsi} (100%)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv181x.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2002.dtsi
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fm=
l13v01.dts
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-videocc.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g045-vbattb.h
 create mode 100644 include/dt-bindings/clock/samsung,exynos8895.h

