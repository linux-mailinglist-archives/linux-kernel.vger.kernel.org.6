Return-Path: <linux-kernel+bounces-200283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9328FAE0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD6DB22F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168D14386C;
	Tue,  4 Jun 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WbiSfFZK"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFA1428FA;
	Tue,  4 Jun 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491198; cv=none; b=dhqTsjN/6n2NBl4g+LWosZpBo4LGkgZSpQATfRUebSj3pRgI5pqe1XJmin0q9elhATDhPgjsCN2bDMNnuwK7p/To3sdRAx/cQJeHXvwFXQLzwX39EFkWLOptts4W+1hWt7IAtGk4Y+FNpEBqt6Aq5ftfljlxTstyVkUzBIzIv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491198; c=relaxed/simple;
	bh=5JQCvwv/sfSIoz1mB0pVZDJme4kNqklTjhBMJOfqhF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd/7ac49HPJtzQc5lxbPisyx/DjO7i2OFGGB3qz58Usn640tPXBoBRKbCR/7RXl36tvPcn2t2DHMtbeLTDFEdyLfRPVtEeucJYEserMR83hh0oHXWC4CJRVFIUBRuOJaMoYoaWPu/9tJoyzeLrc9tDmIRTfDK3++qA78CeLG2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WbiSfFZK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4548r2L2083805;
	Tue, 4 Jun 2024 03:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717491182;
	bh=Wj/nVcxkWM3YA2IjaUmcY/T/jnro7q5KQBZWjhah9oc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WbiSfFZKvGz0E09+0AV55XVPTMl6J1bNY8pQ8AeSZhfbeQlsLWuWQyB9KDMGeNLvY
	 /6ULHsrIcnT5hVwHpXFcjEyeStSeA7g93IJIghoZeSqtqUiUG9zUdIAUO+exxItsJ9
	 cEbclRyjl/C9mJupM1TfqlLIgrGoPb4oQn9cSavo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4548r2DS083540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 03:53:02 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 03:53:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 03:53:01 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4548qqQi066926;
	Tue, 4 Jun 2024 03:52:57 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to am62p-j722s-common-{}.dtsi
Date: Tue, 4 Jun 2024 14:22:46 +0530
Message-ID: <20240604085252.3686037-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604085252.3686037-1-s-vadapalli@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
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
reusing the existing k3-am62p-{mcu,main,wakeup}.dtsi files for J722S SoC,
rename them to indicate that they are shared with J722S SoC.

The peripherals that are not shared will be moved in the upcoming patches
to the respective k3-{soc}-{mcu,main,wakeup}.dtsi files without "common" in
the filename, emphasizing that they are not shared.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
---
v4:
https://lore.kernel.org/r/20240601121554.2860403-2-s-vadapalli@ti.com/
Changes since v4:
- Based on Andrew's feedback at:
  https://lore.kernel.org/r/086fa11e-10f8-463d-8966-1a33a52a3146@ti.com/
  MCU was retained as-is while main and wakeup were changed to MAIN and
  WAKEUP in the respective shared files.
- Newline has been added between the file description and the Copyright
  in all the files.
- Collected Acked-by tag since these changes have been made.

 .../{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} | 3 ++-
 .../{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi}   | 3 ++-
 ...-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} | 3 ++-
 .../dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi}    | 6 +++---
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                       | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)
 rename arch/arm64/boot/dts/ti/{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} (99%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
 rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)

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
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
similarity index 97%
rename from arch/arm64/boot/dts/ti/k3-am62p.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
index 94babc412575..d85d05e0792a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
@@ -120,6 +120,6 @@ cbass_wakeup: bus@b00000 {
 };
 
 /* Now include peripherals for each bus segment */
-#include "k3-am62p-main.dtsi"
-#include "k3-am62p-mcu.dtsi"
-#include "k3-am62p-wakeup.dtsi"
+#include "k3-am62p-j722s-common-main.dtsi"
+#include "k3-am62p-j722s-common-mcu.dtsi"
+#include "k3-am62p-j722s-common-wakeup.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
index 41f479dca455..b7bb04a7968f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
@@ -8,7 +8,7 @@
 
 /dts-v1/;
 
-#include "k3-am62p.dtsi"
+#include "k3-am62p-j722s-common.dtsi"
 
 / {
 	cpus {
-- 
2.40.1


