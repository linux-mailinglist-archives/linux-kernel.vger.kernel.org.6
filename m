Return-Path: <linux-kernel+bounces-211554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2F9053B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508F61F24472
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC0817B4F9;
	Wed, 12 Jun 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VAgItWQC"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF81DFE3;
	Wed, 12 Jun 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198666; cv=none; b=o12qeTCspE9jIh2SRmOapQhqW54Q8y6luVr3f05a4bkMBGv9oUAdJG9yekem4aErWo44MyHL+3kd6LZjuQIz1alg3eY1hH2kPZbo0l8D77qcK8SL6PHRAtb3Wf4mXbarHLXjaav/QLdWKMZtCTxdP9xBnrgWuPTy0XWsS/rcQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198666; c=relaxed/simple;
	bh=aDe32bkClREbvKEZP8ytsQJkd+ACN/v2u58lk8CGD68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U8i5dr4CaaeaLgPDOPqMPZqmXsIfOm142wAInplmXV44rHc36Ge5aWNDqL+B9X+9FHWUzs+onG3iGN41KRoUZZtfj2BiMyraNpRsnsbuEOtbvgt4zEHwxo+3KpX95syiVGzd4SF8oWprTIMq2AqCUKjP90XMWNP7nHXmk7f/3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VAgItWQC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOFUM111030;
	Wed, 12 Jun 2024 08:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198655;
	bh=2iXm9tvlGvr1d3NMZd2vWKy7oyTx9W7IxuHo+Pco1lk=;
	h=From:To:CC:Subject:Date;
	b=VAgItWQCi3bPL6BcDAtHedvieSATXh8pv+BRl9sI5pUGyOaWeru7o5p/02IXFczNa
	 O3SQQg3bgyxWP1Bg5yL1GCk3QGW66E6lhUDFq2Yo/WfV9eZ2euSPiYd+t6/FBVj0f7
	 IVwtVf8qnMtoeyEs7dS5B04CrkhEyyIWeIVVAur0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDOF96083298
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:15 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:15 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAmq046478;
	Wed, 12 Jun 2024 08:24:11 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 0/8] Add PCIe, SERDES and USB DT support for J722S
Date: Wed, 12 Jun 2024 18:54:01 +0530
Message-ID: <20240612132409.2477888-1-s-vadapalli@ti.com>
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
https://gist.github.com/Siddharth-Vadapalli-at-TI/7c9fdfd25fdcd02eaf02a70db8bd46fd

Sanity testing on AM62P5-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/74893311fbebdc523e0ae8e158eee19f

v5:
https://lore.kernel.org/r/20240604085252.3686037-1-s-vadapalli@ti.com/
Changes since v5:
- Rebased series on linux-next tagged next-20240612.
- Collected Acked-by/Reviewed-by tags from v4 series.
- k3-am62p.dtsi is left as-is, instead of changing it to
  k3-am62p-j722s-common.dtsi.
- Renamed k3-am62p-thermal.dtsi to k3-am62p-j722s-common-thermal.dtsi.
- Based on Vignesh's suggestion at:
  https://lore.kernel.org/r/9e7d3f9b-c762-40cd-9d0d-2f071aa3c371@ti.com/
  and at:
  https://lore.kernel.org/r/79eedaea-bf4f-4a20-8a52-751ce7187523@ti.com/
  the following is the file hierarchy in the current series:
  k3-am62p.dtsi = k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi +
  		  k3-am62p-main.dtsi
  k3-am62p5.dtsi = CPUs + k3-am62p.dtsi
  k3-j722s.dtsi = CPUs + CBASS-Ranges +
  		  k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi +
		  k3-j722s-main.dtsi

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
  arm64: dts: ti: k3-j722s: Move MAIN domain overrides to
    k3-j722s-main.dtsi
  arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for
    J722S
  arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
  arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 1068 +++++++++++++++++
 ...cu.dtsi => k3-am62p-j722s-common-mcu.dtsi} |    3 +-
 ...tsi => k3-am62p-j722s-common-thermal.dtsi} |    0
 ...dtsi => k3-am62p-j722s-common-wakeup.dtsi} |    3 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 1063 +---------------
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |    9 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       |   73 ++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     |  184 +++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi          |  165 ++-
 arch/arm64/boot/dts/ti/k3-serdes.h            |    8 +
 10 files changed, 1500 insertions(+), 1076 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-thermal.dtsi => k3-am62p-j722s-common-thermal.dtsi} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

-- 
2.40.1


