Return-Path: <linux-kernel+bounces-446988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B39F2BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E6318859AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAB1FFC64;
	Mon, 16 Dec 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wA4ijqrn"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0681FF61C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337243; cv=none; b=tMU2dQzF9gairUKx6ZuyAs3UaBSJWrgYxN4W/99waKNOvyxDXVUgRdeZxftWY3vxCMotYYlMzJ3RWViTlJ+z0+KA88OWkADvx8sBxMe76fTj+pKH5PNaxKtMmP7aa0s/Gq04DfZTtI7bNQ62d9uIQRAdhY4MNHhyRzSbZKNeB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337243; c=relaxed/simple;
	bh=uUJA3/TZsxZSLGQ3iJa9Q98/lgULeCMhq5QBKWADGSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FDXwWpptsigivTmg2lOxoMjyielUr1Upc7j5v5PZKsG6q/DMiymMfcyVuS6JvETH3hT1C5tYmtWX47eCIDbM4CDnkMgPjzJMaOg2r2n7uhDbvFRy6a9pGZJrn3nT17GTEIll1k83cK9G4DIstnGXOsGXfGI6hcEg+b5zIkhkeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wA4ijqrn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54025432becso3867833e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337240; x=1734942040; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YbfXvKOjtQu6oW6OVlC1iMgsVrQx7zWveYPYCO9K2UI=;
        b=wA4ijqrnIDYOFDhxWEpBqi4+C8fNH48q0kY1nlSKzHIc2smkP594WO8yhaNWmKyN4l
         md3KHA7q4m3RIkRiyQINIlkdTrZLL1lhXYtA63Wr9iUCEPkTFUSwkphs119zdxnGi84W
         jvosWCDM1bHOLkXGf/0GCuLDzqMb2rKO6vGx6bY1OfVsDuFLMJzPt1zChCL+0eED4IUW
         oxZcg18Bg+1hLjFuUK5J0L91fSfi5APHq/WyaonMS1u3SiwyfwnZaZmxg8tY8TXhaINI
         U67+Qb5/205pCApembYQETv3/tGGHpD3PzaWntwKxbIEtPi5KexuZQ2tDEb6Qj5kremx
         GAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337240; x=1734942040;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbfXvKOjtQu6oW6OVlC1iMgsVrQx7zWveYPYCO9K2UI=;
        b=PzOMxb9L9qv6KaGlxgqXxIwOAJ/aPjed3WXrO3S6J3iQikMDm56SBhEoRd1ZR9CWcN
         xbeF6IWV6nERc3PJq5zzbB7Sm1jwqPK3P/Q212Ljke4buIRLfIi8G0/hQDWubkfITRkV
         bvjHm4olXKdoJdoPjHaolvyD+omqIy1LXH6pTeKkPpKRaLjRTIM+J1QuyYUV2OicnX9k
         Qq6EVym6FpCUULB0deHZJDgSM9fa0VTBCKApJ2+IVIeegGofp+2lfgF4dOhKJTtKuq2p
         INifjOKTfFIV2LcRIsJgdM97Nn9u4CPawpDHrgSqFelJp7SLiFObmh66Z0k9n7IbSzAF
         4kjA==
X-Forwarded-Encrypted: i=1; AJvYcCWrUfejOowT0NdrXGnqSXy+gvQeLULWHQ+ncZqVOA9ZwchPF0qW3D7MU1FV9FDzexWMlBwUHzGmqfFaa7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyreW5Va+kmx1/OAB/xsKgcJAXav1DNmFx+hl9IZ9jXGv2GxpFv
	RSLaHk7xPJIhf5eOwDdFt9XoSkOQ8FKiNC0UI2KEtJmoyFXE2IRWGg+0/GxOSkE=
X-Gm-Gg: ASbGncsdpe8yXlEF0LaXpNpHZvLhPTVYrTcUOgL+ya1D7b6mweeK+0pfGtsSy/xXzo8
	Nr+cz7SHUaU2WrmyPzfL45h2O0zm0vU5J9WSIxSYjUN1s50LHXpIVw2stC1/ARChhJjSaK0v+FF
	CvALVhKQ+QbQk4rSJ90DsM+3NPJXv+JtB+jukvoOh/F6f8LQFKqoDzzRYyiqjJnavHI0SKVaKRI
	whRbBTtDH+x6oNCURIgSLWwICnsZgJeDfYueuigjBmVULq/N3ADvawey1LIKBAx
X-Google-Smtp-Source: AGHT+IGzenR2jl87nMf97W1enF+uDtS5ypA2j8yTcUnPoV9iEHOCI2uxIt76PAu02Tox+YY54Iz5kg==
X-Received: by 2002:a05:6512:3dac:b0:53e:39f0:4bbd with SMTP id 2adb3069b0e04-5409054e4a5mr2594490e87.21.1734337239738;
        Mon, 16 Dec 2024 00:20:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c137e5sm754516e87.184.2024.12.16.00.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:20:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:20:36 +0200
Subject: [PATCH] drm/msm/dpu: correct LM pairing for SM6150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-sm6150-v1-1-9fd7ce2ff606@linaro.org>
X-B4-Tracking: v=1; b=H4sIANPiX2cC/x2MywqAIBAAf0X23IJr734lOkSutYcslCKQ/j3pO
 AwzCSIH4QiDShD4liiHz0CFgmWb/cooNjMYbSoy1KA9L3TyYNwbqjVS63Rb9q5zrCFHZ+Bs/+E
 4ve8H2Rd72WAAAAA=
X-Change-ID: 20241216-dpu-fix-sm6150-17f0739f8fe0
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Li Liu <quic_lliu6@quicinc.com>, Fange Zhang <quic_fangez@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=uUJA3/TZsxZSLGQ3iJa9Q98/lgULeCMhq5QBKWADGSU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX+LV2CEVo6lAAyY1ot+m4rawCBEiNbmKI0V0H
 +juU3EvY9iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/i1QAKCRCLPIo+Aiko
 1ZGXB/9aO6ZYG+gIxJb5oe7hQ1dXAs82EbfevXvtGTdQVCnxun+PDjw8B1Aui2HOARJcXI++Tvs
 Mrb4cmy3DvJu36eTg8diFOjJAOMa7gEfLZe3RsMsilSkGjVti/XpkQ83zgspXFA0kDwHaIMSppa
 qulF6sCTzWjzG3V75X/ezks+tZjzi2xF1QiGJ1WHFdsohZYOZEaG89/SoORUguCDm0gHKWT8l8j
 Oek+oRlCB/h4b23/7VnSw2zWwZ0lY/5mT830UlmwNbtHQTtPoqiz5k9Ykda4M5rFRX1wWnBlWzR
 j3YvhI65dGIlbxHx83z/SV1ncEyeME5+srWX5L1yhgODf1rB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

According to the vendor devicetree on SM6150 LM_0 is paired with LM_2
rather than LM_1. Correct pairing indices.

Fixes: cb2f9144693b ("drm/msm/dpu: Add SM6150 support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
index 621a2140f675fa28b3a7fcd8573e59b306cd6832..81eb274cc7000a3b70b0f6650088ddcd24648eab 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
@@ -116,20 +116,20 @@ static const struct dpu_lm_cfg sm6150_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.pingpong = PINGPONG_0,
 		.dspp = DSPP_0,
-		.lm_pair = LM_1,
+		.lm_pair = LM_2,
 	}, {
 		.name = "lm_1", .id = LM_1,
 		.base = 0x45000, .len = 0x320,
 		.features = MIXER_QCM2290_MASK,
 		.sblk = &sdm845_lm_sblk,
 		.pingpong = PINGPONG_1,
-		.lm_pair = LM_0,
 	}, {
 		.name = "lm_2", .id = LM_2,
 		.base = 0x46000, .len = 0x320,
 		.features = MIXER_QCM2290_MASK,
 		.sblk = &sdm845_lm_sblk,
 		.pingpong = PINGPONG_2,
+		.lm_pair = LM_0,
 	},
 };
 

---
base-commit: a3d570eace66b4016f2692a6f1045742ee70c6b1
change-id: 20241216-dpu-fix-sm6150-17f0739f8fe0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


