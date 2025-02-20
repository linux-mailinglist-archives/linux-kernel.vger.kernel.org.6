Return-Path: <linux-kernel+bounces-523424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCCA3D69E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B725179694
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A501F417D;
	Thu, 20 Feb 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/MAMYcm"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD141F3BAD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047197; cv=none; b=cHOj1TZWy6n1byMr+N3AW9oN6e4KSeDMBhKXaomEvGkWYFUSPaGhIHdVYvv7yVixKfOfjr+yccP701YX3gQ1rRgITaX9SqBlOs+Df4QORAG3x+vZpnUCtzgmzXs1EvY6Q5Pd1yTaAjNxmJ7blP0CrfdZxXAbo62J0vHuIQ8SxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047197; c=relaxed/simple;
	bh=bTtPeLTR7bIGAjAGWZZbYSPB+kORXsbXpocudthnDVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/ZbHUiAJN2a3hNLJ8hX9APlFP/7cgjNFilpFFDsgZd3wlxI3l1HhIMbjEIvPe8rBAo5g/tV9DhCz4v6Lo517SaYQ5grgZqVRT5cfig1klh2jd/hAmnKQOvKwC55j0TxgxPP8QzoNLTXb4Z007SLhvye7BdEVZppw5EvYbZonxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/MAMYcm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54298ec925bso1298469e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740047193; x=1740651993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcgN3KcZQIKunyhp5MN5k0ww8zI0POS9d4nm1tGHVCo=;
        b=B/MAMYcmOMuUNs90y1LQc71PStCPU7RIt1KryJvVN+j24+d52Cbwp7OshD1Fcio95Y
         XQp+wXeCkwU8Tw+8HM3oWtjAakmZuglF/mr8qkKhAnyHTzcN7hGhVXRhcjbAwlpLzBGy
         nHZuiQv1rnIZO5prwl+BnQBzKFWdN/AWT4pGkKD6Ug07P+pK5FYxihEULuFb72FU98sw
         NT2WDi5xBzm4cjQqlhZgGVkI23j83ib0AE9VaQfa2s6gXJlW9c5OijyA8r29RAjIikml
         78GOhJrtF3nu/laGePuNkP2B/mDYXjCrbTTBV4ik9D+d5QQyWwV7u6ZtzcmDK3V6T9kx
         7FjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047193; x=1740651993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcgN3KcZQIKunyhp5MN5k0ww8zI0POS9d4nm1tGHVCo=;
        b=OJneNgX/bdLj3ixO4wucVAGq9tm6MeIWNkJkRzOIwqUVlaPXsSxbP+uM1c7NgNTeHs
         XGh865xZb7rFhEbCaYIagR/ScYZ6fx5oEUzc6D6BktsFXtnEI53T69gHQzICXYXaH+zT
         nSvJym3e8UQ9erhLsg4ZoW5NJhasSabGWEcR7o2oIHnkSee30G97sTf0jzkZGxoSE5Z7
         c/OCLkgPscod0kQ2vNTNSi+agHoRDmklLGbW+43TLX5egzHF84A8Ifga18lguBhaAnxH
         amyaAe9Js3CyssOrK6tvUjTkHM3HWagmrQrUb5L/9r6cuCko3o5+3Kln3OMHD4S6uXmS
         Fc6A==
X-Forwarded-Encrypted: i=1; AJvYcCVEHgYRxjlNszwgzSumgX0ab/KNcKUSPeGOCYkW23VwlCT1NGCVCq3aUenezN2yJeRszgA3JIMogqxYrS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltPwjRKCxtgnhtxqD5IMneFLaOpvTnKQX7GaoD+1cvgJrD3X8
	fB981iLwy8za+APeJ6sSg8vK3yNpkuQK+0B+COU9Lh89YLy4cK+RGgfgqbVhZqc=
X-Gm-Gg: ASbGncs6L0waQQle+byCNM8t7iePxpUMgzYMGXjYZLZDclLymGU19xVljEoV6lAT12q
	6tEQUjAp/9IVboAaurzG6B7DFVjbkytsZ2n4fh6mXVQWeuk5dQohXjlxqiYhcoEGmbFw+d/Xh68
	lmYZCfn85LzeO3M1y5XbFyvWXCFH/nUyZ3uDuvIaY2wD1RxA+UJ8BQ66pIckQSeqD3hzIhV92NL
	VeAd0rt4tKJxC3sQn88Qv48//Ex/R7vh6+pW6UEHeFfzrNltnHC9T1eQ71MBC1szR4fgJpXrFCl
	69vuYgZAoDSd+pHrL+YNWwI=
X-Google-Smtp-Source: AGHT+IEM9+GwpoyKZl6DXyfHoUFNWFP013z/rJDJY6azNQJu3BsrfRzXnCOVs/HY3FvHdFiR+OFW2A==
X-Received: by 2002:a05:6512:2396:b0:545:1d25:460d with SMTP id 2adb3069b0e04-5462eee6586mr3144030e87.12.1740047193190;
        Thu, 20 Feb 2025 02:26:33 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545e939224esm1588052e87.135.2025.02.20.02.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:26:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 12:26:23 +0200
Subject: [PATCH 6/7] drm/msm/dpu: allocate single CTL for DPU >= 5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-active-ctl-v1-6-71ca67a564f8@linaro.org>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
In-Reply-To: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bTtPeLTR7bIGAjAGWZZbYSPB+kORXsbXpocudthnDVU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntwNLcO4pIN+ypbPAk3kZc9xkCx3N/uJ1cgUA4
 9Jx+DG4DTuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cDSwAKCRCLPIo+Aiko
 1b4sCACwhvMnemZlynSEuUk5qg5JVNllVcUdExghA2X1IiBLMjPPRqFLSOs40D2uxyzV5xc8ZkN
 DV+h0qhdC20PUTM7ZUtl/Ngb6gvmA10XOTFlli0ITCbOuItVfJrj8QopMwsQasQ4R32Xg6jXOnA
 jy+HXtzpD4feH+5hz+PiR8v+ZOe/epUccGfXOIx0rEJ+tD0RT1htDMg34FAlmwkPKoG+pBz4E3N
 KpX15ArRQDd5zAZrsb+sKYoVcbdWkU8wbvOzcc5dudT95O+yhmYEThoIIShE6NwdvgibQL0U/8k
 MBuoevG8EUDJ1+wSsL3VJkxGBSalC90b4I6Bo9QB5AupStG/
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Unlike previous generation, since DPU 5.0 it is possible to use just one
CTL to handle all INTF and WB blocks for a single output. And one has to
use single CTL to support bonded DSI config. Allocate single CTL for
these DPU versions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 5baf9df702b84b74ba00e703ad3cc12afb0e94a4..4dbc9bc7eb4f151f83055220665ee5fd238ae7ba 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -53,6 +53,8 @@ int dpu_rm_init(struct drm_device *dev,
 	/* Clear, setup lists */
 	memset(rm, 0, sizeof(*rm));
 
+	rm->has_legacy_ctls = (cat->mdss_ver->core_major_ver < 5);
+
 	/* Interrogate HW catalog and create tracking items for hw blocks */
 	for (i = 0; i < cat->mixer_count; i++) {
 		struct dpu_hw_mixer *hw;
@@ -381,10 +383,16 @@ static int _dpu_rm_reserve_ctls(
 	int i = 0, j, num_ctls;
 	bool needs_split_display;
 
-	/* each hw_intf needs its own hw_ctrl to program its control path */
-	num_ctls = top->num_intf;
+	if (rm->has_legacy_ctls) {
+		/* each hw_intf needs its own hw_ctrl to program its control path */
+		num_ctls = top->num_intf;
 
-	needs_split_display = _dpu_rm_needs_split_display(top);
+		needs_split_display = _dpu_rm_needs_split_display(top);
+	} else {
+		/* use single CTL */
+		num_ctls = 1;
+		needs_split_display = false;
+	}
 
 	for (j = 0; j < ARRAY_SIZE(rm->ctl_blks); j++) {
 		const struct dpu_hw_ctl *ctl;
@@ -402,7 +410,8 @@ static int _dpu_rm_reserve_ctls(
 
 		DPU_DEBUG("ctl %d caps 0x%lX\n", j + CTL_0, features);
 
-		if (needs_split_display != has_split_display)
+		if (rm->has_legacy_ctls &&
+		    needs_split_display != has_split_display)
 			continue;
 
 		ctl_idx[i] = j;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
index 99bd594ee0d1995eca5a1f661b15e24fdf6acf39..130f753c36338544e84a305b266c3b47fa028d84 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
@@ -24,6 +24,7 @@ struct dpu_global_state;
  * @dspp_blks: array of dspp hardware resources
  * @hw_sspp: array of sspp hardware resources
  * @cdm_blk: cdm hardware resource
+ * @has_legacy_ctls: DPU uses pre-ACTIVE CTL blocks.
  */
 struct dpu_rm {
 	struct dpu_hw_blk *pingpong_blks[PINGPONG_MAX - PINGPONG_0];
@@ -37,6 +38,7 @@ struct dpu_rm {
 	struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
 	struct dpu_hw_sspp *hw_sspp[SSPP_MAX - SSPP_NONE];
 	struct dpu_hw_blk *cdm_blk;
+	bool has_legacy_ctls;
 };
 
 struct dpu_rm_sspp_requirements {

-- 
2.39.5


