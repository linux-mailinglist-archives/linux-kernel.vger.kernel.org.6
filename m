Return-Path: <linux-kernel+bounces-289523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D382954721
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731311C23A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420F2198A2C;
	Fri, 16 Aug 2024 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kheqa9cY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD31A0728
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805696; cv=none; b=kvrZcBtlV6N3AwBh02TPeG3WWWcMQbSD1yedCCiuNWOpazcRpL7TXBycz/BHa0G1RKR3m6t4FcP8chweKwIKLPldrKU8RVbsEOBhLfHGN/yJ4/wOY/kuabkEyoJANnHgQPUlv94sEHsFsE8a0k9YyZ47Zys+t97Tum+H1f7xLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805696; c=relaxed/simple;
	bh=aOG0FNkWr7wWqxbaC9hbRdBtAW+4DKmOSIujr3Va07A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzlrYGbOC2CHpkosbH4831RwGIqEJrkgsyeaQHgxmpRo9c1+n2n3oxV6g3sOOHUlAPTbOWwSxHmMA9gMF1g9wOB5kkdCQ3/LOoKGN6KSMGkPFJqbJTg7f/s4WrrWNXreV/R2U5pejyxYZx2RQ29ngyxlEsSuu9D1cZx/IQbRmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kheqa9cY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so14368025e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805691; x=1724410491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps5OVwPQda0LMKMNWr2tdKZsG2I+Nc7kykB2orG3PFk=;
        b=kheqa9cYMwIi+QBovPO+6HkYummRiCUKk8S7dsm67r8vn/5ElQmeS/MCCADfNUHZeu
         R6PxotjkzspOXbjENbYAf8tUNk3KMkFQOhoxqtG6VgmAR7b8sljX+CUT6adUR66Tyzsn
         BY86wjTqc/d15mEzn8P3gu+H3vjMcJhGJnZfn9+M38F/cXU8j1Woonqvo+kOaxNuNk/r
         MZSNZgaGUpvx6UYkvrB8xHZxpo3adSwnCTfq/D+lCB+0PNABMnq7zf+09qWfZgTGWR0h
         RBZ3NdEB3sFA97jOtX0YzreGvCYzWGxGO6uEfNfAFFQS4iZ0Je4SXn6Dger7nuRBmKXN
         g/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805691; x=1724410491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps5OVwPQda0LMKMNWr2tdKZsG2I+Nc7kykB2orG3PFk=;
        b=GC8zogDZK9Cm2XPBToFf9O1fFamp7fwN2jc5TNkmkbr2uNvWSM5Uv6kOGLfl0RM0o3
         4x/r6k8hqMA/DtIBAukGQetIP2KVDLedUGNuLL83wdlFhKzNn7opuC6XdoJF63+g3ll1
         yley8MdodFB7BRBuupyCRGWbznBxCpdTNRsYa0zGVfn5g5bXcyMN+9It60CJViq0gde1
         DTamV2rMtgfPGJhD2OVqFFG9np9VhchUK+YdaCXRyQ3UudLsvGJ7yzhdBExubQq1HzCW
         GCEs8n/STgvRqlbO5HJm4DIegh+MhkfN3V86MuVx41w3HNkWmI5wf/g+FdGoZsSqZj5K
         mi+g==
X-Gm-Message-State: AOJu0YzCUdc75Jt/ULVTKzsgM2lHELJwzAm9Brc9L/wIjBcMJoQKfrDl
	NuKP1LWN3u0n40OFPXuHChPuQWfRwU4c7lj6Hxf8KcS5DP/BhrHd874TW2PciO4=
X-Google-Smtp-Source: AGHT+IHxdhvK1ECKqUfwiSpYS/cvX8viRntSwBf6ySKhzTK46bfJHN/AjQbBdfp89HO0dgJRuKS1sA==
X-Received: by 2002:a05:600c:4e8c:b0:426:6ed2:6130 with SMTP id 5b1f17b1804b1-429ed79d9d6mr15821505e9.14.1723805691544;
        Fri, 16 Aug 2024 03:54:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:28 +0200
Subject: [PATCH v2 04/13] memory: samsung: exynos5422-dmc: use scoped
 device node handling to simplify error paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-4-9eed0ee16b78@linaro.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2879;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aOG0FNkWr7wWqxbaC9hbRdBtAW+4DKmOSIujr3Va07A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/qic+gJt3V9XC+/wcsbOscwI6XAJiI5CIZ0
 cpgP5XqjV6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v6gAKCRDBN2bmhouD
 1x5hD/949WpMkITwA7QhSsLEYr1aaqTVr+5IEE6h37JucIjQbSTWkGgK4m/wf3YQv8/aUa+1Swx
 hc3s4GGsYlwauOMNbRde2juds7Grplj5jSnR1lazEcz8YNZqV7tHdU5X6SCzFwiEacMwYyaIvLf
 e0hh9aN4lUSN00pQs7bioG3RP2muok3RivVx1DJSgRADr4zt36pXwWpX55dGUCVW5E/Kw0LCfvC
 CoKTtOojcKBWbyzj4NWXYjmogE5RfcYSKDc3SQsy7aFMlkw9P593FVbHNYB74NbU72eJSvNNwGA
 7+PMvNWtHxR1i7ri1Mht8Bq2PIKlWZIz4pC8JSdyTY++hvWyo+/xpNIgcvomfls33V0CG1t2fgQ
 GPd+q+U208qLx/yp4THm/GReEuAQYLpGUwXF959Yl52Kytcqc94QW1QaTIYeMPQpU6J5b8cQi4L
 /ImmAa+9xuVkX9Tx6IqRXfpbbzwE5RSXP0R+SX4hqxWxQ0Vc0qJGW7yxpQs3O4XIxHxRxo27xan
 BNDOdFigoQxxzPBwdnhM3wiSsAzztF1+d6tXYUlsdwt2+K9N7iFvlOBBjJPtMGTE5nSZAc8K45t
 daUn0t1W965yCXgeSR/uDoPi6XSGhNLJ1aVOLyixXuIjkPiiTFpmZaW+j7tGB+oZqF5G0K/iO7O
 ajmcbr4B7MWf2kA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Wrap line before of_parse_phandle()
---
 drivers/memory/samsung/exynos5422-dmc.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 48ef41b8eaa0..7d80322754fa 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -4,6 +4,7 @@
  * Author: Lukasz Luba <l.luba@partner.samsung.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
@@ -1178,10 +1179,10 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 	int ret = 0;
 	struct device *dev = dmc->dev;
 	int idx;
-	struct device_node *np_ddr;
 	u32 freq_mhz, clk_period_ps;
 
-	np_ddr = of_parse_phandle(dev->of_node, "device-handle", 0);
+	struct device_node *np_ddr __free(device_node) =
+		of_parse_phandle(dev->of_node, "device-handle", 0);
 	if (!np_ddr) {
 		dev_warn(dev, "could not find 'device-handle' in DT\n");
 		return -EINVAL;
@@ -1189,39 +1190,31 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 
 	dmc->timing_row = devm_kmalloc_array(dev, TIMING_COUNT,
 					     sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_row) {
-		ret = -ENOMEM;
-		goto put_node;
-	}
+	if (!dmc->timing_row)
+		return -ENOMEM;
 
 	dmc->timing_data = devm_kmalloc_array(dev, TIMING_COUNT,
 					      sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_data) {
-		ret = -ENOMEM;
-		goto put_node;
-	}
+	if (!dmc->timing_data)
+		return -ENOMEM;
 
 	dmc->timing_power = devm_kmalloc_array(dev, TIMING_COUNT,
 					       sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_power) {
-		ret = -ENOMEM;
-		goto put_node;
-	}
+	if (!dmc->timing_power)
+		return -ENOMEM;
 
 	dmc->timings = of_lpddr3_get_ddr_timings(np_ddr, dev,
 						 DDR_TYPE_LPDDR3,
 						 &dmc->timings_arr_size);
 	if (!dmc->timings) {
 		dev_warn(dev, "could not get timings from DT\n");
-		ret = -EINVAL;
-		goto put_node;
+		return -EINVAL;
 	}
 
 	dmc->min_tck = of_lpddr3_get_min_tck(np_ddr, dev);
 	if (!dmc->min_tck) {
 		dev_warn(dev, "could not get tck from DT\n");
-		ret = -EINVAL;
-		goto put_node;
+		return -EINVAL;
 	}
 
 	/* Sorted array of OPPs with frequency ascending */
@@ -1241,8 +1234,6 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 	dmc->bypass_timing_data = dmc->timing_data[idx - 1];
 	dmc->bypass_timing_power = dmc->timing_power[idx - 1];
 
-put_node:
-	of_node_put(np_ddr);
 	return ret;
 }
 

-- 
2.43.0


