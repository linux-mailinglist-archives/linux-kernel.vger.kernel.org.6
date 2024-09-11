Return-Path: <linux-kernel+bounces-324092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD029747CA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1341F273B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BACF2A1A4;
	Wed, 11 Sep 2024 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkmbvuHp"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99663D3B8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018175; cv=none; b=gUsLlBQKuc0Ki37aOT3ARDUsSP75b/PI3S7+FwvNC4iue6CjE9ItH0Q9D8iTUU4QvoRjvYB8bj87vbaZc6YLcxVPObFjphMhj2lV/Y0V4i+iqI1cXXIZKaCSahciHAYh5fOOqqGyWuMNdt11RVOdlclC3q/+n0Czh+PY3AfEzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018175; c=relaxed/simple;
	bh=X+PyLiDvI+tp+Y9AEeykX8Px0eB0BPntnJcYQwXFIHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW5C7saHAzCpcRCBD/rkbe8ZeXWiCzqc8iRL0lNOOs75GIXFSGdx8uKduVu7zUaHjDWu27PXfkfiLXustSj2nzNK6TkmW7Pg/+MNnXQlBAhM8u+w9EGwEursSqOaKPd9NvH3f1Dvri/WGHK+4w83PZBVxmLjh/0JgoQLIY7XBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkmbvuHp; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aa7c3b498so15177939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726018173; x=1726622973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNmd7Xeflt1tT296+u/RQ2hpS1vjveVrr0E47o0mBJI=;
        b=VkmbvuHpupbjxllQLx+c+7kfTj3w3dBV0DhQ28PmMxZ1E8Y48Fam+69eTxmax4ugEJ
         gpEqnEU1TWXBtJ2K98lgDyI54/wgaVLe3UyWB5Z1qmphergY/EcCaw2sNkRuPyohauGU
         KRBp6f+2dEBKH2mM46Ux0wmG5ku/SuvCY+e6m5VtlZFqMRHdLTBqmXHi7LIx0XQi870f
         Y9jj7UwmdHQGdksAFhzYPnOefXmUwuokRyFIlSn7VI/ZXvZqqn+AW+nvnFtG9d6SZ9vJ
         MAcoHaXjRszm2ohKPp/+9YjVs2Z7kJpBm3SXUDp5Q3kr1QNq8PLLRvDAGlu6S36c9+iO
         4Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726018173; x=1726622973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNmd7Xeflt1tT296+u/RQ2hpS1vjveVrr0E47o0mBJI=;
        b=ML7IeCGlBChyOCX2yaUDkBG6DmvOY8E9yQ5PD79JtSJNizWWyo8mNmVgVflrm0Ge+W
         k+x6idQTwLN/JCm6nUyJIsDKRb4ZZZIFrs7l1gs0x2YgdlO8FkpP8c3USnRzkJwJ7Nq6
         tblJb4eX6qTsEOaM1UJBrY5EHKM0RMlZkW8vALp6B+GqiQYFNaJjSNoZmlZEJFkL6I/d
         A6acWuk0b/+3KIDqZNzgBIrIC4DFbqkifcNmAGj8nA8GJyVBEkqfPcUL/jFAD6WyZpsm
         yQn7uJNOG/BYTMMt5E+rY0mJ4ChN8GnWLI44oX6i9gSYrupCocSrF41Yobd7M3MC28Dg
         2D0A==
X-Forwarded-Encrypted: i=1; AJvYcCVFe4iaA649CRQUuG87iIBThBQcLDa166YIXwz4Spr5u0MguIG7AFvPpQzRs9Ev0CvRyjPlbcn4tEUte/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkdeZaSwR2zBafadxOOg357xZQyODFlBXgQH4i5hMP6B8q+U3
	Mj2S0PXD/L7t1QZ9Jb8QaZ97ReEyOvqggUkdYYGAwDEHC1b14p6L
X-Google-Smtp-Source: AGHT+IENblEup5aBDflSVAc//Eq7RuqhMDHKRxCuG6xjyZyvg1MVVvZDliUQb3Su+5616U9ZKDqiiA==
X-Received: by 2002:a05:6e02:1d88:b0:39f:5def:a23d with SMTP id e9e14a558f8ab-3a074c1d7e5mr10919985ab.5.1726018172880;
        Tue, 10 Sep 2024 18:29:32 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d094561c8csm1917945173.62.2024.09.10.18.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 18:29:30 -0700 (PDT)
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
Subject: [PATCH V7 5/5] phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries
Date: Tue, 10 Sep 2024 20:28:11 -0500
Message-ID: <20240911012838.944630-6-aford173@gmail.com>
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

The lookup table contains entries which use the integer divider
instead of just the fractional divider. Since the set and round
functions check both the integer divider values and the LUT values,
it's no longer necessary to keep the integer divider values in the
lookup table, as can be dynamically calcuated.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
V7: No Change
V6: Fix typos in commit message
V5: No Change
V4:  New to series
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 83 +++-----------------
 1 file changed, 13 insertions(+), 70 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 67a28aac9c45..a5ad51425ee3 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -69,25 +69,16 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 23750000,
 		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
-	}, {
-		.pixclk = 24000000,
-		.pll_div_regs = { 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 24024000,
 		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
 	}, {
 		.pixclk = 25175000,
 		.pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
-	}, {
-		.pixclk = 25200000,
-		.pll_div_regs = { 0xd1, 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 26750000,
 		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
-	}, {
-		.pixclk = 27000000,
-		.pll_div_regs = { 0xd1, 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 27027000,
 		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
@@ -105,18 +96,9 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 35000000,
 		.pll_div_regs = { 0xd1, 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
-	}, {
-		.pixclk = 36000000,
-		.pll_div_regs = { 0xd1, 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 36036000,
 		.pll_div_regs = { 0xd1, 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
-	}, {
-		.pixclk = 40000000,
-		.pll_div_regs = { 0xd1, 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
-	}, {
-		.pixclk = 43200000,
-		.pll_div_regs = { 0xd1, 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 43243200,
 		.pll_div_regs = { 0xd1, 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
@@ -132,19 +114,13 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 50349650,
 		.pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
-	}, {
-		.pixclk = 50400000,
-		.pll_div_regs = { 0xd1, 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 53250000,
 		.pll_div_regs = { 0xd1, 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
 	}, {
 		.pixclk = 53500000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
-	}, {
-		.pixclk = 54000000,
-		.pll_div_regs = { 0xd1, 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 54054000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
@@ -153,10 +129,7 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 59340659,
 		.pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
-	}, {
-		.pixclk = 59400000,
-		.pll_div_regs = { 0xd1, 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 61500000,
 		.pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
 	}, {
@@ -168,10 +141,7 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 70000000,
 		.pll_div_regs = { 0xd1, 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
-	}, {
-		.pixclk = 72000000,
-		.pll_div_regs = { 0xd1, 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 72072000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
@@ -183,10 +153,7 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 78500000,
 		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
-	}, {
-		.pixclk = 80000000,
-		.pll_div_regs = { 0xd1, 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 82000000,
 		.pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
 	}, {
@@ -213,10 +180,7 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 100699300,
 		.pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
-	}, {
-		.pixclk = 100800000,
-		.pll_div_regs = { 0xd1, 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 102500000,
 		.pll_div_regs = { 0xd1, 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
 	}, {
@@ -228,19 +192,13 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 107000000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
-	}, {
-		.pixclk = 108000000,
-		.pll_div_regs = { 0xd1, 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 108108000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
 		.pixclk = 118000000,
 		.pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
-	}, {
-		.pixclk = 118800000,
-		.pll_div_regs = { 0xd1, 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 123000000,
 		.pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
 	}, {
@@ -261,10 +219,7 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 140000000,
 		.pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
-	}, {
-		.pixclk = 144000000,
-		.pll_div_regs = { 0xd1, 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 148352000,
 		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
 	}, {
@@ -288,9 +243,6 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 165000000,
 		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
-	}, {
-		.pixclk = 180000000,
-		.pll_div_regs = { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 185625000,
 		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
@@ -309,25 +261,16 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 213000000,
 		.pll_div_regs = { 0xd1, 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
-	}, {
-		.pixclk = 216000000,
-		.pll_div_regs = { 0xd1, 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 216216000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
-	}, {
-		.pixclk = 237600000,
-		.pll_div_regs = { 0xd1, 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 254000000,
 		.pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 277500000,
 		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
-	}, {
-		.pixclk = 288000000,
-		.pll_div_regs = { 0xd1, 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
-	}, {
+	},  {
 		.pixclk = 297000000,
 		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
 	},
-- 
2.43.0


