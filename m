Return-Path: <linux-kernel+bounces-185150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376638CB135
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586D31C2176A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970281448C4;
	Tue, 21 May 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BS/EnN8P"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A711442F4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305202; cv=none; b=MkDOznrjW+j2gS6vfQcBMD/QqCUHCJcCYvYoY5v40o1bCpMZkrxWBDSAi4uomhIjtFd2KN1uv/hxgY7XmvT4mwh4/1dcDLvEqI/GDdgzgCRDwN/WuKj7oJyNhb3dAOxfa/6ENWXP5uACMZIMvil73rUwQVniRWRFJ9lfT45EGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305202; c=relaxed/simple;
	bh=YbcpAnvKee2GOMccnSTVfLdSPbQ/cZoM9orq9m3+dek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDpYbXOIU0ILZYUAWqpwkuHjSZeeiGvmqU2iFB+nceKkPbKyBFBLFGlOnllyCAmC2q8MsX183D+yVOpAYWeIfIVZMQFYCIKTz/4agE7B33sxFA5teMDE3lI06JieYEDf/dRbg0+5woLc256E84ptxKgcai+pwVDIc4+vJeiSwOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=BS/EnN8P; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so882608266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1716305199; x=1716909999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SP7h2B6yJgGk4TH9IEQ7JI0U019rt16DjXGMkeKeb4=;
        b=BS/EnN8PmaRk1Jmat2BP1RZDEfPL7COEnqjTFsqKlLlt4brTZk8qLSb8L/AJOyr2en
         D5zuaIOZ8XiRsLtXzvyZRG0bxeaVbSa3pkywN91poW9SnbyEB1jfWY3Mdzfp5OUzIhNO
         VTkfAaY7P7IgvxhVLaOF2m0zHtvMPImKEXsBs1Ia+ScdvwZcFMLzyui7aYzLH8CoMbUP
         qxGWcK8IK5Y9GakY+U61BpLAXbHvL3nmsSv0LN7Hxc342JWP8/KCCw7uXLkFZKsuSXDe
         TF+Znt7g+fkyFnY9aSOIHNfpfeEVnS6uGL+lE6bHhueFQtdV6AXrB2snwKxK0pvFtVp9
         FTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305199; x=1716909999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SP7h2B6yJgGk4TH9IEQ7JI0U019rt16DjXGMkeKeb4=;
        b=jrplGL3P5vCaaLhzwdUctbKbrF+w+hkmN+pAnFSS6YgR2quAggYpBISdBDR0a50CXx
         Zs2DYVIAVsZW6RtNhlD4cG/sExaILI7ww8hnS7tK7NrTd7gFvzCY032MhXGQNcfmSYXZ
         yp7wUTPbKWiUmeGHcQbKTo07ypjYqfmCC8hNOvIbrMacS/twsrDkCpMUy5N/sIlf7g05
         KZW6eyJVcF2LMeyfE0BrIs2yVVhypPrZ5emNp0/hazSpjjRhA3UYT/AF2opX0pzfBLQ2
         SkNZmdzv4G4wotTYMmfXUjOjTJ9RF2SD2W+JQOm+4J/JVfKElZxZEBbFDEuJtMfxJasB
         B8JA==
X-Forwarded-Encrypted: i=1; AJvYcCVfpzt3vy9I6Psq1ViL+4hK+k3zVJrtpLJpJw4EtckDJw6IDMTRiI9R73C3zZWf+mujM04fsc0IFGPLCz9uRLe8pgNff8pcK/oT/8Te
X-Gm-Message-State: AOJu0YwFkl4/4/9TrWTVuNFbXAe+HOeHQsFPlBvwmKSfsh7ue4wk2Xcj
	e+327f3757mfoolK52kizGAtuhGs4P1H4l5v+ZkJRhJJ2z5opxgpVoNShG/+hgo=
X-Google-Smtp-Source: AGHT+IHNXBESWf3UtYt88Rul5ND3zDlu4ztC4pHIbV9GB5hTd3riRS/EOXQgXNRtiuUfWmdtSDvAWg==
X-Received: by 2002:a17:906:6882:b0:a5a:76e2:c2a8 with SMTP id a640c23a62f3a-a5a76e2c306mr1547537466b.23.1716305199086;
        Tue, 21 May 2024 08:26:39 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b180c7sm1638327666b.221.2024.05.21.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:26:38 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: naresh.solanki@9elements.com,
	andy.shevchenko@gmail.com,
	broonie@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pinctrl: cy8c95x0: Use single I2C lock
Date: Tue, 21 May 2024 17:25:57 +0200
Message-ID: <20240521152602.1097764-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there are 3 locks being used when accessing the chip, one
in the driver and one in each regmap. Reduce that to one driver only
lock that protects all regmap and regcache accesses.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 981c569bd671..ca54d91fdc77 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -453,7 +453,6 @@ cy8c95x0_mux_reg_read(void *context, unsigned int off, unsigned int *val)
 	u8 port = CY8C95X0_MUX_REGMAP_TO_PORT(off);
 	int ret, reg = CY8C95X0_MUX_REGMAP_TO_REG(off);
 
-	mutex_lock(&chip->i2c_lock);
 	/* Select the correct bank */
 	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
 	if (ret < 0)
@@ -463,11 +462,7 @@ cy8c95x0_mux_reg_read(void *context, unsigned int off, unsigned int *val)
 	 * Read the register through direct access regmap. The target range
 	 * is marked volatile.
 	 */
-	ret = regmap_read(chip->regmap, reg, val);
-out:
-	mutex_unlock(&chip->i2c_lock);
-
-	return ret;
+	return regmap_read(chip->regmap, reg, val);
 }
 
 static int
@@ -477,7 +472,6 @@ cy8c95x0_mux_reg_write(void *context, unsigned int off, unsigned int val)
 	u8 port = CY8C95X0_MUX_REGMAP_TO_PORT(off);
 	int ret, reg = CY8C95X0_MUX_REGMAP_TO_REG(off);
 
-	mutex_lock(&chip->i2c_lock);
 	/* Select the correct bank */
 	ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
 	if (ret < 0)
@@ -487,11 +481,7 @@ cy8c95x0_mux_reg_write(void *context, unsigned int off, unsigned int val)
 	 * Write the register through direct access regmap. The target range
 	 * is marked volatile.
 	 */
-	ret = regmap_write(chip->regmap, reg, val);
-out:
-	mutex_unlock(&chip->i2c_lock);
-
-	return ret;
+	return regmap_write(chip->regmap, reg, val);
 }
 
 static bool cy8c95x0_mux_accessible_register(struct device *dev, unsigned int off)
@@ -524,6 +514,7 @@ static const struct regmap_config cy8c95x0_muxed_regmap = {
 	.num_reg_defaults_raw = MUXED_STRIDE * BANK_SZ,
 	.readable_reg = cy8c95x0_mux_accessible_register,
 	.writeable_reg = cy8c95x0_mux_accessible_register,
+	.disable_locking = true,
 };
 
 /* Direct access regmap */
@@ -542,6 +533,7 @@ static const struct regmap_config cy8c95x0_i2c_regmap = {
 
 	.cache_type = REGCACHE_FLAT,
 	.max_register = CY8C95X0_COMMAND,
+	.disable_locking = true,
 };
 
 static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip,
@@ -559,6 +551,8 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 	if (reg == CY8C95X0_PORTSEL)
 		return -EINVAL;
 
+	mutex_lock(&chip->i2c_lock);
+
 	/* Registers behind the PORTSEL mux have their own regmap */
 	if (cy8c95x0_muxed_register(reg)) {
 		regmap = chip->muxed_regmap;
@@ -574,7 +568,7 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 
 	ret = regmap_update_bits_base(regmap, off, mask, val, change, async, force);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* Update the cache when a WC bit is written */
 	if (cy8c95x0_wc_register(reg) && (mask & val)) {
@@ -595,6 +589,8 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 			regcache_cache_only(regmap, false);
 		}
 	}
+out:
+	mutex_unlock(&chip->i2c_lock);
 
 	return ret;
 }
@@ -667,7 +663,9 @@ static int cy8c95x0_regmap_read(struct cy8c95x0_pinctrl *chip, unsigned int reg,
 				unsigned int port, unsigned int *read_val)
 {
 	struct regmap *regmap;
-	int off;
+	int off, ret;
+
+	mutex_lock(&chip->i2c_lock);
 
 	/* Registers behind the PORTSEL mux have their own regmap */
 	if (cy8c95x0_muxed_register(reg)) {
@@ -682,7 +680,11 @@ static int cy8c95x0_regmap_read(struct cy8c95x0_pinctrl *chip, unsigned int reg,
 			off = reg;
 	}
 
-	return regmap_read(regmap, off, read_val);
+	ret = regmap_read(regmap, off, read_val);
+
+	mutex_unlock(&chip->i2c_lock);
+
+	return ret;
 }
 
 static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
-- 
2.44.0


