Return-Path: <linux-kernel+bounces-446999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96079F2BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029821623EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED6201016;
	Mon, 16 Dec 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQC6EQ7W"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224331FFC41
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337661; cv=none; b=MgeAWrCTONcFCl+FUUpJznn7t6/SU1y+5ltOIaKPd6TZIUUqO55eXO+/8X0z2M4/M3Aya/SnCYSzijb/kPOIOA8vETBTowNln5VpfrezKDChCdOBDdWeeijNWlAHeiawFGW7nwPjrWDw9xHcTdc4baYqr3bElg6Wv1wLPfv20Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337661; c=relaxed/simple;
	bh=1HhOvQdDTQpfgdgbG47ZEhiTKbhwKeluJd76grZHFQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+/KKYl4leKP9piokHtXfTUbo/dE2LQbCLsDeU68Gdrl5N/8yh+mE0HlSuIB0LFPuqIbejmFEBCpKr6noTHmHdlyFniWZVlZ9T98W7AOis+RCoUe63Pz2sE709OyG5jl/xs27HOEi2V1Wb/XEFZUC6n96EOSwXYUVLTclNpUKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQC6EQ7W; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3022c61557cso40456421fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337658; x=1734942458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbJUsGouyvpdIwJ5KdGKXUaM1AeXWb7FKeLRpP8lHmo=;
        b=lQC6EQ7WTmDv4pp3LoMCu+ofO0TKhWmSwN/RzPYV0X5LNBtOt59JrgQ4RHDWcy8R+8
         vZaJ8le42E4lwJZyjO5HQeh/Q7Tl/vU6aAzyMo8ZBpIWTeqgUP26J3WI1BR+y9kX/Hkp
         FGIOzuMXbfvA5ha/ASWPoX4/EWXwYbjZYt1VhJCM/Rjnb9inAhX7MZ8/bhmKZE7HIr+S
         qohJX4OYl5cLcjFSk8/X7xYJh42m4CReMZ0ZWNa824RbRKGEL0tize9BAI5cABj1/c9M
         WLe3FvoOh8xFY1yN7TVQ4mxiikLUuBvzVUpKSe9v1HE1iB5lZhpbNX6/9D4v14BFxu8B
         IQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337658; x=1734942458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbJUsGouyvpdIwJ5KdGKXUaM1AeXWb7FKeLRpP8lHmo=;
        b=lT3pBpwTd5tMWkfZsF9czSZK9FaM6bdJhrITM9eOq1QFS0f0RtwP2qvloOlhMfr21M
         4K25BqY3DsjrrnpKxBlYRzjPTUyIdabh7gUZnsvzV5a5gmUgOL1zdG07/fnwBi6//4r1
         CVyn5efB0dr/1i5FGf2nRFmjzPPfzg+qUqpM7kgYpiVPWV5677g+St0YzR2vsNHmMe3l
         OMNNqgk6KakqhdEYqhm6dcuAdjnA9x2VXA9FKvKUd01sPn4bbZNAuoV38897xgWDiPQA
         a2lDPc6eVY1q6VnTLwrgfVmBTuWyg++lRIXmszMSmpYGv7Rg0dWUR1iscjOTW1gbcdyX
         UOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6aOYhsn2Q7+UzBjlXKzMJ/Jhai4GAwC7E9WLYA0Z39ybF0ZTt2qdgQ2D77w0j2DZUeJcmxXUhNBIL7ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJXzi1ZkdQJVdypowciYAhfMOYEWkQvwfuc+Tj1Qn1nr9rZV1
	sdAWtub5Llh3n/f6h78xmc3SxElZqFuTrc1BmjMh14ugSgpiLzlo703L2TtQG0M=
X-Gm-Gg: ASbGncuo7tFAF9bKXypsFxmG57BIG+R2lKZtIxJeskyGo4OiryEWQAZPtWWlH/SKQ3b
	eCs+m/Mlm8vhyfcLMJU9yL62me1Nk+tAYYk7Nc5lcEo8ubUuZayWndB/dZltudO/BHmJ+iTR06i
	rID0YDUgIfmjoBtEKqkZ46PmJ3qGrGTMLPWuwOhWbuEpXNOfdgTcsolMf1V9h8+6OlwOk7cHEDk
	WPywPiYLtYspzOJSO45d989edI3wZQ0HlYDMlfF+B4i0dMiwX/MUFcqDhwaFee0
X-Google-Smtp-Source: AGHT+IE09YmVD4DRB6LYkgBX9GgTyicLTyLwxzWmsrV39R4MSiGMzGiG8tc7FZFrp00POVfsz/KMrQ==
X-Received: by 2002:a2e:bc1a:0:b0:302:3610:a50f with SMTP id 38308e7fff4ca-302544ae74emr31223591fa.30.1734337658383;
        Mon, 16 Dec 2024 00:27:38 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:27:26 +0200
Subject: [PATCH 5/8] drm/msm/dpu: link DSPP_2/_3 blocks on SM8550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-catalog-v1-5-15bf0807dba1@linaro.org>
References: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
In-Reply-To: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Richard Acayan <mailingradian@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1HhOvQdDTQpfgdgbG47ZEhiTKbhwKeluJd76grZHFQ4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX+Rs2FhUYx9q2yNDoYbhnSjaGb+un7b3T7HUG
 VoAKEcGX0iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/kbAAKCRCLPIo+Aiko
 1eZRB/4rtFczYnTmybdWYQxDY4DO9biNQKJsf8ktMkqNBxfoBOm6geGnYjdFg4JaRtD03g5YKl3
 6UFn4R5as6rx8Zak+ZhimIcttpvhOUzURUykldcuGbs7WqYhaGp2qs2DlvqgiVQb2Z0KkNDMDeY
 QsdD+kpGHf+FnoV8HiCFJgrNJ95+Y3vKe0HgoHPA7NRy1eu3MUZ3DTpFwswhjuzoz/WIrviOUaB
 OT9Qb4erHsNqFFizJ7TgR+cPeXPik04uohYxBeKtt9K/hRMA9258n2yU7rZUYUPuICEzVyoZ7i5
 JM67FnF5p5GaeujazKkpq2Vww/uULSfevN1y3671rWbyPXp2
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.

Fixes: efcd0107727c ("drm/msm/dpu: add support for SM8550")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index ad48defa154f7d808c695860fd91e60bbb08f42a..a1dbbf5c652ff9f21c02af2e2520f019702f29c1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -160,6 +160,7 @@ static const struct dpu_lm_cfg sm8550_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -167,6 +168,7 @@ static const struct dpu_lm_cfg sm8550_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,

-- 
2.39.5


