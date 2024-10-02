Return-Path: <linux-kernel+bounces-347121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE398CE20
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91737281E33
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62F1946DF;
	Wed,  2 Oct 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d54RV6cd"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349113FD84;
	Wed,  2 Oct 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855489; cv=none; b=HD8otjOVb0JT2E3ltNOz2EXRixB1DzqSA63dEOGVbyboqMlmK0GqNfJlAwGbL9GEy4w1T05Fz6AvFpFTFXWqO5Dp3BcgRUNoaXs2ahVnOCua83YijSX23F8KPR7EH/HXzgH0o9ue7sKq1N5E4XukI4wcG2mwSTItBsab659UEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855489; c=relaxed/simple;
	bh=Kaf8TJAWNCNCln3LE9oP/caIjAH992kxQyEN/s+3k6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AqeCGsRejksClF8KYQhGO8TEQOT9q/utHFA/B/k1UG1vj3Vjlz5nuVb7bLnVWn3cc9hALPrXOZmtfy1w6a12/TPZJEMz+Q3RNlMQqfAc87Kv6G3K9kXG/v4+GBhOSDTAerenWAJ2KzL4DEh2MmkoXPAl8Nvt5QhMZ0+P8C0tKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d54RV6cd; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53993564cb1so3762072e87.2;
        Wed, 02 Oct 2024 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727855486; x=1728460286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9nyVJGqZi2kIbcsm5pwHQqNkD1Y8pHSN+TEVYc1BR0=;
        b=d54RV6cdqBHt2lshA1Do0zieNz2nmwceWOVIIHhnxWrRuGPLDiESQyj6SyQmMmF0GH
         5ryr4V5KpQpTkp/P1gtIUxNZ+C8L3pNQCL1Z4GFaFnGaswtHI0ptMQMYKHbzYVCnKkjE
         tmZyIkyHI98HccSnfwBTJ70q+YRM7SoJ/YF/GjC4xa6bs6UFKGHdUgeqyDVxh0OirsHs
         XO0CJxbeOMtRYLqwnStlkA53uqGDihdqDTQTeALacS1EMwIAwHaRTv7s2Wcn/3MoGaGl
         MFbJ0pCLwbgxn831czWBCXzUZncutBikRfc2YW7X2YmesVEONZkw9ZrmqyizmB6M8pqq
         EqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855486; x=1728460286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9nyVJGqZi2kIbcsm5pwHQqNkD1Y8pHSN+TEVYc1BR0=;
        b=U+uA+30KwSon/heZYo8fj7E6byQA2n7rGD0IS7/MtaKVmVsg3jG8on9UBnCX7F9FMA
         Hb295s285zjjGOOLuNV8ovKcEQbkPGHCRcMU6fy+IlfMeIOincpH2GR3B3Vje75NoqeY
         /k+OQmd6rzp50TKWEBfvt1JOiI6bst98MrjFEs0JCN4dHXaJqnKmKwT8Xug/O0Kdd1JZ
         7UkKBMUwAJf+qDZFB/NCLaD7ONWRHvqHjOXAjLf846himOV9DPOhFaXRYiRRTWsP0QwS
         AQwX9KX3MTtq1AkutQPcAm6kp7Poafk6osuaMI42zJLyOeZriYH66SPUKG8keZry8+A8
         i2UA==
X-Forwarded-Encrypted: i=1; AJvYcCUUsuRR00ZyDr+mHuGwKr9XadrRzgyNrs4wg+l2KX6gb9rX9XtqAlkrh8DIL+Gox/auEzRT5BeernP8pCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/2aXnvU+xziYnDuH4wRR+eUJPGqkRBHBsGnGMwoamG/tvk22
	JM18gj58xohIJohjaqqR4j5/LEskUdyVQjB2WU3XePSguU5pAB4c
X-Google-Smtp-Source: AGHT+IF8mtYU+7zcM/iYB2WyeVNCQnN+7leXQiXAba6EuIP/+NC+OtPnfMj3ik00ilaWb/QudUriHQ==
X-Received: by 2002:a05:6512:ad2:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-539a0680758mr1016050e87.29.1727855485537;
        Wed, 02 Oct 2024 00:51:25 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c277c056sm821081666b.33.2024.10.02.00.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 00:51:25 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Fix spelling mistake "initializtion" -> "initialization"
Date: Wed,  2 Oct 2024 08:51:24 +0100
Message-Id: <20241002075124.833394-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index b17e63c98a99..733e69e90c5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1533,7 +1533,7 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
 		r = amdgpu_ras_init_badpage_info(tmp_adev);
 		if (r && r != -EHWPOISON)
 			dev_err(tmp_adev->dev,
-				"error during bad page data initializtion");
+				"error during bad page data initialization");
 	}
 }
 
-- 
2.39.5


