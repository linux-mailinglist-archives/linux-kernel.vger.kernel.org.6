Return-Path: <linux-kernel+bounces-329372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A7979078
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671A11C2196E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DEA1CF7CA;
	Sat, 14 Sep 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2p1/ilR"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631A1CF7C0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313329; cv=none; b=doVPgJVY6ueNcsPGe/pl3/vY6ujYKRP2ezOf8/QQtKbfJgxFVm4vUXF8yUaKYMI3pRG8K8xLxffOJN82w5HKL3f8e2LwFB7/JhhhrGC64Db5udHnLSVhQegSoWekZOj1saEaknJWmJcr9Ny/llbkXfeJv7Kt/Npwb4eV/QFVAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313329; c=relaxed/simple;
	bh=pl9dmmpQ3koTDIUDxHw3l8lmqblXpKji4nlRfs3BJ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkiJ8Ag9Pc/qFrq2l+Zn7R3F/pIQ0MIEqZ2B7mDTB86Mw5dDN6yW3BgHkgCUxWfFI1IA7zx1p+yVHFI1lcbKpwdxKLM3OBVjd1Y05IctsNRSUk55dInL89bS4WtaGprTlLJ50OgNRrEj1rUAdrpnYKf1MRLPZwbhwh4ktnxlab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2p1/ilR; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a08489f757so9147835ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726313326; x=1726918126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xV6n2xfd+FaMO8WaO3/5kzB5Pnz5Y6CJYYgXfk9V5E=;
        b=N2p1/ilRyeKLbvZPMMoYErcg1e8gAhCF/VM+GgZcnPveHBGPkIO09D6p/tUuWAHIOA
         PSl+cgg5GPMGh5Cy3klXIU+jTFgyGn4JaI1V9OgfkNJKfe72NYkXBpQaHM0khAMA2SLk
         hV67thKoJz4IYNIVq1HEzmx1YfH5AWcGqdeodaM2RNNnwblVRxaE2jws1wbI8Vy0MQw8
         /AzS5XYhSCtmhijhKeH6P001REwdYH+OdJktUmbawOHj+jbdxLBjxWJYOOEm1UNhtacM
         1jZqZ+6Gqdq107ooafT2STTlVkVAqvrLJZ4T9iOQBEl/SOj4jZ11SHh08ge2AkPmu3he
         l2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726313326; x=1726918126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xV6n2xfd+FaMO8WaO3/5kzB5Pnz5Y6CJYYgXfk9V5E=;
        b=uHRlTbWb+dMe4+T8osru9qh+zuT7J28G2baXeTIAzVpEZkNgN+QmJpDkWOURYcCtMq
         FB8R9YCcsM7qpGlDsKfnd0QHqCV0MaWYX/gtPT4MippfoCYqNIoqfrHKh8otMXv1ZT5+
         a9rL9epXQZ9vmqXc68uHYd2RjxE+eeo5uwis6Su6toMuqj5XS/vXzae2p1D+jqwAJy5J
         woAz+E21LnAvIA/s+F4gkLXZgbJ7/hqDgyXbsy/KjB84RpwRg9xLmr6UrHHFpAkD+r9f
         ZDAPhO1l03W+XMhFcwhhxGn+QUjTtvKb68Z/uZMPMCot6NDTJFOTVwqRRKi9mlxH9Yc1
         y5aw==
X-Forwarded-Encrypted: i=1; AJvYcCU1xmGSH7XbK6DHPzVE6y8s3NEJQIX/ZCJq6Vs6KkLuA5+tGbi9qhip+4wL/mqbxzZWtAylqQ8HZbXKu+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEdiRaYGUaF0DfZQMUqyW7c95hpuYoaEKIjHRglk6GwZGzKp9a
	P1DmsE1JpzMNPUQHiSW4tB8rOFpq9kqym1pQHawJXbZmwJPiSCUx
X-Google-Smtp-Source: AGHT+IG0kreIWwWBWw+JlyvPmBrdaLkQSyVHwsDgbT6YhqxbLTJUYIJBECAP9is+NklLbzzo8R1hJg==
X-Received: by 2002:a05:6e02:1547:b0:375:a3eb:bfcd with SMTP id e9e14a558f8ab-3a074c642f5mr114413285ab.8.1726313326421;
        Sat, 14 Sep 2024 04:28:46 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed35572sm350307173.131.2024.09.14.04.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 04:28:45 -0700 (PDT)
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
Subject: [PATCH V8 4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
Date: Sat, 14 Sep 2024 06:27:48 -0500
Message-ID: <20240914112816.520224-5-aford173@gmail.com>
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
the closest rate.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
V8:  Replace Goto statement with calls to helper functions
     use ABS for both integer and fractional divider entries.
V7:  Because of the previous patch refactoring, the flow of this patch
     changed quite a bit to use more help functions and goto statements
     to hopefully make the code flow better and improve comment
     readability.  Because of the change, I removed s-o-b and r-b,
     and t-b tags.

V6:  Simplify the calculation of the closest rate and fix
     a situation where the integer divider values may not be properly
     setup before they are used.
     Fixup some comments
V5:  No Change
V4:  New to series
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 ++++++++++++++------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 029de69fbeaf..381742e8b618 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -577,6 +577,16 @@ static void fsl_samsung_hdmi_calculate_phy(struct phy_config *cal_phy, unsigned
 	/* pll_div_regs 3-6 are fixed and pre-defined already */
 }
 
+static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
+						 u32 int_div_clk, u32 frac_div_clk)
+{
+	/* Calculate the absolute value of the differences and return whichever is closest */
+	if (abs((long)rate - (long)int_div_clk) < abs((long)(rate - (long)frac_div_clk)))
+		return int_div_clk;
+
+	return frac_div_clk;
+}
+
 static long phy_clk_round_rate(struct clk_hw *hw,
 			       unsigned long rate, unsigned long *parent_rate)
 {
@@ -615,6 +625,15 @@ static int phy_use_fract_div(struct fsl_samsung_hdmi_phy *phy, const struct phy_
 	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
 }
 
+static int phy_use_integer_div(struct fsl_samsung_hdmi_phy *phy,
+			       const struct phy_config *int_div_clk)
+{
+	phy->cur_cfg  = &calculated_phy_pll_cfg;
+	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
+		phy->cur_cfg->pixclk);
+	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+}
+
 static int phy_clk_set_rate(struct clk_hw *hw,
 			    unsigned long rate, unsigned long parent_rate)
 {
@@ -636,20 +655,19 @@ static int phy_clk_set_rate(struct clk_hw *hw,
 	 * and use it if that value is an exact match.
 	 */
 	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
-	if (int_div_clk == rate) {
-		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
-				   int_div_clk);
-
-		fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
-		phy->cur_cfg  = &calculated_phy_pll_cfg;
-		return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
-	}
+	fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
+	if (int_div_clk == rate)
+		return phy_use_integer_div(phy, &calculated_phy_pll_cfg);
 
 	/*
-	 * If neither the fractional divider nor the integer divider can find an exact value
-	 * fall back to using the fractional divider
+	 * Compare the difference between the integer clock and the fractional clock against
+	 * the desired clock and which whichever is closest.
 	 */
-	return phy_use_fract_div(phy, fract_div_phy);
+	if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
+						  fract_div_phy->pixclk) == fract_div_phy->pixclk)
+		return phy_use_fract_div(phy, fract_div_phy);
+	else
+		return phy_use_integer_div(phy, &calculated_phy_pll_cfg);
 }
 
 static const struct clk_ops phy_clk_ops = {
-- 
2.43.0


