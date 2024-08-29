Return-Path: <linux-kernel+bounces-307326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36597964BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BDF2830B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544751B5832;
	Thu, 29 Aug 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DmgY2XiA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A21B531B;
	Thu, 29 Aug 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949795; cv=none; b=bpumWXi/vKgeTWDY9Gv/AhN8a/qoV+aeFu72Z96YYBOiZ2CEZOUeaLvi71HPGzjRS1GAMy+s/k4IfGh68H/M4G0rkiUMkNt1MaRcxezD/z4uQOUQ+NMJCDeDaXcallx2l3Toezi2Qcs4TN/lhuvlHDt9kjsJrMLWUrAmfDy1xSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949795; c=relaxed/simple;
	bh=SOPsnkhwPhbTqIhL+AfAja6IVOaQyvZoZM6IJCh1A80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TW8jAgHD5DnXGl5scMKGB00EPU9pkLkf67YlIly9nX0skuQIHVReBFhC4CTxipYoQuIiTFi9gwQrE8x/j5NYUuTmzTrDTgYqAnaQhL/cgyXxdUbTnzU+xrM/tw4uTyApMw9DdMpeNpPc1KtVh6pwoaFVV12xfxL1O7VL0DITP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DmgY2XiA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724949794; x=1756485794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOPsnkhwPhbTqIhL+AfAja6IVOaQyvZoZM6IJCh1A80=;
  b=DmgY2XiAQhoXG1mtW1bjEGcLOfZLfsG9Nc476DDkqXPZqIieYXv2pSmT
   MbbNe4L3adTtziJd5F/TJstUmsGhWJPIcLZhC131cqtmDiHHmz03RyOw9
   ryn5wNo1FZaCj0gqgMi8E0B4z/I7zXMORSiud1fBdpdMgET5rzMGGeR3H
   3MKAuRT1S0Yctme5ZXvHNnSMk1g4w3BZoIo7cdgv/8zBliYaW5+RdVR5o
   MPMswkOOucfyXOGeLDTw+63DCnbSCM4GlrmZxMdcJ0cKhZw3t973mrjBF
   4yDHXw36TMNkBF1rsu+TzpOeTYzufZvAAgfxcFbz0f3HZ3V4iWYswEFK/
   w==;
X-CSE-ConnectionGUID: isCbYj0aQvu8z3ziIW0jJQ==
X-CSE-MsgGUID: CE2geJv7Sk+v0FgbadjtoQ==
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="262007773"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 09:43:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 09:42:51 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Aug 2024 09:42:51 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 3/3] clk: at91: clk-sam9x60-pll: increase maximum amount of plls
Date: Thu, 29 Aug 2024 09:42:27 -0700
Message-ID: <cd134c8d9e68c79b798e91f8cce427169b9e6184.1724948760.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724948760.git.Ryan.Wanner@microchip.com>
References: <cover.1724948760.git.Ryan.Wanner@microchip.com>
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


