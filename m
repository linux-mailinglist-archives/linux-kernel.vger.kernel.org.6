Return-Path: <linux-kernel+bounces-169313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C88BC6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1332A1F21AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D647F45;
	Mon,  6 May 2024 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XKA1HKHG"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0F4594E;
	Mon,  6 May 2024 05:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972866; cv=none; b=kgZ1qKMmBNmT3aFuMPhXavdhTImka9rNgAIIIQ2fW7ujuDmt3HpEch8V6QMroUn4A2LsD4v2XZIQxySS5rn8HKZppaPu91XWQwe0eqU6p5h1CxwFXLuIReSYB/pqw65Z5dTF3yWquWadr2IfZnE156FT0JTL88Cv3YL+iALqIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972866; c=relaxed/simple;
	bh=Wjxl0Zh0F/lHFVCnitattjt+DSqY4zt6X9vp37pdqqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMGlUxanP2W9THN4xYS5+NHr+Tu9uNA42DJMtqiD3xWIqjkujs9arrDxGOvGaWB4Pzd5IFYvF1U5hyItJB4Fd8k6LnCinoJ4GsCTVRE9GUIZVF3oi2G5QwTlGGK/2/bo+LwMtPbVbC1fSsnrZi940hymlnqBfLMFGbXISTjCBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XKA1HKHG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4465Kuui124386;
	Mon, 6 May 2024 00:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714972856;
	bh=smd/1opGYkPR1eeZZ60lr/FH6hT2kFz1MrZ/LEP7fZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XKA1HKHGlKKuMBG/I5T2dyr19uytGymF8NUpAGRWW/svotS0nlomb+2103mgNJXP7
	 8I8VhW+aD5fBznF2+YONPstWYEw7SrjEBwesL/aeaqa8ciBd5A+K99yg2ebrXD5wZ3
	 UE+Dlm03bT5BWTHPU6mjXAH6YCilJReGvIT80kjI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4465KuO5027044
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 May 2024 00:20:56 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 May 2024 00:20:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 May 2024 00:20:56 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4465Kj0h069015;
	Mon, 6 May 2024 00:20:53 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4-evm: Enable USB3 support
Date: Mon, 6 May 2024 10:50:44 +0530
Message-ID: <20240506052044.8228-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240506052044.8228-1-r-gunasekaran@ti.com>
References: <20240506052044.8228-1-r-gunasekaran@ti.com>
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
Changes since v1:
----------------
* Fixed dtbs_check warning by renaming 'main-usbss0-pins-default'
  to 'main-usbss0-default-pins'

v1: https://lore.kernel.org/all/20240502053615.29514-2-r-gunasekaran@ti.com/

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


