Return-Path: <linux-kernel+bounces-362137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C9999B17E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FB31C221C6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16621145B27;
	Sat, 12 Oct 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo5pnkUe"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41F13D50A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717591; cv=none; b=dw01U+TZNs8+29A6QbdEhOYbv6l+gbVE5/W7rkJh1xX8Ei+M7XRxsDNq13YZNYuqbeDPoQk6neknSKAh7HP7biGGUX7jtNLppTCJljKzyZnbLKMS2r7CI/SGVLi0Hvud66eBBylUwcOx5SiNOP0eDhLw414RzFpbNZlz3JQd6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717591; c=relaxed/simple;
	bh=y0fnOKUQDiED3PC2Orv9TeNTOXW0bTcc4bQfCqyChT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNB2L7OVC+cALWj37N/5k7gq5DCZ3nykxJKDgF0TMaDUMoo0r7WynBXj+JbxPkPYcviOIWEkT5VN+GVQ593/hxTS7WfuKcpeT/vgO+NFoqx7bH8HYfKt3V6VmMumTSYIixQiq07va5gN1YNsz4lMq2Hc6yJ8gg+mVVol4zxIUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo5pnkUe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so1851966b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717589; x=1729322389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei1bnltRJdZvKwzxVRf43H9d7hPRtvBawiK2S1vBv6g=;
        b=Zo5pnkUe4h3zTjZjaxuom6LD6LYnVc8H5kMRABp/yaBK4R/s5UaaJz2Xf00OKCwNEu
         rws2xXo0ZuMq0oLMRXRoeHfRS/QSpXGpbXE1r8+dJYE8YsTt/JXfto6wODxBJDz0UkAb
         6VJDheysQXdBR+JTeUZMCmqB6johrV2tR+/BGcZavBOGV9Li6UflCmd897/DGStwbe9B
         d5CyKVmXwsee7B6nsjBztyQ015TxAO4lT0yRC7DwFZRH/JQEFt51jPsmi4kzsAJuzoTO
         MDSLgSrFcivcl+NsaFHUR4M7uwyvXK8loWvfwxjX2Yn+P/OiqUGDKwwcQUIbtFSAmZBb
         uWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717589; x=1729322389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei1bnltRJdZvKwzxVRf43H9d7hPRtvBawiK2S1vBv6g=;
        b=usdSu6ES3dh51PDIadyzrBsaZ4MVyFIWe1dqap+qVFszcRE/k23DgdwLgyOXuP0K2v
         VTVI5TBDgp8xmFf3IHqBYaUHsFyDZIUfI7GKTZvgbUcXESbbbrWNqGADIGDSOq+AoV63
         i2jaoGEc5lSgWOEbUItfVmz/q7jvfk84hw1AlYqguW/om3QwGE16mD+kV4kuIldVmyhH
         CU7u6Cq49/vVcTc+DrxdE9zjKyvl1ByFmJylx07JEyCWHcFMptfk7SPH/44SAV4Drlez
         R/S6nbvpRbgD5sNlLxrSwyEGAqGT2XYouVFW1S1ZMfG7CUUyVkSvrBF9hU6GewGSKQqv
         qfPw==
X-Forwarded-Encrypted: i=1; AJvYcCV6nPQWzWYGlhSx/0XqzUBeEAWVGDg0w71/0kEfiGe1NODvfN1gNj/ak9vuUaxlMzLK1bs4E3kmS02haCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNVRb041cgEM5NuohY7Ygbc9obujcSbzhVBbtt4ohiZtXaJL1
	aeXaUPoYT/9d5/6hc8wKzxsvretYSwmRlBMIW0L+GLHwgeZ5f+bv
X-Google-Smtp-Source: AGHT+IGHNnL0hR5nCBDTCirZJfQbJMU9jdSi821rPi96/CgZugLrK7sJ+5WJuuelZIParpqlLGUGPw==
X-Received: by 2002:aa7:8e5a:0:b0:71d:f240:ec5 with SMTP id d2e1a72fcca58-71e26effbf5mr14046534b3a.14.1728717589354;
        Sat, 12 Oct 2024 00:19:49 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba171sm3664620b3a.161.2024.10.12.00.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:19:49 -0700 (PDT)
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
Subject: [PATCH v3 3/6] phy: rockchip-pcie: Use regmap_read_poll_timeout() for PCIe reference clk PLL status
Date: Sat, 12 Oct 2024 12:49:05 +0530
Message-ID: <20241012071919.3726-4-linux.amoon@gmail.com>
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

Replace open-coded phy PCIe reference clk PLL status polling with
regmap_read_poll_timeout API. This change simplifies the code without
altering functionality.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: None.
v2: Fix the subject, add the missing () in the function name,
    Fix the typo reference
v1: None.
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 56 +++++++-----------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index b5b1b1a667b2..e60f24b0b363 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -162,7 +162,6 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 	struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
 	int err = 0;
 	u32 status;
-	unsigned long timeout;
 
 	mutex_lock(&rk_phy->pcie_mutex);
 
@@ -191,21 +190,11 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 	 * so we make it large enough here. And we use loop-break
 	 * method which should not be harmful.
 	 */
-	timeout = jiffies + msecs_to_jiffies(1000);
-
-	err = -EINVAL;
-	while (time_before(jiffies, timeout)) {
-		regmap_read(rk_phy->reg_base,
-			    rk_phy->phy_data->pcie_status,
-			    &status);
-		if (status & PHY_PLL_LOCKED) {
-			dev_dbg(&phy->dev, "pll locked!\n");
-			err = 0;
-			break;
-		}
-		msleep(20);
-	}
-
+	err = regmap_read_poll_timeout(rk_phy->reg_base,
+				       rk_phy->phy_data->pcie_status,
+				       status,
+				       status & PHY_PLL_LOCKED,
+				       200, 100000);
 	if (err) {
 		dev_err(&phy->dev, "pll lock timeout!\n");
 		goto err_pll_lock;
@@ -214,19 +203,11 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 	phy_wr_cfg(rk_phy, PHY_CFG_CLK_TEST, PHY_CFG_SEPE_RATE);
 	phy_wr_cfg(rk_phy, PHY_CFG_CLK_SCC, PHY_CFG_PLL_100M);
 
-	err = -ETIMEDOUT;
-	while (time_before(jiffies, timeout)) {
-		regmap_read(rk_phy->reg_base,
-			    rk_phy->phy_data->pcie_status,
-			    &status);
-		if (!(status & PHY_PLL_OUTPUT)) {
-			dev_dbg(&phy->dev, "pll output enable done!\n");
-			err = 0;
-			break;
-		}
-		msleep(20);
-	}
-
+	err = regmap_read_poll_timeout(rk_phy->reg_base,
+				       rk_phy->phy_data->pcie_status,
+				       status,
+				       !(status & PHY_PLL_OUTPUT),
+				       200, 100000);
 	if (err) {
 		dev_err(&phy->dev, "pll output enable timeout!\n");
 		goto err_pll_lock;
@@ -236,19 +217,12 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
 		     HIWORD_UPDATE(PHY_CFG_PLL_LOCK,
 				   PHY_CFG_ADDR_MASK,
 				   PHY_CFG_ADDR_SHIFT));
-	err = -EINVAL;
-	while (time_before(jiffies, timeout)) {
-		regmap_read(rk_phy->reg_base,
-			    rk_phy->phy_data->pcie_status,
-			    &status);
-		if (status & PHY_PLL_LOCKED) {
-			dev_dbg(&phy->dev, "pll relocked!\n");
-			err = 0;
-			break;
-		}
-		msleep(20);
-	}
 
+	err = regmap_read_poll_timeout(rk_phy->reg_base,
+				       rk_phy->phy_data->pcie_status,
+				       status,
+				       status & PHY_PLL_LOCKED,
+				       200, 100000);
 	if (err) {
 		dev_err(&phy->dev, "pll relock timeout!\n");
 		goto err_pll_lock;
-- 
2.44.0


