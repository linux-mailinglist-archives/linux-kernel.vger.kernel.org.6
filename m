Return-Path: <linux-kernel+bounces-300361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DCB95E2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F8B2822A4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17A6F2E0;
	Sun, 25 Aug 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPd5LvPw"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E14776E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576260; cv=none; b=OOJsaUQop7vPEg/r7BRKCwSgTQTDkieqAWrSs2FMkrBhudbH6IhmwYNGZbfSM6ZUHWivKvYINHking9ztiFh4aFxuqfaw2Vl4Rj+9i3dK/+3jj2KVVVDkTt8ox8mzD8YkKDu6apE1U3nY09AUgxiGZ/gLZ0lf7EtkcOU2ZxHo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576260; c=relaxed/simple;
	bh=L/mXP7Xn6MZBVQiLfifg1NGi/ykpTasI9JOSZKAvRdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7I3vi2y5fvl62IMcmzqnMg3u8l2k4pOieKMY/Gr2N4yF6qwitRRr64u+mQI6oUCnreej0+oDjXDxUb29cO1U26NCqeMJCjU9/HPLGmNlHAXdf9Pm2KfOW40WtQ8hARXZ8ADWy43FmmEJGhgoaQkuGgvglOYytYA8StJQbg1UZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPd5LvPw; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5de8389e77cso693198eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724576258; x=1725181058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/vK+T10MZyl0kQgej4VXi53+tf/ED+iZjgN4kOLleI=;
        b=DPd5LvPw870KThAHL5sTjLJ9fCzpIAa5GvPjgxkJxN1EPRsROibhZ1kk3TQHADkpr/
         F3uqxGFHgPOIdXaFKpBmTFBOOUee8B8xre9ucQ9XWLHHwFzYjvLUAmCgidFVLEclGSMF
         MoVnH7HK7AzL6gOrj8nX0JiqCCYRvToRytPuicXd6Wt2c7cEZ+SqiYTswA0dCoxabwB2
         mlt+5grEBWKgGN2ab3bTIfM6cnfxyYYTIaHmnmoKqY4UHhbKECKU/GSi4WJ0RsxwZDrB
         59RYxqvCvMd97EDa2x/xTznorfIdk3v7wxH1LM0lxPwbphzlt++knpBXVq6xj2s4JUnS
         9fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576258; x=1725181058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/vK+T10MZyl0kQgej4VXi53+tf/ED+iZjgN4kOLleI=;
        b=qIZKkkmOtlEjzzTTRw9UMl0bfh7HXezpUt74NUYPqZB/KEZOlMyYknUrVQG250wv5g
         saD4PV61VzIuvEtnQ58pzMLinysTHJjy0jTPG5jaA8w1nbOs4GyX9uPJd/N3Y1FV+pNZ
         Cqb4U0Wxbh2bSjxir8i3dp3K0hMlJbKG1cR/F8TjfuxjqptvlSuoupkbsq+Jtz8y2f1v
         xAlWXKMP/obWumMsIeWAFQmUAJ8LpGtkQd94NXm/0vBm8cV58qqiXPI8wqjFGITxJVV4
         KQ4u9F/7u5YxXEbr/ZNSyxCRhHEXQ7hQvFkoGxjimfYTGwDOAkj0wJhZJkFOejs/ILRw
         tT8A==
X-Forwarded-Encrypted: i=1; AJvYcCXBnnQ0tBNM/1qzoCTMiwvoGAQPPjAjrGbDnpAq+c09q2EzLZ4kpOcANGswt25qdelT50Viv4KlMOR5bPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwn9DWw+19y5ODtq6IBucb34/GjfRuwOFmuhvlLtxmSpt/Me6K
	Jej2cqGwUzX8Bi+qVbnGJqEZuvw1cl/9CLgxdWUc9GIxDq2D5Llp
X-Google-Smtp-Source: AGHT+IHSY5KmHfBXS1f/iH3BbPeOnqda3O25mlOO6gjzgvkfgvRgrisxNgpfP9TPlIHcB9Ocp9SDXQ==
X-Received: by 2002:a05:6358:9148:b0:1a5:4b74:2214 with SMTP id e5c5f4694b2df-1b5c3a45ad5mr882342455d.3.1724576258008;
        Sun, 25 Aug 2024 01:57:38 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:b871:d8f1:d936:dc0c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143425109asm5414348b3a.67.2024.08.25.01.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 01:57:37 -0700 (PDT)
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
Subject: [PATCH v4 1/4] soc: ti: pruss: factor out memories setup
Date: Sun, 25 Aug 2024 14:18:42 +0530
Message-ID: <20240825085714.10736-2-five231003@gmail.com>
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

Factor out memories setup code from probe() into a new function
pruss_of_setup_memories().  This sets the stage for introducing auto
cleanup of the device node (done in the subsequent patch), since the
clean up depends on the scope of the pointer and factoring out
code into a separate function obviously limits the scope of the various
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
index 24a42e0b645c..83d7d8d5ef22 100644
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
+		return ret;
 
 	platform_set_drvdata(pdev, pruss);
 
-- 
2.46.0.290.g4f02c709e8.dirty


