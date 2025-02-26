Return-Path: <linux-kernel+bounces-533845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24178A45F35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B2716BDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253EA21B192;
	Wed, 26 Feb 2025 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwOq6aSZ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1B21A457
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573167; cv=none; b=lh5cr+oaA0juEtTLrVuKJGaUKbodMutREUeKptVH9t8kMUqh/nzpwW88AD6PBQ/EVP7cYdiLjJvaMPHt0jHXbsH8fIC0mJTTeUTJ/Z6mc7UcW0YTsq23KyGEmXaQM+RMPr69mE7HV8itrFnvcsoAoaePvDqivwdjrRjVqnY5320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573167; c=relaxed/simple;
	bh=80huhgGXFEbENAM104XVYwfft3r9+sKb5+LZQUUxkp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq1a4SgRoQ2hMcFPerTj6x4svJOwMKJTeK4Eci1ErhbVug+BXOLwIusW6A2XIA/GxY1pfOH6jF16jh3qykHKGGlZVcobVj/pmkiRRelcT/kYNFdQ2pb83PU7qvxhpwKisSqTCwxs2QGS4p/zHqoB7I3/e50q4235NbThm7hy86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwOq6aSZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso10784439a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573165; x=1741177965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVHIeMwosUPS7NCbAFkat8Xssywx3I7J7mm+tnW6eUI=;
        b=iwOq6aSZUtS9YsnAhRbOB363NKRu/xLiDHIaE3cGUUQHVWkRiiLT/3Piqo1vb2WKHF
         g2FdN4drAFVxTPlVeHdA/BT80ZIoYbV5Cyz4tLL92LR56YLq7PiQT1EEifPs0/7y/IhG
         B78Cm19C4k1LzHRu9GlgUuGEZ8LX4uyRNzT8NQ8IkQINxSEo1EbfB60tV73WIk1jmnGe
         ASFN25w7PkgwQpOnn3wtU7Q5Vh1djERoluGf6EQuaXzhEh4MbLi7xOd9rZZVV2A3uhjZ
         euTa4FnoGobjRaOOXZ8c2UsfdQMC7LpMNRVc3IfC9pdshpsiTcnsKSFOr7Zvk8DP1xL/
         Djjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573165; x=1741177965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVHIeMwosUPS7NCbAFkat8Xssywx3I7J7mm+tnW6eUI=;
        b=wO1RuRv1aI9Ojp+XU5OlADqx0+kQns6cfTCUYhLMr1dmwCEgIiPVxfBQkVmkeKU607
         +5h+L6KelPTRGc08c+GfZzFobeUjMPDl3KoJdngaZtwCCBfhRP9pbcMbU0kJOEXSWc+x
         t8LcT86A1UbFqKKnoywEs8K95ObAJUAWo0VTuz2suJo8RiB7QubHyqyjsMT78p1twMO0
         r/TF6mLu4KQ+iBsvjMyV8JbQM4g7MAg+c52QnBLNMcVhB35ApvCSn2dgdERbBSqP1hio
         6z0ZV0AO+HNhxFAFABisu+zDyhoUTsmKBVzPOoumEGva2eyT/25b5yoigCuM+7isfrWq
         ZB6A==
X-Forwarded-Encrypted: i=1; AJvYcCUUtaOvFuOF9UmXaaJTI9hWysAIlwFV19vWeJuFcNCaycQkCagxDRgZik2J/GRejqXQievCFCYYOGEMAfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFHAhRYlm7hOJavo1WAT7XOTrrgKGWapiTMHY9o4V0ndrBzTO
	g7o7ZDWdRElY13ewzCL9UL+GjP1yEajn9A6FxXokNNXWqEE8TS7sYBPD6SZG4wU=
X-Gm-Gg: ASbGnctg3gMS3Nkxr72VGrt3NEfhRrPIX4SRHj0227bHDD2Hx6AKZU+GfKqyGDnftVE
	ke1lvOi/YEZeFAWA+PCQmqcSEX/0WIyuuAEVXguNJAenNY8N5WgtHnPaNdYTBv5AYxX3qdr3hcr
	khHLrVJZf+V6xb8zHTmuj1s1/B2Xf9xFAQbLKNofA8OeQ7bCCuk+l63t4oAwYZbGIEWIL4alse4
	8gxvnZqSwrEyrHirTAiqxeNB8ddd65ijbmtHT4yVfYoQl3UMeaqlE1m9HxeA4NZ6sSOYFNEew3i
	YIojhZEtGX8kpdaVNpOY4Ns=
X-Google-Smtp-Source: AGHT+IHHnvY3kAo8md724TLX/w1JYETJEQRhRXOPcyrnv9Hw68j0FgOVTVXm6m2F1RCRi5C6CxILig==
X-Received: by 2002:a17:90b:2551:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2fe68ada3ccmr12141180a91.9.1740573165406;
        Wed, 26 Feb 2025 04:32:45 -0800 (PST)
Received: from [127.0.1.1] ([112.64.61.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm1352479a91.29.2025.02.26.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:32:45 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Feb 2025 20:30:53 +0800
Subject: [PATCH v7 04/15] drm/msm/dpu: polish log for resource allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-4-8d5f5f426eb2@linaro.org>
References: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
In-Reply-To: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740573128; l=2320;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=80huhgGXFEbENAM104XVYwfft3r9+sKb5+LZQUUxkp8=;
 b=N800EMJxkM870hTlh1d1YNwghKBAv8eUi9PS91ZMRhMCmx8xuZNr/cf+VD5ktphz+UCqq2yKS
 rz/q1cuzprYDmmKZsf4SJJ0WuTvxyJq32Zs41gIjKoZyWTEGbOZvkPm
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


