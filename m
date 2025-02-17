Return-Path: <linux-kernel+bounces-515027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22357A35EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9061170675
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4B265CD0;
	Fri, 14 Feb 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeloI0wv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472A264A9B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539084; cv=none; b=BBUYD4qNi17J/Fq/fWoWwgAdc+w4Ei6B9f47gqKalQ9F6FGpuWOieV0PuzE/XCsTNV0r7lt9m/lqOPSTKva3+TEswiNHkHcVBAsb4KqNge67xBSYAfWni06smD1I8kWmNRuc+c4iziHXgKWNTfhsZkY26Mchh3xB5TB3EPHebTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539084; c=relaxed/simple;
	bh=LL1TogbS0I4oRjmhDntXeaINYx8bTjc/f2otEygS0h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnb+xp0J43LpF92PcnyDlHNj4w1rGaLS5EOpofralnyUDlpp2P6ZPO3P9RyWOnTjc2PlsNOYh1doH1R6dDaLkYm30hyyAatD2ZdRRGjT97wvCUdzYJ5d2dA4fUNDt/HEQZA5tDgBGIslNxfYl7JoYfXmZtVuBzlLyCMBdhfee0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CeloI0wv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4395e234c02so2054235e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539080; x=1740143880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ER5spUPaUVlyGOWIrNvzoMizFEk7Lu+Morh7MgKfJEY=;
        b=CeloI0wvmoGdk2n+0kLtr5Q4rq8J32xKGoFxQShIwjO6xc1fjydB6PRhNF9vJiAL9D
         omZ6eWEaOUiwK0+YRg+9mNV9yve4qeWMhjJNsKyBO+VK32DaKy9AUgulG8QT6Rh3qe1i
         pHA7oyee+8kbAoSzA9mWuyZRimQBF4jyKThgQwvY/PTdNj1nbh3oTpszX7/Q9j2ih/Wl
         93tB+oKKoTCW0jwcE6p33LZL4HQzZ5wP00KT9zAAz834VwwVe3VM9t+Y5pknyjRfABcQ
         FULRs5LHVcoVHhL7Fnt4kWrj39mzbBsitxghJCgxrXYrcqVnCNujkT4KjAPlUZLi5zuC
         1RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539080; x=1740143880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER5spUPaUVlyGOWIrNvzoMizFEk7Lu+Morh7MgKfJEY=;
        b=AR9PlEw6BlrHr6tMiYLy9QxprRwdPvHJm25k23/JTdvHrqhL31j6KdftylAbs/9cYb
         lJTZevm71jBHrlsV5oWWkZy4Otmp0myvJkMM+ajmI6G8pyboQwv70hyQLxs1fuOVR2ME
         ttEDf0a7IuYmB2eR0rdeFwlf7sf70m3Ovpz2Z0Xhfi0pf2Yv2CAYbeTHixnswGiukGuS
         PsAFtT9dAHpJbYQUWGTN2HuUGGaUvJxfLdPLID6sMHnzygbX0aU44d7ilDBcw4CJhkEY
         CwqDZVNy6rqEsguFgFMpAb7hAiGmG3bWxAdXn8fb4jpv0RxF6RBXG28A219vb2EwR4Yb
         65fw==
X-Forwarded-Encrypted: i=1; AJvYcCXPhs1PR8Msakx2wp6gjdh1hbGAiuLmIdILSeGHjsH7ICQkaIRf/FxClYv0ndoab4zyCfUgHxSmsTwmuhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwComBPLmzofWK+jDX6wctGEZW4J9WqRv0m87BI4sa0KwdqeaYc
	7ZbGmPQlhG2PwIb9p2XO8+1YUNKFscvWyZVuV2uzsf5qV62icshj4U5xZprwUhg=
X-Gm-Gg: ASbGncuMUyDv1SN7JWuKF+y7E4AQSdD+6zhgLcizhfNTD8iJ82/3TETz9NSMo9Gq6oS
	aeVFs6WQjzC06+NZPWClll2PkA6rYMUrcBOgpHBGMuQtz/UTJghM/A0X1nhhNL+P2raY0z7ojo1
	DPH9XDvE9CFij1Sq9ZYY8QfAcMd8tDjzXCyPbgi8AE/5UgWjN/U/EEendAAJTRY972Uhfn7MNtY
	vRyIbIZ5YIasxCjkrXI9H28BtzeYkbxT+v7JmvqldeKvElJ+m7aOEgq2wG+oW2+QFr1nhGgK2yz
	h80ty+ExvaUG9UAHyQG8XrZDVrw+71c=
X-Google-Smtp-Source: AGHT+IGIlrTgLRsqyJPOqO+awGlXJBj4SLLn6Y0DaVIi6VSMJKuGPZgAAK52EZC+DFxC8B7CiMtSpg==
X-Received: by 2002:a05:6000:2d0b:b0:38f:2e80:795 with SMTP id ffacd0b85a97d-38f2e80105fmr620552f8f.13.1739539080149;
        Fri, 14 Feb 2025 05:18:00 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm4607690f8f.77.2025.02.14.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:17:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Feb 2025 14:17:45 +0100
Subject: [PATCH v2 2/4] drm/msm/dsi: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-drm-msm-cleanups-v2-2-1bec50f37dc1@linaro.org>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
In-Reply-To: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6658;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LL1TogbS0I4oRjmhDntXeaINYx8bTjc/f2otEygS0h4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr0KAwAeYL3ltzf1YUQ4/nTZFCZJPiaeRiKKAL
 x/LdP+jkkyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69CgAAKCRDBN2bmhouD
 1+7WD/9b//ZURPl4U7Yr+s5hL3Wu8hFQO1WE+u0tnhn8D3Kl0IqH4hJD8JOSaNtUervQAoYxlUx
 nUUd34dtMfU6DVlpvTJ2Su4pXJRb0rE+ZkdP9E77a9CLtyAnoYAJXufiX/kTNEVMhBZ7z+uO0r9
 OJN8Kf6XgaXDcbVlM8DnvdDxAmf+TNQlkUad2I6JK0L9cTb2z2OSLsA3FyuzDdkS09gkoebr8f/
 hnhXPhJ2X7kRRHKh3J1iRpyhbhx+3BnppgtZDv5PRSdlQFY1mZ+ACrMEaoNHmtYQmJoDlcha7Sf
 L4bkdNXt93aCdPPzAX03a/bi8vWJKj6ibGCnGeUdXCCHJ1ny6GJ7SDIm54DMbS1BlWfXvaEQETr
 I29r6LNKsnmSkCRdnTsw9s6hr1V7+7zjXiuC48OxlAQEZaIrlTlOSQcYdJZAN4BRhhjP/f4PAJ7
 CRpj09TJO9tcyqXHgDFH5jXdzJSJPsvxV2sqLkKbbpZ+uWYclvXmvyRitVuN27nHtTFa7FZgTpx
 6HFfWgHIxsRoIzldk/DRjmHQxoEtvm03gqqVmgya482q8iULtis0owH7MSH/AlCiOIjxSg8toCB
 vXJPq3jei/hlmSUT7DBBmzm2g+50ZDv1rlI3ddZ4/PproomerYwQgfY14F+gNK98cCfRBfSL9Y9
 v1JLEvMaI3B7rJQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

dsi_get_config(), dsi_clk_init() and msm_dsi_host_init() are called only
from platform driver probe function, so using dev_err_probe() is both
appropriate and beneficial:
 - Properly marks device deferred probe status,
 - Avoids dmesg flood on probe deferrals,
 - Already incorporates printing ERR value,
 - Shows device name (in contrast to pr_err()),
 - Makes code smaller and simpler.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Update commit msg
2. Tags
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 100 +++++++++++++++----------------------
 1 file changed, 41 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 397c9f1f588558b2081d6400d2cbae746c900697..8fc9f5486aebd3c08914409cd3c7824fa0b97515 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -200,7 +200,8 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
 
 	ahb_clk = msm_clk_get(msm_host->pdev, "iface");
 	if (IS_ERR(ahb_clk)) {
-		pr_err("%s: cannot get interface clock\n", __func__);
+		dev_err_probe(dev, PTR_ERR(ahb_clk), "%s: cannot get interface clock\n",
+			      __func__);
 		goto exit;
 	}
 
@@ -208,13 +209,13 @@ static const struct msm_dsi_cfg_handler *dsi_get_config(
 
 	ret = clk_prepare_enable(ahb_clk);
 	if (ret) {
-		pr_err("%s: unable to enable ahb_clk\n", __func__);
+		dev_err_probe(dev, ret, "%s: unable to enable ahb_clk\n", __func__);
 		goto runtime_put;
 	}
 
 	ret = dsi_get_version(msm_host->ctrl_base, &major, &minor);
 	if (ret) {
-		pr_err("%s: Invalid version\n", __func__);
+		dev_err_probe(dev, ret, "%s: Invalid version\n", __func__);
 		goto disable_clks;
 	}
 
@@ -281,39 +282,31 @@ static int dsi_clk_init(struct msm_dsi_host *msm_host)
 	msm_host->num_bus_clks = cfg->num_bus_clks;
 
 	ret = devm_clk_bulk_get(&pdev->dev, msm_host->num_bus_clks, msm_host->bus_clks);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to get clocks, ret = %d\n", ret);
-		goto exit;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Unable to get clocks\n");
 
 	/* get link and source clocks */
 	msm_host->byte_clk = msm_clk_get(pdev, "byte");
-	if (IS_ERR(msm_host->byte_clk)) {
-		ret = PTR_ERR(msm_host->byte_clk);
-		pr_err("%s: can't find dsi_byte clock. ret=%d\n",
-			__func__, ret);
-		goto exit;
-	}
+	if (IS_ERR(msm_host->byte_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(msm_host->byte_clk),
+				     "%s: can't find dsi_byte clock\n",
+				     __func__);
 
 	msm_host->pixel_clk = msm_clk_get(pdev, "pixel");
-	if (IS_ERR(msm_host->pixel_clk)) {
-		ret = PTR_ERR(msm_host->pixel_clk);
-		pr_err("%s: can't find dsi_pixel clock. ret=%d\n",
-			__func__, ret);
-		goto exit;
-	}
+	if (IS_ERR(msm_host->pixel_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(msm_host->pixel_clk),
+				     "%s: can't find dsi_pixel clock\n",
+				     __func__);
 
 	msm_host->esc_clk = msm_clk_get(pdev, "core");
-	if (IS_ERR(msm_host->esc_clk)) {
-		ret = PTR_ERR(msm_host->esc_clk);
-		pr_err("%s: can't find dsi_esc clock. ret=%d\n",
-			__func__, ret);
-		goto exit;
-	}
+	if (IS_ERR(msm_host->esc_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(msm_host->esc_clk),
+				     "%s: can't find dsi_esc clock\n",
+				     __func__);
 
 	if (cfg_hnd->ops->clk_init_ver)
 		ret = cfg_hnd->ops->clk_init_ver(msm_host);
-exit:
+
 	return ret;
 }
 
@@ -1879,31 +1872,28 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	msm_dsi->host = &msm_host->base;
 
 	ret = dsi_host_parse_dt(msm_host);
-	if (ret) {
-		pr_err("%s: failed to parse dt\n", __func__);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "%s: failed to parse dt\n",
+				     __func__);
 
 	msm_host->ctrl_base = msm_ioremap_size(pdev, "dsi_ctrl", &msm_host->ctrl_size);
-	if (IS_ERR(msm_host->ctrl_base)) {
-		pr_err("%s: unable to map Dsi ctrl base\n", __func__);
-		return PTR_ERR(msm_host->ctrl_base);
-	}
+	if (IS_ERR(msm_host->ctrl_base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(msm_host->ctrl_base),
+				     "%s: unable to map Dsi ctrl base\n", __func__);
 
 	pm_runtime_enable(&pdev->dev);
 
 	msm_host->cfg_hnd = dsi_get_config(msm_host);
-	if (!msm_host->cfg_hnd) {
-		pr_err("%s: get config failed\n", __func__);
-		return -EINVAL;
-	}
+	if (!msm_host->cfg_hnd)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "%s: get config failed\n", __func__);
 	cfg = msm_host->cfg_hnd->cfg;
 
 	msm_host->id = dsi_host_get_id(msm_host);
-	if (msm_host->id < 0) {
-		pr_err("%s: unable to identify DSI host index\n", __func__);
-		return msm_host->id;
-	}
+	if (msm_host->id < 0)
+		return dev_err_probe(&pdev->dev, msm_host->id,
+				     "%s: unable to identify DSI host index\n",
+				     __func__);
 
 	/* fixup base address by io offset */
 	msm_host->ctrl_base += cfg->io_offset;
@@ -1915,10 +1905,8 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		return ret;
 
 	ret = dsi_clk_init(msm_host);
-	if (ret) {
-		pr_err("%s: unable to initialize dsi clks\n", __func__);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "%s: unable to initialize dsi clks\n", __func__);
 
 	msm_host->rx_buf = devm_kzalloc(&pdev->dev, SZ_4K, GFP_KERNEL);
 	if (!msm_host->rx_buf) {
@@ -1931,26 +1919,20 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		return ret;
 	/* OPP table is optional */
 	ret = devm_pm_opp_of_add_table(&pdev->dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
-		return ret;
-	}
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&pdev->dev, ret, "invalid OPP table in device tree\n");
 
 	msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (!msm_host->irq) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return -EINVAL;
-	}
+	if (!msm_host->irq)
+		return dev_err_probe(&pdev->dev, -EINVAL, "failed to get irq\n");
 
 	/* do not autoenable, will be enabled later */
 	ret = devm_request_irq(&pdev->dev, msm_host->irq, dsi_host_irq,
 			IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
 			"dsi_isr", msm_host);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ%u: %d\n",
-				msm_host->irq, ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to request IRQ%u\n",
+				     msm_host->irq);
 
 	init_completion(&msm_host->dma_comp);
 	init_completion(&msm_host->video_comp);

-- 
2.43.0


