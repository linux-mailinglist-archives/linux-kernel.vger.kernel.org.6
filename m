Return-Path: <linux-kernel+bounces-323456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D53973D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8FBB26BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC621AB517;
	Tue, 10 Sep 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SkDxASP3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D21A255D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985989; cv=none; b=SPr4ij+NELqFvHZBWY6hE/JV+et/ICdCzml14X6AXtRPkzZeogTdzgjKUom59Mpn42WWg0oH3f5jNYye9zxeHlxnCHKQnbAhwcFQjWWWj7XcJ/71jStusGYMK9Of/4gA3an2Opwap2L3QzDdXaKZqI8tPwtEGxWl8xqZ29l3HOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985989; c=relaxed/simple;
	bh=G/tkeTFlEEIIRl13gZHjvQ8SKXa0knkQG6ZsLKG6Sak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evtQGz83Rue2jyYtdrv302hIeMqvlCK+/dtQTTTD+b+8BBqV4PtkkwrH9oOQZ1FSwtz/VLw9fL9kF1I2UC/dDoOnoAuRYkBWHxXQL5odrOjxvpeD0B1ku2kg4dXYNrHL08MzdJbbCL/y1AZlvQD/21dryLON2qw2bX3uoUA3JtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SkDxASP3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so10101075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985985; x=1726590785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/Yf+6uxXV0kV2P21eOVpIseB4Hi71hF6SfqZ+9Zm0M=;
        b=SkDxASP3MUQzVZtjdM3aNSqBSqLtuN6t7EeceCk3lq4DNCTXKiECuTgedcgzjU2pT/
         +5V/4xox+iht7LLpzx8i0MGmtBvGeWSX3bH+zz+qT8GOrfh721oxwdQs5DB+eKzu9oiw
         EKL7kINeo4beLQt39llYKV48hHpwD8DZTyfP/xZ7HUTaIxJ7kCiQT6Ixq5JVG6a/lycp
         8jazLfvPseIAt5UGu+zE5caxjTW/3cSqQhg9rXcgindi8oKbYipYndw1THmbIX7L3RY0
         vm+hyBfSy5Cxh/gzywXXU4sCkyUZd+F40Nsds4HmlBjT/o7MHws2l/H2x77c31b9I45z
         YWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985985; x=1726590785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/Yf+6uxXV0kV2P21eOVpIseB4Hi71hF6SfqZ+9Zm0M=;
        b=Lb9f4zhw7gujSC9zjD1YowmOLjAbUCK/+oB2gEqJ9YmiPOikslIgMIpJcY2kHxGj5w
         ZK6YZvmXKhbWQOl8jEn2Bo6juYThowpGlf6i0bZZr42qgIXN7sTHWJuwW0cbnDBk2fGm
         VKPrqGD2tILBcZR8mTSzr/9ZbY/HFuCy5v7KGaKK51Jg6FS5o0l+P357Yq47JyrMeTax
         tjgCGYg/VYRrUJDoDj5h3jZTZCrsZjNaScyMnhoz4vXWC54u08/RU+VBPzGWAPNU6il0
         e2uenw+kzgeGjL4r1hqfNeS77qCbmvDh7H+gWS63x83CPmt2x/x1SUZxK+o0dBsnVA3T
         50jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYlSc5klxu9DzpdNA+UBI5jSXfeOkLIA08a8F5aWPp605SCv0JD1R2kg9rsEHqF0sHxrlKFnkf2U1Ulog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3sws4IU0P8/xOG0/PLIqVS7tVR4i/Iz7ZxMhqjFrzLbOlIog
	P+2dbIqpd6fSgkP8/CP8rwdiZSkABmderBlgJA552GRzRqvFfiSMBbXhDQV71Zc=
X-Google-Smtp-Source: AGHT+IHTj1g8Y395YW3wLjECUH+eCckaYId/zx6ot0b8rNoXiVuTR4Rq2dpj9I0vr3gefwHx3RCAxA==
X-Received: by 2002:a05:600c:3b25:b0:42c:b905:2c04 with SMTP id 5b1f17b1804b1-42ccd325012mr2207915e9.12.1725985985361;
        Tue, 10 Sep 2024 09:33:05 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:46 +0200
Subject: [PATCH v5 4/9] reset: amlogic: add driver parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-4-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=G/tkeTFlEEIIRl13gZHjvQ8SKXa0knkQG6ZsLKG6Sak=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS3TGn2HCTwzONvcK+JqbnLVn31ARCNTMtTE
 h4EpAyoLdKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0twAKCRDm/A8cN/La
 hZOaEACwoFmJBZJC0dAuoD9d5L/78cmabU9CiavCRFGVKkqa+GZUy6usmXyIac4i0bnd611HSQa
 vtmP1c5D5GRo6kfRDrbP3y4RkINUB19THzvysfcZu2AfMCJDnCb4FE3XrJD/ZRnzZh8gtYVhnYB
 PExbL5n28LHuibOXeGB5pT46CYR3joyRQ6LxwXvxEx6+JZkWjMrd/wkREUuqEfqJ9AbHbBcEGqi
 Bv2lWXv4hntGJWRLUuK6J/n8kZY5Sf0c2ozu1Ho3f4K62kcJlwOmii97BubTJ/sJFFK41SfK0S0
 iWIjpOEA06NfL+VQWsuUrlOKpyiZwB32Hu9El32JS1XrKlwAfUTTG5Cq4ZezmuvqI/draqbT4gc
 H4Cn1cn98ZnBWJ8StokvGVh4RHlD4WjcTBIQqGzxQLQF5ZA/Ypxze125XlTVHmBbY7K3Wln4LgF
 6v+pi0hMlqZiIs4PSEodj8DaCcKLRDwHya6M+XO0Zl4Q9669IKGmbSPtRTRCafd3mozDcUHEGPn
 UmVIjPSo9z9aOdpQqCInKP4wRz3x7Zvuu/0GAqLJRejkZ3ZtmdYXzTFPmYNwJt34HhQvMKGRshR
 68rKKWYbJIxr4/AWTNEPfRZJ/mnnq7I36KrfVW8a0gFRbIW9pTXHaLHzbST7QY2Fw34Gw0vBY51
 +oL2r8AAbh7C/fQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

To allow using the same driver for the main reset controller and the
auxiliary ones embedded in the clock controllers, allow to customise
the reset offset, same as the level offset. Also add an option to make
the level reset active low or high.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 50bd2241ef2f..6a90613c8095 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -18,7 +18,9 @@
 
 struct meson_reset_param {
 	unsigned int reg_count;
+	unsigned int reset_offset;
 	unsigned int level_offset;
+	bool level_low_reset;
 };
 
 struct meson_reset {
@@ -46,6 +48,7 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
 	unsigned int offset, bit;
 
 	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->reset_offset;
 
 	return regmap_write(data->map, offset, BIT(bit));
 }
@@ -59,9 +62,10 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 
 	meson_reset_offset_and_bit(data, id, &offset, &bit);
 	offset += data->param->level_offset;
+	assert ^= data->param->level_low_reset;
 
 	return regmap_update_bits(data->map, offset,
-				  BIT(bit), assert ? 0 : BIT(bit));
+				  BIT(bit), assert ? BIT(bit) : 0);
 }
 
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
@@ -84,22 +88,30 @@ static const struct reset_control_ops meson_reset_ops = {
 
 static const struct meson_reset_param meson8b_param = {
 	.reg_count	= 8,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
 	.reg_count	= 3,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
 	.reg_count	= 6,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param t7_param = {
 	.reg_count      = 7,
+	.reset_offset	= 0x0,
 	.level_offset   = 0x40,
+	.level_low_reset = true,
 };
 
 static const struct of_device_id meson_reset_dt_ids[] = {

-- 
2.45.2


