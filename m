Return-Path: <linux-kernel+bounces-352725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902999234A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD510B22786
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 03:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371512E1D1;
	Mon,  7 Oct 2024 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMSSnohX"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD71304BA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273408; cv=none; b=rwj9RbwKOL2cDzUIWDerOhOfmb4SIUrbRpXeVskUh2ng8SVYTqVyS1HhNXYCah1ynHh4Q7sdAx4tHFaDt8XwdhPwFOtIpKjX3Wnogtt+kcu8g5gBn54QQ1GnajASTXZz4k3v9zsLOkfycO7AxaLFxP1kVuqAMR3Gd21jsnR59sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273408; c=relaxed/simple;
	bh=HGJcJYGUUUwN6MUujIfQqbi4Vc5dDlaDUipXMzu7JU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdPMOQRV+pAud9RnrMlBl5tgYdRNgpZ32w43lIOn1t3pIvMwfiiKNt3Q3/0lZm8R3hcJ+6Bp3m/qU7d94/wDkKcYTkeM2+1Wj2xmCurLSQu3Rm0P1Z+ZfMhab4/0m0tcZKLMLZC54B/FRDxNOIZ7Ij2cnZ2i7xbkp79pR8FFzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMSSnohX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e050190ddso260038b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 20:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728273406; x=1728878206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Yl2K4EmUgHgFL47sO4eEWU/jT7JgMHndlEzcZuCb+c=;
        b=iMSSnohXv9pPnY9DeaVe+f9VRi/JC2ETcNAZEMhDBWrEQtGdYv6VMs3Lsq6lNHIvWK
         dvAbXgxjiaAvLc86VW/n2UDM/ohUHwPKINKqRmhk4hBqpEuGaqLT1E3lIQ4V2bOhjD0r
         iSIfLEHeNl5IlQHKJoMLkqJBCEG+ylCdQ92CnrYCL40e2y7afukN4LASvwrPTZBKpccJ
         1eTfCVKjxCBKO/KcP1i2jcorAtdbykpPW+yMdsHjy741UKrH9D5ipkYMXUSeC4P/uHkk
         OCgyVUOhFHjkHZlRb7dQ8pg/i3o2dw9IjGbA9uavJ4KiqnrdCJr0MyuvZnlbKgQslAuC
         w+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728273406; x=1728878206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Yl2K4EmUgHgFL47sO4eEWU/jT7JgMHndlEzcZuCb+c=;
        b=fpqUcgJMqPh/4MWacLew+ISVt9AFiXHS4kAClX7y2AjRVYf3GndJrHFHPBF//9k/sT
         8VsXt3fnZOXQJiQm4wtwUqZ2TnrcfJdi8MQ2JTF67Jqmx1WjcTYEQZORDAV513GKxNqB
         uQCS6S0+4jbNHLef/EenjPhLhnMtHaxQ46vYOmu1MZzXWqaPpy2gNBKPeunjVjBRxOl+
         +rij8IXVIfMWOCqyz1bBHCckrfFbN8gbtPIOrJb5oxVDK26nbkDMDPAl3gLcbJt5v6kI
         0w3qU1e3MBDCZLoDeCawqCyaCU/enrfV6so8tPAd1ufT8vAmd1J0SdN8EJ31338Nj6oC
         zWRw==
X-Forwarded-Encrypted: i=1; AJvYcCV/IfW7deripj3b9JcKX0lBHOO4QKL/odp8ySEb6kyTJC4QJVzI1fQmad+ZA2L9vR+2/lDIVRs2s9nCQaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQhP4KbF/sgwMx5r0ldmItveUB1cygDh7KfpCi9WpT3nmpAYH
	kC5yFMbNF3g8O/sJ19Dli/pm80zJpXlAZa2++s3VUzy+qUssZItG
X-Google-Smtp-Source: AGHT+IG2Zgblg95zfw1iMCpAfHL2xKdST9d36NrXxikTBWWWicgc6zwdWqnGZd9qLMDNR+2EHrmRGQ==
X-Received: by 2002:a05:6a21:9cca:b0:1cf:6c64:f924 with SMTP id adf61e73a8af0-1d6dfacacedmr16387346637.38.1728273406386;
        Sun, 06 Oct 2024 20:56:46 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbbac6sm3451322b3a.39.2024.10.06.20.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 20:56:46 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 3/3] phy: rockchip-pcie: Use regmap_read_poll_timeout() for PCIe reference clk PLL status
Date: Mon,  7 Oct 2024 09:26:11 +0530
Message-ID: <20241007035616.2701-4-linux.amoon@gmail.com>
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

Replace open-coded phy PCIe reference clk PLL status polling with
regmap_read_poll_timeout API. This change simplifies the code without
altering functionality.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: Fix the subject, add the missing () in the function name,
    Fix the typo reference
v1: None.
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


