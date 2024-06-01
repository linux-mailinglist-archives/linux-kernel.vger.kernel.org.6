Return-Path: <linux-kernel+bounces-197827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6E8D6FB8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F651C20F4A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E4314F9FC;
	Sat,  1 Jun 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xhMHJO4l"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5F335A7;
	Sat,  1 Jun 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244175; cv=none; b=JEoNq110jQHUfK5RLlQwQOwihp05U4pwA/dAsEo5rm+iChJ0FhQcp74heW/cyDhW2swn4FdtXEfhgyqow2phHueIOGX42tpACZZKCeYBVHQgWlLwWukN1DdPSsifoED2gqgVVcWydpDRa997ivdvYEzR4ZgaGd3MQjvrkK1qFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244175; c=relaxed/simple;
	bh=YQbtDqKskNjMF+zgtEnVxmBnSMyDmmQbOPUAkWECbYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0ZKdVBwuLLXpfL1aFuJ2ofHiH7XvYyNjzY+0FLGNnBfXRw1ZCUdANb3pOIMa4sOFYVIc67JEfATbz1lqrzB3c5kW16VXExNmJrhDxwbOzhWM0C/4VZiOjMnfl1e3fJlwfwRwI01NBGP9RYdagoUI+8mIsOguQyKEPWEkDQY/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xhMHJO4l; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 451CG48n001986;
	Sat, 1 Jun 2024 07:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717244164;
	bh=wPOgx6jvz6CXPqydR8T70MR8eQ6jCHkPssl7vSeN1X4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xhMHJO4lJhyT1ekX1BK8VUDbMBcQQwrsK09ZzDHnc2Iql1yTtYAUQSNb71XEAngWS
	 KRTIdpTj/diz8S04eKLnYbPQ4O2zUnLhEP9WUeHT9dpTPqi0l7k0K0bN/kV8hagZM4
	 a8MDj8OLlHn4dMehk9zXtf/weFnxlT5t487+l6Nw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 451CG4JG046713
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 07:16:04 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 07:16:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 07:16:04 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 451CFtkF009323;
	Sat, 1 Jun 2024 07:16:00 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to am62p-j722s-common-{}.dtsi
Date: Sat, 1 Jun 2024 17:45:48 +0530
Message-ID: <20240601121554.2860403-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601121554.2860403-1-s-vadapalli@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
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
---
No changelog since this patch is introduced in this version of the
series.

 .../{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} | 2 +-
 .../{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi}   | 2 +-
 ...-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} | 2 +-
 .../dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi}    | 6 +++---
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                       | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm64/boot/dts/ti/{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} (99%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
 rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
 rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 900d1f9530a2..ea214f649ebd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree file for the AM62P main domain peripherals
+ * Device Tree file for the main domain peripherals shared by AM62P and J722S
  * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index b973b550eb9d..a5dbaf3ff41b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree file for the AM62P MCU domain peripherals
+ * Device Tree file for the mcu domain peripherals shared by AM62P and J722S
  * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
similarity index 97%
rename from arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index c71d9624ea27..ca493f4e1acd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree file for the AM62P wakeup domain peripherals
+ * Device Tree file for the wakeup domain peripherals shared by AM62P and J722S
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


