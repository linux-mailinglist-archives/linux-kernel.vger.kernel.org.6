Return-Path: <linux-kernel+bounces-515159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B144DA3610B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47379188EC40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3393F266EE6;
	Fri, 14 Feb 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqqDbb1t"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E3266579
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545749; cv=none; b=Uutoycr+hvk0XFxiRIsMH38nU/KtFcjovu4NytqJ8wt4uS3dWBc7/MjmgJ4i++l44EPGjXs57UvlIZg9HASFqRkqtrsTDlZWdcyRmz0OlZGKh2NiQb2h7eZi4nFL5QSXGHlTwgcwPLBGqPaJI8g04j/OfZFW/WFQowaKr2HZOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545749; c=relaxed/simple;
	bh=VSoo9tOfvx5J/rILKbc9JGnlfjdESe0PpUUegqGlGK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7dgA38N/aaiX3/w4EYs0bkcxdapnWjVcxOJJfpdT797klBkPxsMVNyMz0zm2Gkc9tMMe7GkrCJKYeUoWpjj7J66ZQaA4xjgozJwpMPJkonIoYaq4sg8lXjX2TpTctDRMKm9CY5Tfpe+Al5xHiN5QAN9zPBq+/kHA/eUEMglQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FqqDbb1t; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7bccf51e7so31596466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739545746; x=1740150546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgWx1O98lxWOuf2pUGZf2+wF+nxvuU7wTS9vVKBBrYU=;
        b=FqqDbb1tIlCd2kjPByI+N/39ZkF3Tycz4D57JjCXgDQhiZVWRoC9/lEIls/XKnbaAZ
         VWyDAYZSv7uAF1WusvPZSWNymPffl5pZPLDgnK3/wd++31AHFlSoQJdXWTNot7i39j9N
         ETsx5cW0A+ItZdAVENic3wB5kI+2Som/GyTdaH8G2SFfKPFJ4OCXa42rEJnGuuQdKkUe
         Seyg4AxEDkEfGXkYpa1I9Q8gdo+lxLd/9tE+HlqcnwMcfqal3nXZDjpb5Ufla2xwTuS/
         NNXxwli5pgC0s73aSRh7E+gUQ4Q0h7a9yQd+VrC+MSFtX/PnYRtWWjoGbwCd11qpYYJj
         sUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545746; x=1740150546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgWx1O98lxWOuf2pUGZf2+wF+nxvuU7wTS9vVKBBrYU=;
        b=YONttb216BCLMSMCYkVWNJ8oM8e+LU1RmQN1zyX+FrrDP4rTuQX6xsG4RrVVFpbQWw
         kJcRuDElTR6OngpHFFHtGv6kOJ7XmFismDqVuIdoujmYTUqRaCrUWPvyBtmq8moANfiJ
         fAjoYK+sTV0ssnL6rxjEIEiuwhx3ecqaDK0B+q5P4xwK0TU1zPcSRehHoFbqZlmSv6jx
         zdtnWsAEvKrpG/xwkhJ3sr3mTiQkrFIpo6QOc26FS+iDOHDipN4r2Bo2gBbLmtwlVjzU
         DYMU3ZeYfi49HzzZ1ffxihYikVOdSnjPkVVI6BFjR5v9H3EoRlZwbnV+q4awy5rAwKvF
         MU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVefIjb1QexGWYDao1FwHrBIKIrepK0/T0c0JipMtWha/yPxFveftStCNH2sCFt4BO5N7BrhNggQ8bPTsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmEJ3x2bk5202vMz85ufHN4egLuFRLzPn+GBTv8P54VEZLEM8
	6AOK5YoJf09rPQhWMzsBO9lXy9rk01JiLfItDTLHyUPSDH4UzNMuG179+1xRPM8=
X-Gm-Gg: ASbGncvzoYOrPrRJl/j5MoqHSwgYxTfildu9qE21UhS63Ley6au3KMrb2URT+Vgd2+f
	l/WY0HjwY+sS+6FqVs4BIOpj5pGisTPOeA7l+yOMhNgxVKJLAPlOq80oLFKzCy5AtrSmTrL8NhN
	BNgj+kIFLs1QQtjzbVi8BtPm4PrHJh7GDJLt/Uu/u6x3Jq9EkiP7OOADCyB/RJyW+9M68vTl2Ej
	Ebd5nQur3BKo4QBwL8bmYBGg6koMWZA0ETelUiERyArW6iXv+zjTkOC6GNARroXFGQ94mAskQUh
	FbpM1H3ezbKjs4YURUyQPDh7lVOmtYk=
X-Google-Smtp-Source: AGHT+IFFtfEHxQ3Cdoslz28Y5w6bY5MFVmE3IwU8ScYouzkRBfjtskiGVpTwclCF4Xi6nwCc3WvatQ==
X-Received: by 2002:a17:907:969e:b0:ab9:4451:331e with SMTP id a640c23a62f3a-aba6970f9eemr123171466b.13.1739545745495;
        Fri, 14 Feb 2025 07:09:05 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bf70asm356266766b.180.2025.02.14.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:09:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Feb 2025 16:08:41 +0100
Subject: [PATCH v3 1/4] drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG0 updated
 from driver side
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-drm-msm-phy-pll-cfg-reg-v3-1-0943b850722c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3488;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VSoo9tOfvx5J/rILKbc9JGnlfjdESe0PpUUegqGlGK4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr1yKRgQ3FN5sNjIZkHoOJetRwRejI5VSJZ+Gx
 MQkuXSCuOaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69cigAKCRDBN2bmhouD
 19dKEACW4noHnmfbw+d7hsQw4M8NRi8UQsNZpJhyBS67KQrX0SnetIqHTmyyZhz0XChu4qbwrX2
 HP5WHY3qaxeIll4u4iw+Zi72np+NpCoqa7abijLTtEYL9RjEhXXYCbc1gQpuaYrGptUrzcHkMpW
 tQhPZ/umnkNV2LBy1XaI8vNnV9Y7fki5i4cz/o8YZ+ZarcpXmU22qMryxcYe/xQo3eInglcdGlD
 tNDQHP6XCrRX3CuWd+TEXPpKqf84v6OvBsI0wbOPbDpu1DVa7rRUMGF+atvBYS1PpOBhQ0BthFs
 E+sYlIvbygHKXtXIWP2ONeIZMx9UcNWKdWVi1abC+x1FYfMq1oMAn45jj6HQLiJpzZG2ZGEmWVq
 zeoacSZsFK9NDrzjK4fVbNl0J9jgTgjKL978nRbxPe57i7uEXoII44Gj9p4G3t7kXXRBb1qJ777
 3RqDs4qB/GnYbh9z5gZkeE9HsDFj2u7R7Cj4E3t5EDMBkP8MyE42MfGDJQuX9FYMP7fHvNwA9Mu
 emSDfSnLKd+iWwXu0yyABsKoH+Pqvz3FmzEPIORmUBD2kvayGENbkYwW5e255y784oR1hNCEgXT
 pnAfnwMYenZu0yOa755shdzMBFjMiLMTAsrZ+sDYm6TnfO0P8+cWurQE5fulWoM/q+4Eys67UKg
 Js9syNWvbN1M1mQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

PHY_CMN_CLK_CFG0 register is updated by the PHY driver and by two
divider clocks from Common Clock Framework:
devm_clk_hw_register_divider_parent_hw().  Concurrent access by the
clocks side is protected with spinlock, however driver's side in
restoring state is not.  Restoring state is called from
msm_dsi_phy_enable(), so there could be a path leading to concurrent and
conflicting updates with clock framework.

Add missing lock usage on the PHY driver side, encapsulated in its own
function so the code will be still readable.

While shuffling the code, define and use PHY_CMN_CLK_CFG0 bitfields to
make the code more readable and obvious.

Fixes: 1ef7c99d145c ("drm/msm/dsi: add support for 7nm DSI PHY/PLL")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Define bitfields (move here parts from patch #4)
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 14 ++++++++++++--
 drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml |  5 ++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 031446c87daec0af3f81df324158311f5a80014e..25ca649de717eaeec603c520bbaa603ece244d3c 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -372,6 +372,15 @@ static void dsi_pll_enable_pll_bias(struct dsi_pll_7nm *pll)
 	ndelay(250);
 }
 
+static void dsi_pll_cmn_clk_cfg0_write(struct dsi_pll_7nm *pll, u32 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pll->postdiv_lock, flags);
+	writel(val, pll->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG0);
+	spin_unlock_irqrestore(&pll->postdiv_lock, flags);
+}
+
 static void dsi_pll_disable_global_clk(struct dsi_pll_7nm *pll)
 {
 	u32 data;
@@ -574,8 +583,9 @@ static int dsi_7nm_pll_restore_state(struct msm_dsi_phy *phy)
 	val |= cached->pll_out_div;
 	writel(val, pll_7nm->phy->pll_base + REG_DSI_7nm_PHY_PLL_PLL_OUTDIV_RATE);
 
-	writel(cached->bit_clk_div | (cached->pix_clk_div << 4),
-	       phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG0);
+	dsi_pll_cmn_clk_cfg0_write(pll_7nm,
+				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_3_0(cached->bit_clk_div) |
+				   DSI_7nm_PHY_CMN_CLK_CFG0_DIV_CTRL_7_4(cached->pix_clk_div));
 
 	val = readl(phy_base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
 	val &= ~0x3;
diff --git a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
index d54b72f924493b4bf0925c287366f7b1e18eb46b..e0bf6e016b4ce5b35f73fce7b8e371456b88e3ac 100644
--- a/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
+++ b/drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml
@@ -9,7 +9,10 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x00004" name="REVISION_ID1"/>
 	<reg32 offset="0x00008" name="REVISION_ID2"/>
 	<reg32 offset="0x0000c" name="REVISION_ID3"/>
-	<reg32 offset="0x00010" name="CLK_CFG0"/>
+	<reg32 offset="0x00010" name="CLK_CFG0">
+		<bitfield name="DIV_CTRL_3_0" low="0" high="3" type="uint"/>
+		<bitfield name="DIV_CTRL_7_4" low="4" high="7" type="uint"/>
+	</reg32>
 	<reg32 offset="0x00014" name="CLK_CFG1"/>
 	<reg32 offset="0x00018" name="GLBL_CTRL"/>
 	<reg32 offset="0x0001c" name="RBUF_CTRL"/>

-- 
2.43.0


