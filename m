Return-Path: <linux-kernel+bounces-243476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC39296BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2061C20E7A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609F8F6D;
	Sun,  7 Jul 2024 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnAGuIEw"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8644D53B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331646; cv=none; b=I8w6jQNC4aMUr+3fidrj0NQa22SH5gCPX6EsVl5ca8357IpdTYONRu/7ghvy+aoSPNyokgr4Gldj4iIelyZ3ofryGXSghxNiAGNkMn/0kj3ardtyJz9XeafS6K02qyVnXWBWtuQQilxIh8OPqATzM/laWfvKRPpN522pCmLzrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331646; c=relaxed/simple;
	bh=qPFTc3FO5hdRbWD/xpZXkA2hnMsn8o0ImHjlbGM0Pyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS95NSA5bSTvH0C6d0s8qXmZsE8AJdmrNcnRIdQajVEPQBm3LfqcueHCizX+kAv1JAEpcCz1fggYSk5tW6jw+iZ1eg6QSHEhaR/popHhRXLnuIY/MPRGwg23MeLQ6XAzBlSuZiew/hhUku2jjrFOIE4ii7G7zUE5Mq7VMS0PLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnAGuIEw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b29539d87so25593437b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 22:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720331644; x=1720936444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AFnd+VA8Z38aedFSnDQhJz5LXWpxu4cJVkL+MlMwtg=;
        b=XnAGuIEwgvpcT70cDrSFyrv+p8SkpcDny8P6BEWqeK07w4Vs6CU72fQFPXREmxYz5I
         o/mJa7D+qqb4x35PAf2EYA7NFsb/HKX1GHbXt6VKhtXJxyusoAd9q/d3pN7zZiFcqCtW
         SRzVWXS1tSFCTLH864oJ1qboc501syT3a1YU4lAPplOkhJD+X751ACcdTgXAciBdi092
         8TPOWzZtrMIuQOLI8BsfISJlX0u5frLnA9b9CmcvRTJZBmwK0ek5+GnhNRbYrfTJWDLS
         1rD//eKL/4Xo2XvoLBYEJ0Orp1snLUrh3i7k40Qz773SKbidGkfdntemp4ZmOWBmBr2l
         86fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720331644; x=1720936444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AFnd+VA8Z38aedFSnDQhJz5LXWpxu4cJVkL+MlMwtg=;
        b=mjLmB5yTHwejvaalvuGsdEE4MupjV4mYjHbmavRTPh6NIlrV1vKtFL6BMX6eLdy9yq
         L00QaK41HV3bcqdJzi0Hn8Fi/UUceawOdcDO1ctVsmGG9V+n1rv9FecN/jRvuMRBAFsn
         JGDfslTKGQKImQ5W/rcT/6lgZ/qI7cG8iZ9zYYr1gjVXt7tbcUjtxa1hNmk99DqXrhZN
         TMt9aBwlMiDvWPypAh4FgY9sGHJ80n1gZCaJRyXA1/Xpp75a5rDMdGR4wItxSzRMmodm
         Vr88if+m72iCJGfHQfvDDVYz99ecYEDm6HCWbfY1qJ4qG5TRQDvp80qEUrBel1pN+4lz
         93YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLpEekKShcZApvzsOvV73DS0TconvfTbtsG3hA4kbtQFY82OAc1+YsvN5bY8+7fwDS0RwIrHacfdDAb51/Ar8h5VN8FxUqYcY23vtf
X-Gm-Message-State: AOJu0YzPeumR4UiCfy3kIdNFFF39y3Ep5waUSMlm7MKMpfNGgcFBYmgb
	73PInlBCXeEvzIR1O6mryB5nXMro9b2+3MuZRz8AVY9lRrstDGZ8
X-Google-Smtp-Source: AGHT+IEM8rXNId+q2iXUTZrQl0UTkENIr3G4q3CoYS4vqe0FwmaON3MklvnPUYn/y1DOmJ4MEAs5FQ==
X-Received: by 2002:a05:690c:986:b0:63b:d711:f06d with SMTP id 00721157ae682-652d7b5c8d9mr79208147b3.33.1720331643688;
        Sat, 06 Jul 2024 22:54:03 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:252d:94b8:b79c:d7bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2e5fe3dfsm94429b3a.97.2024.07.06.22.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 22:54:03 -0700 (PDT)
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
Subject: [PATCH v3 1/4] soc: ti: pruss: factor out memories setup
Date: Sun,  7 Jul 2024 10:44:16 +0530
Message-ID: <20240707055341.3656-2-five231003@gmail.com>
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

Factor out memories setup code from probe() into a new function
pruss_of_setup_memories().  This sets the stage for introducing auto
cleanup of the device node (done in the subsequent patch), since the
clean up depends on the scope of the pointer and factoring out
code into a seperate function obviously limits the scope of the various
variables used in that function.

Apart from the above, this change also has the advantage of making the
code look more neat.

While at it, use dev_err_probe() instead of plain dev_err() as this new
function is called by the probe().

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/soc/ti/pruss.c | 111 ++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 50 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 24a42e0b645c..a3c55a291b0b 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -415,6 +415,63 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 	return ret;
 }
 
+static int pruss_of_setup_memories(struct device *dev, struct pruss *pruss)
+{
+	struct device_node *np = dev_of_node(dev);
+	struct device_node *child;
+	const struct pruss_private_data *data = of_device_get_match_data(dev);
+	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
+	int i;
+
+	child = of_get_child_by_name(np, "memories");
+	if (!child)
+		return dev_err_probe(dev, -ENODEV,
+				     "%pOF is missing its 'memories' node\n",
+				     child);
+
+	for (i = 0; i < PRUSS_MEM_MAX; i++) {
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
+		if (index < 0) {
+			of_node_put(child);
+			return index;
+		}
+
+		if (of_address_to_resource(child, index, &res)) {
+			of_node_put(child);
+			return -EINVAL;
+		}
+
+		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
+							resource_size(&res));
+		if (!pruss->mem_regions[i].va) {
+			of_node_put(child);
+			return dev_err_probe(dev, -ENOMEM,
+					     "failed to parse and map memory resource %d %s\n",
+					     i, mem_names[i]);
+		}
+		pruss->mem_regions[i].pa = res.start;
+		pruss->mem_regions[i].size = resource_size(&res);
+
+		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %pK\n",
+			mem_names[i], &pruss->mem_regions[i].pa,
+			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
+	}
+	of_node_put(child);
+
+	return 0;
+}
+
 static struct regmap_config regmap_conf = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -471,15 +528,8 @@ static int pruss_cfg_of_init(struct device *dev, struct pruss *pruss)
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
@@ -494,48 +544,9 @@ static int pruss_probe(struct platform_device *pdev)
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


