Return-Path: <linux-kernel+bounces-243479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDA19296C0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CE728276A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED9EAF9;
	Sun,  7 Jul 2024 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHqv+qM8"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185815EA6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331665; cv=none; b=rK0H+nOqSA4hWM5xXO5S5/S19cjJd/U7OJ77LhUxJFtUuFm9qNUUzRo22AAiAjnibkLtG/q9LHpCfDOqM+jjGiVhOJPGd7EJubVin6h3S22pXFcxt4RjEylMzM5jwl4XRyh/FPNOu65M+mBIPhRtCCoG/2A2u8pICIhcPVobAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331665; c=relaxed/simple;
	bh=A+Yqc0Y2sY3QERD0+cTYtcAee5yJA/eRgm7s+R2BFY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqR319DbYSNtdJB60Co9F0ChiQztMeCe9Zh0p8N/o2Hh+QnHtBVvOxZSCwqQm+6JnK/2DWA7JPNQv6yq1LmSN1q4houMGdSBvx4WgByVSzbDCHYN9fOKcXwo/JpXG6E8w62plxmSb7rdFmDYTc5MDhsKO7un3DNSNfWhezH+TwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHqv+qM8; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc66c649so1525129b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 22:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720331663; x=1720936463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUg4PV29CFOGLmMvmdWs76G4kY/lh/K0XHciozPPEOE=;
        b=VHqv+qM8T+cRtDJKRy8AicAxbxMelKJNDFTJw62tyzmkdrYqknu9MI2HK0YelX6clu
         vfqGZ3j7Iz9tPXY4gAxCeQ18YgC/cSfgffchfV+u9XC4jpyik6R2Q57MLtRjvvmqM53D
         ot0K7QpaRy0qasMuBphzJtZ33/gIv+BZJtEhtnKMOoyrfVARhxuhloZHhLVYiAH4PzTf
         Y3Oznt24hATjBlgtda6DKASxvwgO46+GPOfqUM44no+10gokz28BykH/vW2pzNugeJeq
         li1VcFXs1ysdgB/kEPqCGROx1BgwSNvPvk5AZ+pHOGBfeGN4EmF4cMN+qwDIRUn27Kde
         e7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720331663; x=1720936463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUg4PV29CFOGLmMvmdWs76G4kY/lh/K0XHciozPPEOE=;
        b=NnqNJpUVXYqkludzUWNmr8rNtyp8QlvXPEZkpg6yOKrygCcgZgzIOIs4+S0yrKouFH
         9VH0EmyGlQoFOgsistkGHXniFZW8iZRVzfovOhXaHWwIYZCdaNMVs94aIw3fTfBgeANv
         XH7NjvqJwkk6XbRLQoY2gp09SmQ768zoSbHj4OBNef5NPm/rf/WsMay4xDWP8EqnTACT
         iQEg4bZvp4Zbhwb/RH2+tP2ppLeRZooJBhVguyvHISfk4590edlrPKUf/G1PFjKxi3nr
         rQQN19MdHxKLzOoZXi4RXebaHLT4twomzB2V8mezA98uWGJV/hj6/Pxprj2H4vCOJkum
         ffyg==
X-Forwarded-Encrypted: i=1; AJvYcCVJvhIK/z3zrAl0BuIkMEspq5p4Y5KC7Cl0jESsW0KQREeDkpc0cpfc7mu0pOaQc7ENIVyY0q1jH/xuo3AC5goCdZKGlENgtNyN/SoR
X-Gm-Message-State: AOJu0YxA7qHei2YrgJI98o9SdO2Z4yoP08Jin7ESKokuO9OkbJWmv+LT
	tzbp8QvtWNTuP2oh+8qVgLdv3gYaVSeYrWPY7qgs/YCo9vy8mJSG
X-Google-Smtp-Source: AGHT+IFUJJDPOBesbBpJmBoRvVb3Ess8NluFY8+9Qxo64gDShTCPBuINQn3LHw7EIoQS+c8DkpXYLQ==
X-Received: by 2002:a05:6808:1392:b0:3d9:1f05:845 with SMTP id 5614622812f47-3d91f050a43mr7087381b6e.19.1720331662674;
        Sat, 06 Jul 2024 22:54:22 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:252d:94b8:b79c:d7bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2e5fe3dfsm94429b3a.97.2024.07.06.22.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 22:54:22 -0700 (PDT)
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
Subject: [PATCH v3 4/4] soc: ti: pm33xx: do device_node auto cleanup
Date: Sun,  7 Jul 2024 10:44:19 +0530
Message-ID: <20240707055341.3656-5-five231003@gmail.com>
X-Mailer: git-send-email 2.45.2.561.g66ac6e4bcd
In-Reply-To: <20240707055341.3656-1-five231003@gmail.com>
References: <20240707055341.3656-1-five231003@gmail.com>
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
index 8e983c3c4e03..d0edce53c793 100644
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
2.45.2.561.g66ac6e4bcd


