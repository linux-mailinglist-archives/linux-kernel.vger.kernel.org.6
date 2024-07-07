Return-Path: <linux-kernel+bounces-243478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A619296BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD30DB20E37
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58668473;
	Sun,  7 Jul 2024 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsaKOunD"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC012E6D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331658; cv=none; b=SMnp3LI6HsiNi9szI+gs9PZxZcamkXcJYU9EAcnThxfVANUea/Hb2YcFMVIZHODT5FeCs7DusfcbmO/R3sArFcnb4QoC8CiNpR6+XZjryF1aUQDMK3CERQEu1hrvcaR0/tvabiLPX8YeSCXsim9/y+kn88P9PwKjWMh71hHbxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331658; c=relaxed/simple;
	bh=aGupbIWhOuEPGiinUvpLYSMe8w+/SDbrcOcNts9puZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf5nkJNjH/9hR9pgRreq8u3ZvZf5IV3EsDAw97Z5DYX330XLdzDDHeO5zk7Cdhr0+idO8bKLB2RTtCQzS3RCh1xT3nT3pU6XvAhQzV0X4Gkq0TXEwM++82/M347lXQgNKeyJ7EzqnAPKcbvgRucY3zcgAaCTWk/8cZOPt8J6ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsaKOunD; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c66de0c24bso377220eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 22:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720331656; x=1720936456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkYP94kjr/8aPWc+0tv0/ZqO8o4iHRZmdZ252DF4P2Y=;
        b=QsaKOunDIns7LqeXAJ8aSKuaZF07kA0F/BIDa8MfWIsP5peIJNt5ddA6mA9OxtAzIL
         udNw9iRAxIWvlwSZ515S3X6PXVnvsI2CCewwTKmkp2TsDmnaK9eI8/8oM/Q39yED0mma
         B42foOtxznAHJmARmVJnYuwbFiqu21qHJU0gCSDFvrhbOUnhr5jDN2v2M3xv/iZ3qE5m
         AaixwHAkoYR7IUmydgPewkk2EmwKW4CzY79Q7HMtH4fTc0Wifwte+gP5eRnWQI5ikVbK
         oPWHXh//H5LdjMlBjtyLC0HI+fdCl62GcKYOufhBQ4+Ew2PJxkDW158uuuURpIMh8MM5
         KPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720331656; x=1720936456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkYP94kjr/8aPWc+0tv0/ZqO8o4iHRZmdZ252DF4P2Y=;
        b=ReHY6w5Mfuy/L0w22YnXUuvRG0YB7ojgD7DWiKPQgjn85xARAvzx98HtpiCw+hAljP
         5weM0KY5LVq7rpvyWz6X6ub+IgiZWX+oWxuOyUBmiHk8z/rIUosJTthyvV6DJ74lwOl0
         jCF+4WBerU/zwKyVoN+gpbG/LEzie71lgWztc65HgeKZQxuCvmpIh5Bvewk6yIJYDI3h
         Oanac/h0nCt3eOLiy9vGACpB/b3KEeQJnABig8HpsJBC/wV1Th3OOpQ+jg7SO4cDRarm
         cTx5SZvNR+c5vUv2yXwoL5e/6JcWxGiyBp+OujngFGalhnK08fB5IVlJUPOF/VCy35Hm
         7BnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Hag2Ooh5vZm1xArKvSBHHhOpVXxedOAChwJoAL1HXD4dmqTnfrtxQ7KgbQAU8JcmRaF6Y+lKVkSUKQuTuToKYjtaqsEGlVtfxJmB
X-Gm-Message-State: AOJu0YyUF1K6+570OT752XToKsMtmnyj7zSXxLD/OXBVSBcH1tG1GtRH
	c6Yj4lIXizpemJnS5PvTaIgToxKmpSoI7W8nxodTqzC1+b7PoJv4
X-Google-Smtp-Source: AGHT+IEu5EHIYcnfrC8/ox3w5DEvJ6bgrLaIpMPaGoA9D9FGa+MnvW04XbpcHN+amV5ID3TB24rIOQ==
X-Received: by 2002:a05:6870:d8c8:b0:24c:adc0:ffa1 with SMTP id 586e51a60fabf-25e2b5aec6fmr7214256fac.0.1720331656199;
        Sat, 06 Jul 2024 22:54:16 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:252d:94b8:b79c:d7bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2e5fe3dfsm94429b3a.97.2024.07.06.22.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 22:54:15 -0700 (PDT)
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
	Kousik Sanagavarapu <five231003@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 3/4] soc: ti: knav_qmss_queue: do device_node auto cleanup
Date: Sun,  7 Jul 2024 10:44:18 +0530
Message-ID: <20240707055341.3656-4-five231003@gmail.com>
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

Use scope based cleanup, instead of manual of_node_put() calls, which
automatically free()s "struct device_node".

While at it, refactor the code from knav_queue_probe() into the seperate
functions to make auto cleanup look more neat.

Doing the cleanup this way has the advantage of reducing the chance of
memory leaks in case we need to read from new OF nodes in the future
when we probe.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 100 ++++++++++++++++---------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 06fb5505c22c..f4b603719055 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1076,14 +1076,20 @@ static const char *knav_queue_find_name(struct device_node *node)
 }
 
 static int knav_queue_setup_regions(struct knav_device *kdev,
-					struct device_node *regions)
+				    struct device_node *node)
 {
 	struct device *dev = kdev->dev;
+	struct device_node *regions __free(device_node) =
+			of_get_child_by_name(node, "descriptor-regions");
 	struct knav_region *region;
 	struct device_node *child;
 	u32 temp[2];
 	int ret;
 
+	if (!regions)
+		return dev_err_probe(dev, -ENODEV,
+				     "descriptor-regions not specified\n");
+
 	for_each_child_of_node(regions, child) {
 		region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
 		if (!region) {
@@ -1121,10 +1127,9 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
 		INIT_LIST_HEAD(&region->pools);
 		list_add_tail(&region->list, &kdev->regions);
 	}
-	if (list_empty(&kdev->regions)) {
-		dev_err(dev, "no valid region information found\n");
-		return -ENODEV;
-	}
+	if (list_empty(&kdev->regions))
+		return dev_err_probe(dev, -ENODEV,
+				     "no valid region information found\n");
 
 	/* Next, we run through the regions and set things up */
 	for_each_region(kdev, region)
@@ -1306,10 +1311,16 @@ static int knav_setup_queue_range(struct knav_device *kdev,
 }
 
 static int knav_setup_queue_pools(struct knav_device *kdev,
-				   struct device_node *queue_pools)
+				  struct device_node *node)
 {
+	struct device_node *queue_pools __free(device_node) =
+			of_get_child_by_name(node, "queue-pools");
 	struct device_node *type, *range;
 
+	if (!queue_pools)
+		return dev_err_probe(kdev->dev, -ENODEV,
+				     "queue-pools not specified\n");
+
 	for_each_child_of_node(queue_pools, type) {
 		for_each_child_of_node(type, range) {
 			/* return value ignored, we init the rest... */
@@ -1318,10 +1329,9 @@ static int knav_setup_queue_pools(struct knav_device *kdev,
 	}
 
 	/* ... and barf if they all failed! */
-	if (list_empty(&kdev->queue_ranges)) {
-		dev_err(kdev->dev, "no valid queue range found\n");
-		return -ENODEV;
-	}
+	if (list_empty(&kdev->queue_ranges))
+		return dev_err_probe(kdev->dev, -ENODEV,
+				     "no valid queue range found\n");
 	return 0;
 }
 
@@ -1389,14 +1399,20 @@ static void __iomem *knav_queue_map_reg(struct knav_device *kdev,
 }
 
 static int knav_queue_init_qmgrs(struct knav_device *kdev,
-					struct device_node *qmgrs)
+				 struct device_node *node)
 {
 	struct device *dev = kdev->dev;
+	struct device_node *qmgrs __free(device_node) =
+			of_get_child_by_name(node, "qmgrs");
 	struct knav_qmgr_info *qmgr;
 	struct device_node *child;
 	u32 temp[2];
 	int ret;
 
+	if (!qmgrs)
+		return dev_err_probe(dev, -ENODEV,
+				     "queue manager info not specified\n");
+
 	for_each_child_of_node(qmgrs, child) {
 		qmgr = devm_kzalloc(dev, sizeof(*qmgr), GFP_KERNEL);
 		if (!qmgr) {
@@ -1668,6 +1684,26 @@ static int knav_queue_start_pdsps(struct knav_device *kdev)
 	return 0;
 }
 
+static int knav_queue_setup_pdsps(struct knav_device *kdev,
+				  struct device_node *node)
+{
+	struct device_node *pdsps __free(device_node) =
+			of_get_child_by_name(node, "pdsps");
+
+	if (pdsps) {
+		int ret;
+
+		ret = knav_queue_init_pdsps(kdev, pdsps);
+		if (ret)
+			return ret;
+
+		ret = knav_queue_start_pdsps(kdev);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static inline struct knav_qmgr_info *knav_find_qmgr(unsigned id)
 {
 	struct knav_qmgr_info *qmgr;
@@ -1755,7 +1791,6 @@ MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
 static int knav_queue_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
 	struct device *dev = &pdev->dev;
 	u32 temp[2];
 	int ret;
@@ -1799,39 +1834,17 @@ static int knav_queue_probe(struct platform_device *pdev)
 	kdev->num_queues = temp[1];
 
 	/* Initialize queue managers using device tree configuration */
-	qmgrs =  of_get_child_by_name(node, "qmgrs");
-	if (!qmgrs) {
-		dev_err(dev, "queue manager info not specified\n");
-		ret = -ENODEV;
-		goto err;
-	}
-	ret = knav_queue_init_qmgrs(kdev, qmgrs);
-	of_node_put(qmgrs);
+	ret = knav_queue_init_qmgrs(kdev, node);
 	if (ret)
 		goto err;
 
 	/* get pdsp configuration values from device tree */
-	pdsps =  of_get_child_by_name(node, "pdsps");
-	if (pdsps) {
-		ret = knav_queue_init_pdsps(kdev, pdsps);
-		if (ret)
-			goto err;
-
-		ret = knav_queue_start_pdsps(kdev);
-		if (ret)
-			goto err;
-	}
-	of_node_put(pdsps);
+	ret = knav_queue_setup_pdsps(kdev, node);
+	if (ret)
+		goto err;
 
 	/* get usable queue range values from device tree */
-	queue_pools = of_get_child_by_name(node, "queue-pools");
-	if (!queue_pools) {
-		dev_err(dev, "queue-pools not specified\n");
-		ret = -ENODEV;
-		goto err;
-	}
-	ret = knav_setup_queue_pools(kdev, queue_pools);
-	of_node_put(queue_pools);
+	ret = knav_setup_queue_pools(kdev, node);
 	if (ret)
 		goto err;
 
@@ -1853,14 +1866,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	regions = of_get_child_by_name(node, "descriptor-regions");
-	if (!regions) {
-		dev_err(dev, "descriptor-regions not specified\n");
-		ret = -ENODEV;
-		goto err;
-	}
-	ret = knav_queue_setup_regions(kdev, regions);
-	of_node_put(regions);
+	ret = knav_queue_setup_regions(kdev, node);
 	if (ret)
 		goto err;
 
-- 
2.45.2.561.g66ac6e4bcd


