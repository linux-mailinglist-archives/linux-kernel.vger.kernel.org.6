Return-Path: <linux-kernel+bounces-273052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5954946410
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C351F229CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4797A13A;
	Fri,  2 Aug 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD0J1vhX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2054724
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628063; cv=none; b=POsj6/s6S0hyObACVT31sjHpTyqJnUtWK6cWLsB5dMun10hflPoAPUb5M/eJnDMkrquA8DgaelGwtSYs1Ct9IQMtVJxMqNbZDi0fCILAEsQO9Neehi3LFlDiZJZWpx2IMvab0hY9WDUvNqXFZ+pTsw6ng/bVNOVl0RvWFlVjlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628063; c=relaxed/simple;
	bh=2b3yRHs49eX/1vL+P+Me3WH5qiaxmmgj2T78MMKIwZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Std8HhbzF3tkVIMPAfsTGiYD7c56dj8Vx/iHCdoqt+Jh531DtSg3sNPdXyYuCxYLEH47h7djEof4v8R7Is3jmdFHIE/VUBXxq7wnjvq5UsnbYVERYcYHToPH1/plnoyIzYktxM3yQoMKufWX0ujBjNl7xO+iP/0Ry5E1UWd0A8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hD0J1vhX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso104985761fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722628060; x=1723232860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0kj6XTh90iEEbA0uytJvfTg6LVq22XyHCEfhbdwFAc=;
        b=hD0J1vhXM0azhkqLd14g7Bp41kDqZ5PkODfwQNZ3raO1yL7bOscgJdbzfctshB+9b1
         8XglGCNFyeBW56pmLUJD40g6GIjsNdmBaUOJ4MoMLCFilYK6h/Bagn++fDP62t54+Cx0
         Td+5dlcwABSlg5CMzqbhi/Sppa/gPmt0NrnlTfv+lT8czFJ5BQHkvknT6voG+csFD0iJ
         gK+x1U9GIOg1ahqgcrGC3M/Udj0c/9fDODvi6nQprvx8GympNMvOahpL1qLTTiTuGTK2
         qYk/qnGfZSO6EglmJjZmq8X6dXW9P9HrurmuhY9M7jJWAIwXxt5gK4s2WQK6d3cuq8rk
         M97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628060; x=1723232860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0kj6XTh90iEEbA0uytJvfTg6LVq22XyHCEfhbdwFAc=;
        b=rfm4gOPQZF8TQ6Tu+agVQcDtZPOXMazwnPTmKjP+GftkfcNceOczmZgW7BSc8RtaDs
         Jmvc1UN7mhueQ2hb4q+X8r4BclkkRLBpu8pO/x+N66fCjBt+EJx1mjilIitQbZo4QphX
         knuusjaqd/hNoesqLeMq6//aHuET5iEyb+Ys2kMe7esANzLIChcsTOTfMS+/0ycJ/uFd
         nznB6M5PYf+pCnuOQO3xPZU1AttoIQUuGl8GujyV/gtDV53pMmxwXON7nTWHrcLX+4wQ
         at3kBELZDjlgz+QXvdt73x7a/UExJz3d92jorixAVzcds2rtTVJwfxiezKYkB0fwxYth
         AH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyxvIABbt8swaRAdhBoOsS3cqjjQmP7YTpBVhzwVNHoQULjactpcae1kd6EbTuuPjczKTmayo1FGynfwVNpucz/zBOQaC63RakHwgZ
X-Gm-Message-State: AOJu0YxGnHWCIRlnDcVf2XHc4QhHlBpf/7Vthgdxshk6U9evAsaqogkV
	43qlEnt+D9QJtul9LseT5XCUUvSXGwfTi4Pi0jurRTOnDVa4OIEIfPdTQCdrIiY=
X-Google-Smtp-Source: AGHT+IHC5pWQV5sUThqfkpYlt5hVUslppx0/7sOiLjAwX+Cah1N052U8+NZUkk4YN5HoI/4FIhX3ng==
X-Received: by 2002:a2e:9107:0:b0:2ec:57c7:c737 with SMTP id 38308e7fff4ca-2f15ab24bd2mr32139401fa.40.1722628059116;
        Fri, 02 Aug 2024 12:47:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b2b556sm1440939a12.25.2024.08.02.12.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:47:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 02 Aug 2024 22:47:34 +0300
Subject: [PATCH v2 2/2] drm/msm/dpu: don't play tricks with debug macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dpu-fix-wb-v2-2-7eac9eb8e895@linaro.org>
References: <20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org>
In-Reply-To: <20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=2b3yRHs49eX/1vL+P+Me3WH5qiaxmmgj2T78MMKIwZg=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9pa8+s35u2WXFa2pm5rf9vtTZ2JXnH3Zy+0C47kqbxTW
 LSb8ezaTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMRHYRB0NfxVePmPnNa0+1
 pehX92+faVPQribE+KP6RvQjy4ju/SmFXzdu1/T/s5B1Lsc9LpW3gu/iU77+vmUcH361pKREo88
 wNYG9bO33qi/nvDaY7VjK/jTe4d8jh9KUpIyw5Ox4IT8L81WOu7bVbXLZPo2Nxa70YwlT+eWHHQ
 18fa0tcpf4r+ZxR27ZFra8VDVBPuLqsT79cqcvj3Rd64IN/2lvduL+uLko4CPfndhbdelp76ydl
 6p9feAn+UB//6r5Rv2LBYQyPR2kEuu/qDF5TlLt7Zv1IWRig0rH52DrLgV7W+mmpAPdE6dv/TE1
 Lsfw21SrafPiPm/cfdNlpWPndZm5loayJ7MTvpvWKEUDAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

DPU debugging macros need to be converted to a proper drm_debug_*
macros, however this is a going an intrusive patch, not suitable for a
fix. Wire DPU_DEBUG and DPU_DEBUG_DRIVER to always use DRM_DEBUG_DRIVER
to make sure that DPU debugging messages always end up in the drm debug
messages and are controlled via the usual drm.debug mask.

I don't think that it is a good idea for a generic DPU_DEBUG macro to be
tied to DRM_UT_KMS. It is used to report a debug message from driver, so by
default it should go to the DRM_UT_DRIVER channel. While refactoring
debug macros later on we might end up with particular messages going to
ATOMIC or KMS, but DRIVER should be the default.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index e2adc937ea63..935ff6fd172c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -31,24 +31,14 @@
  * @fmt: Pointer to format string
  */
 #define DPU_DEBUG(fmt, ...)                                                \
-	do {                                                               \
-		if (drm_debug_enabled(DRM_UT_KMS))                         \
-			DRM_DEBUG(fmt, ##__VA_ARGS__); \
-		else                                                       \
-			pr_debug(fmt, ##__VA_ARGS__);                      \
-	} while (0)
+	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
 /**
  * DPU_DEBUG_DRIVER - macro for hardware driver logging
  * @fmt: Pointer to format string
  */
 #define DPU_DEBUG_DRIVER(fmt, ...)                                         \
-	do {                                                               \
-		if (drm_debug_enabled(DRM_UT_DRIVER))                      \
-			DRM_ERROR(fmt, ##__VA_ARGS__); \
-		else                                                       \
-			pr_debug(fmt, ##__VA_ARGS__);                      \
-	} while (0)
+	DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
 #define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)

-- 
2.39.2


