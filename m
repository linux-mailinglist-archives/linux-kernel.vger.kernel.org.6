Return-Path: <linux-kernel+bounces-238966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD365925442
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B771F220C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651D135A71;
	Wed,  3 Jul 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkGCrcyk"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22446134415
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989897; cv=none; b=V4aFEbJnSBoEYTjcXIh/B7PIxXOPl7iXXF4hPmsCfiGITwWSdWn/9Bwh9EZFAUVSU5cgV68/aGgCFlDK5QoIbvdkIY62cHp7w7KBNYxFkmX5LJtzOzfOoSYkE7yEN+E81FnB0LvYSy7hkejvXBk1Pk0Q9T5+aI4An9PUq0EKAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989897; c=relaxed/simple;
	bh=ZPs014jUeapXXCgzHtG44Q1FaQuSO5JnIUvqtly4tiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGAhV64yKsq0MzRI6t0dhS4wFJpIOFRg3OR2xsnYUwbX79Jnp1aNnu2NPUzZ9yZJ3WKG6tzeREQYPg7njESbv57NT1yMO50rH5AaQOzNuDENweOaGDcwS6a4TKxab/ZnhwdzsHOKFBSzNAgETtmkDqnuFVi7VHf06JuRSS3l2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkGCrcyk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c8911c84daso3468505a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719989895; x=1720594695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzpdtG7l+61FZknCaY59u/tBtOIKZgOnyqq0sEG7wfc=;
        b=AkGCrcykJlhpDOHQK+VLb2YXoUJBsrzcomXV5EgmOsWU4cWVVGPfd2OpGjDsb2ezoC
         542jInNrf2mmEVxkiImLuf6n9bvtu5Wqu/THJIFH8Eo5iCsuhv+gUcERcjyQ5wzDIS9m
         wS3Mx6OCQwPv0VLzxeYRWvHs5J8SdbtENkRCNPdKz/F0WILa13tj8GD2SXRG1An1PKtc
         Wr6GI61T3dGK0TybEE1kkFYZCi0H36+sWUcylsf/I1B0FPnnzPJKaaaW5eT+gzB+c3o1
         cgHqjTwDMa55cNiQT58nbzu/o+fY6EQFbaBQHJq1O5vxZuZB1wAc4OHTG6usmUTv2gZi
         LGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719989895; x=1720594695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzpdtG7l+61FZknCaY59u/tBtOIKZgOnyqq0sEG7wfc=;
        b=dDwyy+ppsYDIYfid1Ww3bCSi4PZX18cGjEnNWNB8FeGzIwCqTUvrWbmyltcOq47O5G
         rdn7rz2lsAoIjO+0tgwOWrkD4KxraQzHfkQTH/XO4FMhCDg7IPhOws8FaVpRHLmWuNWF
         6TZzLXFyy8f3PwgDm8GDMgp3DF7Cu9XvbVF4IwlpjONZXCjl75uZVrU06jH3iKxtS+XJ
         bIYtDwJPPtcVlaatAbQVjDe2QEfS6o+5hLDaUhP3/peyJJAzPKG8Q+QlG6O3bv+L4j7X
         lx8xyn/rU2Elep9Nm9VV7V4x+oy5uVMIaOYbq6dLJC3RmMetQxCFWdg5hoUqRohEavCU
         7PbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMQa7JMsBkbR1PQEQZnKj0jTXCy628GHE8vlS1xiYJNXNa/5l4G7JMlRHmmiBMepKKR2l9LwFgDEY0lvWSD6rjFBpLdEL3V2hsJMjm
X-Gm-Message-State: AOJu0Yw3G2lf62ipmzy/DbzBjYGN8ML7t1E1xpFshYfXL4ZRx/0zFq41
	sEGMEDcUjw+IbDJ2WoffpNWoldX9Y9EXeC+STHXq+MAoALdkJzJg
X-Google-Smtp-Source: AGHT+IFhTTaB1WupIMW6rfPpx8ReG1qfczZ5DxmoQdwGtfpjx5/6cHxOC3KlaEaxTWQ5ki3CPJyZXg==
X-Received: by 2002:a17:90b:3a8b:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2c93d7694abmr10642022a91.34.1719989895182;
        Tue, 02 Jul 2024 23:58:15 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:258c:c06c:76e7:dba9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e818asm9973921a91.51.2024.07.02.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:58:14 -0700 (PDT)
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
Subject: [PATCH v2 2/3] soc: ti: knav_qmss_queue: do device_node auto cleanup
Date: Wed,  3 Jul 2024 12:25:27 +0530
Message-ID: <20240703065710.13786-3-five231003@gmail.com>
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

Use scope based cleanup, instead of manual of_node_put() calls, which
automatically free()s "struct device_node".

While at it, refactor the code from knav_queue_probe() into the seperate
functions to make auto cleanup look more neat.

Doing the cleanup this way has the advantage of reducing the chance of
memory leaks in case we need to read from new OF nodes in the future
when we probe.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 85 +++++++++++++++++---------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 06fb5505c22c..767b9c49ea93 100644
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
@@ -1306,10 +1312,16 @@ static int knav_setup_queue_range(struct knav_device *kdev,
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
@@ -1389,14 +1401,20 @@ static void __iomem *knav_queue_map_reg(struct knav_device *kdev,
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
@@ -1668,6 +1686,25 @@ static int knav_queue_start_pdsps(struct knav_device *kdev)
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
@@ -1755,7 +1792,6 @@ MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
 static int knav_queue_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
 	struct device *dev = &pdev->dev;
 	u32 temp[2];
 	int ret;
@@ -1799,39 +1835,17 @@ static int knav_queue_probe(struct platform_device *pdev)
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
 
@@ -1853,14 +1867,7 @@ static int knav_queue_probe(struct platform_device *pdev)
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


