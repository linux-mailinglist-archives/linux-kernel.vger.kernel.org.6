Return-Path: <linux-kernel+bounces-281021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0294D1F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23B71C216EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A870197A6E;
	Fri,  9 Aug 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JsvI8Y55"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A1197A62
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212968; cv=none; b=sBxBIS30y2z+LbrbVFMal3ssvFmEODkthyPZy9QtOUAmmVj7TH7jQPTQntyz0iLvfKGT7oih3YwqTakF2NBlt8bIfBkMjxZMN26MFBvgClOk9jj/Ofdc53D6VdWSVIRfVkV3Ucb89IsDwpXxjAeS/ZYXi/f/PvIYalnIU3Il22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212968; c=relaxed/simple;
	bh=i+8btDDh4eAP9SWK/QrveYXoOZhr9JkOlwFDq6hZ13U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eA5x+dqO+PdgIS6fDQUNTT6Wv5y5yK8NrxBhREllhnP5pBkBczn3NXo2OLDoVCYwNna5a9fLWHmsMP/yv0/wX923Y1pNJWYyw5mDbciR4FdSbQkaV2Dc0y/CES11JbIU4pO0s9mW82eHTIzq1w+NPG6Io25m+vdoQMUEiKue+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JsvI8Y55; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so26553891fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723212963; x=1723817763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jw4ZuLFuVy5A0IKctkeTjrnq6fclS4FD7LJSylrulPM=;
        b=JsvI8Y55uxyDWBVnlzmj70P18OKqgLdDAdMHugOOVTP8aOkTV2Wl2Feh7vjvX7Uwax
         8tE2ZK8W+MWf4uC1ZO891jWmeLPO/F8m5tCIZS1xK3SA9DQv7O3pO2F5Dy+z39hMxliQ
         u6YvrpBprK9n25Ut2RQoc5gKDu1TfQd70ujGrgFw+iF6t2PqtzB8jOg/ADCyall9P9kS
         m4Ge3/JFMrzfCdBv7n0uutBnoG14MXXk3T0NgZtIKzHQ++VXJDK8EYP0xjOeqKozP+5K
         NSdIKXFi2Hqc0kourbv1zqtDJmnQkkJLeqH5uLBYz8wOpwY0vGbgX5KOXsJxV/O7sqEy
         /jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212963; x=1723817763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw4ZuLFuVy5A0IKctkeTjrnq6fclS4FD7LJSylrulPM=;
        b=XSPZuEDTmCLz/EDygGDyA+K0HTNXQG53R+UvzWbS/+tO54GwT2RLw9jkHEhDcyr2jf
         96phAKGkkwzSzMYI5NlVui7i7yhUz78uK4OVSheVKERiMWhVxfzuCPWW57+nZIm5anHz
         Q49vuxedpDymkUxVi/iXo4OgAuQeJzX/bLmiOaOPm/cTpTDiglUi5NvzNSfmnTYYImdl
         aa5o43uvrLRiZQSGNvjgyg5923LLWRoz2qpi9elsUvWrpH/t52b9/wnpK50aJZngEPVL
         PAX7F3UfXZCo1qa++IbOM8wzFPlOdBTm7CiTLuulh7QTkUa46lBUD7QHXyZAbiW6XTMM
         1HzA==
X-Gm-Message-State: AOJu0YyA1NB3qWwDgXJAlY6kYHjzYca0aTRrSFKcS7zj4JkzGFQsuRju
	4J1sxc7sOqrmtVdvwvI+M69pM0rkdgN+JHlnMTux9KwviPcGpq54FnsEZ7mhudClAlfE1EuMs6H
	XRgU=
X-Google-Smtp-Source: AGHT+IGSWBqiDzqWNZ16J6q2xOQFHIW/0cm+Wng43GKPXHyaq5g5Ofcwe7rozGe3QCXi21w1t4YbuQ==
X-Received: by 2002:a2e:a581:0:b0:2ec:500c:b2e0 with SMTP id 38308e7fff4ca-2f1a6d1d1e9mr16504981fa.22.1723212962223;
        Fri, 09 Aug 2024 07:16:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8289:d6d0:e805:3543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e049sm130484035e9.23.2024.08.09.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:16:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 09 Aug 2024 16:15:54 +0200
Subject: [PATCH 1/3] memory: ti-aemif: remove platform data support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-ti-aemif-v1-1-27b1e5001390@linaro.org>
References: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
In-Reply-To: <20240809-ti-aemif-v1-0-27b1e5001390@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4154;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=cpSevJ2ayz1pxZPzQQW6QFuyfNJMjPqSMprWbgtPFNo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmtiSgMqu6sE1r9IF+kEXBQ4R9OlsWgdltF2P41
 j5m/rhZLXWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZrYkoAAKCRARpy6gFHHX
 cqWpD/4oV1G8yMje0xaFGMm9dYihYXoH0q8ITVxJYLeGCNIG6x1FTXM8qEfb8ppmRV2gADAWz7L
 i+BQQvDmJRiL7hgoQ/JbC+GuCfdPROHGYWOJNyX9+63mQ3uaiXW0I13ai0vuQFo/LpLKs6+5an/
 QX7x1TSLXOlJJbgwfPg5M8Hth0Wzl9wK9N6gPNPWJ/5YzHOCsNwdgcsnuhTbfcUWgcjDwnOfXhF
 3NMq4D7tY2tpyMX890Z8rs+Tlq6CSRoVFyw47/7pRVC7PRb9AgFHIDnu13fnQLA8vgul1OzRs9I
 FvcT8ycbAt62KQthjFWZR1F/Vr4kiiROkZsg6cdnZn2CLAiQjfMo9i2xninBQUzITFvwyl7NLoF
 F7/7pgKdiNxaA5eg6ioWaU/CfctrccAD5rK4T/x3Bct9ZxqKVXOB7/TJRHZOgx/QPC1BQw7bp+E
 ah39POPT+RjKUwP37RNY3zy21YucEvksOns6Ojmv7z2HzPvlDkbe7CVkBGWVq0c1E4hU2RSlwc0
 QeT7LXIy0bytVVYtIkt3eddIAiRlWMdoy/3rWTjC0umnazsIM4kFFeuOXY4PxPwR7/uYYD/CAV9
 nob17tgJPGpBvbkYtlT1URxTGkBErOxIQjnlvokya0Pni2FtYQre4jO+14WSq15vDAO+Z8Uh2IW
 hEDgqh9hdlqQZTQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no longer any users of the ti-aemif driver that set up platform
data from board files. We can shrink the driver by removing support for
it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/memory/ti-aemif.c              | 25 +------------------
 include/linux/platform_data/ti-aemif.h | 45 ----------------------------------
 2 files changed, 1 insertion(+), 69 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index e192db9e0e4b..b92cab455cbb 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -17,7 +17,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/ti-aemif.h>
 
 #define TA_SHIFT	2
 #define RHOLD_SHIFT	4
@@ -332,16 +331,11 @@ static int aemif_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
 	struct aemif_device *aemif;
-	struct aemif_platform_data *pdata;
-	struct of_dev_auxdata *dev_lookup;
 
 	aemif = devm_kzalloc(dev, sizeof(*aemif), GFP_KERNEL);
 	if (!aemif)
 		return -ENOMEM;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	dev_lookup = pdata ? pdata->dev_lookup : NULL;
-
 	platform_set_drvdata(pdev, aemif);
 
 	aemif->clk = devm_clk_get(dev, NULL);
@@ -358,8 +352,6 @@ static int aemif_probe(struct platform_device *pdev)
 
 	if (np && of_device_is_compatible(np, "ti,da850-aemif"))
 		aemif->cs_offset = 2;
-	else if (pdata)
-		aemif->cs_offset = pdata->cs_offset;
 
 	aemif->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aemif->base)) {
@@ -381,11 +373,6 @@ static int aemif_probe(struct platform_device *pdev)
 				goto error;
 			}
 		}
-	} else if (pdata && pdata->num_abus_data > 0) {
-		for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
-			aemif->cs_data[i].cs = pdata->abus_data[i].cs;
-			aemif_get_hw_params(pdev, i);
-		}
 	}
 
 	for (i = 0; i < aemif->num_cs; i++) {
@@ -403,22 +390,12 @@ static int aemif_probe(struct platform_device *pdev)
 	 */
 	if (np) {
 		for_each_available_child_of_node(np, child_np) {
-			ret = of_platform_populate(child_np, NULL,
-						   dev_lookup, dev);
+			ret = of_platform_populate(child_np, NULL, NULL, dev);
 			if (ret < 0) {
 				of_node_put(child_np);
 				goto error;
 			}
 		}
-	} else if (pdata) {
-		for (i = 0; i < pdata->num_sub_devices; i++) {
-			pdata->sub_devices[i].dev.parent = dev;
-			ret = platform_device_register(&pdata->sub_devices[i]);
-			if (ret) {
-				dev_warn(dev, "Error register sub device %s\n",
-					 pdata->sub_devices[i].name);
-			}
-		}
 	}
 
 	return 0;
diff --git a/include/linux/platform_data/ti-aemif.h b/include/linux/platform_data/ti-aemif.h
deleted file mode 100644
index 77625251df07..000000000000
--- a/include/linux/platform_data/ti-aemif.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * TI DaVinci AEMIF platform glue.
- *
- * Copyright (C) 2017 BayLibre SAS
- *
- * Author:
- *   Bartosz Golaszewski <bgolaszewski@baylibre.com>
- */
-
-#ifndef __TI_DAVINCI_AEMIF_DATA_H__
-#define __TI_DAVINCI_AEMIF_DATA_H__
-
-#include <linux/of_platform.h>
-
-/**
- * struct aemif_abus_data - Async bus configuration parameters.
- *
- * @cs - Chip-select number.
- */
-struct aemif_abus_data {
-	u32 cs;
-};
-
-/**
- * struct aemif_platform_data - Data to set up the TI aemif driver.
- *
- * @dev_lookup: of_dev_auxdata passed to of_platform_populate() for aemif
- *              subdevices.
- * @cs_offset: Lowest allowed chip-select number.
- * @abus_data: Array of async bus configuration entries.
- * @num_abus_data: Number of abus entries.
- * @sub_devices: Array of platform subdevices.
- * @num_sub_devices: Number of subdevices.
- */
-struct aemif_platform_data {
-	struct of_dev_auxdata *dev_lookup;
-	u32 cs_offset;
-	struct aemif_abus_data *abus_data;
-	size_t num_abus_data;
-	struct platform_device *sub_devices;
-	size_t num_sub_devices;
-};
-
-#endif /* __TI_DAVINCI_AEMIF_DATA_H__ */

-- 
2.43.0


