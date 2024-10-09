Return-Path: <linux-kernel+bounces-356593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5B9963E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569CD286A31
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FC118D658;
	Wed,  9 Oct 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2u4kKfZ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2918E023
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463832; cv=none; b=PqT0B7NOsZzRjkw/5GCcAeg99zOmWKNPyO1L8r9cOxNGvoSPOm5Ne+bcrWTKNk2p05FbxD0eAWYSas3MslxruWRUSPNOkXvKAo1/a29H9h+T42hJ67ZZlT1UbVcaZf7CSNb03WXv+PuJmFLmAHZM3OGuvciFfyMaxGMk9BBpF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463832; c=relaxed/simple;
	bh=AOnvev//l48K9poLpI3b2jyK6oiNPwqIXWbViweShqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ys9CUBHSl0e7EyY/zIQRajLkScrAMCAVtph88/cqEHpHKAuMTfivQWJRKMbsC0cAONt0Qr8BKhZKyLjcxnlguJQ1X5Yj9v3D4b6Yb3jl2kUup1BmW0z/l8HFwIY+KZnAsMwTlSSOL/fRYiQD++a/MMoIBWM1fmOjw1JAUUDTHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e2u4kKfZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0946f9a8eso4536571a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728463830; x=1729068630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7bIuQoomWT/rx9ticSN25UJS+k6AR92dNlVIMn4xi0=;
        b=e2u4kKfZuBliioggdDtrXMdMyJ8fU22MxCvqohdZJTgX2t/2fCghwRDNetylRT1+5E
         17BP5gfcc1Q1Z0b39w1VnVDTNny6h0VpbkRMJLj20OhazKVRQS4p6te/aBUoXQo5yN1h
         rSDRKddOhE22TrYCG2NmTuyb9ZADj9WKCiQdmxDqor1XT5+mWS4AR5gxLC5VEgdQNJTB
         ypobbUpVaAhNkFlYVNIeLCEyGHGq36USGo0DddRffBlrZ0RRgkg0DwaGLJfJ2ZX1PHg8
         si+U6VdVEzb7PALKo5z39XrlhBAJG0PRZ9HcWIyJbXhQ6JEkEbs/QUVDtO94+iXbbf0y
         fagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463830; x=1729068630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7bIuQoomWT/rx9ticSN25UJS+k6AR92dNlVIMn4xi0=;
        b=aJVheIgGmfgJfD5Ti0LRMa2o5OWL45s8k2k40kXJZRCc3lk+DsxQypamLgXI0lPtN5
         8A0jA36Lz56iKJg4DxkiuSvOAZlvHx/kVDCrbWtemwH96haDo+VMIPpmIJR7Z9BhCy1y
         225v617CafA4Cp0Us7ej3dhI3Dh9Mp8w6Vg1JtCy9lW7CLW+FHOooihDUDhxyhQpqkY+
         7eF2qPUaIqO7e5+ijEu4E0tVNWm5XvjDfcujG4llc73MvErLqj7v1THzCvO4vcLV7Lm/
         L5tava3q1zG+hs1TLeug9tz7EYWWYqYHJwz3QcTLvgXW9PcAuRgWM9AXTznxRWE9+wRX
         BPMg==
X-Forwarded-Encrypted: i=1; AJvYcCUl6rChLfkRnJYWJH5m0fVXJYM/LMPbTOPCVqG43yXOBPtDhePilFnkhoRQC9x+Zi0Cp69h3dEuysZYeCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpcb3gx7zxLJLE8xXvHgBu1C7kbYCPvIEv79Qi2uD7M2y9Mzx/
	U327kyUraCpehEzR9teKlHG1iWFMnjlH+iKzggJsi9XmYWooFKyyEgrBULb/42HqL4aqQQD038z
	BIpIIJw==
X-Google-Smtp-Source: AGHT+IESUTwygnYBSZdBsUDXgtACJ/v1ab4RJl/GTGW8J3oCmqBYI3AAq2s4v5mchDc9OY7NZ7CVOQ==
X-Received: by 2002:a17:90a:cb01:b0:2e2:9314:2785 with SMTP id 98e67ed59e1d1-2e2a21ef23cmr2286037a91.5.1728463829841;
        Wed, 09 Oct 2024 01:50:29 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2abad236esm898157a91.10.2024.10.09.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:50:29 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 09 Oct 2024 16:50:14 +0800
Subject: [PATCH v2 01/14] drm/msm/dpu: polish log for resource allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-1-76d4f5d413bf@linaro.org>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728463820; l=1834;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=AOnvev//l48K9poLpI3b2jyK6oiNPwqIXWbViweShqc=;
 b=ZoaNma48RD560N7Wpt6QTcmjBW200b4i9cEzu0XKgwNwqPVL8i7T69/tEfkxovejkPIu+Mr28
 li84Bu4qOo4AR+M+tDz5CECNYXgVmRhxQvGYnbyCwDuNNtvMOBsqH7e
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Add resource allocation type info.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 15b42a6683639..2b03ab907c2bc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -778,6 +778,21 @@ void dpu_rm_release_all_sspp(struct dpu_global_state *global_state,
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
+	[DPU_HW_BLK_MAX] = "none",
+};
+
 int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
 	struct dpu_global_state *global_state, uint32_t enc_id,
 	enum dpu_hw_blk_type type, struct dpu_hw_blk **blks, int blks_size)
@@ -828,13 +843,13 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
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


