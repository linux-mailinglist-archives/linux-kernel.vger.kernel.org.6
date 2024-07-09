Return-Path: <linux-kernel+bounces-245952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8B92BBC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8943B1C21F0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49618629A;
	Tue,  9 Jul 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUJ3vxGF"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD151802A3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532919; cv=none; b=AfAAgT1cZSSEh7ioPfao4yg+Y6VbOzXVwfFCSDc4UmIu68UoWLr3YdNEUVfiS0P+klqHNpga4c4Dujqs2rub5wiJzzRH5oalC3JnNGdvhVaDF+liNAbfQPf5O5HRwdqZ6CG2ERjbtJQ+UbS5jAWna/vpgIYMX0PW/uOf8RmZEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532919; c=relaxed/simple;
	bh=5MmuIH9/ptcSX8goq+NiIFoXU3SW2qDd+IHPfO869oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phhJi4LFnlPcQ9BUdnZ2vbjPYt8NbPurosaxST0P7cazprQoF5nS+8cDVNhMuHbpLgUdKF9jkrPFX1ZtlCkMEeeovXrTl3/bvh7bc3m11kVZ1ArQYLuucu0AziS2bqPS2PS+DtRMKRe32+upIF5DBU3rNULvOCA4TmM2oFtEtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUJ3vxGF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso4924788e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720532909; x=1721137709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVsuhaP11rLzifuOYfoCT/JsmgFit3NDN+KhNk6m6Fg=;
        b=tUJ3vxGF8nqPp/D6WnGgxgUEuPqBcGajpXV14TNFcT4Mh1+JZKEgTISIBeKGxY86Iv
         pj2ns1uVG3xe/BKmQw0Njvt8+Qp/Nq+hcBY0xrTIxd0GqelgX3X/S7UMcBnWhyTk0nv0
         vjNYxdmUgfc5LAz15N0qbxguMcQwIod8xNIKk+RIqefobvfTXPCO10rYtDaLPuZqNkhd
         OvBk97ZW8VwGF6ivLIoIJ7fAR9uny5oqr1HS2yoaUXf7jldAXvNmpjAo7mrbfF/No1TV
         e+9JeB1C1unMW5Uq1RMp4QmvG/pq8rD+QRSFPmVFxZokI2Atd1mU2B3ncQFunO4yGe4g
         dcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532909; x=1721137709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVsuhaP11rLzifuOYfoCT/JsmgFit3NDN+KhNk6m6Fg=;
        b=CPF5J1qtOW7E+PaSCPo/y04MFCNbTuCtZR6mmrJXbr9jfL/e5wqafqqg4R3fjvJwRw
         gbSLOCj4SnMJdsGAtgR7iZIE3T0p+ONISwNndqnhdOwbzdASHVNlztvuLLnyHTfdggKq
         q5b1gwzWvb3M6t2lg+6qcIy5HJ9gC0aQpqZwbUKdBePW26PaGLwII8k3O6p9cXMn8UvA
         dkNht0fyaR8L62wLY81FurwEK4/RxSDaQ0DH2zgAU4dQ1nP66B548FI8USO9suJZ/SUk
         E18zRwd+NV70zQm7Hrn98BEYbCcMZUMir6ipjcCN2aKOjkxGRL8uqdZxY+uO8MQNf9vL
         JQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5WXkG2Xp6SSrIB3l6p7sieNSO9kM8XvKUoaFtzIJW7wKAnrN3Lqvra0yUspqCfz0d1j6wx3oLd62E1QgZGHuOl2+8E4UY7NElnzsB
X-Gm-Message-State: AOJu0YzzDmoJYOTWmCJCr1MH+p3TzRwHIKA/3UQF5NTzht5d/Mwadgjg
	1IWAxg2KS35y7XSJtUfoC/QulaqtKynOH4fDDMVL4TH4C+8uwuXBsy5nLaw8Ng0=
X-Google-Smtp-Source: AGHT+IEaDUQIyebHpQsxc8nw3fDHAFZgaEz1nXPH9SPNxdY+OR16Je0rKup8mDiVn9/F2IwT3VnrBg==
X-Received: by 2002:a05:6512:752:b0:52e:95dd:a8ed with SMTP id 2adb3069b0e04-52eb99a199fmr1263558e87.35.1720532909315;
        Tue, 09 Jul 2024 06:48:29 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e4959csm250297e87.82.2024.07.09.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 09 Jul 2024 16:48:23 +0300
Subject: [PATCH 2/2] drm/msm/dpu: don't play tricks with debug macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-dpu-fix-wb-v1-2-448348bfd4cb@linaro.org>
References: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
In-Reply-To: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jordan Crouse <jordan@cosmicpenguin.net>, 
 Chandan Uddaraju <chandanu@codeaurora.org>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
 Archit Taneja <architt@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5MmuIH9/ptcSX8goq+NiIFoXU3SW2qDd+IHPfO869oE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1qv/Qof//Jj7Pw+y0yYutVkmev9z8YY/z7xmP0Fk3LWV
 ffpgZ6djMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZjI+V3s/wzDDrWdCnywurzf
 +9I25rTUQxqHj591S21Ikv/lmOR4tLmB85VMXOFJHeea6mWCTKmbunc7rTqW6HTPcNcfqefx/1w
 sPsV0ZNm/ce7XP3MriNPsowT7rrr49z6Mkzp4Xmu84t04572XTU7tgdb3rxY2Hltx+66hzoxLzS
 1PJpcci9xg0b7YN6MoZveaKX4eR3d+ddk8e7vG5ucL590X3HFkfXShVu5RSQ8P4SzzAJbg7T3sA
 ho8zOv5XpY9qwtaOddC8yBXaCh/Cscp3shKzbLAxc4zw+Rc1wgnca3mT2iIT1pdL6ni7nO7Zcv3
 F+qfI5lus5j7xG5a8PuYtMEZ7rO207veRnHd+Pth3SdNAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

DPU debugging macros need to be converted to a proper drm_debug_*
macros, however this is a going an intrusive patch, not suitable for a
fix. Wire DPU_DEBUG and DPU_DEBUG_DRIVER to always use DRM_DEBUG_DRIVER
to make sure that DPU debugging messages always end up in the drm debug
messages and are controlled via the usual drm.debug mask.

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


