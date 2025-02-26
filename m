Return-Path: <linux-kernel+bounces-534031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B48A461CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E381893A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC72221D9F;
	Wed, 26 Feb 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW7S127S"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE37217F5D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578908; cv=none; b=FxvKxvotJ6phLUq7OVx7Ph/SIRdwIZoX8K3SM0ClChZPRp4pn9Iges8+b199Cn2pXyNgGfcEIsPhTkdtzZEp2fIDnM1SKeUpKbsrP2Jdr6WneLohSsGdk1rzK0se16nSAyj+QPgOn87sA2OtoakfmvTKWIGO4eC4k1uARisOvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578908; c=relaxed/simple;
	bh=iNT0VqOrH9vAHA1UAijWCgNgr5GDEqXdheLf0A2HN9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BrEKISCxfDFu8RiYRHsFSyD5yaXa8KK5h8WFEMOWB75MZfCgUc6zD3t5vymbNP8K1URY7u3QXGGzDVw85j+wAdc98VTthUxT0gg7AJaWdrEv385+lbl/WtMoD4GUWLs5Jl9txZFmBxa4v7Ui8/NziF8+gOYgVqumOJdHxPy43KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OW7S127S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso69831345e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740578903; x=1741183703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxeFUEnPMpG6A3aZld5E/WFu7bcPUUeu7zfpRBo6A78=;
        b=OW7S127Sv2ogLD1vBLxNcb+XadepPo7LcPz0iLZlfIBrV84iBNBOmIZyZLGGhte3qU
         naRHm05Is229BOAVMMoGqAjVUk80VVuXbQGyhFPfqEjueS083LLUNNyBDSN1JbR71h27
         gr7ihFyJPy+iBMM6FLD/E0TyNjTVEbMRgWKKAoCgVIH6XQAi52o6cGgkyA7HVhUwjCHL
         JbVfUZfv6B+qna3CFqKYaF9KKEZn6nit3Jq8MEfmxOBCOkH8o2NFIwqzqpQmkeP5AP/8
         rED34ChY689awQG8i//qF92UK4NR0EMPNEmO+DFlDR1XOgjtUKACe40sM7xq6I4qDBuV
         5Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578903; x=1741183703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxeFUEnPMpG6A3aZld5E/WFu7bcPUUeu7zfpRBo6A78=;
        b=IxtCbt2rfy29FWep8bh1eYvRX8nLTv+0yuExCGMOqL8UMcgE0rJUztmYqWGyYqcevB
         UzydkB3GUl7SJ8Qmbb4w1sUMCnar7X/xpp/j45ZZHdXKdkrsZw1vpNrTjzFT7SpNMnK6
         1+W/TUIJ8Gi5M41zV8RAmkJAmsI7MB8YIWr9vkXbYzH3Xz+0+vmrs552xMjOWEXEaSAI
         lNGjBckGwCPV2CZZyxATPCBcjH1b4zkEu8s0fzR82E1erikOkD3Unb6VPerI7yOkyzkh
         /Is3ympLl93m5VgZs9RYbI5H6g7YuSB1JB2U7L7jDOXozsg5528AVRcJKDz0mz3auxTo
         LRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoE4upexN6pkIS7gpsJUqx1K/i26iUpHSQHwvAHWWLElUfYkDvX1mHweQMCNIT1ZB5IRw7P5A9WFISZNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX03CXrdGeY9UprAq2eGlZLA+xPU7SZ0zIUNf/YBS7T7uJ7Uzd
	3MJiV++fPgU0BiSjN0KzkeHVvtbn+DnWWAgXsY0Sq8JSXVWu3pUR6w6l3/zzSJo=
X-Gm-Gg: ASbGnct8J/36REqCm0b2NhvClKM+Znr1ROTo+l+UvWNtWLFQGB2aZhaa9WX2X5Wi0tX
	TdYf+HJf8TDxxb0b1MK1kRyOTzNM9eu8aiWGJ1vSjkGbbv/OeJ86lIjeYnxjNkv7euxGAn5y+xT
	Aq/M6yDhGV3soiPITAkcsoQ+uIjfIPymrVwR7EGKdKWQBqT25Zry0tgql7HuJAIUiqRq0vyuZsM
	1xAX/zuKOUzaNKKUhJ9k0rTRSIgyfrOP+Jnd7EG0agv7QJCvbFHY0KBlzlfywBDTJtSZIYJEn8V
	mD82HWzOoXM6/o7RRvvubKg82kCP1NN11Qdgm5NdpDGspDMc0SOt4sFWJy5Q853soqZXWbxNlKy
	WG6IM7PWf8g==
X-Google-Smtp-Source: AGHT+IGv/eO4Q+853qoaaBSUt+F6k1tIspvcIuibPPRIZkfwO2bs2v7+pxNtqXYPmvOTuy5Yt55vgA==
X-Received: by 2002:a05:600c:4753:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-43ab0f6e6ccmr69618395e9.25.1740578903152;
        Wed, 26 Feb 2025 06:08:23 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b6024sm330157566b.181.2025.02.26.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:08:22 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 14:08:21 +0000
Subject: [PATCH 2/2] power: reset: syscon-reboot: support different reset
 modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-syscon-reboot-reset-mode-v1-2-91c1b62166ae@linaro.org>
References: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
In-Reply-To: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Linux supports a couple different reset modes, but this driver here
doesn't distinguish between them and issues the same syscon register
write irrespective of the reset mode requested by the kernel.

Update this driver to support most of Linux' reset modes: cold, hard,
warm, and soft.

The actions to take for these are taken from DT, and are all new
optional properties. The property names match the existing properties
supported but should be prefixed with the reset mode.

This change is meant to be backwards compatible with existing DTs, and
if Linux requests a reset mode that this driver doesn't support, or
that the DT doesn't specify, the reset is triggered using the fallback
/ default entry.

As an example why this is useful, other than properly supporting the
Linux reboot= kernel command line option or sysfs entry, this change
allows platforms to e.g. default to a more secure cold-reset, but
also to do a warm-reset in case RAM contents needs to be retained
across the reset.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/reset/syscon-reboot.c | 88 ++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 11 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index d623d77e657e4c233d8ae88bb099bee13c48a9ef..1d3d8a3265ae8005c685b42d3e554bd8bb0047ea 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -14,11 +14,29 @@
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
-struct syscon_reboot_context {
-	struct regmap *map;
+/* REBOOT_GPIO doesn't make sense for syscon-reboot */
+static const struct {
+	enum reboot_mode mode;
+	const char *prefix;
+} prefix_map[] = {
+	{ .mode = REBOOT_COLD, .prefix = "cold"  },
+	{ .mode = REBOOT_WARM, .prefix = "warm"  },
+	{ .mode = REBOOT_HARD, .prefix = "hard"  },
+	{ .mode = REBOOT_SOFT, .prefix = "soft"  },
+};
+
+struct reboot_mode_bits {
 	u32 offset;
 	u32 value;
 	u32 mask;
+	bool valid;
+};
+
+struct syscon_reboot_context {
+	struct regmap *map;
+
+	struct reboot_mode_bits mode_bits[REBOOT_SOFT + 1];
+	struct reboot_mode_bits catchall;
 	struct notifier_block restart_handler;
 };
 
@@ -28,9 +46,16 @@ static int syscon_restart_handle(struct notifier_block *this,
 	struct syscon_reboot_context *ctx =
 			container_of(this, struct syscon_reboot_context,
 					restart_handler);
+	const struct reboot_mode_bits *mode_bits;
+
+	if (mode < ARRAY_SIZE(ctx->mode_bits) && ctx->mode_bits[mode].valid)
+		mode_bits = &ctx->mode_bits[mode];
+	else
+		mode_bits = &ctx->catchall;
 
 	/* Issue the reboot */
-	regmap_update_bits(ctx->map, ctx->offset, ctx->mask, ctx->value);
+	regmap_update_bits(ctx->map, mode_bits->offset, mode_bits->mask,
+			   mode_bits->value);
 
 	mdelay(1000);
 
@@ -45,6 +70,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	int mask_err, value_err;
 	int priority;
 	int err;
+	char prop[32];
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -60,12 +86,52 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	if (of_property_read_s32(pdev->dev.of_node, "priority", &priority))
 		priority = 192;
 
-	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
-		if (of_property_read_u32(pdev->dev.of_node, "reg", &ctx->offset))
+	BUILD_BUG_ON(ARRAY_SIZE(prefix_map) != ARRAY_SIZE(ctx->mode_bits));
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_COLD);
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_WARM);
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_HARD);
+	BUILD_BUG_ON(ARRAY_SIZE(ctx->mode_bits) <= REBOOT_SOFT);
+
+	for (int i = 0; i < ARRAY_SIZE(prefix_map); ++i) {
+		const char * const prefix = prefix_map[i].prefix;
+		struct reboot_mode_bits * const mode_bits =
+			&ctx->mode_bits[prefix_map[i].mode];
+
+		snprintf(prop, sizeof(prop), "%s-offset", prefix);
+		if (of_property_read_u32(pdev->dev.of_node, "offset",
+					 &mode_bits->offset))
+			continue;
+
+		snprintf(prop, sizeof(prop), "%s-value", prefix);
+		if (of_property_read_u32(pdev->dev.of_node, prop,
+					 &mode_bits->value)) {
+			/* don't support old binding here */
+			dev_err(dev, "'%s-value' is mandatory\n", prefix);
+			continue;
+		}
+
+		snprintf(prop, sizeof(prop), "%s-mask", prefix);
+		mask_err = of_property_read_u32(pdev->dev.of_node, prop,
+						&mode_bits->mask);
+
+		if (mask_err)
+			/* support value without mask*/
+			mode_bits->mask = 0xffffffff;
+
+		mode_bits->valid = true;
+	}
+
+	/* catch-all entry */
+	if (of_property_read_u32(pdev->dev.of_node, "offset",
+				 &ctx->catchall.offset))
+		if (of_property_read_u32(pdev->dev.of_node, "reg",
+					 &ctx->catchall.offset))
 			return -EINVAL;
 
-	value_err = of_property_read_u32(pdev->dev.of_node, "value", &ctx->value);
-	mask_err = of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask);
+	value_err = of_property_read_u32(pdev->dev.of_node, "value",
+					 &ctx->catchall.value);
+	mask_err = of_property_read_u32(pdev->dev.of_node, "mask",
+					&ctx->catchall.mask);
 	if (value_err && mask_err) {
 		dev_err(dev, "unable to read 'value' and 'mask'");
 		return -EINVAL;
@@ -73,11 +139,11 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 
 	if (value_err) {
 		/* support old binding */
-		ctx->value = ctx->mask;
-		ctx->mask = 0xFFFFFFFF;
+		ctx->catchall.value = ctx->catchall.mask;
+		ctx->catchall.mask = 0xFFFFFFFF;
 	} else if (mask_err) {
-		/* support value without mask*/
-		ctx->mask = 0xFFFFFFFF;
+		/* support value without mask */
+		ctx->catchall.mask = 0xFFFFFFFF;
 	}
 
 	ctx->restart_handler.notifier_call = syscon_restart_handle;

-- 
2.48.1.658.g4767266eb4-goog


