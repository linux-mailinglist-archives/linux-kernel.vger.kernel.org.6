Return-Path: <linux-kernel+bounces-352723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DB992348
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7661C21CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 03:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F83FB9F;
	Mon,  7 Oct 2024 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDv7LfDW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF538F97
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273398; cv=none; b=SJDfWbSM35mEgOn9PvNKUpBqOfkVfi8iTiDBfknpi84FtLHmOluZOvhuuIAV2bOgN3CZZzVuibd1h7EuSKsW7AcmamKefR4aiDcEA1EUVl6wdiKKye2B1K2fhzL6hsPsQ5b1V+ybsZDT2DnhDxQeZwaH0WOA3BhUVgRl4fcKtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273398; c=relaxed/simple;
	bh=SqJK5nyTFwsAof43gECb+iyKlt+JC/TczrUSIJLmuJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLJ9BquN1jNl3PkmRXGbuTPODoXNXyVOh+aKTLiv9MMxjzRsisrHkuV9QGV4DOraDSfGhzZLNFZb6eoKRHy9xKZrF9XWcnnFE9M0jQGLK3KjlR8U+o262Q+nKqFlIUzQDNjMj2GC7pHen2a8IqthB+o7QUfeJEwO2H1H67leKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDv7LfDW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71df67c67fcso812777b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 20:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728273397; x=1728878197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xZ0sSFTRQLD8htIs0XMnH5FhNQDjNg6QCAysEVYUBQ=;
        b=mDv7LfDWuVo3dKL2aygkUY89ut0EJa8wGkCeJskaIYDmN5+ci7WkD7ulpBJs9QrhWJ
         NrZFvvt/nqw+TCqsQvPhkEgnztJ36/PkgS92AV2t2I6DAQWrYrNT96v6BJCPDFhQMwkB
         l+n/7BAz+XzsKOm4sVA01OpRCb2Cza821CJs22lcbcv/Fm94gUFpkcLFHf0f9TGdYFKp
         4XsB3M4r3eEfg6Azps+4hSqvs7Ih7ubrPc6HHbfzXgvm8f+gith5493rXhH2UYjvShXW
         3N431FJFtXmhOh2HER0AdcCG1l0GJUnF84WlzBSFy4N8kZGDW33xP4+8in6FPvVAD5NT
         SgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728273397; x=1728878197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xZ0sSFTRQLD8htIs0XMnH5FhNQDjNg6QCAysEVYUBQ=;
        b=BH8x5JpLXVQx06bs1qQJIDJEHfGUJwhcAW0aO7h34J8ZSpMLbdGYQ0r2aU3woHqNPo
         7xJ5CphOm6S0lwkNf1J+JeCDFiYLXEK2SFWD2q4HWtVLRoeN4dnoc2XpadTiKjhiRYhV
         1BOxkUG+h+Li+rl0jg3vUfDRD3kQe/jKUFb8iGWInai7THxtlwk+AoPyclMqi7cZpdRY
         dRKJaWtNweDN3aN/ijj+LlIIEyOV/z/HoNW3fR3+exlnhZPjOaFsEo5wVbKgxM+bvg4q
         MWbrnOZ61ZRHfbILTX9R+LyhbsYbCBfVmx33qQ/QQBnCmmEh9hYCrTI8TmRMmkkZ62Y1
         Fnzw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGZmRXHj5Net1YsVYKpRFmbpwUHZ9ozdwX9N8lOwzDftCMfoXnrji2dzTWm02F4EDCa0XckpFoX2km7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHjLOGPlWBTfYeuv7bCTFl6SZDna+VmrB1+YQaCEG/41LnMJd
	+MSIssXG1sTdDNyICv41cHQ6oon+ifudRaI0cgnLjCt7L+Yv7FxH
X-Google-Smtp-Source: AGHT+IGRbfQ8Ygsa7B/NPIUIYHPuPbH6Ec8dQH336nVKqtXQ6uAhYhVO9BVtb98LpLQywzEMyD5EiQ==
X-Received: by 2002:a05:6a21:27a7:b0:1d6:f623:17ab with SMTP id adf61e73a8af0-1d6f62318a4mr5355559637.12.1728273396761;
        Sun, 06 Oct 2024 20:56:36 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbbac6sm3451322b3a.39.2024.10.06.20.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 20:56:36 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 1/3] phy: rockchip-pcie: Simplify error handling with dev_err_probe()
Date: Mon,  7 Oct 2024 09:26:09 +0530
Message-ID: <20241007035616.2701-2-linux.amoon@gmail.com>
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

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when -EDEFER is returned and useless error
is printed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: None
v1: None
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


