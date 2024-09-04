Return-Path: <linux-kernel+bounces-314083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073FE96AEAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E71C23CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7DD548F7;
	Wed,  4 Sep 2024 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx1beUZT"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160A446CF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417222; cv=none; b=IhX3Z+NqvaJVGlZK0JOl9Wu1LtAfyqMnrB7DiPaIfBR9xo2B/K7uS2XbymAlV6FfbNBJ3l4H2cizcV/w2NDLb+wnr/FDKmIzw9twc0/uYNA8gujlTTA1EW9W38ScbFs3VU9/a8zfv+Ahdn9ozr9erM1gfG3Cn8f8fIddeg6mIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417222; c=relaxed/simple;
	bh=ni6Lq3RucOcY5Rrx9+lzHmoQ17vWsjn5gyJxnjwXsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DD+7CsnA2AYI4DPrOd/lWZmoplpm1Rv0+6O5GUnBvIO4ygVBUDgaM8pMyN4n/vE8+OHqQ35drLygybRIEh4KpoHxnuTXr3W1ltTNPByDg2aklFP5NEKSo5iW/5KjcBOfa0b2mXxpKch6dkVzlsElmuSQUZnM741iYV5S8ojKxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx1beUZT; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39f52e60a19so14190855ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725417219; x=1726022019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVOv/lJdk3gJmp2nmDecrMgrWVl3MLrxbsv6imthSUs=;
        b=Sx1beUZTrfvjbZ6jVYJUioHuQOMQJjAql4pwm4Ab5U+d0hZ4bRjb3SE/vPyTtCtqu2
         +KqsBycxbRSXP2PgBD1SdO6RAeJ9VXbaD0htJQOY/bXvHybHIEt5NzlnUe+yg6n6bjNV
         Bdm6qa0CVm3f019sFqs32jPgIh1exJd/9YKu1ngidftYWHQFPi7i7FqoHa3ymTsfy0hC
         bSj6yW5xOVJSgACGphdt0l1cwmbhsw9u571Bj4Yod3H2e00GCiUZjcr2azcJxR7CwlfP
         AM5UwXQPMFbStaaxNGjQEmNEEmJQUC/JHpI5awACnXRf/zjdxOxFOVRbpwzoZC35A/gn
         2UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725417219; x=1726022019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVOv/lJdk3gJmp2nmDecrMgrWVl3MLrxbsv6imthSUs=;
        b=DKNRUixgFQjJrFpS/TEauY/3A1smjOMC2wBBKOXUNW4onKPgiEuism4cWEJJ+4bJJI
         ZcPyrUDtFLKBrkHXyDDJSaXlGxPFVW1OMxMR3w3+z5W5lP7i/nTWEdkawqIyCoLlzuuX
         ePblAlYsgaApBKoVSiJ9Upmnp1lKuKZp0vCUYjzrFgnRjJB9/9N2hkt1VrS3nPD12Hn8
         NeK2WTE9rt1JXEIOVQfrumizddYHvpr8CdRr+Bqg1Y+hY8LlnQcBNeSOQGxLJ2jXAVnT
         Zt1SIuqNSmyb8CmZKxJ5xSJXyF4IMqm2zhPd1BSFPu2a1/B3ZU1YNS++9YzgCq/mZwF0
         Pzug==
X-Forwarded-Encrypted: i=1; AJvYcCXe++5RT+z0P1R+IMi876qQLLVvM7WuGQ9nlE/Cd+aHlQtE3qM/CQ4HITRCLj6ZVSL+b6ixh9if+QS1pdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAhrA07Sr+lnfYaxvtdmOzYk5X76hNPjWd8bpoluw1MYkWiAP
	IwFF0O4ouRM5alYMKpFPa4y/cL2MwlGdsq72mzWeijk3KWtwe+Rq
X-Google-Smtp-Source: AGHT+IHpQFUgQqQYcMy/Pb5K8EPlUgQiBZB0oSIzAbA/wx8uTRP0l4SFR7GpIhI6V+9FPfjHkLqfsg==
X-Received: by 2002:a05:6e02:2141:b0:39f:5baa:e50e with SMTP id e9e14a558f8ab-39f5baae95bmr118091905ab.7.1725417219536;
        Tue, 03 Sep 2024 19:33:39 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc4ff6sm34556175ab.37.2024.09.03.19.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 19:33:39 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
Date: Tue,  3 Sep 2024 21:32:43 -0500
Message-ID: <20240904023310.163371-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904023310.163371-1-aford173@gmail.com>
References: <20240904023310.163371-1-aford173@gmail.com>
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
V5:  No Change
V4:  New to series
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 +++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 8f2c0082aa12..56b08e684179 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -550,7 +550,7 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
 static long phy_clk_round_rate(struct clk_hw *hw,
 			       unsigned long rate, unsigned long *parent_rate)
 {
-	u32 int_div_clk;
+	u32 int_div_clk, delta_int, delta_frac;
 	int i;
 	u16 m;
 	u8 p, s;
@@ -563,6 +563,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
 	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
 		if (phy_pll_cfg[i].pixclk <= rate)
 			break;
+
 	/* If the rate is an exact match, return it now */
 	if (rate == phy_pll_cfg[i].pixclk)
 		return phy_pll_cfg[i].pixclk;
@@ -579,15 +580,21 @@ static long phy_clk_round_rate(struct clk_hw *hw,
 	if (int_div_clk == rate)
 		return int_div_clk;
 
-	/* Fall back to the closest value in the LUT */
-	return phy_pll_cfg[i].pixclk;
+	/* Calculate the differences and use the closest one */
+	delta_frac = (rate - phy_pll_cfg[i].pixclk);
+	delta_int = (rate - int_div_clk);
+
+	if (delta_int < delta_frac)
+		return int_div_clk;
+	else
+		return phy_pll_cfg[i].pixclk;
 }
 
 static int phy_clk_set_rate(struct clk_hw *hw,
 			    unsigned long rate, unsigned long parent_rate)
 {
 	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
-	u32 int_div_clk;
+	u32 int_div_clk, delta_int, delta_frac;
 	int i;
 	u16 m;
 	u8 p, s;
@@ -602,19 +609,34 @@ static int phy_clk_set_rate(struct clk_hw *hw,
 		calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
 		/* pll_div_regs 3-6 are fixed and pre-defined already */
 		phy->cur_cfg  = &calculated_phy_pll_cfg;
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
 
+	/* Calculate the differences for each clock against the requested value */
+	delta_frac = (rate - phy_pll_cfg[i].pixclk);
+	delta_int = (rate - int_div_clk);
+
+	/* Use the value closest to the desired */
+	if (delta_int < delta_frac)
+		phy->cur_cfg  = &calculated_phy_pll_cfg;
+	else
+		phy->cur_cfg = &phy_pll_cfg[i];
+done:
 	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
 }
 
-- 
2.43.0


