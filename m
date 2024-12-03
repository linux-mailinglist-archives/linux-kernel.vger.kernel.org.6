Return-Path: <linux-kernel+bounces-429297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E59E1A11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB42851FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C41E32BD;
	Tue,  3 Dec 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6xWprSd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32891E32BB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223435; cv=none; b=ixzXTrLpKyztfFQAzfLKNNrzwhDw0ZUO6Gmx1enh+uE5QM3cfnj62PoRxxpZ1CvxblRkwXB0V12yBYkA5dSCdqdJCX5HIgp78XM1L65Kq6R99SLm9SZXh68LIqv5mXMT/fYLFyYL4TQ4xiywcHTdg8/clDrPnrPMXgykWqHe1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223435; c=relaxed/simple;
	bh=svpFmIZ0E3MMSYhhbVkeiDatcfDY3UNV1PY9/Sw8tAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfTO9CciEmXoDbmZN0ioXfZl5kewuH341Me6vIIPzoL722w4pVrL0EqFJ54V9lcqVjBabYq4e1hP+ejRCsRvUGRiMWK6aHDJ5kAaSu1OdMRoyML4TCzqtMT3FgbxUHtaUnYbIzArLTfCueIQXbd2NR6IG9yv1F7rsg7HhS1bR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6xWprSd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349dea3e0dso5227665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733223432; x=1733828232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKVFXpi7ykIfpDkplW+mwjJ/AO2M9Jc/QclNAewzA/s=;
        b=s6xWprSdjG/1ksEqbFpj48ldWrt8eAzufgFwfttxVYeMv3qEENJlzhzbOTkveuALo9
         FMKvaxnswBISpZql1Df8Jr8ZfR1BMhg9pX1umMkRtSAACSmfAgyx1TcKdcfSleak50oN
         w7yvX03cNTwT8xV+7MueV4jYcInkAkM8E7ZooCJwi5H+P/44m5VA4i+i021BrAc0LYlf
         9ag6kxKGb0j7gQoQPbnB2nBOXICRJ4F0K1lVRm5jys3tK9cs00jxH1xve83CFPp9hNrK
         uQq3Mv50UGJmS23z8UZ/GoHDDZAUWBZlSeYOtQ8f/XNlimt2I10oEJ2M/s+SbqZkWLty
         uGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223432; x=1733828232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKVFXpi7ykIfpDkplW+mwjJ/AO2M9Jc/QclNAewzA/s=;
        b=oC4mrUA5Y39TA8KupVNhr07H9Y2qPToWxCRZlFj+bCEmOfDWoZyUitl3xa8jnVCYwt
         n1bmtF8S3bVnayShHRcALYvFj5XqtVM+dUActw4s3sUJWXQvAtVyI7z6VjmQN3s4iSBf
         lk1pqJGhK7RpQlGY6X0Fz+km/p8CYx6yuMkULWHmkJ25LNZraL0NXa0pGuNb+fwfTvuO
         dtcAdztFACowmSh4ghJQnZUDyXN7sxvoqNNM6cs2Sxx03VtMIgRWTs3aV8i1yMQCfbmE
         S7mSoJl9FR3J51/TIe6SLKc+0N4abh0a2RnfwKqPbwMXa4V6SIiSpTIwh4LA1ZfBr5c5
         l1cg==
X-Forwarded-Encrypted: i=1; AJvYcCV7AiwYvNb9jaaIcIK9TvybVf05MR8f6x9nlTrX/pBIjM+WmodVBJ+TcdJ+ay5cdwPCAN8/XvBMakGZ3fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgonIrE74dnoGI02oP/v7GG/06uDu6ZtrvvpWXzSZ0uoJ5b+Lf
	R8tCRfEuWW5qHd2QOWCIsSlNWga8OhsraKFmEENz777Bp2Nz3Np/bCkgGq1MMCE=
X-Gm-Gg: ASbGnctuduy3ipAO9fpuKIS1ZYGYfvRFR+b8taD+lKf1ukDMkKafAagk8KEB3k7NSDp
	iBJ2Gl8uzHOfxr6M5J/XbFkkAX2n5oPXrYJSHdk9azIJ/Rh+Do9E+S+iPNHYJiEupE+qsnF7vbr
	Br36bCBB6jZclxyjPwHA2YsNqy2v4li0wXjFTwT9Oh51FKRCvMdxmnetpdBrMrLekaxH0qNS6+o
	a1tQDnIeJ+6JWVUqUBV4yO/5VkGiF/L+5dt/Ao/XxDoqIH4mxCSD1WCcv7rtnQ=
X-Google-Smtp-Source: AGHT+IF3RQrgYMQBUra5s134a/+wlrVH2ULAv0GR1su1FJVR4zaGyhGAAM2BSPOn9K8bQ44CQ81cEw==
X-Received: by 2002:a05:600c:350a:b0:434:9dcb:2f85 with SMTP id 5b1f17b1804b1-434d16dcadfmr5083215e9.0.1733223432292;
        Tue, 03 Dec 2024 02:57:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm215809515e9.32.2024.12.03.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:57:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] clk: qcom: clk-alpha-pll: Do not use random stack value for recalc rate
Date: Tue,  3 Dec 2024 11:57:07 +0100
Message-ID: <20241203105707.34996-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If regmap_read() fails, random stack value was used in calculating new
frequency in recalc_rate() callbacks.  Such failure is really not
expected as these are all MMIO reads, however code should be here
correct and bail out.  This also avoids possible warning on
uninitialized value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Three more regmap_read() failure checks (Stephen)
---
 drivers/clk/qcom/clk-alpha-pll.c | 52 ++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 5e9217ea3760..00d3659ea212 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -682,14 +682,19 @@ clk_alpha_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 alpha_width = pll_alpha_width(pll);
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
 
-	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
 	if (ctl & PLL_ALPHA_EN) {
-		regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &low);
+		if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &low))
+			return 0;
 		if (alpha_width > 32) {
-			regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
-				    &high);
+			if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+					&high))
+				return 0;
 			a = (u64)high << 32 | low;
 		} else {
 			a = low & GENMASK(alpha_width - 1, 0);
@@ -915,8 +920,11 @@ alpha_pll_huayra_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, alpha = 0, ctl, alpha_m, alpha_n;
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
-	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
 
 	if (ctl & PLL_ALPHA_EN) {
 		regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &alpha);
@@ -1110,8 +1118,11 @@ clk_trion_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, frac, alpha_width = pll_alpha_width(pll);
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
-	regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &frac);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &frac))
+		return 0;
 
 	return alpha_pll_calc_rate(parent_rate, l, frac, alpha_width);
 }
@@ -1169,7 +1180,8 @@ clk_alpha_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	u32 ctl;
 
-	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
 
 	ctl >>= PLL_POST_DIV_SHIFT;
 	ctl &= PLL_POST_DIV_MASK(pll);
@@ -1385,8 +1397,11 @@ static unsigned long alpha_pll_fabia_recalc_rate(struct clk_hw *hw,
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, frac, alpha_width = pll_alpha_width(pll);
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
-	regmap_read(pll->clkr.regmap, PLL_FRAC(pll), &frac);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_FRAC(pll), &frac))
+		return 0;
 
 	return alpha_pll_calc_rate(parent_rate, l, frac, alpha_width);
 }
@@ -1536,7 +1551,8 @@ clk_trion_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct regmap *regmap = pll->clkr.regmap;
 	u32 i, div = 1, val;
 
-	regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (regmap_read(regmap, PLL_USER_CTL(pll), &val))
+		return 0;
 
 	val >>= pll->post_div_shift;
 	val &= PLL_POST_DIV_MASK(pll);
@@ -2457,9 +2473,12 @@ static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
 	struct regmap *regmap = pll->clkr.regmap;
 	u32 l, frac;
 
-	regmap_read(regmap, PLL_L_VAL(pll), &l);
+	if (regmap_read(regmap, PLL_L_VAL(pll), &l))
+		return 0;
 	l &= LUCID_EVO_PLL_L_VAL_MASK;
-	regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac);
+
+	if (regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac))
+		return 0;
 
 	return alpha_pll_calc_rate(parent_rate, l, frac, pll_alpha_width(pll));
 }
@@ -2534,7 +2553,8 @@ static unsigned long clk_rivian_evo_pll_recalc_rate(struct clk_hw *hw,
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l;
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
 
 	return parent_rate * l;
 }
-- 
2.43.0


