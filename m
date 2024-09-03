Return-Path: <linux-kernel+bounces-312020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424BB9690F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE44728409A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154F1CDA2D;
	Tue,  3 Sep 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOnCtIVE"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1C1CCEE7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327107; cv=none; b=rLnkk+JjVooKBnIjB4AglBzdKy6VLi8B06DKj6ZwAZiwdlFohajshjo0zfF4yA1uiPoEUo8gb7owLKMB6NiSNp8JCPEF6tLDoKrhnlkSMSiQeL6dR3asrmfZapH3L/ZvFAwMc1Lu9GZz/s9D+tQ8oz2uAmHl5z3ckuPHxlSRlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327107; c=relaxed/simple;
	bh=zpdcJeAxwsn3TRUZFsj3awJYr3xXjM69ZW96AxDTbGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqyRtqWpY7B5t4l0jT05+gyQZcbo+yEG/+sHVOoVoPbrqDiOF/DberwPhj2Hz8IZGZaPxatjuu2CFJjtONn4OUE9kOytjYp6q/8OlTmBDy0CtJ08x8N2aM5u7+/bsFH3NHjytLwSiAQSXzOw/YWlp0jXBqkegzJ5RW2ymQK/GCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOnCtIVE; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39f56df0ddbso6080745ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327105; x=1725931905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWzyFJBdw6McwAWR/O0zmf3qYdQVBqiXE9WFlnVZSZk=;
        b=DOnCtIVEVkkALdhy9Gp41vqOYshQWTiS8YGQZ2KxWj2aWIRpxQ/K4ZMkCF2A+JrLz7
         8jPcRli494Iz+lVajSo6/21xJ5Lu0Lk+obaWYG5stuvmOc5G2bOVdmaJ5YxDW+TPyfYd
         yDjDy+NFUyX7M3dngft3WzhdZdPuIGwK+2kUnVgJ2+bLZbQDnqlsKPK4FmJg35eEAz/9
         Z6MzXG6/asu7MoQlM/0WI28rWawPDKtdDExWMfjyhykEbMsZ2f6yWGATgjUMAzrg289i
         Ox+62wqkUmWGCObOEsipDofQOzGXgheu+/EsJVFD2ibRA/7jcmzXHwrJh6vZb+hY+X8n
         YtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327105; x=1725931905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWzyFJBdw6McwAWR/O0zmf3qYdQVBqiXE9WFlnVZSZk=;
        b=wPVVixNSolDtK5FSHiNJNpNhRoP3lSbjoOPb1yUd2IQoqUN3iSBvLtbJmBlFQJ7WFU
         JUtNr7MPELNyYTbhKO7WyRDLIIuPtPw5gZ7P5wD2oQUvpUuDks25pQBOhM9p5ZOEx8tY
         gWONOvEqwZqtKrjTPYTWnJDL9I2LSWbQ7xDx9P3oV6Pp1sJu8tn5getJBnuIG4dZFDBS
         excf3sfBUnLUjAfgODQyPhGW8nE60Oieum13EEuQezjdIyP/RG49PVHyFnu1+xKnN03F
         f76NdnDDB8uwiA/jIbDSRvwDXTg0VT4/aVTRgzpIybEhVLigoC7ZJZNnMisqCM5PHQn8
         GZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCVQU+8bxRYN09XrGhoB+QtAnrgxmSVA+LtQ+64vYb/HfcCemmqgBE375zoS06ZphM1CrgLEfL8ajmfKsuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhILhCv+Turx1kiuHHUM54KRwfJrl6KOaRU2lILd2GJPPDw9Eg
	CdnTMac0MRIJJCcCcZxnTgYehc2nyA6db/W5Q4YoFTntsMN1TTI6
X-Google-Smtp-Source: AGHT+IGF7GMRXv9kwC7231QtjJ0oUs1xla4KHNbfeXJyQhSKa72TXj6EujOvyf5b3yOnWq3nK05QaA==
X-Received: by 2002:a05:6e02:156c:b0:39b:33b5:5cc1 with SMTP id e9e14a558f8ab-39f37874675mr160259425ab.24.1725327104895;
        Mon, 02 Sep 2024 18:31:44 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b059c32sm28466715ab.75.2024.09.02.18.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:31:44 -0700 (PDT)
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
Subject: [PATCH V4 4/5] phy: freescale: fsl-samsung-hdmi:  Use closest divider
Date: Mon,  2 Sep 2024 20:30:46 -0500
Message-ID: <20240903013113.139698-5-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903013113.139698-1-aford173@gmail.com>
References: <20240903013113.139698-1-aford173@gmail.com>
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
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 +++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 8822029526f0..0bf526e282a7 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -541,7 +541,7 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
 static long phy_clk_round_rate(struct clk_hw *hw,
 			       unsigned long rate, unsigned long *parent_rate)
 {
-	u32 int_div_clk;
+	u32 int_div_clk, delta_int, delta_frac;
 	int i;
 	u16 m;
 	u8 p, s;
@@ -554,6 +554,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
 	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
 		if (phy_pll_cfg[i].pixclk <= rate)
 			break;
+
 	/* If the rate is an exact match, return it now */
 	if (rate == phy_pll_cfg[i].pixclk)
 		return phy_pll_cfg[i].pixclk;
@@ -570,15 +571,21 @@ static long phy_clk_round_rate(struct clk_hw *hw,
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
@@ -593,19 +600,34 @@ static int phy_clk_set_rate(struct clk_hw *hw,
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


