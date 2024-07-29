Return-Path: <linux-kernel+bounces-265210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409EC93EE02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC36E281796
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DFA126F1A;
	Mon, 29 Jul 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hanMhqVr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66638563E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236842; cv=none; b=cIwX3UQNLGfpzJpatiMghqmJJhutgXdAks3lYivHWFuJMWmvy9UkKNna8kbw8VNMxxIovcsO30be4QQvKcBKu6mDBvniTzQWzjjYfKEM6cSEEo4CbJzzMuz9IRrdhDGQhdBq/Afnrzsby+FltyFKET0yqPdtAG1bbI1gG0UE/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236842; c=relaxed/simple;
	bh=cNR7aeg65TsGA3e44kaxGzl/Q7whcBFLFl/bGD4/iqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdYuG2VGvNtnPrthC+wpwOnVjS8UOELaAj0i2p69g4h4EMnRLTanZ+dXI7dC0MXdNNYzlrrTI+E82185+KWM3aN1f5EmBVMhgXOrYE3KKbuXyNHxfqqwkrIvj3ogxLSg0zRGzin5ufJOWPxcG5HXObUOXsuwxTzGu547GAudQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hanMhqVr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236840; x=1753772840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNR7aeg65TsGA3e44kaxGzl/Q7whcBFLFl/bGD4/iqc=;
  b=hanMhqVrb0y+VTo2suYiEd8/z+wqbdeATcuObflSdAFSaddXmTMpj9Af
   RQyv2OGcx6K6yYV/tIpGQgnyfJmYI6x/ar0tHJdn4mjQatcNHLIY70Q7o
   ced+9SpPUcpX2cingHOncvJLJ9YbzTO3X/c602NgyTqDiwDxDw4CCa9Iq
   MncZ7K224IynrHCqEMm8q5KtXxW26xU13Fsj1BadOjv4ZontiaHy15mGU
   6gSEEa9dJ0Mv4au22vEBoTAsUNi14vPtEYAjdNEuMPhRNZFABMy9b778r
   UdeHP3Q0VRnydfdMOVzLfRUdZFouWoLqawo0oERu+4equ/MuVlv1mWvUD
   Q==;
X-CSE-ConnectionGUID: mu7Bu/86R6+7o/RTnFghuQ==
X-CSE-MsgGUID: /kT5rc6tT/CPxgB0IH+RkQ==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="32596830"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:07:10 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:07:08 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v6 07/27] ARM: at91: pm: add sam9x7 SoC init config
Date: Mon, 29 Jul 2024 12:37:05 +0530
Message-ID: <20240729070705.1990557-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Updated Reviewed-by tag.
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


