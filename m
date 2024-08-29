Return-Path: <linux-kernel+bounces-306018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862A963817
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587481C22171
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7F3C482;
	Thu, 29 Aug 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbAHopdC"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DC38FA6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897590; cv=none; b=R1DHBftrVNJ2P2F1VKjdjs3f04KYoCSttaiBEt60BJayUq2LnyJFNJdBfoc3fzheOG573A6BsGE/QuDtuP9W8WvlK2eI4pa6ZCVboQaR4xK/DZ15c2DbauH5fYwjTmwy7t0wKzltOrGo1yhj7h0l54xfHkDgrlzg87LUB4PSmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897590; c=relaxed/simple;
	bh=5mU2nU4X07Z7fc+LngsM0eBMXr9QpTVSiCj7V8unEXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsMgMF9KmiaQBB01vL4cwHRtvIo9ayOb7+ucFmLMRlc62BsmKtOzgHAyj045+eN2phHvO+2ZTc5m0VEIQNhkQ7G3oKNd9hzkWkopK7G+7y0FL/adD8Uh499i5ykznlIck19au4MR68bzcUv57l3kG5VK1C4eMo3NOwSFJAC1O28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbAHopdC; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82521c46feaso7794539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724897588; x=1725502388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsjhY5XZ0vnEndVhLYw930ASTyeg4yncLyqMDgVzQMw=;
        b=PbAHopdCi1eYb627I6JNoiYRXRlV2fuZDp3X563VjSj/+Hx/SEojM52eUQb0BgPEx7
         nhcXKhs+oCYklbT0S+WHr6C/HO2xc/l293Oqyzb07bBKP3WEs+8b3nwHP+moJa1OhroP
         P15y8u4z6HH4ZQEkH+wf2hoT9up6OGI2jY4cS2rW7wTh9m0ucBQwEo6RqMJ+2G/7EUkc
         H+C4KSXASit9LfkbaZd4u8barPmL1H7z5dlvsbt4Z4ceAFx6UkjyUcqdSSYDtF6CnZiu
         yJul3WRuj3wHhafulaBhjwLljOnEXbCDhnYVVjvyg+y9mDYzVQOiHwVpdW/aQ9ZEuPXG
         /2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724897588; x=1725502388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsjhY5XZ0vnEndVhLYw930ASTyeg4yncLyqMDgVzQMw=;
        b=oka5Q3oukyx4Bnbm/xTQRrGMeJzQiCWjyod8jyEe3LE6mFrJFhLr/uumk9AmvQLNlM
         aJ1uXfzyZ9j9YKMrtMeRM0PQB1+MLAQFVCUd9XkI9/j6VuUsLt7qd4ztO5EkvBUZLmqY
         6v9y65MlNRjtP8cvsV250fVUA0/48V/lZaJvcV689gl0kAL677003eLlNPKikeEIYUuf
         LY9E8CgBy5FW008hYefEkbpflLOO3EzkVAC8pLi+RNTv0j4SGAOkKRoseVbFUtYX6hx0
         xDnTaWBRCE9yMIvxaJN5Wysp61EHcB7HYDKWCzYwN+5icL3nDUTGCbqcmuyAesESi80H
         n4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVqpvbm5r7Lpq6m2WX06vourhRYTlq0gs3SN/vOAgUN6nTVsCyqlaqEOy3AQN8z5mMGbEkMi0yA9VkkMY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZA+D8Wl2j2BQAm4OIlK8hI1Ce7RgbRqEfqOCy/ZK07pryGirZ
	fEveXZ8kHdfclRvEKtr/KDnM3FrAAhc5Lpcgb3LVPt8m801+h5fmjUBPDg==
X-Google-Smtp-Source: AGHT+IEtHJTmpOM1GYaMvoBooLQufKeyrDlS3bodVB3yDcAXfAxOJ4AvzBJENGNR3R7isPhfifUIuQ==
X-Received: by 2002:a05:6602:15c6:b0:81e:4ef0:3a81 with SMTP id ca18e2360f4ac-82a1109c87cmr179544039f.16.1724897587851;
        Wed, 28 Aug 2024 19:13:07 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ee8559sm46200173.174.2024.08.28.19.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 19:13:07 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [RFC V2 2/2] phy: freescale: fsl-samsung-hdmi: Support dynamic integer divider
Date: Wed, 28 Aug 2024 21:12:45 -0500
Message-ID: <20240829021256.787615-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829021256.787615-1-aford173@gmail.com>
References: <20240829021256.787615-1-aford173@gmail.com>
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
resolutions without having to update the look-up-table.  If the
integer calculator cannot get an exact frequency, it falls back
to the look-up-table.  Because the LUT algorithm does some
rounding, I did not remove integer entries from the LUT.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index bc5d3625ece6..76e0899c6006 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -16,6 +16,8 @@
 
 #define PHY_REG(reg)		(reg * 4)
 
+#define REG01_PMS_P_MASK	GENMASK(3, 0)
+#define REG03_PMS_S_MASK	GENMASK(7, 4)
 #define REG12_CK_DIV_MASK	GENMASK(5, 4)
 #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
 #define REG14_TOL_MASK		GENMASK(7, 4)
@@ -31,11 +33,17 @@
 
 #define PHY_PLL_DIV_REGS_NUM 6
 
+#ifndef MHZ
+#define MHZ	(1000UL * 1000UL)
+#endif
+
 struct phy_config {
 	u32	pixclk;
 	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
 };
 
+static struct phy_config custom_phy_pll_cfg;
+
 static const struct phy_config phy_pll_cfg[] = {
 	{
 		.pixclk = 22250000,
@@ -440,10 +448,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
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
+	for (_p = 1; _p <= 11; ++_p) {
+		for (_s = 1; _s <= 16; ++_s) {
+			u64 tmp;
+			u32 delta;
+
+			/* s must be even */
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
+			 * in the look-up table
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
+			 * 3GHz.  The VCO is assumed to be _m x
+			 * the reference frequency of 24MHz divided
+			 * by the prescaler, _p
+			 */
+			tmp = (u64)_m * 24 * MHZ;
+			do_div(tmp, _p);
+			if (tmp < 750 * MHZ ||
+			    tmp > 3000 * MHZ)
+				continue;
+
+			tmp = (u64)_m * 24 * MHZ;
+			do_div(tmp, _p * _s);
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
+	return best_freq;
+}
+
 static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 					  const struct phy_config *cfg)
 {
+	u32 desired_clock = cfg->pixclk * 5;
+	u32 close_freq;
 	int i, ret;
+	u16 m;
+	u8 p, s;
 	u8 val;
 
 	/* HDMI PHY init */
@@ -453,11 +534,38 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
 		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
 
-	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
-	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
-		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
+	/* Using the PMS calculator alone, determine if can use integer divider */
+	close_freq = fsl_samsung_hdmi_phy_find_pms(desired_clock, &p, &m, &s);
+
+	/* If the clock cannot be configured with integer divder, use the fractional divider */
+	if (close_freq != desired_clock) {
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use fractional divider\n");
+		/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
+		for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
+			writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
+		fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
+	} else {
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use integer divider\n");
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: P = %d\n", p);
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: M = %d\n", m);
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: S = %d\n", s);
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: frequency = %u\n", close_freq);
+
+		/* Write integer divder values for PMS */
+		writeb(FIELD_PREP(REG01_PMS_P_MASK, p), phy->regs + PHY_REG(1));
+		writeb(m, phy->regs + PHY_REG(2));
+		writeb(FIELD_PREP(REG03_PMS_S_MASK, s-1), phy->regs + PHY_REG(3));
+
+		/* Configure PHY to disable fractional divider */
+		writeb(0x00, phy->regs + PHY_REG(4));
+		writeb(0x00, phy->regs + PHY_REG(5));
+		writeb(0x80, phy->regs + PHY_REG(6));
+		writeb(0x00, phy->regs + PHY_REG(7));
+
+		writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, s-1),
+		       phy->regs + PHY_REG(21));
+	}
 
-	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
 	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
 
 	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
@@ -484,8 +592,17 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
 static long phy_clk_round_rate(struct clk_hw *hw,
 			       unsigned long rate, unsigned long *parent_rate)
 {
+	u32 int_div_clk;
 	int i;
+	u16 m;
+	u8 p, s;
+
+	/* If the integer divider works, just use it */
+	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
+	if (int_div_clk == rate)
+		return int_div_clk;
 
+	/* Otherwise, fall back to the LUT */
 	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
 		if (phy_pll_cfg[i].pixclk <= rate)
 			return phy_pll_cfg[i].pixclk;
@@ -497,16 +614,28 @@ static int phy_clk_set_rate(struct clk_hw *hw,
 			    unsigned long rate, unsigned long parent_rate)
 {
 	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
+	u32 int_div_clk;
 	int i;
-
-	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
-		if (phy_pll_cfg[i].pixclk <= rate)
-			break;
-
-	if (i < 0)
-		return -EINVAL;
-
-	phy->cur_cfg = &phy_pll_cfg[i];
+	u16 m;
+	u8 p, s;
+
+	/* If the integer divider works, just use it */
+	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
+	if (int_div_clk == rate) {
+		/* Just set the pixclk rate, the rest will be calculated */
+		custom_phy_pll_cfg.pixclk = int_div_clk;
+		phy->cur_cfg  = &custom_phy_pll_cfg;
+	} else {
+		/* Otherwise, search the LUT */
+		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
+			if (phy_pll_cfg[i].pixclk <= rate)
+				break;
+
+		if (i < 0)
+			return -EINVAL;
+
+		phy->cur_cfg = &phy_pll_cfg[i];
+	}
 
 	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
 }
-- 
2.43.0


