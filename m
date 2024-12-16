Return-Path: <linux-kernel+bounces-446995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89B9F2BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D7E1882916
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369131FFC77;
	Mon, 16 Dec 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAfNKSBJ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E91FFC46
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337653; cv=none; b=iIbE/UyYDpEQocIuJCeqpGOSlui5ThMOrmWzJOst9hTIS3bfUTrDotZHL9O6i26og/vBfZO+jrAX257RFtukPN4/SxKrPArFJEMKMgEXvhvt2Dd9uivKEETLoTmQDs5ADx8IOSQlbysG6iNC5rnrsQLFuXST7AnD5de/YxVBYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337653; c=relaxed/simple;
	bh=9MObEe5KzGyCABZYczA3jsFGPjAHvUO1PrGscQg+Yd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUncvWkzaEgtE4LGAaxPUZC9Cd62n1zyoqkSlHnB1pCLZvlnugx3eR+FsIEEalK26EfcY8EAgKo2+3j4aLg0J6CO0+AXar285E4fCTXqPQq8l1Nug/2Zu6cz0LIam6NLAEufErjTCU3qm08sl8ZwJ+lgcSyNne2f4kRnn9Rxsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oAfNKSBJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3022c6155edso38474901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337649; x=1734942449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3QX07TGdBq1gHdO6oikHZ2FbBQpzQ564YrLte+zAm0=;
        b=oAfNKSBJyxIQ6l8JXm3nFDDMo8g8Qa4QGjnxUiTdpe4TC0T3lLhFPgjn3E6fowvNeq
         cSaK6lRKJEs9b4uAI5gEAyAU0rSfdGscqCoHbtGfuC2zn8gplpmQccMvrpHNE3vghtqD
         4Gok0amjI1Inzvc6/W12Yi/PrAHgQQH6hKEliQy4VLo52m97Oi3MM3OmWinv0F2bh4Zd
         /DGX/uq9hMlhAhhGGDJnlj7oQTsDlvn+WHmc9qErEPN3sTge8AIDVKK2YmSEEIMj+F9w
         HzqEdzvPF+ywYpZbiR6qPUMDnzzOYPu50DhtU6crE0wipH5FK9yN03e05AbssYE6Qkue
         9RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337649; x=1734942449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3QX07TGdBq1gHdO6oikHZ2FbBQpzQ564YrLte+zAm0=;
        b=NlaC9lwru2tUFDi2TBPVNZkesJFUrppK2W342qNgxvXxUHugRssch1nhGW2a/VL0Al
         bRLNSYSdYfCpCic7GMJqQ3RT/NBbYfykKSHWPPxdDQHIcuglvS7+xitpKdHa/qi6XJYV
         jbwR1HVr9PVIKUeV8atNvJqVp8S09XnL2i6yaNyAUc/U7wfNG996cYznOZho1pPleQBa
         silyafdbLiB4Ln3M9OsTYHz6WtXysE4XgZH3wf7KwiZ0LssPpkl/RZkDx1IBHwsnn3Ds
         su8m2dd7y9F4REB0re4v9FWhSi0pZeao15TNKShqPFG8qhBgg2OIKnHg/evAEH47J5tk
         nK0g==
X-Forwarded-Encrypted: i=1; AJvYcCUrsIrakZ/reVYFeJNoP8kbMhsfl3pmk9aQ6sEud4vPdojriqbnRlWoNWgTq4Q4gQq5qz/s0rYZYER313o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRYiDwdMfRLFVJVAAl7VoB4rHszkQBDPnMAObrUvkYA9c8fxv
	IQabC4tRca26HAFvEDtYBO4cLT3NLoTRd4rQYY8ODRYQqc7TIw1VB18Jt8j9JWw=
X-Gm-Gg: ASbGnct7yHsFdETBjb+OGHJ8RESfdJDN1WQB+oPivsp+U9/2g0v4kyl+DFqVyaNqdoG
	Og6VhO+0uFlknzaTSASaQkAL9kLMgKgi0XrmkwZc+nJrOR0Fr9pegTuPiF4YVx0awaUrcnAZf8p
	Ao1dFDmPkeM+5ExG4LXczVl9xCF4zyHnZywuVu9QvlD7ObJxLFYIJ5AmYGobB9JuU6o9JdC3SSL
	R0lQaXZR4S5Auysj2aqcIPP1vFlP3tQ2ZQsvplGNP9B2pp93oR8BFTSqFy8INFo
X-Google-Smtp-Source: AGHT+IFx724whJM/3tgOtZRukuS/DQOvI/WHlmOjoQuMlO70R1sWXtGolZHOH0q3MJfJtAKMP/bH+g==
X-Received: by 2002:a2e:a5cb:0:b0:300:27fd:a7cd with SMTP id 38308e7fff4ca-30254464080mr42374541fa.19.1734337648920;
        Mon, 16 Dec 2024 00:27:28 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:27:22 +0200
Subject: [PATCH 1/8] drm/msm/dpu: link DSPP_2/_3 blocks on SM8150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-catalog-v1-1-15bf0807dba1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9MObEe5KzGyCABZYczA3jsFGPjAHvUO1PrGscQg+Yd8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3r8k2yTndeVZTf/++P01X49twj3domE3+FdLPFdf7jMA
 mwT2w52MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAin/PZ/7vnCGkdk3tiWteX
 uPGqhuc0xeKKy9IesoUVn0Mm7CgzL8sq6z97evsLbSbJF4vy+pc//sjQ6nIn8SfLnLu8zZx7HqS
 o2P521re/VyWyaVf6Lneno+eihGMbky0amdPPvfRbdWrifa6p5ZdK8hLX3+5/bxZx8LPhYf+g/F
 WRzxp7p9p8ElTbfDLqale0x0yVrnK+H/EpfW3p1uecuM8EdDW47T11Z9dfmX+O3J/nhXen5uXZL
 2zf3beke9mnMtVQBV2rJsnH9yfpzP0y7arzzeyqO6/+2XZW77+bcJgtW59RIYW1KjAh4vbkaLt7
 FXFPjlyX3VXFevWQSOcPhW9/HI86/HT4W3T0KsvPUzHJAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.

Fixes: 05ae91d960fd ("drm/msm/dpu: enable DSPP support on SM8[12]50")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 6ccfde82fecdb4e3612df161814b16f7af40ca5f..421afacb7248039abd9fb66bcb73b756ae0d640a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -164,6 +164,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -171,6 +172,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,

-- 
2.39.5


