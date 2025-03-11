Return-Path: <linux-kernel+bounces-556798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD7CA5CECA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58C6189E34D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4F266B59;
	Tue, 11 Mar 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0FPoqb8"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2346266B60
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719766; cv=none; b=K7SJ5sHzJ+A0nepAHkd2Me0qql8qWz8kX60YedTkT6Qv28TYOZRxaB9k5Oz/0hxvx6GpazKqepM+HHlLHvFAlpkf//A61Rmcwp7gVyrXo5U+itwsVPB+4BORgfxoFQDcV98unvdq2Fr86ySFe7soTGnu+Os5jUDRbY+mUGXPBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719766; c=relaxed/simple;
	bh=3xk0pyKS4szEe/9MhLY0udi1S0AkDYWMQ5qVNXd7KNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNL4pf9NXH85KGuub+k6d21TYKTkmio9l0v+Fh7HC2Iij8OvXAm6gwvpb8BOyvOLeEuJFRZmyGcfVfKT/l49uhSHOzBJP7SXiYE4ZsL0Cp0sC9yt/ld4dwqaPy4hhKzPJXpN7u852J8It3Ghwkt69H7QTSH3UiIKI//M+JZS080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0FPoqb8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391295490c8so351752f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719762; x=1742324562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoHt8+Qv2KBvycEBRbSOT+7Q4Tanwbir/+be358nDD8=;
        b=o0FPoqb8CGFAPN/T3m50tuCyT81T6oSpLPhVBdG3Z1wwjTtiBbgCgs7t9Bb5qHr1I6
         r+K+u97mRlXv78ZMIZTu6cXeCAJZovcZDt20liOSRwsqBvHgMbQ6Y8U4cN10ZfkfwRLl
         OLSut5hmJBeZXEM9bc05J2iEfvNz8ItAC7jUa22/c8vzMwibhGfo96oklNctKjMP6qiN
         cR6lql6vQeBAndOTAApeAg4f0/4g6h4a5w0WyDp/H/iOtc+RAec9Ka03zrIUsEHAK5g7
         /+KkWQAmYwXeSn+ugxJjVLR1GvgcxnjSLWVV4s6S4Xs0eu+u4Qh0ADxSUF7Zs+GlJFXY
         sVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719762; x=1742324562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoHt8+Qv2KBvycEBRbSOT+7Q4Tanwbir/+be358nDD8=;
        b=Gak+W3UzPB0Q2Pre+8eo0siTYn3ug+3xUKyqo2GBp/fB8QYlNphRwQZuURUdN1hcLZ
         eiB5L4C9xN4uwohQaTui8luNP2kUatEUG/YeiRk+Y/AjTtAR79zFCAAcmgXPO9+Pqv+/
         1YbJ+uQw0jI+2XmHrRNhO2p5XeOJEsfuH5Todd4vn7xuNkY5mfo1yS9FYAFB1YkP0aHg
         JNwV9q96czmMf1k58Jzxinu1aHKZrv8tAv4r20i32ZMLdxOqXDZigRQq5oIr9K7wbId+
         iqx3T6mytv4A91tsuPhpHcnzU6+iY1X+BeKlI6Kxgw1R9IE1rQ/ww7K8AKkx2YR6r7Oi
         Znog==
X-Forwarded-Encrypted: i=1; AJvYcCURYEKvXwTSIaZ3jHeQuBosk3l5v7m2+Xxr04uQiI4uT+dEkpo8/lPdT8mYZ+lR75m+odZj1Hy6DIcZZ3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybn8NlE8UdGQcDNuu6j4NM5JCovgtwHpvHOAe+fsFh3yzZ9g+E
	iwiDssAj17qRH9wZatZq0KHGLpRlhpTwTMOIJgM/Zd7gNz2crr/jP0GsKKKZpGQ=
X-Gm-Gg: ASbGncvoFZh2lYqDA8ZUVE9k2COZ1GFdUoPgrIKinVXGV+XOI2FdJiMBUbTU4Jma58W
	ejhoeDRiXsPCAhx9GrHlFzeDcJKsMi7XaP6yIie5YUnd+ULacCHOLG8Pd0c5h5Glos3diCxltzz
	BKjrUGVqeVM0INA0xTCQUrUxVgPNt4TXcIkQp4Bsfxsuj3FpMATFGfUa0W8oSMLl2Pc4hOqQSHb
	y2vkD6z3VBhH+DvchnAStf1T8TEgMDxlAhjLgyJF4QyxHDgrwACxnioIlOF44x1BEkBkVxvbNgr
	Hhd1lNIjWRXU/5ZkMGGEj8/PqES30HSBjngebYMyBJII6Z/6OsVhfvbeeqE=
X-Google-Smtp-Source: AGHT+IGtubQYzLqe6qMHPh2YhYmcldjpGkwHVseYKBCi8jZBCwCNslEBMj62gHB7lTtanzJPhgFk1w==
X-Received: by 2002:a05:600c:3113:b0:43b:d547:6336 with SMTP id 5b1f17b1804b1-43d01c3105dmr22168095e9.8.1741719762312;
        Tue, 11 Mar 2025 12:02:42 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:02:00 +0100
Subject: [PATCH v4 10/19] drm/msm/dpu: Drop useless comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-10-da6b3e959c76@linaro.org>
References: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
In-Reply-To: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3xk0pyKS4szEe/9MhLY0udi1S0AkDYWMQ5qVNXd7KNA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0IitXyBOAqRPMp/KeWk+fUVdkX6Z9R8/hGg9S
 IEiI9aoyTiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIrQAKCRDBN2bmhouD
 1/VkD/41O3QOWYZQCz/a0hGAcXFdCxiwdt52Ij6fy7kFN9HC8l+eoOd3C+t73FbxyP7vOOpTEB6
 ldE1DezPsO3nMYCBNS6xWz2nfXKkZCPsD0yQFauOBzlr9DlY7vSj+be9QELlrCtQ9LCvGLL3ofC
 9m4IenWnpfH0nCkPEPeB7A+BizuF9GFMTqLIIauaHYiGtkieTPZ0c5eSV7Cb9WeEbirH4+WqM6H
 huEJo6H6WJinBZ2KDBNyO9fGP+XgEpkZSHSvY3VLdsXiPO5pkxfKyM5C9c+iYuGUeJzmKjRB1vb
 qDcGUrLd4xCX7CaBXqX/92oeIGIcXOoAIY/KO4ScEcoIMoyvvAFYCZm/L43vJpST6F3Rq2hEKdP
 sTGrMWlRwfWPAbCx6ROKVSUDrSyCf/n+b1KWfU82+G8X5NSYC/YAiW/9s4gNXsU45AIC4ZHtCPz
 K2VH3kaOFUulwd+OVtqnvv29bFVuliq4DP8BGw/FnlYPpVokRPc5DjCbNYvxWzdXmS7Vf2wzW9d
 w++w+S9/b86Ls8p4vmJ+mwbXWy5ZYZJtld+2KOgAZ7ITmlyMVghTehYUGfC/hBz24V5L1F85fkn
 IjLcdFIxoIE+lfmrr86j0xbqzyPewR1QmPz7twsAfiQi+WdIINP/+wsn7V/JY5uy6Z+5fUzqY9O
 AOHbyo42s2JjvQQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Drop comments about SoC before each 'struct dpu_lm_sub_blks' for given
SoC because it's duplicating the actual name of structure.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 2db27c55787791309962acf796d5c49aaf018fc1..a310a5234e99ea4886e82ac2100c4099e6a1841e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -331,8 +331,6 @@ static const struct dpu_sspp_sub_blks dpu_dma_sblk = _DMA_SBLK();
  * MIXER sub blocks config
  *************************************************************/
 
-/* MSM8998 */
-
 static const struct dpu_lm_sub_blks msm8998_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
 	.maxblendstages = 7, /* excluding base layer */
@@ -342,8 +340,6 @@ static const struct dpu_lm_sub_blks msm8998_lm_sblk = {
 	},
 };
 
-/* SDM845 */
-
 static const struct dpu_lm_sub_blks sdm845_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
 	.maxblendstages = 11, /* excluding base layer */
@@ -353,8 +349,6 @@ static const struct dpu_lm_sub_blks sdm845_lm_sblk = {
 	},
 };
 
-/* SC7180 */
-
 static const struct dpu_lm_sub_blks sc7180_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
 	.maxblendstages = 7, /* excluding base layer */
@@ -363,8 +357,6 @@ static const struct dpu_lm_sub_blks sc7180_lm_sblk = {
 	},
 };
 
-/* QCM2290 */
-
 static const struct dpu_lm_sub_blks qcm2290_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_LINE_WIDTH,
 	.maxblendstages = 4, /* excluding base layer */

-- 
2.43.0


