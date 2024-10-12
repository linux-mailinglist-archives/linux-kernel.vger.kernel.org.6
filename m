Return-Path: <linux-kernel+bounces-362136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF199B17D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8C1F21E07
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844213CFB8;
	Sat, 12 Oct 2024 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5CAu7jZ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD01448DC
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717586; cv=none; b=u5Rf2/dgMv+uPMj+YXE4Z8YcOOoUFKpPOgq50WbLsxhhKV2OLyCZVc7EKhnz76Ell12a96PZSZlv4J/2ydhdnAUxus9SBwnrweB8JmXnwIN8g/0PzospLvEc6sNM1kVi1397Z2g6hHdVk6MB6hSjQinwYjWt9HaBAMjsRFGCOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717586; c=relaxed/simple;
	bh=EIw3mJfTAmTe4zvwkPUO5JEBYkHljj9jBLbLU/NmMOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4a8csSQRr90uV6EUih5puHS9wwfte/65609uy4PkAGNLUjBebGTrHsaYARix2yUDOoulsoUnYFVf5wz2+bAdqdF7psEKRLlTWPcuODoFFzjQ66dK/WiWTJJDWAEh8mblQyak2BwkYPbnlxNYjFHUhiLwDz7x5ozG/TmeoMopvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5CAu7jZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71de9e1f431so2177744b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717584; x=1729322384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDPgjk5EMnq9O3TXdBLuoizjZD+u/zLo9dMYOLZW6Gs=;
        b=f5CAu7jZUbGwyBEqbldqirxmsuvAs4stw+T4GIRUdrzIz23pg3RmqDzlQCkc/0pEWL
         wxecMdc7UbW+OCfgbSdr1HXWOZ0utf79o4mYmCkhOTlbAx6DK1Xh7OY/basrs7Sj69Hr
         4tA9xrXm0yQI+paOAaRpgeyPh5BV3d+5XGkSSa0BH5fc4Y+VQyr7kWeEijblcVfp4JVn
         2uKl/El32knpap867SJlUC9YSw1GnIDePQLI7x+CUWESA5aekyGdMqmrD26LV++GTihu
         uML8eLmqb3kWfQJg48XJnubGmDiILaQUViKZ+xLfH/1X4q+8TSdFc0UexQLaCW2zWy6k
         Kfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717584; x=1729322384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDPgjk5EMnq9O3TXdBLuoizjZD+u/zLo9dMYOLZW6Gs=;
        b=RocEPVEmwSJn22ruotPQMyPhmympaVR+QDJgb1hqpbgAHcxjhP5mk8OSy0yrw301RC
         aNiGFRNQiRTYjPpHq8y9zGAO8/TZFhMkamOoqUqIVODYdCG2hW8PkyxQEAxrGKej60ni
         zojvlEUi0yR62EMkb79ubg2eizX+wMlNISK4M07R+tRLr/xL1f/MWiZ9gk1Vyv8R7Ca8
         VhfgyF/GBNvCfoaNofEGGnKatkX2qh2EiXk0c1ffluzjdkehCrrmfc2yVeinUJUMQgPk
         LYl8v3/4SOjOErd6oAUa7umBjrWWKPUZRQ8ZcWRMhbfJwYPt/suyK9T8Nmc9NSUBi0rr
         BnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUut2fOGOJGu5QSX9A5ZWs01IPxS2WrsuSWl9ciqGuGKJfw8ufH1KLI1x1O1mk6gDnSSUFUhzITgYN20Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7hVVCqF34T7A4qsQPQdMuTQG/NvbT1lTPanzkzzmhoSJDKLz
	x8Sohr4Yl/FdppsT+fX1RxNug+llrgH+j29wYk8jTtZp8b1APK96
X-Google-Smtp-Source: AGHT+IHOKv/G3fft8lrCLPkbfUGY4VYY1XzqY3QsgC+ZnNRSYHKjHGuKluxzX8c+5kAFExIe9iS23w==
X-Received: by 2002:a05:6a00:2288:b0:71e:ed6:1cab with SMTP id d2e1a72fcca58-71e4c1cfc19mr2588966b3a.26.1728717584316;
        Sat, 12 Oct 2024 00:19:44 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba171sm3664620b3a.161.2024.10.12.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:19:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 2/6] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
Date: Sat, 12 Oct 2024 12:49:04 +0530
Message-ID: <20241012071919.3726-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241012071919.3726-1-linux.amoon@gmail.com>
References: <20241012071919.3726-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_enabled() instead of devm_clk_get() to make the code
cleaner and avoid calling clk_disable_unprepare(), as this is exactly
what this function does. Use the dev_err_probe() helper to simplify
error handling during probe.

Refactor the mutex handling in the rockchip_pcie_phy_init() function
to improve code readability and maintainability. The goto statement has
been removed, and the mutex_unlock call is now directly within the
conditional block.

Return the result of reset_control_assert() function, with 0 indicating
success and an error code indicating failure

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3:
Dan Carpenter: Reported below warning.
smatch warnings:
drivers/phy/rockchip/phy-rockchip-pcie.c:278 rockchip_pcie_phy_init() warn: missing error code 'err'
So refactor the mutex_lock/mutex_unlock and return the err code.
v2: Change the subject drop: Change to use/Use
v1: New patch in this series
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 34 +++++++-----------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 51e636a1ce33..b5b1b1a667b2 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -274,30 +274,19 @@ static int rockchip_pcie_phy_init(struct phy *phy)
 
 	mutex_lock(&rk_phy->pcie_mutex);
 
-	if (rk_phy->init_cnt++)
-		goto err_out;
-
-	err = clk_prepare_enable(rk_phy->clk_pciephy_ref);
-	if (err) {
-		dev_err(&phy->dev, "Fail to enable pcie ref clock.\n");
-		goto err_refclk;
+	if (rk_phy->init_cnt++) {
+		mutex_unlock(&rk_phy->pcie_mutex);
+		return 0;
 	}
 
 	err = reset_control_assert(rk_phy->phy_rst);
 	if (err) {
 		dev_err(&phy->dev, "assert phy_rst err %d\n", err);
-		goto err_reset;
+		rk_phy->init_cnt--;
+		mutex_unlock(&rk_phy->pcie_mutex);
+		return err;
 	}
 
-err_out:
-	mutex_unlock(&rk_phy->pcie_mutex);
-	return 0;
-
-err_reset:
-
-	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
-err_refclk:
-	rk_phy->init_cnt--;
 	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
 }
@@ -312,8 +301,6 @@ static int rockchip_pcie_phy_exit(struct phy *phy)
 	if (--rk_phy->init_cnt)
 		goto err_init_cnt;
 
-	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
-
 err_init_cnt:
 	mutex_unlock(&rk_phy->pcie_mutex);
 	return 0;
@@ -375,11 +362,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(rk_phy->phy_rst),
 				     "missing phy property for reset controller\n");
 
-	rk_phy->clk_pciephy_ref = devm_clk_get(dev, "refclk");
-	if (IS_ERR(rk_phy->clk_pciephy_ref)) {
-		dev_err(dev, "refclk not found.\n");
-		return PTR_ERR(rk_phy->clk_pciephy_ref);
-	}
+	rk_phy->clk_pciephy_ref = devm_clk_get_enabled(dev, "refclk");
+	if (IS_ERR(rk_phy->clk_pciephy_ref))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk_phy->clk_pciephy_ref),
+				     "failed to get phyclk\n");
 
 	/* parse #phy-cells to see if it's legacy PHY model */
 	if (of_property_read_u32(dev->of_node, "#phy-cells", &phy_num))
-- 
2.44.0


