Return-Path: <linux-kernel+bounces-237044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58D91EA3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C982E28248B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358A1741EB;
	Mon,  1 Jul 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1l6XQ23"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599217335E;
	Mon,  1 Jul 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869044; cv=none; b=MIlQsVANB+kz54C1FZZ/kgebjsDfKQvJ7y4N2tCvbVL1WMlb5vj+//IMqdlMPdNs8lGNn3QE/owOcty0qADEuZnGC9pNL8TZ/oQh5DbNI0nETODgWnUgePLo/T9ImLq5AGHdBgwFNEbizZC5fHCUh2bNHxExHttOII87ZuwZJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869044; c=relaxed/simple;
	bh=hNu8n8FRkycAzwLJxL9+KeyRfii/UWJCZK0Eps9I9TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQkZiiQvacCw4uQDvahnEg4lVGqQRIn4ulq3e0Auk3xGaelzjohFnmk+3vK5/aQJ579j42Fydp51Gxj2VcOxOvGYvL9qtS2E3AR14CL2ZOZt+aiK4Qii+kKNsPxKRvxW9WIUKQJGRlCfUXf/qY4yg9zpghMp/8ebqXtRmxhuDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1l6XQ23; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7065e2fe7d9so2701518b3a.3;
        Mon, 01 Jul 2024 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869042; x=1720473842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rmn+YmqKMxbvYebriTViJTZY4oGoFXAx7v/gdLiYFoI=;
        b=j1l6XQ236o2fLjY6kaMQWhgFhDaHAlhbeR+/Kc5TqbklGEgO4G6taW/pRTR66OaBkA
         tWl67UUNAypTsFYB4AEhOSiTgb8eL244Ph+BZaZvxpFoR+HK3M+D8gCCGI7z5hJl8T59
         /ikVfK0ZPSzi2iwYharkNlNktANb3SjGnxzncSuNatmHn41mUizeSMVVg2V+5tAf6r8c
         EcQP9KgTPwzKpECQa+i8u+1x8Qk5P85iL3DiAE0aUlK00d5igVItWAP2K149EE6taW2x
         zJKImQoeUNrXLGDASkNscZ4I00QLy/lD1elp7frYmmb526aZmQ4lUWJ5B+fFOsMEJd8R
         7ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869042; x=1720473842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rmn+YmqKMxbvYebriTViJTZY4oGoFXAx7v/gdLiYFoI=;
        b=SwdykxRRIzTQr7+nzP5e2q/zsWKG42CXQI/+4djp3keP1T+GxoM94/PFJk9YCZMd2/
         SKs9V84PWJluByBh4Cxoxml9GMd2wX/AkHN52Ap9NYHirl8mvML0QTiWZP5VAom2gHm2
         kWPkr9/CSL7Fa+Kf44pOh+MUdT7w2iE/aECBJhE+sMdY4CzqkAfQmbmfIRYGFl6IEIgP
         0LYiSQ1BozVKjgRJQ7OZac6/73V8yiYvUEUvM3GUZ50nPfUIcUq9oQ9LrNMlIGP6qUW+
         UgJcz/5GpupN8eENROlAj4q1AexKdGGwIGf8Mj8f+/A0d33CjDnbAlsWn7e17HEIY/R4
         Idfw==
X-Gm-Message-State: AOJu0YxhbZVwZ0FH5K6KrrNpB/c0w7bQruc4llyBgpSxKtlXjbsAGb0C
	yAdid1+xxb/OebanMAP6rux0xevFqMTNwVk2wrPPp1717sVSUitA7NN3zQ==
X-Google-Smtp-Source: AGHT+IErh4E/qAyUmiDcqrQSqrJr+CPWae2d6mGIuhOKxxYqw4Nm8I+IhyBzbgRugxz5kLIBUwqD4A==
X-Received: by 2002:a05:6a20:3d83:b0:1be:c0c9:d014 with SMTP id adf61e73a8af0-1bef6109df7mr12242726637.19.1719869042005;
        Mon, 01 Jul 2024 14:24:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568ea7sm69748735ad.186.2024.07.01.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:24:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 07/11] hwmon: (amc2821) Use BIT() and GENMASK()
Date: Mon,  1 Jul 2024 14:23:44 -0700
Message-Id: <20240701212348.1670617-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701212348.1670617-1-linux@roeck-us.net>
References: <20240701212348.1670617-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BIT() and GENMASK() for bit and mask definitions
to help distinguish bit and mask definitions from other
defines and to make the code easier to read.

No functional change intended.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fix definition of AMC6821_CONF1_FDRC1 in this patch

 drivers/hwmon/amc6821.c | 71 +++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 23111c6cb142..fa9f64c743ff 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -68,46 +69,46 @@ enum chips { amc6821 };
 #define AMC6821_REG_TACH_SETTINGL	0x1e
 #define AMC6821_REG_TACH_SETTINGH	0x1f
 
-#define AMC6821_CONF1_START		0x01
-#define AMC6821_CONF1_FAN_INT_EN	0x02
-#define AMC6821_CONF1_FANIE		0x04
-#define AMC6821_CONF1_PWMINV		0x08
-#define AMC6821_CONF1_FAN_FAULT_EN	0x10
-#define AMC6821_CONF1_FDRC0		0x20
-#define AMC6821_CONF1_FDRC1		0x40
-#define AMC6821_CONF1_THERMOVIE		0x80
+#define AMC6821_CONF1_START		BIT(0)
+#define AMC6821_CONF1_FAN_INT_EN	BIT(1)
+#define AMC6821_CONF1_FANIE		BIT(2)
+#define AMC6821_CONF1_PWMINV		BIT(3)
+#define AMC6821_CONF1_FAN_FAULT_EN	BIT(4)
+#define AMC6821_CONF1_FDRC0		BIT(5)
+#define AMC6821_CONF1_FDRC1		BIT(6)
+#define AMC6821_CONF1_THERMOVIE		BIT(7)
 
-#define AMC6821_CONF2_PWM_EN		0x01
-#define AMC6821_CONF2_TACH_MODE		0x02
-#define AMC6821_CONF2_TACH_EN		0x04
-#define AMC6821_CONF2_RTFIE		0x08
-#define AMC6821_CONF2_LTOIE		0x10
-#define AMC6821_CONF2_RTOIE		0x20
-#define AMC6821_CONF2_PSVIE		0x40
-#define AMC6821_CONF2_RST		0x80
+#define AMC6821_CONF2_PWM_EN		BIT(0)
+#define AMC6821_CONF2_TACH_MODE		BIT(1)
+#define AMC6821_CONF2_TACH_EN		BIT(2)
+#define AMC6821_CONF2_RTFIE		BIT(3)
+#define AMC6821_CONF2_LTOIE		BIT(4)
+#define AMC6821_CONF2_RTOIE		BIT(5)
+#define AMC6821_CONF2_PSVIE		BIT(6)
+#define AMC6821_CONF2_RST		BIT(7)
 
-#define AMC6821_CONF3_THERM_FAN_EN	0x80
-#define AMC6821_CONF3_REV_MASK		0x0F
+#define AMC6821_CONF3_THERM_FAN_EN	BIT(7)
+#define AMC6821_CONF3_REV_MASK		GENMASK(3, 0)
 
-#define AMC6821_CONF4_OVREN		0x10
-#define AMC6821_CONF4_TACH_FAST		0x20
-#define AMC6821_CONF4_PSPR		0x40
-#define AMC6821_CONF4_MODE		0x80
+#define AMC6821_CONF4_OVREN		BIT(4)
+#define AMC6821_CONF4_TACH_FAST		BIT(5)
+#define AMC6821_CONF4_PSPR		BIT(6)
+#define AMC6821_CONF4_MODE		BIT(7)
 
-#define AMC6821_STAT1_RPM_ALARM		0x01
-#define AMC6821_STAT1_FANS		0x02
-#define AMC6821_STAT1_RTH		0x04
-#define AMC6821_STAT1_RTL		0x08
-#define AMC6821_STAT1_R_THERM		0x10
-#define AMC6821_STAT1_RTF		0x20
-#define AMC6821_STAT1_LTH		0x40
-#define AMC6821_STAT1_LTL		0x80
+#define AMC6821_STAT1_RPM_ALARM		BIT(0)
+#define AMC6821_STAT1_FANS		BIT(1)
+#define AMC6821_STAT1_RTH		BIT(2)
+#define AMC6821_STAT1_RTL		BIT(3)
+#define AMC6821_STAT1_R_THERM		BIT(4)
+#define AMC6821_STAT1_RTF		BIT(5)
+#define AMC6821_STAT1_LTH		BIT(6)
+#define AMC6821_STAT1_LTL		BIT(7)
 
-#define AMC6821_STAT2_RTC		0x08
-#define AMC6821_STAT2_LTC		0x10
-#define AMC6821_STAT2_LPSV		0x20
-#define AMC6821_STAT2_L_THERM		0x40
-#define AMC6821_STAT2_THERM_IN		0x80
+#define AMC6821_STAT2_RTC		BIT(3)
+#define AMC6821_STAT2_LTC		BIT(4)
+#define AMC6821_STAT2_LPSV		BIT(5)
+#define AMC6821_STAT2_L_THERM		BIT(6)
+#define AMC6821_STAT2_THERM_IN		BIT(7)
 
 enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
 	IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
-- 
2.39.2


