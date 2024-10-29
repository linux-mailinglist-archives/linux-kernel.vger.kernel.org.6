Return-Path: <linux-kernel+bounces-386628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFF9B460F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10FAB21ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8E2040A2;
	Tue, 29 Oct 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QuqLiBct"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832CB204085
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195661; cv=none; b=lhZgCXGEZ6CGmzX6zCcbEzaIxFvwhLPwg1LD3eK6EN21AciFxc2E//ineZSli32BaeWK9RSZSvTgeEkLOTN5GAPq+d5d40Am781EuTjPYTyc4UAAJGcLZPyc3UxkNBsp/7DYM/wT+sSSoICKOzp2MJeBegRA/5Dml1o05Kq+qro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195661; c=relaxed/simple;
	bh=4TzmmDoPs2T7BWH4lmLx2iMOLyLLeDpoERxRmNcYf8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTQ9h7nzbeoIUDdYQPfCzfbh64K5JY8pNv6c9rOhznuJlMtZepm6KO0KDDtzCScdG7gwLJewq9MAI1vXeZMq7B9ZOU+ZbYn4cMfEStqgfawBST4Lmy/mHw/Ah/W8lNDRs1I+8dhtFxwF+4eCOVaRoZJYhWgvKQjNhTzdTgHSebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QuqLiBct; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdb889222so49428945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730195658; x=1730800458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRN2Q2s1tXUlBpPwz2Gezq5YzOvyUe388g/hG6wINCo=;
        b=QuqLiBctMHMsnJHFnH7I5KnJLWmAziIXXemINuSHsOsmM+DpYiqtuiv4DVdxAuBMOn
         GGlcwbDTRnswiUJOlBXkEm6BxonSGCvW1vWj5lKXARB6SLV7Dkyzcowpmi0XOHEyXoV4
         QMFRwcZiABsJIoWueKcdJ/9Hndnv54tUD/rtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730195658; x=1730800458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRN2Q2s1tXUlBpPwz2Gezq5YzOvyUe388g/hG6wINCo=;
        b=JMk7iOwKDLfiAFkdh0Q/FWk5TywByFDygbkHiaArcJYDqhhYms5Euhjo7oUqC7qhBa
         yqzKQtWuP7pn9sXQsENCyUWguS24eRp+WBCWhlHVtzdZpV/vaBA7D73gve0TZPFdDpdq
         N0qoc1+NR2vt/GLKwSjGnIIoDJv4kvelHOUIo0mW4FC/W6eOWve5oAJPOqjNSDrdhgaq
         YIpy+JPl7BGEHJI4C3SFRu5Gtn3Y5lz1aAbUBlFfb3WTZoWmS1aZg42iZt/m3Q3x0isd
         nHOXbwgydtSRS1a/CJYk6637vKbuCoLlIvN3IiV0/JiNmFV3BAhDWTrJ9xdy8XbI0XXf
         Xqxw==
X-Forwarded-Encrypted: i=1; AJvYcCXxOcGIh/CPW3S7ki8+HoKCKCDfY14ZJnIK5i0OpxTuHwL+5SfGy6tnTDZdloFkedDjhBdzpJq3yetlokg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ak681R95kv1qf7c3AJV8c3iPVXXc/rwz5uXypOsxHij9sFbZ
	NLDY/x0tFSXMNHCmQ49MDbOiETDF7soCLG48SFxx+H3RPp7Kpb45f8JlptTKvg==
X-Google-Smtp-Source: AGHT+IGJKLBeHml2mgw0fqam5oO7OYmdphXyqZ72BkhYs4KBfI3AcNJBCtRzWfdnOR4KM6obA5v1sA==
X-Received: by 2002:a17:903:2289:b0:20b:7ec0:ee21 with SMTP id d9443c01a7336-210c68cf5a9mr165968125ad.19.1730195657831;
        Tue, 29 Oct 2024 02:54:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1fef:f494:7cba:476])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02efb1sm62901235ad.221.2024.10.29.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:54:17 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: it6505: Fix inverted reset polarity
Date: Tue, 29 Oct 2024 17:54:10 +0800
Message-ID: <20241029095411.657616-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IT6505 bridge chip has a active low reset line. Since it is a
"reset" and not an "enable" line, the GPIO should be asserted to
put it in reset and deasserted to bring it out of reset during
the power on sequence.

The polarity was inverted when the driver was first introduced, likely
because the device family that was targeted had an inverting level
shifter on the reset line.

The MT8186 Corsola devices already have the IT6505 in their device tree,
but the whole display pipeline is actually disabled and won't be enabled
until some remaining issues are sorted out. The other known user is
the MT8183 Kukui / Jacuzzi family; their device trees currently do not
have the IT6505 included.

Fix the polarity in the driver while there are no actual users.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 7502a5f81557..df7ecdf0f422 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2618,9 +2618,9 @@ static int it6505_poweron(struct it6505 *it6505)
 	/* time interval between OVDD and SYSRSTN at least be 10ms */
 	if (pdata->gpiod_reset) {
 		usleep_range(10000, 20000);
-		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
-		usleep_range(1000, 2000);
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
+		usleep_range(1000, 2000);
+		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 		usleep_range(25000, 35000);
 	}
 
@@ -2651,7 +2651,7 @@ static int it6505_poweroff(struct it6505 *it6505)
 	disable_irq_nosync(it6505->irq);
 
 	if (pdata->gpiod_reset)
-		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
+		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
 
 	if (pdata->pwr18) {
 		err = regulator_disable(pdata->pwr18);
@@ -3205,7 +3205,7 @@ static int it6505_init_pdata(struct it6505 *it6505)
 		return PTR_ERR(pdata->ovdd);
 	}
 
-	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(pdata->gpiod_reset)) {
 		dev_err(dev, "gpiod_reset gpio not found");
 		return PTR_ERR(pdata->gpiod_reset);
-- 
2.47.0.163.g1226f6d8fa-goog


