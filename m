Return-Path: <linux-kernel+bounces-534443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A949BA4670B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428B3188A09D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF9223716;
	Wed, 26 Feb 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaIyCbZW"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE323222569
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588282; cv=none; b=WkTpbV7Jqh/lLCr0MjvD0Gnono9XMN2RApk/LHSSY76POPQslpbTxcvWOtaEvB9yUWYjxq2gPvB/AFdKyeHmOFUbShintVwbDQL17PEfQL6/PhnHJUdmR/T1FH4Yr+B5ztOwSWj5tqpeiw1EUgnArFb5yE2a+62DjiQ+E3TbtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588282; c=relaxed/simple;
	bh=iNT0VqOrH9vAHA1UAijWCgNgr5GDEqXdheLf0A2HN9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tq8kmpvAmad95iKOpRxEFhVfP9jwMiPCAqrVk4Ovigwr6Dsa2++tiJ70kJdERt2acgzA8OXYOezRjA83W20pYC20lHUaGhxOtKuOnPvuzlvNpqg85yh1FlBaW6JErHldCynk6FS1gpfhQcAKYUeukZoPCt9juAo6gmNg29XBkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PaIyCbZW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso12667509a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740588279; x=1741193079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxeFUEnPMpG6A3aZld5E/WFu7bcPUUeu7zfpRBo6A78=;
        b=PaIyCbZWVnIk50RgNRkIDvxNy14XzHoL9WoD8QxlA9x78g13pGAtN46n69B2Ge/95y
         lJa3WeRkgSMpwZIZGGHgHT/zFAxNSFdv9D3CO9OZujgvlKkC4jJZlV9m5phxP9FCYHIb
         7/NFxRD1prrEZnRIg0NHbm1+g2NJV8OpsK6vyeVPsvnAQji5OUW02obU79PJEKfzdnlW
         gzoQUmqGeRiaRuhuE3hHFqQQS6zYD5lsUrivVYdJinzpn5V2+WECKXp20/hl4n9M8EbO
         egfqlSA8Ffx4t4kSpfs3EW1CfucX/VlcjnvkI1gUe/7+m8wDtv8UgcYJKrnYRLBO9Ktt
         Dfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588279; x=1741193079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxeFUEnPMpG6A3aZld5E/WFu7bcPUUeu7zfpRBo6A78=;
        b=JCfp98B5PwvwHOSO9H+Ko9KgSXVeGspk3jnWqy+AMTPgOooHqlSusFb1eBaNpZGqom
         n0MKkPLnwIfgI3ptOiVSuRvHwoUbN7CcL1EyqAQCI8nxWoYAkldQ9yAhgvWbfzHWcdOF
         MNU7Lm9axse54IUa5egY3ECetiN5v9VWbqPwQ6LnJEE713G3u6wKNI5QLQeBIi+Um2iK
         Euzsgu4Inzjv5C0DOuJn1FO4OvvVM10XDR7d5w5lfNA0ufEUqUznzEkKZOSFnfYri+/1
         rdPF8HiUGdHqogJSt71OcW+h4Sy/bGdeN2Q5yY6b5xe5T6NSrMj+8oKwT3yiMWpGVqjY
         gDPA==
X-Forwarded-Encrypted: i=1; AJvYcCU7jxeGYP4DvPzMea7Vl6RO6m6Nj9OSCAp8mQwwWtQz7ghvNmM1eYzwqsj4V+bHsynvntoP09BPWOskeGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydE8Xnsf+3n2iq1r2Al9acLkuEg38KIqP1AZ4ynbpco1v2s6d2
	KDJU1YabHdbta3VfSMxK7UC1DtE/X/i2v6j4oqt6iwUS34QhxbN0KYyJfFFU3sM=
X-Gm-Gg: ASbGncsBHo4nqZqmBfMsMy1pbxOqYM4KubRj9J/YfU07U2kmTmiDyoGUzFbRNPPMfnY
	UyatbkGA4x6TzMyl+P1e5FQhVyTqNM48thhYmnqysfe7Na9Hy0HJUvuo8P39R5LBGkbMbBE8lz9
	PNxsTw+Xc4ExDTbYpezvivp0NfAVgIlO7L4/jlvlTN6U1+4qcF4PwTTbKD82yj8WFK7H+3lB7vT
	ktgAMsey520KQhZIgxxZuLqRUkNC52Yubd+RUJcIi0KDEOLDVUE4LwAKy0+l+EVcgFhrsCTaWC1
	cMoS2Ai5+xHWE6z91J1etxJzMLUDsKNVJj8+vxwmRrljj8RORVCgtxF+d3x2ZqQCgfUP5oxyt4d
	g6/gZkVnVrw==
X-Google-Smtp-Source: AGHT+IGv44paoi7SHvV5/BUy3MTrsCsjRS9MSLuRT7rzrBdvmcFLXDj/Fn1PZse8GNxAVzy8dxcAyQ==
X-Received: by 2002:a05:6402:4409:b0:5e0:815d:4e08 with SMTP id 4fb4d7f45d1cf-5e0b70bbf50mr23117724a12.3.1740588278826;
        Wed, 26 Feb 2025 08:44:38 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462032b00sm3058459a12.68.2025.02.26.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:44:38 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 16:44:27 +0000
Subject: [PATCH v2 2/2] power: reset: syscon-reboot: support different
 reset modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-syscon-reboot-reset-mode-v2-2-f80886370bb7@linaro.org>
References: <20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org>
In-Reply-To: <20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org>
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


