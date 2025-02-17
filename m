Return-Path: <linux-kernel+bounces-517806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BCA3861F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816523B8CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71C22257F;
	Mon, 17 Feb 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPEtYzP5"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0221E082
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801825; cv=none; b=eNMC9awSGlmfT9xl2dn9QsxHtWATKQrk/xQYEg1BxltYtVGHKkocmOcp/KGRs7hf1e3u6GqdTOQRbRUK555H65ATc3qPuYvCC13c1nikj9cChPa57u7yAMmy4+DmKF/iOc6um19uoqkX5zWFy+fdShSGdVakzY/zUmjGVYLFkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801825; c=relaxed/simple;
	bh=aJOtxV7p2hzo+78dTS+V6QD+6d00i3eKRY4QZgmhCkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nG7JD1tvzjz2rt+xhPmlwYoFBbIm4L5roh9p8lRx/opXMh16m06M9XtM4C9F0aK1NUNgwj+9VhuHgfN+bmALAbiWmTh/0hGBcXJakAYimJbGJ9R6kHY0BdAM7xB8c7ldUWt8NTbt8iTyopaLNC0jUAatTpEiz2VkSrsxsJv8JuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aPEtYzP5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d28c215eso61695605ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801823; x=1740406623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgZb9vFHqGbbrUhX0AClGPorEmPUShOdtzPqIURbFyI=;
        b=aPEtYzP5wfgvBIn6dTCKQmjiQjnnoyiU7idL7MZ4ch+0g4xp0cjxMivRwjtHSeO7Lj
         rNU6eqKRxTBC9jIDk2H1ysJr6+oYToy1+ZqrRnrtlivqOBCUlkqg5b1Dbc3woDs9Wucr
         wynhO9HZTPmfj4wfJSg9VqePbU58w94WqzRGKr5Yixs84bMad5YJe9ESHdfCOYfY/kK/
         sKPdl7gOWadJHWQSuVRqEhrM3DwMF4mPo9qUpg2KhfqQHQnb/L5T9qHo60swJ4iWyrej
         BVL6rrngDc6Yt2TfXvg93eXF5GwZ3tysTB7RL37F4jzVjgwgKtLwNqo0II5SguXAHmIG
         P/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801823; x=1740406623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgZb9vFHqGbbrUhX0AClGPorEmPUShOdtzPqIURbFyI=;
        b=sfY64xmvJJrK5UoKGnyMv59b4+6XOV+x+Ga5MWdzPBRrWbnHLzjHBsSieo1hZLenK/
         24g2QgWX0vkeyrc25OCuDcXU/qLooYUmw6ZpkHEDhzpQqg0fnXIeWa1kfvbX2LNobBIL
         OtVq5cXwu0icv4etsrt+tSBRL8Q6HSus6mINqOdJRsJYpFT8hxYMe/E0bvBeUzQhSfpE
         8W24zfw7A2N0PERNsCEsBpdRU4XTGmsswD0C48jPZbA8LR9/6eRtB+/E1cyIy64wTSmA
         +iK+vebBvVqQAO5VQD+C/GBHowKhQbDZ12ogYTBPwDLrj644dQ7vC45IUnYG6eyfn7xI
         JMLw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6BmVNC3Y3BNcrCIBSJvqknvsRoMnY3kzx57vORWdKVUT4+kBkSzkPKZiwbwChSeK8k+0lr+jfdWgRis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFs1MLvugmGXD9rzDujIfUtpt7rf2tFIzmolSmvdkLiSyqieF
	Bp0YZtFXwcqEwaiqXI1Q3QZHH3JS5uO7OCbue9YoQsJhFKtZzC6Gwt7WnkBfOjltQko3O0DLm43
	gYkBwxg==
X-Gm-Gg: ASbGncu75yIGws9MLokNUm6egEzvO2n89vBm2KW0E2u+dmuxd1rJWIcj6pMYOgIbMR7
	7xYNdJjd3x9+OYVHZYBjxhmwAcnA+oikIV2ExMH7K/GDH9sw/gmHsGJNzW7HCjjoTFOhNf8+9wq
	AvenAJkjX+7QQpGGP+1rzfT95o6BFW4R6STELy+knKIXVroZb05iyiBXrMbHpBcJyj6t0VWevv5
	zBghn0e5jEFbXIXjWeoxAB4aqdt2ef/YQwi0yxBdj3tIhfgBJKp+Z3+7xQCnB9CWUffasvjlRb/
	c9hZXYX1NJPD
X-Google-Smtp-Source: AGHT+IFeltiqYZ01XeVBukpD9aotaPbVJK+H+9lmaQXByPgl7WgVurkIerWDOUdc5+qfs9Bzr9iwVw==
X-Received: by 2002:a17:902:d502:b0:21f:3e2d:7d42 with SMTP id d9443c01a7336-221040620a5mr151503565ad.23.1739801823386;
        Mon, 17 Feb 2025 06:17:03 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:17:03 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:15:53 +0800
Subject: [PATCH v6 04/15] drm/msm/dpu: polish log for resource allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-4-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=2259;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=aJOtxV7p2hzo+78dTS+V6QD+6d00i3eKRY4QZgmhCkQ=;
 b=IDE1Zdpu5jFx+kMQo1OdjkeN0YD3cohBgglvXImn3/+XiN2uPyTRmcdz8y2Y28SIQ/cyuUHqr
 5tEYBuNeq+BDREy7yr5nkqDHi2QzYdzRe5eXBuxeMWhgOeSeLWJndDW
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

It is more likely that resource allocation may fail in complex usage
case, such as quad-pipe case, than existing usage cases.
A resource type ID is printed on failure in the current implementation,
but the raw ID number is not explicit enough to help easily understand
which resource caused the failure, so add a table to match the type ID
to an human readable resource name and use it in the error print.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index a67ad58acd99f5c14b9ec34806b83c7a58b71e16..24e085437039e677e0fb4bbd755a8cb3852300a4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -802,6 +802,21 @@ void dpu_rm_release_all_sspp(struct dpu_global_state *global_state,
 		ARRAY_SIZE(global_state->sspp_to_crtc_id), crtc_id);
 }
 
+static char *dpu_hw_blk_type_name[] = {
+	[DPU_HW_BLK_TOP] = "TOP",
+	[DPU_HW_BLK_SSPP] = "SSPP",
+	[DPU_HW_BLK_LM] = "LM",
+	[DPU_HW_BLK_CTL] = "CTL",
+	[DPU_HW_BLK_PINGPONG] = "pingpong",
+	[DPU_HW_BLK_INTF] = "INTF",
+	[DPU_HW_BLK_WB] = "WB",
+	[DPU_HW_BLK_DSPP] = "DSPP",
+	[DPU_HW_BLK_MERGE_3D] = "merge_3d",
+	[DPU_HW_BLK_DSC] = "DSC",
+	[DPU_HW_BLK_CDM] = "CDM",
+	[DPU_HW_BLK_MAX] = "unknown",
+};
+
 /**
  * dpu_rm_get_assigned_resources - Get hw resources of the given type that are
  *     assigned to this encoder
@@ -862,13 +877,13 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
 			continue;
 
 		if (num_blks == blks_size) {
-			DPU_ERROR("More than %d resources assigned to enc %d\n",
-				  blks_size, enc_id);
+			DPU_ERROR("More than %d %s assigned to enc %d\n",
+				  blks_size, dpu_hw_blk_type_name[type], enc_id);
 			break;
 		}
 		if (!hw_blks[i]) {
-			DPU_ERROR("Allocated resource %d unavailable to assign to enc %d\n",
-				  type, enc_id);
+			DPU_ERROR("%s unavailable to assign to enc %d\n",
+				  dpu_hw_blk_type_name[type], enc_id);
 			break;
 		}
 		blks[num_blks++] = hw_blks[i];

-- 
2.34.1


