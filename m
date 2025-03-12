Return-Path: <linux-kernel+bounces-557824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484DEA5DE46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AD63B7649
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD042459C2;
	Wed, 12 Mar 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D9ogUIlD"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC95226861
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787065; cv=none; b=qwqzJgKmhD+jxqa8A+hp7yeHz4tDw2qoPrYJP8Mt/pieifZjqDWFQ5pRP+A7OehULMVDbYVHecC3XbCnrSizze7Be9iTxLsHraQIawr6sG7ZzSGEL99uY3hnkE6LJ19XGYGmylDV8pineSPDfgRyL5bg8TAcNDWhT22x8XM8Q7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787065; c=relaxed/simple;
	bh=CKwh8bZGL2+vYB9JbuDSLBR7JG4l/p3BknAMciDF/TI=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=ApFobYl5MrFyaaQuQj45BCQ3pPEH67vUsqiT+hQhbSG/SCS98r/GQcP6q0YFAii5dIXhDB7Tb9vjT6z6UQg5qe2aGIaZDGi721dIWuasIyVOX/pOC67JX1sbex3ic3fJk3ldN7DNi+VrDTE2VPi1OFeoTSUzNpnDZHXC1sn4dKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D9ogUIlD; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CDi1fd1043814
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741787041;
	bh=2jVIV9DnO8Fj9z+Rk95dAiuUSZ3yPdEOI3Ck8BUljhc=;
	h=Date:From:To:CC:Subject;
	b=D9ogUIlDfQdlamfPolhwo+7G5hsowQGDbE3nVWbU/np0DpoQ5ynpV2GEmVz4CMiIz
	 brMrHGxM32VEr8YYxpxBTI32Yjh8DmB8OwR9u3CkVj8nDk5GeiOm2YoT0Ps3oKioso
	 Cd3bemEh3wzB3nUboWgEDFplrg9Ulc/rCm/R05Ng=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52CDi1Mw107874
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Mar 2025 08:44:01 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 08:44:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 08:44:00 -0500
Received: from [10.24.68.192] (dhcp-10-24-68-192.dhcp.ti.com [10.24.68.192])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CDhwc0054596;
	Wed, 12 Mar 2025 08:43:59 -0500
Message-ID: <5d612c0e-4cd4-469a-9856-dd4552d74412@ti.com>
Date: Wed, 12 Mar 2025 19:13:57 +0530
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
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 1/2] arm64: dts: ti: K3 devicetree updates for v6.15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi ARM SoC Maintainers,


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-dt-for-v6.15

for you to fetch changes up to 377fde74eae4abcbcd5475676d58fb595a07ff85:

  arm64: dts: ti: k3-am62a-phycore-som: Reorder properties per DTS coding style (2025-03-07 18:48:05 +0530)

----------------------------------------------------------------
TI K3 device tree updates for v6.15

Generic Fixups/Cleanups:

SoC Specific features and Fixes:
AM62Ax:
Enable MCU domain pinctrl node

J784S4/J742S4:
GICD reg size fixes
Serdes lane ctrl reg mux mask fix

AM62P/J722s:
Wakeup UART0 sysc updates for system wakeup
pinctrl node fixes drop pinctrl-single,gpio-ranges
BCDMA CSI-RX support
Audio REFCLKx output support

Board Specific:
J784S4:
EVM: Cleanup duplicate gpio-hogs

J722S:
TypeC port mux selection fix

AM62Ax
SK: boot-phase tag to support USB bootmode
RTC support
Aliases for wakeup and MCU serial UARTs

AM62P
SK: boot-phase tag to support USB bootmode
USB wakeup support
Aliases for wakeup and MCU serial UARTs

AM62:
verdin-dahila: microphone support
SK: Aliases for wakeup and MCU serial UARTs
BeaglePlay: reserved CMA region for Multimedia applications

J721e:
SK/EVM: boot-phase tags for Serdes for DFU boot

Phytech board updates:
Boot-phase tag updates for AM64/AM62/AM62A boards
DTS coding style cleanups
RTOS IPC reserved-memory additions
DT overlay for X27 Connectors on AM64 SOMs

J721S2 SOM:
Add flash partitions

----------------------------------------------------------------
Daniel Schultz (1):
      arm64: dts: ti: am64-phyboard-electra: Add DT overlay for X27 connector

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62p: Enable AUDIO_REFCLKx

Hrushikesh Salunke (1):
      arm64: dts: ti: k3-j722s-evm: Fix USB2.0_MUX_SEL to select Type-C

Jayesh Choudhary (1):
      arm64: dts: ti: k3-j784s4-evm-quad-port-eth-exp1: Remove duplicate hogs

Keerthy (1):
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size

Markus Schneider-Pargmann (2):
      arm64: dts: ti: k3-am62x-sk-common: Add serial aliases
      arm64: dts: ti: k3-am62a7-sk: Add serial alias

Michael Walle (2):
      arm64: dts: ti: k3-am62p: fix pinctrl settings
      arm64: dts: ti: k3-j722s: fix pinctrl settings

Nishanth Menon (1):
      arm64: dts: ti: k3-am625-beagleplay: Reserve 128MiB of global CMA

Sai Sree Kartheek Adivi (1):
      arm64: dts: ti: k3-am62a-mcu: enable mcu domain pinmux

Siddharth Vadapalli (6):
      arm64: dts: ti: k3-am62a7-sk: Add boot phase tag for USB0
      arm64: dts: ti: k3-am62p5-sk: Add boot phase tag for USB0
      arm64: dts: ti: k3-j721e-common-proc-board: Add boot phase tag to SERDES3
      arm64: dts: ti: k3-j721e-sk: Add boot phase tag to SERDES3
      arm64: dts: ti: k3-am62p5-sk: Support SoC wakeup using USB1 wakeup
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix serdes_ln_ctrl reg-masks

Stefan Eichenberger (1):
      arm64: dts: ti: k3-am62-verdin-dahlia: add Microphone Jack to sound card

Udit Kumar (1):
      arm64: dts: ti: k3-j721s2-som-p0: Add flash partition details

Vaishnav Achath (3):
      arm64: dts: ti: k3-j722s-main: Add BCDMA CSI overrides
      arm64: dts: ti: k3-j722s-main: Add CSI2RX nodes
      arm64: dts: ti: k3-j722s-evm: Add camera peripherals

Vibhore Vardhan (3):
      arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
      arm64: dts: ti: k3-am62p-j722s-common-wakeup: Configure ti-sysc for wkup_uart0
      arm64: dts: ti: k3-am62p5-sk: Add serial alias

Wadim Egorov (7):
      arm64: dts: ti: k3-am64-phycore-som: Reserve RTOS IPC memory
      arm64: dts: ti: k3-am62-phycore-som: Reserve RTOS IPC memory
      arm64: dts: ti: k3-am62x-phyboard-lyra: Add boot phase tags
      arm64: dts: ti: k3-am62a-phycore-som: Add boot phase tags
      arm64: dts: ti: k3-am642-phyboard-electra: Add boot phase tags
      arm64: dts: ti: k3-am642-phyboard-electra: Reorder properties per DTS coding style
      arm64: dts: ti: k3-am62a-phycore-som: Reorder properties per DTS coding style

 arch/arm64/boot/dts/ti/Makefile                               |   3 +
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi               |  25 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi             |   6 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                |   8 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi                      |   1 -
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi              |  19 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                       |   4 +
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi         |   8 -
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi      |  36 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi                     |  26 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                       |   4 +-
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi            |   9 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                |   2 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi               |  33 +-
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts      |  19 +-
 .../ti/k3-am642-phyboard-electra-x27-gpio1-spi1-uart3.dtso    |  63 +++
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts         |   1 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                        |   1 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi                  |  41 ++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                       |  30 +-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                     | 208 +++++++++-
 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  |   7 -
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi      |   6 +-
 23 files changed, 488 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-x27-gpio1-spi1-uart3.dtso
-- 
Regards
Vignesh
https://ti.com/opensource


