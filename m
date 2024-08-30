Return-Path: <linux-kernel+bounces-307961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599A9655A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D255DB2233B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2254278;
	Fri, 30 Aug 2024 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km0f7jXG"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B713C672
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724988297; cv=none; b=Qf7VCSZQaN1QAXkrp36mMkqygaq1Yj7dSvhTfdptjAIgpRcY+kmVvUziyKtMjldvKlT79smkosQyli8nDItT1dBzQTIsIWyOZhGDUE5ND+WZk6aFPDR3OdrJksSRRN1+IdyXgow29gITW/NwFaB5loGCy0LC6Jamwf+k+ioDgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724988297; c=relaxed/simple;
	bh=RrJ1sQiwNrGacvgc+B6cZ/4OAEH+N4H/bHn2DxrYWFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjai2ls9Xk+JwSeG31yG9Jy31fTMgSTdnxkfeJuL9R+rVjqiM4KsxXcjGUIhtkVWjoCoAa3nkwNiovNlz4o/hZPa46EHvHEtSwAwOzIhkz/icnxbNs45idWro8CxYT3ZaE1mhoOE/e89C2MyFRIGqzuFT+nglE8nCO2rR7bX/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km0f7jXG; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a0c156a79so65868039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724988295; x=1725593095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjWUxBy6BGIw8Dk+DXNW4fn9hLAEVEXI1Eh6S4ImcZM=;
        b=km0f7jXGDD64VZdDPyUyB3IJ7fpKVmhMSgn8vFCvE9PDheo5qRBLpYK6pwLDNn3fnJ
         9s1xyCjPJlmJC6VKQ/3BQdh4J0DEiCw78GCR8Y9ze6MOlHodYdAMg7TbnaYLQYqz8N/R
         sayogJZijjFDIFVUgMwgis2JmLV8IotrZSLjK/YA6DTj407ZOgEqw0/mXoIQFewLJNRT
         RnvX/lfhBx1RWEOj6xuxoXVcHrnBgBLKktTz+NFXrikfGc5BfvwG2rm1AO0aVZsxdAWW
         S9NWMelnA481V5/6VAYdDiwYZ0rkGi4+2iKWrRA0nZrDnx0YJQp/80LSME4bMDxZCvpB
         0IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724988295; x=1725593095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjWUxBy6BGIw8Dk+DXNW4fn9hLAEVEXI1Eh6S4ImcZM=;
        b=rbx+5zNUszVjTBQGXJnJiULy5l0m+3msf5NvE5ETkbgud0by5f3Fp4rdFqEEIOyp9R
         3hMzigc6oZyLhQnLdXpXo2Ckhx8PtCuaW1HKzXpjzScCLfQpkAqFndKeu9uPd9J+8qof
         RUyDxgQAU4ej0nTyzyTXmloOdPzWd6Y+Z/kp5+5eqFkenT47ktw4+vNsL2u2DXRp9akP
         pwrBLw5A0wrFvGfuG08ZJ3DUn+vLFJMEReE60F8YYHy6PXqO8wmokkEHSmfot59rma0n
         sVc47atT1T4tCA36qild689BmJqBDOYP/Acr/+MaN7tIFAfdiUx3Op0Yk6ShCH55KJpS
         QAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/MHLwCbpLjL4h7+jIGWpMadKB/DHqf1EX89efd8EbVRsV1OR4Z7pi6bZKCQAvNBBhFVCCZjVx8GwOtIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8Obj5HzdLDr/lTRp/xvbu2hLd8iYL67ZotzdppPHy3hgNVFC
	7nz2TvpKUkADmKlV/UlkIfhygtONY2w8tK+F/Br307AbNbQ1zNKz
X-Google-Smtp-Source: AGHT+IGgAovizFpEX5LFsdulAECAYWdhHOcXnLoaPD7mfBHOBepP/pyh+1mkEnBE5dqGg8/ucQDK4w==
X-Received: by 2002:a05:6602:140f:b0:81f:abb2:1e9b with SMTP id ca18e2360f4ac-82a110364e8mr710451939f.6.1724988295253;
        Thu, 29 Aug 2024 20:24:55 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2dcdf0fsm543140173.20.2024.08.29.20.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 20:24:54 -0700 (PDT)
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
Subject: [RFC V3 2/3] phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
Date: Thu, 29 Aug 2024 22:24:26 -0500
Message-ID: <20240830032442.226031-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830032442.226031-1-aford173@gmail.com>
References: <20240830032442.226031-1-aford173@gmail.com>
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
---
V3: New to series

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index bc5d3625ece6..a700a300dc6f 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -355,40 +355,6 @@ to_fsl_samsung_hdmi_phy(struct clk_hw *hw)
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
@@ -457,7 +423,10 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
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


