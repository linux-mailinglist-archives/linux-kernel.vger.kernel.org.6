Return-Path: <linux-kernel+bounces-334787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E397DC27
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89DA1F221D6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223631552FC;
	Sat, 21 Sep 2024 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWgqMsDT"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1814293
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906660; cv=none; b=NjOgNBxdzOIgGM18J26kYC8oY0zicgUH5gwrR948Ika+94QSfPCelFOOrNbCBg4CCzK0GdfBy79UIzi5rBsFI3vkCmasPx+zd+U2/TkJICb8BIIgkOGtrhUJXiB1xL7WyEMHGxWrlXLcS4wl+0ZhDgd0Q+yDGQeqPoXlaiJui8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906660; c=relaxed/simple;
	bh=FWxmz7a337bopVTKsWHeJLal3kuOKwjodrDrKroH46g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NR9fnGaHZ144ocDImHzulESdQLUla8OuTozwhokZQTQKF9E8sU3JzhMued6uH1pej4dVHPHEIJoDK6XgR70XDliI68IKKhpd4ftDTK96ruMtaYp6fHFxAM5/tV80WU261lpnV5HZUnKCAKq+XirWcuaMTahXrUNz4eFVYWOsUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWgqMsDT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3432929e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726906657; x=1727511457; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9/tDMi0UFQzl7ArS3IW9+nNYwPjqkN7+k/yDaV0L7c=;
        b=dWgqMsDTJtizL+WqN+ZyFLCs1hnLhFVPhzW4G54aDTOnFuPJ+CTqCjgAdCnx2DEb3h
         XMuhYYAhocrisFNqSZimYMNeEAlBi+dGHFv3ZbvZP5Ca615pr342cj6voKs7xbfR4a8j
         Z+PHbF1RI8qxIo0o7RfVGlsqQ69D7awkdzLF6EntlmPcXtZrkg8jANveNxaIp6TuZACJ
         zaQFojYDgOqbJMa3IyjSRz8hIredSpl/YROn4ZwPSYlulqL17gu1gFWZILPKidjYpWgm
         UZpWGO0gaZ5l+T68CuqbU6/0HZOYKYypTP0zjEd8lvUJa4Oe2QLke8hzlqlpHaqz5rWr
         FpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726906657; x=1727511457;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9/tDMi0UFQzl7ArS3IW9+nNYwPjqkN7+k/yDaV0L7c=;
        b=G/f9BkNHIpsbF5zXjeHsYFTujoPDNaFwLWczQf2tdOj207YohMxXaffQQMgKjM79Ny
         q6KG/sNWRwZGC286RjEJpHh3CZgaEYuAxkggZLkta6GIb5pRULRpd0XD/DLHYEOppT9O
         VQM/9flhyzOxkyfS4Fz5+7phrgsF+h2nLSzDC68C5Ro77/2Jya9nIuWLg+gkoW0lnfXM
         fwycy9jfRMtchnPkauekMVLA07hrAVgfZaFcCWaZqxdFm46Vaxg7Rhtoh4Vdi0ae6dEF
         ELUlTfRgisnKy/OAA5pA9YvMMoGB2q3nVRAJNCovqlLtQySY+jXDyqswpUCGdLAqcfCz
         KDag==
X-Gm-Message-State: AOJu0Yz7IUY1No6Tq+FZUT6/qM0grNzel4roq+s9sCcS2kHLX+rwIF9k
	1avED3DW5SzltU0SWfrPziep/frgEjmTIyOt4z2Au0lStmZTuAgRqdejvXEW09g=
X-Google-Smtp-Source: AGHT+IExbB1kKJ/xoX5oGe5FlVKfWYeM9QjPTp2scSPuxwYz/2DPr8V3dCucC36g4rRThGdPEYK1tw==
X-Received: by 2002:a05:6512:2395:b0:531:8f2f:8ae7 with SMTP id 2adb3069b0e04-536ac2f5196mr4283336e87.25.1726906656592;
        Sat, 21 Sep 2024 01:17:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968d1sm2466380e87.175.2024.09.21.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 01:17:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/4] drm/msm/mdss: rework UBWC registers programming
Date: Sat, 21 Sep 2024 11:17:28 +0300
Message-Id: <20240921-msm-mdss-ubwc-v1-0-411dcf309d05@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiB7mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyND3dziXN3clOJi3dKk8mRdQwNTUwvLVAPTNGNTJaCegqLUtMwKsHn
 RsbW1AI4EzJNfAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=FWxmz7a337bopVTKsWHeJLal3kuOKwjodrDrKroH46g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm7oEeg8QXbKlz5YvCz4t/2udl84Z9xp0WLVCjr
 E0eBawUMEqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZu6BHgAKCRCLPIo+Aiko
 1dKnB/9i7/Ti1b9MR9d1Q+g5lv7IhMcVt+9dwlNHrbmi/iy9XyTh/1MVVbxvteN44VxZYgkpElh
 icJx0jJby8V/YsrxcxsQBsDxzAbvCRl27Fawt5WCYzug44R7yjOt9V5h7sxfFjKj12IyeQVmfxO
 hk6+Xx+ZWDNotIFPeowgRgjuUAQpDJMHKCBfAO0xqO3+6gRxnb7GXfhDMZ/8DlumwSFGGRucnoE
 vPIsYP37wcOIpGh33G5ZiFP4sEbcJ7Uq+YezDOkpfvkeBWycxujNpUEhyagl7eSLdKVTfEBD1Dn
 KH84lfQRyxA3uNLrLiwKUtTqscI57VydcmSZJdCMtOV/fUvg
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Current way of programming of the UBWC-related registers has been
inherited from vendor's drivers. The ubwc_static was supposed to contain
raw data to be programmed to the hardware, but was later repurposed to
define of the bits. As it can be seen by the commit 3e30296b374a
("drm/msm: fix the highest_bank_bit for sc7180") sometimes this data
gets out of sync.

Rework existing msm_mdss_setup_ubwc_dec_NN() functions to be closer to
the actual hardware bit definitions. Drop the ubwc_static field.

Unfortunately this also introduces several "unknown" bits, for which we
do not document the actual purpose. Hopefully comparing this data with
the more documented Adreno UBWC feature bits will provide information
about the meaning of those bits.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      drm/msm: move MDSS registers to separate header file
      drm/msm/mdss: use register definitions instead of hand-coding them
      drm/msm/mdss: define bitfields for the UBWC_STATIC register
      drm/msm/mdss: reuse defined bitfields for UBWC 2.0

 drivers/gpu/drm/msm/Makefile                   |  1 +
 drivers/gpu/drm/msm/msm_mdss.c                 | 86 ++++++++++++++------------
 drivers/gpu/drm/msm/msm_mdss.h                 |  4 +-
 drivers/gpu/drm/msm/registers/display/mdp5.xml | 16 -----
 drivers/gpu/drm/msm/registers/display/mdss.xml | 38 ++++++++++++
 5 files changed, 89 insertions(+), 56 deletions(-)
---
base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
change-id: 20240921-msm-mdss-ubwc-105589e05f35

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


