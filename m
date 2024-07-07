Return-Path: <linux-kernel+bounces-243477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17E9296BE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4931C20B9A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2FB653;
	Sun,  7 Jul 2024 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg68b9uX"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9A10A0A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331652; cv=none; b=ru7U1H1+pnFl/oabV/Qm1GnjFU+N5LIj2uT2cXCEzwhuWPLvDRIyEprvsQr/CLcBsv0RAOz4ZFaEUcCexpcxZPDII3q0yUQ81B/G0XmdIc8g/T8PlVnXmG75UJjrj+wHYOHcHRdpMcPgwSIBcaytHyUF9VZx98uzvtLRZMk5918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331652; c=relaxed/simple;
	bh=L6kGp0yQ/1I5sbHd1feIDteukGCJQBEVDTYbRX9lmmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoQCUS5gYtNNN6uStJajTi1LLrDTkA3gEw9wcWRB+LS+OuxxIstbu/YSI7yRxKS8hNreRdgNXvk912FdvZfVqkpLZAfenYJFJ7b6SCDmUbvVQnrp3i+HK+02ZuVG4bfNXo6VUJz+yG8o1AWFm/XI6QJDvUswXFbNCx0rltv+PHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg68b9uX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so194564b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720331650; x=1720936450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ao/bHiRilB5S2e2EOSdMSTC1iVfP4AjXJyo+t6sd4=;
        b=Cg68b9uXdCBXoiZDDsatrgEsAtF9p0YrLzCt0T+0hFJK7NqY82JLbcKErIC/hrFHjP
         vqZPvfMtX5QOgyeCFTCl1gvC715FOsmXjzhdDF8TvZxYPoeLsFyoraklKizJW237O9Jj
         9aQAjUUD7cgWJAIT5uw4PNS5YHgc667r5Vzbe67ikyFRyuJ3erO/7wZH2ufo6ua7BcFl
         l/yc2wo45fIT5kr8pL5OEHYmLar0l+hge5lovEDXOB9VDaNDNZPrhSmlrcsmfmCEz2c4
         cuRMVjmBVOt00F0q+7bXTRpYBsIrY4jJuOlOWz9SmvJIg8rw1kMKSIEOn/Mv/Nbku99T
         nafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720331650; x=1720936450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ao/bHiRilB5S2e2EOSdMSTC1iVfP4AjXJyo+t6sd4=;
        b=NlGtEBJp9G9LVS29/GL9jd/GkRpqwH1MROCfY2NRGosux4v3ZUR7cQELj8NFTDWNXD
         Vp9HDJspnh4vO9b3xIjDI9BM72J6GpMDB8/eFJhwbV7b6F5NVlO8x6tDjzP6CtQOHRgU
         VUvq2avweoYGe2/IxpD9DF9EqpViLnd5m4kV7jmHRlUECf8GmLrBcAQIs+9lFdd5EEXM
         ItbVkD09QeU4ZLk697vJnlA0MLHyw6QdlrNfzhbmkDDY7jHuJgt2hOgwBZgPnVja5ZCK
         OmhtKmB9ZLaqlXyqSH3iRl0adx7zBbR7T7S6ZdCseTBnaMJeE2qg3iexYDNYfcsmrkn9
         aMaA==
X-Forwarded-Encrypted: i=1; AJvYcCWCloM1ykEY5jm7dGcJq1APmwnHiC+bPKOBnc7SMZAlpX/iCUQc/Uht+bdjXljSLSG82kL96DoaAwG24NeTfbQsajwJj1n78WZq0wqs
X-Gm-Message-State: AOJu0YzFlJS4yrP12BdIrZmPlvfMrYuZpWNVBhTssaHqJ/qr6CQy/xMO
	pmtd1pHVk5pjRQJGKxIBgGL0eAkDUKG2kCISmZffKuRxyAPHY5aB
X-Google-Smtp-Source: AGHT+IGG7pp0NWsGPjDUHxaPtmH314w9l9YdSMp2LYg0SS7OJEi0aKYm9s3XK1kO6NxeK/Uks5f+5Q==
X-Received: by 2002:a05:6a00:2ea6:b0:70b:2589:3a55 with SMTP id d2e1a72fcca58-70b25893db3mr2139078b3a.32.1720331649578;
        Sat, 06 Jul 2024 22:54:09 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:252d:94b8:b79c:d7bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2e5fe3dfsm94429b3a.97.2024.07.06.22.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 22:54:09 -0700 (PDT)
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
Subject: [PATCH v3 2/4] soc: ti: pruss: do device_node auto cleanup
Date: Sun,  7 Jul 2024 10:44:17 +0530
Message-ID: <20240707055341.3656-3-five231003@gmail.com>
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
simplifying the handling of error paths at various places.

While at it, use dev_err_probe() instead of dev_err() in all the code
paths touched.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/pruss.c | 91 +++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 58 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index a3c55a291b0b..a01eabb0ca26 100644
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
2.45.2.561.g66ac6e4bcd


