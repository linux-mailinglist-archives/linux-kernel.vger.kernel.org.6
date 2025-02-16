Return-Path: <linux-kernel+bounces-516587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D5A3745F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A3618933BB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2226199FC9;
	Sun, 16 Feb 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lHiS89xy"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFE1922FD
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710729; cv=none; b=BCdKhLfgIOFGlSo3yCya8TlwEGQ8ublFN9oKoXJC7ppKWm1Np1HO3KfB5mk8znS2Buqj93ZpIqfxU8mimAmnYFPT3mtzdvhfWlv/UzkiXcdPSIN7FEqXnIMqdtLeUA8uVOu0tBDhsofGq2y5iJQca1E3ZXUwEmrstZUBpsosXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710729; c=relaxed/simple;
	bh=gaGxbWoVq59TTDiq4cJd0eCsgnEJQWKB3/3FfvlvZ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlHD7rwbI7msu2Y/oFRbrX5R9IdBQvECqoEN4QCFIbqalZ+xkCFT/VJHz2fnWSTeslg5E1SQPo0kvOnbWjGwgsKtn+L8Cfr5wPTzHoRsCSqP7kcdik16WnR80HMT8hR3pR/x2tgNOl3g6XG3MrPSZ0vcjbNG4hMPIf6fAMYnHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lHiS89xy; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE1CF3F2A0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710725;
	bh=iZPn8FzJi1wBDhT5MKcLY0VoABjKA3JgOf2KFRB4x/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=lHiS89xyiIXGuTMfAXkvnZGJEjt0GCRZGubgqjQzIooz9qDJ1f6UbKh6aDt7/JUYZ
	 o+kMPvntcodBAUPKIo/sUSvp2u2glTAugiCsmDb80l+Yxel6F7ZGT7fcgIMcfiyrE0
	 GwC/Cjnij2njDyT3qtpJy7cDqH+Aeepa77E5NlkruwQgRCDjRrcR71voVY8a5ThRN/
	 pkA+dF9EYPk3vZU4A/CxCKh1gWgvzBNntRPH/Pk+LwBBPieCYzF56kCAgEz64H1vTa
	 aaXU99VMiwDJbhvIramhx2jXdLC4HMsVYTP7RUwihVm8KkmLWxr/mDuxs1giTejrpR
	 0PTYVbuzEaetA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so3995071a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710724; x=1740315524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZPn8FzJi1wBDhT5MKcLY0VoABjKA3JgOf2KFRB4x/o=;
        b=QTxHl3z+Rqx4ynlI3JGbLVyLb2OwQXLMKXWjfD5Ovn/eNTX3loGAJz+loskbvu9tUk
         M8f+JuFVL4Pgbu9mtusiO5BWdHYWqxtuXNN0iSPYGmJyXCHUyYhLioFmN8xkdbGFZRfA
         vf6Nit7K1nOvRze0I5fzEMWjo2SGW5MS6etErww2bR+Bu4WUdDldBZFiXwqXvRBkVpT7
         efVQ7AiKBih6/L0NtiMflNLjcjtRghCzl4TBhoEMEn8uV54hMPJE65JGAFzYTj24XH9T
         iaFye9qgFn/2hgcH/t+yLoPQ/BR8n/ddEN57SQ7Xvs+dHFAvl3nbQ209BXthcL2mFkc1
         +RTg==
X-Forwarded-Encrypted: i=1; AJvYcCVristO/+QHHKoIwa5WXvpGTMYMDCLaNJc8YXj2Q/TPlnoAc+J/rMGvxN3j8lQ/hMF26bLyDrfxJNF4njQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSw60JPquuQoeK019Rx1nXrw1wf1dDDw/35zy0burYHmYEIa9D
	xClbeDXTMjqHqgCxk5IlwdRoi22KISBYRxhwOfce4OeyWP7NCIQ7B5c7RnlbM3JfCcYykpfWMJu
	1bfATcRS10trU/uHDtFd/Vwdm4f5adQKmN7M9EER6dgc6cHce4WvmPNO8nEjkg14cUKmsmqH/0u
	tO1A==
X-Gm-Gg: ASbGncsbqpc4Tj9OzcezhrKRNMkTJETkoq5V3U6wjwlSYtJS/3A5DzarYNxDhyNE87c
	vPJTZHvnLS27OhH4a/dmAjMopCmePTwffLUw7qUgAPemSoiPeLPYJT8x4JslRl3mDwkpoU50ZIJ
	eKD2+YyVhmyWvhFcD8VtOlZQgutQE7XM3pc7/L1Sre2BRfKmlUeZ2tM2oGe/L5crrCSG1dXBptn
	VAgwiQx5E+nUfmuGJJINF9iH1L7xsiq4fMH5K7ScCLkz2/GUACTFv6l0k+DqkNNPnTX/KMJbz63
	xcioLA==
X-Received: by 2002:a05:6a21:4014:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1ee8caab5bcmr12234116637.8.1739710724260;
        Sun, 16 Feb 2025 04:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfRPYv58J7W+79MK/Q30Fi4lENg4yHxG8EDlpAXCIOHoz6Soxw8W0XJQto3mMp1Ii5Vz+npw==
X-Received: by 2002:a05:6a21:4014:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1ee8caab5bcmr12234095637.8.1739710724000;
        Sun, 16 Feb 2025 04:58:44 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:58:43 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] gpio: aggregator: convert to use gpio-pseudo utilities
Date: Sun, 16 Feb 2025 21:58:09 +0900
Message-ID: <20250216125816.14430-7-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250216125816.14430-1-koichiro.den@canonical.com>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update gpio-aggregator to use the new gpio-pseudo helper functions.

Note that the current sysfs interface for gpio-aggregator does not wait
for probe completion when creating a platform device. This change brings
no immediate benefit but prepares for a later commit introducing
configfs that shares this mechanism.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/Kconfig           | 1 +
 drivers/gpio/gpio-aggregator.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d8fede07149f..8b9ffe17426e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1871,6 +1871,7 @@ menu "Virtual GPIO drivers"
 
 config GPIO_AGGREGATOR
 	tristate "GPIO Aggregator"
+	select GPIO_PSEUDO
 	help
 	  Say yes here to enable the GPIO Aggregator, which provides a way to
 	  aggregate existing GPIO lines into a new virtual GPIO chip.
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 893cd56de867..b24ed963cd9a 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -27,6 +27,8 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 
+#include "gpio-pseudo.h"
+
 #define AGGREGATOR_MAX_GPIOS 512
 
 /*
@@ -34,8 +36,8 @@
  */
 
 struct gpio_aggregator {
+	struct pseudo_gpio_common common;
 	struct gpiod_lookup_table *lookups;
-	struct platform_device *pdev;
 	char args[];
 };
 
@@ -492,7 +494,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 		goto remove_table;
 	}
 
-	aggr->pdev = pdev;
+	aggr->common.pdev = pdev;
 	module_put(THIS_MODULE);
 	return count;
 
@@ -517,7 +519,7 @@ static DRIVER_ATTR_WO(new_device);
 
 static void gpio_aggregator_free(struct gpio_aggregator *aggr)
 {
-	platform_device_unregister(aggr->pdev);
+	platform_device_unregister(aggr->common.pdev);
 	gpiod_remove_lookup_table(aggr->lookups);
 	kfree(aggr->lookups->dev_id);
 	kfree(aggr->lookups);
-- 
2.45.2


