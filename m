Return-Path: <linux-kernel+bounces-300363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9395E2D0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA2B215AC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227878C93;
	Sun, 25 Aug 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOmYR2l6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D177119
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576272; cv=none; b=mCymU9UFF8h/TnZW1zHLvjYnBcYrmTLxuAJByK7M/zPZRDH1kMZFZIjOgEjm2hvGYsGGoOnPAUmcEJlfcacEnR2Fyu0Rt97zFVnCH/MOlxdjDaPb5bi7clzpTHfxJ/IMB/orp2a9DqWJERHASnJ872xF8lVUSbhlEplIgk6wMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576272; c=relaxed/simple;
	bh=lCTjWmF/9K4denNqt2FdCUUu0I5veJZNX61skQW6V+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuAXvsO2MC2r9dY5nMB0NpJbHbAEYBku3sTZ7IHDBbCFpkTfWVHJ2YWvKgHJIFgT4URV+VPGRXrNgAOnTQ/e9OO9pOb10MOFMsdP/cTEPnPpctBO6FD4wMY1FVMS2u505oR20S3vxiBepQgeb6SDr9+21jtsAMoRbKNZYpdz6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOmYR2l6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71423273c62so2405667b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724576270; x=1725181070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdDSkwgr4tP8vvC2Lh81EsoGSqhFoF9r46WKr4u5n6Q=;
        b=jOmYR2l6RcKqklM15/PvBLfnPzNHFsV1SZdKCBbJyk4IPTXM27VQK1Ssb2bF6rK38e
         k5EgOJe5b4cFmFSF9WW22h/S7lZIYB6wPPsRigrxz+e1MUuanHmKlczLY6zp5IOBe+bx
         XycN7IQtQixZaU2H0fhuD4R6NQCqMxuVZN821ZegVwfmJq6TXB6V2aAYPqGia5V7XGDx
         gefSgLzI8lKA7XENsJOOI/AcLJZcwrC3XEdt8018LYvKPY6PeWkCqKBZ9382em+PaFBR
         xCwtyyhlMg2rYPk5ntPKET7eUAlOkRHxs5GoNV+B9QD36l+LcylHqPMQj+EIc0RRoH8k
         FhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576270; x=1725181070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdDSkwgr4tP8vvC2Lh81EsoGSqhFoF9r46WKr4u5n6Q=;
        b=bGl7YqS2uV8VOTTill+4SsrQz+Rltf7QvEhkKW0Q9eOPrTEYKc69ea1wInN6MO6AJg
         cwQr+jaGLbFQSSbwvz4LA3S5TDFRIJLggCrth756WaU5N3pWbBRCsKfrKKQaf5YEjofc
         LqFXVwNyozeiIyo7oqiw7X06vsaUO3LB9qqoNgYf1T1koJRE4s+MhGEg0qOJdVZK9lLu
         z39fkQMf6KuXq1dt4FmXZExsFtPFMKCt5nwPyC5CNFPGfdKD2hF/fTPBzOp6A04QzHlD
         BblTVPEPS5Whz370xvdDZgVyekW0U8b2Qe0MueaLf4ELJR/seU4AdxOOCgWOAupeP4DM
         dkQw==
X-Forwarded-Encrypted: i=1; AJvYcCXs6obgtd44pZDl7tLGkkxNrFeAvQcugDGh/rUOJLG9XUCqtlPba6qRliXYe2rlrRn5bwJpcjDVSN7/Xw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnDw4TEhjnINjEt7f5OCv22xYfu7yS8B10Kz2yOqLhfZJXQ0j
	r71bFdXXjnEm2JtlFOM/1clmji4B2+RU1pCf6Lc/clW/xIOXzTT9
X-Google-Smtp-Source: AGHT+IHnYI0GVsC+HRYaFQj5uR/diEHP2T8oRwEjXY1h9XGwrqqq7Xfcp8V/76LBZgRP8GY0y4P4hA==
X-Received: by 2002:a05:6a00:b8f:b0:702:3e36:b7c4 with SMTP id d2e1a72fcca58-71445cd49d4mr7759843b3a.5.1724576269357;
        Sun, 25 Aug 2024 01:57:49 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:b871:d8f1:d936:dc0c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143425109asm5414348b3a.67.2024.08.25.01.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 01:57:49 -0700 (PDT)
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
Subject: [PATCH v4 3/4] soc: ti: knav_qmss_queue: do device_node auto cleanup
Date: Sun, 25 Aug 2024 14:18:44 +0530
Message-ID: <20240825085714.10736-4-five231003@gmail.com>
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

Use scope based cleanup, instead of manual of_node_put() calls, which
automatically free()s "struct device_node".

While at it, refactor the code from knav_queue_probe() into the separate
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
index f2055a76f84c..2f14841ac8a9 100644
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
2.46.0.290.g4f02c709e8.dirty


