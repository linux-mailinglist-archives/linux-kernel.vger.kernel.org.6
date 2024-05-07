Return-Path: <linux-kernel+bounces-171044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB58BDF16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8248C1F223DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC4114F123;
	Tue,  7 May 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t0R82+7f"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91314EC65;
	Tue,  7 May 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075764; cv=none; b=Sn8qN1pDSol+uk/6NBzne9QFqO8y5K8D6T9Q0+vMBjmjMDsLPcQ3V3y/eZ+M5asFtQ+f38T1TLoQd5GpLmVST2XIcWyuicvWuebZXHYskVfiv+hDuvSnaEUZClpGGE0ccWFn7DxCnwZPSZO9hH3NbTNsZyjxNNQzOwMM4Nc+nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075764; c=relaxed/simple;
	bh=pzBYIDYPxxaFkxuKahT7iMaeKL1h19wPwuGYCEHqVeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siVWbep8GypXLIKJEJ3vzXntNuneKGIJfBhPsL3oPyUAxN/BvFPAL1HOMq9iOw5pt+uctJlMu1pWvWIY0s9UVrYYiQeAmFlJGOA2UasjD+2jdp0Mmy5x8jdYhsgDEVwlw9KZQ8rhgfxZC+FaSMb2K/jBWvFw7yj5VEmW+SS0GH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t0R82+7f; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4479tvtT107422;
	Tue, 7 May 2024 04:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715075757;
	bh=N17m9LzgCTati8EKmN4u+FCakx9xKHwIfJ2kC2zewIU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=t0R82+7fN0mf2mPZwWJWs/+OYC3s2mPXtf6ieThhSqhOimMVbw7/cmodUxjqqMeR2
	 qZXcKoUg44l73LfnLP4qhrrUhDiC0dvPgPOVcr2hXiqdiSeU0z6Q9/Z9hRAkKeC+lX
	 A9oIYJsGMf9Cr+f/1BPdKy6F7WEK9U9u0pRu3Egk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4479tvcX034259
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 04:55:57 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 04:55:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 04:55:57 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4479tjn9007273;
	Tue, 7 May 2024 04:55:53 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-j784s4-evm: Enable USB3 support
Date: Tue, 7 May 2024 15:25:45 +0530
Message-ID: <20240507095545.8210-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507095545.8210-1-r-gunasekaran@ti.com>
References: <20240507095545.8210-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Matt Ranostay <mranostay@ti.com>

The board uses SERDES0 Lane 3 for USB3 IP. So update the
SerDes lane info for USB. Add the pin mux data and
enable USB3 support.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes since v2:
-----------------
* No change

Changes since v1:
----------------
* Fixed dtbs_check warning by renaming 'main-usbss0-pins-default'
  to 'main-usbss0-default-pins'

v2: https://lore.kernel.org/all/20240506052044.8228-3-r-gunasekaran@ti.com/
v1: https://lore.kernel.org/all/20240502053615.29514-3-r-gunasekaran@ti.com/

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index d511b25d62e3..a2d3cba0423e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -336,6 +336,13 @@
 			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
 		>;
 	};
+
+	main_usbss0_pins_default: main-usbss0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AN37) TIMER_IO1.USB0_DRVVBUS */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -1041,6 +1048,40 @@
 				 <&k3_clks 218 22>;
 };
 
+&serdes0 {
+	status = "okay";
+
+	serdes0_usb_link: phy@3 {
+		reg = <3>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz0 4>;
+	};
+};
+
+&serdes_wiz0 {
+	status = "okay";
+};
+
+&usb_serdes_mux {
+	idle-states = <0>; /* USB0 to SERDES lane 3 */
+};
+
+&usbss0 {
+	status = "okay";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	pinctrl-names = "default";
+	ti,vbus-divider;
+};
+
+&usb0 {
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phys = <&serdes0_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};
+
 &serdes_wiz4 {
 	status = "okay";
 };
-- 
2.17.1


