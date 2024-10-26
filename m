Return-Path: <linux-kernel+bounces-383207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC869B187A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5921F233E6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00E1D6DC4;
	Sat, 26 Oct 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D303b/Mp"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F481B641
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948851; cv=none; b=t8plCaVmUDlLxgoLlbuTAqJO/Wb622tPib+WDX4DOdr0+oMKNNKn/dVdSYAM8VdcP+iMycWVnTmpCxo7RJYAqOU6/pyNXIKggK92nuZhP7GaPtjy8XYtS3h4eNebCtTfwilbZf000PuRh4n80lRkpAONaSoqIJHqaOkdiIckEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948851; c=relaxed/simple;
	bh=DBMSEFR8GWRKbcYASoUVhk82KanL4RPwZwlMeoTP0X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doAFF750OrYhGGjxLQekWvMoSICpirJ7OQb3xTyaUPzSfy0xAeFyEeNwRoAZFULKvzO4a4ZePfLV8Z8dzi6aVSCU5j2AxruyJXMujnBgolX2E8egbIneJ4DmmUexNnTXmZdJEdjKDZ7UCyyzmEYuoWeF99hJuN5g9W9ZiDqXVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D303b/Mp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4611abb6bd5so16334751cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729948848; x=1730553648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SEXUwNq69Lxz2+rJU+Fb+Wv+ryIv6HHBu9+ALfzWIM=;
        b=D303b/MpAWVGUQ2Oib4dhGdnrHX9bxLzATqTzbQ7gyoGb2Qty0fAT5381hEBg21sHC
         IAWMDAUKNUbi0iBJIc3F8TptDzEVPLOx1UEOUnb/A1SbXCQhJg6YHRNO75ltgRjHfDZd
         /EKwIq+BK8YjiD5q9LikITnMoBrRC9o8dnprCjqKTvv3WUeNbOp2fI9vq1G3ooGBSP/h
         9xQ++rSP9jJmmU37LfwihXHhap2C+5ry/KzsyEqYPzVcl1rsS+9fwWfvBceKG/hryf/3
         GPi9G3ODRwhJOoHWS0bFLi3RQROb7yMuVauiE7spPQzV0uh3sZZEaAcOkDIysFgadzSU
         3vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729948848; x=1730553648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SEXUwNq69Lxz2+rJU+Fb+Wv+ryIv6HHBu9+ALfzWIM=;
        b=NsJ98BzhFgULBML2Tho6ZC4qQSlqo+HxhcjRoS0QtLkRuKuda46N+GyK1/5zlrwIzv
         cFt2OM8H0s12Ye5DV3gs++vyAbIo9SrgXPn2qDMRj1CMZfvRjdDBHQ1gySD+KitDRduw
         wEuf50/XJ2xJAesNAnjfdt+XY84rY5Ws2+H71jVYxRTGuShg9nPwjHIlse2iiExQn9VU
         wmn7ch2J0O9DpiteUIcyxyXAOlsqPhWHUliwjLvbRs7S/gRwmA8tp7dotn35rWNHeriC
         K2mXniZlGUbqAPyJpl9Fo26UmhhUkAF9SbCxbfAglxeU+QsiBnjMzru+Gb+lDLiSzAdf
         X4sw==
X-Forwarded-Encrypted: i=1; AJvYcCXMrBV4EPB4MK4OHKNk3ZEyYLFkqf2PWu5mIC8sBkVUl1+jj4pafMk+G/Yop81uesGo3mW+K61L5/BES3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9xQ5tjNdwnD/g9qnEjB9jl5GCHIQ4jo1nCeGjzVlLrcYy1HJ
	zJUUI3rJNkWT+hLMGhvUxvs+2roXfAaqcgR5UWJuHPCSGBdv6IjB
X-Google-Smtp-Source: AGHT+IH46XosSRPTVvmPfs9D+20b96VP9CGzbRxqUxFucRtXiWXaKWZjWuE5wDGB97MeNbRY2AFijQ==
X-Received: by 2002:ac8:5946:0:b0:461:141b:47a4 with SMTP id d75a77b69052e-4613c083788mr40894821cf.36.1729948848129;
        Sat, 26 Oct 2024 06:20:48 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net. [75.72.162.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613211a1b2sm16372741cf.12.2024.10.26.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 06:20:47 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com,
	sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] phy: freescale: fsl-samsung-hdmi: Clean up fld_tg_code calculation
Date: Sat, 26 Oct 2024 08:19:59 -0500
Message-ID: <20241026132014.73050-3-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026132014.73050-1-aford173@gmail.com>
References: <20241026132014.73050-1-aford173@gmail.com>
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
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
V2:  No change

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 121f67455cec..5eac70a1e858 100644
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


