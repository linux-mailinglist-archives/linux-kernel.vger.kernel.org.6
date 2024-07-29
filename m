Return-Path: <linux-kernel+bounces-265215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25693EE0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CA5B222E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D87136664;
	Mon, 29 Jul 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EBT6V+oR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA012FF65;
	Mon, 29 Jul 2024 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236880; cv=none; b=YB+4YKyeraPG3JNYPTsB5SHlYnZFMgBwDpfV92tss8L4sY0vGdl8YRgPttqXmVCPOFlSIuWinifX1T5Hr9GvFCipUzVJJZ+X9Hb13so0hsJsiRjpHVrj2TQyXDxhfrZZmnEqAt5GE99rDE/vc13iK+6ntk1eYJ6bt14N5uT+IPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236880; c=relaxed/simple;
	bh=q5323n++TaWWMADTjdvqcpdyQh2QIVsYWT8VC7rVzdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyiYX6vGr+kDgrR2CNMrpHAB42a94IdBSbJfrWcMoJerl8m3ZNX+uOoeG1pW4szdHe6GN7+siXPSeUXZu7kwkNDfUr0DpV5/e/EHzfkvzYIFUkYFgjWk5SNaCPbO8w9hJhiMdBbxnZtOsAqK874VdQKhPZrjtNVf0p+lAmDouRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EBT6V+oR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236879; x=1753772879;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=q5323n++TaWWMADTjdvqcpdyQh2QIVsYWT8VC7rVzdM=;
  b=EBT6V+oRa81euc875o0rY1XywVcC6ABB/6Wg7IDk9wI6GqkvQ0i8Us2p
   ratwGa/UGRfamGert5cd+QS6pB6Vo/DOHffqa1/MmgDRchHpTE0D5+heW
   0aF8OnP1yED3aLIE+lBSmviSC6LGGb9skxJZLbt93CFX0SptosaHjTtNg
   tRERAiP1cebd43atqNNYJxzMaG0un+oj8+84swFTlRZeGPz2XjiWkg95X
   C54w4nGvyLaPbQ8ZXp2jiv8L9zh5piehJu0TW0IbEcQ9W0pdyWoxizdAp
   O/w2GlG/3hyiCTMvDlN4mX+EEZHPhr2PyXi8l1/4516OhsaZsj9NdOZCX
   Q==;
X-CSE-ConnectionGUID: R9YWgj/LTvO//sJgAksALA==
X-CSE-MsgGUID: CMKpmI9kR26ayQxAfUj0AA==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30454114"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:07:45 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:07:42 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 11/27] clk: at91: clk-sam9x60-pll: re-factor to support individual core freq outputs
Date: Mon, 29 Jul 2024 12:37:37 +0530
Message-ID: <20240729070737.1990756-1-varshini.rajendran@microchip.com>
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

SAM9X7 SoC family supports different core output frequencies for
different PLL IDs. To handle the same in the PLL driver, a separate
parameter core_output is added. The sam9x60 and sama7g5 SoC PMC drivers
are aligned to the PLL driver by adding the core output freq range in
the PLL characteristics configurations.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Updated Reviewed-by tag
---
 drivers/clk/at91/clk-sam9x60-pll.c | 12 ++++++------
 drivers/clk/at91/pmc.h             |  1 +
 drivers/clk/at91/sam9x60.c         |  7 +++++++
 drivers/clk/at91/sama7g5.c         |  7 +++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index ff65f7b916f0..b0314dfd7393 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -23,9 +23,6 @@
 #define UPLL_DIV		2
 #define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
 
-#define FCORE_MIN		(600000000)
-#define FCORE_MAX		(1200000000)
-
 #define PLL_MAX_ID		7
 
 struct sam9x60_pll_core {
@@ -194,7 +191,8 @@ static long sam9x60_frac_pll_compute_mul_frac(struct sam9x60_pll_core *core,
 	unsigned long nmul = 0;
 	unsigned long nfrac = 0;
 
-	if (rate < FCORE_MIN || rate > FCORE_MAX)
+	if (rate < core->characteristics->core_output[0].min ||
+	    rate > core->characteristics->core_output[0].max)
 		return -ERANGE;
 
 	/*
@@ -214,7 +212,8 @@ static long sam9x60_frac_pll_compute_mul_frac(struct sam9x60_pll_core *core,
 	}
 
 	/* Check if resulted rate is a valid.  */
-	if (tmprate < FCORE_MIN || tmprate > FCORE_MAX)
+	if (tmprate < core->characteristics->core_output[0].min ||
+	    tmprate > core->characteristics->core_output[0].max)
 		return -ERANGE;
 
 	if (update) {
@@ -669,7 +668,8 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			goto free;
 		}
 
-		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
+		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core,
+							characteristics->core_output[0].min,
 							parent_rate, true);
 		if (ret < 0) {
 			hw = ERR_PTR(ret);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 0f52e80bcd49..bb9da35198d9 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -75,6 +75,7 @@ struct clk_pll_characteristics {
 	struct clk_range input;
 	int num_output;
 	const struct clk_range *output;
+	const struct clk_range *core_output;
 	u16 *icpll;
 	u8 *out;
 	u8 upll : 1;
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index e309cbf3cb9a..db6db9e2073e 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -26,10 +26,16 @@ static const struct clk_range plla_outputs[] = {
 	{ .min = 2343750, .max = 1200000000 },
 };
 
+/* Fractional PLL core output range. */
+static const struct clk_range core_outputs[] = {
+	{ .min = 600000000, .max = 1200000000 },
+};
+
 static const struct clk_pll_characteristics plla_characteristics = {
 	.input = { .min = 12000000, .max = 48000000 },
 	.num_output = ARRAY_SIZE(plla_outputs),
 	.output = plla_outputs,
+	.core_output = core_outputs,
 };
 
 static const struct clk_range upll_outputs[] = {
@@ -40,6 +46,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.input = { .min = 12000000, .max = 48000000 },
 	.num_output = ARRAY_SIZE(upll_outputs),
 	.output = upll_outputs,
+	.core_output = core_outputs,
 	.upll = true,
 };
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 91b5c6f14819..e6eb5afba93d 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -116,11 +116,17 @@ static const struct clk_range pll_outputs[] = {
 	{ .min = 2343750, .max = 1200000000 },
 };
 
+/* Fractional PLL core output range. */
+static const struct clk_range core_outputs[] = {
+	{ .min = 600000000, .max = 1200000000 },
+};
+
 /* CPU PLL characteristics. */
 static const struct clk_pll_characteristics cpu_pll_characteristics = {
 	.input = { .min = 12000000, .max = 50000000 },
 	.num_output = ARRAY_SIZE(cpu_pll_outputs),
 	.output = cpu_pll_outputs,
+	.core_output = core_outputs,
 };
 
 /* PLL characteristics. */
@@ -128,6 +134,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 	.input = { .min = 12000000, .max = 50000000 },
 	.num_output = ARRAY_SIZE(pll_outputs),
 	.output = pll_outputs,
+	.core_output = core_outputs,
 };
 
 /*
-- 
2.25.1


