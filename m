Return-Path: <linux-kernel+bounces-570315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55303A6AEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A90B486DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC9322B5A5;
	Thu, 20 Mar 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gALizsrT"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787322ACCE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499900; cv=none; b=SxTKFDvg0xQKegsbl4ioG4cD5wba/HcSFppEj1Cea+VEIkqZX0OsXbfTWR/UNMipgA522cQx6Ub2CTXmPT/s/asB+g5mZ6uizJOS7Gtdu++ki6y7/1IXlir51f8DblHeYrschESq8PkdvPV8d+8ThvDZlbK3z963BjUmAfUzF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499900; c=relaxed/simple;
	bh=Msfp5XPXlQWRA6OSK94MBACxh76YXKPDMkGV+ksBlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M68/AiAYfwyNt52rQKDzor1dJOnR3AdZ+G/2TzBLo/alJ9dqToGSiG8HGhBSjMoZyCFQYjWFKXteIfSkSCxb8qAiyZgG7SnKJTNjTZyFQ8efVaHX5FxpFUd92WHn0ayzDW07eRlE2oGJDraZT1AjO5By7J9X0CZpkcnpJ2D+Jus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gALizsrT; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so107148839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742499897; x=1743104697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8oqjEMMafA14xwGBAA8P5aE0E7j2tKNWQP5nX11uxM=;
        b=gALizsrTR+YkI3w3YUnCF/CfNj2DLDW81lc4wi3NEayQEgd9auAUqCqmsb2h/LywiT
         riNlA/DbgqRCgGpPf6c+lj8A7I9us/A9KfC+dySjWGhNjWA+H5toaTaaTFSjPTFsVFu/
         QK0ASKnTA47iAMlNpvseIJB/6CzCBYlJVO1VHqkkAU95MQPs7HSTVCPJPamrnbxz/8gi
         /8eGc9BoeIR5920WQftadAORtZ+M8cIGpziUbTwa1V2uBM/OvM0GI8Hm07xCnUFPhEzM
         vsz54VPEf+WYvihUEAQMNO20ONUvar8lqv4bNlrsKgz42abJztMpqcfHyqaGvwck/wYS
         Bzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499897; x=1743104697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8oqjEMMafA14xwGBAA8P5aE0E7j2tKNWQP5nX11uxM=;
        b=jATyOfKqwSdSlPpqCeQtRzpjaEEw75+nSqjSpOLtSS9Ay3xnnh3+QASAMEAQ2OwG2N
         b/Q7EHtq/m/QrX0MNU5s5mmXC8LIDTW2k03dcp8mZXsVix2hEVj5bylyQ2mXM1MCbMjZ
         ZFMZymbCyJ9PcBw2vdzdHHfXPclTgxqCZOpwZJY5Jj3h2Yv4bW5WM1U67NywirR3qII1
         j9yB2Nb0vPG4g8tafBHcP3l9OXN15PxdZKmmN2ai5kxmWclTgLAGjVoC+dm4cgNFC6wV
         Ne3PSnNRXGfo5aT8RX07kSBCqQPzOFT20srf+6Nwxyu4//+lbMcScgjvomvNs/jvL8Jx
         GASg==
X-Forwarded-Encrypted: i=1; AJvYcCVHyskRsOV8uRy/5UsosVbDG4cao7D629oE2xgfXY7R/m5rFAFLDhZ6ND9TVOhWkj82ofMHFFQFpFqOS3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVxZH82qBxBN3bRKhkeampUjLVSVp9UmtokVdTapSj+ANmpi4
	yaIAot6uiA3iCau+h2MP91V52Z5e7T3fgTtbmckJUnT6y8BHOSzvNKT8Sa4WVBE=
X-Gm-Gg: ASbGncsomRTqnWLrjMopSxj1tbIDQ3DcrWtPjrqnHpNwU16SYorNgVUY9Qdve+pw04C
	5E/TyoHsaSLUssKMYipehWlXQJAoTqdvJmaDA1B/Xbi9xGGKHdZ5kNAyANrdJGQxVaF+n+E4Qvm
	wqUm2qyXimVmJRS0QD+zf/uZ/fIHo+7p190CsyoyPnBnQvTUYfCk5nMMLG7T7eeR6zjHoa+ZAAR
	GlFNEI9O9mS6b2wZLnOWrX5cFB1AyYTRE+jIliHIUEy1bOMX6pMzj3gJJPgvL/M/MHl8xLcvlm4
	C58NmG5ZgH20xLuY6kZBI/S9HS+4qa/yC6R0RN2sqwL6R9WJANoR/RsUgNFgFT3jSTYC+vq4hy4
	SPbt+U/NFfW1ZNox+mJUgaiyi
X-Google-Smtp-Source: AGHT+IE0HnT0gHPp7UKf3TtmiqLLIYHOa3X3172V4PY0PqjTK+kdQE3txVupAc7Grypt+2MRtP2v8w==
X-Received: by 2002:a05:6602:380b:b0:85c:5521:cbfe with SMTP id ca18e2360f4ac-85e2caaf4bcmr59453439f.8.1742499896878;
        Thu, 20 Mar 2025 12:44:56 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bd8c40fsm8341439f.32.2025.03.20.12.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:44:56 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: p.zabel@pengutronix.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	dlan@gentoo.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heylenay@4d2.org,
	guodong@riscstar.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] clk: spacemit: define struct k1_ccu_data
Date: Thu, 20 Mar 2025 14:44:43 -0500
Message-ID: <20250320194449.510569-3-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320194449.510569-1-elder@riscstar.com>
References: <20250320194449.510569-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a new structure type to be used for describing the OF match data.
Rather than using the array of spacemit_ccu_clk structures for match
data, we use this structure instead.

Move the definition of the spacemit_ccu_clk structure closer to the top
of the source file, and add the new structure definition below it.

Shorten the name of spacemit_ccu_register() to be k1_ccu_register().

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/clk/spacemit/ccu-k1.c | 58 ++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 44db48ae71313..f7367271396a0 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -129,6 +129,15 @@
 #define APMU_EMAC0_CLK_RES_CTRL		0x3e4
 #define APMU_EMAC1_CLK_RES_CTRL		0x3ec
 
+struct spacemit_ccu_clk {
+	int id;
+	struct clk_hw *hw;
+};
+
+struct k1_ccu_data {
+	struct spacemit_ccu_clk *clk;		/* array with sentinel */
+};
+
 /*	APBS clocks start	*/
 
 /* Frequency of pll{1,2} should not be updated at runtime */
@@ -1359,11 +1368,6 @@ static CCU_GATE_DEFINE(emmc_bus_clk, CCU_PARENT_HW(pmua_aclk),
 		       0);
 /*	APMU clocks end		*/
 
-struct spacemit_ccu_clk {
-	int id;
-	struct clk_hw *hw;
-};
-
 static struct spacemit_ccu_clk k1_ccu_apbs_clks[] = {
 	{ CLK_PLL1,		&pll1.common.hw },
 	{ CLK_PLL2,		&pll2.common.hw },
@@ -1403,6 +1407,10 @@ static struct spacemit_ccu_clk k1_ccu_apbs_clks[] = {
 	{ 0,			NULL },
 };
 
+static const struct k1_ccu_data k1_ccu_apbs_data = {
+	.clk		= k1_ccu_apbs_clks,
+};
+
 static struct spacemit_ccu_clk k1_ccu_mpmu_clks[] = {
 	{ CLK_PLL1_307P2,	&pll1_d8_307p2.common.hw },
 	{ CLK_PLL1_76P8,	&pll1_d32_76p8.common.hw },
@@ -1440,6 +1448,10 @@ static struct spacemit_ccu_clk k1_ccu_mpmu_clks[] = {
 	{ 0,			NULL },
 };
 
+static const struct k1_ccu_data k1_ccu_mpmu_data = {
+	.clk		= k1_ccu_mpmu_clks,
+};
+
 static struct spacemit_ccu_clk k1_ccu_apbc_clks[] = {
 	{ CLK_UART0,		&uart0_clk.common.hw },
 	{ CLK_UART2,		&uart2_clk.common.hw },
@@ -1544,6 +1556,10 @@ static struct spacemit_ccu_clk k1_ccu_apbc_clks[] = {
 	{ 0,			NULL },
 };
 
+static const struct k1_ccu_data k1_ccu_apbc_data = {
+	.clk		= k1_ccu_apbc_clks,
+};
+
 static struct spacemit_ccu_clk k1_ccu_apmu_clks[] = {
 	{ CLK_CCI550,		&cci550_clk.common.hw },
 	{ CLK_CPU_C0_HI,	&cpu_c0_hi_clk.common.hw },
@@ -1610,9 +1626,13 @@ static struct spacemit_ccu_clk k1_ccu_apmu_clks[] = {
 	{ 0,			NULL },
 };
 
-static int spacemit_ccu_register(struct device *dev,
-				 struct regmap *regmap, struct regmap *lock_regmap,
-				 const struct spacemit_ccu_clk *clks)
+static const struct k1_ccu_data k1_ccu_apmu_data = {
+	.clk		= k1_ccu_apmu_clks,
+};
+
+static int k1_ccu_register(struct device *dev, struct regmap *regmap,
+			   struct regmap *lock_regmap,
+			   struct spacemit_ccu_clk *clks)
 {
 	const struct spacemit_ccu_clk *clk;
 	int i, ret, max_id = 0;
@@ -1648,15 +1668,24 @@ static int spacemit_ccu_register(struct device *dev,
 
 	clk_data->num = max_id + 1;
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		dev_err(dev, "error %d adding clock hardware provider\n", ret);
+
+	return ret;
 }
 
 static int k1_ccu_probe(struct platform_device *pdev)
 {
 	struct regmap *base_regmap, *lock_regmap = NULL;
 	struct device *dev = &pdev->dev;
+	const struct k1_ccu_data *data;
 	int ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
 	base_regmap = device_node_to_regmap(dev->of_node);
 	if (IS_ERR(base_regmap))
 		return dev_err_probe(dev, PTR_ERR(base_regmap),
@@ -1677,8 +1706,7 @@ static int k1_ccu_probe(struct platform_device *pdev)
 					     "failed to get lock regmap\n");
 	}
 
-	ret = spacemit_ccu_register(dev, base_regmap, lock_regmap,
-				    of_device_get_match_data(dev));
+	ret = k1_ccu_register(dev, base_regmap, lock_regmap, data->clk);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register clocks\n");
 
@@ -1688,19 +1716,19 @@ static int k1_ccu_probe(struct platform_device *pdev)
 static const struct of_device_id of_k1_ccu_match[] = {
 	{
 		.compatible	= "spacemit,k1-pll",
-		.data		= k1_ccu_apbs_clks,
+		.data		= &k1_ccu_apbs_data,
 	},
 	{
 		.compatible	= "spacemit,k1-syscon-mpmu",
-		.data		= k1_ccu_mpmu_clks,
+		.data		= &k1_ccu_mpmu_data,
 	},
 	{
 		.compatible	= "spacemit,k1-syscon-apbc",
-		.data		= k1_ccu_apbc_clks,
+		.data		= &k1_ccu_apbc_data,
 	},
 	{
 		.compatible	= "spacemit,k1-syscon-apmu",
-		.data		= k1_ccu_apmu_clks,
+		.data		= &k1_ccu_apmu_data,
 	},
 	{ }
 };
-- 
2.43.0


