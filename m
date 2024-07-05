Return-Path: <linux-kernel+bounces-242816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49914928D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3D81F21EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AE13DB88;
	Fri,  5 Jul 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYq5yMIj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B614224F2;
	Fri,  5 Jul 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720204055; cv=none; b=PvYWzxkrHk4ILEQhWo6PXUDCGUamWrg/s0b8NTSwzgi6dpaZU05gR1XEAXeCSQPlahSSyzMr5ZbRTVPy2xn2xqFBM9CQQ9yactzg60ge3KGiA5gpw6Yrx85cx0SinqBa5UuyUvOZTmH98QdX492+dAvXEQEsFyfkMF7hokRLWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720204055; c=relaxed/simple;
	bh=3CKUzJWdEdDG484sR92q8TI7bVIXY1L5RBfx/b2yB/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XMNqIWkq7U8ZBBDruM3Wr8HOZZHA0aZbiX6LuFbTah+SF6zSVLt0OX0xDvqnw+isHv1wVGGzEUowdtAawAUPHk1EAYUBcCPtgVyU+yXRIz/uSb6dAxbfkd7s4fYnq2E8WfhIjlWz7dj3UucaBfWMv9TmmLh1TB1dmMnnKGiBsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYq5yMIj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4256788e13bso12919115e9.2;
        Fri, 05 Jul 2024 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720204052; x=1720808852; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nh4IMQ6aMf8qqnXQqtk5t+twjcO4FX7On9IGuSSAOg=;
        b=cYq5yMIjZ8mWTGInI0ZzROlz7Jn5k0zqMyowWQrtjJ94k0DJTtMudtIJOGnD9xTtin
         gHMf8ija0dxFfJ9Kf4KIULZfs6ZZO2B7gg1ZJKLphF2j+4RaNraLTe+YW0JuW5V3/aV3
         f1Ob5IJ3zyu1NzFZGCyWgZYSVYoZhj2QY0RUyKUG2mXNE+YkaQ/9TDtQfthi6BTvB1Nl
         N/VWATOTY8g2VMOaOVkjoFedTRuQrMSXFhlkOVkKKSOAL3acEj9Y/C/AWUYcpX3DyuMU
         LYCsz0TJQUGd5dUZasWisUwSKCKd9Mvorrv8b4EX8dsQ7ZLjt8JEiXbHnbWUNXFw+uAT
         gokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720204052; x=1720808852;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Nh4IMQ6aMf8qqnXQqtk5t+twjcO4FX7On9IGuSSAOg=;
        b=BzNdDbrWNmB264NLo/u6X0ibeDMsaRipm9Dwn4nqo2xboAZlumJ4OPuKYP2cP4X/UB
         +nbRFECD67MFGbk8c9hdNpY4EaZ1dlOu31WS8GMGb71rMLUcLBalUWwpLTVZKxhiqB8r
         slwKwbNgM2CDufAnmWDSbcbXNSiSeT7QTaRGoTQ8OhkQ+p8a7cZOUmQYATLS002QlB2e
         6qQtrFDXOO+aAKjQekH0MK1J31UviOH4AHo8zxmvDlMmzzEHkWn07GYV2ct7wzA0y1fl
         dOfVBoLNqrBogaPSlDyaz6invmQdl6d4s0g3KlyCYR/ta3rs0SFb4bvEq1RWKRwiPVH8
         h2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnFw5lBkeUNauKUajxL19CwjBET5bhJZpbj6poGdazZqbYSD/WMg4HLlSq5wzEGvr+4tTAm5MWQEgQbwDAT9SfCykJT8DOmJ06jdhv
X-Gm-Message-State: AOJu0Ywj+refz9koc0JDGDyuAtb0oouHPFZDFPHmF0Z3KGCw3vIc7gPP
	/Gi8OdrIu0zE9LND15GOHJCBNxMDykf9nkOnkU4rZQzqaaNgSoT6cBGEN8lc
X-Google-Smtp-Source: AGHT+IFjGnRKr8+rJVJupa3E4KyVyJghp/1UMCw8OjEsQrZgrRqh/kcSldLTMQaK2MCEwsKLBC+JHg==
X-Received: by 2002:a5d:4f06:0:b0:367:326b:f257 with SMTP id ffacd0b85a97d-3679dd5459bmr3994466f8f.33.1720204051943;
        Fri, 05 Jul 2024 11:27:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-4adb-3312-ca75-bf55.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4adb:3312:ca75:bf55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d00sm21606055f8f.99.2024.07.05.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 11:27:30 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 05 Jul 2024 20:27:28 +0200
Subject: [PATCH] hwmon: (gsc-hwmon) constify read-only struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-hwmon-const-regmap-v1-1-7cde543ba818@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA87iGYC/x3MTQqAIBBA4avErBvQ6Ae6SrQwHXUWaWhUIN09a
 fkt3iuQKTFlmJsCiS7OHEOFbBvQXgVHyKYaOtH1YhID+nuPAXUM+cREblcHKmnJSmE3Mw5QwyO
 R5eefLuv7fsclirBkAAAA
To: Tim Harvey <tharvey@gateworks.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720204050; l=1032;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=3CKUzJWdEdDG484sR92q8TI7bVIXY1L5RBfx/b2yB/c=;
 b=ncwd+dZQFblPN5HIfl6JjHy3N4DYGB7QB775/atanC1bMMMqmaz5MoTAnhqQ5lhJM7xdwx8eX
 sS8vPQNMnQTCjCx78Eo/ZAyLBbtv8b1R7F7jwXAgMx+RojyiiDV/7mx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`gsc_hwmon_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
I missed this one when converting regmap_config to const. After this
conversion, all read-only regmap_* structs in hwmon are declared as
const.
---
 drivers/hwmon/gsc-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index 0f2147699c91..cb2f01dc4326 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -39,7 +39,7 @@ struct gsc_hwmon_data {
 	struct hwmon_chip_info chip;
 };
 
-static struct regmap_bus gsc_hwmon_regmap_bus = {
+static const struct regmap_bus gsc_hwmon_regmap_bus = {
 	.reg_read = gsc_read,
 	.reg_write = gsc_write,
 };

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240705-hwmon-const-regmap-a1fef10fbd65

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


