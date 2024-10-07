Return-Path: <linux-kernel+bounces-352724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54671992349
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1577C283485
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 03:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744276036;
	Mon,  7 Oct 2024 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6pWOu73"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E938F97
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273404; cv=none; b=tHmDwljUiqbLRNb6zZc50zcP75oA7iM1nCfmVaJz/I6ugGjd5bL2AvQ5iSmeFheKF2hxsN+UcM6FKojuE10BhnhzjkP7jZxqGiq4O2/i74NGiMQSk0Br3rOB/xcFKuuG0jAYBbVbXbGFr0hm1ZKCQzZR2vvahyuSqLsTD1ZBgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273404; c=relaxed/simple;
	bh=imyWUZwPcapokmiBWVEm+gTZombsP2CCxcP2qVK/heg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sz2imlpqVX8pNSTWubzQPQNKPmkn2CWTKxWUm/newVRa13P/Ms/VhbiUEQJE2LWtRLsEFJRgop18orKss29ENs5DVJGrzLZGmBlNSUmu1bepuUSBsgsv23M+FPqeM0p7Q5auEuguYlokfawOwgz9sp1qKJqFnxEYkHMI1cMuAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6pWOu73; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso3946732276.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 20:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728273402; x=1728878202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6eSRE8PNh/DxA4RdaK3Wt2RcDD9+iNYAeS9X6qJVfI=;
        b=P6pWOu73+zdeC97lO+1cJRe+cZM6A+fYrIsw2ABVcGH8MQ3JNMPopB/SxyE0oujtmv
         HSFDyeBPirIvfeIO9e7E9NTzB/x8fxNvpUBSv5CPPFVOKkL0l1Q62qp7zmS5A9HpbPG1
         9kBS/VJVWT+8Dl9JGum+jYideGGKX26IDGyXwPm3lXevShC7UN8Ujhbct8DR2fS3V4EH
         HYpG4sCttJOqe8ySHNuGzAc0MKUcEw8Agj5PFhl4UX4Cxtp0WkUn4rFiHvWlneStRJn2
         ojTifz9C3Saevpp+lAUwhJP9+Nmuj9/gFp22pp3O7beEfYRJRmDP81s1zkVGKOgl/wAP
         aVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728273402; x=1728878202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6eSRE8PNh/DxA4RdaK3Wt2RcDD9+iNYAeS9X6qJVfI=;
        b=BG/YmyaVKz1azex/Abo4lln8ZA5V0FSHAdoTRIl4g9h0/YHxX//4oBtGiXePvHbRFk
         Fs4DM2CE02ySJiHpU7SkD8P80Dn7wMgNuxjUtC9fBnCyBNyYm+6Fnq1c0d8pFK6CuIIf
         NN2bGtuFQIwV2L71e70htgV3qdGRr+REQSOTVOOWJo2hdqx2j1ZAyWqpjGZAqOqcDrUy
         mSdnhW9HNijZko+uNtUBhxclf8IYyqwAQ04IYm5hVOhVvs4qHEQSVvCS/m92wdyeZlzK
         e1yRfjcCCDDxKtSm7h85p4cP/LBSq3f22PGmwYcv0FTOXCBv1j9LAHlbFTBXX1v6OIG/
         PKCA==
X-Forwarded-Encrypted: i=1; AJvYcCVTeTHwo/TgxVW9XMJsxoG/i9rmmiIXdCx0aBrIYedpyTaPXHMPIxgQgG6u0YiM53U7ND2ZwxmtjgVTShk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozQIgxRbBUkMPt6Oamy/eFONhgw5vn9sTaSIsy5n2KUZ1CXFw
	xojEiC5piifMokOP/S/p38WPtk98Lb1V+KZBSa27lume6hKARKyk4qoJOg==
X-Google-Smtp-Source: AGHT+IHNeJw7Y38Do9bLCUY+sRwFyUhcdw/O9uY3zyz1MoVfAXMmNmgLF8VUGm8KzFOE0Mg1zPkztg==
X-Received: by 2002:a05:6902:2192:b0:e28:68e8:ccc0 with SMTP id 3f1490d57ef6-e28936c62e1mr7534463276.11.1728273401633;
        Sun, 06 Oct 2024 20:56:41 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbbac6sm3451322b3a.39.2024.10.06.20.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 20:56:41 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 2/3] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
Date: Mon,  7 Oct 2024 09:26:10 +0530
Message-ID: <20241007035616.2701-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241007035616.2701-1-linux.amoon@gmail.com>
References: <20241007035616.2701-1-linux.amoon@gmail.com>
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
---
v2: Change the subject drop: Change to use/Use
v1: New patch in this series
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


