Return-Path: <linux-kernel+bounces-312018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCB89690F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C67C1C22660
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077B1CDA06;
	Tue,  3 Sep 2024 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsPLrnUI"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A01CCEFD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327097; cv=none; b=XXNQ04kucE+VzFcuzQScFva+m13H5r4qP2obq4WEyk2nlWG0bXzgU7j7oayxdA2V8m57uIw6bIRiHkC23j+BWivz8WiHFPcYNYl1wOgEN8mTvM6njUoNBboDPY/45gZviHPV+/evevR6u0/F+ct5GFtFLADSzeS2XOdxrRQiu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327097; c=relaxed/simple;
	bh=2KEsNWSHB9EcLDWaALj0R/0FWZ3PB+ji0y2f+6UTdmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVi1p8pnC8O0xy7tCwco7Tg1GB0wjFh2wPf0hlIZp71ap6kf68qzach2JVsdoqezgET3zVN3P+gPSpubNC2fOqZG2XcufO/ThtsDDfDfa/72A96jbgAzhaphwCCZztcrRPIHZl3ugza3d01foow30PKrVYYpKMI0vwhH8LUthJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsPLrnUI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so17567805ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327095; x=1725931895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wVQDkoBZtHEQkKMZT4UIQ8IV+tatzzx9ZIraz0AFHI=;
        b=TsPLrnUICVJzxSEbJETi0nkuAE6KXbsgswIP81e+d593DRaTmMvby4gd5DgF/ZX/TU
         wkgBU6/gKbFSKfg7Uvd5n/5D2ZUIUdUOdyW+9nkvy1brAGeCj2UVjLl7fAjWlTs1GkTN
         IsiXIEa4neetvqa/3K2IXIfsMPP1UQI2U44kVc5b/FoAvvjQAKiOYdSWdJHjj0ZWsByo
         +/O5LvXxrShXXLYU81sc9mIN99EwlSHninxkfeAnAjdRwqlIzG0YJp93Ca2RP0hhjTkl
         LSfgdJmisjkiYvFNDLZXgf3QkKsWPl+phfBMeCSIyUMHL3rAmmoHhqJRPbAMuyTb69C+
         FbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327095; x=1725931895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wVQDkoBZtHEQkKMZT4UIQ8IV+tatzzx9ZIraz0AFHI=;
        b=reiIDIjfsy9MIkCLz5nr1RpDFEwnj0ssU/bc23vEhil+WxQ/ePAcv8lZhAKHVJt31/
         XkoFX8IwjvCQa7wi/azWqrTuS5ZDbCIb/cukVuD45hckFcbhtECRlB8negxMV5qczi2A
         EveFxWi1lqCccCQtW3F9Lq8FfoHt8f5H1CIlJ74FNcNyVmtqBEZoIzPmyHuQr3tyvCoY
         YAbYCN7VvjS4C2GICxcL6T9TKDwDoeWNlnJ8Mlt+N5xA+vFtTSAieQ6rVR/w1rut3ltR
         0+cQUBv8cvlj4y0dQ+xHAmD/wketT7eEb5SZbTDxG522nCd4y9du1gZHMEAm3xbRK2q5
         VVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8wN3UJJPOAdhDapwxYTJxnWJP06TuzJ6TrxNAl8P1BJ7sIrOJhydEpzqhNqUwymoblEyTTLqaoQoLtOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwarwBHhabpzBZRrrxG8ceDEeGsPAjeBrsi2yvowTk9/huYnc
	CfCbmbT6nZc5EE7JsYDp/uNgL1T4PxAe4ShUncc4v5WEymJ59kn1
X-Google-Smtp-Source: AGHT+IE0MGF4aNsgfVs4SXY+HfrnvzcV+aUNnWbo1l7pAkhO8tS/DkTg/rkSwfteXsUIx2VFq8s2kQ==
X-Received: by 2002:a05:6e02:1a29:b0:39f:61e4:1ad8 with SMTP id e9e14a558f8ab-39f61e48be4mr46839095ab.26.1725327094959;
        Mon, 02 Sep 2024 18:31:34 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b059c32sm28466715ab.75.2024.09.02.18.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:31:34 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/5] phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
Date: Mon,  2 Sep 2024 20:30:44 -0500
Message-ID: <20240903013113.139698-3-aford173@gmail.com>
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

The value of 'S' is writen to two places, PHY_REG3[7:4] and
PHY_REG21[3:0].  There is a lookup table which contains
the value of PHY_REG3.  Rather than using a switch statement
based on the pixel clock to search for the value of 'S' again,
just shift the contents of PHY_REG3[7:4] >> 4 and place the value
in PHY_REG21[3:0].  Doing this can eliminate an entire function.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 39 ++------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

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


