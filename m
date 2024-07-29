Return-Path: <linux-kernel+bounces-265214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522F093EE0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66C51F23CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51A12F5A1;
	Mon, 29 Jul 2024 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZdorSugT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B012CDBE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236877; cv=none; b=EVNisa3TEPRJYNvvD+tty+Rz3r+9eUBJp5LL6a1kKyasM8BsYG3jbz6dxR6YnXPdAC9DwK3m1XHaucwWHEn/os/NNomYdVsaJs1bp2gQYv0sxMQSNnQ2wrrJJRa+dliMGAG+aVWaCvc6BKxJ2XKF7MJ0+OzW1yBC7yu0/LY9FjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236877; c=relaxed/simple;
	bh=ypHV6uueMavUZPwxfYeHSzcnYTbC4p42FiuCemTc394=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPnPbcE/EHKCjUwQPLnPRWfcSg3Eq3JRfiWzk2YMJGZVVcaRzXY+I1s4G7hk/G/7Nr0WW/NwaocqSPBW12NKShEmduJOsQjT0nCRbARSwCttXStSUxKL/ewXMqxHbFPb9uri0T54GoalyROjqiFHz/Hwz73Zy9mSrFTWVMrDJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZdorSugT; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236876; x=1753772876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypHV6uueMavUZPwxfYeHSzcnYTbC4p42FiuCemTc394=;
  b=ZdorSugT+XV2RrjhtCBBFhJPGGDbMJjRPIJuLufXozU7DKwGG5rp/AxE
   5UTX3GS7HwteUO0roSZw4w6hNhd0GgmagedR5L5WOYCfMwZmUFH22/7xa
   e2NMetlmSpceDTXZduC8P4LzwWG0zoI+f3Ta6AhHgiDoh/XCkMHBh296+
   qEA2RYKgRulQz9+k/RpTCm0xnLkqLGjuDHIrZkJVPMgJsiXAW4SwdJzhy
   IIAkLlYvNHMC/vNhNuTL86Geh3lWpJrLDyBhCmGPxJlWSuj+41rPl8UVs
   kZN0dQiVvEP/WXl29PGjzlK1PKqT9bxuKVyt840ADLt2hwX/j9nbgWPVk
   A==;
X-CSE-ConnectionGUID: 4drqvErnRjiW0P2YP0GX4Q==
X-CSE-MsgGUID: bAf4TAM+RQO8jYU24eamcg==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="29796723"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:07:16 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:07:14 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v6 08/27] ARM: at91: add support in SoC driver for new sam9x7
Date: Mon, 29 Jul 2024 12:37:11 +0530
Message-ID: <20240729070711.1990605-1-varshini.rajendran@microchip.com>
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

Add support for SAM9X7 SoC in the SoC driver.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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


