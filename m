Return-Path: <linux-kernel+bounces-314081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD296AEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB80E1F276BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF24AEE6;
	Wed,  4 Sep 2024 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrm9dT0z"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104547A6A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417212; cv=none; b=ZsdsMmwpRSypL9tDRf2VIin2/eOwON8uFl439/45b0cC6xIduKpqoLDUGIjLmDDjXNpy6zsJf1gWjsZKKEF0q0H++6oY4yWKBzDmKPaVhbirdxB96egAbvfRVxO+Q5+hA5mwJo5jM6M917oluZQXIe+20odYQHbwIvDf69Hgvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417212; c=relaxed/simple;
	bh=rUnFGtz8cBSbNYS+R3XI9OduPh5g08bIrP9s1b9diVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zgf9LJW7FgijYNy/8ujd8htLXvf3KKc2VlgSBVxQRyzYpgYa2Kd54vPcECQBj/tgbL78KuHfmyKOUWBur0lk8Yco2f0gOQt7jrlEzbgftd1Fi079au2Rriy8tKtADtqfqV+2dfWn/lQmydjlJpgvTBcHe44LW233lW6EjeK83pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrm9dT0z; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39f4ff22a49so14999235ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725417210; x=1726022010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmNqbg3yGfYLTkXW6S6jugsOEeVckNDMDMzxEWmAPPQ=;
        b=jrm9dT0zpn1N4lKkVL/0jfCaNI/ErWlxL1jMl/4vt3aN9+N99qR8RhgZbRY8XzS2m1
         f/+QwcJ3gF51KS7dfCbPmpMxDC9Z2j4UD79oTXzD1ekGO1UIrYKJNdbaEO/2zkM3rcO1
         vpIjvutMKPOdpD3f9PoaYKTuZUwlkF8hxYwnbNsKYADPf/daJkNBj7y4uGVAm8QFNKNy
         FbP1TMLwceCgEIwdejJvjbv3UJfhCv20x3EnZqJJPuJkpqBizRODeNlEWiJg48nwdQpl
         JLhK9Pql2aa/kASMrV0/Sm9JjVfQdRIO/CeztwBLJ/vEp4HSwzQyf9Wt+IkYapQUZiOv
         JETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725417210; x=1726022010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmNqbg3yGfYLTkXW6S6jugsOEeVckNDMDMzxEWmAPPQ=;
        b=Cv1IHDBcQNxMg2XR6DmZE/ZACES2TCsowEenSk1F1gaRapcUJpY6jT2IPr989zGQT6
         hRGD6kEu07KL6aLHJUbC5gI2AEaa6Oh6cFGowD6bsJf+CXy2KbEmHqfWt/E9Lelwrk1e
         +gLcLkLA6s04MwrAjdbk9fqLmOtQ8Tx2RzHTik6TaNQ3N8Ytj4Um2upT/b3xAKeIUdBd
         sJgWPZOJ0P78Mxd8XQ0zX8/sg3YqZVCFGch5FA7lW5sL+np3deFbBE8oubaFkOYqvuaK
         ekBATg4ELe2rETOQ9QuF1k1yq/q6kJUtDhi0V99Iz/Ictt+IWqWcX9htx0uA/2dLEA1Q
         OGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIiEwd0KfNI0v7Rvf3JtdaWa47dypGJ5auP2lSbBJ+lWsfn4b0P7qHXi31P/pq3ZsTok5WR9hSESCcDmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFV/ancrXOkIRxGnM2Aavc4HriBhI9XL/R0AzXL4eQSC2cpW1
	SoNuXajDromyrC2PctJGYrIeosyeQCjDF1EU5+6wbsva5PT9GX9c
X-Google-Smtp-Source: AGHT+IFaGu+OSpFyIJd0ANhd9Us1h419LPnKpM02Mf6Qgk65tlbE7dDOn+Xko3A33H/1hBlPw6Rxxg==
X-Received: by 2002:a05:6e02:b45:b0:39f:577d:8979 with SMTP id e9e14a558f8ab-39f577d8b15mr115501415ab.22.1725417209676;
        Tue, 03 Sep 2024 19:33:29 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc4ff6sm34556175ab.37.2024.09.03.19.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 19:33:29 -0700 (PDT)
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
Subject: [PATCH V5 2/5] phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
Date: Tue,  3 Sep 2024 21:32:41 -0500
Message-ID: <20240904023310.163371-3-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904023310.163371-1-aford173@gmail.com>
References: <20240904023310.163371-1-aford173@gmail.com>
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
---
V5:  No Change
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


