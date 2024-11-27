Return-Path: <linux-kernel+bounces-423242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBD9DA4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03769282D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B217DE2D;
	Wed, 27 Nov 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiuQIYz3"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD518E373
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700194; cv=none; b=ZFipG3aWjCcMktqdSxf+Nfual9gKxdwfx1LNczPwXxCAUVWp/B5j1YVmEkHDOWMEgheRgL9QDC87kG6Ne8ZSdexK+lPgI5CFx0QdcklaZK5QgtXM7n9pmRMThr7QrUxPkqMrqBPbJ3Fr0XFMlBDy1nUt49jj1UWxhD37lm50dx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700194; c=relaxed/simple;
	bh=gtprPVNdoBA0SQtz+Tn8Mp5pL32x47VlscWHTkUCCP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqZvQmGRbBZ9lj60pZuxlyOsFq89R+qmOiy0KgXgSL7/LQA7LBIUNDsJw3mJzgKQUUj06P1n77qnG2PCsXNv2Q6KlWrUMuRZKN2WR4aQa9sc9ts/ExBcWQDqo3+R8Zk4dl+cwKjU2V98KIkQv08uAGVOykl55C0ILEUxscxS1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hiuQIYz3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3822e64b2d8so231280f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732700190; x=1733304990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JiUVixxYlECG0+CmoWGiRvTX57VPI+LOi/KpvIp4z8=;
        b=hiuQIYz37WuUwNBMHn9k8wX7AlkjEE4jityz7hSQVKatNEWFf9xYqyXIN7F7VN31nl
         JjUCojFBnIsuxOofB2KNz1WjI3QgK4Rq1m0ACdj3nfQBhuWKKh80K6LdINpVPa+BedcW
         QvLOxzy1D10bctKhc/Rkb6zyedwG0o9jy/Dixj8bh+UEr7rU/0Jo0lprvCOy+kpTvFtQ
         9CUULLP3HvonH2/z85CKvjyvGMDebdyXNisLfbiNikdH/forfvDmCo0L2UDEhFak0r6K
         1zwJ3fVkX+68CDl/riVIpZpl5XdKqV+qKnw0dCmVmT5oWONoJ9Cz8VpOb+ML2XQgLOPV
         trGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700190; x=1733304990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JiUVixxYlECG0+CmoWGiRvTX57VPI+LOi/KpvIp4z8=;
        b=pa9oOL9Ac9oFD4R9q7koKIpyBSPGCrXy2rXr/ZnwriXtR5QUXi4lBNxYGf2Qp8Co8W
         KfMgpCUPdGN7QG1AAdIoZ0qskJtIN/SFD2pS5qVeCH8QOOX2CAAn004nUlLInzy1KS5Z
         Ua7rqFzXX8/UsP+j5L+kBURcgHKQD1ip1Es6RRDtXAkfhWHOcFLdH5dEtQo1UXSYMvmM
         YL0oeJnryWh2jMeHILNs6unwh2/VS4pohSi8yM6VicOktMrytilAX24pUH+S4xCPa6mc
         259VCzITohP6/mpqM12WLPglaGiOpdCPbPoHYSyOz+JAM0vQybvI1BcxjhUsS28N1VY5
         bqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIP5XQs/iQjKVR+5PtQpYdDX+CL/Z6/ERNUgmYILpq3VbIMTnlFnS/4L0tqmbxJok4uu2AcbGIRc23i+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOqiPBSCvJGJaHyl2vdLkm7W4ttK1CAYTVOwlSiE/gdeI8zfA
	USJlMa6aCNyf0zNQVRM1fhyHpMg72rUdknp1d/5uJlMoRGWpkqZLdDxy9Tah2z8oX589EbPZ/wS
	bmAM=
X-Gm-Gg: ASbGncvBdEGDZ9hK16dbBy4f1sTuxJrDJYa1dHElsrrgGJL9e2F6FUXqnyGpvsQohfj
	e+wLH+rKn+wM7v4AxQONu3WoAI/0yNHPYZeElj8piADL/R0BOBJzUJ9Fh8PYn4nR0cDnOdJNzac
	6/46HhdpOXDv3dAIT7M9bS4kho6YWtBziTZK/WrTQH2KVHaqlVgfcoU92UWIrNJakgTOox3t1Na
	jzcpSUmTw1YAIknC8MMLkOu3GjFDAiqMq/kP29kU5t8nl4UJnVKWRUEvWlkqts=
X-Google-Smtp-Source: AGHT+IHg0M4TpF2Z6OCGwX2wDMIMPge9z2fUPxOqzZYk0qiCMYgz7Tddg7rr6pBtKhaG0tQg5d/Qaw==
X-Received: by 2002:a5d:47cb:0:b0:382:498f:9d54 with SMTP id ffacd0b85a97d-385c6eb68a6mr711784f8f.6.1732700190581;
        Wed, 27 Nov 2024 01:36:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.219.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc38afsm15729035f8f.67.2024.11.27.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:36:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clk: qcom: clk-alpha-pll: Do not use random stack value for recalc rate
Date: Wed, 27 Nov 2024 10:36:23 +0100
Message-ID: <20241127093623.80735-1-krzysztof.kozlowski@linaro.org>
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
 drivers/clk/qcom/clk-alpha-pll.c | 41 ++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 5e9217ea3760..0cd937ab47d0 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -682,9 +682,12 @@ clk_alpha_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
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
 		regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &low);
 		if (alpha_width > 32) {
@@ -915,8 +918,11 @@ alpha_pll_huayra_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
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
@@ -1110,8 +1116,11 @@ clk_trion_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
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
@@ -1169,7 +1178,8 @@ clk_alpha_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	u32 ctl;
 
-	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
 
 	ctl >>= PLL_POST_DIV_SHIFT;
 	ctl &= PLL_POST_DIV_MASK(pll);
@@ -1385,8 +1395,11 @@ static unsigned long alpha_pll_fabia_recalc_rate(struct clk_hw *hw,
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
@@ -2457,9 +2470,12 @@ static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
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
@@ -2534,7 +2550,8 @@ static unsigned long clk_rivian_evo_pll_recalc_rate(struct clk_hw *hw,
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l;
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
 
 	return parent_rate * l;
 }
-- 
2.43.0


