Return-Path: <linux-kernel+bounces-300365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6F95E2D2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F20E1F20F35
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA736770F3;
	Sun, 25 Aug 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQhwqZL5"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBC7DA80
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576282; cv=none; b=KpWG5H7zSPpYQYy8zIU72haS4L1fqFDhxYTHIUQkNUThT6G/A717ciPrn6jQ4Hh7+LQVqCvCL9uCE05AVnkAG8adfTXVzjqC1LzPJhdQbiVgoPjbQIPh7h4ef65ADzHjcocHrH+JTdJZHhC/S91uUejfeOvItZ8TTc0KODdP/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576282; c=relaxed/simple;
	bh=bZ2coIvMThC0641Kch/FQFWZUStNTz9cg7L/vnjPLIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ty82g5AUWHGDHW1DiYT1rkVwkPAJ5xIM3wn8kZ0PwYw9Uh11vk+rFGrb1CYEOYi9hY1IHNv4IvfHiFVuvHPr4x+QowHo0WPtT1YHpaI1zRWGmHbRvpaTsWV2SpAaAgYgPKd3vNuzOGfbghvRhivW2dptV1Vk1boXyp0XgfOTawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQhwqZL5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71423273c62so2405690b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724576280; x=1725181080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmISYgMpUlAe9Yh2xMwNMd95DBbU9NeKqHPqX7UpJnU=;
        b=WQhwqZL5YF6BX6RvXoR7hELZroEvhvtSs8m/jdIQHfWRru6/Fe9efuXgqtiTbEtbMS
         EPG4e30ZMl4Z9WNQHM4BVWpA9r34ODgJggtT7dBAqbSLf7SX+EFOamkaldt192EEX7il
         3LXXjG8HXNscQzB2sYLZIguwHqz8fLlp6PVCJu3TXsbBvFrwUwYxZ8rJsxIZt6gO0Fpt
         xaentioA7bQVDcqBesJJ86tFear+RzxavD1/8dbDtTX39RNpvnV6PZKMp39LH3OkMy69
         drw95AngF02KdK/pcEUx6k9RWxSGWOMVAGhaYJIFdoxLQ6cRE47VfzoMDwwMBTYpqzmG
         jglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576280; x=1725181080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmISYgMpUlAe9Yh2xMwNMd95DBbU9NeKqHPqX7UpJnU=;
        b=ABwRnVe19TVwqBlXND3FSwkimRDFp4Znz5p+3KYGkyE94CQ+9vPn6DnMIFFgIRhkPc
         T6EaQjSO3xfG17XF4DWgSsax2FbNC1GiIro702//BKd8CB6wfGgwDh/RlCJ7LpYcO92T
         oW9QWDzSvBqj5x3WUFAt9kczbgPHrCp4pwY/RZ7hb4BvgUVf5DPTlnDfzkY0jgSxyIRN
         xQ7DeVEukG6TiIz2gtaiIBXY+cDF+w2btFbtvGNIiPahb2aHmgSz2osxlYAkWtT/ZDFF
         h/nzHlDOLVjRpecJh55RcQHYkk8Xgm4V2yZh+XvsjSJEa183bxmh0BXZWid/P0QqBu8q
         PlOA==
X-Forwarded-Encrypted: i=1; AJvYcCVfbaDt67yJ2tsX1SPOcGfTWDCu4IIsQ9igZBLqPpJcoyGYQ+SNSjrhmONygX77V0HKYFflT/Dmct7R6zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCT2dGMydYG5d+/5I8bTnHvnQ2VRY4F0kgeN5Xjr6pptgMUqSJ
	uXVX9Jo7dMWVY+Hs1hjRMpyo0N6RxgodJ0yfKW9Ux3Q8jWOLz6Za
X-Google-Smtp-Source: AGHT+IFgyeQwAMTLWK0lo4575kKeDSrTrlhwS/4NLcWiLXb0PV0PIYonF6/gE+NONh44UsvI2HFn/g==
X-Received: by 2002:a05:6a00:a17:b0:714:21cb:8486 with SMTP id d2e1a72fcca58-71445cd5eb7mr7504708b3a.3.1724576279792;
        Sun, 25 Aug 2024 01:57:59 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:b871:d8f1:d936:dc0c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143425109asm5414348b3a.67.2024.08.25.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 01:57:59 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v4 4/4] soc: ti: pm33xx: do device_node auto cleanup
Date: Sun, 25 Aug 2024 14:18:45 +0530
Message-ID: <20240825085714.10736-5-five231003@gmail.com>
X-Mailer: git-send-email 2.46.0.290.g4f02c709e8.dirty
In-Reply-To: <20240825085714.10736-1-five231003@gmail.com>
References: <20240825085714.10736-1-five231003@gmail.com>
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
 drivers/soc/ti/pm33xx.c | 52 +++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 3a56bbf3268a..8169885ab1e0 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -383,54 +383,44 @@ static void am33xx_pm_free_sram(void)
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
-		if (!np) {
-			dev_err(pm33xx_dev, "PM: %s: Unable to find device node for mpu\n",
-				__func__);
-			return -ENODEV;
-		}
+		if (!np)
+			return dev_err_probe(pm33xx_dev, -ENODEV,
+					     "PM: %s: Unable to find device node for mpu\n",
+					     __func__);
 	}
 
 	sram_pool = of_gen_pool_get(np, "pm-sram", 0);
-	if (!sram_pool) {
-		dev_err(pm33xx_dev, "PM: %s: Unable to get sram pool for ocmcram\n",
-			__func__);
-		ret = -ENODEV;
-		goto mpu_put_node;
-	}
+	if (!sram_pool)
+		return dev_err_probe(pm33xx_dev, -ENODEV,
+				     "PM: %s: Unable to get sram pool for ocmcram\n",
+				     __func__);
 
 	sram_pool_data = of_gen_pool_get(np, "pm-sram", 1);
-	if (!sram_pool_data) {
-		dev_err(pm33xx_dev, "PM: %s: Unable to get sram data pool for ocmcram\n",
-			__func__);
-		ret = -ENODEV;
-		goto mpu_put_node;
-	}
+	if (!sram_pool_data)
+		return dev_err_probe(pm33xx_dev, -ENODEV,
+				     "PM: %s: Unable to get sram data pool for ocmcram\n",
+				     __func__);
 
 	ocmcram_location = gen_pool_alloc(sram_pool, *pm_sram->do_wfi_sz);
-	if (!ocmcram_location) {
-		dev_err(pm33xx_dev, "PM: %s: Unable to allocate memory from ocmcram\n",
-			__func__);
-		ret = -ENOMEM;
-		goto mpu_put_node;
-	}
+	if (!ocmcram_location)
+		return dev_err_probe(pm33xx_dev, -ENOMEM,
+				     "PM: %s: Unable to allocate memory from ocmcram\n",
+				     __func__);
 
 	ocmcram_location_data = gen_pool_alloc(sram_pool_data,
 					       sizeof(struct emif_regs_amx3));
 	if (!ocmcram_location_data) {
-		dev_err(pm33xx_dev, "PM: Unable to allocate memory from ocmcram\n");
 		gen_pool_free(sram_pool, ocmcram_location, *pm_sram->do_wfi_sz);
-		ret = -ENOMEM;
+		return dev_err_probe(pm33xx_dev, -ENOMEM,
+				     "PM: Unable to allocate memory from ocmcram\n");
 	}
 
-mpu_put_node:
-	of_node_put(np);
-	return ret;
+	return 0;
 }
 
 static int am33xx_pm_rtc_setup(void)
-- 
2.46.0.290.g4f02c709e8.dirty


