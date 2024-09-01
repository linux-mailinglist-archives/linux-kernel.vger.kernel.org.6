Return-Path: <linux-kernel+bounces-310364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81651967BC7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A5C281BD7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458612EBEA;
	Sun,  1 Sep 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LthLj2dO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5B32C85
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725215651; cv=none; b=LcwdVKurCZ3xFczU7qM8FslF1j1aelDaGhtokPQRrkNtHu/f343WJtytmISIA+To6gVwE2SxlYYlX1IxcxBnUNzufGtswAgwJ7Fd7ke1PTq8Oux67C7Hx/lS+1i0KaPbFguGY9IbEF481WMlH4L/J32pDL3NXAPk/TPFCRvddjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725215651; c=relaxed/simple;
	bh=CEqC+2ZMRpUu7SPPKl/gWjfqFLrpzhL+WWJweCTBoA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7IgEMlXOlUhcph1kO8wLSEwpheKShmsGxGGLSHmOJ04Dsf0C9iXIyzyu5qREMFKqKVAnIKWUwgLlTyO5om+oEyUORLw3mf/OsUNhPt+XK4TKO47zDmLHft8dBjTIxOLTx+377hoYq8HACkM5k/BEk2lFdb8qYJ4QHpUZK3JtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LthLj2dO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20551e2f1f8so7970755ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725215649; x=1725820449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1OZckweW5Fso4kEkpFhONlk2Rygt1dqEGGEL98qz2s=;
        b=LthLj2dOYB7oMxKqRWRyd3tX62FJwy2SBL6FGmJbvxPC+be2qSZMJgErb0JOBogvIL
         nb0xrjS7DUV5Z2jTX9cGrTkTwemRTWpFRnX55tKRBa4Sq9RSRy3GXG+e8/4ML6aDWfYc
         mRem6I5gfpiJTa4UsizBm8mBKMOgDinFrY7yuJMKDKPaMsmNIH7EDJnoMLPqNPo+o5ER
         C2OGkYcJuspSs53i64BtM+eI2DAHYHTMbmJE6PXcA2fwst5pfq1R/XePmuq87agWFgpG
         +6xv9HbfMynJcGeyFRPbUqx90oVJiabxmAilfpUWm2hqIPYEG+JZwgyowAmQeRLBy6AO
         OMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725215649; x=1725820449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1OZckweW5Fso4kEkpFhONlk2Rygt1dqEGGEL98qz2s=;
        b=fLffgDizwTn65Cy3r9DZXMTdbbIy/wgSNzS3alOknSMfblUiLwpYzeaBHyjWpyK4C7
         yxzUEqrtpofEZzFGCTdVAPNIiazKo6lhHUtCVajdPQSMvb7RKMzx2V/HNxkiuxy4m7pN
         dGhj3fK27oy/RbVlQ/i6veevxNdhV+cwXInzdj3eP50FBH2LY5rn8llnk9q7pHIOm+a7
         q5/vZd30NUU+/DHbbIlxL50vsMX/YBHo09NRfvdjzwOCLe13BEctbqgmqdXflJMSpgMx
         INM0FlOioWEuhCG4nKqEOCH2w5D26Wj5Qs5/bgvHq70jV9SiT1c4eGNskxZRrZeJw8fG
         /v3g==
X-Forwarded-Encrypted: i=1; AJvYcCVAxlu5UceVLvpf3hJ/Aac96YQTBUqyxAnc+4GQ+V0bdspi9Md+v7NHfZ+SGCScyFfodjjfip38XP9u8CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9xhKxQJ/IhF+6Ln+N/VK4QEw5EFBWDGaqKAHsI7jWJI5UFZE
	28tMkR3/uDxcD6MWe4Zn0objkvbkHVBjiNU/fHJSzmH/BmWntV8a
X-Google-Smtp-Source: AGHT+IFqD4cq32sJgonIzbTceZ/6isHD9h4Ev1uaZFsEW7Xxuog+FeUhQLuaeZwURmm3Ht2J2S2xow==
X-Received: by 2002:a17:903:22c4:b0:202:13b0:f8d2 with SMTP id d9443c01a7336-2058422304dmr187195ad.46.1725215648617;
        Sun, 01 Sep 2024 11:34:08 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559b793f8sm16262405ad.15.2024.09.01.11.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:34:08 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] phy: rockchip-pcie: Change to use devm_clk_get_enabled() helper
Date: Mon,  2 Sep 2024 00:02:12 +0530
Message-ID: <20240901183221.240361-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240901183221.240361-1-linux.amoon@gmail.com>
References: <20240901183221.240361-1-linux.amoon@gmail.com>
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

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
--
v5: New patch in this series
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 25 ++++++------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 51e636a1ce33..a1b4b0323e9d 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -277,26 +277,16 @@ static int rockchip_pcie_phy_init(struct phy *phy)
 	if (rk_phy->init_cnt++)
 		goto err_out;
 
-	err = clk_prepare_enable(rk_phy->clk_pciephy_ref);
-	if (err) {
-		dev_err(&phy->dev, "Fail to enable pcie ref clock.\n");
-		goto err_refclk;
-	}
-
 	err = reset_control_assert(rk_phy->phy_rst);
 	if (err) {
 		dev_err(&phy->dev, "assert phy_rst err %d\n", err);
-		goto err_reset;
+		goto err_out;
 	}
 
-err_out:
 	mutex_unlock(&rk_phy->pcie_mutex);
 	return 0;
 
-err_reset:
-
-	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
-err_refclk:
+err_out:
 	rk_phy->init_cnt--;
 	mutex_unlock(&rk_phy->pcie_mutex);
 	return err;
@@ -312,8 +302,6 @@ static int rockchip_pcie_phy_exit(struct phy *phy)
 	if (--rk_phy->init_cnt)
 		goto err_init_cnt;
 
-	clk_disable_unprepare(rk_phy->clk_pciephy_ref);
-
 err_init_cnt:
 	mutex_unlock(&rk_phy->pcie_mutex);
 	return 0;
@@ -375,11 +363,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
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


