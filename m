Return-Path: <linux-kernel+bounces-329371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ABF979077
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E09B22B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5BD1CF5E4;
	Sat, 14 Sep 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvJPvTGr"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361F1CF5DE
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313323; cv=none; b=VN4biwRkvLweDWGg3ZbAbePNCvOBkaIUxDdmCp2c2NFdgDbP5bA85EBhVzIXMsQlvYSlzI/yx4CzCVCVKHnGEI7ipjJN1mpk4cOp7//S4X3s0qZ8Kl4kVSbjfs3RrnVxgIDXM3uP3nMjUlO4/6f0mRD/BFh+D0QHTe2Cx2mkY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313323; c=relaxed/simple;
	bh=gFOjB1IGE7vGt1NEKGCKtZ6+4QQ1lBNJLn+kQw25LwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjypBDc2l7DAKIbaAirqJdx9ZwtLXblDrarD9Cu2WjvfrnGc80wrXGXGqrPq+5u2v09+fRMg+Ua2VN2JPoTaAZhGSmnjGfULlcO/CqvhVg1/yIgX/0lcAmYqsuT11QFqLmtdS/U2sZQ+Y8IOzUW5ngAXC4THzqO8tfvJBZlnKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvJPvTGr; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso66140139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726313321; x=1726918121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9HxPAJshHdDvtOGJE9jxZxcZZCQzRJA0uViSfjtafg=;
        b=FvJPvTGr2W4+LAm9MCftQNKSkgFJmHOXZXQYIQuIhLM7MpQgG9JXO7OcU3agIL7Try
         qj53bsk1y416yJWyWCjgOCcWlh6mjMqauGEYuTs/mEEbhAC9s0oBB9SSg/6gnmA4DZ1l
         6iK5wFZP9A6uBs7tegolvhhu2ZjqJ2IL+sFpypsFfnjIYUcl+EB4E4+D7mcU7U1M7Wml
         5bBDZ2Kk1x+JEtRSXe52zkdGRUIzaXY9B5CT+3AEGp9Vj7VKTqzyBQBiBAcNBcnYJztW
         czZz7KK25T3nU8yjTCP3+BnhHIg28lKfa71wYPhstnRee8WbfiMoye2L9GdeNGWdD2WL
         8I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726313321; x=1726918121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9HxPAJshHdDvtOGJE9jxZxcZZCQzRJA0uViSfjtafg=;
        b=j20UTptboh/DgnwbeDXAEVKd+spsgdlZf1GpcM1Rsq15BdW49wpxQJi/aCE2YmDLot
         Ja+fmpS0w2rKp7V3Cfxwiy7sWQ2j+gH09+x9ink+pW5qo6WU9PSIc3JN6Jrzd+LUgLpI
         NdNi2lUJIgzRWwTGhSTEaEfaakXW3G+Bw/ZMCDSLtgXe0RpKcPBtws0+nnO9Z+9WfZFN
         y66qZmTTVFSHtQfbYpk+XpvoRcP/fVgHURdv2seyEcyE3sZcfTH8cmFPfmz8b+o2cxg8
         bEUzl/52bqx9Fhznhkx1sTv2NRva3RhZywOintMS7qNJ7dIBi9fEi/3YckAp9Zh6+ryR
         A+0w==
X-Forwarded-Encrypted: i=1; AJvYcCVfB5JZJ5vnaYOh9Q5DQObb9dpPaui+gAcLizweuBXqgU//NKG/l7URvSDUE1WPTTP8YYMDkM+/ltv3uhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jJctDJrGZsbzrzJ6zIiTreOvojgCda5NtPstBsWuSXWSZCcu
	huhzPGayjH4+i1wDDWyJCS0DMaN6BfOA58k9CixuEg+xh/y59z3E
X-Google-Smtp-Source: AGHT+IE9iCn2Hniu9fo5kvOOtdcxCYiyTWsa6pOGJTLEz77gy4cXouFI/xiMSphckcnlNd35hZJkrw==
X-Received: by 2002:a05:6e02:12e7:b0:3a0:8eb3:5160 with SMTP id e9e14a558f8ab-3a08eb35230mr38510585ab.11.1726313320714;
        Sat, 14 Sep 2024 04:28:40 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed35572sm350307173.131.2024.09.14.04.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 04:28:40 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Sandor.yu@nxp.com,
	neil.armstrong@linaro.org,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic integer
Date: Sat, 14 Sep 2024 06:27:47 -0500
Message-ID: <20240914112816.520224-4-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240914112816.520224-1-aford173@gmail.com>
References: <20240914112816.520224-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is currently a look-up table for a variety of resolutions.
Since the phy has the ability to dynamically calculate the values
necessary to use the intger divider which should allow more
resolutions without having to update the look-up-table.

If the lookup table cannot find an exact match, fall back to the
dynamic calculator of the integer divider.

Previously, the value of P was hard-coded to 1, this required an
update to the phy_pll_cfg table to add in the extra value into the
table, so if the value of P is calculated to be something else
by the PMS calculator, the calculated_phy_pll_cfg structure
can be used instead without having to keep track of which method
was used.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
V8:  Fix VCO note and remove one goto by using a helper function
V7:  Refactored much of the code to create smaller helper functions
     to eliminate redundant code and improve code flow and comment
     readability.   Any t-b and s-o-b tags removed due to the
     extent of the changes.

V6:  Fix comment typos and remove an unnecesary extra calculation
     by using the cached value.
V5:  No Change
V4:  No Change
V3:  Change size of pll_div_regs to include PHY_REG01 (P)
     Create calculated_phy_pll_cfg to containe the values
     Eliminate the PMS calculation from fsl_samsung_hdmi_phy_configure
     Make the LUT primary and fall back to integer calculator in
     phy_clk_round_rate.
     Check the range right away to ensure it's reaonsable rather than
     trying to find a clock only to learn it's outside the range.
     Overall added notes and comments where stuff may not be intuitive.

V2:  Update phy_clk_round_rate and phy_clk_set_rate to both support
     the integer clock PMS calculator.
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 377 +++++++++++++------
 1 file changed, 270 insertions(+), 107 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 4f6874226f9a..029de69fbeaf 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -16,6 +16,8 @@
 
 #define PHY_REG(reg)		(reg * 4)
 
+#define REG01_PMS_P_MASK	GENMASK(3, 0)
+#define REG03_PMS_S_MASK	GENMASK(7, 4)
 #define REG12_CK_DIV_MASK	GENMASK(5, 4)
 
 #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
@@ -38,281 +40,296 @@
 #define REG34_PLL_LOCK		BIT(6)
 #define REG34_PHY_CLK_READY	BIT(5)
 
-#define PHY_PLL_DIV_REGS_NUM 6
+#ifndef MHZ
+#define MHZ	(1000UL * 1000UL)
+#endif
+
+#define PHY_PLL_DIV_REGS_NUM 7
 
 struct phy_config {
 	u32	pixclk;
 	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
 };
 
+/*
+ * The calculated_phy_pll_cfg only handles integer divider for PMS,
+ * meaning the last four entries will be fixed, but the first three will
+ * be calculated by the PMS calculator.
+ */
+static struct phy_config calculated_phy_pll_cfg = {
+	.pixclk = 0,
+	.pll_div_regs = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00 },
+};
+
+/* The lookup table contains values for which the fractional divder is used */
 static const struct phy_config phy_pll_cfg[] = {
 	{
 		.pixclk = 22250000,
-		.pll_div_regs = { 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
 	}, {
 		.pixclk = 23750000,
-		.pll_div_regs = { 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
 	}, {
 		.pixclk = 24000000,
-		.pll_div_regs = { 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 24024000,
-		.pll_div_regs = { 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
 	}, {
 		.pixclk = 25175000,
-		.pll_div_regs = { 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
 	}, {
 		.pixclk = 25200000,
-		.pll_div_regs = { 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 26750000,
-		.pll_div_regs = { 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
 	}, {
 		.pixclk = 27000000,
-		.pll_div_regs = { 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 27027000,
-		.pll_div_regs = { 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 29500000,
-		.pll_div_regs = { 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 30750000,
-		.pll_div_regs = { 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
+		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
 	}, {
 		.pixclk = 30888000,
-		.pll_div_regs = { 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
+		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
 	}, {
 		.pixclk = 33750000,
-		.pll_div_regs = { 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 35000000,
-		.pll_div_regs = { 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
 	}, {
 		.pixclk = 36000000,
-		.pll_div_regs = { 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 36036000,
-		.pll_div_regs = { 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 40000000,
-		.pll_div_regs = { 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 43200000,
-		.pll_div_regs = { 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 43243200,
-		.pll_div_regs = { 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 44500000,
-		.pll_div_regs = { 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
+		.pll_div_regs = { 0xd1, 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
 	}, {
 		.pixclk = 47000000,
-		.pll_div_regs = { 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
 	}, {
 		.pixclk = 47500000,
-		.pll_div_regs = { 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
 	}, {
 		.pixclk = 50349650,
-		.pll_div_regs = { 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
 	}, {
 		.pixclk = 50400000,
-		.pll_div_regs = { 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 53250000,
-		.pll_div_regs = { 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
+		.pll_div_regs = { 0xd1, 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
 	}, {
 		.pixclk = 53500000,
-		.pll_div_regs = { 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
 	}, {
 		.pixclk = 54000000,
-		.pll_div_regs = { 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 54054000,
-		.pll_div_regs = { 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 59000000,
-		.pll_div_regs = { 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 59340659,
-		.pll_div_regs = { 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
+		.pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
 	}, {
 		.pixclk = 59400000,
-		.pll_div_regs = { 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 61500000,
-		.pll_div_regs = { 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
+		.pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
 	}, {
 		.pixclk = 63500000,
-		.pll_div_regs = { 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 67500000,
-		.pll_div_regs = { 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
 	}, {
 		.pixclk = 70000000,
-		.pll_div_regs = { 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
 	}, {
 		.pixclk = 72000000,
-		.pll_div_regs = { 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 72072000,
-		.pll_div_regs = { 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 74176000,
-		.pll_div_regs = { 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
+		.pll_div_regs = { 0xd1, 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
 	}, {
 		.pixclk = 74250000,
-		.pll_div_regs = { 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
+		.pll_div_regs = { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
 	}, {
 		.pixclk = 78500000,
-		.pll_div_regs = { 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 80000000,
-		.pll_div_regs = { 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 82000000,
-		.pll_div_regs = { 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
+		.pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
 	}, {
 		.pixclk = 82500000,
-		.pll_div_regs = { 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
+		.pll_div_regs = { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
 	}, {
 		.pixclk = 89000000,
-		.pll_div_regs = { 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
 	}, {
 		.pixclk = 90000000,
-		.pll_div_regs = { 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 94000000,
-		.pll_div_regs = { 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
 	}, {
 		.pixclk = 95000000,
-		.pll_div_regs = { 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
 	}, {
 		.pixclk = 98901099,
-		.pll_div_regs = { 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
+		.pll_div_regs = { 0xd1, 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
 	}, {
 		.pixclk = 99000000,
-		.pll_div_regs = { 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
+		.pll_div_regs = { 0xd1, 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
 	}, {
 		.pixclk = 100699300,
-		.pll_div_regs = { 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
 	}, {
 		.pixclk = 100800000,
-		.pll_div_regs = { 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 102500000,
-		.pll_div_regs = { 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
+		.pll_div_regs = { 0xd1, 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
 	}, {
 		.pixclk = 104750000,
-		.pll_div_regs = { 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
+		.pll_div_regs = { 0xd1, 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
 	}, {
 		.pixclk = 106500000,
-		.pll_div_regs = { 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
+		.pll_div_regs = { 0xd1, 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
 	}, {
 		.pixclk = 107000000,
-		.pll_div_regs = { 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
 	}, {
 		.pixclk = 108000000,
-		.pll_div_regs = { 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 108108000,
-		.pll_div_regs = { 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 118000000,
-		.pll_div_regs = { 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 118800000,
-		.pll_div_regs = { 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 123000000,
-		.pll_div_regs = { 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
+		.pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
 	}, {
 		.pixclk = 127000000,
-		.pll_div_regs = { 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 135000000,
-		.pll_div_regs = { 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 135580000,
-		.pll_div_regs = { 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
+		.pll_div_regs = { 0xd1, 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
 	}, {
 		.pixclk = 137520000,
-		.pll_div_regs = { 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
+		.pll_div_regs = { 0xd1, 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
 	}, {
 		.pixclk = 138750000,
-		.pll_div_regs = { 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
+		.pll_div_regs = { 0xd1, 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
 	}, {
 		.pixclk = 140000000,
-		.pll_div_regs = { 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
 	}, {
 		.pixclk = 144000000,
-		.pll_div_regs = { 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 148352000,
-		.pll_div_regs = { 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
+		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
 	}, {
 		.pixclk = 148500000,
-		.pll_div_regs = { 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
+		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
 	}, {
 		.pixclk = 154000000,
-		.pll_div_regs = { 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
+		.pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
 	}, {
 		.pixclk = 157000000,
-		.pll_div_regs = { 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
 	}, {
 		.pixclk = 160000000,
-		.pll_div_regs = { 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
 	}, {
 		.pixclk = 162000000,
-		.pll_div_regs = { 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
+		.pll_div_regs = { 0xd1, 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
 	}, {
 		.pixclk = 164000000,
-		.pll_div_regs = { 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
+		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
 	}, {
 		.pixclk = 165000000,
-		.pll_div_regs = { 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
+		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
 	}, {
 		.pixclk = 180000000,
-		.pll_div_regs = { 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 185625000,
-		.pll_div_regs = { 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
 	}, {
 		.pixclk = 188000000,
-		.pll_div_regs = { 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
 	}, {
 		.pixclk = 198000000,
-		.pll_div_regs = { 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
+		.pll_div_regs = { 0xd1, 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
 	}, {
 		.pixclk = 205000000,
-		.pll_div_regs = { 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
+		.pll_div_regs = { 0xd1, 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
 	}, {
 		.pixclk = 209500000,
-		.pll_div_regs = { 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
+		.pll_div_regs = { 0xd1, 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
 	}, {
 		.pixclk = 213000000,
-		.pll_div_regs = { 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
+		.pll_div_regs = { 0xd1, 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
 	}, {
 		.pixclk = 216000000,
-		.pll_div_regs = { 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 216216000,
-		.pll_div_regs = { 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 237600000,
-		.pll_div_regs = { 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 254000000,
-		.pll_div_regs = { 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
+		.pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 277500000,
-		.pll_div_regs = { 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
+		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
 	}, {
 		.pixclk = 288000000,
-		.pll_div_regs = { 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
+		.pll_div_regs = { 0xd1, 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 297000000,
-		.pll_div_regs = { 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
+		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
 	},
 };
 
@@ -322,7 +339,8 @@ struct reg_settings {
 };
 
 static const struct reg_settings common_phy_cfg[] = {
-	{ PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
+	{ PHY_REG(0), 0x00 },
+	/* PHY_REG(1-7) pix clk specific */
 	{ PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
 	{ PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
 	/* REG12 pixclk specific */
@@ -415,6 +433,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 	       phy->regs + PHY_REG(14));
 }
 
+static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u16 *m, u8 *s)
+{
+	unsigned long best_freq = 0;
+	u32 min_delta = 0xffffffff;
+	u8 _p, best_p;
+	u16 _m, best_m;
+	u8 _s, best_s;
+
+	/*
+	 * Figure 13-78 of the reference manual states the PLL should be TMDS x 5
+	 * while the TMDS_CLKO should be the PLL / 5.  So to calculate the PLL,
+	 * take the pix clock x 5, then return the value of the PLL / 5.
+	 */
+	fout *= 5;
+
+	/* The ref manual states the values of 'P' range from 1 to 11 */
+	for (_p = 1; _p <= 11; ++_p) {
+		for (_s = 1; _s <= 16; ++_s) {
+			u64 tmp;
+			u32 delta;
+
+			/* s must be one or even */
+			if (_s > 1 && (_s & 0x01) == 1)
+				_s++;
+
+			/* _s cannot be 14 per the TRM */
+			if (_s == 14)
+				continue;
+
+			/*
+			 * TODO: Ref Manual doesn't state the range of _m
+			 * so this should be further refined if possible.
+			 * This range was set based on the original values
+			 * in the lookup table
+			 */
+			tmp = (u64)fout * (_p * _s);
+			do_div(tmp, 24 * MHZ);
+			_m = tmp;
+			if (_m < 0x30 || _m > 0x7b)
+				continue;
+
+			/*
+			 * Rev 2 of the Ref Manual states the
+			 * VCO can range between 750MHz and
+			 * 3GHz. The VCO is assumed to be
+			 * Fvco = (M * f_ref) / P,
+			 * where f_ref is 24MHz.
+			 */
+			tmp = (u64)_m * 24 * MHZ;
+			do_div(tmp, _p);
+			if (tmp < 750 * MHZ ||
+			    tmp > 3000 * MHZ)
+				continue;
+
+			/* Final frequency after post-divider */
+			do_div(tmp, _s);
+
+			delta = abs(fout - tmp);
+			if (delta < min_delta) {
+				best_p = _p;
+				best_s = _s;
+				best_m = _m;
+				min_delta = delta;
+				best_freq = tmp;
+			}
+		}
+	}
+
+	if (best_freq) {
+		*p = best_p;
+		*m = best_m;
+		*s = best_s;
+	}
+
+	return best_freq / 5;
+}
+
 static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 					  const struct phy_config *cfg)
 {
@@ -428,13 +523,13 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
 		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
 
-	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
+	/* set individual PLL registers PHY_REG1 ... PHY_REG7 */
 	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
-		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
+		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(1) + i * 4);
 
-	/* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
+	/* High nibble of PHY_REG3 and low nibble of PHY_REG21 both contain 'S' */
 	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
-	       cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
+	       cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
 
 	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
 
@@ -459,34 +554,102 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
 	return phy->cur_cfg->pixclk;
 }
 
-static long phy_clk_round_rate(struct clk_hw *hw,
-			       unsigned long rate, unsigned long *parent_rate)
+/* Helper function to lookup the available fractional-divider rate */
+static const struct phy_config *fsl_samsung_hdmi_phy_lookup_rate(unsigned long rate)
 {
 	int i;
 
+	/* Search the lookup table */
 	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
 		if (phy_pll_cfg[i].pixclk <= rate)
-			return phy_pll_cfg[i].pixclk;
+			break;
+
+	return &phy_pll_cfg[i];
+}
+
+static void fsl_samsung_hdmi_calculate_phy(struct phy_config *cal_phy, unsigned long rate,
+				    u8 p, u16 m, u8 s)
+{
+	cal_phy->pixclk = rate;
+	cal_phy->pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
+	cal_phy->pll_div_regs[1] = m;
+	cal_phy->pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
+	/* pll_div_regs 3-6 are fixed and pre-defined already */
+}
+
+static long phy_clk_round_rate(struct clk_hw *hw,
+			       unsigned long rate, unsigned long *parent_rate)
+{
+	const struct phy_config *fract_div_phy;
+	u32 int_div_clk;
+	u16 m;
+	u8 p, s;
+
+	/* If the clock is out of range return error instead of searching */
+	if (rate > 297000000 || rate < 22250000)
+		return -EINVAL;
+
+	/* Search the fractional divider lookup table */
+	fract_div_phy = fsl_samsung_hdmi_phy_lookup_rate(rate);
 
-	return -EINVAL;
+	/* If the rate is an exact match, return that value */
+	if (rate == fract_div_phy->pixclk)
+		return fract_div_phy->pixclk;
+
+	/* If the exact match isn't found, calculate the integer divider */
+	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
+
+	/* If the int_div_clk rate is an exact match, return that value */
+	if (int_div_clk == rate)
+		return int_div_clk;
+
+	/* If neither rate is an exact match, use the value from the LUT */
+	return fract_div_phy->pixclk;
+}
+
+static int phy_use_fract_div(struct fsl_samsung_hdmi_phy *phy, const struct phy_config *fract_div_phy)
+{
+	phy->cur_cfg = fract_div_phy;
+	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
+		phy->cur_cfg->pixclk);
+	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
 }
 
 static int phy_clk_set_rate(struct clk_hw *hw,
 			    unsigned long rate, unsigned long parent_rate)
 {
 	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
-	int i;
+	const struct phy_config *fract_div_phy;
+	u32 int_div_clk;
+	u16 m;
+	u8 p, s;
 
-	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
-		if (phy_pll_cfg[i].pixclk <= rate)
-			break;
+	/* Search the fractional divider lookup table */
+	fract_div_phy = fsl_samsung_hdmi_phy_lookup_rate(rate);
 
-	if (i < 0)
-		return -EINVAL;
+	/* If the rate is an exact match, use that value */
+	if (fract_div_phy->pixclk == rate)
+		return phy_use_fract_div(phy, fract_div_phy);
 
-	phy->cur_cfg = &phy_pll_cfg[i];
+	/*
+	 * If the rate from the fractional divider is not exact, check the integer divider,
+	 * and use it if that value is an exact match.
+	 */
+	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
+	if (int_div_clk == rate) {
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
+				   int_div_clk);
+
+		fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
+		phy->cur_cfg  = &calculated_phy_pll_cfg;
+		return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+	}
 
-	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+	/*
+	 * If neither the fractional divider nor the integer divider can find an exact value
+	 * fall back to using the fractional divider
+	 */
+	return phy_use_fract_div(phy, fract_div_phy);
 }
 
 static const struct clk_ops phy_clk_ops = {
-- 
2.43.0


