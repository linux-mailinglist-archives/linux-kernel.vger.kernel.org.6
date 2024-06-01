Return-Path: <linux-kernel+bounces-197829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C48D6FBC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA61C20E03
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A681514ED;
	Sat,  1 Jun 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IHL0EHTM"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC81509BF;
	Sat,  1 Jun 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244181; cv=none; b=TOo9pf1Prb/kg5zbjC+0vlyatihA+SBSZWrMagD7bqAYdpJ0Jk+PyWILn+oIsM/18ZoaArpzj7YZvoZn/Fnd1PJDg0qSzO0X5+dvRaw0Lmzlvs0vKY1UCAvG3aSljGDY8WctcpDtVDcNdrYrcdZywPVGuEjBLPD/PkNg8E1b974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244181; c=relaxed/simple;
	bh=0aN9z1SQ1jjGgFST6VVgJMvgXtS15pPTB+Hjtac1RzE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DusyiElt4xA1T4l0Rq4n7sir7a10l/ntUsjHQ30P+nmd4Kb0v1cBfGp2Qndqkbt+NxB/2bME6Ui4DmXNdVGuNcFERSiId7gmW+KdHOpuuKNXlQ/K2cKv7yMovrwNDh773y22ku9sxhCyIZCcUndfcbjWEwkXU9lB+C3JpytfMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IHL0EHTM; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 451CFxpn124500;
	Sat, 1 Jun 2024 07:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717244160;
	bh=QufcMYh3YXU2xy/76eZ1TcO5FsqW7dBlYNeGOlQBUwE=;
	h=From:To:CC:Subject:Date;
	b=IHL0EHTMIbfMR9NMqj2Ek1+VGiC30zRq0TCJuKrFgDTdCpB4AzakyB53UmR0ta9HX
	 AUINPUy9OihXJ3TMEX89bNzEHzQlVeKSFKiDwB0hAjwx235MNhKc0iaXRBJDaFgfZF
	 KoDH8rSB3iYayOkUv+vs3IgZU2LsZ69OHMddzb/g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 451CFx9q000651
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 07:15:59 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 07:15:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 07:15:59 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 451CFtkE009323;
	Sat, 1 Jun 2024 07:15:55 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 0/7] Add PCIe, SERDES and USB DT support for J722S
Date: Sat, 1 Jun 2024 17:45:47 +0530
Message-ID: <20240601121554.2860403-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

This series adds the device-tree support for enabling PCIe and USB
functionality on J722S-EVM.

Since AM62P and J722S SoCs share most of the peripherals, the files have
been renamed to indicate the same. The main domain peripherals on both
SoCs that aren't shared are present in the "soc-main.dtsi" files.
This change has been made based on Roger's feedback at:
https://lore.kernel.org/r/f52d9569-a399-422f-9cf0-b0bf69b64d18@kernel.org/

This series has been tested on J722S-EVM for PCIe and USB functionality:
https://gist.github.com/Siddharth-Vadapalli-at-TI/bb20e30a4a9e29e1a6772915c13dd214
Sanity testing on AM62P5-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/a8764b3180d20d7e380b167637136676

v3:
https://lore.kernel.org/r/20240524090514.152727-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased series on next-20240531.
- Renamed files to indicate that they are shared between AM62P and J722S:
  k3-am62p.dtsi => k3-am62p-j722s-common.dtsi
  k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi
  k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi
  k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi
- Moved AM62P specific USB1 from the shared
  k3-am62p-j722s-common-main.dtsi to AM62P specific k3-am62p-main.dtsi
- Updated k3-j722s.dtsi to include k3-am62p-j722s-common.dtsi instead of
  including k3-am62p5.dtsi
- Added J722S specific main domain peripherals namely USB1, PCIe and
  SERDES in k3-j722s-main.dtsi

Regards,
Siddharth.

Siddharth Vadapalli (7):
  arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
    am62p-j722s-common-{}.dtsi
  arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to
    am62p-main.dtsi
  arm64: dts: ti: k3-j722s: Add main domain peripherals specific to
    J722S
  arm64: dts: ti: k3-j722s: Switch to k3-am62p-j722s-common.dtsi
  arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for
    J722S
  arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
  arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 1067 +++++++++++++++++
 ...cu.dtsi => k3-am62p-j722s-common-mcu.dtsi} |    2 +-
 ...dtsi => k3-am62p-j722s-common-wakeup.dtsi} |    2 +-
 ...-am62p.dtsi => k3-am62p-j722s-common.dtsi} |    6 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 1060 ----------------
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         |    3 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       |   72 ++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     |  170 +++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi          |   97 +-
 arch/arm64/boot/dts/ti/k3-serdes.h            |    8 +
 10 files changed, 1420 insertions(+), 1067 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
 rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

-- 
2.40.1


