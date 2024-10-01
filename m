Return-Path: <linux-kernel+bounces-346627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79B98C6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3D01C23798
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C681BDABB;
	Tue,  1 Oct 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZYYf7y0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132021990A8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815237; cv=none; b=fQOQZnHBNEVxHimiB6x4tmJNlaNbmpiO81Quc0qz38qxENKz1LYm3yU60+mcM4WlKDaFi3UU0A5BKMkEZ6/ZqHRVRFBq+8SPMYlzQhSKAa45gnCo1SwesInrSM4CxicsqogXWc3pPlXCWL98mbJ23vTzTrDLyL0g0jG79xvtWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815237; c=relaxed/simple;
	bh=z7fN0wcDrgSGLJ54CogSRI9qTPvLsqNMXWPMmhQaMK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSAo+co0dR0OiyFrc9cI5vLJR0uirE5mxzWSSwGYQq3HIZ9aqLckuZuSQwNIJBUeT5PIMZAqMtd6palqdUNdt7hcxQa1BJD5LHjRfjViKf2o1tJ1c8EskgvBcG6+gMGR4O3GVfZxPESs968J0vxjUuHYReu90LgsWEpTp8zKi74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZYYf7y0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb1866c00so7780915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727815233; x=1728420033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EN+IlGnMWsVNl93iDCLUh0QeaNh7xIiYAcmuHj+W00s=;
        b=YZYYf7y0t3fzNM6K8Io/RKGwI6WHJiV38lKuKDxx9LfCcPwU8pJvhVMQHB989W0lbH
         qoWoiy9qgzSJXTwlHvoVY/klOuc/FnKHxrSt+/ThBLoF+4ZMIdxmI34w0XKFAd7JAfx8
         f93rdrCKIFVQ7zI0Zd8AlwtcckIBVp05syFToLAIMtsLJQICv69u2knv5L1ft4pyRgWE
         +s1He5B/yGCvo9SP/eVKJK5pszJ2nyn3bHSJlK7Q6uRW7vmU8EG57ImDBeQy3IVDruxJ
         awBkHirnmXngDS0ysmKOyGSWGkRrcSo0bESh1INwZdOgBSDw/5gbBZNY1ZxPYCS9wKx9
         WZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727815233; x=1728420033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN+IlGnMWsVNl93iDCLUh0QeaNh7xIiYAcmuHj+W00s=;
        b=Tj6XYSKBLtSyi0BPV3Cz3wlolYy2dOlxUG3wPkB/4I7t2dpAm1JtI4+7SBVHeGvl98
         s2M4LDE2pkqQYH/ZBZevAFv/lBuR5/6/RW7Pfq3w4bZMhIbPUJZ6QUJBG8HwC5tps6++
         jEStMFRUmfk+c60aO9m+CpQzjSkQC1OLi8zbPEXk6YtTIlqyB63kqzkEN4Px5A5LsDln
         a4jkPQRvx+Bq22X7U2mjLr75J3/tK/ib8RV+ejAT4NYlZUeMFiBKTIq4BYfRGrzP7xbu
         YGU9Y9uYRmCO7Hx4UHrRiLcOWno58hcDU9Fo2dmoV68rmB1jj7oESEeZEdJGZaCqJfPS
         YYgw==
X-Forwarded-Encrypted: i=1; AJvYcCWE77OHzO5SHcXdQ1mkovRYLWXkCIsTw8wWe5ZwOHqLEmVLjTB0vnC3rkhBX3DD6i4C5m0We7cLGjMcxVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrF8WshT03rfj9cXQWjPHdRHUpnwzCVYIWYrNbT+sh3ZeGbFT
	WKgSUR8lvhhPtmOHDLYK0aCf49XICKH/UMShZZEOBZ2ZjR9P0v6kJvI1vpojHxMq5fehSGITOm2
	9
X-Google-Smtp-Source: AGHT+IGT9qvAcHTeHq/UjlDNrHiw+vESOThjdO8ZDEU34vY5psay4GhWwsOZG2VmxNX+sm2JGMKISg==
X-Received: by 2002:a05:600c:1884:b0:42c:aeee:d8ee with SMTP id 5b1f17b1804b1-42f77951d97mr2528105e9.8.1727815233235;
        Tue, 01 Oct 2024 13:40:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f771c208bsm6214725e9.0.2024.10.01.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:40:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] firmware: tegra: bpmp: Revert "firmware: tegra: bpmp: Use scoped device node handling to simplify error paths"
Date: Tue,  1 Oct 2024 22:40:25 +0200
Message-ID: <20241001204025.5632-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 8812b8689ee6 ("firmware: tegra: bpmp: Use scoped
device node handling to simplify error paths") because it was silently
modified by committer during commit process, by moving declaration of
'struct device_node *np' above the initializer/constructor.  Such code
was not intention of the author, is not conforming to cleanup.h code
style and decreases the code readability.

I did not write such code and I did not agree to put my name with such
commit.

Original patch:
https://lore.kernel.org/all/20240816135722.105945-2-krzysztof.kozlowski@linaro.org/

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

It's very strange to see own patches silently modified without any
explanation in Signed-off-by area.
---
 drivers/firmware/tegra/bpmp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 2bee6e918f81..c3a1dc344961 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <linux/cleanup.h>
 #include <linux/clk/tegra.h>
 #include <linux/genalloc.h>
 #include <linux/mailbox_client.h>
@@ -35,24 +34,29 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
 
 struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
 {
-	struct device_node *np __free(device_node);
 	struct platform_device *pdev;
 	struct tegra_bpmp *bpmp;
+	struct device_node *np;
 
 	np = of_parse_phandle(dev->of_node, "nvidia,bpmp", 0);
 	if (!np)
 		return ERR_PTR(-ENOENT);
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return ERR_PTR(-ENODEV);
+	if (!pdev) {
+		bpmp = ERR_PTR(-ENODEV);
+		goto put;
+	}
 
 	bpmp = platform_get_drvdata(pdev);
 	if (!bpmp) {
+		bpmp = ERR_PTR(-EPROBE_DEFER);
 		put_device(&pdev->dev);
-		return ERR_PTR(-EPROBE_DEFER);
+		goto put;
 	}
 
+put:
+	of_node_put(np);
 	return bpmp;
 }
 EXPORT_SYMBOL_GPL(tegra_bpmp_get);
-- 
2.43.0


