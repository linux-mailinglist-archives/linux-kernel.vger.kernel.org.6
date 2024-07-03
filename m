Return-Path: <linux-kernel+bounces-239253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B0E92588E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7943E28502C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861416191E;
	Wed,  3 Jul 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sfc73m6k"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87B15CD7A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002452; cv=none; b=QMHikbJ0saMWQSznl0M28R4FwwaWHcdVKDco88xjO0Bob46P6RnOE7cyA+lBsJAuJb2AadEts5TMkFQkzUvD8b9QYrnwvJzo5S0mTZMZtpGg7DRtyzt7z9b+NSfMM6uEhrBdfRJUl+25KSUrV+mGPbuPy2fg67xJHUgv+dU3v4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002452; c=relaxed/simple;
	bh=tF97RZEDc1Pj4JTtRtwDGPy7ecJ57nNiFKkGjXuJBrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jufaX9bQUO7q8rTXpbJlQRsdG+JmmcBSNgFb/VR91dayX+SHOcmfUWD53yjbywgxSxSaLzKsRh0fuLTdO2UGPa0wO/7ASCSQatNlRFq6vvinXJZ3HDr1p6kPb2CMLsNtBs4p0uqnPSpNkNB0feUc37HIAg95Hb5DFegMrefwAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sfc73m6k; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002451; x=1751538451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tF97RZEDc1Pj4JTtRtwDGPy7ecJ57nNiFKkGjXuJBrc=;
  b=sfc73m6kQFhVY7SzM9JMNo9J0tDNyjKuyaAT74sNGxkU762mkQaDMOJ8
   68lB4IEt5L2oaanGOmXc3Od8+yd4KXrZiYz0eqGNgpxasFCL3HgMOcDTI
   xf0VHuo4OoaNYJ+hC+Ao/IeIxFGXLcysKRyKwNGWI5x0tTxVrvZUR+ABB
   SMvjauTLHyPzTiGnPV7TGrZw8MoeQbL6+alHpyJC+KgNoPX/AK9F28NqB
   /ZvVoDqSKYg+H3j/9610Aj+ZRaK1zM1eNlrbctGRaHi/gsZinm6j7MOCI
   sqketoxeu4hsiI1P2nPaMFrM2pDUuTH3ZGIbRuDOaw1xBo8TI1iPKMp/Q
   Q==;
X-CSE-ConnectionGUID: sY2/M6/DSDaC/EbwViKWug==
X-CSE-MsgGUID: rdX+l/tcQMyaUKXtMabirg==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="31414857"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:27:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:27:02 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:26:59 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Claudiu Beznea
	<claudiu.beznea@microchip.com>
Subject: [PATCH v5 04/27] ARM: at91: pm: add support for sam9x7 SoC family
Date: Wed, 3 Jul 2024 15:56:53 +0530
Message-ID: <20240703102653.195483-1-varshini.rajendran@microchip.com>
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

Add support and pm init config for sam9x7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Changes in v5:
- Removed usb related ids.
- Added sam9x7 specific rtc, rtt compatibles instead of sam9x60.
- Removed gmac id.
- Removed a blank line.
---
 arch/arm/mach-at91/generic.h |  2 ++
 arch/arm/mach-at91/pm.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c3960a8b3eb..acf0b3c82a30 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -12,6 +12,7 @@
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9_pm_init(void);
 extern void __init sam9x60_pm_init(void);
+extern void __init sam9x7_pm_init(void);
 extern void __init sama5_pm_init(void);
 extern void __init sama5d2_pm_init(void);
 extern void __init sama7_pm_init(void);
@@ -19,6 +20,7 @@ extern void __init sama7_pm_init(void);
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9_pm_init(void) { }
 static inline void __init sam9x60_pm_init(void) { }
+static inline void __init sam9x7_pm_init(void) { }
 static inline void __init sama5_pm_init(void) { }
 static inline void __init sama5d2_pm_init(void) { }
 static inline void __init sama7_pm_init(void) { }
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 345b91dc6627..c0c861e1b8c1 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -233,6 +233,13 @@ static const struct of_device_id sama7g5_ws_ids[] = {
 	{ /* sentinel */ }
 };
 
+static const struct of_device_id sam9x7_ws_ids[] = {
+	{ .compatible = "microchip,sam9x7-rtc",		.data = &ws_info[1] },
+	{ .compatible = "microchip,sam9x7-rtt",		.data = &ws_info[4] },
+	{ .compatible = "microchip,sam9x7-gem",		.data = &ws_info[5] },
+	{ /* sentinel */ }
+};
+
 static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 {
 	const struct wakeup_source_info *wsi;
@@ -1362,6 +1369,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
+	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
 	{ /* sentinel */ },
 };
 
@@ -1499,6 +1507,27 @@ void __init sam9x60_pm_init(void)
 	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
 }
 
+void __init sam9x7_pm_init(void)
+{
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0,
+	};
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SOC_SAM9X7))
+		return;
+
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
+
+	at91_pm_init(NULL);
+
+	soc_pm.ws_ids = sam9x7_ws_ids;
+	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
+}
+
 void __init at91sam9_pm_init(void)
 {
 	int ret;
-- 
2.25.1


