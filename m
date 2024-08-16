Return-Path: <linux-kernel+bounces-289768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C05954B85
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026DC2873E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440841BB6B7;
	Fri, 16 Aug 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skoonXmm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE181B8E84
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816653; cv=none; b=c2UVsMSth4me3Sd5XxuOCj/nU6ja9qWn1OkHzYSJsUGHyx8AXvB1q87ALoeypphefTLaHdmSmsrlr276B+qkUqU1vh7o9aXVyezRpdh6S+HV5QcBMSQkMXCxKMYmorqC93A7aeely7lZOoI0Hwswo1CDoX/J+P4vhWUkKq7hQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816653; c=relaxed/simple;
	bh=ES5WNhjQ97KkXEVEYI5UMpRbkvt68q9g+APgmhu1B+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmnJn2wxNzti7j0feCzTAdyHKeBUU33ZLxcU4KDBaeOO2Eq03LGXO5wnkdjuuSDcf6NJlL4UKKnLgHFjg8eIjiyU/hTTaHkAzRrVuTozr7zBYiepsalusVI7RtTq3gL2IjdmCt4dF/Wuoh1pzjrbIzM3txeJ8eeSgeK14s8nLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skoonXmm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42803bbf842so20573895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723816650; x=1724421450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FU7Yn36ou/qawMkS1iMJfnBA3me627G17eoAbOIhIU=;
        b=skoonXmm9AwCuIWHcBSRq8UxYQLVxV/Z0RKihKZpXrIthrUc7QxE3d71BfCLk/V6aO
         xv3yKRKRwbfy88GCBLQtPbZlcvpR8/p8fu1G05/rBH6JAK2JYvPEk1cv28zNmw73olhU
         r7zv3kqaOmSVV9s+VHOt7Cg3Hh1HZKKYtz21V5IEH1AE0FjoU6SSgKRtq+w2IC5dufBl
         aLf/vErAMkaHEErKeivvLPMSCxHjddRq8+XQmsfqzBgxYmDTs2mAcu9pqmZwC+YbJprg
         putZa7ibi7AfEIuz1U8sTw9JtGDeNcEcOBP49IXR2Z4VBOUtMY5LstBTGh1nBQxC8QIU
         ah3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723816650; x=1724421450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FU7Yn36ou/qawMkS1iMJfnBA3me627G17eoAbOIhIU=;
        b=rBjkRMDIjcf8gkm9QSP3MgC5W7xjdzCyVbL9e2fU4kc4bI9MLZClfeQIPyKJ16eo1r
         u9QzhXPyCE6sb+D5Peb0kP/5bpde39Zh5CTvdXinY2GtDktU4E4y+YPhJx+zHdmmCZed
         oggUQt/Yj4Mvjb7A/c4KQnZr05zYBRXQZSpJrY+uptLzdDKywrQNypj9wW5GDIGIxuEY
         d4Kg39LGyHVR7of6vA6JsxJoN05p2tQAlmoDMiEmypZWDqODV+9micD7kL6xiYxNnRES
         KVdd0qU9Pd23bfgaIDM6aaIZY9/h+qxttMQA/lcsIpDcwQ3fPgGcAMpKu8Q0VELSBeju
         yLxg==
X-Forwarded-Encrypted: i=1; AJvYcCWCaJJw6Bb1oiYvnLAZ8Cbqv9y/whK1Eyn6m0Zbopc5Gs9Il3MoKtbdQ+9LGraMYmxdOcTMdrufJdSkLoDAHqoJzj+bl0FaJHbF+aPm
X-Gm-Message-State: AOJu0Yz+vuRlnwkTl/EtEgFhEPLdPP7vkD+opXPYcWMK9Dkl/rHBH4G+
	ob1T5G3B8Q+AQVpZyIed54xMpinlGVGNT4V7SkSwEDMDpADPa0NdbOaTv7Glf5s=
X-Google-Smtp-Source: AGHT+IF64oucyuEIrdECCSfRCeOVjjInXceFWeMY/QFE6S9rq989ayLrMtsEH0Yly5SMl9RtJuP63A==
X-Received: by 2002:a05:600c:3b26:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-429ed7b6a3dmr24128425e9.17.1723816649988;
        Fri, 16 Aug 2024 06:57:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36a95sm76183995e9.28.2024.08.16.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:57:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Timo Alho <talho@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] firmware: tegra: bpmp: use scoped device node handling to simplify error paths
Date: Fri, 16 Aug 2024 15:57:22 +0200
Message-ID: <20240816135722.105945-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816135722.105945-1-krzysztof.kozlowski@linaro.org>
References: <20240816135722.105945-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/tegra/bpmp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index c3a1dc344961..2edc3838538e 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk/tegra.h>
 #include <linux/genalloc.h>
 #include <linux/mailbox_client.h>
@@ -36,27 +37,22 @@ struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
 	struct platform_device *pdev;
 	struct tegra_bpmp *bpmp;
-	struct device_node *np;
 
-	np = of_parse_phandle(dev->of_node, "nvidia,bpmp", 0);
+	struct device_node *np __free(device_node) = of_parse_phandle(dev->of_node,
+								      "nvidia,bpmp", 0);
 	if (!np)
 		return ERR_PTR(-ENOENT);
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev) {
-		bpmp = ERR_PTR(-ENODEV);
-		goto put;
-	}
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
 
 	bpmp = platform_get_drvdata(pdev);
 	if (!bpmp) {
-		bpmp = ERR_PTR(-EPROBE_DEFER);
 		put_device(&pdev->dev);
-		goto put;
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-put:
-	of_node_put(np);
 	return bpmp;
 }
 EXPORT_SYMBOL_GPL(tegra_bpmp_get);
-- 
2.43.0


