Return-Path: <linux-kernel+bounces-238967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2EC925443
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32451C23A78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E413774D;
	Wed,  3 Jul 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSl/XEM5"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57214137760
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989902; cv=none; b=NVe75Wk5FJvUmJH+4zSJO0rWqDoygDCOod2YK5pldrLo0eB4BySLqQuKfz69hMrk4q7ZqoQAT1Cjh9YZDSs9nxOj+cBgoY3zXtcDfP7ZybcLR6kkgr7f0xUDjVJefuD+hDLnd/jDbHxk7TUpIIGHaJteHmyDLy5qJTvjFzOFZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989902; c=relaxed/simple;
	bh=o2uBgu6KoI6iC4vRl+T9bSlBLBAmmXqPYZ7yreC4cEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRoDeUXsM8Ssc5+DQEGB12UAwE+KVWINKy29vXnhfO/+sevOGkkfI0h46f0ESO/eVckxporVU6rBtLXMtE0w71Ladqpfo/baC34ctI8+c3/CslJlbMnFGCUEAiRI2EuuYN6jXGYqKnB0wKcUy/zTzeudgdTWyS1VrvCxAG13BBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSl/XEM5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c8911c84daso3468542a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719989901; x=1720594701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxbxKt+yrBPNNKQZqw0DOsM2FX9GJEjPe3EATpJa3RU=;
        b=YSl/XEM5jROWO724p4De+dkUqr2O7CWc4oWZivF4HzzN/+fKk9tbqEsQHDOi3IPHCH
         wXmb+2hOcrdW8TUqmcrc0C/DKY7yPugI4JznCAxGzXXM1OSoc9riquduNTYiJzvK7f+/
         wKvGzWXEzB0xzJTLus9pPqqxuNBEwuS6BPnhb426tAGIpa/PbrYUUwXqhyIfSCwaIHhR
         cRPC2HxzOHzj+YIus1eRajqy2Mvdw79zrBL86RK211PWbaJtqQ9SVcWpPe//s8ajiGL+
         nlzxud2BoAciozenOXX6bjzLK9L+gX18J8wET0YwPvYXpnk7sWgU7MYUGouZZ9KaHa9t
         /xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719989901; x=1720594701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxbxKt+yrBPNNKQZqw0DOsM2FX9GJEjPe3EATpJa3RU=;
        b=EG9cT6JHbX0861ZZ4CQa7Y6MBx3gUP2ImrgHCbRpji4YYR22n8Z5CrH+JJh7Zwx2tt
         4NC4e7Ze3DtEbtHPLcuvwbbee5MdtYaCjy4xeIL36BqPYiEeawvHiXwZ9NIiISf4bfyN
         86cYoDattFCLSwuCmYKUVj437HMLkKd9uqo9wpfEw8xO2dq2LrxRF1gs+ew+/mV1DN03
         b7FZuomy0QLUZuVoGTGlvphUB53gB/LDouVz1PCjq2zyY7SpztXoxrOg3X00SRREtOKg
         jThQoSxnEhkVJXpbKyuBf1uhQR0HiOhLTv02CXCPKWln0sNrXr1yT9yYR0Zi9ogVtNG0
         Dy+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7vcsB1PvXacxyHj9CRE2knSP/ik+0Ik1ocYUbjdH4plH1Tu8UvHsCAaUE71oZmD47BGSdTMKeHBqI7HcU+9+xBcHy/hgIKL7oZM2w
X-Gm-Message-State: AOJu0YxelKXar4/UUJ5orX3z8WuPqoSor9ojXEUO4Jr9ePp6Dgu59FC8
	4hw76Kh/5hBGAgtyl+mL+i5TOnXswDCXVPXRyi8dtSKatMZ/Afjy
X-Google-Smtp-Source: AGHT+IHArs7mizExpBu5sv5B/RYD+ZEGUNrrOWSx56Hcy+SLKwJ5Kja6sljlxOWMSAWYm+qthagh5g==
X-Received: by 2002:a17:90a:ec12:b0:2c8:880:776b with SMTP id 98e67ed59e1d1-2c93d71f509mr9257040a91.23.1719989900562;
        Tue, 02 Jul 2024 23:58:20 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:258c:c06c:76e7:dba9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e818asm9973921a91.51.2024.07.02.23.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:58:20 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>,
	Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 3/3] soc: ti: pm33xx: do device_node auto cleanup
Date: Wed,  3 Jul 2024 12:25:28 +0530
Message-ID: <20240703065710.13786-4-five231003@gmail.com>
X-Mailer: git-send-email 2.45.2.561.g66ac6e4bcd
In-Reply-To: <20240703065710.13786-1-five231003@gmail.com>
References: <20240703065710.13786-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scope based cleanup instead of manual of_node_put() calls, hence
simplifying the handling of error paths.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/pm33xx.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 8e983c3c4e03..40988c45ed00 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -383,10 +383,9 @@ static void am33xx_pm_free_sram(void)
  */
 static int am33xx_pm_alloc_sram(void)
 {
-	struct device_node *np;
-	int ret = 0;
+	struct device_node *np __free(device_node) =
+			of_find_compatible_node(NULL, NULL, "ti,omap3-mpu");
 
-	np = of_find_compatible_node(NULL, NULL, "ti,omap3-mpu");
 	if (!np) {
 		np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
 		if (!np) {
@@ -400,24 +399,21 @@ static int am33xx_pm_alloc_sram(void)
 	if (!sram_pool) {
 		dev_err(pm33xx_dev, "PM: %s: Unable to get sram pool for ocmcram\n",
 			__func__);
-		ret = -ENODEV;
-		goto mpu_put_node;
+		return -ENODEV;
 	}
 
 	sram_pool_data = of_gen_pool_get(np, "pm-sram", 1);
 	if (!sram_pool_data) {
 		dev_err(pm33xx_dev, "PM: %s: Unable to get sram data pool for ocmcram\n",
 			__func__);
-		ret = -ENODEV;
-		goto mpu_put_node;
+		return -ENODEV;
 	}
 
 	ocmcram_location = gen_pool_alloc(sram_pool, *pm_sram->do_wfi_sz);
 	if (!ocmcram_location) {
 		dev_err(pm33xx_dev, "PM: %s: Unable to allocate memory from ocmcram\n",
 			__func__);
-		ret = -ENOMEM;
-		goto mpu_put_node;
+		return -ENOMEM;
 	}
 
 	ocmcram_location_data = gen_pool_alloc(sram_pool_data,
@@ -425,12 +421,10 @@ static int am33xx_pm_alloc_sram(void)
 	if (!ocmcram_location_data) {
 		dev_err(pm33xx_dev, "PM: Unable to allocate memory from ocmcram\n");
 		gen_pool_free(sram_pool, ocmcram_location, *pm_sram->do_wfi_sz);
-		ret = -ENOMEM;
+		return -ENOMEM;
 	}
 
-mpu_put_node:
-	of_node_put(np);
-	return ret;
+	return 0;
 }
 
 static int am33xx_pm_rtc_setup(void)
-- 
2.45.2.561.g66ac6e4bcd


