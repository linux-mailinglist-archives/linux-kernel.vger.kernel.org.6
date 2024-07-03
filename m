Return-Path: <linux-kernel+bounces-239047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD8E925567
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCF02850FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6496613A3F7;
	Wed,  3 Jul 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9GnfByM"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160601386DF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995497; cv=none; b=DwS0l6oUTnbt3wrRC3yymxTGFeuRMvgl+LFxl7+cx4FeMIjy/6j85sc+bMIXbuARW2ssCLOSthB7Ic2WnrTd5UIe60gAYmPt/kH5GUc8sdbVuOoQy5z3aMMpb+cbFG5Mewml8LnbhYo9gGOb7CeDmTXQ9Hq/rGg8DeV2Cg1C2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995497; c=relaxed/simple;
	bh=BlydWvEq+lJU50RG7ZzWFAhX9TQHOsK3+vDE1ICGSPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXmAOM8/D25i4ORe28tQwiWeNNIMdtO+khafQ4Oov8+Y0VMQKPcfFHKiM6A1z/tvUM7YwfBWqk7fZ5T4Nob+aCfAu/glzknfozRP0ijChnMqZVfdg19/HlatgSMq25YYcRguHU+RUVewzSb/Yx3QbMrWVhLdk5vJ+QrWTOIcAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9GnfByM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42573d3f7e4so34077785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719995494; x=1720600294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6teWzjrPNMwyuUfB/rea1p/V9QpvkiuOZXrjhGxSXpQ=;
        b=C9GnfByMAwJKHxiq6oFnAWIVtvAanOmlWP2z1RZky6vQREXLXGlf6RGRklI4OQJroj
         Aunx+dIoRnVx5vMn/f3N9jhPQPjfvLQqzHcsmOJXplG84HChhCNCk77iA2J7hGFK/IzQ
         lsGHPxjyf7nykPgOyhpFpsT7ch4djvthQWVtbGAvoJ8ugwTtzow/lWPv8wgjEPRv9HeX
         RJeaDb1okwVS4s5QBBqGz44ov6GMQd43wtwTY9Eom+oDUDl1sREj97THdlgJzkDwOl6p
         3bmxxsDT6rg5qHKRILXojS175MTB/pq3uG5i71D3plweiiwMEj+iMPVFhkXsUyd9w+lB
         1Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995494; x=1720600294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6teWzjrPNMwyuUfB/rea1p/V9QpvkiuOZXrjhGxSXpQ=;
        b=dnJWYMCpT42eVIoVeapL8jBH4ZWvk8U4tE/CSdHgHXZ6jbVVuVk8ZaMQGW/Xn5Y3nU
         fx5cGKx7PvBTUw3OW9gXBPVexjwuZRZS12RtBKQvry2lADbH2vPTsaVY2yHHxhmVkNJs
         +cL2xCx/jemL4PnjiO6n0pHgQh7E8LGz/umoNr/bIZuMePjWg8roDfhkvOqm2A5W3OGb
         mePLtsYxhqcO1ipx567tLG+HDKzWY0yhdFhkh/TObpxnEVNJ+yjSOxMWfFovxLXRfhKC
         s1ZmBEN3FnZmQtK5j6sSv2UAbvhQ4JpUwWXd10mVkUI7K2KAYuJfWpAGEdk8fYTRb62R
         CeIw==
X-Forwarded-Encrypted: i=1; AJvYcCXqyEf5/CuJCcabhFOtD6JYj2nanvW7zpNdb/hvciOz+PHloGeUZnEV90Ej5iViQldgHpRc01YfMEp3TV0wscNyjfdV0dRbJfIfdO96
X-Gm-Message-State: AOJu0Yx2W7WAt/o8HZHdg9LWFeTbgA9cB23zdj9WMT/GK0vexhpTG1Zc
	JsX3EnJKrq+P414fSyuO8ycZbPHKeJPOz9QMNWot4gOjsy/8OAo9d1x006EgS2Q=
X-Google-Smtp-Source: AGHT+IE+U8mZtsBhfAXNgT4J9m0ilBbDh9pFD6F//fwXE1kVllDLT8bYH0ANRMJt41mdgBM0UxKcFg==
X-Received: by 2002:a05:600c:5486:b0:424:a779:b5bf with SMTP id 5b1f17b1804b1-4257a03a561mr76732165e9.20.1719995494607;
        Wed, 03 Jul 2024 01:31:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258036d034sm126760385e9.43.2024.07.03.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:31:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] hwmon: (dell-smm) Simplify with cleanup.h
Date: Wed,  3 Jul 2024 10:31:29 +0200
Message-ID: <20240703083129.95955-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate memory, which is being freed at end of the scope, to make the
code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/dell-smm-hwmon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 0362a13f6525..e72e26db6e10 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/capability.h>
+#include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
@@ -1095,9 +1096,9 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
 	struct thermal_cooling_device *cdev;
 	struct dell_smm_cooling_data *cdata;
 	int ret = 0;
-	char *name;
 
-	name = kasprintf(GFP_KERNEL, "dell-smm-fan%u", fan_num + 1);
+	char *name __free(kfree) = kasprintf(GFP_KERNEL, "dell-smm-fan%u",
+					     fan_num + 1);
 	if (!name)
 		return -ENOMEM;
 
@@ -1115,8 +1116,6 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
 		ret = -ENOMEM;
 	}
 
-	kfree(name);
-
 	return ret;
 }
 
-- 
2.43.0


