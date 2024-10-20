Return-Path: <linux-kernel+bounces-373328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123439A554F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B251F222B0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70EE194AD5;
	Sun, 20 Oct 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfOis/FJ"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEC194A51
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443079; cv=none; b=WdHfe3oefruu8teV3zDnJs4bp+Yfc0/I8qO5F9IU0FpNLckDjT1hYjWyiOitNEOoKKOapC+NnwlWDa+J8jjsybJtcO+4831btO4dWmyQG5qqZyvE5FFCmQ6o6UsvkxJrmLwLLxKI8DiAtrPBBfJ+haDVyvAVXxh19jIxYngLSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443079; c=relaxed/simple;
	bh=GZHLhq4kq5diNnYQlBFrbDLEA4eqebgfI0dp/WpNj4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEg3CjJ6SmPY1occfJOPQflVQS1JhXiEcovxqqpAX3IaTy5/UiFqPBOVdVCad081b1+Rth9QPlTlKSfjfmUZRkW7BoLoelAkg3WYnXBrn+lAbknjXsNIH7Klv9HbuyyVcAaojlEDHiP82icNa4dHu9Rqp8FfgZPt/klomOaImUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfOis/FJ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3b98d8a7eso13073505ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729443076; x=1730047876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4PED3h42QBV+YaBIauxPbyLrEm2xxjav8Dffh6+wwU=;
        b=YfOis/FJyYQ1nS33F9ajSo5tYin5FPjVzLr2SrYfKgkxoZGpwdQzORIVrYjIyMN8Fn
         rO+Ioc4/cLVx9SBkYlRKEyPU0I5Yl2+ruXRqj79mC33DE2fsptsSpqlaHAjPoalkUk7C
         rve4fMvPyz7YGiBEbc5QlpimkPSfGJHTD+QUbHYutOMP5X/gUcsfvxsm+u+AOUMwocOP
         eJrJJwErQjDnZvBbDWXKJABu4medpGdsUpb5z070uAIQetEMrW+PCQRg/rNOtGyi3OES
         LAH687kRvFVtKrEkr5YiDbGSveLgCNBEKpb1kqH9u2FwZGc8+i3jPVRqskAGGvaWRGls
         ZLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729443076; x=1730047876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4PED3h42QBV+YaBIauxPbyLrEm2xxjav8Dffh6+wwU=;
        b=bOF5SMlogqbw7sTzd/GuRVeaGn0Ds0ZsoGOntYuz1u8Ma0cPzPZADxFDwkkXB0vtNY
         qh6lm4dRvaa1BoHrmjSLgmwGzY5Pb9Bt6XUBm4YS262TzHkoh5EmMnqseIWBKESP5vzE
         LLLCzuaOLTA1gwJP8orC8Ae7p0XP/BwmRmm8zZXiVKHX+0zKyutNlR6Azj4jhuFjT4dA
         LHTVsRVEHfnRwW40m5MID7M8zXqu2NJfjd6sAXFsj2dXAescvtsXgXMYZk+cjtohQZGF
         6wbSmUGIJYfbXoYDECL1ckyRImp/JkFc7NwLUdjveLMnnyxE6ih5HC8680Cc2ojD7OdW
         3lww==
X-Forwarded-Encrypted: i=1; AJvYcCXxqRMrVMmhO45GQf8dZybqJkUG4pW3eMVVwnZJNo8FvVY2PhKbmY6IZg+RAbjRR/zfbp5gbmuuAbfUWY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtbgFNE2WGCquWywkCGF2/EyWEbwGl2Ke0vO+6SCJgFa7jors
	M0mLJN7sgStOwQVL1AvSNiCMP70VIYu5Mm078+jNOnHEM4dfUxlJ
X-Google-Smtp-Source: AGHT+IHH2y8nl7UH4g5w15MP7jiZ7UfDxgkm0T52N9hzFqOm27QrT3RjtYmQFfua2l0RZFUrcEYtHg==
X-Received: by 2002:a92:cd83:0:b0:3a3:96c4:29bc with SMTP id e9e14a558f8ab-3a3f406fe98mr81856035ab.11.1729443076248;
        Sun, 20 Oct 2024 09:51:16 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net. [75.72.162.184])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fab3sm533821173.35.2024.10.20.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 09:51:15 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] phy: freescale: fsl-samsung-hdmi: Clean up fld_tg_code calculation
Date: Sun, 20 Oct 2024 11:50:47 -0500
Message-ID: <20241020165102.340838-3-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241020165102.340838-1-aford173@gmail.com>
References: <20241020165102.340838-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the calcuation for fld_tg_code is based on a lookup table,
but there are gaps in the lookup table, and frequencies in these
gaps may not properly use the correct divider.  Based on the description
of FLD_CK_DIV, the internal PLL frequency should be less than 50 MHz,
so directly calcuate the value of FLD_CK_DIV from pixclk.
This allow for proper calcuation of any pixel clock and eliminates a
few gaps in the LUT.

Since the value of the int_pllclk is in Hz, do the fixed-point
math in Hz to achieve a more accurate value and reduces the complexity
of the caluation to 24MHz * (256 / int_pllclk).

Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 32 +++++++-------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 719f8972cb5a..0bfe0c0907a0 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -331,25 +331,17 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 {
 	u32 pclk = cfg->pixclk;
 	u32 fld_tg_code;
-	u32 pclk_khz;
-	u8 div = 1;
-
-	switch (cfg->pixclk) {
-	case  22250000 ...  47500000:
-		div = 1;
-		break;
-	case  50349650 ...  99000000:
-		div = 2;
-		break;
-	case 100699300 ... 198000000:
-		div = 4;
-		break;
-	case 205000000 ... 297000000:
-		div = 8;
-		break;
+	u32 int_pllclk;
+	u8 div;
+
+	/* Find int_pllclk speed */
+	for (div = 0; div < 4; div++) {
+		int_pllclk = pclk / (1 << div);
+		if (int_pllclk < (50 * MHZ))
+			break;
 	}
 
-	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG(12));
+	writeb(FIELD_PREP(REG12_CK_DIV_MASK, div), phy->regs + PHY_REG(12));
 
 	/*
 	 * Calculation for the frequency lock detector target code (fld_tg_code)
@@ -362,10 +354,8 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 	 *        settings rounding up always too. TODO: Check if that is
 	 *        correct.
 	 */
-	pclk /= div;
-	pclk_khz = pclk / 1000;
-	fld_tg_code = 256 * 1000 * 1000 / pclk_khz * 24;
-	fld_tg_code = DIV_ROUND_UP(fld_tg_code, 1000);
+
+	fld_tg_code =  DIV_ROUND_UP(24 * MHZ * 256, int_pllclk);
 
 	/* FLD_TOL and FLD_RP_CODE taken from downstream driver */
 	writeb(FIELD_PREP(REG13_TG_CODE_LOW_MASK, fld_tg_code),
-- 
2.45.2


