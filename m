Return-Path: <linux-kernel+bounces-306640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD2B96419A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689D8B270F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EE71AE87F;
	Thu, 29 Aug 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiQT5AEr"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC11AED21
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926809; cv=none; b=axDvqWbp5rvoW9ah4/rF5AetM74DIumxaYgMDPmMGb4usIFv2mkTHYVZS1dmtBGtmOQEqN5gDhP2yCEiIlocJff3zYLuQSotyuS0z3VowQ5EM5FY/bzcUSttmGBzaav3v36TKcgY62ujJ56ea3re/va7wh2zryzr+3Wf9Q83LGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926809; c=relaxed/simple;
	bh=0yy1liVIVVcBNaGfsGh4eMYqZcgCYhVFKjgWT8Yk1d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pf3NLp7odcUf1j+FaPRKWzQ1ADbWNOeRlDj4JKEKRNpPkoihMqVFWS0fCli9dJwRG8a5U0H1LkGe6eXFuhJF1oAzfxsOaoTnFk/NShKt4ClUxkVhu5U8AKzn9yUp9Utlay+RXHAoq85eAHRuYP+/gjn1kADBjLuOCX3/rVI0BJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiQT5AEr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7bcf8077742so324176a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926807; x=1725531607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCM9+J5N4G47yHA+9svPJMNmtm7ygy8LRAS3AKbj6g8=;
        b=XiQT5AErWp1qebMKIwonixvM9IJKNqtgBLLTzirGDVxBVmff9Ic+LCkJQWbD5u0dmq
         g2fdkWbueEbouvE9YeVhg1fv+ut2KU1TJWG7nkrZoYGXdVOg3ho59YmhIXRrJ9bA3dv3
         +KzPhaLxLULKeF7n6R4XYPJoqw2dci1n6w5uQkgG/tM4NzLekaNz6MfIEDR1YjXv7/ck
         sV0PJ3MT1MVHLDyISI4yAVQzFW8PqzIEhTdMPvh9F2g7EnMqCkncOsnzY2ioPsYr/Rje
         Vgc4mbQm+qsB7Xja+XxyBYkNzC47P3h/jsyQhR01mjBdaXqYRoCsIYjbhVa2col1ftNc
         AYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926807; x=1725531607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCM9+J5N4G47yHA+9svPJMNmtm7ygy8LRAS3AKbj6g8=;
        b=smeT47NdSdQ+619+qqhFhXKtlETibEpJgmzH0IGmeclTb835idlFcEu8rVTJJKSzHs
         1tlTaS30bHjxpuPK+dP5vIli3s4VwJuqXs4LPRqzAxxwTfL8p/6jsIqT6dTo8RbMwxQB
         e0YrYhIuwl7GNRW66OqkAwyh9Hix2hGBmanY+mCpnqz/mlXefwMgfO+OMAbMpMw0oHc6
         Wpf/KIkeTyJ6Rm/hySQMp5rsD9QXYDZoSjOf2lvCRen765Pli1M0pD47GQO3LYBpb0N4
         qvtlkdz6f4G2i5IXl0zghvmvJ6Q9tVndYSTCWfffhvbJlTzQKchfuaNkpma8tGmy9te2
         JdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB7XFlaWTQ2haPsPiRm83VSO5QnIuPoEnMOENNoEdzjNHM2NY2k/5uUpaBqmVll75w6kaI7UJM+71J6MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8k7WX/vDJ/MPNvLn/IcEF4A4HEfS5rOpJ44hUyd8ZEtdfl3cP
	2ZnZjZeU/nZxV5i5VR4BfWEYBt7npJgT/JZgUASJOUDWRurNR3dJamqn4ZQIGQ4=
X-Google-Smtp-Source: AGHT+IFo6JqACOpnth0fo0ebIHz2s0TbrVB7OHz+muTbyPW6Oj8OzQXal3TuFyZ8y86blnUcHVs4ag==
X-Received: by 2002:a05:6a20:43a0:b0:1c6:ed5e:24f with SMTP id adf61e73a8af0-1cce1021453mr2687410637.23.1724926807471;
        Thu, 29 Aug 2024 03:20:07 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:06 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:36 +0800
Subject: [PATCH 07/21] drm/msm/dpu: Support dynamic DSC number
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-7-bdb05b4b5a2e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=921;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=0yy1liVIVVcBNaGfsGh4eMYqZcgCYhVFKjgWT8Yk1d0=;
 b=PwOW3rRew35aIX4xRyng/9JjRkID8/gLpZS+9EYNgSES93anR/gwegVFnq/E8Gu6stEEFpRH/
 CqB8AK/26+2AOcc8A0fnpWAoCQs3VSmafagyoRBeq9Xe8yckQ/TJZpN
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Do not assume DSC number as 2. Because there are 4 DSC in
quad pipe case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 6bdd9c21ff3ed..05b203be2a9bc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -553,9 +553,9 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
 		if (dpu_enc->phys_encs[i])
 			intf_count++;
 
-	/* See dpu_encoder_get_topology, we only support 2:2:1 topology */
+	/* DSC and mixer are mapped 1:1, so reuse the mixer number */
 	if (dpu_enc->dsc)
-		num_dsc = 2;
+		num_dsc = dpu_crtc_get_lm_num(drm_enc->crtc->state);
 
 	return (num_dsc > 0) && (num_dsc > intf_count);
 }

-- 
2.34.1


