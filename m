Return-Path: <linux-kernel+bounces-211555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27209053B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE68B23ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8478417C7A7;
	Wed, 12 Jun 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ktr5eKa8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1C16F0FD;
	Wed, 12 Jun 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198667; cv=none; b=Vq3bUANleZQUx9dFGIHR/a4retNYb6jZz8549A8ruN+nkpVBYur3aiwj1F+5VXpvS7OVs0fdbfGPhQ9YI9ue1LHwwsVjFh2OD3wTIS4kp4asp5c0+tYqHtOxQEXuIx35mKJcCcd/+51urTm8ytb7/8PJa5z1KsnN9Z4EmwAIFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198667; c=relaxed/simple;
	bh=JvXngxu9HGFoJkMNN0xeWKtg0wICDR1DqTnlIDWqeJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aa/jaF7ZwtC8jRq7Fb3evoxJWFVBP8CenqroQxwr20k0D6yz8ABmqV+yHcq7ffoYHwajE1UGlxEjIyXnqDr1rygVLxs1wGCiDdC51VYAVyjb19Oo6N1sA2Bg8EKwt9ItITiki9icPqljM/giSVG8/do/F6wnv7ct6ckX92ZghWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ktr5eKa8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOJGx115247;
	Wed, 12 Jun 2024 08:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198659;
	bh=OHWXyPTnN5KSXLCf0hjbD7yaww2UVLY19MKqQgfbez0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ktr5eKa8q7j5Nwn/DmniKSjYcih1XuByd2UNnjZ40y0LqhlqBTECg5bIDPoltotU7
	 nfRlA+jKuud6DGnxquR/9S4xmBz0NI+3eZWHAH3F+9wgaK43EYi16CurFlN/ZV/ty7
	 xN16akj60u2cW0Jzdw59XRE9fXAo8HBWh0c67c98=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDOJKP094545
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:19 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAmr046478;
	Wed, 12 Jun 2024 08:24:15 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 1/8] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to am62p-j722s-common-{}.dtsi
Date: Wed, 12 Jun 2024 18:54:02 +0530
Message-ID: <20240612132409.2477888-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240612132409.2477888-1-s-vadapalli@ti.com>
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The AM62P and J722S SoCs share most of the peripherals. With the aim of
reusing the existing k3-am62p-{mcu,main,thermal,wakeup}.dtsi files for
J722S SoC, rename them to indicate that they are shared with the J722S SoC.

The peripherals that are not shared will be moved in the upcoming patches
to the respective k3-{soc}-{mcu,main,wakeup}.dtsi files without "common" in
the filename, emphasizing that they are not shared.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
---
v5:
https://lore.kernel.org/r/20240604085252.3686037-2-s-vadapalli@ti.com/
Changes since v5:
- k3-am62p.dtsi is left as-is, instead of changing it to
  k3-am62p-j722s-common.dtsi.
- Renamed k3-am62p-thermal.dtsi to k3-am62p-j722s-common-thermal.dtsi.

 ...k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} | 3 ++-
 .../{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} | 3 ++-
 ...2p-thermal.dtsi => k3-am62p-j722s-common-thermal.dtsi} | 0
 ...m62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} | 3 ++-
 arch/arm64/boot/dts/ti/k3-am62p.dtsi                      | 8 ++++----
 5 files changed, 10 insertions(+), 7 deletions(-)
 rename arch/arm64/boot/dts/ti/{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} (99%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-thermal.dtsi => k3-am62p-j722s-common-thermal.dtsi} (100%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 900d1f9530a2..bf6384ba824a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree file for the AM62P main domain peripherals
+ * Device Tree file for the MAIN domain peripherals shared by AM62P and J722S
+ *
  * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index b973b550eb9d..1d4e5fc8b4e0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree file for the AM62P MCU domain peripherals
+ * Device Tree file for the MCU domain peripherals shared by AM62P and J722S
+ *
  * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-thermal.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-am62p-thermal.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-thermal.dtsi
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
similarity index 97%
rename from arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index c71d9624ea27..f6ec6e8e171d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree file for the AM62P wakeup domain peripherals
+ * Device Tree file for the WAKEUP domain peripherals shared by AM62P and J722S
+ *
  * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 94babc412575..2d11c80107b5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -116,10 +116,10 @@ cbass_wakeup: bus@b00000 {
 		};
 	};
 
-	#include "k3-am62p-thermal.dtsi"
+	#include "k3-am62p-j722s-common-thermal.dtsi"
 };
 
 /* Now include peripherals for each bus segment */
-#include "k3-am62p-main.dtsi"
-#include "k3-am62p-mcu.dtsi"
-#include "k3-am62p-wakeup.dtsi"
+#include "k3-am62p-j722s-common-main.dtsi"
+#include "k3-am62p-j722s-common-mcu.dtsi"
+#include "k3-am62p-j722s-common-wakeup.dtsi"
-- 
2.40.1


