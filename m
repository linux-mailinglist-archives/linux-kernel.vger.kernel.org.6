Return-Path: <linux-kernel+bounces-238965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CB925441
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6687A283133
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8EC13440A;
	Wed,  3 Jul 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVEO/jz9"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281A45025
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989892; cv=none; b=nD+djapCJgyzpd62ykGBZ3k6dJmRQHLJIbTHaJ+CQpTHg4mGvJWNTkzWWXYwCshhN+zaAeeZXkC9P9v1D8DItAMa5SIS99IQTVUQWue00uJMuqoUXcUNCwRzEQ/UwCJGqSYF9CgBZ7X8HKUHnaL2B4R8GADnYWnQv7DsNb32q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989892; c=relaxed/simple;
	bh=Aat+8U0Q3IJAuf5l3+vmrAyh7Zy59LxP/ajakTChWQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YawFq5CzdWkd2o/zMRw+r2gz3Sp+vpQJslm6BoarBEe/fErOPKPd4j9vubLDagQrol9QYexffDZhgRuLv1EYrjYzE4hFBajzcD2hmNVDxGT7bMcpmzlcMrxE+VegQqYjuDND46Th8o8SAgeaoo3ZUlVuuEJHu7licC02VPIv0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVEO/jz9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7449fbfeb6bso2057167a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719989890; x=1720594690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5IB8/nq6DlwhVNyviTWwBZ2x7h3P9W/CW2Qn6PLl7I=;
        b=PVEO/jz96KjYk3ECqRk8aBFVUi2apJupGsI/KoyBIloqKDS+zdAJzvETVs7ajy85Tl
         zlFVXdscjzYGWhkNT5wL1eMit+QeFJ1oankhYXzDrIy+09Fc1XiQJG6az27C14WxWhLd
         mHEJ+am5z/ianU3BMQWwfi5HR6k62IOB4z/zAMsdtABtVbB7KeRkbg46ZqAuONHIIact
         oZfESiJJ3DRRJ27PI8MvL8QtWKCRetr0j3PTMGapjFOZicjTYUq0arAOW1i/jlSh7gNj
         R0Ikff1qLz8H2/N7fhBdedxoZacsWMll6/9BdIw48zQyeFEGoC/Htc/oU7+cThQ9e4h8
         JUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719989890; x=1720594690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5IB8/nq6DlwhVNyviTWwBZ2x7h3P9W/CW2Qn6PLl7I=;
        b=X6OqgvUeWQ6UMv3auQb3WJ7CAR+0CKhgZKLs+WWlkB0uyAynStb8UOKN4zmR7nzuLG
         8n0k92ro+ykFqlJjulD6HHcPAbWgqOssr0SrJd8+DPscS1h1/B/lpE5xFStVlZbZTG+F
         n+SzF3fjdpaCeePtCm4XeVlkbZKM9gM6mkvOg/66K8Y6mr7hrBVJV+iritbHYPqdrKXQ
         urcJsjTjNrvYFgQh3o4E0kMJdqIQ1vjnoaJVWtoDtFtqdj78Qb6GtdGvMbSoReG/59le
         FFdNpWTqO+JClk5YSZX7LrjcNbtHtp1EOz5hI58/EZbaPpy3AfbdWZWUlSO9NwATn4Vl
         BOJw==
X-Forwarded-Encrypted: i=1; AJvYcCXUVhzOJU/uFdOEFxjfeRacrBfI+UQHQ45A+YEX3XgN8ygVloBSUPrvDh6Nr4Ue7DhMxAr5S23MH4oO/ma06ePXDXQJXDxiwvyxBL05
X-Gm-Message-State: AOJu0YznpKbvH6nvfEKhhh7ROi2yao8QO0kZ9pvxWb/r28V8FhhpVIkU
	PkpVCNV/hhHwkNXqjfue39+fcG1QTEnLA04248sZm6NA2Wg5SV73
X-Google-Smtp-Source: AGHT+IEY3rUCcx/kslsTq7Tjv7pevyUVOb+O1uxfTVwJ9nsCAKEHnyQPyUnwCmSJchrtKSBAnmdQ0A==
X-Received: by 2002:a05:6a20:244c:b0:1be:c5c8:d1e2 with SMTP id adf61e73a8af0-1bef6198ccamr12807732637.35.1719989889627;
        Tue, 02 Jul 2024 23:58:09 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:258c:c06c:76e7:dba9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e818asm9973921a91.51.2024.07.02.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 23:58:09 -0700 (PDT)
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
Subject: [PATCH v2 1/3] soc: ti: pruss: do device_node auto cleanup
Date: Wed,  3 Jul 2024 12:25:26 +0530
Message-ID: <20240703065710.13786-2-five231003@gmail.com>
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
simplifying the handling of error paths at various places.

While at it, refactor the setup code for device node "memories", from
pruss_probe() into a new function pruss_of_setup_memories().  It is
worth noticing that this step is a direct consequence of trying to
minimize the scope of the "struct device_node" pointer to make auto
cleanup read more cleanly.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/pruss.c | 168 +++++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 90 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 24a42e0b645c..9767d129a8ea 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -381,38 +381,82 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 {
 	const struct pruss_private_data *data;
-	struct device_node *clks_np;
 	struct device *dev = pruss->dev;
 	int ret = 0;
 
 	data = of_device_get_match_data(dev);
 
-	clks_np = of_get_child_by_name(cfg_node, "clocks");
-	if (!clks_np) {
-		dev_err(dev, "%pOF is missing its 'clocks' node\n", cfg_node);
-		return -ENODEV;
-	}
+	struct device_node *clks_np __free(device_node) =
+			of_get_child_by_name(cfg_node, "clocks");
+	if (!clks_np)
+		return dev_err_probe(dev, -ENODEV,
+				     "%pOF is missing its 'clocks' node\n", cfg_node);
 
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
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup iepclk-mux\n");
 
-put_clks_node:
-	of_node_put(clks_np);
+	return 0;
+}
 
-	return ret;
+static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
+{
+	struct device_node *np = dev_of_node(dev);
+	struct device_node *child __free(device_node) =
+			of_get_child_by_name(np, "memories");
+	int i;
+
+	if (!child)
+		return dev_err_probe(dev, -ENODEV,
+				     "%pOF is missing its 'memories' node\n",
+				     child);
+
+	for (i = 0; i < PRUSS_MEM_MAX; i++) {
+		const struct pruss_private_data *data =
+				of_device_get_match_data(dev);
+		const char *mem_names[PRUSS_MEM_MAX] =
+				{ "dram0", "dram1", "shrdram2" };
+		struct resource res;
+		int index;
+
+		/*
+		 * On AM437x one of two PRUSS units don't contain Shared RAM,
+		 * skip it
+		 */
+		if (data && data->has_no_sharedram && i == PRUSS_MEM_SHRD_RAM2)
+			continue;
+
+		index = of_property_match_string(child, "reg-names",
+						 mem_names[i]);
+		if (index < 0)
+			return index;
+
+		if (of_address_to_resource(child, index, &res))
+			return -EINVAL;
+
+		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
+							resource_size(&res));
+		if (!pruss->mem_regions[i].va)
+			return dev_err_probe(dev, -ENOMEM,
+					     "failed to parse and map memory resource %d %s\n",
+					     i, mem_names[i]);
+		pruss->mem_regions[i].pa = res.start;
+		pruss->mem_regions[i].size = resource_size(&res);
+
+		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
+			mem_names[i], &pruss->mem_regions[i].pa,
+			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
+	}
+	return 0;
 }
 
 static struct regmap_config regmap_conf = {
@@ -424,26 +468,21 @@ static struct regmap_config regmap_conf = {
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
@@ -452,34 +491,22 @@ static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
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
 	return ret;
 }
 
 static int pruss_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev_of_node(dev);
-	struct device_node *child;
 	struct pruss *pruss;
-	struct resource res;
-	int ret, i, index;
-	const struct pruss_private_data *data;
-	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
-
-	data = of_device_get_match_data(&pdev->dev);
+	int ret;
 
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -494,48 +521,9 @@ static int pruss_probe(struct platform_device *pdev)
 	pruss->dev = dev;
 	mutex_init(&pruss->lock);
 
-	child = of_get_child_by_name(np, "memories");
-	if (!child) {
-		dev_err(dev, "%pOF is missing its 'memories' node\n", child);
-		return -ENODEV;
-	}
-
-	for (i = 0; i < PRUSS_MEM_MAX; i++) {
-		/*
-		 * On AM437x one of two PRUSS units don't contain Shared RAM,
-		 * skip it
-		 */
-		if (data && data->has_no_sharedram && i == PRUSS_MEM_SHRD_RAM2)
-			continue;
-
-		index = of_property_match_string(child, "reg-names",
-						 mem_names[i]);
-		if (index < 0) {
-			of_node_put(child);
-			return index;
-		}
-
-		if (of_address_to_resource(child, index, &res)) {
-			of_node_put(child);
-			return -EINVAL;
-		}
-
-		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
-							resource_size(&res));
-		if (!pruss->mem_regions[i].va) {
-			dev_err(dev, "failed to parse and map memory resource %d %s\n",
-				i, mem_names[i]);
-			of_node_put(child);
-			return -ENOMEM;
-		}
-		pruss->mem_regions[i].pa = res.start;
-		pruss->mem_regions[i].size = resource_size(&res);
-
-		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
-			mem_names[i], &pruss->mem_regions[i].pa,
-			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
-	}
-	of_node_put(child);
+	ret = pruss_of_setup_memories(dev, pruss);
+	if (ret < 0)
+		goto rpm_put;
 
 	platform_set_drvdata(pdev, pruss);
 
-- 
2.45.2.561.g66ac6e4bcd


