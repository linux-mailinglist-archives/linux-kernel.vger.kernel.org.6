Return-Path: <linux-kernel+bounces-312019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2629690F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEE61C215F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D61CCEED;
	Tue,  3 Sep 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdw5r15E"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A61CCEFD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327103; cv=none; b=jGiZvM9GGoN0Izw2r2t3yo/N5B3fUPzbwKja0OlAuHXARZbhpqThEN7SF7+rWwObHRTHsLSLPZ462jCNr2f9HWXgiqXKlxzrHuea9RtmQd5XPP7yQpCEqNi3vZrfdlG72WRsWY36LtsAQ+t++95BLSefNsX9t5DAPTdMXf8m9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327103; c=relaxed/simple;
	bh=6QlnKLBbCh/VSoZHnfYGU+yfXt4uxAMVveccMu1IrSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZjgHUZ9HgP+gznjpYQn3vB9gGVqEerfMvo97ejpmJ0CnCKbo/JrshXdZVw7lbDxT86uQuzk4K7It8gtE0yOer2Qil4jghcpJ6OnalvUzyfjG4BW1tYKcD0zMK/ijyPQJ73rRJbnDhWBW++aTfYakoLLkCnVniVrGkt13hXaam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdw5r15E; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a1741aa31so276132139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327100; x=1725931900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sEWNOyX4JEhPKXKzebKs60n4QKdhi/iAd4E2D6hdhk=;
        b=hdw5r15EELtBwSv21yqwus6TG7HtOoinVoMdE8H30JsnOcqQ8WeZK7lR4pYhwdfi7V
         epwOPatfwgp8G/5Lc5WZmfEQK6oZVKl/tuOZtjOxc3ZVxVzybfE+gFLToGaRSvcwoStp
         JUhdKADOlhkZxbLa8kSM2EKCb3iF5gt+SoAmEYLjvbefAviZfUduIGQ11tXt8ic347Al
         aNZYeEi7+VT2mMKFI0IZjD1X/GiPEy25HqpuPktW5dWz1EwHQz1z53guMN7PbW3sF1VY
         Gy971PnhM+HcAjXKQlO+NyumQsoc1h0JimamKtNZXWXnk2WwDBVGKAYH/RmCk1AVngid
         wI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327100; x=1725931900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sEWNOyX4JEhPKXKzebKs60n4QKdhi/iAd4E2D6hdhk=;
        b=deEpPdazvMloanzCZW6kz74MV0kWyrbF72QwitcPKa05bAvk3EUY+DT7e/+FGIsJcZ
         BO5D735tFITNK/n7iCYKeifFHIh8aQkLkU/sRyPdw3FStwmzU+QuViTQZCp7+Q1JA33X
         w0C4IpMCyWg6o29gg4blqPBwGmeYZuWcqbciklJgqK6xW7h10v/6+gxsUspYVhS0YAi2
         2dfIE1EA5esLzJEYXicG96CzYozLt7l78br69W2OJm+fXjStW6osX6PWVKjRuD0RdCVR
         XeMXV6bm/wmrk3990pAQTOHgLfpRguKHth4vyDcNU1FA4XlGDV+Ib8fGXF+JJYl8SCq+
         6kdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMQxsFNQEYYbyQAdLtdV2vlBGyQ3w5gJbp8Mx0a98GGUgcsX1HCIShp70+e06h0bZl5GbVPJWjJZHU6zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpXxnhFiM7BOJj0F5CuDkM2B9xq7rEyy+84YCef5K5JxVT+A4
	4l/Rw1QPICS2Lz9MYHrC4KEyH7IUX5syQMdrNkamE1D26i+ylBY5
X-Google-Smtp-Source: AGHT+IGjJi7h4OtqyyYcxdSznNVXlcKPmAYtUdsgPdISPxx6jnTnY+wn9+cj2wiR73yG6aq2NsLgiA==
X-Received: by 2002:a92:c565:0:b0:39a:e984:1caa with SMTP id e9e14a558f8ab-39f3784f79dmr186308785ab.21.1725327100006;
        Mon, 02 Sep 2024 18:31:40 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b059c32sm28466715ab.75.2024.09.02.18.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:31:39 -0700 (PDT)
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
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic integer
Date: Mon,  2 Sep 2024 20:30:45 -0500
Message-ID: <20240903013113.139698-4-aford173@gmail.com>
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
---
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
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 341 +++++++++++++------
 1 file changed, 235 insertions(+), 106 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index a700a300dc6f..8822029526f0 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -16,6 +16,8 @@
 
 #define PHY_REG(reg)		(reg * 4)
 
+#define REG01_PMS_P_MASK	GENMASK(3, 0)
+#define REG03_PMS_S_MASK	GENMASK(7, 4)
 #define REG12_CK_DIV_MASK	GENMASK(5, 4)
 #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
 #define REG14_TOL_MASK		GENMASK(7, 4)
@@ -29,281 +31,296 @@
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
+ * The calculated_phy_pll_cfg only handles integer divider for PMS only,
+ * meaning the last four entries will be fixed, but the first three will
+ * be calculated by the PMS calculator
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
 
@@ -313,7 +330,8 @@ struct reg_settings {
 };
 
 static const struct reg_settings common_phy_cfg[] = {
-	{ PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
+	{ PHY_REG(0), 0x00 },
+	/* PHY_REG(1-7) pix clk specific */
 	{ PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
 	{ PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
 	/* REG12 pixclk specific */
@@ -406,6 +424,76 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
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
@@ -419,13 +507,13 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
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
 
@@ -453,29 +541,70 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
 static long phy_clk_round_rate(struct clk_hw *hw,
 			       unsigned long rate, unsigned long *parent_rate)
 {
+	u32 int_div_clk;
 	int i;
+	u16 m;
+	u8 p, s;
+
+	/* If the clock is out of range return error instead of searching */
+	if (rate > 297000000 || rate < 22250000)
+		return -EINVAL;
 
+	/* Check the look-up table */
 	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
 		if (phy_pll_cfg[i].pixclk <= rate)
-			return phy_pll_cfg[i].pixclk;
+			break;
+	/* If the rate is an exact match, return it now */
+	if (rate == phy_pll_cfg[i].pixclk)
+		return phy_pll_cfg[i].pixclk;
+
+	/*
+	 * The math on the lookup table shows the PMS math yields a
+	 * frequency 5 x pixclk.
+	 * When we check the integer divider against the desired rate,
+	 * multiply the rate x 5 and then divide the outcome by 5.
+	 */
+	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
 
-	return -EINVAL;
+	/* If the rate is an exact match, return it now */
+	if (int_div_clk == rate)
+		return int_div_clk;
+
+	/* Fall back to the closest value in the LUT */
+	return phy_pll_cfg[i].pixclk;
 }
 
 static int phy_clk_set_rate(struct clk_hw *hw,
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
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n");
+		calculated_phy_pll_cfg.pixclk = int_div_clk;
+		calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
+		calculated_phy_pll_cfg.pll_div_regs[1] = m;
+		calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
+		/* pll_div_regs 3-6 are fixed and pre-defined already */
+		phy->cur_cfg  = &calculated_phy_pll_cfg;
+	} else {
+		/* Otherwise, search the LUT */
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
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


