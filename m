Return-Path: <linux-kernel+bounces-324088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F29747C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACFA288AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BEC2A1A4;
	Wed, 11 Sep 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiqXp7pE"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A2224EF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018152; cv=none; b=lYkhyEFQvQG1T5mWiY4WzSvLhuYZ+4jKaUql3sK6+M3NgN/1jE/WbXXxXdn5Hj0R7Z4/JrkUSHAN4yhdUrSLc1rPLTqw1ID948WbympKMHhWqWO0v9koAFeYDyfyQQyxxwIpe8XjLLQP0bSQJcZ8X7Nfrv4RrgD0wNSpsL4o/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018152; c=relaxed/simple;
	bh=w4WjNTKo8YOTZ0nnY5vinap5dKv5B8g8jL9FHegwdvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJzlbC09hN3A2Q+imGsX4odZxApeiYhd8Vd+IlSASRjOiXfj/lPLn0p5KMPU2/ub02u6TN/fV3DLOjAddHLR4B4LETBWBBbrE7WRVXDslGooxPHNGM1EoPGtTl5tssP8BlnQwbttIniJpPU9m4F5v6RosGvhFgyOL4TcO0ukuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiqXp7pE; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a043496fdeso19756925ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726018150; x=1726622950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3LsMRu85yB/qOlSnmRAsRxtDcGqXg+1AwrMb5pI1nY=;
        b=OiqXp7pE8JVW86ucCywEm3rC/UKBhH/gS3uMm6V6lPz43ThEBEXD6WUofqXroWFpUQ
         5CZV4OlSdRAeFyLPNY4Jblw3qZ8VadYCAN5t2QjH9aUd/O4/VUXDoVKzmF6kx2kzYA54
         1CCXP0aG8biTN5iupAQLDR2hgW88POgOAz++P7KTy4A0r+3PoVCZ54o13pQAlbVRQdWN
         kZuB6p0r2g3sdWR/BpliczbNcPuWjonAUXDNXnytK/N8gxAzraEPDo9XkPLAfQMw26SX
         mj5ZyucqGcZolzUnYGZrTreAi+o+MEv22qEGPAvunSIHFKrkye1jFaXphTqsDD8nfoAy
         k5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726018150; x=1726622950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3LsMRu85yB/qOlSnmRAsRxtDcGqXg+1AwrMb5pI1nY=;
        b=MSkJDfzn/4+Dxrm541tubcNB7crLZ4hmA+3skpaXHEkNiGkrTdBoj/4s5ptDY+bGSG
         t3Omg6XUnIPb7Wnd/zgqdkfJJg74YRWrs7t8u0dSMqjzqjqP9j/lp+oAPkNtbZtytiQR
         Dd0lL/AnzwzZKmzZsOvRX6K7/FJ10ogQEnjNVT2iMCkIvaz9Vht/ZX8v7A6zh0nVZW9w
         yKB/Je4hUbKj2zwrgONOrS6fFbDwVTZuV05VABEyRZKwRx5xXwiYIf9I6AGsRTx5IFgk
         hG4qmxf3BFnRwxQzJkurxc5mgJ/+PDWVuzj5MXSnEHuBbHHYg6NL98fvLs0X69j/fvMW
         fQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHJ6zqU34hqs3Gtshp8tIS51wXPK3aVRymARVs5+f+c+Ct1N34PeKgmkbX0du1xL7m0TJ2BF2rYqE3xyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+sPBJfYKH5en2UevTvDguexEhYvrDFPuPlgEUPiAuoAlrtM+
	P1GVuU27Al5GYEoE/BTL1J7iCQfH6BSZTjJcx2znQsOewm7J8Nl3
X-Google-Smtp-Source: AGHT+IH3tx8lMHCc7+unvAj5udtcpFzie1RB7+MgSxm4JZnTaAsKyx3vroG72SZyZ+pVjJ6jy7L8Ew==
X-Received: by 2002:a05:6e02:1b08:b0:39d:351a:d0a2 with SMTP id e9e14a558f8ab-3a0576bc30emr140299235ab.25.1726018150265;
        Tue, 10 Sep 2024 18:29:10 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d094561c8csm1917945173.62.2024.09.10.18.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 18:29:07 -0700 (PDT)
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
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 2/5] phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
Date: Tue, 10 Sep 2024 20:28:08 -0500
Message-ID: <20240911012838.944630-3-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911012838.944630-1-aford173@gmail.com>
References: <20240911012838.944630-1-aford173@gmail.com>
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


