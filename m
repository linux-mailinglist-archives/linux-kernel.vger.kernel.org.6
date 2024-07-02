Return-Path: <linux-kernel+bounces-238121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680BB9243D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2333A28843C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43B1BE24E;
	Tue,  2 Jul 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xZLvAIWU"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907F1BD50E;
	Tue,  2 Jul 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938670; cv=none; b=bDvtSIBRUw55NODjWFH0LaB78SV4E7RXjjLQUI3W+pADYjZOo9Kb3vy5bECOZhaajtc0cn7jN9JQGLQ1PCBQTKiILGGB+ZlPehvW5eUyxlroqUDbobyx+V/G5YJZrOoVHJP8tLo5X5pT1WHbZ8cf3N6C+uH81NtqYT6Nj3FmWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938670; c=relaxed/simple;
	bh=TEISTGNqUCQco+Gu1UmliAuZuaiM9vsZntscT4xlMf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpEaV8hP6Vdg4i89NUgbdXxjcU5OuTOAGCwSsOHHNJwbcrRUuBgmvX9VjePvs8SFqIp4cDfxPRGJTJgUn7CTMPhVvXlRu51R3QnogP98/Zj/LogIFbxNYyZeHl2vI08+7Ejzlh6Luopw1E8NJf3CqLT+3kwfdm5Gn2ugIV8vAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xZLvAIWU; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi8jb051254;
	Tue, 2 Jul 2024 11:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719938648;
	bh=KplOxOQPqHLAX8GNF7TJR+t//tYPDP1lPxEZajqtg34=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xZLvAIWU/kn+aQSoKm43Em0x3d8DV7Cu8/fe4BLf+aTZnUN4DiPoPahG7KUU3ZyrA
	 L3kxmoUFJAKXNjTtVPBXEH4M22pRAJQj4vmyp7nETSPSpIH6qOhy3YslwiSmd3Ol5A
	 8I4q0hShqov8UoA4w88OGkRfOFB8zetZcyBSMS+g=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 462Gi8WZ008549
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 11:44:08 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 11:44:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 11:44:07 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi4YD112748;
	Tue, 2 Jul 2024 11:44:07 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vaishnav M A
	<vaishnav@beagleboard.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Walle
	<mwalle@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson
	<robertcnelson@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ayush Singh <ayush@beagleboard.org>,
        Ayush Singh <ayushdevel1325@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 3/3] arm64: dts: ti: grove: Add Grove Sunlight Sensor overlay
Date: Tue, 2 Jul 2024 11:44:03 -0500
Message-ID: <20240702164403.29067-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702164403.29067-1-afd@ti.com>
References: <20240702164403.29067-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add DT overlay for the Grove Sunlight Sensor[0].

[0] https://wiki.seeedstudio.com/Grove-Sunlight_Sensor/

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  3 ++
 .../boot/dts/ti/grove-sunlight-sensor.dtso    | 31 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index a859629a6072c..7d1ce7a5d97bc 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -8,6 +8,9 @@
 # Entries are grouped as per SoC present on the board. Groups are sorted
 # alphabetically.
 
+# This needs a better directory location
+dtb-$(CONFIG_OF_OVERLAY) += grove-sunlight-sensor.dtbo
+
 # Boards with AM62x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtbo
diff --git a/arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso b/arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso
new file mode 100644
index 0000000000000..ab2f102e1f8ab
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/**
+ * Grove - Sunlight Sensor v1.0
+ *
+ * https://wiki.seeedstudio.com/Grove-Sunlight_Sensor/
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+&GROVE_CONNECTOR {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&GROVE_PIN1_MUX_I2C_SCL>,
+	            <&GROVE_PIN2_MUX_I2C_SDA>;
+};
+
+&GROVE_PIN1_I2C {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	clock-frequency = <100000>;
+
+	si1145@60 {
+		compatible = "si,si1145";
+		reg = <0x60>;
+	};
+};
-- 
2.39.2


