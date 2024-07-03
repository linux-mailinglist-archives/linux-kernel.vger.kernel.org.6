Return-Path: <linux-kernel+bounces-239254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD561925882
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE34B276F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B600172791;
	Wed,  3 Jul 2024 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NFQO5vSX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AA167DBD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002455; cv=none; b=bxWxc5DpGf5/MqUq6zSCQ01lkTP2ro6z9bB40kC3Hxl+0xgkZdgWVQonUritT7MertTEY3T5gE+FgeNro7kFF1h53bWScIuTPUfjMr4PFb0S9VXIA/gWpLoC11xApsOWU0ttCiWedMpRA3s8hNTMV4nN3i6x0S4CzUkVQdDAiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002455; c=relaxed/simple;
	bh=3KQ5c+sR4gULel13+dJgDCHrPyjdJPoEAjnMltcY90w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qv02e5CVTYZdoTeKP530V4DUTzijnPA2telUUV75EYfsJI2qxhAQDkrTz4vhMSLKsiRn4uYQtdmtWMCFBPA1ViHYxSDY/zXoEez0qsIWzkKRkUJedUS5Qah4C/gdCJTIwGteAS9ygwWnJIivMurkYIT6u6BooAUYpTpob+/Qp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NFQO5vSX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002454; x=1751538454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3KQ5c+sR4gULel13+dJgDCHrPyjdJPoEAjnMltcY90w=;
  b=NFQO5vSXLAxaAf20TAuXHJ2TkzRd4vkOF0G4kKyLbTp0m2mHyGgA0vxJ
   YQdBHl5BvkvP5mZBwl6WO3utKtDsqyOz0SbrRrdpWcNSTdjaE8Q8dAWiZ
   ZJgYa9TnG56P/Ae+gvOl0CTxfCXaiBYWl/DISewjgD4IoqGSyvzW7Ciqz
   mcD8P7s77F/n3XVvqviGm6imCAVwUviTTZBVx2z+DMITBTpEjA4swDi8e
   7cWkKmcg6t2L5FwBmH1rJeAiLLe/PDIK7LcALTEJty9dBzbF8au7MpiZY
   zXP2KmWBXbKQYdk7MNNSju7ohg2BB/pezq13Vi2G6JJYySZsCscwr2Kaw
   g==;
X-CSE-ConnectionGUID: 6if5lKZrRRahkqLSM+7f7Q==
X-CSE-MsgGUID: 5SgJzZHDRgi7Lm5DfMZR1Q==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="196197029"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:27:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:27:14 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:27:11 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 06/27] ARM: at91: add support in SoC driver for new sam9x7
Date: Wed, 3 Jul 2024 15:57:08 +0530
Message-ID: <20240703102708.195612-1-varshini.rajendran@microchip.com>
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

Add support for SAM9X7 SoC in the SoC driver.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Changes in v5:
- Changed the RAM size in bytes.
- Alphanumerically sorted the entries.
- Sorted SoC entries by name and size.
---
 drivers/soc/atmel/soc.c | 23 +++++++++++++++++++++++
 drivers/soc/atmel/soc.h |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index cc9a3e107479..2a42b28931c9 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -101,6 +101,29 @@ static const struct at91_soc socs[] __initconst = {
 		 AT91_CIDR_VERSION_MASK, SAM9X60_D6K_EXID_MATCH,
 		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
 #endif
+#ifdef CONFIG_SOC_SAM9X7
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
+		 "sam9x70", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
+		 "sam9x72", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 16MB DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 64MB DDR2 SiP", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 125MB DDR3L SiP ", "sam9x7"),
+	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
+		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+		 "sam9x75 250MB DDR3L SiP", "sam9x7"),
+#endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAMA5D21CU_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 7a9f47ce85fb..2c78e54255f7 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -44,6 +44,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
+#define SAM9X7_CIDR_MATCH		0x09750020
 #define SAMA7G5_CIDR_MATCH		0x00162100
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
@@ -66,6 +67,14 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAM9X60_D1G_EXID_MATCH		0x00000010
 #define SAM9X60_D6K_EXID_MATCH		0x00000011
 
+#define SAM9X70_EXID_MATCH		0x00000005
+#define SAM9X72_EXID_MATCH		0x00000004
+#define SAM9X75_D1G_EXID_MATCH		0x00000018
+#define SAM9X75_D2G_EXID_MATCH		0x00000020
+#define SAM9X75_D1M_EXID_MATCH		0x00000003
+#define SAM9X75_D5M_EXID_MATCH		0x00000010
+#define SAM9X75_EXID_MATCH		0x00000000
+
 #define SAMA7G51_EXID_MATCH		0x3
 #define SAMA7G52_EXID_MATCH		0x2
 #define SAMA7G53_EXID_MATCH		0x1
-- 
2.25.1


