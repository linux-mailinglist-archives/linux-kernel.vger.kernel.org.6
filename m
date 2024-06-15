Return-Path: <linux-kernel+bounces-215769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9465F9096D1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BC01C21021
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A518C38;
	Sat, 15 Jun 2024 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vb7h88Si"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94017579;
	Sat, 15 Jun 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439377; cv=none; b=arzRBuJtME0y9JAZMW26Xik4Fu00l9NWu2k4GR4kjZokuMTUa/AOH63LmV9jxvwgvzYPyhf03tMBYinMrlMneOPROUosn0ZbWOVyayiWhkNH3VXt5alR3+48veOwLiuL1jQ2WuAYPZuLkeMdiu9GuTJ6Glr5N926h5K5tLiD8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439377; c=relaxed/simple;
	bh=rBwMqTRsyloPG8mLh+a90y+z8GzhjQxc/nqlkFvdlNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XaXn47c3M5g0fJC5yaxYsCFYICsk5oAlCos5RtIPBBUP8tpdDPDlsV/RgJYfGbNCsp1CBsxSNLHRVRPCXU4/MFeu+6wliCNYnLdbJGQmTgEjQbc4ZeRr/16f3nl2HzuyaiytqwCrBJBIF9WN/5cDZzWpaZQMz/g4L79Dsi4PpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vb7h88Si; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45F8G6s5052806;
	Sat, 15 Jun 2024 03:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718439366;
	bh=MdFnYk2bAe/egZEobrkLJp0SfNmTXMt7lEYpYKFxDmQ=;
	h=From:To:CC:Subject:Date;
	b=vb7h88SiXtFjAjc9HyXcGau1XLiWaKA9Kqa+GIdagtcnQgzSxwMayxWMAvGf1ivM5
	 Hf3nBEFMLIJIWTDY5NKrsqcJZRI23Oq7fs7iJwnJ+b/TwChaavnZpd60sIuM08yIue
	 p1bhfiBEPdmKbMsTkQUz0KLb2JMj0LVBd1chQ9kk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45F8G6dV032173
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 03:16:06 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 03:16:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 03:16:05 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45F8G1QU024463;
	Sat, 15 Jun 2024 03:16:02 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v7 0/8] Add PCIe, SERDES and USB DT support for J722S
Date: Sat, 15 Jun 2024 13:45:52 +0530
Message-ID: <20240615081600.3602462-1-s-vadapalli@ti.com>
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
https://gist.github.com/Siddharth-Vadapalli-at-TI/556ff78fb81fbc47fcc205dff8a31745

Sanity testing on AM62P5-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/2fdb4c0e0db5c3f3ba55d37d587a740d

v6:
https://lore.kernel.org/r/20240612132409.2477888-1-s-vadapalli@ti.com/
Changes since v6:
- Rebased series on linux-next tagged next-20240613.
- Collected Acked-by tags from v6 series.
- Based on Roger's suggestion at:
  https://lore.kernel.org/r/d4c33ee4-1e91-40e5-90c8-bd793bcf34ff@kernel.org/
  in order to avoid overriding device-tree node properties, the
  properties that are different across AM62P and J722S have been moved
  from the k3-am62p-j722s-common-main.dtsi file to the respective
  k3-{soc}-main.dtsi files.
  PATCH 5/8 from the v6 series with the subject:
  arm64: dts: ti: k3-j722s: Move MAIN domain overrides to k3-j722s-main.dtsi
  is replaced by PATCH 8/8 of this series corresponding to the suggestion.

Regards,
Siddharth.

Siddharth Vadapalli (8):
  arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
    am62p-j722s-common-{}.dtsi
  arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to
    am62p-main.dtsi
  arm64: dts: ti: k3-j722s: Add main domain peripherals specific to
    J722S
  arm64: dts: ti: k3-j722s: Switch to k3-am62p-j722s-common-{}.dtsi
    includes
  arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for
    J722S
  arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
  arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM
  arm64: dts: ti: k3-am62p-j722s: Move SoC-specific node properties

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 1064 ++++++++++++++++
 ...cu.dtsi => k3-am62p-j722s-common-mcu.dtsi} |    3 +-
 ...tsi => k3-am62p-j722s-common-thermal.dtsi} |    0
 ...dtsi => k3-am62p-j722s-common-wakeup.dtsi} |    3 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 1073 +----------------
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |    9 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       |   73 ++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     |  190 +++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi          |  171 ++-
 arch/arm64/boot/dts/ti/k3-serdes.h            |    8 +
 10 files changed, 1514 insertions(+), 1080 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-thermal.dtsi => k3-am62p-j722s-common-thermal.dtsi} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

-- 
2.40.1


