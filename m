Return-Path: <linux-kernel+bounces-310738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44F96809D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F9628254F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED962EAD0;
	Mon,  2 Sep 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DLWto28A"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777BC1714DF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262216; cv=none; b=ESRZT3Zy57Oxotpk9XQkeH9x47QtOebEZ0+x+JGhHmIxQqrwjMcqQawWmo1Ovc3Py/yKRobiLOLUjhe1QKOfd7iTW7YViPbrEUA38hfg3TYDMkkeNRlkA+GXOjEwWW0MGnQDl2yqIsaqOcdrskslZWw9bb99XsXkRAE152/Vhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262216; c=relaxed/simple;
	bh=iuzNHiTGA4qPPKrg+Ne9uUBp6SzEJWfWAWEO6vgqjC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJm6iKl5k4+m8mDjCZiMqa6A2IWwdPickkJKbNXsC1U3fqf1nZIGeQX76dDw+mN1FMw36RyRZhjy+LPkB7uQxSI8qMA2bovfnOcf8KPjVRas4EQeGIbsuBZ4bSIzHgVLaGOxV3z4Njvre1bZSnl+9Bcfu44TyuIRkW1dijZGcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=DLWto28A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86a37208b2so442461766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1725262212; x=1725867012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymqoQjZK7eHAmVItsICPN5ZMST4IqPsOrotjK86QITc=;
        b=DLWto28ACeISAeVXnE30+EsGLdfPDLeYK+Wgy1iFJXTkXegr6bJ2NyI6Uu7BVixI1/
         SFlKm99XJZHoCVR+DX4wfBDs3UqaYqQKGK12+LmYTjFpXtS6dyetVxk/NY2D6G6QFhjl
         H7d7s43ZZPs7q+h7g13YjJrnKd3AvyJ1JeXoaKMdicGLcpvKjWG6y8r6O7+iVw0GTklG
         JYriCogRqHTHiDIg+erFWPWm2slJNYhBbkCwAqJQ+wILS0MBiAiqevpBb7Bqd0tC7iP9
         ukTKNwJ8bOhoVUfgO5oTnsLq6rwxTlf0h6PlDdikeMT+UBKxBm0I1IK0k4QbgbwK738g
         h+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262212; x=1725867012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymqoQjZK7eHAmVItsICPN5ZMST4IqPsOrotjK86QITc=;
        b=LJPy5tBzDmOcyZC0bR+4W8KP18Ze6JAnkRVbjzaaEauBIcneZYRsJ2tf51U+vDpN7u
         x4X1dB+VY8ixX3ABn7jMbVon0tXsRBxZOMtbrzjZUEDf/lWyemM2gSpAuBFjY0RDpOpD
         JiUHnNoQq6ehdWaUeVED710t5R8RrqvWzt+X1bKb/2GMlMpANt3SVLuk+iIP2bqwPhEH
         0G31fz0XnhFfhraok3nNNwsLwlF6Z2zSa2l/8Xi1qTPvj2yUcfxSNaXDRFXYUjj2zSeo
         A+I6wl/fU50H0J4yQf9J52wdjBg81+dlgR5qUU+h/RQOEXf8w3FUAqPvOHZiO7CJjsHf
         FjyA==
X-Forwarded-Encrypted: i=1; AJvYcCW7lY1wDUZ3qB/4jMUx1ga6cnpKb3DXr+3ba6n4d6SD4blY3sBJgwpH/Of5zKI4eoxZV9cRRbqW85nRNRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMo+2R1PB16C4bcMkLI4Z/6ZUvU5po5ipNI+qz78zaaJcTQGv
	AHWoEn5upQceUvN0TWlQK8lWn/aiQmn1rZYBJaSF9oVjfKC765hJ1zd4tJRhMD4=
X-Google-Smtp-Source: AGHT+IFls9iGZXGyJCiypj7+d7zjqdkshGbDYjgLwUigjg5rgeZoI/B15GuHn3ZI4bijJ7RMy5NGjA==
X-Received: by 2002:a17:907:7256:b0:a7a:a30b:7b93 with SMTP id a640c23a62f3a-a897f77eed8mr1114693066b.2.1725262211571;
        Mon, 02 Sep 2024 00:30:11 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6dc3sm516163766b.156.2024.09.02.00.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:30:11 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: naresh.solanki@9elements.com,
	andy.shevchenko@gmail.com,
	broonie@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: pinctrl-cy8c95x0: Fix regcache
Date: Mon,  2 Sep 2024 09:28:58 +0200
Message-ID: <20240902072859.583490-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the mux stride was of by one, which could result in
invalid pin configuration on the device side or invalid state
readings on the software side.

While on it also update the code and:
- Increase the mux stride size to 16
- Align the virtual muxed regmap range to 16
- Start the regmap window at the selector
- Mark reserved registers as not-readable

Fixes: 8670de9fae49 ("pinctrl: cy8c95x0: Use regmap ranges")
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 9a92707d2525..21e9e7b264c8 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -62,11 +62,11 @@
 #define MAX_BANK		8
 #define BANK_SZ			8
 #define MAX_LINE		(MAX_BANK * BANK_SZ)
-#define MUXED_STRIDE		(CY8C95X0_DRV_HIZ - CY8C95X0_INTMASK)
+#define MUXED_STRIDE		16
 #define CY8C95X0_GPIO_MASK	GENMASK(7, 0)
-#define CY8C95X0_VIRTUAL	(CY8C95X0_COMMAND + 1)
+#define CY8C95X0_VIRTUAL	0x40
 #define CY8C95X0_MUX_REGMAP_TO_OFFSET(x, p) \
-	(CY8C95X0_VIRTUAL + (x) - CY8C95X0_INTMASK + (p) * MUXED_STRIDE)
+	(CY8C95X0_VIRTUAL + (x) - CY8C95X0_PORTSEL + (p) * MUXED_STRIDE)
 
 static const struct i2c_device_id cy8c95x0_id[] = {
 	{ "cy8c9520", 20, },
@@ -329,7 +329,7 @@ static int cypress_get_pin_mask(struct cy8c95x0_pinctrl *chip, unsigned int pin)
 
 static bool cy8c95x0_readable_register(struct device *dev, unsigned int reg)
 {
-	if (reg >= CY8C95X0_VIRTUAL)
+	if (reg >= CY8C95X0_VIRTUAL && (reg % MUXED_STRIDE) < 12)
 		return true;
 
 	switch (reg) {
@@ -444,7 +444,7 @@ static const struct regmap_range_cfg cy8c95x0_ranges[] = {
 		.selector_reg = CY8C95X0_PORTSEL,
 		.selector_mask = 0x07,
 		.selector_shift = 0x0,
-		.window_start = CY8C95X0_INTMASK,
+		.window_start = CY8C95X0_PORTSEL,
 		.window_len = MUXED_STRIDE,
 	}
 };
-- 
2.45.2


