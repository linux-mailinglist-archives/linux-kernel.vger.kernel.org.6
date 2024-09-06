Return-Path: <linux-kernel+bounces-318944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2743D96F57E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803A0B2378A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F381D0488;
	Fri,  6 Sep 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LUozod8/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595EF1CEE9F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629727; cv=none; b=Z1TSgmW1JccEej5nRVz7sE0LKYgF6X46Mlfynfu1nycUq7+fMC8kCpxWTloNoivrQAVm7H6hB279XKAFTo/iIJzDNwiS3fZ2rUyqpJHpkZyK0Zb86w6zWo6EdQAc/twBVhBaP2S7EJiLGrBbLfwEXBauYWRVaqSA8y4Dc7jl1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629727; c=relaxed/simple;
	bh=iSedGQJkeoX1rk7eD0ZddgTbF2MZs7+12PeFSEIOANY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6rveGKSstB3QRN32pwyo3CbS+lhvE19nw8AqvMPnxZ/tE0U8dqkPjH0mlisKyz952RjYxnUhuavc1XLmzZlr+vU0RRs80+dGS78c/UzYlhtYZmVxEfDC/g30B8Ugv9hVFOu7u7vwPfbiS/EXwVgNFsfw6XCWF6xMoHFj86C7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LUozod8/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so1252888f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629724; x=1726234524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yr1sayqKxsWDgBZHQ1bM3Uke54ske3bCnU2ZK9PgUEo=;
        b=LUozod8/N4p7bjxBzjcm8thXqtD3Ss6BV7VKKzRVD8AVSg6+vp2H3ppjyfey/dwAeV
         l6WGX1SWt4TpmrQXi4x0SAQLKLMADey0WZVVEJ/b3mzIn0b79ncj4g23Va0naw6SBVvL
         60QXboBP+BCezryhqZ9+HpjKO71YT7v5JZIhvoxxLnVky3mp8OVw66lMjVGt5MLCPhyZ
         pqD6eYc0Dahd2xpQC/yBSq9jI0Mnr8S2+cju1yvvxBpiKTzUBcq2rrWhZ2PwOCqEYRxp
         N8h59ERhJxlVNNUmI/i+/zVGcD+t6ZQLOyXL2F2C86s4ZuNeKtqfmFt1fm/czpF2slfC
         L2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629724; x=1726234524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr1sayqKxsWDgBZHQ1bM3Uke54ske3bCnU2ZK9PgUEo=;
        b=rfhkNpX6UlXr3qEIgErzZ7kx1Cavj5cp8JlOGzuvNIFymec0scZqTge8OLLYTlqeGs
         TewTiuAjY0W62RK6K8t/iED/6hFUChwcMq9fvwwdMiuQUEG1Wi5We72UWeOEuEvVjWbS
         ExrfhrjU9Rnr9C5Hb/HedCx50ICmjDSONPQh6KZuVn2QWxIcBzmmQLXwItPqM22UCqGg
         Lu/l+8Q37SOhx1aFXeCYR1nFHiavNeLDI8hy0UTbRe7otjlC8ptutU6A9HA/eQt0gy/6
         VvURqKOiw/1Nq32LnTNK6SlTVvtPtQ4v0IVI0U6C95Qme75YfPYJzmSqkXJ+FVNLDGxd
         xtqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6wNXMGso7kV1nwVcR+GxusZ8Gck9vkdiEj9lLXTmGEjOUBgXvkaxj0CEJuF3fIiKoa/EyOHjJL6ft854=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGKwBbh/UXbbzSXkLXAsUYPKvBTqg+mwYGYd+FvoNsdC3+jwk
	L5QEeUyP1ndb6CUQ4u/mtVFn0Rd41lhnB/+Yr/rSDZdxWVQyqjmEGbScb6vV4vWOHB1z0sVrmmx
	K
X-Google-Smtp-Source: AGHT+IHtyPvrZcVdwFmw8XQihKzwGBhzTpX6IW6Bq3OFAXKmFfW1m1vMKo12rNUklRp2d6TUNkaT6g==
X-Received: by 2002:a05:6000:223:b0:374:d1dd:1cc1 with SMTP id ffacd0b85a97d-374d1dd1e44mr8801291f8f.2.1725629723501;
        Fri, 06 Sep 2024 06:35:23 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 06 Sep 2024 15:34:50 +0200
Subject: [PATCH v4 5/9] reset: amlogic: use reset number instead of
 register count
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-meson-rst-aux-v4-5-08824c3d108b@baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
In-Reply-To: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=iSedGQJkeoX1rk7eD0ZddgTbF2MZs7+12PeFSEIOANY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wUSHEcD7K2lLWF6rnCrk05yGhK2svJKDRc0t
 qPznnAbxlWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFEgAKCRDm/A8cN/La
 hX7fD/40NAGXsNPZZOklKjEefS6iDGIJJ66e6aq5vjJ4tJFkgU1UCHM6HtnWyGrwVH7bCATlkrc
 zfdZW5t3tTl4pqOCl+vOKaRSGrHBT35G8Ox9hJlFRW3Snso5iJyPuQ+CTrYma1JrEHyGz7krZZS
 847buYbjmFRvpRorM2qQfwsNbhDXNzhoPGlb33dLmRRHSobID92DGHGWH1qfLjv1l1LQEx2yTwJ
 NgfluH6D0qkQUH0bvGbO8Ci2nIdl39PfEYyvHVG9MZw1mvwlUs1Qc72y0OXci599sge1sDLvLdS
 h0Zaj3/tu0HSDSprt8k03YFFg5NoAUvEVoJiAvpb3itN5TnzzVk20dnXth6oHFnijLTrN/2jy97
 A6LoYexCGpUx2EnQkiBdXc56R8qlL8X43hA86h4rZzo33O4F8bXsleFUZXGUESfHWpgJWdk7Gfq
 uutDTN//4THhTnzPuOUe9x2+wpjasBkUm5AeSeXWg2eukaSOc6i5WVbS2g+hem1WolVvXIFjlO2
 jgbjZIMP8OdSA274I0TiF1VItV2l4Xkpj6dt1ZD+H3p1zQuQrzmPbXjPgKFSARxvBYufdW3kejF
 MB/0K6fkFBtjMUv1nnkv6T4sXp24yjYyFokjOzjEUV6kYajijkoNJftGFrmewhrX3n1ZHwmaj2W
 XVQkI2IQt/4Pf3Q==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The reset driver from audio clock controller may register less
reset than a register can hold. To avoid making any change while
switching to auxiliary support, use the number of reset instead of the
register count to define the bounds of the reset controller.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 6a90613c8095..e31c1b7c9e4d 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	unsigned int reg_count;
+	unsigned int reset_num;
 	unsigned int reset_offset;
 	unsigned int level_offset;
 	bool level_low_reset;
@@ -87,28 +87,28 @@ static const struct reset_control_ops meson_reset_ops = {
 };
 
 static const struct meson_reset_param meson8b_param = {
-	.reg_count	= 8,
+	.reset_num	= 256,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
-	.reg_count	= 3,
+	.reset_num	= 96,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
-	.reg_count	= 6,
+	.reset_num	= 192,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param t7_param = {
-	.reg_count      = 7,
+	.reset_num      = 224,
 	.reset_offset	= 0x0,
 	.level_offset   = 0x40,
 	.level_low_reset = true,
@@ -156,8 +156,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 				     "can't init regmap mmio region\n");
 
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
-		* regmap_config.reg_stride;
+	data->rcdev.nr_resets = data->param->reset_num;
 	data->rcdev.ops = &meson_reset_ops;
 	data->rcdev.of_node = dev->of_node;
 

-- 
2.45.2


