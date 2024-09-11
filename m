Return-Path: <linux-kernel+bounces-324091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FD9747C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC391C25B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0139FD9;
	Wed, 11 Sep 2024 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUE2DeSF"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008C38DF2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018168; cv=none; b=K9H1w8itPHW/e1ZX/5L7XQK2xY5oMwOy/5fgINx4JD8ZCZ30tAPDSYaQi/cLCpKImnpzoyB/HFe0iYZ+4jGxh/IXCDAYcVedxPDhVtW+X/B9OLscdOaOIx9+IbIE2+OFeENyy/eoYKXvDeNUJDXSSbccWGZSt8TC/sFE/VGs5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018168; c=relaxed/simple;
	bh=ALyOjTy8ZLxL7e4PyE7k/QDgE+2xcvS/bEF4GWf/KT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9lvapFKXP2Z2chAwtSQsDxGpNQlZMJjoVDI1Z0cqWbGHB+nPdLOxvkI35cm3reGuyL8GsSm57Bl4m5LmlwOSJsYDSIMu1WqojKGcMFWjgDdspmlDzxVYLdW/L3RfbNQnuyk697eKJa9TWMZqnNtjZXrgDqPOD5DWFnNNPxydUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUE2DeSF; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82aad6c83ecso162207839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726018166; x=1726622966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlFNTDXoXEyUpPlrrNaNANZH/5hsOx6UcWrdzrMvmoM=;
        b=ZUE2DeSFSdWhRw9GQrrlF1AB1KkjJWLHTkLtHujwWM9IiOpegb18kYG6inN7moFz0W
         RnDnaSac5mQnbIMaSeF83fFPGE6ClCYecgSQviFgixAewOJSfvbx+VsCrUmARMuVSeZO
         cUA13MgvSwE7mTK4ZeyS2rcO8dsMLk7tGW9W/ajeTrwA7Sd8XO4AqHLiSf4fuQOsJBRz
         3q3QXXnTFY91IlU1dn42rJHOVbYzVifU6UYD9sa+1L9M7P2BwDfwnAnXLTcJbQWVQ/VX
         c39V5gnRmT9bj3VE8PMno6bIJ2NktBMCD5VD/z4Eq9W1gLjMXORNAzjyg7LZX9ENOe10
         ZFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726018166; x=1726622966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlFNTDXoXEyUpPlrrNaNANZH/5hsOx6UcWrdzrMvmoM=;
        b=Aju/PkCf+P6J5ldVjRA2scjiwDLfEZDznmWHOLdcHdC3T+FkfmqYgrJkwtp2UMayvN
         4iJE2VFPHngBqm5J95wTz+jC15DuO5shrMCf7gotDcZD2LQ2fhBtN5cZk6T4lJYIotUI
         6dnyVNr3xYzSUZkLjntrsfFRtoeOjRM4V8buOvTi6yNuNklpT/dlUCN65y/hlKUu93QN
         38umxY7VtdjVJAYuq0lmLlUhjx0+yQC+nusKJl8Fi4lhhpb7Ty/49uF5A438++ZTSm8b
         61wP3XscoV/jLVnjD6Ofw02VoGIBL7Sc/rMt+wVNx7mE5vexeeHThnKm41ThhYKhCUsv
         P+rw==
X-Forwarded-Encrypted: i=1; AJvYcCWDYQQ9gzaeyzX/GZpJQNL0ysO2Aeg+4AdeTYB3NJMFdSdGZpQfZ6dE+77ALV9c23QH/CYSgIeIQqF0I74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBr9fEdt3P03TVfawN8FOcVKPWyHAKAckndJ/cJ+HsNK5abCL
	3MsVu73kfj3f+tTDKG/MvhnK9x9MkhqD89LStT09zx6Ow2tA/iRw
X-Google-Smtp-Source: AGHT+IHOlR9fu7WNIanoaxL4Cik4jU168bCe4I1AdMH1x3KQNoa+P9rSz7ffH6ZORnOkMfaOxNu7VQ==
X-Received: by 2002:a05:6602:2dd4:b0:82c:eb18:ea53 with SMTP id ca18e2360f4ac-82ceb18ec51mr1045846039f.16.1726018166381;
        Tue, 10 Sep 2024 18:29:26 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d094561c8csm1917945173.62.2024.09.10.18.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 18:29:21 -0700 (PDT)
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
Subject: [PATCH V7 4/5] phy: freescale: fsl-samsung-hdmi: Use closest divider
Date: Tue, 10 Sep 2024 20:28:10 -0500
Message-ID: <20240911012838.944630-5-aford173@gmail.com>
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
---
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
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 49317a96f767..67a28aac9c45 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -577,6 +577,16 @@ static void fsl_samsung_hdmi_calculate_phy(struct phy_config *cal_phy, unsigned
 	/* pll_div_regs 3-6 are fixed and pre-defined already */
 }
 
+static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
+						 u32 int_div_clk, u32 frac_div_clk)
+{
+	/* The int_div_clk may be greater than rate, so cast it and use ABS */
+	if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))
+		return int_div_clk;
+
+	return frac_div_clk;
+}
+
 static long phy_clk_round_rate(struct clk_hw *hw,
 			       unsigned long rate, unsigned long *parent_rate)
 {
@@ -624,27 +634,33 @@ static int phy_clk_set_rate(struct clk_hw *hw,
 		goto use_fract_div;
 
 	/*
-	 * If the rate from the fractional divder is not exact, check the integer divider,
+	 * If the rate from the fractional divider is not exact, check the integer divider,
 	 * and use it if that value is an exact match.
 	 */
 	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
+	fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
 	if (int_div_clk == rate) {
-		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
-				   int_div_clk);
-
-		fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
-		phy->cur_cfg  = &calculated_phy_pll_cfg;
-		return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
+		goto use_int_div;
 	}
 
 	/*
-	 * If neither the fractional divder nor the integer divder can find an exact value
-	 * fall back to using the fractional divider
+	 * Compare the difference between the integer clock and the fractional clock against
+	 * the desired clock and which whichever is closest,
 	 */
+	if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
+						  fract_div_phy->pixclk) == fract_div_phy->pixclk)
+		goto use_fract_div;
+
+use_int_div:
+	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n", int_div_clk);
+	phy->cur_cfg  = &calculated_phy_pll_cfg;
+	goto end;
+
 use_fract_div:
-	phy->cur_cfg = fract_div_phy;
-	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
-			   phy->cur_cfg->pixclk);
+	 phy->cur_cfg = fract_div_phy;
+	 dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
+		   phy->cur_cfg->pixclk);
+end:
 	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
 }
 
-- 
2.43.0


