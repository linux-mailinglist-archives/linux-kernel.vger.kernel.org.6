Return-Path: <linux-kernel+bounces-517819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA504A3860B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFC18923BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F6225797;
	Mon, 17 Feb 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFLP5q2u"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF822578D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801908; cv=none; b=fW8s1F8nNpRSy6IoT6/UZPBOO8vALgIaI/nE4YYn1JQQtMZgbAccQ6XE+ACo4MiKQVW3uoOpDddVeBI883ElBfoDO+tS/4Hg8HJtUFGQZ7quRRSf1+sq5qEizguno2u2y9Iqyo/NiZn0d7hvttI/jG6Ex+lnxZfImbkyK4XRy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801908; c=relaxed/simple;
	bh=veu7hLXT3SD4D0Kyuw+V0KvUpZ/gY1t/JfEoWat6gtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHWNCfy0hdePd6W9EyoflMCLJsZBY5aTYCrCYC1f1gaIQQsqUbENIpkjA0ScUn8/dCzUM42ug8tjsfi9x6eeS10vtur/DElgVCMNVDbXfKSe/yfH5XCoZl0HImtRW2rR0T8v3bzuwBBI0pZLofyf1F+B8vNHBxoAiAAHvVbeP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JFLP5q2u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f2339dcfdso66145065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801906; x=1740406706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXLhjKi+Nzo0OfIZF64sRgLJpm5FXfzGgMsXpBNxX8k=;
        b=JFLP5q2u2QRxT/PZJ+aHpsdM2vBkDi0/p6rR+P2WDlQ3Zrjnbyr0o0i9sWyCQfYFDT
         nQcx/zjrWq+s7VURPcIeikLA22gARKSjf6axT7yiVu3d34/Hs2jDUhHd1GjNmgKoft90
         OUg7j90JZO292UKGKh/sVRKsrHGYoCeWC36yJw9hOGMnjFySzmCN1VztketYx0JFwWem
         eAGMOqA56X1J4FoeQdRbl13dcjn1ttj0+Hv3iysL12OlWkyYS9ahdN3e1HjQxbgZJHHm
         yLaOSwWuG/izheALwYpD28dGSl3E9Q3XyaWjzjS8LOoDx2W0wxMhtAM1j51y06Ll9HpW
         5Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801906; x=1740406706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXLhjKi+Nzo0OfIZF64sRgLJpm5FXfzGgMsXpBNxX8k=;
        b=DEd8+yqbz6zlzD7A+aDxtOVM5w+or6BXY/IKRciSyVhvxuzuy5vfQWI/xRD49+ntRY
         dVCuX5CO4rYk/qseG/m25wtX7nAs13iRCgacq+hdbhVvOLWRmcMaJeLPpQ44UqG2hdlV
         kQhklLyw79QY5hHkV56fXWhiISIb9aiuggvchVkhKUfPbXjX30up0UMA8PZfI5R5ytga
         mPI5Ki3rtM0EotMEzCsDUWGWSEI9I7LkjuA6H3/iu6Gvu7Clgisre7hyWCvcRLG376w5
         5aWzVCyrwg3dDg3SPQpjVMu6ufKvOwLLm7WlsdDQMpdXjDgfUfQxmNbJlC4olHRPbXgC
         cLIw==
X-Forwarded-Encrypted: i=1; AJvYcCU4yp092Xi+oeEvE0QJXPEcJ9V7JgoOOFY2iDZ/2uejs6ErtbBVa8tNf0zOEAsvQo/nutEShwjTRws4FLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1qLF3p6AzHofXpD5bRAmyZNm+kFUxeXeLE5Fy3DFUyr3R1IR
	Y8QSG5GutLQt/dsYp6jm1q9SaB5rzPcFlyXUpURN2PyH5S3uAhhXnGgZ0wjBEEaVv/vOEnl3nL2
	eAeFuWA==
X-Gm-Gg: ASbGncthM2MzIku5wdyLJMt1/8L6mbR7OEvCzKIhfsUoGcIdsfsxnrskfbhmYDAx5EE
	iv4LI94btrOrRK5zgrehCRW0/pkdAA9C6jQfJXD7i0sVNtZ/11UkYtt44O3oyiZrmT6m0SmS2Y5
	V+8eIxPIw3kBgAGWB4sHgi4LQb11pmWuanAtW45G0++rdaLoDIrRkd9/6rJPB6KLKB8kiRbds2O
	NaD4a9UyGMVVkTQBZxrujVG3GkCsQET+j4vy3UBu2JYFtdwK6rcXV7YTw8RYULvaPnBPssl2QFU
	JF9QSZQqb2hU
X-Google-Smtp-Source: AGHT+IGdb+TI0TyztzjV+M3t6by7GQP11sx53miPRwsVTLVzqy3N7a8SwYhWpx2NGAdC5Z8hX3yH6A==
X-Received: by 2002:a17:902:ce06:b0:21f:40de:ae4e with SMTP id d9443c01a7336-2210458f528mr169643645ad.9.1739801906191;
        Mon, 17 Feb 2025 06:18:26 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:18:25 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:16:04 +0800
Subject: [PATCH v6 15/15] drm/msm/dpu: Enable quad-pipe for DSC and
 dual-DSI case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-15-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=6380;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=veu7hLXT3SD4D0Kyuw+V0KvUpZ/gY1t/JfEoWat6gtQ=;
 b=d9M3KDoVU/iLbzEyL4YjLQ9mmF90OA6iC48MVzT+JQBCbawsPxmju9bSUFWMFYIeFV7lsWF2W
 9YlTcakHl8pAwncAsLQLkRkwRpgQeZDONcnMJMusmu3sZ2L7xguUOzE
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

To support high-resolution cases that exceed the width limitation of
a pair of SSPPs, or scenarios that surpass the maximum MDP clock rate,
additional pipes are necessary to enable parallel data processing
within the SSPP width constraints and MDP clock rate.

Request 4 mixers and 4 DSCs for high-resolution cases where both DSC
and dual interfaces are enabled. More use cases can be incorporated
later if quad-pipe capabilities are required.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 28 ++++++++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
 6 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 852c2ea632f1bb52b3d83ccd45c8afd2e5f8e988..6b306755fceb3973d2063b7983622543b71a723c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -200,7 +200,7 @@ static int dpu_crtc_get_lm_crc(struct drm_crtc *crtc,
 		struct dpu_crtc_state *crtc_state)
 {
 	struct dpu_crtc_mixer *m;
-	u32 crcs[CRTC_DUAL_MIXERS];
+	u32 crcs[CRTC_QUAD_MIXERS];
 
 	int rc = 0;
 	int i;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index b14bab2754635953da402d09e11a43b9b4cf4153..38820d05edb8b3003971dc6dc675ba8ede847be8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -210,7 +210,7 @@ struct dpu_crtc_state {
 
 	bool bw_control;
 	bool bw_split_vote;
-	struct drm_rect lm_bounds[CRTC_DUAL_MIXERS];
+	struct drm_rect lm_bounds[CRTC_QUAD_MIXERS];
 
 	uint64_t input_fence_timeout_ns;
 
@@ -218,10 +218,10 @@ struct dpu_crtc_state {
 
 	/* HW Resources reserved for the crtc */
 	u32 num_mixers;
-	struct dpu_crtc_mixer mixers[CRTC_DUAL_MIXERS];
+	struct dpu_crtc_mixer mixers[CRTC_QUAD_MIXERS];
 
 	u32 num_ctls;
-	struct dpu_hw_ctl *hw_ctls[CRTC_DUAL_MIXERS];
+	struct dpu_hw_ctl *hw_ctls[CRTC_QUAD_MIXERS];
 
 	enum dpu_crtc_crc_source crc_source;
 	int crc_frame_skip_count;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index c89a5da0fa8321e9082d5aee304fa16402bb4ad9..d4719b45f4cdd5d1f0bd585283c0c16f1df2f1f2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -54,7 +54,7 @@
 #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
 	(MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
 
-#define MAX_CHANNELS_PER_ENC 2
+#define MAX_CHANNELS_PER_ENC 4
 
 #define IDLE_SHORT_TIMEOUT	1
 
@@ -664,9 +664,13 @@ static struct msm_display_topology dpu_encoder_get_topology(
 
 	/* Datapath topology selection
 	 *
-	 * Dual display
+	 * Dual display without DSC
 	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
 	 *
+	 * Dual display with DSC
+	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
+	 * 4 LM, 2 INTF ( Split display using 2 interfaces)
+	 *
 	 * Single display
 	 * 1 LM, 1 INTF
 	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
@@ -691,10 +695,20 @@ static struct msm_display_topology dpu_encoder_get_topology(
 		 * 2 DSC encoders, 2 layer mixers and 1 interface
 		 * this is power optimal and can drive up to (including) 4k
 		 * screens
+		 * But for dual display case, we prefer 4 layer mixers. Because
+		 * the resolution is always high in the case and 4 DSCs are more
+		 * power optimal.
 		 */
-		topology.num_dsc = 2;
-		topology.num_lm = 2;
-		topology.num_intf = 1;
+
+		if (intf_count == 2 && dpu_kms->catalog->dsc_count >= 4) {
+			topology.num_dsc = 4;
+			topology.num_lm = 4;
+			topology.num_intf = 2;
+		} else {
+			topology.num_dsc = 2;
+			topology.num_lm = 2;
+			topology.num_intf = 1;
+		}
 	}
 
 	return topology;
@@ -2189,8 +2203,8 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 	struct dpu_hw_mixer_cfg mixer;
 	int i, num_lm;
 	struct dpu_global_state *global_state;
-	struct dpu_hw_blk *hw_lm[2];
-	struct dpu_hw_mixer *hw_mixer[2];
+	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
+	struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_ctl *ctl = phys_enc->hw_ctl;
 
 	memset(&mixer, 0, sizeof(mixer));
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index 63f09857025c2004dcb56bd33e9c51f8e0f80e48..a9e122243dce9006aaa582a1537980c86b6203a4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -302,7 +302,7 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
 
 	/* Use merge_3d unless DSC MERGE topology is used */
 	if (phys_enc->split_role == ENC_ROLE_SOLO &&
-	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS &&
+	    (dpu_cstate->num_mixers != 1) &&
 	    !dpu_encoder_use_dsc_merge(phys_enc->parent))
 		return BLEND_3D_H_ROW_INT;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 4cea19e1a20380c56ae014f2d33a6884a72e0ca0..77a7a5375d545483edb316e8428df12212191362 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -24,7 +24,7 @@
 #define DPU_MAX_IMG_WIDTH 0x3fff
 #define DPU_MAX_IMG_HEIGHT 0x3fff
 
-#define CRTC_DUAL_MIXERS	2
+#define CRTC_QUAD_MIXERS	4
 
 #define MAX_XIN_COUNT 16
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 64e220987be5682f26d02074505c5474a547a814..804858e69e7da1c8c67c725aa462c1a558d1b402 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -35,8 +35,8 @@
 #endif
 
 #define STAGES_PER_PLANE		2
-#define PIPES_PER_PLANE			2
 #define PIPES_PER_STAGE			2
+#define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)
 #ifndef DPU_MAX_DE_CURVES
 #define DPU_MAX_DE_CURVES		3
 #endif

-- 
2.34.1


