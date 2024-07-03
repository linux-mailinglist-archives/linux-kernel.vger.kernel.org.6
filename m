Return-Path: <linux-kernel+bounces-239252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6BA925886
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF58328E63E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07662156F28;
	Wed,  3 Jul 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XxkdtgM7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6B16F84F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002439; cv=none; b=Zjzb14L/Qqk5NFIes4V7wn8uurWmQeoH3YEwEHRy6kjgkMs2xPjanlAg/bQNDYlGk5SCO8Nx1TG2T6H7K0PyVaOwB8sbh7kbzgjjEYWZ6RagUxpJhW4KHvHG8V9eTYWdlD+Jz417hR0dVVIKRaSDaqsqpJK5eYOuftlYOByDPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002439; c=relaxed/simple;
	bh=Lv0sEaA8F2c8HiyRvT8WYHleiLqbWNB02c+WFOle1GY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLRWEvGt/TBHt2SkhwDN/UfqWa68SL8qBhIlKfR34TzIYEEqbkiKjfGq6ObZjMNCiw3BDJShMOCT+XvFFQjKOyaitImFIFEU3HNwk0p+AMWckYNTAfPqAYX8lM1vpf4BaRZmJNiZXxl3Hs0NPlOpucaBGmf3JpS+cV9vMYdAFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XxkdtgM7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002436; x=1751538436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lv0sEaA8F2c8HiyRvT8WYHleiLqbWNB02c+WFOle1GY=;
  b=XxkdtgM7fvcat09cgdO4MlmqijBW8QyI1coXQ2qc1g0AOe0PwP/SPNKX
   rDbJ78+A5J9tCMLrGYPGs1OwLjXVJ5j+jjY1310CkFu0M9YYDHZbhY/Mj
   sYVZsmx+fkhlHpf6JXKV7DIVlY8QxCNBIwSV/HHwlXsB6/B8WUrfGUIKT
   ZS+thcaxnewhiVjUudLMG3PR4XhKVY0nvgyKNH0YgN7MM1dcD8MvgyqlP
   SZRWPTRdlwFdgrCKFv4XdRJHHBEHcV6YJviDt9q8crNwU+z57Q7Ym6apI
   zoC54EhZ7iCVCloRtP6+z83rOC3845CRGtd8Qs7pJSqAZwJH4NSj1ntBc
   A==;
X-CSE-ConnectionGUID: O6jm4qbsRBydYsAuvGKY7w==
X-CSE-MsgGUID: LzxUdgSRQ8uM9Ewfl3OogQ==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28772336"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:27:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:27:08 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:27:05 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v5 05/27] ARM: at91: pm: add sam9x7 SoC init config
Date: Wed, 3 Jul 2024 15:57:02 +0530
Message-ID: <20240703102702.195564-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add SoC init config for sam9x7 family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v5:
- Removed unnecessary header file.
- Added a space in the return type for clarity.
---
 arch/arm/mach-at91/Makefile |  1 +
 arch/arm/mach-at91/sam9x7.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/arm/mach-at91/sam9x7.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 794bd12ab0a8..7d8a7bc44e65 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
+obj-$(CONFIG_SOC_SAM9X7)	+= sam9x7.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o sam_secure.o
 obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
diff --git a/arch/arm/mach-at91/sam9x7.c b/arch/arm/mach-at91/sam9x7.c
new file mode 100644
index 000000000000..e1ff30b5b09b
--- /dev/null
+++ b/arch/arm/mach-at91/sam9x7.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Setup code for SAM9X7.
+ *
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+
+#include "generic.h"
+
+static void __init sam9x7_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
+
+	sam9x7_pm_init();
+}
+
+static const char * const sam9x7_dt_board_compat[] __initconst = {
+	"microchip,sam9x7",
+	NULL
+};
+
+DT_MACHINE_START(sam9x7_dt, "Microchip SAM9X7")
+	/* Maintainer: Microchip */
+	.init_machine	= sam9x7_init,
+	.dt_compat	= sam9x7_dt_board_compat,
+MACHINE_END
-- 
2.25.1


