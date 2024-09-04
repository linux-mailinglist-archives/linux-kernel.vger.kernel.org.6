Return-Path: <linux-kernel+bounces-314084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C396AEAD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263241C24111
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181757CBC;
	Wed,  4 Sep 2024 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egNheHRW"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DA5E093
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417227; cv=none; b=pNeh840Zk86K1jSePvImkp9DXZ9N7vVHkbFzY2mZ+TLeXsFMtZYkFdkEKEsFaf5f8G06qOZMMTKqp4b9AuTiQgsvWx9WTre+FxQ27WP12vJWXrsJL9mUSuKiUlG9te8ini4yAmABrsg/r/ZR+kv7NVd/jb8J0nC4T2emo29V+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417227; c=relaxed/simple;
	bh=nD+TJsXZSYvQ1zawRIJ88YFOIOUwyyMd/WchYjEyVu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFzr7IvhkQKD6ycML3Z7DtjHb1XlW5jAc6r7fzqgYWXGNg5oVYrBiQo8789DZqaUjmZTv2WoxNcXo0CSjOO3hEu+btuR2HeXXMFG6C8Kqcw3xKh3lHIYvo4hebdPD6kdAxLAZm60c8teIbdfHJiO98gcvZjBPsFerrTgOx8BhrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egNheHRW; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f4fed788bso14076825ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725417224; x=1726022024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYFfVCWMBS22o7JNNFtpuqpD2IKuzKiYCMZ9dmjOqGw=;
        b=egNheHRWiSdwbtZHJSXNZuQRn60kmLyRlM4slUZXu1WnlQsOvCEs5GEPLIqylonbQj
         F1oqSB2sBuIFhqjJm3EK49sD16fuqhBVlyVNM+NoPc1ZEeFCKtFcp6WMPAGl/yeKqGKX
         tHXa5bNOzPoIbilC7SECs8WTWsQ9/5IPBnybSN/G4YhvV/iqdisP8toHKzR5zaMfBnQC
         fOsU5sHO2BZmyff2II9fWxIogqJjBf6TS7QXfgF2CzMWrI+gu3V+fYUTibvcnhEKbgZa
         5fO0IpBwq1eW/GjGaKTsmH5RoVVeAf1ANwEJOQ4rzj07V8TmZ07DSrueyUPQIjlfhXYG
         /+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725417224; x=1726022024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYFfVCWMBS22o7JNNFtpuqpD2IKuzKiYCMZ9dmjOqGw=;
        b=nuLn0WMhUEZe2B0wfsBLktvvvZiFSMmsIGCYaf8/Svf5thnpsP1CHDb4h60brIW5y4
         RGIu0mitO/SK6CvAVnrQtvG5igktim/1s6IJzqO7tQ5pQ9zlBmjLh/a8FY3mkl9JYYMB
         rzqfaqTUel6M0JKeTI4vKggbqU60iTiKA0BC6S8SaHHmbwwvZyyMltoA0JxIpftRsAdg
         1F1Z7iz3NuCcy2RPwe22fUwDt46jIKBf9cHfrEdReI0GaXe3DeRbods8pau57Efs6pSH
         LK+RYJvtmyKBzPGH+qhRST9WlO+QfjgndG3UrV210HSzYWWpX//+dPHIlB0znZZJYpE7
         MNOg==
X-Forwarded-Encrypted: i=1; AJvYcCWCYmyHsQAIWt40kDWp218rHzhYwnmsqr6hlIA2Z0MMdOvxMmExVpgSYaSxIL/7elROSrC3z2OVZPrflsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jmQHCoYumKQjJdRJ2kh4m8aJihPwQPSdivB+wvTL4RRmwXVK
	41B+3vu2Kdo3uTpkaQ6L+bUy4Bj3XMMY84fwNfwGDwb1j9Uz33pv
X-Google-Smtp-Source: AGHT+IF9CRUtm+5KI3viB9KtZrJ5BbBu0xR1m3Mh6exNp+Uwc7k1kyyRtk7Whfy3CbaJWWi739hbtA==
X-Received: by 2002:a05:6e02:1a02:b0:36c:4688:85aa with SMTP id e9e14a558f8ab-39f6a99105emr71036315ab.10.1725417224417;
        Tue, 03 Sep 2024 19:33:44 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc4ff6sm34556175ab.37.2024.09.03.19.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 19:33:44 -0700 (PDT)
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
Subject: [PATCH V5 5/5] phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries
Date: Tue,  3 Sep 2024 21:32:44 -0500
Message-ID: <20240904023310.163371-6-aford173@gmail.com>
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

The lookup table contains entries which use the integer divider
instead of just the fractional divider.  Since the set and round
functions check both the integer divider values and the LUT values,
it's no longer necessary to keep the integer divder values in the,
as they are able to by dynamically calcuated.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V5: No Change

V4:  New to series
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 83 +++-----------------
 1 file changed, 13 insertions(+), 70 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 56b08e684179..a37d7b989552 100644
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


