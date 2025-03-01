Return-Path: <linux-kernel+bounces-539855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCF6A4A9F5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F913BAD2C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D891D514E;
	Sat,  1 Mar 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQSrPSrM"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BEB1B423C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821103; cv=none; b=KRFC6SOIzA6N5RJdoPiqYVy4orfkPW1q+BwMCIuZVfv8SZizvHyEmJ2inlAZ2bhcpE6Esf8IebtPlmamiXmf5qDD9XPjgzxTuOcotQxDUzkz9jpLZneEQG2wkyf5GiyepvI5FQWvMMb7a0PhLCeSU/ZBmKvuhAP9jqG/teBh5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821103; c=relaxed/simple;
	bh=GqOq9rkDu6v4PggutY2CL3RwcYuHkk2cBFFkYzV4MYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cMPQ5UVh5x8ZiYG5V/6Qexjk+hSY+ZClNlvjL43NlePtQsTWvi2pzOINtM2Koq3yuWD7zZRtdSSqLYJKbP/YuruGKGgFUbkkm4I0dbrJdaKdpM+TxnHC92S5xCFDadvEMoQ/jLqSEEhl20GUQgCIDtFrUlj8xF1eE1Kx5FylLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wQSrPSrM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-546210287c1so2923619e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740821099; x=1741425899; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypB915vJqmRaH63cKoFbSo3grjRFws/DTwU9I0cazvs=;
        b=wQSrPSrMrRcNcMf0nFrC/x7X41EgqCwbZ2mDxzMvOJDNeGWYilwKH8IAOcplkM7qby
         woR4NtW4+F1X2NufcUyvBLmm283AoTJ4CyS0m0XSUeHYGNbPlGsHE/3EeKROUtlKOuLS
         wpOEYXGojkMnzkxpqfAwQPDiqX5iuiKX/guoIzBGJePVXMzhhCyHQrM53BGm2NegI5re
         uw0CpAbISLS+/BFy9/StboI7l9Uh7mhC/TNllO4Q6Vb0Wb83Rk2cm4aU9zI81hQGCzX+
         PWPlGddn5ydBF21btGJy39t/E+6hMUoVdjfMJODCCsptOeXaGo8XE8J2MFeb/KjTSfpu
         Xt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740821099; x=1741425899;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypB915vJqmRaH63cKoFbSo3grjRFws/DTwU9I0cazvs=;
        b=W6ygJxvnrsf1WV4/ljjvTIrfFWcxnBbN0UJVBWoyfeTQtfqnJzOPxysAe60M9/PR8P
         +Z9jjNWPSBP89fz0yNz826aX4C8KfZxx0SwBwjmiS++X4qzwVnXyBZTOfH2Gc2BpJW3G
         3o2hiOaIilIIjUTa+kd+N9ks51VFvtF4wiJEIrzs0VB/WdnNFrO2kxARBMyh+pUSVIIR
         JCapoJ9LKXWOWcntVyLannJMtPjbyIMII3Rs5svLdA626m2KIkPd+t0mad+EkxsmquGs
         lbmhSyk2febmRNggssZ1tFirUZjZMYbfPV1+16zd1BBO4+85v0fWe/sjSF11MbZQcCHl
         vWPA==
X-Forwarded-Encrypted: i=1; AJvYcCVnsR14iAuqz4w/C1Z1E1LuZgxyboPC2lxEbDlwWmCAcbhq4aGQGM7pQmEoZNJYY34XQECyy/ItbDRu/SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gdbxGf8UW0iagqJRHOGyLApNuxliKkZRaTdpig1vLVuOmiN/
	L+3q9+OlU9esR3s1L6w3W+jcZexXmHO7PW0FPKMYRfkeydy4lyWC5swN1wKOGMo=
X-Gm-Gg: ASbGnctOTF6yq6JM7ZIrQqzp9eYMYBggp7TYqXGoIM48LmMe02Z47egbdl3KMSXVk7c
	TVuMLo1K0M3S0/sGBjCKQcSvbm55PtcxHGDY8Y5+bXbCjuD5K/Z51+6akKikgBYCFAFnB3rqC5S
	jotm0XmAs12KQ7tQ9IQK0fCqZGbcRgQ8v/Pzaw9e0q6TL+f/XwBHzchP8DWnAmVKx5Z9q+jmWl7
	aoJwWalxnHIUc0TQpEVDTtw1tJ8QU0+jRHZAHUAm4dCQTIZdlN+N3NAgJZPEvqq2aY8nG5IIOie
	yMV5qpVwPJxGPEMoxqGVaVnIDEK7cPNMdOfARQM66CUoLwH96AF2
X-Google-Smtp-Source: AGHT+IG/1AayJVp+qm5RXrxUhbjPYPpH8uNl8/6SF/4ZZfwJzrYVs2UolooqjFryoLYeJuDT1/fK0g==
X-Received: by 2002:a05:6512:3a90:b0:545:441:52d4 with SMTP id 2adb3069b0e04-5494c33089emr2269458e87.26.1740821099342;
        Sat, 01 Mar 2025 01:24:59 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417432csm738406e87.52.2025.03.01.01.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 01:24:57 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/5] drm/msm/dpu: disable DSC on some of old DPU models
Date: Sat, 01 Mar 2025 11:24:53 +0200
Message-Id: <20250301-dpu-fix-catalog-v2-0-498271be8b50@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXSwmcC/3WNzQqDMBCEX0X23C3JolJ76nsUD/lTFySRjZUW8
 d2beu/xm2G+2SEH4ZDhXu0gYePMKRagSwVuMnEMyL4wkKJGEd3QLy8c+I3OrGZOI7Z1560eHHW
 mhbJaJJT6ND77whPnNcnnPNj0L/3v2jQqtKrxRIN1ZOvHzNFIuiYZoT+O4wurkalurwAAAA==
X-Change-ID: 20250228-dpu-fix-catalog-649db1fc29a6
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GqOq9rkDu6v4PggutY2CL3RwcYuHkk2cBFFkYzV4MYY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwtJn2qMf0VS7G3JEN+uWvtBRgvvIOldnrQcYS
 k7crSZsssOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8LSZwAKCRCLPIo+Aiko
 1e0HB/sHdFdwVnCgI6jz4PMEGkIyskrbhGqY3Hqwu8/2I5ecn5HgHXqKgNxEmhAwseUs8bRMoym
 4fn8fkRTrsmTSihzFm8rom7vUKX8po4+Dh13YIGBfhBugH0Uvsb42HOAOq6bCOJ6YVJnl5u8SkM
 Yv9QaHmoQKWeLG+PsJck7cp5GRXF41+7G6rN02fpQ0QaP0lv/NjfbtSEUV3OEHUPv3HYSgVTqjz
 8M3RhzQQACJhts2u77bNT9Zm2N915NZFfph69mY6YiOYdtljBt5LCoftEdUaYtxZxW5+AlHG3eA
 1NwcGGLIHnLk/CndkDteu7KMYCaQ6G7oG3gfKRv8Ic01evLE
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

During one of the chats Abhinav pointed out that in the 1.x generation
most of the DPU/MDP5 instances didn't have DSC support. Also SDM630
didn't provide DSC support. Disable DSC on those platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Fixed commit messages (Konrad)
- Dropped TE2 bits and pieces, they are unused in the upstream driver.
- Link to v1: https://lore.kernel.org/r/20250228-dpu-fix-catalog-v1-0-b05d22fbc2b4@linaro.org

---
Dmitry Baryshkov (5):
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8937
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8917
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8953
      drm/msm/dpu: drop TE2 definitions
      drm/msm/dpu: remove DSC feature bit for PINGPONG on SDM630

 .../gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h    |  2 --
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h    |  1 -
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h    |  2 --
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h |  8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h  |  8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h  |  6 +++---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h  |  8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 17 -----------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h          |  6 +-----
 10 files changed, 20 insertions(+), 46 deletions(-)
---
base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
change-id: 20250228-dpu-fix-catalog-649db1fc29a6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


