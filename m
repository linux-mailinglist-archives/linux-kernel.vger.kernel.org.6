Return-Path: <linux-kernel+bounces-230321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9408917B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1693C1C21329
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DB15F41F;
	Wed, 26 Jun 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fkUk8Mkd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A401EEC3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391544; cv=none; b=f+A5O8JHqoQ9AAu5cKZmK/86JFE2RPvecLne56cPfonF8GG5wbOQUDRv/2N3pUv42WwNQCMnpbt7RLe5KtN98UJE177/r8vvEYrs9JDyPv15FjwrTQpLjI/ENb+9m8tcx/0qE8Yv992rsb4SR4hj0C/wv/eBxHLiBa5zbc9/eHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391544; c=relaxed/simple;
	bh=e+4il4BiDqDqxdJ+2HXtfhb5dyGkvKJ2NlmBscN7Lsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nb5K8sCSgSWBzcRyj3u0QUDDbbWl9sLkJQs/OtMsmE5as367IuTwKvuE88u9xfl9LDXasidS+dyQLIR7fSfCRrBOK32VauZUqGYSILnHmlzAP5Q561zygnPg6LDtU4E2/v3bF34EBBQIYIKZO7VSsy4cvcehNgRSU6CYl323FjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fkUk8Mkd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a72517e6225so431718366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1719391541; x=1719996341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiDsIDBP7mglQq7Zo2R30eNEeyLgI5TULZGsWugMJk4=;
        b=fkUk8Mkd3tNXmEuh+f7SuiDafff5f+ftgkswgLjlo6H7Vr6UZF9eNjqlUcro9djeNZ
         NulqKLlqBCGSygZZyKkBF3zDkkCC5dLGD2PueGhyILyqnnhOtAX8m11cRokwvyyC4Frw
         xASXLZhn3LgoI2Diny+qyUeCimRVyXFTsVLqs/aVXxzN18rO25ineTWSa53niGDAxARO
         mE50fuhMzaK2+7zOoA9QXlYCRntwvkq+KXQ89dT7PYhvU1sYh7lELeg8gKEIWvuuEzzM
         rwk63FTSCCrJG5TJ7x8fkzwshJghxZMikOIF8tgfXfXnL88Su/B9aehgmF1jkzvaYe0I
         hXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391541; x=1719996341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiDsIDBP7mglQq7Zo2R30eNEeyLgI5TULZGsWugMJk4=;
        b=jrL2DWAK1nqy3whGiSBV0s5YUDt4vxdpN3yl0ggAYxKaej4+oNKFW/K9uutbkJmtCL
         8B+z+RAkMHC4gfwHGnNYgW7wxCex5LYusOwsOP98EWEQN320tOjQaNV+1eLZgcLnS1Oq
         Il1RxtD3+fVvEnAnu86dqdzSXX50aw5/9E5EMEFUzAlGtyp1wbD9NEdb2E8hl6qqz9ya
         wFWH5dN83KtU2hD8Fv0JWOIxJWzCPATPdfM5KWa8hjlIU8Eju+QxbjMaPKgpOGsoVZ+H
         IOQynn3alFOP356Pm14X59Pt4zgpHMgKHo6GFE91GFMAaBMfOQ5+LBuoF1VgYo0GUnNV
         ogag==
X-Forwarded-Encrypted: i=1; AJvYcCXxxFkatv9ljYoznKYTNsURNVwfVBnb3eebgc/hk7+ClCSX2JhpOOmdLg9ah1dfF6hfOYmO0pPcw6AG0pkIox5Kj5cGONvDb7Z0uebA
X-Gm-Message-State: AOJu0YwX6sCR9d6CgvUtUkKECKxgs+U4TzFqaYxmiWokEY7Wv6pua3S8
	MeC93h8D0nvqVbqqG3u7TTC67f77KIwUl6LBYAAsWJDmbBrHvw99cvy/9GrqCXI=
X-Google-Smtp-Source: AGHT+IETBbf+gHc8aPv/nhXZcZ13PbW3DXb5PtzTmTYrkptRRxHPPyjOwl/EAxG4mHTvlKU/EZqLdw==
X-Received: by 2002:a17:906:230d:b0:a6f:50ae:e0a with SMTP id a640c23a62f3a-a715f978a7amr612805566b.37.1719391540668;
        Wed, 26 Jun 2024 01:45:40 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72605ff279sm218647166b.5.2024.06.26.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:45:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: naresh.solanki@9elements.com,
	andy.shevchenko@gmail.com,
	broonie@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: cy8c95x0: Use cleanup.h
Date: Wed, 26 Jun 2024 10:45:22 +0200
Message-ID: <20240626084525.787298-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the guard mutex from cleanup.h to make the code more readable.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 4efb8b5cc2d3..781949e0e09e 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -9,6 +9,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
@@ -480,8 +481,6 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 	if (reg == CY8C95X0_PORTSEL)
 		return -EINVAL;
 
-	mutex_lock(&chip->i2c_lock);
-
 	/* Registers behind the PORTSEL mux have their own range in regmap */
 	if (cy8c95x0_muxed_register(reg)) {
 		off = CY8C95X0_MUX_REGMAP_TO_OFFSET(reg, port);
@@ -492,10 +491,11 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 		else
 			off = reg;
 	}
+	guard(mutex)(&chip->i2c_lock);
 
 	ret = regmap_update_bits_base(chip->regmap, off, mask, val, change, async, force);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/* Update the cache when a WC bit is written */
 	if (cy8c95x0_wc_register(reg) && (mask & val)) {
@@ -516,8 +516,6 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 			regcache_cache_only(chip->regmap, false);
 		}
 	}
-out:
-	mutex_unlock(&chip->i2c_lock);
 
 	return ret;
 }
@@ -591,8 +589,6 @@ static int cy8c95x0_regmap_read(struct cy8c95x0_pinctrl *chip, unsigned int reg,
 {
 	int off, ret;
 
-	mutex_lock(&chip->i2c_lock);
-
 	/* Registers behind the PORTSEL mux have their own range in regmap */
 	if (cy8c95x0_muxed_register(reg)) {
 		off = CY8C95X0_MUX_REGMAP_TO_OFFSET(reg, port);
@@ -603,11 +599,10 @@ static int cy8c95x0_regmap_read(struct cy8c95x0_pinctrl *chip, unsigned int reg,
 		else
 			off = reg;
 	}
+	guard(mutex)(&chip->i2c_lock);
 
 	ret = regmap_read(chip->regmap, off, read_val);
 
-	mutex_unlock(&chip->i2c_lock);
-
 	return ret;
 }
 
-- 
2.44.0


