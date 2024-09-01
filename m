Return-Path: <linux-kernel+bounces-310363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C387967BC6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DE3281F2B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA754662;
	Sun,  1 Sep 2024 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8xVHYd3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752B51016
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725215646; cv=none; b=KW3NHaBL6Utb14EpsFPIf6cVQyG2FU037EAJdNY/oa9yVwRRUEol+xOrPjiDO3tqBPZ+rI/cdwPLix8x7VyoPf7ZxKmbZFsUo2KEvN6vY0Ii5Nnfr2pzVy/n/BsO7p5IUHQus22vXGrtuCptbuYJPfkLoyFye22lcghctIE+lLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725215646; c=relaxed/simple;
	bh=m5f/nnjmJ74rQ71ubTnv9CjpKdYFxHSITGk3ET2Bhs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1kmYaxXmMCTSwVLpOtUStroptesGwq5PCS3Cvi5+mqhbFnCFa4Kw9qiR2zXnp2Jukf1bWw63Vp7HVlJco4NZ0I5n4i7JlZzZ0kCFz3TzLTUHDVHTwdaCR7qG7L1qa4ObbVDbBi9xaIRqVf+ZfUDoKEu+HIS921gS85miuJtO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8xVHYd3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201fbd0d7c2so28238585ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725215644; x=1725820444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs7r7/Zx+L7jgSgyX/lH7TsYQ/OmfRm7Q2KA/O4kFP4=;
        b=D8xVHYd3gAUjeuAqCNOED8rZiiod0H0f/yCqFtOGbgbBeY6SYE0OHq5HnSrfs/AXhN
         PuRvwMVni8AypmvGwl3iODAntbO14RneExScvcTgNw1kGrdiHcuoLMoMLO6AkACADYWO
         2n65Gd1UUm3nc7vXXb5HXwNzVRMl4kG6wjEK2o7wdAOvS4WMz8WFOrr+DTQQGdL5wEQd
         Iogu9JT4gtISVgs759j89PAVR8AQJMSlb/GM0QksMj0TAL7n4DuyvmWIgH8+F6bFGlug
         SzVNl0iJXEEebqb9GlqAMtxp8rCiAobYrsxDN8nwviDJYbWFDt59nSKjOXDjWiG72kcs
         MOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725215644; x=1725820444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs7r7/Zx+L7jgSgyX/lH7TsYQ/OmfRm7Q2KA/O4kFP4=;
        b=FRBK87roQi6eZZsubWD04aI4TtFmkghgKZ8WhK618tkC3azez3udpe50T+pVk7bgWf
         YccffecudKacWIzPkWCGnSBrt6evIs7TP7b0kpfrgu/9OPlddwH91K4+Czc3CwH7iors
         fMkq2xvrVnqu1/UMrYQGMlt6j+m2cZ4t+EKUSiEv6rB+jmaZBWZpFd9f29pc29hejt/C
         7O9a67HpDQxKWuMiv6KFkvTAvumXcKOOeZPc90ENDYG60py05TcGz62Cmggj693tE9sL
         uTS4D/bGJEoi7or1XpvhkRk/INfgJ0f6wXnDmfSWVDWk58YFb1qxCEeQC129k2/su8rC
         qveA==
X-Forwarded-Encrypted: i=1; AJvYcCUgUNeOMKBNjvvEmWBrrugIZvFrbZe4aG/ek8p9vcQChJZTVClRRNAQCdlwuiyczJjRfMnwEoEFB9zh1Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDPlMtzSmX3nPNHWM142ghSvLreMCxPGK6VekMXywJYWeP+HD
	ug4na/mA0szZE9UclsY52f6u6d+xEp+vWpI3U6K6pn+BVkFCfuI1bEKJOA==
X-Google-Smtp-Source: AGHT+IEC1rG0a4oSqwPB+FBRd7vgpBdtvMr3n/IBlgrouflEoKepJ4FUNU7icdPjsa6KdeQlrynBGw==
X-Received: by 2002:a17:902:ec81:b0:201:efe7:cafc with SMTP id d9443c01a7336-205444fc15fmr66090815ad.23.1725215644468;
        Sun, 01 Sep 2024 11:34:04 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559b793f8sm16262405ad.15.2024.09.01.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:34:04 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] phy: rockchip-pcie: Simplify error handling with dev_err_probe()
Date: Mon,  2 Sep 2024 00:02:11 +0530
Message-ID: <20240901183221.240361-5-linux.amoon@gmail.com>
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

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when -EDEFER is returned and useless error
is printed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5: New patch in this series
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


