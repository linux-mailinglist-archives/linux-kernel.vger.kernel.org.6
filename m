Return-Path: <linux-kernel+bounces-316118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBF96CB76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA11F28584
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC3188A1E;
	Wed,  4 Sep 2024 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjm0MP+2"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9971865E8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494244; cv=none; b=bnx28XPvMQU5sazpsw13srxxSCqs7WtIlA1WhkYavaioPTCWRo7I/Rj6CIH58n6hhHRLZ0NB34TVX5zgU11D62JdJJ0qn0CZZ/mjkvO7SCTW0uC9FvFOa6h+7z1FM0ySbZfwAay4XGg7qtfyc+op09pb+XsyWN5V3RPOH2H5z08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494244; c=relaxed/simple;
	bh=u7AckGsY0Ncb14aUeEywvS5X/pAoock8fD0Q5ofprao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjU0rqfIeKUot6+qS4MpUXC6BFhwnZl5mvaGuAXto9iJxDN/rqfPNeYUesUJdYnaOC2Qip9SX6l+Pwgk+abwiZJaTuAEKSd3DT3jFibKeiBs8gLCOEzjWUYNCwmD8J7x6YQOIqKCkJuIZKjp/EWJBI9SwQh07y6xlmO/jQDgLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjm0MP+2; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a32294b27so45951939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725494242; x=1726099042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEz2Arqi3/o64yZ0XIIlM7mZIysQIRVH9/tjlYxL3xQ=;
        b=Vjm0MP+2kkCQUROS6FsRB7KybJ5eNANdly6sfgcaT6yfQB+U9XUCe5AZ4oGaPtAZ8P
         XDd2JvVS0TyMTvUWOsSf+HVNBplSjCv3spCF4IBYQNEeuSxxof7XAHyVqlkRWKyYs5Tx
         X2vl22dbTxUgK5z/aSO2blzw3qqGUSzdZ8pPGvTgUyOzSzXoRi3HEPeMKjZTcO8qOqBq
         Hd4VbppEXVYyT9Hzg9Pjl0fuz3FRszBhCJJYhec3kadJZvGkLu6FQ+YpqFnQAZ2uwVbm
         H+V/V8yjz4Oz/IrIjhqRzLS6XsQUUVepVt3D1x3l4qnaniqXeek2ZSA9V0t8fNQnf81I
         p+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725494242; x=1726099042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEz2Arqi3/o64yZ0XIIlM7mZIysQIRVH9/tjlYxL3xQ=;
        b=vrvqHPaYuhK/CGJ/N5mZZk0W9Va1+trHCiXkoYFKHor0HlDXiRCbK2nUlrA0NH4xie
         /lZQy/GWYWZKHpJCZ1c9r2wOv/aJBYmOe8lNR++2vSCWANAdnXwIWMgTXNbXxkDlgLSM
         fy2THhL8Sdeu9EE0EC0lEPeo2o1Uv2Al/AFuQvLlcrAiRH4pwaxwxZrgRgrzjBOCNOj/
         OF3m1CLAWe/BUtrD11wA9YJ0XBoCqYRTn/o1kzbteC+5dkwOXUIl0+aV9EGSmDptXdAq
         +oTmb6hP4apklTqwq+P+fKDTIt0IQpDYjQdtWmh5CcXbR1NIb8n+fFgIjjR18PLTf/GI
         CFAw==
X-Forwarded-Encrypted: i=1; AJvYcCVE5vkzg5b+kNjZxmqaz/c2SDeDHHgJJ338khrgYBZeOtUhhCzyfCU4oJvUK7Wa1w/ik1wbnSdfVIsL5DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETbrLekVNE578UvQvK9gvcXx+xBDT417I8dkvO4kwg9r5Ju/K
	sglv1LsM1PrRhA11Rb6v6nezRD+octMtDycHJhYr9CBk+0LK68Bt
X-Google-Smtp-Source: AGHT+IEsI6wTHvCX3sOK133ohxI2RakNxa99vQ5IMUDuQlWiloHeO/bx7kabL1bk7PCufZA6dMdxCw==
X-Received: by 2002:a05:6e02:1c46:b0:39d:4dab:a533 with SMTP id e9e14a558f8ab-39f74f88f94mr34164785ab.0.1725494242407;
        Wed, 04 Sep 2024 16:57:22 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc594csm39396735ab.43.2024.09.04.16.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:57:22 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
Date: Wed,  4 Sep 2024 18:30:32 -0500
Message-ID: <20240904233100.114611-5-aford173@gmail.com>
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

Currently, if the clock values cannot be set to the exact rate,
the round_rate and set_rate functions use the closest value found in
the look-up-table.  In preparation of removing values from the LUT
that can be calculated evenly with the integer calculator, it's
necessary to ensure to check both the look-up-table and the integer
divider clock values to get the closest values to the requested
value.  It does this by measuring the difference between the
requested clock value and the closest value in both integer divider
calucator and the fractional clock look-up-table.

Which ever has the smallest difference between them is returned as
the cloesest rate.

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
V6:  Simplify the calculation of the closest rate and fix
     a situation where the integer divider values may not be properly
     setup before they are used.
     Fixup some comments
V5:  No Change
V4:  New to series
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 46 ++++++++++++++------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 4b13e386e5ba..9a21dbbf1a82 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -547,6 +547,16 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
 	return phy->cur_cfg->pixclk;
 }
 
+static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
+						 u32 int_div_clk, u32 frac_div_clk)
+{
+	/* The int_div_clk may be greater than rate, so cast it and use ABS */
+	if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))
+		return int_div_clk;
+
+	return frac_div_clk;
+}
+
 static long phy_clk_round_rate(struct clk_hw *hw,
 			       unsigned long rate, unsigned long *parent_rate)
 {
@@ -563,6 +573,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
 	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
 		if (phy_pll_cfg[i].pixclk <= rate)
 			break;
+
 	/* If the rate is an exact match, return it now */
 	if (rate == phy_pll_cfg[i].pixclk)
 		return phy_pll_cfg[i].pixclk;
@@ -579,8 +590,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
 	if (int_div_clk == rate)
 		return int_div_clk;
 
-	/* Fall back to the closest value in the LUT */
-	return phy_pll_cfg[i].pixclk;
+	return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk, phy_pll_cfg[i].pixclk);
 }
 
 static int phy_clk_set_rate(struct clk_hw *hw,
@@ -594,27 +604,37 @@ static int phy_clk_set_rate(struct clk_hw *hw,
 
 	/* If the integer divider works, just use it */
 	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
+	calculated_phy_pll_cfg.pixclk = int_div_clk;
+	calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
+	calculated_phy_pll_cfg.pll_div_regs[1] = m;
+	calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
+	phy->cur_cfg = &calculated_phy_pll_cfg;
 	if (int_div_clk == rate) {
 		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n");
-		calculated_phy_pll_cfg.pixclk = int_div_clk;
-		calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
-		calculated_phy_pll_cfg.pll_div_regs[1] = m;
-		calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
-		/* pll_div_regs 3-6 are fixed and pre-defined already */
-		phy->cur_cfg  = &calculated_phy_pll_cfg;
+		goto done;
 	} else {
 		/* Otherwise, search the LUT */
-		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
-		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
-			if (phy_pll_cfg[i].pixclk <= rate)
+		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--) {
+			if (phy_pll_cfg[i].pixclk == rate) {
+				dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
+				phy->cur_cfg = &phy_pll_cfg[i];
+				goto done;
+			}
+
+			if (phy_pll_cfg[i].pixclk < rate)
 				break;
+		}
 
 		if (i < 0)
 			return -EINVAL;
-
-		phy->cur_cfg = &phy_pll_cfg[i];
 	}
 
+	if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
+						  phy_pll_cfg[i].pixclk) == int_div_clk)
+		phy->cur_cfg = &calculated_phy_pll_cfg;
+	else
+		phy->cur_cfg = &phy_pll_cfg[i];
+done:
 	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
 }
 
-- 
2.43.0


