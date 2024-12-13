Return-Path: <linux-kernel+bounces-445647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774BD9F18E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C5C7A12F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F4195B1A;
	Fri, 13 Dec 2024 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VaFnYVZf"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BE1F757D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128146; cv=none; b=U6XG49/DdO0picySKfEFA77TefyJLpzF3/iLL+2+pynyf6uY4zga+IZ0FeeHmhrdnyEz7Q3ysPwG0xHzb+abul3s2kwO2h+4/GkGCS9yyQ5WY5nISjyVbPC0991whs5TkqsYO05GdD000djDJvbJZ0AG+nKlMigxi1CoeGNen4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128146; c=relaxed/simple;
	bh=tPpDxtHO5xmaStginATMqoo8E/aoUokLFeBXLrsaQRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mg9PxWZQFOq80LERllfGcTvnoa0rssJpq6hetz8frUhaX0+TtZ7KDFdZL7nWLMdVl7euwktNrtqFYc6t/S3SIhBR1HcUssQIixEJGtXJaDDpFdljWl0oBDcLNwh4Lyt7bA9L+qwLkugJ/HTBVS5OKQbNnRN22+BNPIGre/tuXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VaFnYVZf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3003943288bso19827781fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128143; x=1734732943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRIxn4/iOOppm9kbxU+lpuaS0hiTeQ2NsHK0Y4FVJCw=;
        b=VaFnYVZfWGvRsv/1iCUuLV7TcGB2f6CpLyxVWpNcICCvBMB1wMx9DE6q9LiJA+TZht
         l9a8ob5U+V+aRZOJqC5ezUaHIw/3V1dSC2Pbq7BJXAGQpFd3u7Q7epi475xfu6/iZ1jE
         JO88tu33cBmZZt5szZIdZxq6M8uuw5Bpvs3pxFDSXNwi04GO/NPaLBGr3OKs0jEEyYdR
         q2VHMwUWzjClgoMa//dhyevDzG/rF97T6qsl1Ts7PBZVD6/VHLdILa0baGRvYmOUYfRQ
         /pFyIg5Q913m8vQLsV7CB//aNzMMOQ3paRoq4ThUCz9Pww7M/J8RY16VF4DTiRQYr29/
         YJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128143; x=1734732943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRIxn4/iOOppm9kbxU+lpuaS0hiTeQ2NsHK0Y4FVJCw=;
        b=dmlT6Dv17b8RGzKo/oyoWb7MdVC3jZkH5ziXieyLP0haS9aPwyIjc5/OHcA+7UTlNA
         1og6xAFHGpKxOYbxUxaywevcHCzeVu7LmpbbYH4NbuYOw1/akXq+InEjohy+q8O8clvR
         cQa0Q6+tkXw7hkY4JPR3lWBxQ8H48goOITnx1X/xfiwhih9TRt9xcHpaxMYCSsESuuNq
         b3yedjU9i8L7LLyRFruCcy3gQwqcbtAnuH0Q8P4IxUXAYv2Ye05Kbus69FfqKIBWcTJP
         14SMVUIoaIWExyBz8ft3R2cQZ9Su83oTzfu+QjM+k5lzHXW5o6xwOC4eha9B12o4O6TQ
         Fjxg==
X-Forwarded-Encrypted: i=1; AJvYcCX2nq0KjbxZmlqJHoHCEDa9SctbbouheGyWoQENQQ+/+O3TodyS+71aaEfOI9DaMz34xBhbwSYBcLiwjsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33kWte7Xx5K+5wMgaIMTf+Em08fQIDecSqPf7XdYX5e1sT4Ti
	FOMyM8iUv4Z4JEcV32tycp4Xq3w+XcCXKuQqNO477M29CADX/p27xaxy+h8EoRk=
X-Gm-Gg: ASbGncsop+B9pFHjBGLCY+KVSf0S3F87SMLdFt7etFbXNgC4kXs52U8i32sBxy0on5I
	6crMyuPHYNJcHO9L6Y5eYWKaPrSSe/fKpgx5iGPv2ZcGwgDXvJr4BQQaPtQ/cluQAe5lkHI7gy/
	xqa1U+N3kUR2fYN1eCZG/Iv10lXIgboFfMrlNbiCv5650x4olpvdCC/ugNrGmGBmgsf2C7D1Wry
	C3/LD3zg23K1Ngfry6mLLiV2/H26+33OXOqgCjchsgkiHZX+eWidH9DQLW/I+vt
X-Google-Smtp-Source: AGHT+IEv90YSml1vB3yVi1kVPvZNguaRuGgjlQIsfKSFuZ5C43ynmhkX1erwdxz3oWCyU7cEsZn6Pg==
X-Received: by 2002:a05:651c:555:b0:302:4130:e0c8 with SMTP id 38308e7fff4ca-3025452fd41mr14481201fa.9.1734128142715;
        Fri, 13 Dec 2024 14:15:42 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:45 +0200
Subject: [PATCH 29/35] drm/msm/dpu: drop unused MDP TOP features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-29-988f0662cb7e@linaro.org>
References: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
In-Reply-To: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=tPpDxtHO5xmaStginATMqoo8E/aoUokLFeBXLrsaQRY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHI1qqRYU/devWX2LGbgi3Y5RR0YCZei/GMW
 xIk9YP0h5WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxyAAKCRCLPIo+Aiko
 1QqxB/wMEhSpPsB5KZxkaGmeszgOBFKq7akQyCwt4+s/C9G59XsH4gEnwwcd1ADifNpNtvSdRkH
 2IixA74GQphgxKIuvyMewHXsDwGLRT8cP+xInrKcJ/RKalBN0ngqVPBOWmTBYAVXS9a8lWL/wXC
 Efyo1znRYHKyLLC52N9vsmg+N5CP4gemxvIt7fpg6DjjYPKxBxzJvT9xdNSKevNTm6LrL7mZusI
 LSNNdnHYFe4GX2p7LlPONgFtUPaPEORakAT6AUMA7M6syyWJcSc9dkjtFxpiLZfpNPZWuQi92Kk
 jfwhx/OhhDAy0HWOWyEh/T1yvpw6JaCifZ6zi7C7UXJ4PBV/
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop unused MDP TOP features from the current codebase.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index e1039b731604ef49958ff158d36e0aef97258ca4..2d7e4bdd84705707198c3b265a003630cbccd28a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -28,19 +28,6 @@
 
 #define MAX_XIN_COUNT 16
 
-/**
- * MDP TOP BLOCK features
- * @DPU_MDP_PANIC_PER_PIPE Panic configuration needs to be done per pipe
- * @DPU_MDP_10BIT_SUPPORT, Chipset supports 10 bit pixel formats
- * @DPU_MDP_MAX            Maximum value
-
- */
-enum {
-	DPU_MDP_PANIC_PER_PIPE = 0x1,
-	DPU_MDP_10BIT_SUPPORT,
-	DPU_MDP_MAX
-};
-
 /**
  * SSPP sub-blocks/features
  * @DPU_SSPP_SCALER_QSEED2,  QSEED2 algorithm support

-- 
2.39.5


