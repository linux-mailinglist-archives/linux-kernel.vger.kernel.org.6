Return-Path: <linux-kernel+bounces-329370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87C979076
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04D31F214D8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F91CF5D3;
	Sat, 14 Sep 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfl3hLL+"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A71CF7A0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313317; cv=none; b=rxiUpsnb5FOkXNna83D57814c5v44MAPh97eQTxmQCfYD0GQcu0/AEcOnXKQ4mp83CR2qnQDFpcdcFCpwJpFZ6RHuYxs6rcalErHwPnmSeHb+9XIfYjWh3fHE2YCT2JMbuSvyI+pSHJbhgLoIoidknXcHP0bOHazUyQyZwUaz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313317; c=relaxed/simple;
	bh=k6cGXZOrCzju041aeZ331Vyl0q+xVrCuFJLbG+YPZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT93DhxRGTF2dc+vujlQr6zEuCGp5oAjshlVX/MqCpr/yKeir/+39GWTH6BP1vr8tcr/oJbbRHjPEYZr64tgt27iB/9gnLnLkZTH6yX1p7tRnV7EhenlhtkkdsmkSEZiJqU5PgYzM4RH7JDQKq3249+LvQpbyOqQX7EE/wm8Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfl3hLL+; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39f52e60a19so15484365ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726313315; x=1726918115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUqDak0O3QXqMSK46gM4L1oImDEknZFw9hO3+gSGP9E=;
        b=cfl3hLL+Cj66qfeHbl1mnNnew694Gi54vVyk/2hL3+USiCCmHYJmBOG03by4TiMO4a
         g50K/HalrDYEFSvGDq1WZ/rptF6pcMV/uV/TLR0E3j/1XnmOWLMC5WUf1c5A0rvqPnGb
         XPVZk47BbA7EDr63P6TcUyoe1HMBtIYSh3x06ywenfipZoHr6QE50NoJnbklqWP/vTlU
         qw/xZ+0xb6Cbe4h2Jkp16neX6Ixf/w+XhWnO+6MMHVSEVp/KhTg4gHWncXTMTJ21OZ4N
         1PpDKrf9SwwLdeY2xSmya5H3e2f2KhkZgG1qOBF/lPAxTEX4jE3Cx2K5NefDvvx4gr81
         Pf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726313315; x=1726918115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUqDak0O3QXqMSK46gM4L1oImDEknZFw9hO3+gSGP9E=;
        b=U7Mle+zkrjhYL23Ty1lrDlL7yDAM8VAt56MStIT08MvfYKyxvijFRXH+hh4g+/nHxa
         KQ/3F1e/JUudJ0vVVXqZcX97fTkf9Omz7FQVwcGZSiFDc9Lv2Ij2yA2HBCqC5n/cQ684
         Kg6rVnKwfAE0pjBzkyXjXlV7hWHyA4YQfw+qGOaijoV/cNZfQF/7jRWowjA9jab86oQt
         tshFIoPwluxzSJBUOq2/E4MwFapKkjRXJFzezubZAE76LMvPC1CvPUrz+ArzFOt3yUxW
         cn8blRmZY45CW5HuJuvfIVY6V1ypS4Kfx4c3E7pKuboOZcSXmPjNE9XTPdgcdaQFCMAf
         XAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIgQJzvl9w3xCiacybpWMqJ0eeHVhTN6PaeYX/ZMTlvFKhhawRN70o53Qk+J7LrhyZR9pbEoiVUisc2Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYNdA0eX3/DQ7carDjvMZYZ1lIUqNgD0dCwivTP7jUeg37GdM
	/yZkbZgeOpUiTZAmLGbDqjMr/7mm+62oRA3ldY2BlAGX3Lvk42XA
X-Google-Smtp-Source: AGHT+IGtPFYjznHVWoDep8DJKi1LGKBj4gH/E/hrp7OfcL8Bw58Bk3unjUUFazFUIVuJuUFyjo2VvA==
X-Received: by 2002:a05:6e02:1a0e:b0:39f:558a:e404 with SMTP id e9e14a558f8ab-3a0848ac716mr99880625ab.4.1726313315075;
        Sat, 14 Sep 2024 04:28:35 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed35572sm350307173.131.2024.09.14.04.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 04:28:34 -0700 (PDT)
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
	Marco Felsch <m.felsch@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 2/5] phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
Date: Sat, 14 Sep 2024 06:27:46 -0500
Message-ID: <20240914112816.520224-3-aford173@gmail.com>
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
Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
V7:  No Change
V6:  No Change
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


