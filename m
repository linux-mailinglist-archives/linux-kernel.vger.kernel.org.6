Return-Path: <linux-kernel+bounces-322394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BE97287A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0793A1C23B88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C917E00A;
	Tue, 10 Sep 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAoHkugf"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264B17ADF1;
	Tue, 10 Sep 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943233; cv=none; b=E9+3Av9YbgArXN3MkfnNDahLddctLrTigxA6TRwrXE/v8RM8yAOV/AD4L16ApyXNQsELiEdMSlQyezRhU40F16ZjMcR18qbSMJVzsdPrnPYJuncLpIbTKFK4I6NE8/bIHm5TKMdLc5iOzFueO3bLVdNNQRj/hcD1lGPd3/z34PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943233; c=relaxed/simple;
	bh=koJBg8yzwhtGzGx9x9JJA/nipZE2WzOP8mnJFes4NBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNQSR+xz2f4RlUTysAm2d6qOou56+jafdIwzexoG7L/7WN14RSJURS0I5FM/QFVUgS8zj7nW0Jb8rybwJRN7a5MMFexE5HuPIERpctM4LNmWmc0ubXThJnefWJF3aNJLrwdkhHmWofDow0ZaTGKof0hxcA+Yt+D/Ebt937BT78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAoHkugf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cba0dc922so10807875e9.3;
        Mon, 09 Sep 2024 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943229; x=1726548029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7579wdpHag2FewCMXqF+ybgeA198ZT0CN/Gcy3G4QeE=;
        b=mAoHkugfxl0X3O0lHBT5HIa4HCCY2C64RJ82Oh3kIOPUBDxKQB++F3gyHDi2hc/+yP
         Ta8J+dW8zReLA/RK37UuZUqZ1IoCLn2Wct/rZyVwZ4AFurvZNbXezzvv6xXzAeDah7u5
         MdoSnuxF3S425O2rrsS80F3Jb3DVub825Zo76TRi6T0NniuUanQ+X48rkmyb8lEeUOgw
         eNR7RqSv5076fNM9NKNGfndVENEeZFt60F07abs+Sl1SKunuCGAGNJ0plXvptRGQwxRd
         1ZhdLtQlmtHny2KzTQZXQGaOgMY49fzz9J34a6fF+te3Sjm/QcRVmiyxQ7N6FltViTVS
         XDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943229; x=1726548029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7579wdpHag2FewCMXqF+ybgeA198ZT0CN/Gcy3G4QeE=;
        b=Tr8JEnBChZQlnXZH0hIYtzEwQjfOXWxtxvDl1VtmBgmy9DmCGrBEB/oawdV++GsP+D
         ow8L3aW4WC8se2OvUe60GBqyGjFLK+FvB8nX751wMB3UOhmZA50EJflZnqFu3rZskCOZ
         sj3U29s/JHG1UsMx3uxomEqlvIxcW2TzHjnHfA0v7bL6nXrTqdSZzRRrTOGCJcg4yCzv
         F6YGd1jCcMdBGyMvOR2iWtlNsxedaUljsoV3h+DXDJiDWuzqkaVwH4/f33Axd1IrPllO
         Seww+nNxRK/8iNBRaX1p7nXUhCbkaPI9VEln4mmMa01gPR5KCIE+tRqpBomAEh6sBlqK
         rk7A==
X-Forwarded-Encrypted: i=1; AJvYcCWiyIkCCb9qS9JUid1qT4SjmhwpFt9py08JxdHTl6R399ZLplpHCCSg0GbsCC1WNo8YFO6LBXGol5gi2/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8v9C2fnU94Nhjpv1ygDmFU6KvI4EqejM4acQjdxKnbjKFvhQ
	CHRpI4+b8QqB5rf4gfgVdYRo/AEliumz4j1AgSNmK9l4/30QK3dKzvWhPw==
X-Google-Smtp-Source: AGHT+IHK8xVxjDQwjj3c2e+y3trQYkf/C6Ra0KJNdd53Eniy+vtfLtzIXpLrCh2LZffNsljAIXWLwA==
X-Received: by 2002:a05:600c:354a:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42cadb6a47cmr61619375e9.35.1725943229024;
        Mon, 09 Sep 2024 21:40:29 -0700 (PDT)
Received: from localhost.localdomain (201.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01cae3asm5516055e9.0.2024.09.09.21.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:40:28 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@kernel.org,
	mturquette@baylibre.com,
	tsbogend@alpha.franken.de,
	yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clk: ralink: mtmips: add mmc related clocks for SoCs MT7620, MT7628 and MT7688
Date: Tue, 10 Sep 2024 06:40:24 +0200
Message-Id: <20240910044024.120009-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Original architecture clock code from where this driver was derived did not
include nothing related to mmc clocks. OpenWRT people started to use mtk-sd
upstream driver recently and they were forced to use a dts 'fixed-clock'
node with 48 MHz clock:
- https://github.com/openwrt/openwrt/pull/15896
The proper thing to do to avoid that is to add the mmc related clocks to the
driver to avoid a dts with fixed clocks nodes. The minimal documentation in
the mt7620 programming guide says that there is a BBP_PLL clock of 480 MHz
derived from the 40 MHz XTAL and from there a clock divider by ten produces
the desired SDHC clock of 48 MHz for the mmc. Hence add a fixed clock 'bbppll'
and factor clock 'sdhc' ten divider child to properly set the 'mmc' peripheral
clock with the desired 48 Mhz rate.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mtmips.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 76285fbbdeaa..97b8ca0f9181 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -207,6 +207,7 @@ static struct mtmips_clk mt7620_pherip_clks[] = {
 	{ CLK_PERIPH("10000b00.spi", "bus") },
 	{ CLK_PERIPH("10000b40.spi", "bus") },
 	{ CLK_PERIPH("10000c00.uartlite", "periph") },
+	{ CLK_PERIPH("10130000.mmc", "sdhc") },
 	{ CLK_PERIPH("10180000.wmac", "xtal") }
 };
 
@@ -220,6 +221,7 @@ static struct mtmips_clk mt76x8_pherip_clks[] = {
 	{ CLK_PERIPH("10000c00.uart0", "periph") },
 	{ CLK_PERIPH("10000d00.uart1", "periph") },
 	{ CLK_PERIPH("10000e00.uart2", "periph") },
+	{ CLK_PERIPH("10130000.mmc", "sdhc") },
 	{ CLK_PERIPH("10300000.wmac", "xtal") }
 };
 
@@ -272,8 +274,13 @@ static struct mtmips_clk_fixed rt3352_fixed_clocks[] = {
 	CLK_FIXED("periph", "xtal", 40000000)
 };
 
+static struct mtmips_clk_fixed mt7620_fixed_clocks[] = {
+	CLK_FIXED("bbppll", "xtal", 480000000)
+};
+
 static struct mtmips_clk_fixed mt76x8_fixed_clocks[] = {
-	CLK_FIXED("pcmi2s", "xtal", 480000000),
+	CLK_FIXED("bbppll", "xtal", 480000000),
+	CLK_FIXED("pcmi2s", "bbppll", 480000000),
 	CLK_FIXED("periph", "xtal", 40000000)
 };
 
@@ -328,6 +335,15 @@ static struct mtmips_clk_factor rt305x_factor_clocks[] = {
 	CLK_FACTOR("bus", "cpu", 1, 3)
 };
 
+static struct mtmips_clk_factor mt7620_factor_clocks[] = {
+	CLK_FACTOR("sdhc", "bbppll", 1, 10)
+};
+
+static struct mtmips_clk_factor mt76x8_factor_clocks[] = {
+	CLK_FACTOR("bus", "cpu", 1, 3),
+	CLK_FACTOR("sdhc", "bbppll", 1, 10)
+};
+
 static int mtmips_register_factor_clocks(struct clk_hw_onecell_data *clk_data,
 					 struct mtmips_clk_priv *priv)
 {
@@ -811,10 +827,10 @@ static const struct mtmips_clk_data rt5350_clk_data = {
 static const struct mtmips_clk_data mt7620_clk_data = {
 	.clk_base = mt7620_clks_base,
 	.num_clk_base = ARRAY_SIZE(mt7620_clks_base),
-	.clk_fixed = NULL,
-	.num_clk_fixed = 0,
-	.clk_factor = NULL,
-	.num_clk_factor = 0,
+	.clk_fixed = mt7620_fixed_clocks,
+	.num_clk_fixed = ARRAY_SIZE(mt7620_fixed_clocks),
+	.clk_factor = mt7620_factor_clocks,
+	.num_clk_factor = ARRAY_SIZE(mt7620_factor_clocks),
 	.clk_periph = mt7620_pherip_clks,
 	.num_clk_periph = ARRAY_SIZE(mt7620_pherip_clks),
 };
@@ -824,8 +840,8 @@ static const struct mtmips_clk_data mt76x8_clk_data = {
 	.num_clk_base = ARRAY_SIZE(mt76x8_clks_base),
 	.clk_fixed = mt76x8_fixed_clocks,
 	.num_clk_fixed = ARRAY_SIZE(mt76x8_fixed_clocks),
-	.clk_factor = rt305x_factor_clocks,
-	.num_clk_factor = ARRAY_SIZE(rt305x_factor_clocks),
+	.clk_factor = mt76x8_factor_clocks,
+	.num_clk_factor = ARRAY_SIZE(mt76x8_factor_clocks),
 	.clk_periph = mt76x8_pherip_clks,
 	.num_clk_periph = ARRAY_SIZE(mt76x8_pherip_clks),
 };
-- 
2.25.1


