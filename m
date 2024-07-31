Return-Path: <linux-kernel+bounces-269606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04C9434C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9821F2200C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B381BE84B;
	Wed, 31 Jul 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I1OksOch"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E51BE24B;
	Wed, 31 Jul 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445858; cv=none; b=JOuFfstYPW5OWOAkHd7kbPdkhOfUizIsICazLI9qeUTTP84Rtil48MmYM7u3netd4koB1HqNnx0StD559DjKwgNMN09hjWVG7kHWwhzXShDEm1A+iwHRpWnXIuKtoW6DIwJgfCx8maL8ClCjXJCTICEtwoPt8AIDvhv1pNspS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445858; c=relaxed/simple;
	bh=PxrG8bZxhw5fS8NLV0uCqWQHJe+edChWzsafCHdHp30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QnuFcwi2XfgrxPXl5m9JkUSXPb6NlNlqoFiaulmOU5IsvFg6TFq4GaSyQIiNv2dYLsOVDSAxyU/HN/1At5CcNpgfu3KfcfbvKiJmsjfvEGcGOUIiqUmFmMAprpdUo/HbaVSlIYbFPw4xyLbhgNBxce+A62o7g1CqKpNgLbN78ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I1OksOch; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAoXc090454;
	Wed, 31 Jul 2024 12:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722445851;
	bh=VVhDA/DT3hGQQoCDjSRbk4R2xYQLd5qL46zIyAsBaqo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=I1OksOchEQLcN8K5SyNF+NktJnt5+sBk+k6lO/cPi1Czt+5hfvTHN86EoC7tiYhgd
	 KQjRl5fhGTBWd7VKlmFhA5ttMHX8Lf1n6dF0ht48jYMs6K4JG/+mAgXHTzcPzzG/Uh
	 e0u3S4IfUiQsqai91iHtpF6+TdXWqxnAqzDPHmO0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VHAoPf108877
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 12:10:50 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 12:10:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 12:10:50 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAVgR036362;
	Wed, 31 Jul 2024 12:10:47 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 31 Jul 2024 22:40:30 +0530
Subject: [PATCH v3 4/9] arm64: dts: ti: Split
 k3-j784s4-j742s2-main-common.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-b4-upstream-j742s2-v3-4-da7fe3aa9e90@ti.com>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
In-Reply-To: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445831; l=2512;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=PxrG8bZxhw5fS8NLV0uCqWQHJe+edChWzsafCHdHp30=;
 b=8Ny2Sufd49QCrbrTXLkPx6pOhFFJ/g8ZhyklB/Q8yVOnOjqUu/jTBBcuqBYOrZcFCWFYJl5cR
 LUcuFBm/g5KASfRk5nDw6nZ/26q9ssXUhpQe2kVDGgMEkU+SR6QbxiU
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

k3-j784s4-j742s2-main-common.dtsi will be included in k3-j742s2-main.dtsi at a
later point so move j784s4 related stuff to k3-j784s4-main.dtsi

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi   | 13 -------------
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi          | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi               |  2 ++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 17abd0f1560a..91352b1f63d2 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -2405,19 +2405,6 @@ c71_2: dsp@66800000 {
 		status = "disabled";
 	};
 
-	c71_3: dsp@67800000 {
-		compatible = "ti,j721s2-c71-dsp";
-		reg = <0x00 0x67800000 0x00 0x00080000>,
-		      <0x00 0x67e00000 0x00 0x0000c000>;
-		reg-names = "l2sram", "l1dram";
-		ti,sci = <&sms>;
-		ti,sci-dev-id = <40>;
-		ti,sci-proc-ids = <0x33 0xff>;
-		resets = <&k3_reset 40 1>;
-		firmware-name = "j784s4-c71_3-fw";
-		status = "disabled";
-	};
-
 	main_esm: esm@700000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x700000 0x00 0x1000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
new file mode 100644
index 000000000000..2ea470d1206d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J784S4 SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_main {
+	c71_3: dsp@67800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x67800000 0x00 0x00080000>,
+		      <0x00 0x67e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <40>;
+		ti,sci-proc-ids = <0x33 0xff>;
+		resets = <&k3_reset 40 1>;
+		firmware-name = "j784s4-c71_3-fw";
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 16ade4fd9cbd..f5afa32157cb 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -168,3 +168,5 @@ cpu7: cpu@103 {
 		};
 	};
 };
+
+#include "k3-j784s4-main.dtsi"

-- 
2.45.1


