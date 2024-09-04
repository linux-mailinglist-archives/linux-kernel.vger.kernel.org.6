Return-Path: <linux-kernel+bounces-315480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2C96C32B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA0E1F27A56
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169C1E1A26;
	Wed,  4 Sep 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y5qUQemT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D371D3643;
	Wed,  4 Sep 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465354; cv=none; b=E9l5XRYkqaffmM9ZGBH2aYzOHnCmuz61IVGJcu7Z+F1k4u8jE27ELTlIJi1j3Fh/7CtIY3ewHgiDjLcC47RQ2WidPapPR0qPyfwfTCLK4Y8z1USiwEv3D/yKcjyP+JtXRFl6AWsMRYHhrvWnb6/BpkJZ4AgWK8esunbZ4KToGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465354; c=relaxed/simple;
	bh=SOPsnkhwPhbTqIhL+AfAja6IVOaQyvZoZM6IJCh1A80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uo3z1fjeQT8WN6OqbRd0TldIAqYwaEQCMoX543qS+7qrgWrRsQLlC4DqjoZk9bB0+oP3Wu3PuHQnVMoeGkUsH3Mg5ZK+UFNc2WbcLgd02SJ8JITQA6MwZJfX7Bp0Voblovx7bzlLi0rUESyfm64DPKgBa8h9N9QMco2aFckW5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y5qUQemT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725465351; x=1757001351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOPsnkhwPhbTqIhL+AfAja6IVOaQyvZoZM6IJCh1A80=;
  b=y5qUQemT+MZkfhyIWFoVUCRwzv2eJZD5WtAQZF9/n6PFhtNfOuNCnCDk
   3TSxo25a5V4odmOKCy2ce7iPt664iCv0faD+7HyMZye7hht8fO4RRhgGL
   tqqBl00SajvjQ0EfQjTxnOxdpIypc0UA06fouXi2316BGlavFGiH/veaU
   q7dLW7caI8u907Vs63hvRjvrqJy2jDX4jmskHV+glBWUcHwcED65le5Wu
   qA3phbN5M+YmNCkPk9apu8k5B3dl1w1BVqqlrnZaB5SWz8wnrCV5iu4wp
   OcJxXvkC+VZGJG1ipBf0c19ehNbWy0eLQXsEfTPPWLtKnH9PG6XwUYWjd
   A==;
X-CSE-ConnectionGUID: xaJg1LqHT3SppKCUBnqXjA==
X-CSE-MsgGUID: 7BkpScBLQf6tkOh8whaUXQ==
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="31232731"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 08:55:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 08:55:17 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Sep 2024 08:55:17 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Ryan
 Wanner" <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 2/3] clk: at91: clk-sam9x60-pll: increase maximum amount of plls
Date: Wed, 4 Sep 2024 08:54:12 -0700
Message-ID: <370cc48eeb3dbec796e17c1af9bff2c10de331bb.1725392645.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725392645.git.Ryan.Wanner@microchip.com>
References: <cover.1725392645.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Increase maximum amount of PLLs to 9 to support SAMA7D65 SoC PLL
requirements.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index fda041102224..cefd9948e103 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -23,7 +23,7 @@
 #define UPLL_DIV		2
 #define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
 
-#define PLL_MAX_ID		7
+#define PLL_MAX_ID		9
 
 struct sam9x60_pll_core {
 	struct regmap *regmap;
-- 
2.43.0


