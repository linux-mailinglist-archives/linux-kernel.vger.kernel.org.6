Return-Path: <linux-kernel+bounces-446998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AFE9F2BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C569A1623E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD7200BAE;
	Mon, 16 Dec 2024 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAPBSvbd"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FF200116
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337659; cv=none; b=VC8NywpHbpZHqhlVzU6KW9M7RqofyYQfPcend7iU7o2ZRqEywdRkIusKcNeV/O1HKMpiqKdH5r3grk3Fpz/e/IRWuZQDuaYz7DNYfI+01n2fZRaBmOiSQDe2geqF8Pl6H0IVYTYF1xesdNBxcPWBeVQ17deUwwPpWZ2Oh/FdZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337659; c=relaxed/simple;
	bh=bJyPESVKaUC+ChFiQF2ba+YGs7hcFzITyl26AyryJho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGGI6nAWqIk/a1hyQ0OyF0JQUFdPuFbQwL4KCac2/vwSi8Jc1H/+I/YRTgwE/GC2r3NgiGOdtLGBwt3QNsoyDxZ1JYK6FVlIUqKZp8d6yxmLwiGCrelrvCn8dcdN2iKMp17q1FhoSOqt7Mo0ZfBHvVHXO1I9UTFc03gswm7x8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QAPBSvbd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401b7f7141so3571570e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337656; x=1734942456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjeVcGMhalEWw9xcCqMUL7so98QwVZkPwRwD7ozFXS8=;
        b=QAPBSvbdMhzsmF0jQnzvfaaA1CV9YUQaGOwLDRzcOZ7QM6bG2g2QPI26qUqwB0swMT
         PC1BTTm97OdclY8kYWiuPwAWb7bfJXEX5DBylV/yXIOy98G9c5hIRYsBveGYVtBVTSaG
         UZsKHMyJPCwVJ01k7IsMWxIDGQly9OUuYnS1FcEDXaBo9L3DQm118aS+HmJXlP4YUe7t
         xl9I0fR1VzmP5RqcGhFCUVFknfSEeUIH+k9Slyn0iF6m2Kcwii8AH0xpKxiXPvqUJX7j
         PGf6ijLq3pLqdW7Faz0VNNMmjTua16sir7K/i4jUpPp8CwEOQHVR1Xpz1O6DLT2Orrfz
         Rdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337656; x=1734942456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjeVcGMhalEWw9xcCqMUL7so98QwVZkPwRwD7ozFXS8=;
        b=dL71pZNlojYBdj72lOdWVkPHhl9D93FN0K9eosnRJYTTacZ0xFWCNSWWvLyWjdwU17
         G417f2YXH+yJoqepMknVUUYEWc03XX2uT/Rm5yDB7v9/zo2brsODc0m3BvbwT3fevN7h
         YHOATqaP5FZPR1Htx4IvTbxeHMJPovq5HYXfzxy4pMEuxLuvHQ0DVIzVQhNVf3igt4to
         yUHVKNqf+MO6zhIt5NVF9MFjXjDxjMseOu1qDNK54hUD4kvLVDtmtKmDRAdFUaDqMHLg
         yWlJgPA7oyBHrO+S+ETTE0fQDEUwqOIPwPNB0ZkdMXI/by28z/8+t6004z3aFoc8ShXX
         H26A==
X-Forwarded-Encrypted: i=1; AJvYcCX1FbvpmL+Ro1sKhtGyW2VekzgCU63s0lqHCIhiFyH/5pKPyNcmihmg7cyB89iHRARaSq5u6JtoB2btpwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7wqEztRPxFVRTmT8DbgvG2QUK9nES5f+mw5U8J2Jf1d54+HI
	KNNB5vSQqmaaAG+mUIlJH9h2QqG3AnyyviUT2cwGchuBXuWxKzxJu17f9TGAfW0=
X-Gm-Gg: ASbGnctdiZOfNCwJQibXrAYEJuP2ucpNBB0zwMmBj9tZyNdtRwWGm+KfyXotxseH9Q9
	IZWIEqE36pYF4H6ULYzJa6UffpddYSIoWjRgYi++8X2MH0D7IQkqPksHvSR5Qb0m40BPP3kQJgm
	jdTuVf2FYcScUAPq23gRg8LQrxK884gbO1ua3zx5fBX8rqghHg92Zk5dWIggJAe5qqG+rhxdp03
	uP4KYlQCTsaDPmiEE5Mg3/TcGIYK6ZIfNLOhacdr//XDfW3HpZMtbrDSwLLOiaV
X-Google-Smtp-Source: AGHT+IGaM+ZRb1OFrc1yp/HQm0eQzzmfQ0sLJ440wGVKdOn2/mFn3Nd/997hnnex+AYrS7uGr6kzuw==
X-Received: by 2002:a05:651c:198e:b0:302:26ff:d0ca with SMTP id 38308e7fff4ca-302544233ebmr31569821fa.3.1734337655950;
        Mon, 16 Dec 2024 00:27:35 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:27:25 +0200
Subject: [PATCH 4/8] drm/msm/dpu: link DSPP_2/_3 blocks on SM8350
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-catalog-v1-4-15bf0807dba1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bJyPESVKaUC+ChFiQF2ba+YGs7hcFzITyl26AyryJho=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX+RsYj676nOMBUcWu0Fh7OCpAZdVSpsOyhgCY
 g8rKfv/T8aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/kbAAKCRCLPIo+Aiko
 1fHPB/9Ao9hXUP9x6qbAqEBuksJCbxQyxmcXfPawdhm1QBaFs+qx2p/0VL5mXxsIMBUTsyftJ6G
 dSrnR4ASCTdvqedczP2FEqlgSTBic6YfXSrVrOo+ItdlTr/VhRiLjteBhqB18AAf2ONl6jNi0Am
 Wn5+9BRKSJDMFmbCXWUUIB+/Kycn2oAzv9UNnT9/Aqu9M/W43FuLjVbq71NJZmXM1GKmY2Ls0hi
 fE1v7zBkd4g98r+/avL33ho1dqMHjK5JcmTWZpebpFdbaOW8Rd4CaqmiH80NSY0ZgaXde3Bt7Yu
 THMpfE2x0NdM3+G4NdLTbNPEhEoSs9w74OkEsDYNoTNMVSFp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link DSPP_2 to the LM_2 and DSPP_3 to the LM_3 mixer blocks.

Fixes: 0e91bcbb0016 ("drm/msm/dpu: Add SM8350 to hw catalog")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
index aced16e350daa1bf5d24078b2468b5095a40ce07..f7c08e89c882038aa658955ca1202bda3d928e80 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
@@ -162,6 +162,7 @@ static const struct dpu_lm_cfg sm8350_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_3,
 		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
 	}, {
 		.name = "lm_3", .id = LM_3,
 		.base = 0x47000, .len = 0x320,
@@ -169,6 +170,7 @@ static const struct dpu_lm_cfg sm8350_lm[] = {
 		.sblk = &sdm845_lm_sblk,
 		.lm_pair = LM_2,
 		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
 	}, {
 		.name = "lm_4", .id = LM_4,
 		.base = 0x48000, .len = 0x320,

-- 
2.39.5


