Return-Path: <linux-kernel+bounces-200281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465978FAE08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0020B282465
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D0142654;
	Tue,  4 Jun 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QcfbN6qa"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD61BA39;
	Tue,  4 Jun 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491192; cv=none; b=OGx5usOIhMI0S5GxN3mWDZV2lmYy+3vHQmwEEk/4Q59KEKi/n+wBVQQS8UXMAHbIna6X5VRQ4LPlx8jUOyn9jBTLdQZds6AzqO8y/7JhJXwMjPBagVfbQXFc9JQdfcrf4fY5gRV4dgJUw0vmFDpakFHp7lY0suH/JsuvPuiD2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491192; c=relaxed/simple;
	bh=EF6kcuyEKnCpEhcDAN3Y90hUIGJNMUAFdpjqJ/fxZPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icoJBZ5c7TWiwD3c3goN41G5N7sYL4g4kkCO3ZcMW/VJIOhOkNJqiqEllbwRa5LmPS7AlZMaPBmi9Xp0A2N7IE5h70HgCKPffm5SvGaL0YB4T0pO/KkWnm0y79WNkGY/t+2zQVbn2dDiz6UB8lp75BabO5vjucrNLwlKijiEAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QcfbN6qa; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4548qvv1104969;
	Tue, 4 Jun 2024 03:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717491177;
	bh=6iyLsfE5NFGLIDenSZ7LevfQ5SYEgR7vWcrXflvbod0=;
	h=From:To:CC:Subject:Date;
	b=QcfbN6qaz7Gbahay7n3vesS7D/GPGHdB11dY6QcJXvb7IT2cjvdbRUMAJKOAHB29N
	 e1NskZl4SEC5dR9b2ZSbJxsMZKPj5tnCKjMsv9uOMEMAZAseYXwCyIwbpuKi8Gmtcl
	 oa5wkOOBtFXsaN5BaEW9cYYcUKxn2GcFWGYo30ow=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4548qvaL083479
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 03:52:57 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 03:52:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 03:52:57 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4548qqQh066926;
	Tue, 4 Jun 2024 03:52:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 0/7] Add PCIe, SERDES and USB DT support for J722S
Date: Tue, 4 Jun 2024 14:22:45 +0530
Message-ID: <20240604085252.3686037-1-s-vadapalli@ti.com>
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
https://gist.github.com/Siddharth-Vadapalli-at-TI/02c037efd3666ea8232d7bb8b0fa42f3

Sanity testing on AM62P5-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/1fb178f31b7cbc8eefd424e1e540ef3b

v4:
https://lore.kernel.org/r/20240601121554.2860403-1-s-vadapalli@ti.com/
Changes since v4:
- Rebased series on linux-next tagged next-20240604.
- Based on Andrew's feedback at:
  https://lore.kernel.org/r/086fa11e-10f8-463d-8966-1a33a52a3146@ti.com/
  MCU was retained as-is while main and wakeup were changed to MAIN and
  WAKEUP in the respective shared files. Also, newline was added between
  the file description and the Copyright in all the files.
  Collected Acked-by tag for the 1st patch since these changes have been
  made.
- Based on Andrew's feedback at:
  https://lore.kernel.org/r/147d58a6-0cad-47b6-a069-755f835a77e9@ti.com/
  SERDES1 has also been disabled in k3-j722s-main.dtsi similar to SERDES0.
- Based on Andrew's feedback at:
  https://lore.kernel.org/r/183a9d15-939e-433b-84ba-8a64eb8ef3ec@ti.com/
  the `status = "okay";` line has been moved to the end of the
  `pcie0_rc` node referenced in k3-j722s-evm.dts following the updated
  ordering rules. Also, the SERDES1 node has been enabled in the
  k3-j722s-evm.dts file since it has been disabled in the
  k3-j722s-main.dtsi file.

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

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 1068 +++++++++++++++++
 ...cu.dtsi => k3-am62p-j722s-common-mcu.dtsi} |    3 +-
 ...dtsi => k3-am62p-j722s-common-wakeup.dtsi} |    3 +-
 ...-am62p.dtsi => k3-am62p-j722s-common.dtsi} |    6 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 1063 +---------------
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         |    3 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       |   73 ++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     |  173 +++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi          |   97 +-
 arch/arm64/boot/dts/ti/k3-serdes.h            |    8 +
 10 files changed, 1429 insertions(+), 1068 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
 rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

-- 
2.40.1


