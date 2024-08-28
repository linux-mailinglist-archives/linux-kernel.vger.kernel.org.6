Return-Path: <linux-kernel+bounces-304233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179A961C52
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F379C284DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4D7316E;
	Wed, 28 Aug 2024 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K477T/kU"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BA44964D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813304; cv=none; b=k40sqzzgBbm1Lba0H3JQPuhvdtXako/Qy9llzKVSX3qYbgbMIph0mU6WiW5y4zTxuqFnwLEIX3eqpLM9FJDlWab6/TzORhncYzQkOjm/flH1lXII9/439UzT2K7CRpd1Ol3NJzCDor+LbzgjN6e01hAP9DS79WG8ggaa0DUfy8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813304; c=relaxed/simple;
	bh=YHodXqUsatHD6qYxpxNKeQYHH1oxlbPVOIz9qpV2M4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNPpNoeZIpf9G99NVLsEXdDH83reKAmpv3m8D/roCy88U4fnNomR3bnJ+O+bkBOqgP1TQ5hP0YdgrkQFJAEj219Q5AjQKdega0/nsPSABfsidtuqlnECrXuI2qnpvPetZFOj58D+qlkQORiGfPtIbeAyzwZH5A66iJqm2pfBxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K477T/kU; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fd520fee5so237525139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724813302; x=1725418102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMUXRB0PCYmOizO9nlqx6R7KKS9cq+ndpmvAnug7G6o=;
        b=K477T/kUrnyJisrRR1Jwv4a/zj4ZFkdWqUIsug77k79B8aYyAr9vxfwbgQYOdC0Vob
         o12ivGuMkXtPpTvDODZHXB87oZpbD2IAQB5JKzxJbV3+Kzb38rtg3gvbrkJtpdQ9uEVa
         lpSU03PKY3nLSQOSmm9ZHcSRvJUoFUW54KrUtQ2npCW1WxEP0Jul1qYEGPZGPyo86nIq
         HRJqzTvwAWfH3vjZQWLzMbpyKbdi8+V+lvOUYZdFtW2CG/d/TBBSx1H/UwRnICGgL3CR
         KIY9x4nlrznlB1IhwdA9CgwPX93kTm9Dp73hCKlExe1ulmFsozqt/15x63O/P8hfXbgg
         s/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724813302; x=1725418102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMUXRB0PCYmOizO9nlqx6R7KKS9cq+ndpmvAnug7G6o=;
        b=oamh0uGzWwMmPJqR78/ZAwBsQkvxtYtLSlX3W1dXXyHfzAYVUEOG8qx6n8N1kLy2qI
         nOVivFgEzCD56P0BDvHKWJG7NTKuenC/zhIM3j/94cfCh0HiP0sWQvqinfjnKk3k/lGt
         ZBqE12QVzfnKkoCsjjV7kMyjAS8hOYgTc4ubDY6uZ0oDcf02N3yUsnqSisUbGVX5/MRx
         EkcvpbbbQrYFlOJV2YA4dyDPQrNTZPrWZXFeagwf4oiNI0RtEVqG0iHuxdT2BC5Ue36S
         LcHHXFmsWws/G9pRru2Plnsjjby/J2yMuKLGTIwNuueeZ9h04wM+BpQTLi6oAlEIft7G
         07yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkhqaLOMDUR02jhYWs2tigB/+t33Dv+vo8L9J1XA7aPyveYpiKY/53F2MkVa7o0OJco2+VomiJbFLP1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49y2K+FB1eypwq6Lysad7dxvKMltVNRDOzV5tPsTjZ76xQ83y
	eKAkHtb56Nal2i/6nFdUhucYxJ+nid6Ivhqvvif6jcn/LDQBtTZp
X-Google-Smtp-Source: AGHT+IG+CMpOmVxzIFWphyCWp4fqELKUKLn9HsA3utj9B19Fci75uvN1NRjiA5H4goIAKSa/J3kMJA==
X-Received: by 2002:a05:6602:608c:b0:825:2f0:9f74 with SMTP id ca18e2360f4ac-82a041996bamr82818839f.16.1724813301854;
        Tue, 27 Aug 2024 19:48:21 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce71140ee6sm2838530173.170.2024.08.27.19.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 19:48:21 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/2] phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
Date: Tue, 27 Aug 2024 21:48:01 -0500
Message-ID: <20240828024813.1353572-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 47 registers defined as PHY_REG_xx were xx goes from 00 to
47.  Simplify this by replacing them all with a macro which is passed
the register number to return the proper register offset.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 9048cdc760c2..bc5d3625ece6 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -14,76 +14,20 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#define PHY_REG_00		0x00
-#define PHY_REG_01		0x04
-#define PHY_REG_02		0x08
-#define PHY_REG_08		0x20
-#define PHY_REG_09		0x24
-#define PHY_REG_10		0x28
-#define PHY_REG_11		0x2c
-
-#define PHY_REG_12		0x30
-#define  REG12_CK_DIV_MASK	GENMASK(5, 4)
-
-#define PHY_REG_13		0x34
-#define  REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
-
-#define PHY_REG_14		0x38
-#define  REG14_TOL_MASK		GENMASK(7, 4)
-#define  REG14_RP_CODE_MASK	GENMASK(3, 1)
-#define  REG14_TG_CODE_HIGH_MASK	GENMASK(0, 0)
-
-#define PHY_REG_15		0x3c
-#define PHY_REG_16		0x40
-#define PHY_REG_17		0x44
-#define PHY_REG_18		0x48
-#define PHY_REG_19		0x4c
-#define PHY_REG_20		0x50
-
-#define PHY_REG_21		0x54
-#define  REG21_SEL_TX_CK_INV	BIT(7)
-#define  REG21_PMS_S_MASK	GENMASK(3, 0)
-
-#define PHY_REG_22		0x58
-#define PHY_REG_23		0x5c
-#define PHY_REG_24		0x60
-#define PHY_REG_25		0x64
-#define PHY_REG_26		0x68
-#define PHY_REG_27		0x6c
-#define PHY_REG_28		0x70
-#define PHY_REG_29		0x74
-#define PHY_REG_30		0x78
-#define PHY_REG_31		0x7c
-#define PHY_REG_32		0x80
-
-/*
- * REG33 does not match the ref manual. According to Sandor Yu from NXP,
- * "There is a doc issue on the i.MX8MP latest RM"
- * REG33 is being used per guidance from Sandor
- */
-
-#define PHY_REG_33		0x84
-#define  REG33_MODE_SET_DONE	BIT(7)
-#define  REG33_FIX_DA		BIT(1)
-
-#define PHY_REG_34		0x88
-#define  REG34_PHY_READY	BIT(7)
-#define  REG34_PLL_LOCK		BIT(6)
-#define  REG34_PHY_CLK_READY	BIT(5)
-
-#define PHY_REG_35		0x8c
-#define PHY_REG_36		0x90
-#define PHY_REG_37		0x94
-#define PHY_REG_38		0x98
-#define PHY_REG_39		0x9c
-#define PHY_REG_40		0xa0
-#define PHY_REG_41		0xa4
-#define PHY_REG_42		0xa8
-#define PHY_REG_43		0xac
-#define PHY_REG_44		0xb0
-#define PHY_REG_45		0xb4
-#define PHY_REG_46		0xb8
-#define PHY_REG_47		0xbc
+#define PHY_REG(reg)		(reg * 4)
+
+#define REG12_CK_DIV_MASK	GENMASK(5, 4)
+#define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
+#define REG14_TOL_MASK		GENMASK(7, 4)
+#define REG14_RP_CODE_MASK	GENMASK(3, 1)
+#define REG14_TG_CODE_HIGH_MASK	GENMASK(0, 0)
+#define REG21_SEL_TX_CK_INV	BIT(7)
+#define REG21_PMS_S_MASK	GENMASK(3, 0)
+#define REG33_MODE_SET_DONE	BIT(7)
+#define REG33_FIX_DA		BIT(1)
+#define REG34_PHY_READY	BIT(7)
+#define REG34_PLL_LOCK		BIT(6)
+#define REG34_PHY_CLK_READY	BIT(5)
 
 #define PHY_PLL_DIV_REGS_NUM 6
 
@@ -369,29 +313,29 @@ struct reg_settings {
 };
 
 static const struct reg_settings common_phy_cfg[] = {
-	{ PHY_REG_00, 0x00 }, { PHY_REG_01, 0xd1 },
-	{ PHY_REG_08, 0x4f }, { PHY_REG_09, 0x30 },
-	{ PHY_REG_10, 0x33 }, { PHY_REG_11, 0x65 },
+	{ PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
+	{ PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
+	{ PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
 	/* REG12 pixclk specific */
 	/* REG13 pixclk specific */
 	/* REG14 pixclk specific */
-	{ PHY_REG_15, 0x80 }, { PHY_REG_16, 0x6c },
-	{ PHY_REG_17, 0xf2 }, { PHY_REG_18, 0x67 },
-	{ PHY_REG_19, 0x00 }, { PHY_REG_20, 0x10 },
+	{ PHY_REG(15), 0x80 }, { PHY_REG(16), 0x6c },
+	{ PHY_REG(17), 0xf2 }, { PHY_REG(18), 0x67 },
+	{ PHY_REG(19), 0x00 }, { PHY_REG(20), 0x10 },
 	/* REG21 pixclk specific */
-	{ PHY_REG_22, 0x30 }, { PHY_REG_23, 0x32 },
-	{ PHY_REG_24, 0x60 }, { PHY_REG_25, 0x8f },
-	{ PHY_REG_26, 0x00 }, { PHY_REG_27, 0x00 },
-	{ PHY_REG_28, 0x08 }, { PHY_REG_29, 0x00 },
-	{ PHY_REG_30, 0x00 }, { PHY_REG_31, 0x00 },
-	{ PHY_REG_32, 0x00 }, { PHY_REG_33, 0x80 },
-	{ PHY_REG_34, 0x00 }, { PHY_REG_35, 0x00 },
-	{ PHY_REG_36, 0x00 }, { PHY_REG_37, 0x00 },
-	{ PHY_REG_38, 0x00 }, { PHY_REG_39, 0x00 },
-	{ PHY_REG_40, 0x00 }, { PHY_REG_41, 0xe0 },
-	{ PHY_REG_42, 0x83 }, { PHY_REG_43, 0x0f },
-	{ PHY_REG_44, 0x3E }, { PHY_REG_45, 0xf8 },
-	{ PHY_REG_46, 0x00 }, { PHY_REG_47, 0x00 }
+	{ PHY_REG(22), 0x30 }, { PHY_REG(23), 0x32 },
+	{ PHY_REG(24), 0x60 }, { PHY_REG(25), 0x8f },
+	{ PHY_REG(26), 0x00 }, { PHY_REG(27), 0x00 },
+	{ PHY_REG(28), 0x08 }, { PHY_REG(29), 0x00 },
+	{ PHY_REG(30), 0x00 }, { PHY_REG(31), 0x00 },
+	{ PHY_REG(32), 0x00 }, { PHY_REG(33), 0x80 },
+	{ PHY_REG(34), 0x00 }, { PHY_REG(35), 0x00 },
+	{ PHY_REG(36), 0x00 }, { PHY_REG(37), 0x00 },
+	{ PHY_REG(38), 0x00 }, { PHY_REG(39), 0x00 },
+	{ PHY_REG(40), 0x00 }, { PHY_REG(41), 0xe0 },
+	{ PHY_REG(42), 0x83 }, { PHY_REG(43), 0x0f },
+	{ PHY_REG(44), 0x3E }, { PHY_REG(45), 0xf8 },
+	{ PHY_REG(46), 0x00 }, { PHY_REG(47), 0x00 }
 };
 
 struct fsl_samsung_hdmi_phy {
@@ -442,7 +386,7 @@ fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_samsung_hdmi_phy *phy,
 	}
 
 	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
-	       phy->regs + PHY_REG_21);
+	       phy->regs + PHY_REG(21));
 }
 
 static void
@@ -469,7 +413,7 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 		break;
 	}
 
-	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG_12);
+	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG(12));
 
 	/*
 	 * Calculation for the frequency lock detector target code (fld_tg_code)
@@ -489,11 +433,11 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 
 	/* FLD_TOL and FLD_RP_CODE taken from downstream driver */
 	writeb(FIELD_PREP(REG13_TG_CODE_LOW_MASK, fld_tg_code),
-	       phy->regs + PHY_REG_13);
+	       phy->regs + PHY_REG(13));
 	writeb(FIELD_PREP(REG14_TOL_MASK, 2) |
 	       FIELD_PREP(REG14_RP_CODE_MASK, 2) |
 	       FIELD_PREP(REG14_TG_CODE_HIGH_MASK, fld_tg_code >> 8),
-	       phy->regs + PHY_REG_14);
+	       phy->regs + PHY_REG(14));
 }
 
 static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
@@ -503,7 +447,7 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 	u8 val;
 
 	/* HDMI PHY init */
-	writeb(REG33_FIX_DA, phy->regs + PHY_REG_33);
+	writeb(REG33_FIX_DA, phy->regs + PHY_REG(33));
 
 	/* common PHY registers */
 	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
@@ -511,14 +455,14 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 
 	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
 	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
-		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG_02 + i * 4);
+		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
 
 	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
 	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
 
-	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG_33);
+	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
 
-	ret = readb_poll_timeout(phy->regs + PHY_REG_34, val,
+	ret = readb_poll_timeout(phy->regs + PHY_REG(34), val,
 				 val & REG34_PLL_LOCK, 50, 20000);
 	if (ret)
 		dev_err(phy->dev, "PLL failed to lock\n");
-- 
2.43.0


