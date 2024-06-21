Return-Path: <linux-kernel+bounces-225406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440891303B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5AF1C23B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8316DEBB;
	Fri, 21 Jun 2024 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lStu89Kg"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529412E1E9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008568; cv=none; b=s7Tp3V4FQkTUKSvHq0cMUMoCDNqeQY3RsjXkV0rrmoQd+OHg3cnbiW2Vjxup9c2XAp7qEi5Vn8kTUjB+YIJQY1HrCou04ewGgtmFRJW+CxEbqSNXmQVQB+F657QZIWZhjqkblmu08dhPxx+1DXDO/p3JvxTXgZ4jNfFhjlOuOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008568; c=relaxed/simple;
	bh=8PoHB1+iNVVWg8t/RPg2r9VCF8spozdok5YxPwDRVdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kbVVLg3mMaikKtBGltz9F69HQZevuY7X1dIfAnqaF2V2pd2A6tJM7pCvc4dr5XSjs5MVnVfj7XUqOcGtYhIDsDRmhRMw0LpHM3D4G5Sw8CE8zDAJkLxmQtmm+uOB/jNxGox5vTIwF5MQhDcqgxwPGsSxDpjiiXujmRI0tZFo3M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lStu89Kg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b9706c84e5so1419612eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719008564; x=1719613364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlIty+WgdwDoohW5XXFoR1hOthwU+4uED/1nhbuq/KU=;
        b=lStu89KgLrVrp2G5NTYGp2uyfg5nVhlDQ8z/9xppOQYd3irrSloHJQUhpK7SRXn2+A
         tAEBOB+xkLWvV0mcrCt3YeLBQbW3hWKmqTbRIimJLdOeQ9M4wQqQaoSzWv/JhQfy5sr+
         7aDfty1Hcg2NwUtgAS8MCBPM2RavI26jgqg5vwwjvRQB3/VwU4W9NeEj9OudFBe00kJJ
         i6Dq1HxMKRT0d8TamsAA3RliE20S9jANfhPbvALudiSmq2a9g3y/RbTYrqN+ND3N9CTe
         Y08WZj3Y7rfIRZe9I/wiDqGPCGjrDG3QTAWNu1UTOBnUW5A6ykowi1UYgGWA9BCiPiOD
         D89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719008564; x=1719613364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlIty+WgdwDoohW5XXFoR1hOthwU+4uED/1nhbuq/KU=;
        b=vYqPrH73F6d9/0GFWOqZPsivgUlfXKLOuU/oKyiWSfv7p+lgbBlPeKsaNpqiG++464
         k9XBv0uiA4M4GXsASQSM7J8XCoFviXGMHKDLzDCRll+6qAOnjqvP2bh/TRAx4coN0YOD
         jiymKqKGCBNytbJ2PePbcXwIbl6fImf0OaQ1Sf13H0w2MbudeW56sTfawKG0Hsi9eAGX
         t9tmT59eNaqqMLK4+MJC9OXS87n5eUjFOFa63ZKsgZNRsKefc3zEw2Jv5Y5lfCuTPCfc
         jtfwsajXlXQn2H+vDWV9gn5Wga8w+vHNZoemadKhq0vuPGfW3SV6YXyOrZeWZo1zbhaR
         VtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfMTlOKVB6VonUZHh9+0iw/+lId4vp27fPBTxORo4R051LT/nT8T+TQfiGdoUZiREen5Lhuyvk6gWqPxB/lULF5X7GhHBXTtMXwwxM
X-Gm-Message-State: AOJu0YxWwnV90uS2nlnJ5JfqLxma49rJjMQwdRoHiQonw5UZ6Wa5etlb
	2rt0lUdjzvlnSUs+dyVPnH3KGBJvWt6LOuyQghUTcKHedn2lmKULd4YmyNJq/i0=
X-Google-Smtp-Source: AGHT+IG+p63Zxmf2rAXWjvPijY7SoPMWPclMbCezJsVfap4w6qjRMVX7Qof09UrimH4j8vFNbWCoxA==
X-Received: by 2002:a4a:2407:0:b0:5bb:2d23:8aeb with SMTP id 006d021491bc7-5c1adb3b4f8mr10056699eaf.2.1719008564634;
        Fri, 21 Jun 2024 15:22:44 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d5901473sm414841eaf.43.2024.06.21.15.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:22:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] counter: ti-eqep: enable clock at probe
Date: Fri, 21 Jun 2024 17:22:40 -0500
Message-ID: <20240621-ti-eqep-enable-clock-v2-1-edd3421b54d4@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The TI eQEP clock is both a functional and interface clock. Since it is
required for the device to function, we should be enabling it at probe.

Up to now, we've just been lucky that the clock was enabled by something
else on the system already.

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Reviewed-by: Judith Mendez <jm@ti.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Added Fixes: tag to commit message
- Picked up Judith's Reviewed-by tag
- Link to v1: https://lore.kernel.org/r/20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com
---
 drivers/counter/ti-eqep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 072b11fd6b32..825ae22c3ebc 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/counter.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -376,6 +377,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	struct counter_device *counter;
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
+	struct clk *clk;
 	int err;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -415,6 +417,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+
 	err = counter_add(counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);

---
base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
change-id: 20240609-ti-eqep-enable-clock-91697095ca81

