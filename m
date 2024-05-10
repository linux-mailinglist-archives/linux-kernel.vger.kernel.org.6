Return-Path: <linux-kernel+bounces-175392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123038C1ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435EF1C20C61
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646F15FA62;
	Fri, 10 May 2024 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feTNMKf8"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4915FA80
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325306; cv=none; b=lkPR9H82UFo0ABBJh2WALliJYI1UMk/bJi0CAosMqAyi/rfmOqt+9RnucWjTdkiEL83pBOrNTp1+XI/aTdiu/R7ny4Ro1WOy7IIUah72mOTpgHwpUZOJ4ISgDjgCCZ5n8rE7Yz/QIMuxHkRpPrO1cEYutWdYlUUZtKOfFvPaWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325306; c=relaxed/simple;
	bh=oAm++Nl7rH+floe+stVP5JzNifQpPjuF4OcCxTwuO9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HegWLuh8SfIJDrzd7z1I4tgK3oofxYf62e2fqIm8gx3CcRRuzlikUTLZlx+eAoEjLkTaJN/Ku5mg83cBmveAr9D/wZODOzmHOMFfndaklxZPzBdglIRZUnENGEzSjlPnovoR0EtkYTu+wBFMeQyIGF9aqBNyyCFLtOG0NrTjrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feTNMKf8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44dc475f4so1458114b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715325304; x=1715930104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e9AaiZhqzpQxOi3rf8QWQAd00HqbSZFUmUbCLkX+1U=;
        b=feTNMKf8TCUfb6Lv1MKfvFbktz+nUw/324LS/CJ+y467Eo7uyp7uJ4HGa0TXmaqz8p
         1px1KhJ2muHIiPvicwPLlNqAhAbwHl44/mPqH7OmreZbLF7c05Mby/PiymiEGS1/PeM/
         NIVj9qGIScSXd0wcPQ2wcDSYNNt63mSaITgW4yhcwWPllNfoaeEDYJ9K7mDOzCGp74eO
         Xv70sGKVOV1f0PogKjLjL4AR+IoON5eDRFKv+Cklqnj2dp7/vuiSof73YioB99VnXcNc
         22UA3yn4BPgxQQV/mC58HbK5o+FMDIyhQdqq1/CNsP5QOo5sgApyhCwCJn/8w/7gTugD
         CzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715325304; x=1715930104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e9AaiZhqzpQxOi3rf8QWQAd00HqbSZFUmUbCLkX+1U=;
        b=eLl1cPYbKjb0Jsw/aNmwggWU+4Q4mtHgylBjZ6txeO6jJdXY+O1avED+WMGGxmD9MP
         qOTDu0td0rORbRTYpWGjEX+I9OsO/akeQWeOwTwZCXKT8V3hwpb3NvWEuCWQQnCyqqcB
         uMq9WE8v6XyJbJqnz2SmtJxtckQUmOGKbqiZGY1KA1q9vrEzmnPY9NtSf2pi7wPH8hA3
         3FA5HccmbmEil3wLuQOHdl6xfE1NTnmNFStjONmjQRUKhMvr/eq9yoNIaZOrhrggY9E5
         WzGFXk3b0uQ/xnqPB3TkEeIRno6KQhLxsQGkiRKCz3XIZnjkgDqCP9ap23Uzn54FzNiT
         MF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6jDu9mgjqSK8jD+sm0gwj+hf2OYsJP3nZ+xwF1T970ABabqyb9fJ9Gy8ylCv7biF4fQ+d/S3O6RXHHfvNIqJo/fXG1EiRofKCoe90
X-Gm-Message-State: AOJu0YwMA/SBaEXGO2Qz+jomyLOwv6HZN4iUC2u5B/chyucXRluj6fyU
	AKZd3kRUQhp8XIV95Lwzp46pgwMft1/Pzq9hs8PWua/0vvc+sFrv
X-Google-Smtp-Source: AGHT+IEwUMH0kBFIFoUmUPVo3NgEwfjmKEL/UUFcaYpx/JhNnaWZO9dILpMlR+hxXvDfTz57P+747Q==
X-Received: by 2002:a05:6a00:1a93:b0:6ee:1508:edc8 with SMTP id d2e1a72fcca58-6f4e0347d57mr1783419b3a.23.1715325303602;
        Fri, 10 May 2024 00:15:03 -0700 (PDT)
Received: from kousik.local ([2405:201:c01a:90f4:8de5:a651:7145:5260])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a37sm2344475b3a.161.2024.05.10.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:15:03 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 3/3] soc: ti: pm33xx: do device_node auto cleanup
Date: Fri, 10 May 2024 12:43:24 +0530
Message-ID: <20240510071432.62913-4-five231003@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.8.ge326e52010
In-Reply-To: <20240510071432.62913-1-five231003@gmail.com>
References: <20240510071432.62913-1-five231003@gmail.com>
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
2.45.0.rc1.8.ge326e52010


