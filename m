Return-Path: <linux-kernel+bounces-316266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC796CD3C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8631C21BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F804152166;
	Thu,  5 Sep 2024 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzDtOzUd"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D914830A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506782; cv=none; b=e+MpIDJkO9uZK0LxjVJrikILYxR5CdMUNKfQTRiFsbC6JC1Up60QR/CQxZ0GZFBcDuQ5KjCfTqkoFDK8BbWTkfI0X+HAGJLtuxvTjYthBR8c/ttFXiehbOpOu9nlhXgRA50o5DWAXfB76cwwNA1QMh7grVMEZVY8tZ75s6IvYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506782; c=relaxed/simple;
	bh=KnnNbGZkukvbhdJ4+vjUC7nnvFSR94+qavRX0iu+euY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaF+sSwX7em2kJ2Qz1d1IS0Czf74CoBIlEabx0mrHWoBBWn5xH/3TtpriZ0w0Q5WJvPwqqJq6qo8ftS0w3W+H7QFGx0yKOB4RzybhjuDlOfCwszpktkbzQb2rpPWOYRvMvPfVPCRoGw0TbHwr4THrvY8/8k4Zt8F21gHQlT8H64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzDtOzUd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53568ffc525so276061e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725506778; x=1726111578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMVe3dV+riSJbx0XmpXNkjqyIshg14e/HbhXiq4bN9I=;
        b=jzDtOzUdUP6t7++D08ksVaTQYh5hMe1x5ijVzz3/cwNWAmoRbxkClSvjhRQ0dbMUBd
         L9A1CM2EJZMFc5pqVbDaCIUYKMHKPLBfsAPlJz91I9E7rY4CkHSvD8H9RM0Plt/I/2R+
         rAVK5wkASGDICo+ZoMp8lSNvRE8Dm+WIag4fBohnvd53TAkV1RYOHCAVsl6dD9avDig3
         T3t5d9JwXzzWnnOXe+TtRTb8pdY38+wz+sGLKo0JTbQ+l1fqNV7QY9DuSWuaSwUgHYli
         LnG99mveuj1M+WkDj1m5SUTEsafWmyMHCW9xKfuuQ27osQtTQXkV8VOpP8eyH2LQGPQU
         NwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506778; x=1726111578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMVe3dV+riSJbx0XmpXNkjqyIshg14e/HbhXiq4bN9I=;
        b=Q1v/Ga8aDapQDmes1ep8tyXBF8BlwNrD0rqxNGwLs1cPdrM5uyKulx2cuCggSEnU7r
         od65nwPFJAOim5zv6uIy43/799JjstYr4vmLlqWijfJvKg3nuDMjb8CTYhIH45z6FZ3a
         x4s+aak+HAu7OOeUTNywiE5AbWfsgiKcNyTS5HjZhLNxd1HGGIlqQrsI9AeSRv4b5WH0
         gAQCh+Ls/vynKJFmsLfDaZNsLkSwWsiWwlzmf2XaaBzdCgA6wfu+sPf2ILX60v+U5yNg
         pJjrlw7Jp0v4/7CbEQEgxf5WkPTHABln3p6vEHDGCGFLpcUqz0+8ZPGblRyXskvjb73p
         2d2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpypt4ouIb4xTbyAFVpSqC0P0TJ+dpS1bbn0g8W+tqDFZVycDQfKz/U3iQOIlBsTMUCYmHRysNERim9M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtdsv6TWeT91SRcr6dCW05QVX5qGMJxkd2voekuVRAgMA61D7
	igp3aHSqYF5XwdQ81aGqGVdA2FTHklhn1m34YEXIOo0uPH29zXuLmgIhFl0sWOI=
X-Google-Smtp-Source: AGHT+IE+acS5vwCPZFfqy48BFrmCtYX0ql9IXQeheRpZrwQ/SpmPQiQYu7G/Vy0git+9k2kOjN0YnA==
X-Received: by 2002:a05:6512:3d24:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-53546bb4d0fmr14476272e87.49.1725506778081;
        Wed, 04 Sep 2024 20:26:18 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841a3csm2533860e87.226.2024.09.04.20.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:26:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 05 Sep 2024 06:26:15 +0300
Subject: [PATCH 3/3] drm/msm/dpu: drop LM_3 / LM_4 on MSM8998
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-dpu-fix-sdm845-catalog-v1-3-3363d03998bd@linaro.org>
References: <20240905-dpu-fix-sdm845-catalog-v1-0-3363d03998bd@linaro.org>
In-Reply-To: <20240905-dpu-fix-sdm845-catalog-v1-0-3363d03998bd@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Archit Taneja <architt@codeaurora.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, 
 Chandan Uddaraju <chandanu@codeaurora.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=KnnNbGZkukvbhdJ4+vjUC7nnvFSR94+qavRX0iu+euY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm2STWnttq8+i1NuRxG0sRjN+Pu4vbmRCduSOT5
 PdTVOSI9cuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtkk1gAKCRCLPIo+Aiko
 1Y0ACACbYLNDW/4i+2oZ6R8wbt8nuCMVXDGVTRy41HFmR9wJLSiqYXZdU88wXVZUoVToIy3ZnzQ
 MB2/Y7veEbRQQm+4ZuOLZh/+kALsNMc/GGZPH/pkBJAXCp5isa87fYxWtg35rn7kjsni0F1DSol
 OO+Xs35CudYnkNtVxbxez+/Dw3OIba3jpCNngWHkE9ADO3lZBE+nOTE1xoVZfc4TAHmhZrJyeTv
 ntEcJmCYKGwKlgwFGXe/4aBNf9ZlvjvLz+XcBzEOfiMF6lhCqVjk68btl48xGZp/S/MTs1uJFW1
 E4ma7P6ds374GzuyyttRXUcK2LCw+3cSZOP1b2vakxWtDkSL
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the MSM8998 platform ther are no LM_3 and LM_4 blocks. Drop them from
the MSM8998 catalog.

Fixes: 94391a14fc27 ("drm/msm/dpu1: Add MSM8998 to hw catalog")
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index 1d3e9666c741..64c94e919a69 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -156,18 +156,6 @@ static const struct dpu_lm_cfg msm8998_lm[] = {
 		.sblk = &msm8998_lm_sblk,
 		.lm_pair = LM_5,
 		.pingpong = PINGPONG_2,
-	}, {
-		.name = "lm_3", .id = LM_3,
-		.base = 0x47000, .len = 0x320,
-		.features = MIXER_MSM8998_MASK,
-		.sblk = &msm8998_lm_sblk,
-		.pingpong = PINGPONG_NONE,
-	}, {
-		.name = "lm_4", .id = LM_4,
-		.base = 0x48000, .len = 0x320,
-		.features = MIXER_MSM8998_MASK,
-		.sblk = &msm8998_lm_sblk,
-		.pingpong = PINGPONG_NONE,
 	}, {
 		.name = "lm_5", .id = LM_5,
 		.base = 0x49000, .len = 0x320,

-- 
2.39.2


