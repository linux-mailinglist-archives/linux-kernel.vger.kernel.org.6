Return-Path: <linux-kernel+bounces-306632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAD964189
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F121C248BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB761AB51F;
	Thu, 29 Aug 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtrmLu/f"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273C1AB507
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926765; cv=none; b=PI5ofyM80nL4GsXip0693xKJXM0yFBuhXpklewBdxPT9wq17PcxLpcxy0nz8zlvl/qiteW27iJ0PYhHoQfV++Zvo19+tCRUdoG9C0NKW5y+INytMFKEUDcjMpG34Em+bbR7rCVLOEhOFYkC9xEc7wb9ZhWioFksrWOmwZmQHPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926765; c=relaxed/simple;
	bh=g+FnEUgKwPDRZxJvT/CziQEGXapPMXRnc3Pzxh8cG8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghTSDr/L4MfrHbrPceVp4VMtBuzoIADPzU+Hu7yAQGf1arQejsooNFWL8//soZxaqD54RHDE4G6hANg21GLgWV2J+vny7FzW2YDNpHlF5XoECKsF6tn+CNQHjhgmG2qs18EpdJCsLenl9IR/0MOUt9+CtSkiKFmaKA5lOjYhr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtrmLu/f; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7141feed424so415930b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926763; x=1725531563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liJfUzuPiz+x1OeGHXt2r3UO2uLGH4OphxjUtIXOwkw=;
        b=mtrmLu/f2rBoHwbAoeAF37MfVeLlXEownM3TVnk5iVKMZKHgSJseoYZPds6LGSkj1G
         cXh1CfhiWFsdGL1Lgf19vGuKJCLihoZRh9MK5BqLXTisV95OmnBdkzhf71Bx0JErky9P
         xp/TsQudyK76cODWHW3+y0m1M8yoQsY6JnQcVJPZE3/ZOG3kR6JqlWV6C9f7al6v4hpj
         N+H+tONwXp/nf+ATC+kIMNuSSdFmpmhchy/x/A4Kd0Ru/MphBRfOWDbKKqrfDpezmRok
         vSWd+Cd+FDRkZOirie/nv64s5bGU8/DhFDUlyMMhlsBqPOtikjdoq+6W9VZcAayP98K4
         O5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926763; x=1725531563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liJfUzuPiz+x1OeGHXt2r3UO2uLGH4OphxjUtIXOwkw=;
        b=WQ16ZHrR4RS6hlw6zroRUc3ZL4kQdbTqG4Y2Poaui5DgqU+vO/NwOwBy85Ql8pdXDt
         CKkp32iKKZHhuarLj3Ne5WyehKl3PtcQtv4gN1ctkkNH8SUDG/5lWG3L1ftieCTFOG8Y
         hPMl1if5RCHz0tg94YklZVNQYVXIUtPRW60x9ay6Om3bKbCI+uTNZ0+G3Px4Ah5/llpq
         l1dBcOdaENtMxdn35v00DgXp4FZZPkvS/6z+Y2kaq+vYNNIBiXhU41SjfBFwRFp8Bz0u
         nc4LFcivOH3OwXDtSXsKcDM3UWmKhv8UkEBQtqAj3YNwJW/KpIcROabGnvqOAOmg49c9
         fJMg==
X-Forwarded-Encrypted: i=1; AJvYcCXnW+Q8PG9iYBjYUtfL+zB/XbdH61tkkQyUGeLMo0zbtVICA84o1ONcEIboLhz0zHWb8eONiIemZKTO9Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVLfuMI6gtsJC36LIrL5VfwixHLAKb4YOd0IKBkCRvGtC+chI
	wDXFobSW9tJatVFJcI6445WHhgiCe4/duDVQZFAsJYi0I4Y65SM2GZDyaFGCjmk=
X-Google-Smtp-Source: AGHT+IGke0/qnL9Q3/h01ae4g52cRUA7SASLy2QLx9D9YMJ6mIYmlVGHFgKC3BITCmVT1KlLNqVLHw==
X-Received: by 2002:a05:6a00:2353:b0:714:43d2:920f with SMTP id d2e1a72fcca58-715dfcaf7b0mr2933631b3a.25.1724926763274;
        Thu, 29 Aug 2024 03:19:23 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:19:22 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:31 +0800
Subject: [PATCH 02/21] drm/msm/dsi: fix DSC width for the bonded DSI case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-2-bdb05b4b5a2e@linaro.org>
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
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=2920;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=rMW8hgzOVthU1PJqs91Rp1PmU+xpXc/U2BYdfZKLbeM=;
 b=BVhNj9KJ9uzLPwA91fAXENVPKzJaDPbKBTjgRRjyoZ1PwZV7o4Nf9bk80gC9rOKGmI3lNBimQ
 VB5Hqs9eJSfA7rHTx5AIfPuju1inhjMkcjiejmjJ2LebFMUN7JbYjGH
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

For the bonded DSI case, DSC pic_width and timing calculations should use
the width of a single panel instead of the total combined width.

Bonded DSI can be used to drive a single panel having two input
channels, or to drive two panels with a input channel on every panel that
behave like single panel for display controller.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi.h         | 3 ++-
 drivers/gpu/drm/msm/dsi/dsi_host.c    | 6 +++++-
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 87496db203d6c..35b90c462f637 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -79,7 +79,8 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host);
 int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 				  const struct drm_display_mode *mode);
 enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
-					    const struct drm_display_mode *mode);
+					    const struct drm_display_mode *mode,
+					    bool is_bonded_dsi);
 unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
 int msm_dsi_host_register(struct mipi_dsi_host *host);
 void msm_dsi_host_unregister(struct mipi_dsi_host *host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 6388bb12696ff..7a4d9c071be5a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2489,7 +2489,8 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 }
 
 enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
-					    const struct drm_display_mode *mode)
+					    const struct drm_display_mode *mode,
+					    bool is_bonded_dsi)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	struct drm_dsc_config *dsc = msm_host->dsc;
@@ -2499,6 +2500,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
 	if (!msm_host->dsc)
 		return MODE_OK;
 
+	if (is_bonded_dsi)
+		pic_width = mode->hdisplay / 2;
+
 	if (pic_width % dsc->slice_width) {
 		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
 		       pic_width, dsc->slice_width);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index a210b7c9e5ca2..6e915b57e14bb 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -420,7 +420,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
 			return MODE_ERROR;
 	}
 
-	return msm_dsi_host_check_dsc(host, mode);
+	return msm_dsi_host_check_dsc(host, mode, IS_BONDED_DSI());
 }
 
 static int dsi_mgr_bridge_attach(struct drm_bridge *bridge,

-- 
2.34.1


