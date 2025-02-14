Return-Path: <linux-kernel+bounces-515161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6AFA3610F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7118C188EE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5A526739A;
	Fri, 14 Feb 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJWazoGX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6995266F1A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545753; cv=none; b=S4lRhFLQ3vvOfB0iAmv0SD9WLE7ZtBuOln5KToXsbTX9NQYRXtdh0+TzXRDN3/6TU4Q4IuqiAVg2/zU4eGOIRXu73oGxqqTHs4zR8bmVXJEVxp6lRok+2K0CkJX53O9MO4aYQ6AXeAuYAPV6ZFI7s7Kx0DJ3eBHqJFDxHrva9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545753; c=relaxed/simple;
	bh=BQ4ctpKzt2JNBBm/FezOIGSkr/SYl7Hi5IRx7EgvobQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvnK3bfX2/k6G9ck4MeHtUmz7EKLi9Jl+pcUfveXSXuZHWLo9WB1bATW0T/q56gvlvzg/BUedePQ8uPxTvVeDwkJD7umxWke6JArc4Qts42j4keAtUXnxyLnIxfJHK8k4q6+fFPOfm6kxs+5y+IeznzKYiEjH/B4K/TqwW1k9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YJWazoGX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7f9f57192so36986766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739545750; x=1740150550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GstLIXqd1K/ZKQfJCz4c26uEua+iUU1422NpxaHZF0=;
        b=YJWazoGXTuT0dc7Ch1owdLLCts7/Gd0oMXsV7rKdZyy4osFXPNJI+8NXrY5pKE8URZ
         x7oC8ppswz6GEsTVYc/ebflLd7U56oeYWLILM0scdgYqmJPEm5iJnt4cHuIdiV0j8TDw
         c5VL3iKGOIit5EzQnP/+n+p4dD5BaYssWUeTSAiotT32AozwXO5ACIhJLVdYShJr506m
         SRunYlGlgSYJc/zoyMEUNm+jNCL3DsikSB3PVcH/HjT4jPF/+XHny1yQ+sV3F4ednv/6
         8Lp4+dAmSvRM7yfC4nbLzST1Q0wuYB9/eh9rkrcoz6a0WzphA3O6s7KA/362taq0Yfm3
         JSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545750; x=1740150550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GstLIXqd1K/ZKQfJCz4c26uEua+iUU1422NpxaHZF0=;
        b=FaVRagHY6+oFLYi1hHmcO777mXqDEht4L7/tQgy+G80Yn/3/Ui2mW7olezbhGJuYbW
         4RYnOqQkUelqqQqni8OzVsoftY2o7kbR7saa06wdNkPVNQb4gZWfXjPI+4s6UiUhRlLt
         ELl7oAj9naAZ/Yi7DM0m5CaD9e8RMT8hFD3FYQbsafeFBIH4xTlfuf1iRgXr5Y49xZcJ
         9gKic8ZoC/JKdy8CmczLnYtB3ICoIZ2VucKrP1DQTqP0kWntN53N1IZqtuKvuthiSq9O
         13larL4uzNneYwe2IgEYGjToBH4V3tcbEE4+C5Qf8zQu2pg5ZkTUCHQhxvYDAN1AvcLA
         AaSg==
X-Forwarded-Encrypted: i=1; AJvYcCXaZ7WhFpBhcyG36kGBWJMvMWkrcSfCn4XBHsLDbLApEIOIRU8H/h6PvZaz/21OTlD8vA8gLztsr6o/Pu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgi5ONA4iBlJE1thI7/ZlT1MBytp8qPRDu/VrIjRI9NTms5xAK
	RYaTfN2mBYVZxOtc366jsLALPCDUptIs6+fABHCpMmP82OZ3xKkJpXfxfQ0R4iY=
X-Gm-Gg: ASbGncvRAPmJP1b1zqdE9rEESoh1flTpGFqa9WuyYmWP0NImHqd4Hm8DhxoNsr/A269
	HlLpWUZllwqxAgpBBxynruuiMcWhVqsZv4IxIDpnYvFDg3P/G8ByQNyRbmS8wKVs8MRrqzXvQvO
	piiol70QVKI/Mhr/l/G+jZR31oWs28iKMLBaFq7K9YP2px54JRa097APWUh0lwWnbRaP+Pl5tDK
	Yvz5IyO4a8NS8Bl3jda64Muw0WFimS6gUxHLIbPnqNDMgltEUMcKJsIw6ZkHSL659IaN/oU14XH
	wFUJBUr2RYE2z/BNZYSLsgQ9sn4Xqf4=
X-Google-Smtp-Source: AGHT+IEzVqM+iUmxc7skwIAEYucZ3akEM3g7G8GQlo3NC2U8yusEjhbXvucjr1pSP1U70ccqH5eCWg==
X-Received: by 2002:a17:907:9720:b0:ab7:be81:893b with SMTP id a640c23a62f3a-ab7f318e3f8mr491212166b.0.1739545750041;
        Fri, 14 Feb 2025 07:09:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bf70asm356266766b.180.2025.02.14.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:09:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Feb 2025 16:08:43 +0100
Subject: [PATCH v3 3/4] drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1
 when choosing bitclk source
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-drm-msm-phy-pll-cfg-reg-v3-3-0943b850722c@linaro.org>
References: <20250214-drm-msm-phy-pll-cfg-reg-v3-0-0943b850722c@linaro.org>
In-Reply-To: <20250214-drm-msm-phy-pll-cfg-reg-v3-0-0943b850722c@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rob Clark <robdclark@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2592;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BQ4ctpKzt2JNBBm/FezOIGSkr/SYl7Hi5IRx7EgvobQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr1yMWlXDCCR0YeuZkcFoQUPFixkLcf1UZ+u1H
 9ehMouSx6iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69cjAAKCRDBN2bmhouD
 1yxpD/9hIXb1N3TiLm97hyItMPG7g63u9pCjssD653f4reFjoc0jJWXob0VogwGA28ddfd2BZmH
 vFdKX9XZjh/AvDFseBOPyLcli9Fjxch911KpBsKSmq9q6Q3nUbQd5P8+Xn3Ht2dbwvQLKfh3Kvd
 FNqXJHVP27uxS4mvgwEAyTBCsh+wVu3B4J55nqzedi1+1qMVpnhLxA3X0F3vTiX5H0iWtIkimfm
 MJRMtrVfnB7n02Ygu5H2jZFGUlXpS93eEm9XI1fvsP0/mzyvnCA1SlwbA2XdaFbLH0edDX3VAFz
 audt3Y8np4Ag0nCwAWcyZnVzktz8gpzugw/IsXHAOUdEy4HCSYY7yt7a8lFPhcYTBB0+fUIia6i
 KYmZeyNZHGp3PE1vH4yxjru1Uh4xy3wzzaaxRIHsGWgEpzp3dkIzjeNC6+6YSWgU/uWIKNXSiip
 OKEcR5HRjyhW6vEUGX2WrqfNsUbVoTdGOXtjMnkZwwgdWFJ8A7qQyNRmRu8zrWk/lNolXlZoseD
 N5sezKQ+i951OTx1h1iVSbs6tYzAMRc6W6Li0jKsB8CHLqvGBnHE3n11DJC+yBbn2dKwv0ffUur
 GZ5X88+ofzEY6vDY+2hujXWxKT65+hirW9+QhQvxpBFLQukUvSWw/luF39lQeE0vyMulTx4OctK
 imlK6EKYwx9z9Nw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

PHY_CMN_CLK_CFG1 register has four fields being used in the driver: DSI
clock divider, source of bitclk and two for enabling the DSI PHY PLL
clocks.

dsi_7nm_set_usecase() sets only the source of bitclk, so should leave
all other bits untouched.  Use newly introduced
dsi_pll_cmn_clk_cfg1_update() to update respective bits without
overwriting the rest.

While shuffling the code, define and use PHY_CMN_CLK_CFG1 bitfields to
make the code more readable and obvious.

Fixes: 1ef7c99d145c ("drm/msm/dsi: add support for 7nm DSI PHY/PLL")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Define bitfields (move here parts from patch #4)
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 4 ++--
 drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 388017db45d802c4ef1299296f932c4182512aae..798168180c1ab6c96ec2384f854302720cb27932 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -617,7 +617,6 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
 static int dsi_7nm_set_usecase(struct msm_dsi_phy *phy)
 {
 	struct dsi_pll_7nm *pll_7nm = to_pll_7nm(phy->vco_hw);
-	void __iomem *base = phy->base;
 	u32 data = 0x0;	/* internal PLL */
 
 	DBG("DSI PLL%d", pll_7nm->phy->id);
@@ -636,7 +635,8 @@ static int dsi_7nm_set_usecase(struct msm_dsi_phy *phy)
 	}
 
 	/* set PLL src */
-	writel(data << 2, base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
+	dsi_pll_cmn_clk_cfg1_update(pll_7nm, DSI_7nm_PHY_CMN_CLK_CFG1_BITCLK_SEL__MASK,
+				    DSI_7nm_PHY_CMN_CLK_CFG1_BITCLK_SEL(data));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
index cfaf78c028b1325682889a5c2d8fffd0268122cf..35f7f40e405b7dd9687725eae754522a7136725e 100644
--- a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
+++ b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
@@ -16,6 +16,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x00014" name="CLK_CFG1">
 		<bitfield name="CLK_EN" pos="5" type="boolean"/>
 		<bitfield name="CLK_EN_SEL" pos="4" type="boolean"/>
+		<bitfield name="BITCLK_SEL" low="2" high="3" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00018" name="GLBL_CTRL"/>
 	<reg32 offset="0x0001c" name="RBUF_CTRL"/>

-- 
2.43.0


