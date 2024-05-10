Return-Path: <linux-kernel+bounces-175390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B48C1ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35DD1C21CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBDD15E5D7;
	Fri, 10 May 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwY4PM+0"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE615D5BD
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325295; cv=none; b=RNd6H93qkCoxgqjadBPik2TAFgpw/D2Axxwux3lq4ToZYmmq8OteyIjH4hLwlp+RQceItFlMLvoCLMJIz/Bmu+H3HCCA+d4+YJw8nKPq8ShzGt6dLwnmptuE3PWzjFpzFAiOx9c79u8CVYfyis2GnWHj8Sk11AguMSiiMpYSL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325295; c=relaxed/simple;
	bh=X9GM11oXuJoXdDSCPr2nHcRrKw9Gn4uUHfpmpxxS7NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhgEnuYj1vQClYptfS3JocegY8Wc3dAZpP0qRVfAL6pzUstvobYa8A+SDVCBV6O16id7lw/8Uv7nChDksd6duxQu4NeRYo/qs3j5fkNHAh8C0Zq5jLw8xpZuTIPlgs2irgFr8V0GI4RCFGgCTML+DUTXB24HUipySLAB20oDXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwY4PM+0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso1762776b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715325293; x=1715930093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKl1sJKw/UsKDzy8KNhNK1sYyMGjgorHopo+1odx4UQ=;
        b=YwY4PM+0hqdazp9U1kQJ3QKuE6NLZozWeKUpYB+LFDmuXLwAcY2rdtkIFrc+FoRf06
         xd7ALYGQKrTvX0s/2OXXjc8oqPKSnVcaQ3pL6Tedw7yOqZGJSXQfNH252ohefko9S5g8
         /qp+DQwpLAX5KcDmbTsVno5u2UxBESRCHZqCus/3A+wO+5g4YlFFfuoEXMoL9+TDMhzU
         ltukYNcZEbOiO7nHxCiSE1v6MMi/8HHQ93jx/jfD9ae0LJ2prvqy/2IIRF0gqw/ukcsi
         t7jKy3kfiTtU/nylPODpbDn9eeNHq5oWUyJS7LIzOoBtejjKbsbRy8/XyAQ0zMLehA96
         Z0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715325293; x=1715930093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKl1sJKw/UsKDzy8KNhNK1sYyMGjgorHopo+1odx4UQ=;
        b=DoTSl/pSeOVNM8DpgBtFxgMqrlnGsoJ+Ps5eqBqTn8WOafMLmfOvCq4IfiWMAjA0pY
         75uOI2J/g0Ij8O43abIDGzkxx/Vau47VbsBh1iRDg+KzomySSDAnBR1qpfESGSEU2fyW
         1Hu0Sa2FkFyPpJnFBzfHJNN2oqAzeii8bWPo5B/DOKDit/ghcrrRykw0KjFf4VCgCj0b
         7OTCHy5Wr2+t1qZXVi2IZqVfb07DodPms0Jp+nvyxwnI5r9ILgahKvg5zUtPHHe4jqIM
         n3VBCZ8RRZ/TsAzxYT0pfWCfiZZfL+tn5VJL6x0JlQZ1s9vp22fRFQa2o3fAbCfjuBKr
         Koog==
X-Forwarded-Encrypted: i=1; AJvYcCVbfqZQkpJXeP2ujayGPrZr3vyRPQ0jpj66rU7y1pN345uvPxFjFdd1iSCZ4fsfwX9O62usVZoQgzqWdXhALsXX0G17MXXZwWev0YUX
X-Gm-Message-State: AOJu0YzCHT8Y5zj9aETa/bpIcaCfF70x/BZ3ZuAoKprYmMl7eGt9mozg
	jxtDDZ7Y+avsEfJJ2g2TN1winc0vvyrCCJ+KmTFqOAeXu1fFOze/
X-Google-Smtp-Source: AGHT+IFLklw0VPt+U78fsumXcfh6TZru62wWQcHPZt+ZTPkp5rl/p4PAe0H9zRH2ix3RbFqgeJpgHg==
X-Received: by 2002:a05:6a00:1911:b0:6f4:1799:c70c with SMTP id d2e1a72fcca58-6f4e02aa518mr1645479b3a.9.1715325293048;
        Fri, 10 May 2024 00:14:53 -0700 (PDT)
Received: from kousik.local ([2405:201:c01a:90f4:8de5:a651:7145:5260])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a37sm2344475b3a.161.2024.05.10.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:14:52 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH 1/3] soc: ti: pruss: do device_node auto cleanup
Date: Fri, 10 May 2024 12:43:22 +0530
Message-ID: <20240510071432.62913-2-five231003@gmail.com>
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
simplifying the handling of error paths at various places.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/pruss.c | 48 ++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 24a42e0b645c..8f238d59eca9 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -381,13 +381,13 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 {
 	const struct pruss_private_data *data;
-	struct device_node *clks_np;
 	struct device *dev = pruss->dev;
 	int ret = 0;
 
 	data = of_device_get_match_data(dev);
 
-	clks_np = of_get_child_by_name(cfg_node, "clocks");
+	struct device_node *clks_np __free(device_node) =
+			of_get_child_by_name(cfg_node, "clocks");
 	if (!clks_np) {
 		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
 		return -ENODEV;
@@ -398,7 +398,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 					  "coreclk-mux", clks_np);
 		if (ret) {
 			dev_err(dev, "failed to setup coreclk-mux\n");
-			goto put_clks_node;
+			return ret;
 		}
 	}
 
@@ -406,13 +406,10 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 				  clks_np);
 	if (ret) {
 		dev_err(dev, "failed to setup iepclk-mux\n");
-		goto put_clks_node;
+		return ret;
 	}
 
-put_clks_node:
-	of_node_put(clks_np);
-
-	return ret;
+	return 0;
 }
 
 static struct regmap_config regmap_conf = {
@@ -424,26 +421,22 @@ static struct regmap_config regmap_conf = {
 static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
 {
 	struct device_node *np = dev_of_node(dev);
-	struct device_node *child;
+	struct device_node *child __free(device_node) =
+			of_get_child_by_name(np, "cfg");
 	struct resource res;
 	int ret;
 
-	child = of_get_child_by_name(np, "cfg");
 	if (!child) {
 		dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
 		return -ENODEV;
 	}
 
-	if (of_address_to_resource(child, 0, &res)) {
-		ret = -ENOMEM;
-		goto node_put;
-	}
+	if (of_address_to_resource(child, 0, &res))
+		return -ENOMEM;
 
 	pruss->cfg_base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (!pruss->cfg_base) {
-		ret = -ENOMEM;
-		goto node_put;
-	}
+	if (!pruss->cfg_base)
+		return -ENOMEM;
 
 	regmap_conf.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", child,
 				     (u64)res.start);
@@ -455,16 +448,13 @@ static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
 	if (IS_ERR(pruss->cfg_regmap)) {
 		dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
 			PTR_ERR(pruss->cfg_regmap));
-		ret = PTR_ERR(pruss->cfg_regmap);
-		goto node_put;
+		return PTR_ERR(pruss->cfg_regmap);
 	}
 
 	ret = pruss_clk_init(pruss, child);
 	if (ret)
 		dev_err(dev, "pruss_clk_init failed, ret = %d\n", ret);
 
-node_put:
-	of_node_put(child);
 	return ret;
 }
 
@@ -472,7 +462,6 @@ static int pruss_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev_of_node(dev);
-	struct device_node *child;
 	struct pruss *pruss;
 	struct resource res;
 	int ret, i, index;
@@ -494,7 +483,8 @@ static int pruss_probe(struct platform_device *pdev)
 	pruss->dev = dev;
 	mutex_init(&pruss->lock);
 
-	child = of_get_child_by_name(np, "memories");
+	struct device_node *child __free(device_node) =
+			of_get_child_by_name(np, "memories");
 	if (!child) {
 		dev_err(dev, "%pOF is missing its 'memories' node\n", child);
 		return -ENODEV;
@@ -510,22 +500,17 @@ static int pruss_probe(struct platform_device *pdev)
 
 		index = of_property_match_string(child, "reg-names",
 						 mem_names[i]);
-		if (index < 0) {
-			of_node_put(child);
+		if (index < 0)
 			return index;
-		}
 
-		if (of_address_to_resource(child, index, &res)) {
-			of_node_put(child);
+		if (of_address_to_resource(child, index, &res))
 			return -EINVAL;
-		}
 
 		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
 							resource_size(&res));
 		if (!pruss->mem_regions[i].va) {
 			dev_err(dev, "failed to parse and map memory resource %d %s\n",
 				i, mem_names[i]);
-			of_node_put(child);
 			return -ENOMEM;
 		}
 		pruss->mem_regions[i].pa = res.start;
@@ -535,7 +520,6 @@ static int pruss_probe(struct platform_device *pdev)
 			mem_names[i], &pruss->mem_regions[i].pa,
 			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
 	}
-	of_node_put(child);
 
 	platform_set_drvdata(pdev, pruss);
 
-- 
2.45.0.rc1.8.ge326e52010


