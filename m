Return-Path: <linux-kernel+bounces-257183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55AE937657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68D31C210AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6AF2576F;
	Fri, 19 Jul 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eefuVgl7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575829A1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383418; cv=none; b=fljA37QKSTIH6Smx7aUUb5IpffdOf5TnzwcAVrvkIUDw698UNmiFcerhd8Jt8Gtk5aoj8dw8fYkzxcLZ/j4wARk4s3Ts9ZNWqyKei9HHPJn+a3n1fCMU2Hy0tURF58jEiid13MRbiVYIykREq0iEEpk+ULalEprpxZIOzWyImUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383418; c=relaxed/simple;
	bh=RXgu3OH6O1t4AFA1c/ztzYKlGP0Ku08ZFQf1VH/giNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ReI0+qqjfC3GQ9JXqE7HmD07s6LqXhNSFACmBpqdb+AC3yWmCUcEAzyu1uRB5uqBnClVTrFgPkC0OsZUhYGQPfSQSivloI9b8ejcxHe7XnBgDiHR6D3GSXUAjEKql0fKr51cxo4hagoKG6cpw84YNcJuhPax3kopfUtQk2ftFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eefuVgl7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso2142861e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721383415; x=1721988215; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EDgqQLvRSwDrCcv59CmXj7GYAkDehygdnCzNRYYZjU=;
        b=eefuVgl7T/9X5iu8ceNXgpz2mvdAgqfcK8+0YzISXRAxLAai6aLhuAbmAF7KyE3JnR
         BXcYtaiLTEep1UEPgis9oYSB/akDv9wmlZBZmZfYAy2V7XtfTrPWKhB843X/5lOLvtSS
         /7AZ0yzaJKlKgrjGe+svXE78D2XF36GAQRWJv4lnhjUlxjPREwkJrwd5Jl1eY7JjRo7+
         Snrcw3LB0+eL2bosG3HwOtOJdeJTcvIDQfWezWjn9oLlP4gIJWogpRtN5FPv5cQRm34l
         KK1OvDhGz1pfKK+0mrNYlh6iL7fETkEObvVmA6pHS2fAJoaXU23fghZuxCDjTVMk/Jdz
         PWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383415; x=1721988215;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EDgqQLvRSwDrCcv59CmXj7GYAkDehygdnCzNRYYZjU=;
        b=n1AcvfDvx1WbTIakd4sKa7Zs5sdmrbL4CZ/4bqy3m0pR3SZYzHwXT62DlX8rVHU+sX
         kjcOYWZVT/DrCfP8sFsLAdGfCsIa6YA4v7VaPuF77VUFgS0MJ99EJcM6MIPluA4unmEU
         07t0/80HGuUTvbd0PHeLVHBH1W8bka0X0LlrIVq0MkswWqllvpZ0PGqEfv+gxVF2RM1N
         olyGfkh84CHA2dv/rnkCw3LKNq9HvooC7140iE9xop1o+eQrbClcVzCKBRmUFsM0zIag
         iSN2oiIZfZtYOK8J2AL5dT+EgicHFF8rqQK+GI93n1YOBtf66g+KoGQwwXjdut6ilM+a
         jgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqDS7C5neNxqm9JOz1ZAw8abR64ui24VkHILcoDxr67nmCJEbT9lnKJ0ONdTTHu37F3TTTieUT5v56Qq3vuvVetWd44E+5Xr9ihKj4
X-Gm-Message-State: AOJu0Yx1M2qEwpoDsyl7YFVSFXebdSrbU+Buf7kL+kHhg7VU1kLeFprd
	x9Lce5qWnkrvbN+EMkk69sVgyAzPm/dfyaKnPlGms0VCdjdQF0VHF/p6ONLcNJg=
X-Google-Smtp-Source: AGHT+IGTtksPveW6pC3us/zUAC0RNKQufFymz4YZAckWjFhi189BGPP5AyYrC6CKG/NOilhOcKxVQQ==
X-Received: by 2002:a05:6512:10d6:b0:52e:9481:eaa1 with SMTP id 2adb3069b0e04-52ee53afb4bmr5128415e87.23.1721383414492;
        Fri, 19 Jul 2024 03:03:34 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa31e0sm919984a12.27.2024.07.19.03.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:03:34 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/5] A621 support
Date: Fri, 19 Jul 2024 12:03:25 +0200
Message-Id: <20240719-topic-a621-v1-0-850ae5307cf4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO05mmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NL3ZL8gsxk3UQzI0PdJNNUC+M0c8skkzRzJaCGgqLUtMwKsGHRsbW
 1AMW8ly9cAAAA
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721383413; l=955;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RXgu3OH6O1t4AFA1c/ztzYKlGP0Ku08ZFQf1VH/giNE=;
 b=c/RgXy6dCMl2d1vMO7rTTvx4ALMhaqE1vHO1hHD/P6O9ZTkdG/pRDnzht+tM4eXuFiTkhO93Y
 i4Xc2YMMSGSBgSW5bylwIp+nHxRkF4vrpnKYFeGzaiDNLMRiiwchTjN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Baby A650, needs mesa mr !30253 (or better)

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      drm/msm/a6xx: Evaluate adreno_is_a650_family in pdc_in_aop check
      drm/msm/a6xx: Store primFifoThreshold in struct a6xx_info
      drm/msm/a6xx: Store gmu_cgc_mode in struct a6xx_info
      drm/msm/a6xx: Set GMU CGC properties on a6xx too
      drm/msm/a6xx: Add A621 support

 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 111 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     |  21 +++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  52 ++++++--------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   2 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  13 +++-
 5 files changed, 164 insertions(+), 35 deletions(-)
---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240719-topic-a621-b5e83f79b4f7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


