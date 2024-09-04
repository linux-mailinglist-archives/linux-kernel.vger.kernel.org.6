Return-Path: <linux-kernel+bounces-316119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E720E96CB77
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F03C1F28611
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE488189508;
	Wed,  4 Sep 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANyS5WVY"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EDE1898E4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494250; cv=none; b=PCR9qtGCXoS1gD3f5EP8flFl81yc7Ws2kw8Hj2jJWqOsUIjSaRFBAjd8sLCYVRmcC1AU8F+uWmdX7M7Ig0SkVWvQ5n/NKmKIoq+r4+FqT+RDj2sRkdbl5RIZK9orGy7jXcLOucFcg8XyHPDrZ+ZVbaaCSzhiG74kRcxJ+zUbOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494250; c=relaxed/simple;
	bh=n5pd9XHbzvlDhWgU15b71ZeHUsEGL77HGqr834uRj7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBJTP1b/Gdx8rI1AKf4icVIyWZsmBFWJMonLthIuGm598+TRGOmEdD6ShcD8N1YlpD1fR4IWJ0/T+A20A6SjrSf95A078AgWbmce3ZbRdEw0Qs+T1AF/H6PAw5vFwMeb8Dj982BfLpV3Bbb7af9pWWyi/30EY/iodwSf0lDSTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANyS5WVY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39f4fed788bso736945ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725494247; x=1726099047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXSm9WNyKH2X+oIseXOh6+U5ooOHPYDvfoco3hKDKmI=;
        b=ANyS5WVYOMhSQcziwJ9ImlJTcgW7R5boYsNUSpMLDpQt6zIrb4s9/iO2ZgeUS/YXLT
         fJ176VGeu9d/CJRXJb8va9C+1rmiYW2ALdh3cWs/wF8R42E+CX1ttsQMLLJYZ4b5boP1
         ff75YOyBtChZ2PBZe3WNJzzxA1qr/1U22ZCDm1yrGKE+XfB7lhDUwYbUVYGBiGWn0Z5R
         1SDmMtELv9V7JCsSz/ee+0RDzR5QmjmMIgi+lueRegdo1FDwsSE5heZhi3mu+fIApAtW
         uPCtYOgpvmudWIafuWVEVVhs1bb6wRx6q8g2eujfnLuqO8Z6WpgfSWaOxOOEQBnwCwet
         EqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725494247; x=1726099047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXSm9WNyKH2X+oIseXOh6+U5ooOHPYDvfoco3hKDKmI=;
        b=TqRE0+M+39ctzsgk3L4Z++tMvDrzqcWfLy9cpXoJsSgekuh8vDncmOCHnQ7eR5J3Xu
         klMErDrV31Rg4Es/PIAQ3QmqOY/vT5Ha9DfsH0esoZEZACBW+LqXJFLQO4mHCJfWd4fu
         UvOtcwLLx2B7sUd4VyA+BzqlCl2jDE+0CsQ+Mzfp7mgUZ79SX7DhqLghaHgUFLGb9WYY
         x6gtcjc3I82bKqJ3KI/onmo45gTzDkW8gtgTWu2EpUuvahjS+g/xy3pppuxtuLVBwOMO
         FxizWjATDjCMuGe7YYoTXD89J5HbqNa5DOdCr4yP9esyG2Ok3Thu8Kh7AXM3G0MxlIHb
         +RmA==
X-Forwarded-Encrypted: i=1; AJvYcCVhabDCvwBDEYmKKnI7UxgpKu3SgA1A3CMimrtpEDzi3+fKNoAXQd2fMNVqINuv71JHgvyWyFeMTCbZlCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3dibP1Zc7tmz2mWhuRdw7+tAJJZ7Lfd3NkZWfvVKjL9VtZav
	Y3TzXOAemLKBcErguzWmLggCEnXMF/nvu59ei0KhoD9YOoZVaL6c
X-Google-Smtp-Source: AGHT+IFUOeEAenh8bRBe65yBvzTzTad6MxUdqDI6x0cOmF4c0818sqHkfFafnkg/GA4i9lWMj5Cg3Q==
X-Received: by 2002:a05:6e02:1c27:b0:39f:36f3:1957 with SMTP id e9e14a558f8ab-39f6a978675mr100072705ab.3.1725494247336;
        Wed, 04 Sep 2024 16:57:27 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc594csm39396735ab.43.2024.09.04.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:57:26 -0700 (PDT)
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
Subject: [PATCH V6 5/5] phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries
Date: Wed,  4 Sep 2024 18:30:33 -0500
Message-ID: <20240904233100.114611-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904233100.114611-1-aford173@gmail.com>
References: <20240904233100.114611-1-aford173@gmail.com>
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
V6: Fix typos in commit message
V5: No Change
V4:  New to series
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 83 +++-----------------
 1 file changed, 13 insertions(+), 70 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 9a21dbbf1a82..1203143bad7a 100644
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


