Return-Path: <linux-kernel+bounces-312021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3169690F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57562840A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC11CDFA4;
	Tue,  3 Sep 2024 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgebKNqi"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798B1CDFA6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327112; cv=none; b=MlvROqTISZUHLphBMDy4QbvgnG5MQ7MLZ+BpZNTZO01K5mE54MlISWRrCyr0aur1V5sfJlmSNOPj5UCdWj33POJ2fg0coI3gYi/s8lzVuhHc2RQ0eHBgYHhMaAx8LCemaOi5hAJ+o1/bGbFui+Urd9f5FKxLN/Q+gpjvLzDeg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327112; c=relaxed/simple;
	bh=xR72qna4avx5b0guljaiboIZTrSYINVE6Vcqe4PLOio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czVY+2mb35yPJQyvzVFwtIPv4z1oxmKkqbriZWH6VUFlyd2yKk6rdVj/M7rR21fddvBg4kCFBYe2bJyNhfdhjdXNebEv1gQ5ZeGosdSZxyoepkS21k/ywPXXusCBB/HW1IflzpAQ5MGvvAJSqpl0T9y2oycOLzCIIwe/NBvNzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgebKNqi; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-829e8718502so199452939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725327110; x=1725931910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjDycFG/gwvOYgM+KYAdbKzrZuoPb1hpign8aj2gA/s=;
        b=KgebKNqiWAAh2ltWgyMP21VButoD24RgMPMq7M05Zhgtiw7F2saTVsbz+ASPhsWtbw
         rOuOIP/yfg0yh6kP1PpvLqkEAbVYagTLwhKwNNltTdxMrQbs/+iGmpjJAESHv7CJW3kW
         UZWaX7imKI/a/zNnzx0fakKudoBEt1xubn1qrauh//CNuh2ecMQ81vhdHIDjuHZPfBWu
         MxjrtKXDv22aypJoQ8QcQmLHmZTTn9SNq5K0MTu2QSoGkOC5hk/43ONC63YFzkL3E1GT
         nbo+JxLBqDWZuiQ6Vb3BdPmvA40gliuj/O571ElGqBBIAAbq/RFBsDl8QFNo+XlBh8CC
         HdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725327110; x=1725931910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjDycFG/gwvOYgM+KYAdbKzrZuoPb1hpign8aj2gA/s=;
        b=hc2yOuEL9R1SFjS8fKceWguUCh2elAPH7orRcSvZ+6GOF1lqdSOIH3x2u9X08XRjOY
         lxAANNzKLe4Afwvp+5N90mzqLduuCosCINwx/pKrbtrE3WuETXL4UAGozEv02yRfr/9P
         l0bHUfx92fM7YIY/O6kd7RuCrqXTPeITmZUQv8fr5lXx+e4ViaJbhKUOCQaEuLxYWF1Q
         byO//EjhTjXzOBXTl0GiqA0YqjLLMyjbNF5xuxFQLnGYrrM+AiZ/nLyYOgOHyaZDOfhA
         RFgi/UGzD6IgNHvflQSsvIFtBhwo+/Xbw1/y9s4iF/Ne+aZtHuNP3QQ/0eTTQpo/E/J7
         6wdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbmEUJiC2l1qfsCw7Nj8yCfq8/zIR/C/HiqIfG3uQpm7XToX5GqaWsuWiTMI6PhAVSBjySmuGDBuLDTnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLdKx0FRW/38eKIQMRR4nxtQRJTNMQZyjzDCPVuQdWlzb+NGi
	AOBKMP+VY7uk/UcNR1wfGDhw4fr4PV3Tg1tGIsbBZ1uPvxo+pb4P
X-Google-Smtp-Source: AGHT+IFBxGp8SaeQqQUz2zloZ4K1h8vgzjf3pkmahMn9NrG4HemfvelUnukoTgxIAlFGA7ZKWawR9A==
X-Received: by 2002:a05:6e02:1fcc:b0:39f:36f3:196f with SMTP id e9e14a558f8ab-39f378ea649mr163711435ab.4.1725327109783;
        Mon, 02 Sep 2024 18:31:49 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b059c32sm28466715ab.75.2024.09.02.18.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:31:49 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/5] phy: freescale: fsl-samsung-hdmi:  Remove unnecessary LUT entries
Date: Mon,  2 Sep 2024 20:30:47 -0500
Message-ID: <20240903013113.139698-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903013113.139698-1-aford173@gmail.com>
References: <20240903013113.139698-1-aford173@gmail.com>
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
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 83 +++-----------------
 1 file changed, 13 insertions(+), 70 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 0bf526e282a7..7cfad4ed94f3 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -60,25 +60,16 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -96,18 +87,9 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -123,19 +105,13 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -144,10 +120,7 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -159,10 +132,7 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -174,10 +144,7 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -204,10 +171,7 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -219,19 +183,13 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -252,10 +210,7 @@ static const struct phy_config phy_pll_cfg[] = {
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
@@ -279,9 +234,6 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 165000000,
 		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
-	}, {
-		.pixclk = 180000000,
-		.pll_div_regs = { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
 	}, {
 		.pixclk = 185625000,
 		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
@@ -300,25 +252,16 @@ static const struct phy_config phy_pll_cfg[] = {
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


