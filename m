Return-Path: <linux-kernel+bounces-304234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7F961C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA191C22858
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555E482EB;
	Wed, 28 Aug 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7gkumkt"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867D12EBE9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813309; cv=none; b=upVFRKwPNSlyR0hvIsYXVSPHP7Lxi4UMDpt+Mvi/i6oIAUI8r1nO642f6H+2DrNxiH2BEcuDoXHVjuSKNYJvmH6X5K0TZGzCE2sKYPrBxkqD3oiZOm3jb+iPrcCXv2HLxcM8bIilEpUMiRtuXTMtYM5WJ+exTOxGivk1FQJIS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813309; c=relaxed/simple;
	bh=6bSPtozHQsMj/kYua0d0HBoiB8CfOYKpp3goJ+lSCCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYri8xHrKhv6DvczWmDFIf4mz39cz0Co5Jr1CxgfUnQRa6nXtt3Qw6RPsLNR/Q/wA7YX2/BxpTsZmjQTLMPiaDcHvo9IstKuU1mXwLXGvOibqWP+trEB95utuqs00+lQMDHACmmkbbT6liG9rCtB0VgIPWdXygdpiWVgRXQoqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7gkumkt; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so311088739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724813307; x=1725418107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slZK3kwPJTk1YegpkiC0OGClCbpXUDIaO/7ScMP6y88=;
        b=K7gkumktTzuavjttU2rX6S6w/hlW91G6BNwaoEz+0ChbWAgmIrskTiE7Kl6/JFyq07
         ZI86TDdhNki2aswRL0Gnly+UMmHPONGODh6jPj8+8qTzlUDM4X5443nfPL3xRrG7HqEh
         r+LDkSHgmA3jo3wZW5PNF+v3EGG8uUCKdy+CmxYbUC3v9zTtIoPjv0Bv2wQ8hD81n5sn
         JIPCY5c0l4k2hhkvDLte5SOhFkUOrt3MlFDoIsW9WZnBW+ho1fcLVc9FeTbhWQg62YtZ
         FTWD2GnWg1/ZZ96YNLrgRmipkaX21KLyZglNb7RbmyF6fuc460kST19LWD0fazPFWuUY
         XJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724813307; x=1725418107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slZK3kwPJTk1YegpkiC0OGClCbpXUDIaO/7ScMP6y88=;
        b=m39RFQqMF2vDTQ2Z+g2yq9dYLLX1UeCEby7iw/vkDfqROPY8zgtb5SAGJokeFr4Mz4
         vp5c86hwBW1UXGDX08/oSJP05AzI0rboooyq6makiS/Pl90mcFNlnfNtixqZqU2ucesU
         eULHLsp0oz9s4vmwmAbCkgloUIoMUg1+adBx6chUBcY4KcF0mqbr6yIVcUJrXsgG1vNX
         HS81BaqwOVvaRb5gNZbWAaufZVO44miN2LeeZkuEKq1/4rXCP4Nh7ZZFA3T+4YLit8zi
         3ny+Z/qUPyI6lzi0Ro1kBsSMQ/m6yg/C/z4gS/oAafJewbkLUn3DYaoMryOK87OnPKPH
         JCZA==
X-Forwarded-Encrypted: i=1; AJvYcCWGaBUGn6b/541d/BZP4JUNwiUrQnzvtcVqQx615Zbtr2yhX7CoVJbcjyyGwaYQnMdLBuPkOf1K7zoac0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQoZlVOfXzYIUrXC7NGf+ctGFDAdDJNQGQAYmdWXdvDMvb3st
	RbSfxD6UuWMmnGJiX1B2HvnA+J6p3QXDkRbbnEEAfkQJFJn4G2zA
X-Google-Smtp-Source: AGHT+IF4pbSmUMk0Q+rA+srN18cecFIGjTH7XlYmBzXh6ZUSfJGZQ92XHgexHHd1SW+m/bBnQIg/Aw==
X-Received: by 2002:a05:6602:13c8:b0:824:d752:986 with SMTP id ca18e2360f4ac-82787387f9amr2059918539f.16.1724813306993;
        Tue, 27 Aug 2024 19:48:26 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce71140ee6sm2838530173.170.2024.08.27.19.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 19:48:26 -0700 (PDT)
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
Subject: [RFC 2/2] phy: freescale: fsl-samsung-hdmi: Support dynamic integer divider
Date: Tue, 27 Aug 2024 21:48:02 -0500
Message-ID: <20240828024813.1353572-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828024813.1353572-1-aford173@gmail.com>
References: <20240828024813.1353572-1-aford173@gmail.com>
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
resolutions without having to update the look-up-table.  If the
integer calculator cannot get an exact frequency, it falls back
to the look-up-table.  Because the LUT algorithm does some
rounding, I did not remove integer entries from the LUT.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index bc5d3625ece6..03b598f734e7 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -16,6 +16,8 @@
 
 #define PHY_REG(reg)		(reg * 4)
 
+#define REG01_PMS_P_MASK	GENMASK(3, 0)
+#define REG03_PMS_S_MASK	GENMASK(7, 4)
 #define REG12_CK_DIV_MASK	GENMASK(5, 4)
 #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
 #define REG14_TOL_MASK		GENMASK(7, 4)
@@ -31,6 +33,10 @@
 
 #define PHY_PLL_DIV_REGS_NUM 6
 
+#ifndef MHZ
+#define MHZ	(1000UL * 1000UL)
+#endif
+
 struct phy_config {
 	u32	pixclk;
 	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
@@ -440,10 +446,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
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
+	for (_p = 1; _p <= 11; ++_p) {
+		for (_s = 1; _s <= 16; ++_s) {
+			u64 tmp;
+			u32 delta;
+
+			/* s must be even */
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
+	u32 desired_clock = cfg->pixclk * 5;
+	u32 close_freq;
 	int i, ret;
+	u16 m;
+	u8 p, s;
 	u8 val;
 
 	/* HDMI PHY init */
@@ -453,11 +532,38 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
 	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
 		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
 
-	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
-	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
-		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
+	/* Using the PMS calculator alone, determine if can use integer divider */
+	close_freq = fsl_samsung_hdmi_phy_find_pms(desired_clock, &p, &m, &s);
+
+	/* If the clock cannot be configured with integer divder, use the fractional divider */
+	if (close_freq != desired_clock) {
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use fractional divider\n");
+		/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
+		for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
+			writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
+		fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
+	} else {
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use integer divider\n");
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: P = %d\n", p);
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: M = %d\n", m);
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: S = %d\n", s);
+		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: frequency = %u\n", close_freq);
+
+		/* Write integer divder values for PMS */
+		writeb(FIELD_PREP(REG01_PMS_P_MASK, p), phy->regs + PHY_REG(1));
+		writeb(m, phy->regs + PHY_REG(2));
+		writeb(FIELD_PREP(REG03_PMS_S_MASK, s-1), phy->regs + PHY_REG(3));
+
+		/* Configure PHY to disable fractional divider */
+		writeb(0x00, phy->regs + PHY_REG(4));
+		writeb(0x00, phy->regs + PHY_REG(5));
+		writeb(0x80, phy->regs + PHY_REG(6));
+		writeb(0x00, phy->regs + PHY_REG(7));
+
+		writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, s-1),
+		       phy->regs + PHY_REG(21));
+	}
 
-	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
 	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
 
 	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
-- 
2.43.0


