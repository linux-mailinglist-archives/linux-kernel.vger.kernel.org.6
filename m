Return-Path: <linux-kernel+bounces-536032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DA8A47AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1693B065B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68022B8B5;
	Thu, 27 Feb 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GommgqJB"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7322A4E1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653203; cv=none; b=hh58yWY8lGQ+Dkh0n5vZ6Jg4Lz7tYwNuUAb1S/hMRp5o59qG3j26QTSE3ojPPlYbrVR+oJQNvRvPupdikNLlaESrqtMvtJEN35F2h7TOPsFZVakrlHTSDfWfJIZll7q/UqE9ByvjRda7irQmtL/Yx51M7exdAZbH6c6dm7/wpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653203; c=relaxed/simple;
	bh=W9D+anLswderraXRnZUvbxnOgYIsKuJjLY7iig4it4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSQog1H11xCfXHfOWPbWPb5ppeeq1NFX8B6IFrb5eTY/eHKK8Y5y8H7KOqED1Zoo0wr7m0aAqyaawHbv8XEL0VzMXNVXvKNnZLoI+caoR0PeZ8PQnkq0kC690VHchbL43W0REd2hFfsItenfxChPhin5f9ash585LTt+C2j4ecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GommgqJB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso1175803a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740653199; x=1741257999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GinroxZiXaUl0iulTclS3Q5Hjx+0LaS8RfRGW3GbBU=;
        b=GommgqJBDnmdCWUQoaT/QRdTmY4OZMLY4f/lOQxdY3kKNUeZ/Kh9UTxpVkOimpzOg1
         7IiL9URGjV3A1ZmfU+jVStjqJCC/ACb+SukMt9LcTfzudK2jAzQhG3jUcgCsHgT5qjNw
         xHdmwj5xg3Kso1JBMzfgJYKheV/jDJtHuWTpNRgZBgW9FnLzuoC4sgtxRb1tPPfGkAK0
         iTkbE+8O6bSEqMQTIZnALNvJSXiipBycvL7E1mNtsx4WWuq+5/DC9wm3IKTcCZxxtHb6
         PvuoD21i4ZTag2K9CiGyoAyFI3ktwX2nbjVGx+bwwcYW7UBUY6kznuYcO4KLmho0M5AQ
         xEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653199; x=1741257999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GinroxZiXaUl0iulTclS3Q5Hjx+0LaS8RfRGW3GbBU=;
        b=F0drAhJfwwmfdXb0e5IPNI7zURzU/Zj2XvhWNlrlSj2eOATaqZ3opk3Y5FDgzh/p4o
         MuD5fpasPEthicA3uWtcduFIP/3KFvu9yNtmINMER/U1QcX0foP0nJsne0VZgQB+N1NM
         tiOZD9yzp3j8kGg2v8CcQxNyDIIMYDMKhWwfLxIVnMEFjYThbbZNbH/cM2R0ogngrpGF
         2yFtE2qQsOetawYFGTnkTIUKkXrWK70kk/HoWGnu/Bnqr1WFoJWmXxkwi3BhZnbda5mp
         0OygwDnP7uBOE0M2iGyyeE8BX8kYa/5TkFT6R9uf2gPSRZUuvyeOkNkX7IfX7pHNRQH6
         XSow==
X-Forwarded-Encrypted: i=1; AJvYcCVNqdoXPUYGCrqhE8D6xL/nzVFG/T7NaxskwmZs+uVpg9Ys9jgDq0uxo9bt/jdB89gzNzhAYC8fq60ydy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDO42g0sNezYHhW0BBLNwVWkGSoNBlen3yStjqoO4LIyri+Sy
	BWSwT82RXAn1DBK6E/bWKuQ7KPH5skKcQ6m1MdcnNiMyzQcjOSHVMYyIcCKN4EguIj1v0yEqv6t
	cX+o=
X-Gm-Gg: ASbGncsH5cxoAp7hufS0xmTc/wJiThr6s5eclLu0xKXNOwgqe6QG5w9MCkehNHGuYVq
	Ec/j/Nj9mon9kV8RmsoP0bsg3/35sOqsNWF0cxjw0osYG84k/hqsKnXcAVxdqSpeuwf0QToqEPU
	XQcvi+Jx0ZrtpVzup1hQIOwFtrCtn9MEWkzrSA3bQ+tffPItvGbMp0JQkkuGTarF44XMUCMKsTf
	HRRAOT/4/+5qvyk7QjOhW/J2A5slMU2WZ1E1/Yr+ZD5xU5P4/xxKJmTHdqEQr5RBFbxyyElOMmi
	vwnB4QIibFVXqYra+UTyGdvp9yMhR9/gEbEGJtud4WpKvVaFAWWiskULm4AmYl3D6i87OPTz0xR
	1vNO1OZnQ2g==
X-Google-Smtp-Source: AGHT+IFqCgtaEn18UyqkDgMvhRqj12YBC1o82ZagmdpxbrZDloQykLk5OMYN37B77iU31+3OfQ8GNw==
X-Received: by 2002:a05:6402:27d3:b0:5e0:82a0:50ab with SMTP id 4fb4d7f45d1cf-5e4a0e160e3mr9376148a12.27.1740653198730;
        Thu, 27 Feb 2025 02:46:38 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb5ad8sm901032a12.34.2025.02.27.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:46:38 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 27 Feb 2025 10:46:14 +0000
Subject: [PATCH v3 2/2] power: reset: syscon-reboot: support different
 reset modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-syscon-reboot-reset-mode-v3-2-959ac53c338a@linaro.org>
References: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
In-Reply-To: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
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
 drivers/power/reset/syscon-reboot.c | 96 ++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index d623d77e657e4c233d8ae88bb099bee13c48a9ef..81b917a531b8bf04d7c5e7027bdc3290f2183eb0 100644
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
 
@@ -60,12 +85,61 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	if (of_property_read_s32(pdev->dev.of_node, "priority", &priority))
 		priority = 192;
 
-	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
-		if (of_property_read_u32(pdev->dev.of_node, "reg", &ctx->offset))
+	/* try to catch enum reboot_mode changing in any incompatible way */
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
+		char prop[32];
+
+		snprintf(prop, sizeof(prop), "%s-offset", prefix);
+		if (of_property_read_u32(pdev->dev.of_node, prop,
+					 &mode_bits->offset)) {
+			snprintf(prop, sizeof(prop), "%s-reg", prefix);
+			if (of_property_read_u32(pdev->dev.of_node, prop,
+						 &mode_bits->offset))
+				continue;
+		}
+
+		snprintf(prop, sizeof(prop), "%s-value", prefix);
+		if (of_property_read_u32(pdev->dev.of_node, prop,
+					 &mode_bits->value)) {
+			/*
+			 * unlike catchall below, don't support old binding
+			 * here
+			 */
+			dev_err(dev, "'%s' is mandatory\n", prop);
+			continue;
+		}
+
+		snprintf(prop, sizeof(prop), "%s-mask", prefix);
+		mask_err = of_property_read_u32(pdev->dev.of_node, prop,
+						&mode_bits->mask);
+
+		if (mask_err)
+			/* support value without mask */
+			mode_bits->mask = 0XFFFFFFFF;
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
@@ -73,11 +147,11 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 
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
2.48.1.711.g2feabab25a-goog


