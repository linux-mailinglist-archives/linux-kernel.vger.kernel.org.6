Return-Path: <linux-kernel+bounces-265220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D0993EE16
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DBC1C21DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842C13AA41;
	Mon, 29 Jul 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="imAOOaKN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FA12FF65;
	Mon, 29 Jul 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236909; cv=none; b=Yz0wxxHEfNLMsxMUftsdhyBppmXvayzjxhzBAN4WdOlLirdIn6MOwrMnn7NszZY3WYA08CNop+2+5dS4c9T+OHgnOXTkFaJQ3hLZWprnQX7YLGDuFy47h517B3kX1iDZ2KUuniqeGXqu0a3j5DPhG/5CL567ojPV4pDzkDtJ9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236909; c=relaxed/simple;
	bh=Di2ZGDrA79I1MXXqZzapDThApEyoad0ZpQCNWRq3Atk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCKsetjz3J9WZ0zFCsINa32yFZLGioTFGdqsJ0MlLsvrIPz7u4R3A+6/0+so+JF2k9M3x9RipTy69eKF24eZZEkqynastuE3VMwarmUOoPG4AGKcDmL2/WMah65kV8NvJ5OXwJKUbQPHNcf3NrPsyEwjkz2lVNsT5pvzifUuTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=imAOOaKN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236907; x=1753772907;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Di2ZGDrA79I1MXXqZzapDThApEyoad0ZpQCNWRq3Atk=;
  b=imAOOaKNbjH5x6PCXFXA20lSPTNabqRjkZA/f7Fi0WaLNc12QSc64fEz
   XBJqzv6peDqQHVpXEr7o7j4LbGwLVS4JzpbRHJGu095odFKkILxmnXMcy
   MEDW8SzOC2u1aUu9EwKldXoGB57vGT3mE4nJH+R/Og9OiZOK55+CDBbRL
   0GW8kYKkZtx3dLoP1i7q6ASCe5tGpLA9BUOR23jP+R4ojnP6DEvcCt+mc
   2qX9zK+F82ew+VM1WS4V4ZqGVXKqtI6rFW/FIU00aovRrs7VQQ/iknnxw
   iIa/AGktGDsviA4eBETeoSnCyB873GWut6aRktmTPxgUZrgNSznM5u3gY
   w==;
X-CSE-ConnectionGUID: CDCB7FyvSBaPa6/JesHbIg==
X-CSE-MsgGUID: UG8SIdJFTn6LGmjOGUGT7w==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="32596908"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:08:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:07:52 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:07:49 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 12/27] clk: at91: sam9x7: add support for HW PLL freq dividers
Date: Mon, 29 Jul 2024 12:37:46 +0530
Message-ID: <20240729070746.1990805-1-varshini.rajendran@microchip.com>
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

Add support for hardware dividers for PLL IDs in sam9x7 SoC. The system
PLL - PLLA and the system PLL divided by 2 - PLLADIV2 with PLL ID 0 and
4 respectively, both have a hardware divider /2. This has to be taken into
account in the software to obtain the right frequencies. Support for the
same is added in the PLL driver.

fcorepllack -----> HW Div = 2 -+--> fpllack
                               |
                               +--> HW Div = 2 ---> fplladiv2ck

In this case the corepll freq is 1600 MHz. So, the plla freq is 800 MHz
after the hardware divider and the plladiv2 freq is 400 MHz after the
hardware divider (given that the DIVPMC is 0).

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Updated Reviewed-by tag
---
 drivers/clk/at91/clk-sam9x60-pll.c | 30 ++++++++++++++++++++++++++++--
 drivers/clk/at91/pmc.h             |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index b0314dfd7393..fda041102224 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -73,9 +73,15 @@ static unsigned long sam9x60_frac_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct sam9x60_pll_core *core = to_sam9x60_pll_core(hw);
 	struct sam9x60_frac *frac = to_sam9x60_frac(core);
+	unsigned long freq;
 
-	return parent_rate * (frac->mul + 1) +
+	freq = parent_rate * (frac->mul + 1) +
 		DIV_ROUND_CLOSEST_ULL((u64)parent_rate * frac->frac, (1 << 22));
+
+	if (core->layout->div2)
+		freq >>= 1;
+
+	return freq;
 }
 
 static int sam9x60_frac_pll_set(struct sam9x60_pll_core *core)
@@ -432,6 +438,12 @@ static unsigned long sam9x60_div_pll_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST_ULL(parent_rate, (div->div + 1));
 }
 
+static unsigned long sam9x60_fixed_div_pll_recalc_rate(struct clk_hw *hw,
+						       unsigned long parent_rate)
+{
+	return parent_rate >> 1;
+}
+
 static long sam9x60_div_pll_compute_div(struct sam9x60_pll_core *core,
 					unsigned long *parent_rate,
 					unsigned long rate)
@@ -606,6 +618,16 @@ static const struct clk_ops sam9x60_div_pll_ops_chg = {
 	.restore_context = sam9x60_div_pll_restore_context,
 };
 
+static const struct clk_ops sam9x60_fixed_div_pll_ops = {
+	.prepare = sam9x60_div_pll_prepare,
+	.unprepare = sam9x60_div_pll_unprepare,
+	.is_prepared = sam9x60_div_pll_is_prepared,
+	.recalc_rate = sam9x60_fixed_div_pll_recalc_rate,
+	.round_rate = sam9x60_div_pll_round_rate,
+	.save_context = sam9x60_div_pll_save_context,
+	.restore_context = sam9x60_div_pll_restore_context,
+};
+
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 			      const char *name, const char *parent_name,
@@ -725,10 +747,14 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 	else
 		init.parent_names = &parent_name;
 	init.num_parents = 1;
-	if (flags & CLK_SET_RATE_GATE)
+
+	if (layout->div2)
+		init.ops = &sam9x60_fixed_div_pll_ops;
+	else if (flags & CLK_SET_RATE_GATE)
 		init.ops = &sam9x60_div_pll_ops;
 	else
 		init.ops = &sam9x60_div_pll_ops_chg;
+
 	init.flags = flags;
 
 	div->core.id = id;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index bb9da35198d9..91d1c6305d95 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -64,6 +64,7 @@ struct clk_pll_layout {
 	u8 frac_shift;
 	u8 div_shift;
 	u8 endiv_shift;
+	u8 div2;
 };
 
 extern const struct clk_pll_layout at91rm9200_pll_layout;
-- 
2.25.1


