Return-Path: <linux-kernel+bounces-186072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6DB8CBF90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4411028281E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361B8287E;
	Wed, 22 May 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjNkqHKI"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A682490
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375064; cv=none; b=jQjkez0sx1zHU8z54yfsgK50rMpPLq/0VBJbnpb6GPaY5VQ3sp0rnOYcOgA9NSIsORQP4+mIzuKnCUeczZrRlAdLqvXEdOzwv9lQSmIwcCPzooi6mN0v+D1l/Nyy3y27w6RKaY7X+Wb0s267tp/ZYVUDjPYFAqtzLdlB9aMUy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375064; c=relaxed/simple;
	bh=osqs9uVQGma2pB7Uqqmi191XkOj9NO2HEt9nbTjIsVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LI1NbhZg99HAZsjVNmu92OroWa7n4Zlvlz0gAOA2V8aEJnJnQate+OTDEmwzWHN8h/gLSIUv5aKGIU2DTrPqD0O7fL2lGrPxwdyp21EKjbzsEBwLipEqkDhlcAoROOT0E/6uKk6W6C9P16L4VwmDnHI/QhPEuYuGv2/tCBUbJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TjNkqHKI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5238b5c080cso7888080e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716375060; x=1716979860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dResiOVnD3KDBKBragxWJ8JzwAGCkXgZAm144m2F5c=;
        b=TjNkqHKIdYxxWe4LEmJ4nirZAc8wdlcMp/EIEPugcFw18uo8hykEaqzHc6Of5TEfeO
         79JcefWoluPbRVUbJOglmYTXbZHK273twte6kDaFWa9HVN7/w8YFlw+O+r1R7otjXaos
         W6RotYZJRxz4SxXrO/ZdkFSedhT24T+IdImGOmqCByJ1ssxBOeOomSlY8VFuEekLalP4
         FYsSXuYdU/Vowx2HZx1mCw13evMhQHSwpyHI013Ux1o0FJwuyRgEWs0SK0TiJ41pzVs/
         RvybGeFXC3xcjjbogfVQcPRL2FYfp3Djekbi8k+w/yVxfrO/LruqNkuUnNP17l7Bo7O0
         V2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375060; x=1716979860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dResiOVnD3KDBKBragxWJ8JzwAGCkXgZAm144m2F5c=;
        b=guhQQE4IlvHKNTz1saV4uPx2b6INhsfctDCl+tMeYLKx28LaIUtCrGWc4UZENHqFWO
         QCAgdRtPVPTNn0OME2keVgvrfXqgWQpusSf5E8UwIrQ8moo8LtkuwJ81NWtcJ5xY8ty/
         mpWOU6MxivTMzfDl5QN94Fo1ndcZ0W6CMxYT039lvpSpAgX0UfJnMS+a2+OVnKgRPcvU
         19E+iiqf0fGA/TDQ64XJ4ZxS2Enhv1swD9QF34PIsvoXvl5t+u2DUrD+YZyGIQC5nuHB
         Zr/Dj11Xkm4TfaADjgs0mB9ViPHnxniLpX4ooSXTUvHES3/D/aVo9O51w+c4h0ZOhNH2
         6igg==
X-Forwarded-Encrypted: i=1; AJvYcCWeXPEKA+/DQWJiY87dULYef7sZmaR41Lnfdkf4MgFgG7RYvRWiKhfWDKsehbZzcLKPtQ+OMw88/JxrIQmDphH1DhnxGQwW0UHQkmz3
X-Gm-Message-State: AOJu0YznGEVyB7H3CSbf+kFQ5c4HnSLGZnY1ena0h8TTGdRhmir3d/P3
	Zeoq2V5L/tdsi7sY9mfP+CFbPtOvh5k7VAxZUII7mWpfytDEfkDNi0DIo/+tn7Q=
X-Google-Smtp-Source: AGHT+IEOC9Mt121LUZMOGbgq/bBML1Pc3j8MLinnpLNjgkjcRolQAPuoJbIEqAzUiz7UiRJq4scneg==
X-Received: by 2002:a05:6512:1583:b0:51f:5d0a:d71a with SMTP id 2adb3069b0e04-526bd694ab4mr1047130e87.10.1716375060602;
        Wed, 22 May 2024 03:51:00 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52431778ec8sm1279126e87.194.2024.05.22.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:51:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 13:50:55 +0300
Subject: [PATCH v2 03/14] drm/msm/hdmi: switch to
 atomic_pre_enable/post_disable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fd-hdmi-hpd-v2-3-c30bdb7c5c7e@linaro.org>
References: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=osqs9uVQGma2pB7Uqqmi191XkOj9NO2HEt9nbTjIsVU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTc4PCjd2hgbwjgDirDxBNAxSDUfP1Beqm985y
 mK3+UPx39GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk3ODwAKCRCLPIo+Aiko
 1WPYB/9GLMl/u2GZ6jjdkuV0W4HL2lvbKpyLAgp7znyuLJlQUAPszh1vOixoX8xNGhFns22vham
 I4iJi+J8EkXyOxci+LIH4tRVsV/SxwHRSEW/e3Cw2bXrKQmcDYv7fd+0GHrCCLjcpCMyebaojiW
 zRBJyJl3CHbBr5p9gzsVLMJylnF0DZTA1ug30vaVjh9K08tofK+gyZ4Ispn4JPX3qyHCuXfciM2
 bPq0rZyOMrJ8bx5Jt46S0g3gIGzI3yhMeb83rVW7IeutOq0m1XsS63rQmH/ccGOypBcBVfxVRjx
 JO7Ny9cUSQ2fG1qG4VcrKyPdZonoRdiIM6VG2BeF/b+MX3uD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In preparation of reworking the HDMI mode setting, switch pre_enable and
post_disable callbacks to their atomic variants.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 9eb4d06bdc0e..3c6121c57b01 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -120,7 +120,8 @@ static void msm_hdmi_config_avi_infoframe(struct hdmi *hdmi)
 	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL1, val);
 }
 
-static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_bridge_state)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -146,7 +147,8 @@ static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
 		msm_hdmi_hdcp_on(hdmi->hdcp_ctrl);
 }
 
-static void msm_hdmi_bridge_post_disable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_bridge_state *old_bridge_state)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -292,8 +294,13 @@ static enum drm_mode_status msm_hdmi_bridge_mode_valid(struct drm_bridge *bridge
 }
 
 static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
-	.pre_enable = msm_hdmi_bridge_pre_enable,
-	.post_disable = msm_hdmi_bridge_post_disable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+
+	.atomic_pre_enable = msm_hdmi_bridge_atomic_pre_enable,
+	.atomic_post_disable = msm_hdmi_bridge_atomic_post_disable,
+
 	.mode_set = msm_hdmi_bridge_mode_set,
 	.mode_valid = msm_hdmi_bridge_mode_valid,
 	.edid_read = msm_hdmi_bridge_edid_read,

-- 
2.39.2


