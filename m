Return-Path: <linux-kernel+bounces-537654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DADA48ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EBE169EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0290014D70E;
	Fri, 28 Feb 2025 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLYr191/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D02F37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710448; cv=none; b=SVUnOkzKdp3wLSr6tNUecekEPvWhDPoxLWZkyTnx5F3XaCT49BYExFKG/RNaQJ8F6g5HGc7gSLqBZaSTyJRmC8xadsZA3jGzVTzF/G4hZVycyXIkMolGI5hLqgwxEGDPkyYxMZry5+GxL5EOz2WIECB1Nzhv9Lky2hYmPApG2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710448; c=relaxed/simple;
	bh=NqHFkZTNSAOJT6jUtd40Rvhz1aSYBkpu5FVcerkF0Jc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G1lf7eXRfyUbNqWhJeRcHG2Cf1Shkb97mZiFm0noWOTzAhTdczJ3Xusp2v1mYfu7zzU6N1XW3a2fYDjo8LJ/Nm0gQfd0yq2rbA88EApnIn74CexWg65YxH4tH+OlwI0hh34QxKUrbtZvfwTBDmNdAape68j/Rx0Onjoe7QjAQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLYr191/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5461cb12e39so1509663e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740710444; x=1741315244; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4yYgoXSkPDEHxZJYvKHSYFoTnrDSY0PIOlWyJbY7oM=;
        b=pLYr191/6XLySwC2BVpxP+JvfcCgKbuvLVwqTBOAT09beG6Ld3Qo27lCFAHfLXatG2
         5cmc2sSEBrEd6Jelp3s46LhJPOefmsOgaDoh/4OFKhzHEsSCg+3qi+F8mFW+498reGZR
         W5EdTbHjp5KYwlIpAdFIgFJULUm8iRjWNCFpwVMGEvjVbLDcvDA58/F2oGEd09pOoQZq
         va6Z9ijqorTNQpSLjTIrDN2RReusx6miq2xJhK7UKubTadIO0lt44GigypfzZp4OTkYJ
         qaipLrwflenc9J3vSM9vHub7j0jCTuAkvBhbW6+pN5aE2DjSKpHBni1x+1cWPmECvLPC
         hnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710444; x=1741315244;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4yYgoXSkPDEHxZJYvKHSYFoTnrDSY0PIOlWyJbY7oM=;
        b=e0/Nqz1IVU5j0HgbmM10sAeK/91HWuFvOeSniIeyiczd5nLX/FjOAdyTz19aeVB5Y4
         9ac7WzPsxOBgpu0/qbjZApMY3mMWrl531DdJSxlxpQEyNeaUqskOH9JUAgQ7X1gc+KaR
         ioL+CuCSR6SWXBLpIYFNuPQOH2O33uzg1ixcCDh8JeZAAZTfZupQddMfr/dfDBTCw59+
         svbkC/XrmjGALo89lYnaKvWra1iUOHxeTQ3hE2tCeysp68qfVmmLHujuYZ3fri3EptbL
         e4AMW9gOdUUgqdRfKagEwRH3il2nlfZcAgIiKh0LIbJM6M+7oUdD5m9Bfq+sIgnutSng
         Id4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXotZan/frI79alv9T5G/EFTlp56wuRaW9GRCLp7AfUmNV2K/q5O0xV6olyBm2noQ2mqsyKKxPXpAS/QU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl51VvORkQwCW/0m0Xt31r6/NM0TooTvTDTNpBdXodkee/CxQj
	pow5plrwdxz+2392xBwos1xDm8c0fJkM0k8Chk8iH0eEP5Jm1an6HwN+b0fZXHI=
X-Gm-Gg: ASbGncvLDlT25GbiYRgb0oP7TtqhG2avGkWWY1zaEqXo7aNBXnAjARrysK0Iv+C0vJK
	Z4kZOmfZAVveXfV9Z166mETj5pMZ2Knjo2H33v9sn+gp9N7tiBgTCK9wHqaAHUiD3hQPsirISgB
	yqofkz43aLAm6u4vHbpKNkvPWVMfY6vRJs0iRy8gZyA2hOjrjym7kduoc9fukpEIS+qqvq+sT9K
	gY+UnG9QjFLIU+mR0F7z29DbyFpWE3S0KYY8CcU2jkkQdH+ugMZfcrHEtcxS7E/quCu+sSiagZh
	fO55GRmeUXZKd6+q7lyKA974Iyb7nFuGLg==
X-Google-Smtp-Source: AGHT+IEtW0WMPANQ6F9JpDf+C1+6JFlyEN+Vr6zomJwOBX9tkR/2r9ue9QaM1C6U7eBAlBJHB7ZBbQ==
X-Received: by 2002:a05:6512:e8b:b0:545:296e:ac1d with SMTP id 2adb3069b0e04-5494c36f2c0mr538764e87.51.1740710443803;
        Thu, 27 Feb 2025 18:40:43 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867a7403sm3493881fa.17.2025.02.27.18.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:40:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/4] drm/msm/dpu: disable DSC on some of old DPU models
Date: Fri, 28 Feb 2025 04:40:37 +0200
Message-Id: <20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUiwWcC/x2MQQqAIBAAvxJ7bsGWiuwr0cF0s4Ww0Iog+nvSc
 RhmHkgchRP0xQORL0myhQxVWYBdTPCM4jIDKWoUUYduP3GWG605zLp5bGvtpmq2pE0LudojZ/0
 fh/F9P29WEudhAAAA
X-Change-ID: 20250228-dpu-fix-catalog-649db1fc29a6
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NqHFkZTNSAOJT6jUtd40Rvhz1aSYBkpu5FVcerkF0Jc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwSIo20QqL+PSUtzMvu2VMoizDb8f7qpVvsxX+
 ee6P7F2eHSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8EiKAAKCRCLPIo+Aiko
 1RIxB/9DmOc9LFEh7/7feQPzGvjW/BRBpCsJ4lENZIx6U+ByPKdT5v2qDT4+NRfGKfq4u8OVIwm
 b1hT8PQf3Kx24uw/Yu7XgggS+nahjQE0T0i689EqYkMHON/DsOqxgRrjjRAx4TsR9VuMuM8nY/7
 ZZXb6fl3xHc3uRFi2iGydqJYRs6uk+IP/NyZVllESvieHOqAxhW5KH0cijdaPsljJEI+PRNEM/o
 XoL7fmb2jXrYhsIkKm01znKQvs+F/LNwQLD18F8UKOYbCqOats/SYHkddp6HT5uzCvM8R8SOt1u
 sxZyXYxO48mPbZu1iffvBy+E8dzZ0/h1AH33BKTd3vMuKiUx
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

During one of the chats Abhinav pointed out that in the 1.x generation
most of the DPU/MDP5 instances didn't have DSC support. Also SDM630
didn't provide DSC support. Disable DSC on those platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8937
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8917
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8953
      drm/msm/dpu: remove DSC feature bit for PINGPONG on SDM630

 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h   | 5 +++--
 4 files changed, 3 insertions(+), 7 deletions(-)
---
base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
change-id: 20250228-dpu-fix-catalog-649db1fc29a6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


