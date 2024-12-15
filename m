Return-Path: <linux-kernel+bounces-446605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EEB9F26D1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F17A1364
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408C1CEAC7;
	Sun, 15 Dec 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nc3SbXbf"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9CB1CEAC9
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302671; cv=none; b=cH1udzKDlpcVlrC1ZdUtZvz0dK08uEuiVsY0jdUWPlEBcYtcfbRsYfBX5nPBZnGiOqa1JTyZ3Trd6q7TzClRhzECVRZ62zwzs+xntCYGjQ7xAd8azyB1pi7st7n3NeuIbgb5zt9cE89z7lUFPcrl2Df+0/3iqDdPdNlbY5XfY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302671; c=relaxed/simple;
	bh=y//bbM3DWYF3HEdpfuzV0aVuaH3FmLoVHehWOxlGh/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QdQJUkbXGWHoU0qK6ippl9Wdk0XUZYkY6hQfbvQ9U0LEUEw32C4+lqEbkg0Mm1tNKly2/8ZdEAluZg71vTbSks6+s0aNP4LN75NI7Lg0VS6WGAT3J+IXwoJdmq3gkyvn0uqi8BlGGszxH5O2HRtn/M2ETIW/mqVnSV3+YfXXS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nc3SbXbf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3035046d4bfso6752111fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734302665; x=1734907465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3aML7gxQK4Qe9FGAs5JaPzifxEP7lddSGDpHtcNIOE=;
        b=Nc3SbXbfClRE7Ijhkd89WJXK3pFbqKnhQZgc/KGwb7SzXG6i3rJYwGw1W9Pu1CynI7
         v7hGbaEY8gAhDgUi55vK15pUaxTiVe7dNR0EEGguAZyMNDRdp0QV4ZiCmJQput+9Mpqi
         OVX/6JGxXFyRH6vha9oeCbHGCXZZfIA2ufZs4rRkWKIfdpEEVKaSuh/J40nU7YdClOPP
         Frk7oBpGQY7lO0+DuP5BHDCdbewUnq9AeokYfmL8SZWX8w4vOCNTMI2WJPKoacYte3bl
         nPXtaTnrJx2BjzGZOXzoftnUDdKoBqaYaYWi3TIujhweRQ/ao3cZxoErcPHktJK+4eCb
         sb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302665; x=1734907465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3aML7gxQK4Qe9FGAs5JaPzifxEP7lddSGDpHtcNIOE=;
        b=nsMPYh4Z8WFDfJy4oBG3Nci4Y9ErYK7ua1VFfUWlJ6kOv/1KA1TMifWy1wWRCRj/sk
         KuAXM+wY+1xTbFBUgxyzE6EmjAgHKRrSGJEFwzhjcvp8YJAx/UO93ABos8RH/yXB1vGJ
         g1u6Q31Q2K8UpymIlsS7yj8QmXnhRvqTZ73B5qmTqRhrWLX81Xt/yhrkZRXuMpX0vmwc
         mofTEeLx8m+SUnJkhPP+NsvxiloH00JuH7bafIc1iUcmKpJ7p0QgGoKhqS6iUg+MgBSt
         w6bCcBH/Zch+nlxfwz3YOIki6OZT7dWrNNje7VAuXa1+EVNfIq50AxETX8GJJi+XFxT+
         TLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfk1aNK13tG+ewM/ZRfep2H5JQb2kH5tWLSSOuUV9NGBBQsNyzVHCKF3DxQl5MWCJN4KvezU8mePWsrNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZqvLkgxjjIxBbQIS0YOlvh2owJxyR5xmLS+skIKlXjPyvhE7
	O7qD689+nyYK9wXQrARWbQRCdyHhX4gCCogE7sgjRlA1tkOsnbP03ude7DNPJy8=
X-Gm-Gg: ASbGncthOdqUzbZfTdKXPwfXghVGFafAYVHDnXcBj4fM9rYbfNLCKAQuPUTCRyDAxof
	tY9iUHbc9ktqYgtH+7z9dE4OFw5y+bXu1rGAhZkgobwgcoQy0Wavtg9MdllOomUNrGuo/SY3HiZ
	0kyRNpmTiihf3/yH29Pc40uKMpkq9wC/fIfCSFirWIScbSIh4UEVn7sHL9yWWK8ZzBTve+Wk6Qy
	KgcvLWp9o8Tc1xaiyMqldVCYss3Njjzu1NMjxYuGgC0oVGitatpUt+qVupU/9zZ
X-Google-Smtp-Source: AGHT+IHgYBQaQkAuEBIaZvjJII0xL145HHOwqROw1fcPzfz0MJlC5cSUx988XIfEN/8HldbDDvn61g==
X-Received: by 2002:a2e:a994:0:b0:300:2524:84f2 with SMTP id 38308e7fff4ca-30254444a38mr36489511fa.2.1734302665117;
        Sun, 15 Dec 2024 14:44:25 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a41d1sm7201701fa.100.2024.12.15.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 00:44:10 +0200
Subject: [PATCH v4 05/16] drm/msm/dp: stop passing panel to
 msm_dp_audio_get()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fd-dp-audio-fixup-v4-5-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2659;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=y//bbM3DWYF3HEdpfuzV0aVuaH3FmLoVHehWOxlGh/4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX1u5kb1ZbcWlfFkv2I2FNncdtStLPvZRzeZjR
 7RfWc9OeMGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ19buQAKCRCLPIo+Aiko
 1WrjCACQCw3XmlmJHS23smdMsgQID06rTdcFDYjo83IbnI92bERW3cq/yFiAwL7CVi9r9NiKhmU
 Cf4TQstar+Sj7PjNZ22jmKF7o2tZXN2N97ssGkzA/pK9i0PhHgY3zCXGUM+ciEUS3iq5ZQI2I73
 3M5U5PSShg0YSv71XpT6csm6UCXmYgIO7LoUQLYiDtrZExSEgnCXS25bQ/BJgLOSnwvBwQGOYyi
 y8zV55Ofp1TADHr4HBdw/muO6KBejAnuFbbZKq1XJXSU03dOSS9uf/NBnURt0Wd/lpxit59ZSWf
 Ydiq3bEssfRJaeVsFBkwJa9aaRBrCMg9kH04+bLvEupZ7iUV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The dp_audio module doesn't make any use of the passed DP panel
instance. Drop the argument.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   | 3 +--
 drivers/gpu/drm/msm/dp/dp_audio.h   | 3 ---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 9e402d71b9761f640f1a8733e10e09477ff675cb..a4b792624ccc444f8912eb967d722cb94f6d4087 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -351,14 +351,13 @@ int msm_dp_register_audio_driver(struct device *dev,
 }
 
 struct msm_dp_audio *msm_dp_audio_get(struct platform_device *pdev,
-			struct msm_dp_panel *panel,
 			struct msm_dp_catalog *catalog)
 {
 	int rc = 0;
 	struct msm_dp_audio_private *audio;
 	struct msm_dp_audio *msm_dp_audio;
 
-	if (!pdev || !panel || !catalog) {
+	if (!pdev || !catalog) {
 		DRM_ERROR("invalid input\n");
 		rc = -EINVAL;
 		goto error;
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.h b/drivers/gpu/drm/msm/dp/dp_audio.h
index 1c9efaaa40e5879e54c1ed4a3d04a39a85c9402f..beea34cbab77f31b33873297dc454a9cee446240 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.h
+++ b/drivers/gpu/drm/msm/dp/dp_audio.h
@@ -8,7 +8,6 @@
 
 #include <linux/platform_device.h>
 
-#include "dp_panel.h"
 #include "dp_catalog.h"
 #include <sound/hdmi-codec.h>
 
@@ -28,14 +27,12 @@ struct msm_dp_audio {
  * Creates and instance of dp audio.
  *
  * @pdev: caller's platform device instance.
- * @panel: an instance of msm_dp_panel module.
  * @catalog: an instance of msm_dp_catalog module.
  *
  * Returns the error code in case of failure, otherwize
  * an instance of newly created msm_dp_module.
  */
 struct msm_dp_audio *msm_dp_audio_get(struct platform_device *pdev,
-			struct msm_dp_panel *panel,
 			struct msm_dp_catalog *catalog);
 
 /**
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8d428bc633a9f2165651194797b027dbe8655e06..24dd37f1682bf5016bb0efbeb44489061deff060 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -780,7 +780,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		goto error_ctrl;
 	}
 
-	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->panel, dp->catalog);
+	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->catalog);
 	if (IS_ERR(dp->audio)) {
 		rc = PTR_ERR(dp->audio);
 		pr_err("failed to initialize audio, rc = %d\n", rc);

-- 
2.39.5


