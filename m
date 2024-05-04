Return-Path: <linux-kernel+bounces-168612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17C8BBAD5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD861F21F1D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E110A16;
	Sat,  4 May 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e39KWvAv"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2317BD3
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822749; cv=none; b=XeRklMPcB6vDE2Bzod+MqukwpqSPr1G5vb0jkmuDAfgjroXXoRtLgNLiTgikhpRX8zLnpujyS1oaj2qGDOWbGvlYvSbVnHcCOULR31JR3wiLFNBkW3phm4tSkXJy/TReY/f5ZRbmKK94LfibLVJWcInpwDDob87IhV9k2tCiIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822749; c=relaxed/simple;
	bh=psH6Hfz8X1PsHcv3AZZTK4aOZhVGyQRFm73UEDjnMRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WbUa/WE/bnqsQYT7feQlRpfrqFdROQfxP8OXx0NIMTu84ucLb+GdMal42CPvaxDbr+w6LFF0wFQGtls6HhVoiPX9TySAiP2CeGS2i2XX26QloEYSQcr8cF7oT0ylE3rtfxxZfrcoBw5rom8QOJ9rtlq53VSUNBqjBcvlYtX105w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e39KWvAv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f0b6b682fso529732e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714822746; x=1715427546; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJQr+N2iqh0CtzNmBbGY4L46Wh//FbWkaD2H/7huYvs=;
        b=e39KWvAvZXimJP1xGWxHWZ/OM4UCgoWXeMpxetLfbR826muk35CiW1m+6pyzWe1EHe
         pSx1AYlzMQFnVcgFnCEA7Ammhm+PLEdbAZNRgoNiYPNO0xJDhXsRMha5K+agXagsUyRo
         03Gz+Wif9CezFOJGuuJb75goslZi4auRNTeFlcjCaoL6iBxZtPKr6ZR02JVokC1N46Wr
         /MD2PwFIhwdGpm3cV7JL2dJLc4eJLUdKt7lZHE9jY3DKPZ1Jr+hLQ7cHE6X/Oy2buLZH
         UcloHTh0l7lOV1SoaDN5YTa70B3gHiTntDlLAq6cXVM8N+Ch85qLODv+slp+Kb2m+JXV
         s0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714822746; x=1715427546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJQr+N2iqh0CtzNmBbGY4L46Wh//FbWkaD2H/7huYvs=;
        b=XVNmzHDJ0vV/dhCoXe3PJXxoJooHOajkXrSJK7SzXdqj/mZtT4YxDi7qqJQjHxtvgm
         FvAjav/Qaawy1Wv66a0ZaDZnrpoASPGzFPEFRhoN2LTnI2YQcWZJ7oi738lxxvxnaFYV
         YSU6n88NkxU0uenD/FgT1J72puuaocEquPNVC0snOTZ/MtKi7Yv56dz3DTJyaozoiofA
         Ra/SQFqUQm2kjgO6JOOymRjW0XfoG9Yf1M7PNFNJx7G9nzDM0D//gDm+UYOX06xr2gW3
         JPMeh9+LlmShN2fpELZ+cmV7khVY7t5LTqcvUx956iDSXLtZbAfJYDSn1Iugc0gNtFJA
         FeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6nUCabYVBt7sXL0y+/mHgQCRg8UtsqdbyV64Sf7pgc+X2zrcahyqFx9xAaHVLZLcFAEgqDpnu+lH0XZkgCCjpsfIgzzaFXYiDCER7
X-Gm-Message-State: AOJu0YypfVziyOxzOc8/zcJ6kBF26hQxchPyuDdkzsbrhvmEolSY38uU
	CtLh7j70+qEOrWfDUmkeCxO12XI0aw2sszRMi/nEOsCNekS/usR6gaQA6WnthGQ=
X-Google-Smtp-Source: AGHT+IF7aOCE2HjYaAJh5yWG3SZAbTJBfjHo58pHIPQhrrqnKxi6kzUXvdANtDldvdgnmxcG20+dZA==
X-Received: by 2002:a19:4311:0:b0:51c:d8f6:4e6f with SMTP id q17-20020a194311000000b0051cd8f64e6fmr3921509lfa.40.1714822746039;
        Sat, 04 May 2024 04:39:06 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b00418948a5eb0sm12776941wmb.32.2024.05.04.04.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:39:05 -0700 (PDT)
Date: Sat, 4 May 2024 14:39:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	"Stanley.Yang" <Stanley.Yang@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>, Candice Li <candice.li@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: delete unnecessary check
Message-ID: <3f9ce1f6-c7fe-401d-b958-395948f4c6ae@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "ret" variable is zero.  No need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a037e8fba29f..4d50fb039509 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2807,7 +2807,7 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 				uint32_t timeout_ms)
 {
-	int ret = 0;
+	int ret;
 	struct ras_ecc_log_info *ecc_log;
 	struct ras_query_if info;
 	uint32_t timeout = timeout_ms;
@@ -2836,8 +2836,7 @@ static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 		return;
 	}
 
-	if (!ret)
-		schedule_delayed_work(&ras->page_retirement_dwork, 0);
+	schedule_delayed_work(&ras->page_retirement_dwork, 0);
 }
 
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
-- 
2.43.0


