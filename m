Return-Path: <linux-kernel+bounces-215771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B09096D6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7751C2115E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E2224FD;
	Sat, 15 Jun 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P1WFzETp"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D81CA94;
	Sat, 15 Jun 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439385; cv=none; b=OW1KhktMAXKh8rTGxl0E7kZfNE1jFEEwLLUsdEt0cS+zTLhX3qowt20gLkl025IzEWbV9bywbM93TrfINcT4TGI/sWvoBB3xq0wRMbdPPxF7P8NBzsdAZGsfXUi9S4JwFwb5fcd2J+cPDAc3wDfsZ4aqiBHQBdolRHsIof99if8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439385; c=relaxed/simple;
	bh=lJ0LFnMAev/ZokSSiLxDUixFGWgniKUj+gj5RRIY7bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr5qAc42YGLVHmxnugL15TCVI4TxOZYcpuVjsgdFAglQ8OmeUYDiH0LZVvd8s7uWouKE9JsGxEX/6TEGqmYjhHKTQjnYPM3Ymz3zl+mSadQzIxuBi5pQ8JbWMjK2LYYAu+Vf580U2F1Vl3GE2QS7gBKMyokdmtNJhP6nSraMR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P1WFzETp; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45F8GAuP069665;
	Sat, 15 Jun 2024 03:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718439370;
	bh=A8rt51C5aTHmQ/FVzZRM4ATnvo2alvUHzxR40z95+Ak=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=P1WFzETprRFG35pRcAM0kRLtGYqdUh9Rcu+e7Z3rklgBpD7ygKPk6AqP90TtstB0G
	 D3vPgDqHvgbILxgu1MwtsRzkpq7zBYhyeT8udo4Ucg78rtSCYihVATag7dYfNi9M4R
	 1bPcr4JNBey9hSqCTeGqEPDm33kYQutKRBt5FxzQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45F8GAOM078410
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 03:16:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 03:16:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 03:16:10 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45F8G1QV024463;
	Sat, 15 Jun 2024 03:16:06 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v7 1/8] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to am62p-j722s-common-{}.dtsi
Date: Sat, 15 Jun 2024 13:45:53 +0530
Message-ID: <20240615081600.3602462-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240615081600.3602462-1-s-vadapalli@ti.com>
References: <20240615081600.3602462-1-s-vadapalli@ti.com>
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
Acked-by: Roger Quadros <rogerq@kernel.org>
---
v6:
https://lore.kernel.org/r/20240612132409.2477888-2-s-vadapalli@ti.com/
Changes since v6:
- Collected Acked-by tag from Roger Quadros <rogerq@kernel.org>

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
index eed06506f617..ff97e4a59e3b 100644
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
index 71784e10b4f1..315d0092e736 100644
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


