Return-Path: <linux-kernel+bounces-316115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947796CB72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ACA282387
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890951885A5;
	Wed,  4 Sep 2024 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu3+y1KP"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7D188582
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494235; cv=none; b=sNoN2/ECmd9Ws/CFalSqDjtZFcQH2+tlG5Q6zhNHG+m53Dcn1MOIO0HM2uiSYSdbVvvv+PFbZ1E2WFCnrG+rftmuELLr9iYLYljYj6x1qhPGzb7lhaCcexaVXzys0M4DsUqcyfjHMq7TngpybZYseUiIzKObtdQ/mGZldu3PrxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494235; c=relaxed/simple;
	bh=X08t1QPMxUFrXgBrLbI64z8K8zK0VYEvSIXi50YDfJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfQrrUnhdQYGAi2+yRzMBJ3s+drBNcr5MTuC9cy/O8g2hO3YpRLJnleRxyZ4HF5D6NpuludmtzPxu1y6+YbGqGwS4mkg3Jv+rmSNboF0OyYZKqlVxcKMYckbIKXM7diLxxKcaPaJgJYe48iIW72G/3y7YLX8EQW5dYDB4PSdlVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu3+y1KP; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39e6b1ab200so781755ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725494232; x=1726099032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnvKz4VCRDYIFlWg27wCPTIEDT/7xtP8qgUadloc2x4=;
        b=Vu3+y1KP4fKFcT3I0rM2w0BSzqVaNI0fEvd6NvZU7eZ7SEETStTjyQ9t5zTgm0wuzK
         WbJByZWH5/qaA14IO36uDXnax5wkC0hNDVbcPI3HoAjpOc/FaUsZrqq7gryGb9BbKxox
         4v/kaVOCmiPcpYeWmcbR9gFAu5CXHq116idFOCdUpKN9/jhEtJtHdAQ+UXJEx8p58bP4
         Emgh9hw5vP3y/BNTwNxhH7qINdsyjEckyqQFuKLTTDTYHP5T7/be+GDhOKDHsHoFmqUC
         gfYwQyLhz0vwMOJ65xrWoRuVibGnLK8z0kx0uJnKIJqWJOWk++SQvnPWl802Vn4109WP
         mcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725494232; x=1726099032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnvKz4VCRDYIFlWg27wCPTIEDT/7xtP8qgUadloc2x4=;
        b=tbP6xPD1Mc5MZDHOEXjBMknMC8tUYT92nUT0KBMmniYjPUr95B0L8B8YIEiF+bZZ7D
         uIcB3i1TE6XFkvHvs1Q9GfwIXHTcHtiYyvjHgwW+YslT5NuoNf2LnpIcTlDn4oz6ACDe
         bioHPh+wXwP4TuDURvJicgseQyywviSEb1fMikcfRiExF/IfQQn0sA5AOOTlH21lWw7u
         Xd8DD5W7PUUoI+Sw3+o7EcafKpFlP9FYdQ0Ac2KZlGy/TzpVsd8f5OIgOKb6NxWNn6Y6
         QcHqOB4nA3kF0QbW01a8yMzsOwznTqHHPDV/4U7lx6ROeS5aT6D6mKnk9W5XhR6m2yX5
         xDAg==
X-Forwarded-Encrypted: i=1; AJvYcCVFgb1oiCDuTuThFoMRL1PpaRZLtboEUhRf4jJzVvCqyVALvKp0l2JbfsAwFStC0f5gAUXD0ZFBS/EMZW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8qwHtRhvK9kYBbxRh/v1kM7yh3yrjjqut1J+HIfYkBUHnSgK
	h+Gua3Wi1BzXB7lDQgbr9G4fTevrQDAyZQDmnUpWb5M+5zAw7gbv
X-Google-Smtp-Source: AGHT+IG5q6rMM03957Ull+SI14wbNpAwjXrsDNrc4H2Nc/UMDXZUgDTC9FfN5eufAb767R3BTk4ItA==
X-Received: by 2002:a05:6e02:174d:b0:39b:4ec0:645c with SMTP id e9e14a558f8ab-39f4f68207cmr202094565ab.4.1725494232585;
        Wed, 04 Sep 2024 16:57:12 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc594csm39396735ab.43.2024.09.04.16.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:57:12 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/5] phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
Date: Wed,  4 Sep 2024 18:30:30 -0500
Message-ID: <20240904233100.114611-3-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904233100.114611-1-aford173@gmail.com>
References: <20240904233100.114611-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of 'S' is writen to two places, PHY_REG3[7:4] and
PHY_REG21[3:0].  There is a lookup table which contains
the value of PHY_REG3.  Rather than using a switch statement
based on the pixel clock to search for the value of 'S' again,
just shift the contents of PHY_REG3[7:4] >> 4 and place the value
in PHY_REG21[3:0].  Doing this can eliminate an entire function.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
V6:  No Change
V5:  No Change
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 39 ++------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index acea7008aefc..4f6874226f9a 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -364,40 +364,6 @@ to_fsl_samsung_hdmi_phy(struct clk_hw *hw)
 	return container_of(hw, struct fsl_samsung_hdmi_phy, hw);
 }
 
-static void
-fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_samsung_hdmi_phy *phy,
-				      const struct phy_config *cfg)
-{
-	u8 div = 0x1;
-
-	switch (cfg->pixclk) {
-	case  22250000 ...  33750000:
-		div = 0xf;
-		break;
-	case  35000000 ...  40000000:
-		div = 0xb;
-		break;
-	case  43200000 ...  47500000:
-		div = 0x9;
-		break;
-	case  50349650 ...  63500000:
-		div = 0x7;
-		break;
-	case  67500000 ...  90000000:
-		div = 0x5;
-		break;
-	case  94000000 ... 148500000:
-		div = 0x3;
-		break;
-	case 154000000 ... 297000000:
-		div = 0x1;
-		break;
-	}
-
-	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
-	       phy->regs + PHY_REG(21));
-}
-
 static void
 fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 					    const struct phy_config *cfg)
@@ -466,7 +432,10 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
 		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
 
-	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
+	/* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
+	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
+	       cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
+
 	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
 
 	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
-- 
2.43.0


