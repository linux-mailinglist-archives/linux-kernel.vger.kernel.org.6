Return-Path: <linux-kernel+bounces-306635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2467964190
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97A9283A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F91AC436;
	Thu, 29 Aug 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPUNmORm"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5A1AC433
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926773; cv=none; b=mfW9neVrK0p9FCuNduQjKJfvnfkbq79dQJAf+yEUlLkJBNj99HaCRcrVVGaqpLr1cL1Mz8TZnmhDTIrpgGNnuSvShNIFMPUCGq+KSH6lSX2nc2dpcF6WSwuHHkTQHjBOgpa75RAX49jeZ5jVP79IyWRX42OR4Nru5fzZwrX2bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926773; c=relaxed/simple;
	bh=SPm33PXBWIKSppH1J5nRIqVSKT5JheP2bTluuMrYOXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/5kZRWxR495MqcV9/wYuEL/s3WRjXrxcc5nU4BTnG3SV3E1qFoMUM56VFhstaYyv9HhTRYTq+rcABN7+tBf4J4DmUOug1DtYBAOTk/B5j15DRZ62TCcnorF6GQJA6uYXQUKSVdVtOMjHelYKMihMhZvUy8CxQsqaKsh60FjScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPUNmORm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714186ce2f2so424794b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926771; x=1725531571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YT/oslnAviObem/Io85gQj+L4LOssdl6Cnm2LzK67QU=;
        b=LPUNmORmV12hDCyx5U7vLUYtRZe96r5G1MdzN2N+MYLV18XImDspUdXBpD34RncjXu
         wgY7UvKhofnayZtjL2MTzx0OswTZL0gc4RNYmvxKI/DDliiBcbECah4njny6ShbnNrBa
         RV9/LLhx8i0CX23utLhX4YOF67A3ZwrlehVyRipP5QhQ0VCi7BJdtnUZOFtbEDT8rWae
         vm9LtGHn9CqjWW5kAv70sofwx+PLTCR42BtlA0F65DcGs0TE6bFI94UNlGDuo/xB5qmH
         0OM+MEBMsEeeF0p0L3TIxXhjc98c0XrXVSdKwMa0hzT4727TG8h9RMlB3YTJIfujuX4x
         vn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926771; x=1725531571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT/oslnAviObem/Io85gQj+L4LOssdl6Cnm2LzK67QU=;
        b=bnTnO1ehqV9DILwpi04u66TYaE8JDS+sgo/tCU6tmta7MkSrcyA86eW9nE4yAcw5jx
         0UlQAy39NA+Vs4YHWSYfxcbwqGTZ9NISJheqeodlt1HTD8jivDQA8kNJlePg4EYsx7d8
         X3G2ipIlGMjtwKELcLhDC3V1cHkjF8BGfELExPjgZgXjeUFQF56dLYkGmEgFP5Fdgv41
         bc4Rk20gN7VmRxBCucnnPM7RbjbAfy7ZCY+buxgGZhxO4HqQtUxDUMYYG8NEWtXhUTBo
         ODrRTg5pSv45bp7Xh0FbMjfX05pg7q/xrMev4WDAeJawsXAbP4i/nhpsgYp3gGhUO12K
         3vhg==
X-Forwarded-Encrypted: i=1; AJvYcCXUh1yS9Twz0rwkXfirTK8YxZeydpbhk392sqAY7fXNZZhkfWryCqlTX35zUglT3XwQdvvYHxwtdpDBQkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMKtY579jYzah0rs7pl+zN8WX0HNk2uPEyoNKE7XTrJNiU2Vv
	XQ7z/U6odO7OSySxUKNm/zk2l649GbklIFGC8JtHlavyUgGZHed5k3xFlYcsFX4=
X-Google-Smtp-Source: AGHT+IHcvsg7fZYGxqm7ChIBko2zPV37f4pchYS4RO/UEJv/BV2Datn0nVhZhKL+JHS7piaG7e078Q==
X-Received: by 2002:a05:6a00:21c9:b0:714:2881:44cc with SMTP id d2e1a72fcca58-715dfaf3a0bmr2666674b3a.10.1724926771151;
        Thu, 29 Aug 2024 03:19:31 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:19:30 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:32 +0800
Subject: [PATCH 03/21] drm/msm/dsi: pass the right width to dsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-3-bdb05b4b5a2e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=2169;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=SPm33PXBWIKSppH1J5nRIqVSKT5JheP2bTluuMrYOXw=;
 b=2uMFbX70ER8OkBTRn+QVNb6hp3X5asWvQnYadjSLOcg5TmgHNJubsEGmnCe4Vuhcmfo3hKd+l
 Q1K6HbGoKNyBFSkdiSz9mYPQkAwUWKvJeWIfcvYYF/5SnKzF16Wwo7d
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Data width for dsc engine is aligned with pipe, not with whole screen
width. Because the width may be halved in DSI bonded case.

The dsc width is not related to the timing with back front porch in
later stage, so update dsc timing earlier.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 7a4d9c071be5a..5abade8f26b88 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -953,7 +953,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			return;
 		}
 
-		dsc->pic_width = mode->hdisplay;
+		dsc->pic_width = hdisplay;
 		dsc->pic_height = mode->vdisplay;
 		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
 
@@ -964,6 +964,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 		if (ret)
 			return;
 
+		if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
+			dsi_update_dsc_timing(msm_host, false, hdisplay);
+		else
+			dsi_update_dsc_timing(msm_host, true, hdisplay);
+
 		/*
 		 * DPU sends 3 bytes per pclk cycle to DSI. If widebus is
 		 * enabled, bus width is extended to 6 bytes.
@@ -990,9 +995,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 	}
 
 	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
-
 		dsi_write(msm_host, REG_DSI_ACTIVE_H,
 			DSI_ACTIVE_H_START(ha_start) |
 			DSI_ACTIVE_H_END(ha_end));
@@ -1011,9 +1013,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
 			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
 	} else {		/* command mode */
-		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
-
 		/* image data and 1 byte write_memory_start cmd */
 		if (!msm_host->dsc)
 			wc = hdisplay * mipi_dsi_pixel_format_to_bpp(msm_host->format) / 8 + 1;

-- 
2.34.1


