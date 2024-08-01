Return-Path: <linux-kernel+bounces-271515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530F944F48
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862071C25012
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D71B3F05;
	Thu,  1 Aug 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbvmP2Wy"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9D1B3754
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526253; cv=none; b=Kwx/39eUR96cvwz8hXnxDp+8hg7UU4AmUJ6Zko9mAveh38/wbUGxmnoDlK7GuS4DrllW40b7rJSzKOSOAIKhdjDeMW4DuGi06pILZ89YM8/D+ncb35E0f1ykSWqItlcgYuWTPMae7KSoaNW7UzvQeD5slHgn9Dfni88H9SRwgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526253; c=relaxed/simple;
	bh=WJMyfi+YtPpFX2Z/GWAKLDIPN8HFev3IEbR1ndhrQYY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VLmzpphBA7/YI3WTBud+TmiUzviEF5rmNtZF5g/c/FPIuxhwDSw0T7RU5+UUp5T3xEX2+zIAI5hOX/Gb+6/9DyImZkMCRFjFeww9jKZwAbv7i1b6vYtd/uPvJBG7HxI4e1FzfHwkJUtIWe/8qotyGY8BMK6rSbMUGWXtQYDLdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbvmP2Wy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so9828804276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722526251; x=1723131051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m3JNCEaF8nqgI7TKTXE+tQok4Us7yA+D2oACsQAYZWM=;
        b=WbvmP2Wy0kkOExaIZsnQqHGwXni+RpqwYMhH4TGPoSnCEKebBBrH/fWnr49yoCY1e6
         N+TRX9PG4OjnStCYrISpTAMx3zG0vTWTT0q6KZlo+zGnauXO2xF9MTa0u7N36iNVVsUT
         kD/9fxhg/4wqmhlyHoj7BAUskJ/365vkn1toKPtkm1ejoivE6HVmFVc6aOfqsGDTMppJ
         K6qxOMCjfbvYHFdYOJ2paQjAHbFwwxiIbe2T93VMmPfmQqlbngMGFWWTUg6e2MyDgQPc
         9lpBlh5SG0RLYTBBZWRxlR8po3gLoroEtyo+XjeA5cF/VFRZG2vyLMAhZ4ZgQv1rlCO1
         Lmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526251; x=1723131051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3JNCEaF8nqgI7TKTXE+tQok4Us7yA+D2oACsQAYZWM=;
        b=oITIOgtsK7I0+QKWx5NbFgWCgmspWfIXB9qCBTfbLcaDcgG5I05GH9OCAVgE+8984j
         /ypR+XtfyR5KeorB402uio43GJ0wZjFczjkaq6lN+KfD4ya1Co61EoJGQmwOgZHwcO/w
         mYW55TIXjR3YHu57TNmA30BBdfPYOsapEwNLLgVo73UjGz+/Z+KnT8l2JJPsva7BMlt8
         r2hWQF/3A9u71iRYgzIwTRcy5VlJV1kskvWV3Xb518mXDLZ2cSBN7Qkyy6Te9wAYGgPT
         Llld9tSFT3Re16tHMOKsXZod2SJLbNS/KYbwBs6PgpI66FhBb7km1QATc2ZNfQ3WDIfm
         xi6A==
X-Forwarded-Encrypted: i=1; AJvYcCWqreCXQVkL1HtFYerQOhnlR7O/u5oFYGTazswExQDn60MT03Yy8M+egh+Ga0bZad3HKAlg2E0TP6Sk9iaJbktw8xqg0A1vlI2ZToh7
X-Gm-Message-State: AOJu0Yzjf0gg4OK1KU7ghDhCypf4UH2Tipn9Srl8TY4JmMk9nS509KSo
	EzjVTzwEWpIe2bv5Cnun1xG+u8l2vt3wqn47R14ZKLx4BOitt0Kwzwv7OcEyeyNvsg+qrILNSQm
	R5ppcpkqkV6DeCaSHoA==
X-Google-Smtp-Source: AGHT+IE7QiiDa/cXG7VrZ1aFpIxnOdTQpanLrSGZoNXaUwHG7EzUTcNKpR3S0Z4D+PKmWtvCfnovonDeLvtvbTRe
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a05:6902:e0e:b0:e0b:d5c7:1abf with SMTP
 id 3f1490d57ef6-e0bde45e24fmr426276.12.1722526250874; Thu, 01 Aug 2024
 08:30:50 -0700 (PDT)
Date: Thu,  1 Aug 2024 11:30:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801153048.3813581-1-zenghuchen@google.com>
Subject: [PATCH v2] leds: lm3601x: Reset led controller during init
From: Jack Chen <zenghuchen@google.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jack Chen <zenghuchen@google.com>, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LED controller should be reset during initialization to avoid abnormal
behaviors. For example, when power to SoC is recycled but power to LED
controller is not, LED controller should not presume to be in original
state.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/leds/flash/leds-lm3601x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-lm3601x.c
index 7e93c447fec5..148e48624cd9 100644
--- a/drivers/leds/flash/leds-lm3601x.c
+++ b/drivers/leds/flash/leds-lm3601x.c
@@ -434,6 +434,10 @@ static int lm3601x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = regmap_write(led->regmap, LM3601X_DEV_ID_REG, LM3601X_SW_RESET);
+	if (ret)
+		dev_warn(&client->dev, "Failed to reset the LED controller\n");
+
 	mutex_init(&led->lock);
 
 	return lm3601x_register_leds(led, fwnode);
-- 
2.46.0.rc1.232.g9752f9e123-goog


