Return-Path: <linux-kernel+bounces-515162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B896A36111
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413CB16D4EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24AD26659F;
	Fri, 14 Feb 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNuS80tN"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795F2673B9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545759; cv=none; b=tDGldhlQP1f+J1HEFBnWELsanHLVEdp4vVLLeBoXMkW4bhyKKFHFivBgSL9D4lnYtV2HEGfeImfX4UKU5b/IbaJeO0CC7djhJWDcEzytzYtlrC/ESk93zW+D5G8sGEdA5zJp2cUlBUiYQNoJqAFrNwjhWECRxQWUkofZueV2cZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545759; c=relaxed/simple;
	bh=2CBa9IBMibbcITCTnBXKA4ai81Vo/pmWYs2riYsXCmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYcTyFxy762IG1JYz7N3ITRerd+faWYbeVALtyZKlpBUL+pnrfgKsnI4ONG8X3Ki8gXEXm0MW56fV7VNHIwHxUt8GHm28ZKcsFghKJXiQrZOIrONcIpckyD0RVPlcKqUnjU5cYdpOJCsRDvuN/+rdz95CjJZKPDNCUnVddTjNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WNuS80tN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb64620031so810566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739545754; x=1740150554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7jsGzrzWA2UpjfP518+Ys9Fu8SxTav8yjO65ThpneE=;
        b=WNuS80tNfTlW7WceVU/9Fxvy0fkxRA0xVSw8+D8ymEo3WTBVsYHqvdTEvrVpCKn4dL
         U9YYgx7bpUjlZfhETbzZjHMCUHT4LA97BU73W1Q4J8kQz0i0iKZr1EMdHtAh0T+puU25
         joYGueXy0y8d/KnIqNoqeT+nCoFU5hHIdsrKdid25cZlV4kGUkfcn8Bs02tUqaGkw96S
         6JjxV4B/P+OzYiPJTgQBaOF/4oFSVJjfEYDisijetllLxPZy3agMOtK6gGJC9ZIwvlU2
         uWSP7qZlAm0AWiOT6+8wgoz4qmcfDILKjYGLsV9mQqz3nCRJfXBABPaLSKC72+GP+4De
         YH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545754; x=1740150554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7jsGzrzWA2UpjfP518+Ys9Fu8SxTav8yjO65ThpneE=;
        b=Jnx0vPbCLyuTeX5oM78se9s69RBZcgn6gNeQd5n/Y5E4PY+K7Dz5aRny/MgOVLBkT8
         sKK+1ix/wBKlGq+K77IqkTzOapsKF5xhjyLcejBkY7kp8KE+jgTcv7xvISAUX3myc/91
         fSI+tvtDAhEWlm7oTTzzf5SKhyoBYfXMqcT968c+d2an9gHjcTQx7PGSYvAG563ZUn2h
         cnklCi2o3jhcOByoesR3hYA011FhPMuFOFZ954bNLxK7RRC6xbuW8WUdfsamToaJ4iMY
         5hMnLpLazf5zDu5xUd/S7GoHRlQthT8f19K1L66eXbaSzzfxXSNEtHgtBp0gzMgK0U+t
         97LA==
X-Forwarded-Encrypted: i=1; AJvYcCX6RfWAXGXHa+/wEwCCiOaRjCY1iRF+gXG8g68wtAjQQqUiq8qADP0vGVrcH4AMZYZZLN+xF2O78jRjXck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72+9gfa+ZMoiwGVtq7zzRhNXNJ30WExcBonBv7VvPyckDPOrV
	qiyZWEj08azKxVXsr7dxn8oQfER7t8IXSE+7kjiIudVZUCpVMOkAqdnLoRcICzo=
X-Gm-Gg: ASbGncvsaSlAE9s5t9T1huqRm6OG8gfjJhzkrEM++0jFF6b4Qs9hEpPoGCnpN9+1FG1
	4ot9XWCAtRy5aIPY6r8Mw1Gpyk2kA/7PddN/mzELFUNR9icv/n0SWRWqHK6mvK2760t9WrLlnML
	q+rWI2TAsHdfxvNXxZ0XOF0vVjLahX4quSmeOMIgvP1nnoTr+WtAiUdFvWWrd/ELuthphbCZl1d
	W0HFlVFSH8yziboSIxvzJA/n4y++U5k2tU+T/FtOn0pk4tavTpwQvrAMmCk2zizK6MmXlYS1vtV
	mImoNA1+Nh5GsS58082iofg/cgvasUM=
X-Google-Smtp-Source: AGHT+IE7JU7OBLRkos654tOsr2eurVNX6fP97fyobBh9cWCTtMYkOpMH7QEK2km71kJRMzG661dyZw==
X-Received: by 2002:a17:907:9490:b0:aa6:6f12:aa45 with SMTP id a640c23a62f3a-ab7f33cee90mr468424866b.7.1739545753005;
        Fri, 14 Feb 2025 07:09:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bf70asm356266766b.180.2025.02.14.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:09:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Feb 2025 16:08:44 +0100
Subject: [PATCH v3 4/4] drm/msm/dsi/phy: Define PHY_CMN_CLK_CFG[01]
 bitfields and simplify saving
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-drm-msm-phy-pll-cfg-reg-v3-4-0943b850722c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3653;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2CBa9IBMibbcITCTnBXKA4ai81Vo/pmWYs2riYsXCmg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr1yNPOoysNFKaCqU06xwyIbjOpzjtXtIKu6ny
 4+bnqJO1UuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69cjQAKCRDBN2bmhouD
 1yGpD/wMzzZRoNEJddfIEvdwKtLRihZJNRYkTaNYECkfJYQ6wVhuz/xiDFeQ/SsAKz9pXIik4SF
 r1dMnA02Sdxyt8TCDLtpJK0u3ExejMBuU8qebOKqizCR+eo6R0DPttheCsrYtVrbdFF3AdnlwzG
 gAz+vQprz0JP0P0HRcUQ6Lr7dLKjgGlJTEnUD/BA2haAPIeNL65suMKARExE7XPqcKfKKW2rerR
 bP+5YlODHhXC8Ed9PZUTBZeKswlrHetbg+K6sXYVVeiZlrSaHxaAiBKwqRG3aZDmGTck+fXDxAc
 wtArZ7WcsYip5uEe+3IpEMbhKj30Y63CHWBXqhEF3Yy7whUzFW7Y/MidDXE5b6H54iOl1FFTA1M
 ygz7rypxFuKTIhwjjQMwTRwmi7QmB8lYQwO0AXuNjogTa/87fzaHB0ZksZL08OGx7pdzSkD2FVF
 H70bF7zWAVrubgHNrd7dq7mVvW7fUagqjVZgQ4zt0qZyKGq9tfdF32WqOjQzuKP8KTOuJDjzz53
 GU8w3jameWwtUdx94rwQWUwBSybUxrlEFt/u3CyrfAQuJREuLn63Um71DBvnAUeGy5WMAuoceSJ
 0gyuPMvDvi+/l74qISVy8ROY5hlboH4ec0KxaguKF40BhO8oR2imSsOJkhGsagTK+4ZDRJmNgS7
 o1B5XGYPuyYdueA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add bitfields for PHY_CMN_CLK_CFG0 and PHY_CMN_CLK_CFG1 registers to
avoid hard-coding bit masks and shifts and make the code a bit more
readable.  While touching the lines in dsi_7nm_pll_save_state()
resulting cached->pix_clk_div assignment would be too big, so just
combine pix_clk_div and bit_clk_div into one cached state to make
everything simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Use FIELD_GET
2. Keep separate bit_clk_div and pix_clk_div
3. Rebase (some things moved to previous patches)

Changes in v2:
1. New patch
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 12 +++++++-----
 drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 798168180c1ab6c96ec2384f854302720cb27932..a8a5b41b63fb78348038c8f9fbb141aab2b07c7a 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -572,11 +572,11 @@ static void dsi_7nm_pll_save_state(struct msm_dsi_phy *phy)
 	cached->pll_out_div &= 0x3;
 
 	cmn_clk_cfg0 = readl(phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG0);
-	cached->bit_clk_div = cmn_clk_cfg0 & 0xf;
-	cached->pix_clk_div = (cmn_clk_cfg0 & 0xf0) >> 4;
+	cached->bit_clk_div = FIELD_GET(DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_3_0__MASK, cmn_clk_cfg0);
+	cached->pix_clk_div = FIELD_GET(DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_7_4__MASK, cmn_clk_cfg0);
 
 	cmn_clk_cfg1 = readl(phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-	cached->pll_mux = cmn_clk_cfg1 & 0x3;
+	cached->pll_mux = cmn_clk_cfg1 & DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL__MASK;
 
 	DBG("DSI PLL%d outdiv %x bit_clk_div %x pix_clk_div %x pll_mux %x",
 	    pll_7nm->phy->id, cached->pll_out_div, cached->bit_clk_div,
@@ -598,7 +598,8 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
 	dsi_pll_cmn_clk_cfg0_write(pll_7nm,
 				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_3_0(cached->bit_clk_div) |
 				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_7_4(cached->pix_clk_div));
-	dsi_pll_cmn_clk_cfg1_update(pll_7nm, 0x3, cached->pll_mux);
+	dsi_pll_cmn_clk_cfg1_update(pll_7nm, DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL__MASK,
+				    cached->pll_mux);
 
 	ret = dsi_pll_7nm_vco_set_rate(phy->vco_hw,
 			pll_7nm->vco_current_rate,
@@ -739,7 +740,8 @@ static int pll_7nm_register(struct dsi_pll_7nm *pll_7nm, struct clk_hw **provide
 		u32 data;
 
 		data = readl(pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
-		writel(data | 3, pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
+		writel(data | DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL__MASK,
+		       pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
 
 		phy_pll_out_dsi_parent = pll_post_out_div;
 	} else {
diff --git a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
index 35f7f40e405b7dd9687725eae754522a7136725e..d2c8c46bb04159da6e539bfe80a4b5dc9ffdf367 100644
--- a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
+++ b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
@@ -17,6 +17,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<bitfield name="CLK_EN" pos="5" type="boolean"/>
 		<bitfield name="CLK_EN_SEL" pos="4" type="boolean"/>
 		<bitfield name="BITCLK_SEL" low="2" high="3" type="uint"/>
+		<bitfield name="DSICLK_SEL" low="0" high="1" type="uint"/>
 	</reg32>
 	<reg32 offset="0x00018" name="GLBL_CTRL"/>
 	<reg32 offset="0x0001c" name="RBUF_CTRL"/>

-- 
2.43.0


