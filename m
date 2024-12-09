Return-Path: <linux-kernel+bounces-437003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14D9E8DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE03E1617AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB0215711;
	Mon,  9 Dec 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G8za5VaO"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92320FABD;
	Mon,  9 Dec 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734344; cv=none; b=jcwgl3fVN+SXijPslKHcVHAeijOxlsJlQtxkwGYCmGuybN9g6hnzN3FFzJtv8jqDgzWDd8MBJMKcx0puVVMSGBICO+xJuT0yiQiZw4MvmcU2HZC6VMZ1q4Jvwe1pJBc6fhQxsGG+nrIQcDSq0QoetXIZEdCghCtU4P4rXRzhqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734344; c=relaxed/simple;
	bh=BNcLxl+DcJJbVF5E/p1CQUzZ5UK5Ws+R+EN50rheir8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XKL2uiAB0o6J9VRcV3wTUX8nRw/491DFrCLV8+yfWZ1K3jhJCMcG6OGl+Dzm5GKftc9p+OCn+ARq9e13WFO38PZn3FQp8pIXm0DkEQjKoSM0zJCjUoC8vntDbAQmn9nJASIrnjdQ7lZclsSamaZ0ITDM7W9jMkqpBsyCjoM5oWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G8za5VaO; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B98q2SE2485023
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 02:52:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733734322;
	bh=X3Af4Y2rLTa8xaPSh9/yanPOZLxr1gQCD0meK+BsxM0=;
	h=From:To:CC:Subject:Date;
	b=G8za5VaOkmxrj238Gh9/OUgqCIWot902/BIEsrjms2CvhowaUenL3VCekouk0/kJH
	 Ab+XKwxyAx0QfEj/hZSKQw/OnGZwPy9YK4vPZOQXafq5us/evMzWTD+mlSkQ+wYEcM
	 /5GQaahrKnW2EDIHClEn9K1DG3NHNgaPK9LHIhmc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B98q2i5010368
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Dec 2024 02:52:02 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Dec 2024 02:52:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Dec 2024 02:52:02 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B98pwbS085675;
	Mon, 9 Dec 2024 02:51:58 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4-j742s2-main-common: Enable ACSPCIE output for PCIe1
Date: Mon, 9 Dec 2024 14:21:56 +0530
Message-ID: <20241209085157.1203168-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The PCIe reference clock required by the PCIe Endpoints connected to the
PCIe connector corresponding to the PCIe1 instance of PCIe on J784S4-EVM
and J742S2-EVM is driven by the ACSPCIE module. Add the device-tree support
for enabling the same.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Patch is based on linux-next tagged next-20241209.

v1:
https://lore.kernel.org/r/20240715123301.1184833-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on linux-next tagged next-20241209.
- Moved changes from "k3-j784s4-main.dtsi" to its equivalent now which
  is "k3-j784s4-j742s2-main-common.dtsi" since PCIe1 is common to both
  J742S2 and J784S4.
- Renamed "acspcie0-proxy-ctrl" to "clock-controller" to follow generic
  node naming convention.
- Added "ti,syscon-acspcie-proxy-ctrl" property at the end of the node
  since vendor specific properties should be placed at the end.

Since all dependencies mentioned on the v1 patch have been merged, this
patch has no further dependencies. Patch has been tested on J784S4-EVM
with an NVMe SSD connected to the PCIe connector corresponding to PCIe1.
Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/c36e30d8e9eb7bec96f7f400af1ea470

Regards,
Siddharth.

 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi     | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 7721852c1f68..cddadd12f444 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/mux/mux.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
 #include <dt-bindings/phy/phy-ti.h>
 
 #include "k3-serdes.h"
@@ -124,6 +125,11 @@ audio_refclk1: clock@82e4 {
 			assigned-clock-parents = <&k3_clks 157 63>;
 			#clock-cells = <0>;
 		};
+
+		acspcie0_proxy_ctrl: clock-controller@1a090 {
+			compatible = "ti,j784s4-acspcie-proxy-ctrl", "syscon";
+			reg = <0x1a090 0x4>;
+		};
 	};
 
 	main_ehrpwm0: pwm@3000000 {
@@ -1091,8 +1097,8 @@ pcie1_rc: pcie@2910000 {
 		max-link-speed = <3>;
 		num-lanes = <4>;
 		power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 333 0>;
-		clock-names = "fck";
+		clocks = <&k3_clks 333 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
+		clock-names = "fck", "pcie_refclk";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		bus-range = <0x0 0xff>;
@@ -1103,6 +1109,7 @@ pcie1_rc: pcie@2910000 {
 		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
 			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		ti,syscon-acspcie-proxy-ctrl = <&acspcie0_proxy_ctrl 0x1>;
 		status = "disabled";
 	};
 
-- 
2.43.0


