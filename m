Return-Path: <linux-kernel+bounces-517808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA2A385E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEC91885B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA822069C;
	Mon, 17 Feb 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGL4KcQP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91121D5BC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801838; cv=none; b=bBvUG6QJiqrWu2rPS5Kn/8qMIQ+j7Q9vKuh5N+AR4+RufPcQE9lgUKDtr8St+MqT85TbVLntRHC19NYkyg926a8dHAAsd6wc1S+fgxENQMjl64PMkhJCZ1uzxI20LXoWWCUwYu1s9KBIoDAORvZgtR+M/QVJeRC6lqONvJkqEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801838; c=relaxed/simple;
	bh=94sGM0uG9AA2R84ut2aXyN09vsNy3Mf9Tf086GLox/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnEg8JLH9QN7X7FdL9qoxb9j+CHGRK3nvi8jgXTRYDFNb306sSIS/uScLOaPEyqcVKaZ3ZF2N1Qi09QXXpqpvUxk6cI633EylBkka0QRgp0Rwor3SKo9sIlNXA59qFyf68GSTxDtoHIu4dWzjW830b+63X+j2s7TE6oAhzVb7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VGL4KcQP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220bff984a0so77671375ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801836; x=1740406636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpxTAQa8072dELfu5kZ4WUb4EfPVG9CirHn3aioqsaY=;
        b=VGL4KcQPs4oZTZFyWu+DZFgbcjC0PYlfGONo5IOsV5p2KSJqORoKlo/fF2t2uZ2SVc
         5BIJAbvjCQkytl1/+tJSdnEB+mayekf8cylRujxKret47HpHIrPejBipxDObNbgpScFo
         uZHiM7RRvmsFN78CpAp8neoQXtOrdz9qrX+StAzJraS6pAOx1GidKJ21wDtyM2/gaSnX
         U22BbA2CojNZrr6tN6D4xq/wxXhIZZb1w61jAktzQYGXYCWQBP1s48gtXMapkvPv2D4R
         4CzO8Mcn/HY6Vup0H9/lUVeuvu1izXkBtRW9NWbSwgZ0/mLNKZgERJvT4GOWoMBOMyEK
         +9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801836; x=1740406636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpxTAQa8072dELfu5kZ4WUb4EfPVG9CirHn3aioqsaY=;
        b=TaU/cCbYQ9uvs9hCeA6VqxXtC3ISUxc3k7ml548CKfr6WbpJ4+G7UJ6VkwAzmNlSKM
         nfr42zHaSnhGLLG8xJeeN+zfRxSyHn44hLHSz88r3q0k51/3lf0N1ZAfCaMiHLAUJO6Q
         z+71ZGoDxXgeT/RqQcBZkx/Q0EM68nwe3c0NBlknuWioxg5Sl/AHvj593X+WN7UIfJAo
         1IOZU3t8VdDznILOYWnrz9fwbGqZU1TyfFvYMkDi9ieav9v/Xhsvdbi9YOrG0o6dzCZs
         t9tx6w3ewfKacJwzJf88FfEYcp034oUUucZSEKtE9eNKUmnr94yahYwAgjRgniH3RASw
         2bmA==
X-Forwarded-Encrypted: i=1; AJvYcCVRqVrh5BWAMwgBsvrqVWBBDMt9Szr7igRQ23vx56bF8N1Hz6ONsqXcSBvUGX9ZPJ40STi3wBpKW7Tz6jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7m8xlgjGdzSzGYHL/aVQ8JhE3FfTXNp7ghv0TtH2xHVHp25b0
	SUjp5AX7ZBLc9dYwKnJ1AjYqQGTnUk1tSW1dmWlWeQSFfkmad813ZQH/SKt6PM237Ild+UVLKuy
	6rnN1Gw==
X-Gm-Gg: ASbGncvjRY0AH4NMH7Kz2Et+XMn/MbxceQihnet/S3/z8zxC4TzxSRr/FShP/F9cLol
	awyx3/UOcN4Gt6VZiEYMC6FStd43cSu1F8iwCIEHWZso36YVTbuvKfAaniP0ywSzhSPm6NBXhwf
	8Ewr3aXT9fcwdOJBDHFmr3naYTyFvwnt8njZh5rqtxJGsSW22hyHCmkp+z54UBo75ogumS9olMf
	+8aw8dbFDoSmHSDQP2VGi84axwV4OiSnjud20kqBxv5+3GI4dCXYUIcs/LETMFwpzhNwhagEOcc
	miWh98uznkJZ
X-Google-Smtp-Source: AGHT+IFZHeIA0CD4UYx9Z3ngew6444gPSr2M1ZAt7fuz/lLqxs6zXEfEO8224qriYfC42F0X0mlf2A==
X-Received: by 2002:a17:903:41c8:b0:220:c86d:d7eb with SMTP id d9443c01a7336-221040a9a24mr171158235ad.36.1739801836664;
        Mon, 17 Feb 2025 06:17:16 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:17:16 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:15:55 +0800
Subject: [PATCH v6 06/15] drm/msm/dpu: fix mixer number counter on
 allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-6-c11402574367@linaro.org>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=1305;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=94sGM0uG9AA2R84ut2aXyN09vsNy3Mf9Tf086GLox/k=;
 b=sBcqZRv0ogKjajSPG9ugvgn2jWTjkmdxAHujjheTZRukMN9BXeN5vr1uB92ILnxrl+DGsaYQe
 zZd+h+j/wt+B5YZPhX5R72j8qaa2kWdGJpXRN6qzh7cAXO+14YMKzTs
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Current code only supports usage cases with one pair of mixers at
most. To support quad-pipe usage case, two pairs of mixers need to
be reserved. The lm_count for all pairs is cleared if a peer
allocation fails in current implementation. Reset the current lm_count
to an even number instead of completely clearing it. This prevents all
pairs from being cleared in cases where multiple LM pairs are needed.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 24e085437039e677e0fb4bbd755a8cb3852300a4..3b3660d0b166d9b0e947b2c918e37adaae8b76d2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -321,7 +321,11 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
 		if (!rm->mixer_blks[i])
 			continue;
 
-		lm_count = 0;
+		/*
+		 * Reset lm_count to an even index. This will drop the previous
+		 * primary mixer if failed to find its peer.
+		 */
+		lm_count &= ~1;
 		lm_idx[lm_count] = i;
 
 		if (!_dpu_rm_check_lm_and_get_connected_blks(rm, global_state,

-- 
2.34.1


