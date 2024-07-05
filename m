Return-Path: <linux-kernel+bounces-242675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3AC928B50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14342811B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD4154C11;
	Fri,  5 Jul 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GHIfqnn3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE214AA0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192295; cv=none; b=kFNoSGFo3J4p/ioRUjFEFzuYAnx3P2vKUCkzSUZyvPL1rp0K/T3nierK4Tiw8pssvjvroJBWZOjibMHv36ZyOR5uG/mDTEevQHH73O56/0yqNH7m+U9qHhSsvlDSSVSNClvlaJUYRO2wQtFxnuCE6QHWaqtcfK4Xtca8BuXudQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192295; c=relaxed/simple;
	bh=iFsULXT/5FDkWEsyfBF01RdIN9iV6F/qVjLZJ7xJxAc=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=VkGVvUxjONKjcJjjWEDr/471jTw3MMerjuwFn4/WJ/X9MH4fK6wLzROHHxs8y+LGCOls2a6f52YWjLx569tr8ItzXZGB6tdbIpkajnnSamC5yrqap45fosZKMgNAYutDfgxkuiQJfZEqSs8xn58uK5GKkaTGkXnQbXDHl8vE5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GHIfqnn3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465FBH3A117285;
	Fri, 5 Jul 2024 10:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720192277;
	bh=ufNre9Y/BNX6RZMxFecalk/FQKeyZLA+QD9hQfRO6tk=;
	h=Date:From:To:CC:Subject;
	b=GHIfqnn3BKC12B/kguuJrfH4hpfiT7QXBgkMDrjvg0668k4HeF+fkiFgA6CWECgzz
	 yEoEvI3eI169Pinpd4wBSiLaTvwwodT/QGoTfMHn7xvQVGClU0dY0Z1PWY6sm1mnVn
	 dvi7CJjH3O+15nzX723ox3wn+EuvLRBhlRb1xs8c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465FBHSa062055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 10:11:17 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 10:11:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 10:11:17 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465FBEHm102538;
	Fri, 5 Jul 2024 10:11:15 -0500
Message-ID: <37f251a1-f3bd-402f-ab22-cf786c3871d7@ti.com>
Date: Fri, 5 Jul 2024 20:41:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 1/2] arm64: dts: ti: K3 devicetree updates for v6.11
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------rk0kaNJsTHDwI2dwxMRWD3C6"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--------------rk0kaNJsTHDwI2dwxMRWD3C6
Content-Type: multipart/mixed; boundary="------------Dq2T6pWO0f31Rwc8DO8OhgEL";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nishanth Menon <nm@ti.com>
Message-ID: <37f251a1-f3bd-402f-ab22-cf786c3871d7@ti.com>
Subject: [GIT PULL 1/2] arm64: dts: ti: K3 devicetree updates for v6.11

--------------Dq2T6pWO0f31Rwc8DO8OhgEL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC Maintainers,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-dt-for-v6.11

for you to fetch changes up to 6406c5d5512c0814b8c155df7f833a98d9069a72:

  arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA (2024-07-03 =
19:51:21 +0530)

----------------------------------------------------------------
TI K3 device tree updates for v6.11

Generic Fixups/Cleanups:
- main_pktdma reg ranges fixes
- dtbs_check warning cleanups with addition of cpsw-mac-efuse node and
  dropping "syscon", "simple-mfd" compatibles in favor of simple-bus
- Disable McASP FIFOs across SoCs for better latency
- Add memory node to bootloader stage with bootph-all
- Restructure am62p and j722s dtsi for share nodes across these SoCs
- DT warning fixes around USB type-C connector node (AM62/AM62P)

SoC Specific features and Fixes:
AM62
- GPMC and ELM addition

AM62A
- Enable RTC by default
- Crypto accelerator support

AM64 and AM65
- PRU system event support

AM69/J784S4:
- CPSW2G and CPSW9G addition with QSGMII and UXSGMII board support
- PCIe, USB, McASP, EHRPWM node additions

AM67/J722s
- Fix to update GPIO count
- Add gpio-ranges definition
- McASP support for audio
- PCIe, USB, Serdes support

Board Specific features and fixes:

AM62
- am62x-phyboard-lyra carrier board support
- am625-verdin: nau8822 PLL support
- sk: CMA node addition
- lp-sk: NAND expansion card overlay

AM62A
- New phyboard-lyra-am62ax from phytec
- CMA node addition

AM64:
- phycore-board: PMIC support
- hummingbird-t: RS485 RTS pin polarity update
- am6xx-phycore-som: overlays for variants w/o SPI, RTC, ETH PHY or w/
  QSPI
- EVM: GPMC NAND expansion card overlay
- EVM: ICSSG ethernet MII mode overlay support
- SK: power supply temp sensors support

AM68
- SK: PMIC, OSPI

J721e
- SK: MCAN Support
- Overlay for infotainment expansion board

AM69/J784S4
- EVM: PCIe RC/EP, USB3, MCAN support
- SK: PMIC support

----------------------------------------------------------------
Andrejs Cainikovs (1):
      arm64: dts: k3-am625-verdin: enable nau8822 pll

Andrew Davis (8):
      arm64: dts: ti: k3-am642-sk: Add power supply temperature sensors
      arm64: dts: ti: k3-am65: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j7200: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j721e: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j721s2: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-j784s4: Add cpsw-mac-efuse node to mcu_conf
      arm64: dts: ti: k3-am62a: Add cpsw-mac-efuse node to wkup_conf
      arm64: dts: ti: k3-am62: Add cpsw-mac-efuse node to wkup_conf

Beleswar Padhi (1):
      arm64: dts: ti: k3-j721e-sk: Add support for multiple CAN instances=


Bhavya Kapoor (1):
      arm64: dts: ti: k3-j784s4-evm: Add support for multiple CAN instanc=
es

Chintan Vankar (2):
      arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in phy_=
gmii_sel node
      arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G

Dasnavis Sabiya (2):
      arm64: dts: ti: k3-am69-sk: Add PCIe support
      arm64: dts: ti: k3-j784s4-main: Add node for EHRPWMs

Devarsh Thakkar (3):
      arm64: dts: ti: k3-am62x-sk-common: Add bootph-all for I2C1 instanc=
e pinmux
      arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
      arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA

Dhruva Gole (2):
      arm64: dts: ti: k3-am62p5-sk: fix graph_child_address warnings
      arm64: dts: ti: k3-am62x-sk-common: Fix graph_child_address warns

Garrett Giordano (4):
      arm64: dts: ti: k3-am62a: Enable AUDIO_REFCLKx
      arm64: dts: ti: Add am62x-phyboard-lyra carrier board
      dt-bindings: arm: ti: Add bindings for PHYTEC AM62Ax based hardware=

      arm64: dts: ti: Add basic support for phyBOARD-Lyra-AM62Ax

Jai Luthra (7):
      arm64: dts: ti: k3-am62x: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62a7: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-beagleplay: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5-sk: Fix pinmux for McASP1 TX

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

Josua Mayer (1):
      arm64: dts: ti: k3-am642-hummingboard-t: correct rs485 rts polarity=


Kamlesh Gurudasani (2):
      arm64: dts: ti: k3-am62a-main: Enable crypto accelerator
      arm64: dts: ti: k3-am62*-main: Remove unwanted properties from cryp=
to

MD Danish Anwar (2):
      arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add overlay for mii m=
ode
      arm64: dts: ti: k3-am642-evm: Enable "SYNC_OUT0" output

Matt Ranostay (2):
      arm64: dts: ti: k3-j784s4-main: Add support for USB
      arm64: dts: ti: k3-j784s4-evm: Enable USB3 support

Matthias Schiffer (1):
      arm64: dts: ti: k3-am64-tqma64xxl: relicense to GPL-2.0-only OR MIT=


Nathan Morrisson (9):
      arm64: dts: ti: phycore-am64: Add PMIC
      arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase cpu fre=
quency to 1.4 GHz
      arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
      arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe
      arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
      arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth ph=
y
      arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
      arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable spi no=
r
      arm64: dts: ti: k3-am6xx-phycore-qspi-nor: Add overlay to enable QS=
PI NOR

Neha Malcom Francis (4):
      arm64: boot: dts: ti: k3-*: Add memory node to bootloader stage
      arm64: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287 nodes=

      arm64: dts: ti: k3-am69-sk: Add TPS62873 node
      arm64: dts: ti: k3-j784s4-evm: Add TPS62873 node

Nishanth Menon (2):
      arm64: dts: ti: k3-pinctrl: Define a generic GPIO MUX Mode
      arm64: dts: ti: k3-am62p: Add gpio-ranges properties

Nitin Yadav (1):
      arm64: dts: ti: k3-am62: Add GPMC and ELM nodes

Roger Quadros (3):
      arm64: dts: ti: am642-evm: Add overlay for NAND expansion card
      arm64: dts: ti: am62-lp-sk: Add overlay for NAND expansion card
      arm: dts: k3-am642-evm-nand: Add bootph-all to NAND related nodes

Siddharth Vadapalli (16):
      arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
      arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add alia=
ses for it
      arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with C=
PSW9G
      arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
      arm64: dts: ti: k3-am62p: use eFuse MAC Address for CPSW3G Port 1
      arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
      arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
      arm64: dts: ti: k3-j784s4-evm: Add overlay for PCIe0 and PCIe1 EP M=
ode
      arm64: dts: ti: am62p: Rename am62p-{}.dtsi to am62p-j722s-common-{=
}.dtsi
      arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to am62p-m=
ain.dtsi
      arm64: dts: ti: k3-j722s: Add main domain peripherals specific to J=
722S
      arm64: dts: ti: k3-j722s: Switch to k3-am62p-j722s-common-{}.dtsi i=
ncludes
      arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros f=
or J722S
      arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
      arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM
      arm64: dts: ti: k3-am62p-j722s: Move SoC-specific node properties

Sinthu Raja (1):
      arm64: dts: ti: k3-am68-sk-som: Add support for OSPI flash

Suman Anna (2):
      arm64: dts: ti: k3-am64-main: Add PRU system events for virtio
      arm64: dts: ti: k3-am65-main: Add PRU system events for virtio

Tomi Valkeinen (1):
      arm64: dts: ti: k3-j721e: Add overlay for J721E Infotainment Expans=
ion Board

Vaishnav Achath (1):
      arm64: dts: ti: k3-j722s: Fix main domain GPIO count

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62a-wakeup: Enable RTC node

 Documentation/devicetree/bindings/arm/ti/k3.yaml             |    6 +
 arch/arm64/boot/dts/ti/Makefile                              |   56 +-
 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso               |  116 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                     |    4 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                     |   39 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi               |    4 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                   |    4 -
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi                   |    5 +
 arch/arm64/boot/dts/ti/k3-am62.dtsi                          |    2 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts               |    2 -
 .../boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso      |   20 +
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts        |  467 +---=

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                    |   32 +-
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi             |  330 +++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi                  |   11 +-
 arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts       |   18 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                      |   11 +-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi       | 1062 ++++=
+++++
 .../ti/{k3-am62p-mcu.dtsi =3D> k3-am62p-j722s-common-mcu.dtsi} |   11 +-=

 ...am62p-thermal.dtsi =3D> k3-am62p-j722s-common-thermal.dtsi} |    0
 ...3-am62p-wakeup.dtsi =3D> k3-am62p-j722s-common-wakeup.dtsi} |    8 +-=

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi                    | 1083 +---=
------
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                         |    9 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                      |   20 +-
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi           |  475 ++++=

 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi               |   32 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi                     |   24 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi              |   46 +-
 .../arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso |    4 +-
 arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso  |    4 +-
 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso |  101 +
 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso                |  148 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                      |   15 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts           |    1 -
 .../boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso     |   87 +
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts     |   12 -
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                       |   12 +
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts       |    4 +-
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi               |    4 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                     |   36 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                      |   12 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts               |    1 +
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts             |   76 +
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi                   |   86 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                        |   87 +-
 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso |   19 +
 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso     |   15 +
 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso |   15 +
 arch/arm64/boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso        |   15 +
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi              |   14 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi                  |    5 +-
 .../boot/dts/ti/k3-j721e-common-proc-board-infotainment.dtso |  164 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi              |   12 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                       |  117 +
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi                  |    1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi             |   12 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi                 |    5 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                      |  182 ++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                    |  217 ++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi                         |  165 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso     |   79 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso |  147 ++
 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso  |   81 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                     |  383 +++-=

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi                   |  527 ++++=
+
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi             |   14 +-
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi                        |   10 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h                          |    3 +
 arch/arm64/boot/dts/ti/k3-serdes.h                           |    8 +
 69 files changed, 5153 insertions(+), 1644 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz=
-opp.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dt=
s
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dts=
i
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi =3D> k3-am62p-j722s-com=
mon-mcu.dtsi} (94%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-thermal.dtsi =3D> k3-am62p-j722s=
-common-thermal.dtsi} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi =3D> k3-am62p-j722s-=
common-wakeup.dtsi} (93%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-m=
ii.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie=
-usb2.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-p=
hy.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.d=
tso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-n=
or.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-qspi-nor.dtso=

 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board-inf=
otainment.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.d=
tso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-ex=
p1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp=
2.dtso

--=20
Regards
Vignesh

--------------Dq2T6pWO0f31Rwc8DO8OhgEL--

--------------rk0kaNJsTHDwI2dwxMRWD3C6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmaIDREFAwAAAAAACgkQxEYeRXyRFuMB
oQf9GNtvrQCmRv1akppWl7IlDiW55qNHSQvVzWZwqO9dAwRQ5GppY7KY8WOPbkVuwC71NCHi7msW
0/SeXI5zt3N/R0RP1lGlsgO3uEDRr45cxmvkUh+6sgUQuHtB380hCm58jtheKviI5HcEdUNKJ0A3
E4CkUgb3+xIx5WNrA2I8lGr0j5a1Ibr4brrDi5D1O0v0JU8SpFVBIIaxFDy48exPTAXslFDJrRXz
zlA38d17x0FiLbZUM9QM+qnxJPxYL+Q2bEC7oIx80yF340zrny9PeS/a1ZbC7CTMnpzR5ISNVT3u
7Z5BsF6SBEiKOeEF1j+0BOnqbLtSWlR7s3+oJpHqhw==
=iPir
-----END PGP SIGNATURE-----

--------------rk0kaNJsTHDwI2dwxMRWD3C6--

