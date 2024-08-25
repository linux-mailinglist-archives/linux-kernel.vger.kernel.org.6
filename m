Return-Path: <linux-kernel+bounces-300362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7095E2CE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9801C2138C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE7757E0;
	Sun, 25 Aug 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKzZ1Lee"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1177119
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576265; cv=none; b=rJ+volB/35zE/SNm/dDptdji8hvZz7N6OGQ0vU0Jwz0BjphxKdGUbTNhVTR7BXTdxYqYionOpfzqAFTra6+WDSAeh2y9kj+jSKnN8xr/3jVw17m5H3oyBRTWpSemgj6+lTPIEfckzTrBW7Cx3arnXqVF/rfuw9gEavYkzpQAlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576265; c=relaxed/simple;
	bh=67/Xozd18Ej9k8mZ00J+8j3/xv7WWXoGpKJcxBLrG2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvGesFNkZDfiGsWmMosygqnJMMDTBi6pUJAnu9QNXyOdG/n/YnLET6rSSwKqkSuJwaQ07MapQZuRn5rt5RzHOiwD1W2Q6pL+E4kkkGMrrEkh3KPNsC7pV0d6bERCXwfSpLgncIFPdJkSlV31G0+kgJhb/8bZLHTuI6zwSKo/cX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKzZ1Lee; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5e97b8adbso2902022eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724576263; x=1725181063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNMuyrfijznIh50InJIHyOaHM84gPkC0aoCc4qU4CQ4=;
        b=ZKzZ1Lee9BdGoPcdhW3sXk2UGrsARciML8Kici79KF5DuboffLz7WU6SSy+hN7LzdR
         +cuWZdb9CPvijv+ugugacXXhFMKPLCV1BjzygyXZ4wu9VQkuWXF7HCkNi32UPlbLDeif
         RVPTcIxB0mgm5fTYqc8fj3cwzmo+N+cflGRtOA0W3UqpWxJ0B5IGMHKsjsaLw5f//Yvt
         13beL90LJLQ6JQHP0r7hJKlOa5jSxDgmZjHiErd6OaJQxUyGtUcqqVCjA54aCOplpOOa
         xespI5iPQVlbWRyTE5XEVWpLwU6seYNffS0x9G64/76r5KNoG6Tv/UMY3tBuTAOqkuFf
         Iaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576263; x=1725181063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNMuyrfijznIh50InJIHyOaHM84gPkC0aoCc4qU4CQ4=;
        b=GtVeQ+//HStjf3Wk4XppxB7na5nVEBFB/EeMeh0Ybiq6AGsrnHwcoKFMDvBGKM3VXU
         b1kk/VEJli6cccfmUdCV3whjeohUua4qLNLgS4Z9NjHPJQdRXWCzNNSw5g05ZwElgRm/
         iH78oZLNnjzSp6QJRih82TtM6lh1S7z1BUCquwGl6uRkWgfgELRPN98buRZTZb4nx3sV
         dNOmHD4hSJGau2Zr75YRY1vLnLCbEIKIZoMdbupbB8QmY3YYB6PAhMc48I4CqdQx8FLT
         uq9jIziqLobQmpdiK2xl9XVqsxz1/WbbK2qjQVZfWR6LSdIZRk1L05ZKeI0tzTppXG/h
         v32Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi43XXLWdBRz6OpG/SAOrWHrRBFNaajx3t9yW7a/Dbv7xtqCD3lpZSEc6oUAfgjoo2UB+sy8yTh9f6O5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPRxF7oIxpSolMhK3y280yDFqs9p+d0GOvs3+XtovKDPoarAP
	6IwLVREWeNmnUWahbIrnFKSicqRTVoU5CpDZNyMR/ldD9vEq9dzH
X-Google-Smtp-Source: AGHT+IGpYva06f1FOiHhlRMbZ9nmuMmHEPsYHgf5mxg8wBqak1kBhd2jWqR4HEB5jI0I/wBjcbP2AQ==
X-Received: by 2002:a05:6358:5f02:b0:1b3:8960:986f with SMTP id e5c5f4694b2df-1b5c3b0fab6mr797160855d.19.1724576263352;
        Sun, 25 Aug 2024 01:57:43 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:b871:d8f1:d936:dc0c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143425109asm5414348b3a.67.2024.08.25.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 01:57:43 -0700 (PDT)
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
Subject: [PATCH v4 2/4] soc: ti: pruss: do device_node auto cleanup
Date: Sun, 25 Aug 2024 14:18:43 +0530
Message-ID: <20240825085714.10736-3-five231003@gmail.com>
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
simplifying the handling of error paths at various places.

While at it, use dev_err_probe() instead of dev_err() in all the code
paths touched.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/pruss.c | 91 +++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 58 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 83d7d8d5ef22..3ec758f50e24 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -380,50 +380,42 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 
 static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 {
-	const struct pruss_private_data *data;
-	struct device_node *clks_np;
 	struct device *dev = pruss->dev;
-	int ret = 0;
-
-	data = of_device_get_match_data(dev);
+	struct device_node *clks_np __free(device_node) =
+			of_get_child_by_name(cfg_node, "clocks");
+	const struct pruss_private_data *data = of_device_get_match_data(dev);
+	int ret;
 
-	clks_np = of_get_child_by_name(cfg_node, "clocks");
-	if (!clks_np) {
-		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
-		return -ENODEV;
-	}
+	if (!clks_np)
+		return dev_err_probe(dev, -ENODEV,
+				     "%pOF is missing its 'clocks' node\n",
+				     cfg_node);
 
 	if (data && data->has_core_mux_clock) {
 		ret = pruss_clk_mux_setup(pruss, pruss->core_clk_mux,
 					  "coreclk-mux", clks_np);
-		if (ret) {
-			dev_err(dev, "failed to setup coreclk-mux\n");
-			goto put_clks_node;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup coreclk-mux\n");
 	}
 
 	ret = pruss_clk_mux_setup(pruss, pruss->iep_clk_mux, "iepclk-mux",
 				  clks_np);
-	if (ret) {
-		dev_err(dev, "failed to setup iepclk-mux\n");
-		goto put_clks_node;
-	}
-
-put_clks_node:
-	of_node_put(clks_np);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup iepclk-mux\n");
 
-	return ret;
+	return 0;
 }
 
 static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
 {
 	struct device_node *np = dev_of_node(dev);
-	struct device_node *child;
+	struct device_node *child __free(device_node) =
+			of_get_child_by_name(np, "memories");
 	const struct pruss_private_data *data = of_device_get_match_data(dev);
 	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
 	int i;
 
-	child = of_get_child_by_name(np, "memories");
 	if (!child)
 		return dev_err_probe(dev, -ENODEV,
 				     "%pOF is missing its 'memories' node\n",
@@ -442,24 +434,18 @@ static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
 
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
-		if (!pruss->mem_regions[i].va) {
-			of_node_put(child);
+		if (!pruss->mem_regions[i].va)
 			return dev_err_probe(dev, -ENOMEM,
 					     "failed to parse and map memory resource %d %s\n",
 					     i, mem_names[i]);
-		}
 		pruss->mem_regions[i].pa = res.start;
 		pruss->mem_regions[i].size = resource_size(&res);
 
@@ -467,7 +453,6 @@ static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
 			mem_names[i], &pruss->mem_regions[i].pa,
 			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
 	}
-	of_node_put(child);
 
 	return 0;
 }
@@ -481,26 +466,21 @@ static struct regmap_config regmap_conf = {
 static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
 {
 	struct device_node *np = dev_of_node(dev);
-	struct device_node *child;
+	struct device_node *child __free(device_node) =
+			of_get_child_by_name(np, "cfg");
 	struct resource res;
 	int ret;
 
-	child = of_get_child_by_name(np, "cfg");
-	if (!child) {
-		dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
-		return -ENODEV;
-	}
+	if (!child)
+		return dev_err_probe(dev, -ENODEV,
+				     "%pOF is missing its 'cfg' node\n", child);
 
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
@@ -509,20 +489,15 @@ static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
 	pruss->cfg_regmap = devm_regmap_init_mmio(dev, pruss->cfg_base,
 						  &regmap_conf);
 	kfree(regmap_conf.name);
-	if (IS_ERR(pruss->cfg_regmap)) {
-		dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
-			PTR_ERR(pruss->cfg_regmap));
-		ret = PTR_ERR(pruss->cfg_regmap);
-		goto node_put;
-	}
+	if (IS_ERR(pruss->cfg_regmap))
+		return dev_err_probe(dev, PTR_ERR(pruss->cfg_regmap),
+				     "regmap_init_mmio failed for cfg\n");
 
 	ret = pruss_clk_init(pruss, child);
 	if (ret)
-		dev_err(dev, "pruss_clk_init failed, ret = %d\n", ret);
+		return dev_err_probe(dev, ret, "pruss_clk_init failed\n");
 
-node_put:
-	of_node_put(child);
-	return ret;
+	return 0;
 }
 
 static int pruss_probe(struct platform_device *pdev)
-- 
2.46.0.290.g4f02c709e8.dirty


