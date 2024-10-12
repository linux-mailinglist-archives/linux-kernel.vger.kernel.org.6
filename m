Return-Path: <linux-kernel+bounces-362135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5299B17C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68DF2845A2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CB913DDA7;
	Sat, 12 Oct 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFZ5XuPu"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE4126BE1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717581; cv=none; b=XVktjJwjPdt3+ulh9K/jrrgUwA+9YP/UoiLMWbjl0xcxRkgnhkQ51xCGSs2qdy5435UwN37eW0w06MruQL41DEWORrCjgLj+Zp4PkFqLenMbuj3X8PXFRKx9YJmP45A5tKS6a+rtgazIL7J4mzWyJr/c1MTLZwcteFC3NrPmeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717581; c=relaxed/simple;
	bh=QUpie//8a2pVA2kTIf37Wc0ZfgiY+n1sBlkCEjqbu/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShmsEOXwytYJqHA5QlBiT29ZPlW/hPhcMuPo7elm0mNcDx3GqQBfgcCo0+tiqtU0F4ZyvhuZWW1HmyfalIHyUtxqPoNWOL7iECApAIPbu4MSZYb1ms1r7rlOZK/0QX2ACIz9vYpNCV+rlPHaHZmRQ+Pw7lwUXyTLSHB/aA1bK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFZ5XuPu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71df468496fso2504709b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717579; x=1729322379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRnaRhdgkUaUMlLRJLvxIED2m3y6s8utZfCC8ysa670=;
        b=aFZ5XuPuVTaMo7v9akv1Zw/0kOKawFARi6FiUeUncDluTTh4h8t879fG0UvKWV1l3B
         YSrjtxK393jqdhmL3kyV6HmvdpA4CL1/cHR83B2xN/PZ1ns9KOKIQvqecIqTQX3WHwON
         7A/1EU6XtzIKPJeh99GiMAMtQEOq/9NMf7wb4qgItAdy4zSsG+ExcZfpHtglqeCHz3MY
         PPvkddBcGtgjnYZlyAyKYc1PdSmeB7mL/JIbhokKaZtIpF6LNCLV5NRXAaFDbkP9aMIw
         lcUVNfsF9PBGYKMzsFif53kTLpKfK/nnIeV2YwMpIWSvcr7Pv4TWKdyxwe2yYpZaZ09q
         KJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717579; x=1729322379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRnaRhdgkUaUMlLRJLvxIED2m3y6s8utZfCC8ysa670=;
        b=OelGaSFelfWPUILGNd4FEGMmyTiYvkWYjc0ny8p/g3Qa8hvyYNx7HvAUlahnuB0vht
         Ms8mpX/cSN3RXkGu31kqnAaPiSJvKBm62Sm5lMO0Dqs1LwDGqOSb8C59aTu9yd6YZRz+
         zjSKYS2NiKzW9erUqEFiGuzOZu9y5U+UVS9ngPUSBJiwPc+vO9fBi1AQ7j5x+vxP5XNd
         ZapxgJVcYJm8nLWtVpLlwqOe6/V4zKUGDQl21Pef32UxeJZ0T3VmNMVl/SYtm/jTbZ7K
         rXBqH3h6ypSYEkbHS3v3KhA+PMu2S96uZybBXPVbkZOr/dQjqAI5F9/RehBmI7TycBLC
         h2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUjyZUwxCZP95uVUcBqAjBPxyDjKCO+5IwQOpNy3cDjxzU0CNIGQ7vC6UwMeaTuclQ596e9nrEOJ/E2VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfptHXNO0P/zzU04oxZR3eAsl4k91Ulsh78ygM1zVX1qexN/B
	0gUecos7PQqr16jT6vYnCYNLD0k2MbBYlUdVZVKLxDcRHoIJY1gA
X-Google-Smtp-Source: AGHT+IFBdUwCJYRaP9uIilAhxIH8b2VIJABfgd2ZHHwiTppROC77o42YtpLJtRJ3UBXTnvVl99LC5w==
X-Received: by 2002:a05:6a00:228f:b0:714:2198:26bd with SMTP id d2e1a72fcca58-71e37e4a7b6mr8409189b3a.11.1728717579344;
        Sat, 12 Oct 2024 00:19:39 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba171sm3664620b3a.161.2024.10.12.00.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:19:39 -0700 (PDT)
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
Subject: [PATCH v3 1/6] phy: rockchip-pcie: Simplify error handling with dev_err_probe()
Date: Sat, 12 Oct 2024 12:49:03 +0530
Message-ID: <20241012071919.3726-2-linux.amoon@gmail.com>
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

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when -EDEFER is returned and useless error
is printed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: None
v3: None
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 51cc5ece0e63..51e636a1ce33 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -371,12 +371,9 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	mutex_init(&rk_phy->pcie_mutex);
 
 	rk_phy->phy_rst = devm_reset_control_get(dev, "phy");
-	if (IS_ERR(rk_phy->phy_rst)) {
-		if (PTR_ERR(rk_phy->phy_rst) != -EPROBE_DEFER)
-			dev_err(dev,
-				"missing phy property for reset controller\n");
-		return PTR_ERR(rk_phy->phy_rst);
-	}
+	if (IS_ERR(rk_phy->phy_rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk_phy->phy_rst),
+				     "missing phy property for reset controller\n");
 
 	rk_phy->clk_pciephy_ref = devm_clk_get(dev, "refclk");
 	if (IS_ERR(rk_phy->clk_pciephy_ref)) {
-- 
2.44.0


