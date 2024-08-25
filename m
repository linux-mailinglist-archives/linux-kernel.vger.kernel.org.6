Return-Path: <linux-kernel+bounces-300453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F5095E3CE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7EA28188C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE61714BC;
	Sun, 25 Aug 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbaIkl2u"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0816EBF6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595282; cv=none; b=TTlOsJjWpq2SQvkrNrAB1LAzICOq2E9Azd9xQ4wAb2RED+RYSINSIvwHacSBMlRHVaIPgNEu59ZsHrWvihr1nFT7/3BVO1wIeirzK4wATWjfSDHRh+lKnQSoCn9mP3IMoJ+HaHmkGTkb+e1UzmFGLA1JOvZExsEU7zN3Wdtj22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595282; c=relaxed/simple;
	bh=3FUpFc5Q6VFd1fQ8A/U87QLsFQnyhnFox4YWGWQ0Hbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmHCFMbyRejIySdNW49buGT3qgP7vFsO619hYuN2STLTA9Rs+946qXa3ZCDh9L5Vg8wbHLTKhEpUY2099F5vlUg/ZoC07vEbqvO6m6PnGa5uXFIQy5+AL8fiZupFvbhH3FDGhIX+peIqYy9zrmu5X4HVouy7uic3fBk/HXDh4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DbaIkl2u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e09ee91eso4317305e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724595280; x=1725200080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPfVC68w4G9TItKcZX9hLfDBOa9Rh2fNT0mcRYJpZNk=;
        b=DbaIkl2uSmArqx0PUn0teFwLTCDMeIkAbHsVoL3RRa8FdwYlGb1waGz7uRdsj3re1D
         hJi0vdG/Sh3yue3V8m5OdvumUXooAUcy2aPZqcBjupQHQSf9K5wn21n3P+2LKYeZfRCs
         pBE1+VCFCgkboalxPQ8Mi6xzT1IegFKsixjJI3yutr6ncjcua9MRGD7cbUFRYhanz7Yi
         +5Ij8ABNPkldq79j6DtTxbLbZoViKirP39SF3arUHPVeSZHNG8MfOLSGXHJe+rQzILYI
         0Hn1JX+4jarlbZn+NPGXVy2k+OPHU4DXk7zoq+ffKxIFKCE38y4HUozc30Q9r+W69Fzg
         kUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724595280; x=1725200080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPfVC68w4G9TItKcZX9hLfDBOa9Rh2fNT0mcRYJpZNk=;
        b=Sfl7IBGA4viZwyHspD2E0+tUpudmDaIYeNnzsiZpRGoToYHrWDOX6xR5ARrIvQJUNR
         rKb5vknTUWacW/u0mAJGl93q8A3F4McRdV+m2CzxnYNSQlREi14frZC/hfBVgZ/aOOqu
         en8OFN613+SBRxUASQnyH458nCW7cv+/1VpaJd1hATVYMoFzh5DfigzKqazDXugeNqPL
         XgAjgLuJosF9khZ+Xdjp6MCL9f4OfzDIMZdZ+/4IurYhOeexnQDDOVSsaZQuzti334H6
         RE2tVz0vr854X1YvgsIFlfmYVTR033HQpzGcYPjVAu+Y4Onrko16kuSPFaxWTA3pS8fi
         O4cQ==
X-Gm-Message-State: AOJu0Yx+r6qy4aPIM2O3kFEr7xnAFE9qKyjOA//i6Gga7aKG63S+zy44
	Krg8wamTyC+7ZElXRi2EokCSQOcNfFzXZJtrwVcOxzqlYaAG0pg9/dhS6H6GU9I=
X-Google-Smtp-Source: AGHT+IElMKRI5xZ8yzDk8JbJF8qKOxDYwCIunD6hU146I7V15XtRVaFAqCfrraqfYRZZ0YGENwgH/A==
X-Received: by 2002:a05:600c:1c1f:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-42acca112admr31861355e9.5.1724595279439;
        Sun, 25 Aug 2024 07:14:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162347sm122556045e9.23.2024.08.25.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:14:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 16:14:28 +0200
Subject: [PATCH 5/5] reset: lpc18xx: simplify with devm_clk_get_enabled()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-reset-cleanup-scoped-v1-5-03f6d834f8c0@linaro.org>
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
In-Reply-To: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3FUpFc5Q6VFd1fQ8A/U87QLsFQnyhnFox4YWGWQ0Hbk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyzxGxK3ymr8fJfvYSTHWGw3mhICORfcHW0/ex
 woHJNmabneJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZss8RgAKCRDBN2bmhouD
 15u+D/9Enprg8sJbkA1Du6xadF51tsosIPpeLdcevWdfza41+UoHchX5cxoDdM6x3VHFYX5PSvr
 Vomw26pQKB8SMQUS38dtxNYBc3yrtp97ZP+t1ryzjTmkPEX7Nl76aJnQgsDxFFqoHepwuupIHCs
 FUoV6QMXQbjQvINTbf+hIky6dYdBoaYMe6ln95ldHsqc+3hJzfiKkum72zx3hK1kepxrvn7NikR
 O7dV/PuemP226IU/zwtMmhwCNTRaU+OFVdWrC807JD/Kua7UZ8bERqRR1aZw2p2jyyvXXCsb6yu
 gehSPqxngcswmzrm2lPn+CRZhKGdpxHLjyzoJX0edDaYAtvUeOlnVxKrm6mV6g0tPjV5p+qfj2P
 /CYDSpOaNixEpQqahTXrdrx1PW45Y7NVkfPYZaaFSqNLo5R17dbZCq960XCavRAdEXmAPCaVFa9
 0TM+Rl5tlPvjpkKutR7FtTrJhq29nVqACJIFbcgK6Z2rr/X7He2hf76yDDfHTQM6xAq079EdQIr
 eGxBvKCPMoNs3sxD47j8uBxqztQ7eCWvZbGljfM3g2sPWhYi9n16BP95eZt9xH0cPj4nKAmNMWE
 jbXjXkQ/TK235iBhyt+rEN/t91x9JxGZmALel2kJeKHIejYXTEd75zBGb3WGxS93VDUjVyqBdBu
 i6S6vCcYnfzEz6w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use devm_clk_get_enabled() to drop clock prepare/unprepare parts and
make code simpler.  Change to dev_err_probe() in handling
reset_controller_register() error to make it even simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/reset-lpc18xx.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
index e7896e3f1851..e42b2f24a93d 100644
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -150,28 +150,16 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 	if (IS_ERR(rc->base))
 		return PTR_ERR(rc->base);
 
-	rc->clk_reg = devm_clk_get(&pdev->dev, "reg");
+	rc->clk_reg = devm_clk_get_enabled(&pdev->dev, "reg");
 	if (IS_ERR(rc->clk_reg))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rc->clk_reg),
 				     "reg clock not found\n");
 
-	rc->clk_delay = devm_clk_get(&pdev->dev, "delay");
+	rc->clk_delay = devm_clk_get_enabled(&pdev->dev, "delay");
 	if (IS_ERR(rc->clk_delay))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rc->clk_delay),
 				     "delay clock not found\n");
 
-	ret = clk_prepare_enable(rc->clk_reg);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to enable reg clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(rc->clk_delay);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to enable delay clock\n");
-		goto dis_clk_reg;
-	}
-
 	fcclk = clk_get_rate(rc->clk_reg) / USEC_PER_SEC;
 	firc = clk_get_rate(rc->clk_delay) / USEC_PER_SEC;
 	if (fcclk == 0 || firc == 0)
@@ -187,10 +175,8 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 	rc->rcdev.of_node = pdev->dev.of_node;
 
 	ret = reset_controller_register(&rc->rcdev);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register device\n");
-		goto dis_clks;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to register device\n");
 
 	rc->restart_nb.priority = 192,
 	rc->restart_nb.notifier_call = lpc18xx_rgu_restart,
@@ -199,13 +185,6 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to register restart handler\n");
 
 	return 0;
-
-dis_clks:
-	clk_disable_unprepare(rc->clk_delay);
-dis_clk_reg:
-	clk_disable_unprepare(rc->clk_reg);
-
-	return ret;
 }
 
 static const struct of_device_id lpc18xx_rgu_match[] = {

-- 
2.43.0


