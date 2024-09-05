Return-Path: <linux-kernel+bounces-316263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A945F96CD31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFDD1C2278E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BAF1487D6;
	Thu,  5 Sep 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONAOyL+I"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB5EEB9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506779; cv=none; b=XX7RTk5yQpS638t1uj5jo3JwDdrLbzJJAtCT5vgNwB0dY1Nd5+sqH7Een5EcV2cmqMGosav3OOb2cF1XwH60PAbLon8kCAZ5/mi+dGHvO1QTw2iYeD7Yf2UcsgvKn43LH6OXS/Bqcv62CiKG3wG003Fxk7+cKAOdUjniHE0QbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506779; c=relaxed/simple;
	bh=BZ5PHJUN7Hor8+JpllFkfczVxdddQUUnZGIyXKGk8aU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AcBefg3k2M0EHVVUGh1d/VZh+i0wGfmlcO08qLiGSED4ZNqvBe33WzgtSyrpvIBIW49howuydNcEKEjB+0dIjwYbzb30XBjuVuWeipCfT52wLCPWsE/jxm0mrDdlL9+P9sYF8cnc12X+jIHvoc4lxCTgroFjV0sK/Z37QPfiTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONAOyL+I; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so198080e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725506776; x=1726111576; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7Kwe86N9nHvE2bdTSgvVMB4M3NfN+siKz0Ithbz+ZI=;
        b=ONAOyL+I1vIc4RxWNY5sgw87FIaOk7TpshzY5hp45W6Mm1T8ZJeWVLx0yPad+6Hfma
         hCjnNTwj3bQW/PiMtfnp2ESZ8mtOUM/hthKs2u/hxWpU7RRgyrPOzgjJac73hADUf1iE
         Rjk/3NmlDeHuFTxYJHHUPGJ5JTdCenW6Z7xOIpRfRkHr93v9w8bujByN8SRXzRkPt+u5
         C/KQbu//YMghPMuV6r+n4pPG9ZHIIqsVOzIq1cup9p5Q2nvhbJXPr31D8aiR5PjKnEvR
         2SWDCq6UXeTXTzoiWg0ToORbHq10ZM2jWKRrGYmUTywP6qwF+aQf0n3KJI/ofC1Dc3Tp
         zcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725506776; x=1726111576;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7Kwe86N9nHvE2bdTSgvVMB4M3NfN+siKz0Ithbz+ZI=;
        b=Y/g8GmLFmh2LadNmDR/koZiljsif04/39a1PhRsPlPVTUrXDXvrSB78QFG/Hcf/a2K
         8JqqhHcs/u5G390/DkVDMYeT8JZBYU9IxRDRk9tl8CNAlJ1PFVTKMVDDUcxzPUUE3qxH
         DEweFXC9GLO60E0vSeJsMfiqGITtW9dnw/Ss2ZkvHq0FkM/X/kT7XNlsllgH8uUHjzS5
         jEil7y/KgXIJ64xRYMcL5sJx+5ysnLyIPLu6ZjHbQ2YTUAkATTeouaYx8fBmwvslvLyR
         bPYLp+l8j63S7Myzisf16RLMDP8pkBMcRB5Q/XLSkTRQBDcVjQqxDpLP5xEtKXRV++76
         RSWg==
X-Forwarded-Encrypted: i=1; AJvYcCWrIob8HaZOTL46FRnnX3ZJ0cbdkBidM4+XPTIKuh470EkCUg8RBIZfRsHtYCAJWQafdValWiyr7wBM54o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCv8basvEx/L7EfQRM0HiVEaNgqISzOT3iymMl3kY+1yge8fB
	yXc+UJ28WVUiv64qPJlRvcCjJMMhi/kRpyEyDBJSJU2nRBDJxv+ePH0Lrw6aAEA=
X-Google-Smtp-Source: AGHT+IEd71q7rgbecU7t0vjYUoea6y0Uwtg+9mihNSR1M1wolmrI75YQVKcYPsBu1XiNVXMZS24V6g==
X-Received: by 2002:a05:6512:2814:b0:530:dab8:7dde with SMTP id 2adb3069b0e04-53546b451b4mr11950730e87.34.1725506775783;
        Wed, 04 Sep 2024 20:26:15 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841a3csm2533860e87.226.2024.09.04.20.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:26:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/3] drm/msm/dpu: catalog fixes for SDM845 / MSM8998
Date: Thu, 05 Sep 2024 06:26:12 +0300
Message-Id: <20240905-dpu-fix-sdm845-catalog-v1-0-3363d03998bd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQk2WYC/x2MSQqAMAwAvyI5G6glYvUr4qG2UQNutCqC+HeLx
 4GZeSByEI7QZA8EviTKtiYo8gzcZNeRUXxi0EqTqhWh308c5MboF0MlOnvYeRtRm8pZ6iutyEC
 K98DJ+sdt974fNtpQVGgAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=721;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BZ5PHJUN7Hor8+JpllFkfczVxdddQUUnZGIyXKGk8aU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm2STW/EY3pdZ+8DlzkFSokoN8pS7Iot0QDch+I
 uXW05aaj22JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtkk1gAKCRCLPIo+Aiko
 1WjFB/0eAJYyhERs0dG0kbpoFycXpnsaxRH5nzOGVfuBGt9fw4/AwImtD+fmGsFvVh3XH/rr3bR
 iE1DNaeyCRiOUuIrgaPMXljb7w46g8wwa+a+Ulgixfjs2yUxnLT2YTxDtGJk5RCLu8nGWgfnFBe
 QIwF+Wn9q0hk/M3ko8qgSEeh8qG1cMcLvkToTrO7h0SzQfTAJb1dbcD0e/KPeSyo8NP9QxaKmBN
 bte/3bMbM04EUUsIlz5JXu2Sx7N9Y2706GO2mInj0vgZ0cBlGSnTeExO92nCV+P8EifpbVd0XS2
 lDl5adPlggkzgWQX4ZybCYQgfDD0r2SNY/vIpxD1AiiNJGLA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop two extra blocks that sneaked into SDM845 and MSM8998 catalog
declarations.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (3):
      drm/msm/dpu: on SDM845 move DSPP_3 to LM_5 block
      drm/msm/dpu: drop LM_3 / LM_4 on SDM845
      drm/msm/dpu: drop LM_3 / LM_4 on MSM8998

 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h | 12 ------------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h  | 14 +-------------
 2 files changed, 1 insertion(+), 25 deletions(-)
---
base-commit: 15302579373ed2c8ada629e9e7bcf9569393a48d
change-id: 20240904-dpu-fix-sdm845-catalog-287ca4b72048

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


