Return-Path: <linux-kernel+bounces-306643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 711009641A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B15B260ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7BA1B012C;
	Thu, 29 Aug 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEWs+/XK"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760D192B9F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926826; cv=none; b=P2pxjxI9gYxUi+5xAFW61RcA516aRyjY3wvxl36zOgs/vOEbZUS35yPivfoVH0VSoDE9vgLJepTv5Ug6kuHEPXbrx71C5gXF/wXLgs2TttM5Kj8rN6Y7cUIyxdaER8uvaLgVbpQahK5psPPF0ff/D54KKkaFcnd3JpjnSh4ElA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926826; c=relaxed/simple;
	bh=J9qbpND/oK0fAXiMDbCuIZnkaZ9CaAJIulB/ZP/a6Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ugo/SZjDLD04x+F/nXYMWUzStdJIjhdSxLfcck59KxpnFfRtWsHX0o4YnRy77AFM15H6694wnQ/yJFRduXPf1x2s0vPDMoi5kF94m7Drk5ruy7+Q4LRLJvN8M4SYAKrCs9UXTcGSeOpbbkqA99BANzi9sXLVGOodJ2Wg/K2AJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wEWs+/XK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141285db14so438970b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926825; x=1725531625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqVaFuXRTjcV6hpBsvv8E/abzRWrI1lYc7ZkudzQdyo=;
        b=wEWs+/XKX4mHvj5aroO1v4Da9I7ljbCaRE9ejgYuwSIKZ8k1eMzAjDQZXHrbpeY8cE
         EwxSvbMDDS+cPALmhGSbRCTo5R5US8/4rt4+6K1i/Uac59Ms43xs2Qp82R6ZRYbrHyof
         sMy0Ge/dU3VLmIGGo5QT1RVrh6z7eHzdElEsTkD2Iwv31DlKS0GUksN1Xq4t+9lovRvN
         Je4NjQp1CRbPORIcPdVIiecqrntMNiTFP6RBoSAlqHlMPRVKG9hMxiXcCT4tVuL+dEwR
         9muaWpNbtoJWnQh/ZpxrDMjGh+Aytdlhr+A8sB1hwUsiTE2jSq6rConFc/LKNnzTqlo4
         REBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926825; x=1725531625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqVaFuXRTjcV6hpBsvv8E/abzRWrI1lYc7ZkudzQdyo=;
        b=pdrdf0ln048S1yA4vs8HbhqaPmHIXj2QLmImu9LEwNFSqE1C3Ha716tI3EqZ0HUmRi
         sLJjpspvMxc+lsP4SWNGt8wU4Ob/nv/FT3d6Pc3P0PH6o366TWHunDjcueeg06UfPGXE
         rBHruZUPAokoIAwFrTI9FT5lW62Zi5mbFb1YVjoR3Hig0y0R+pG5enylozFY3dCwJl/L
         zAQviCdmj4br4r/znRjNWi7/njLwMF6MXxpVRZAlIN0iY/6ux/CWKVMcuwpZSW76LRlP
         wehnBmREvUpGBdCFgRl+ioCSa8UjEnkdFB8mTOnVs/bAFKcqpYx0FKmLnRSauAiGH6YI
         l0ig==
X-Forwarded-Encrypted: i=1; AJvYcCVCKszTJjY2VfzuC3CgrmbswXTpipmCtirBQWIzxXalfZQsxj414WNHLSre0KMrGKafJdJT5DzOCkR2VMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTsY1UuDrtY0CHzUUFnhuU/9qqPh1Brj3SjlLIjtHotfSX2OW
	dHdn+ikocVK/mwJ5cxJtD51tvE+4JqqC97S7w1bboB0ZDBoBGiR0/KCa1rlt5Zixw0rcCEICloA
	/IavjwQ==
X-Google-Smtp-Source: AGHT+IFFcYQklmFqvsFpUrteERi7sYJuMzaDu52erTAc7hG9eMzpIZmxHDrIi9iF92E+PnEl7bRKMg==
X-Received: by 2002:a05:6a20:c908:b0:1c6:a680:ef3d with SMTP id adf61e73a8af0-1cce10479ccmr2252451637.28.1724926824735;
        Thu, 29 Aug 2024 03:20:24 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:23 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:38 +0800
Subject: [PATCH 09/21] drm/msm/dpu: request more mixer for 4K+ DSC case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-9-bdb05b4b5a2e@linaro.org>
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=2153;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=J9qbpND/oK0fAXiMDbCuIZnkaZ9CaAJIulB/ZP/a6Ww=;
 b=2reSSKY4nTX2HXPWMGAjlTPGq8K51OYUY+VKwm+i9BINUgZREQbtA5f8i8d7LSSWkUPIvuj7B
 UDpmaeEAQAOAMDMADlR05u/TTonmyqRqi579jz6NI8X32aU6Ia4zUFr
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

request more mixer for the case that hdisplay exceeding 4096
and DSC enabled.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 05b203be2a9bc..33cfd94badaba 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -59,6 +59,7 @@
 #define IDLE_SHORT_TIMEOUT	1
 
 #define MAX_HDISPLAY_SPLIT 1080
+#define MAX_HDISPLAY_DSC_SPLIT 2560
 
 /* timeout in frames waiting for frame done */
 #define DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES 5
@@ -588,15 +589,19 @@ static struct msm_display_topology dpu_encoder_get_topology(
 
 	/* Datapath topology selection
 	 *
-	 * Dual display
+	 * Dual display without DSC
 	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
 	 *
+	 * Dual display with DSC
+	 * 4 LM, 2 INTF ( Split display using 2 interfaces)
+	 *
 	 * Single display
 	 * 1 LM, 1 INTF
 	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
 	 *
 	 * Add dspps to the reservation requirements if ctm is requested
 	 */
+
 	if (intf_count == 2)
 		topology.num_lm = 2;
 	else if (!dpu_kms->catalog->caps->has_3d_merge)
@@ -615,10 +620,21 @@ static struct msm_display_topology dpu_encoder_get_topology(
 		 * 2 DSC encoders, 2 layer mixers and 1 interface
 		 * this is power optimal and can drive up to (including) 4k
 		 * screens
+		 * But for dual display with hdisplay exceeding 4096, we need
+		 * 4 layer mixer. Because DSC has a max width of 2048 and
+		 * a single plane can only be used by one mixer pair
 		 */
-		topology.num_dsc = 2;
-		topology.num_lm = 2;
-		topology.num_intf = 1;
+
+		if (intf_count == 2 &&
+		    mode->hdisplay > MAX_HDISPLAY_DSC_SPLIT) {
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

-- 
2.34.1


