Return-Path: <linux-kernel+bounces-310365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F8967BC8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CF31C21689
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0015139CEC;
	Sun,  1 Sep 2024 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUuYby4T"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96289137932
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725215656; cv=none; b=BJgiQ/XvJB2nfUWjwuGcwWYMhhhg9CVi67LVsI+zuIF+nuDQ1GuCXhnfhcj7mJZTSzQkunPqOKw9+AN9JhT5hETR5by6P5+s2B78y9w9LUWQPv8j3oXNSYjIAdEYYaXHp7qwPJZ+L04RK/Xmj4+6Ihs+/Q+UfB68Hacp7OyUwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725215656; c=relaxed/simple;
	bh=jKdUu1ExBco5S0KbNsN6/B0IKs4k668rF87+upIk1BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu2NRhusiQgFKOI4LBKmitIiAYIIlOUdkMJUJh+1G2YJFjtrkWkX58MaGv0rJk4+ek+egWzmcjbyAsv+p28qVdpJF6QGGx0hutBNW5ob6yQBlXkTg8f+uynSfA1nfpcfkDXt7sVI6NvM9Lr/eEObzXIJ1k/WD8iOOVDN3WuwMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUuYby4T; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021a99af5eso29041725ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725215654; x=1725820454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLCyRC657hgOtTBOAgAwcacwSzgshdziSy5VI8t2Gq0=;
        b=KUuYby4TjeQqQ3W2S6Y1SsPQSymbp5alwd4ViqwaJ2djTCPaufu8BuxTXYKDs9etxC
         ardYFDV/Xa0n/vrdt5uRmkr0emKBBJdjFG4vh6ERIo2nAYfMiUhHRPUoeWCDZ4deSL7B
         riIfHSR6WMPlKFz58NPcNQxC6DvTl1Y6t5KlMNJe+3UrgctsPADTS2sWqld8/kKYfcDl
         kKC9r8rStfg0pO3Qeam4xElA8RtAVcc/1ylKVBkdvs/HMl9spx00DHsdsVYNrFlfEXv4
         MXGO7dXfs6DBoBwNtJ/POe4u1Vs9hrRJHFpsaSY7tQa+1QNy4SVlvE3thTOr+h2G2Q3g
         iW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725215654; x=1725820454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLCyRC657hgOtTBOAgAwcacwSzgshdziSy5VI8t2Gq0=;
        b=RvGcWOdAVGYFCD9FYP+7aBRYzKqSWqx03nNtyYSDqdkoEBylnYv+Td7g2LrRjN+ZRQ
         iakxHBtSwwVIp7xlH8UFaYsVC8NLwxCWGACOBqf7Hz777lZT32PGWoHtVRC1rs4O/vjA
         XtmloGhzOd+Pp/lJU3ZG6x0GQTvSq0OaYvMgZNRl8+aiMi5bDsd6F2EDiF2tjJYqpCnv
         7JcmMxj0CYiwsmrtaRJsOhsOM4p5JcazavftOvDC3MnFMfdi/ufjM3QwfSsQOgD6nJua
         UMUy9d7wjuo4Q70JiMxhyzKW2x6OdWpVQl3xiLhSNXqq03h7bK9fF/LLTa1FZjUJ4oUH
         eJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCU+0rs2JKvZisKBMEutGDPigqHe4U0XfC02gFpSF+OvoY5BlHZnJa/cNvDgXqMnpmludtPKt7+k4pG+C0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyacnbVbE3LJUbOnh/REgPm3ddtgIcxfCZxwwatziZ04CHgADLN
	MMAM1UxwrYWOSITQbH+fHpApNo31cb3sQ2+8bWjSDrzpSSiybk3g
X-Google-Smtp-Source: AGHT+IE0DF0h8dNkgogZ/U5Ym66OZuvgg8ZiSDLJNUPCI1HaXLR9hpfBmfxTQjfDGWPLFLoNSdDjfw==
X-Received: by 2002:a17:902:ced2:b0:1fd:791d:1437 with SMTP id d9443c01a7336-2058417b1d9mr426515ad.6.1725215653750;
        Sun, 01 Sep 2024 11:34:13 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559b793f8sm16262405ad.15.2024.09.01.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:34:13 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] phy: rockchip-pcie: Use regmap_read_poll_timeout for PCIe reference clk PLL status
Date: Mon,  2 Sep 2024 00:02:13 +0530
Message-ID: <20240901183221.240361-7-linux.amoon@gmail.com>
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

Replace open-coded phy PCIe reference clk PLL status polling with
regmap_read_poll_timeout API. This change simplifies the code without
altering functionality.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5: New patch in this seriese
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 56 +++++++-----------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index a1b4b0323e9d..2c4d6f68f02a 100644
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


