Return-Path: <linux-kernel+bounces-423549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5169DA996
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61891B2172D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433141FCFDC;
	Wed, 27 Nov 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeJ7zgsr"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A071FBE84
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716287; cv=none; b=lFXgpkwBpaqsGCz5aqtvA4Z7Pk9MEp/XwXsOqtJGRxYP+YR+FrApslayPjzf1XQkb1lt0srHYpHkHakwGxLXpk8m9GyjnARdp1pOvBJ+F3KL+VLaxZ7kTsHEcSvN8cEiTlxIj2XOG+PKwbDk0ScsngWHMtnbQqG8qO4lrxzKv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716287; c=relaxed/simple;
	bh=Awfx1uj7GWmNyTbncLyYqj3YeiEUQM92uIC4PxSF4K4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bn/vghNxgL7tQdiSKWTKd5lzTepK2xq1+OMcCHdQxeIeJbc5X6lMci1Ow8beMdyU8GyAbnQuWohHYvyPIzvbf+vcqwhC3wJG4M0otJQjTku5YF8EHvkjZa+xD/TNXv6Ngj5OFKAtpOruCJ6pc2sQqfY7uyJDEm3N7xo2x/bpQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeJ7zgsr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de852a287so2377915e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732716284; x=1733321084; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4Ts7aUIWizov/NLYuaDxwP3nX1iyB8pequrCUYPZSs=;
        b=VeJ7zgsr13DWRnFVcNLnAak+avFh0r5qZaOkOGII0gOjeBPILHwSBaLrrnGQnsGyfr
         nif8h1AULYwCEWZ38HInActxhA+2S+Gdvl0EArYnZIOBro2OhxN1g1pzOM8le5CAT0P+
         lYb2VJkAQr2hJ6m59sHHlCHTFFEpxkzOmz1sIsN+HQQ3QUP2nCxJOrCr5pHb9yrxYPcR
         59ooqk6JVE8mowGMsniChA7LKq5RKq4gN4ubZwug0Mkq7ihF3ArB1ci6RyUmz4YIn0Mp
         QCfhioCBe46u65qYmsg8jD1McGuqGI1rygn0Q2NEGvxzh7sakyWzo2zE1C/J9Wm5+YnK
         WznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716284; x=1733321084;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4Ts7aUIWizov/NLYuaDxwP3nX1iyB8pequrCUYPZSs=;
        b=OaqxACU553b2f9Hn/3K2GJkQzgYb8yMv9VRQc7hYq/PvEafcex1ucJaGmF0UDb0125
         GqGP33FbTccL9TeLgetP9ofp5G6LhEuNydbym4JG2J8O21PXM8+mkbYNTYtzE985Vwmn
         34kLzAPldcU2y17oTtqGejFtKCFXsoAi3i+dzpi+CUT/6IP2A3fV+9CqoS3uCMlfsgmy
         WWUIzpD8GUyrBvwRhwSpgKsArF14LgZpxiM7fMeJoIFzwDwi5wpkNKgojBl4nZqmcYxm
         O0oIiN1moofiUkfnXfcl3KrMREJimTPK0UvYGZ0bBL/McF8lphjFDiRJiiF0F02w4v2s
         JgPw==
X-Gm-Message-State: AOJu0YzCGbTf89/YhMxIWUClOrnL5vHwH2V4fVDYF2lJJlPs4q5hZQZI
	0bntoO4RrqWbP+M1zSgKcjcSzWP5FV8rkyKbmsJwNt46FYBcrWjNcovrOlgUJtNb7Eb7r2PKm+x
	h
X-Gm-Gg: ASbGncvheau7ORTmsor2UUp+m0PuAnuoisWtq724+muQShJlxB1PZgSXT+/dsTphnNk
	SelF4HsXCN7fWKtpORS75AkF+Wk6yIiApWFkQk1/ptkQe5g93AINKqdAZYcytJc/KisX0CFcpUQ
	xlhLZhSehn46dKD311o712skcO3MnrIlAxodEO29WJmbbnvBh1T2iuq+6PYBpRbo+8xv4FoGPtn
	IXt6DJX+M98Llp4PmFdz+Yd/q4pAdjk1S2YASm4P+q0iA+cBOnpzb1fpg==
X-Google-Smtp-Source: AGHT+IGKW7mqkMGNSg9jVL3UeUo9m2hpnWRcx4+XgEbh8rHW/MWq3FNhz3Cl3UMtUlWPz/sntopdTA==
X-Received: by 2002:a05:6512:3d0f:b0:53d:ab0d:b9f9 with SMTP id 2adb3069b0e04-53df00d3e42mr812209e87.23.1732716276835;
        Wed, 27 Nov 2024 06:04:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd44cb7c5sm2157291e87.122.2024.11.27.06.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:04:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/3] drm/msm/mdss: rework UBWC registers programming
Date: Wed, 27 Nov 2024 16:04:31 +0200
Message-Id: <20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO8mR2cC/3XMSwrCMBSF4a2UjI3k5iHGkfsQB21y0wZsI4lGp
 WTvph0ICg7Pge+fScLoMZFDM5OI2ScfpjrEpiFmaKceqbd1E864ZJoDHdNIR5sSvXcPQ4Eptdf
 IlBOKVHON6Pxz7Z3OdQ8+3UJ8rfkMy/uvlIEyKgGscYJpy9Tx4qc2hm2IPVlSmX84ABe/nK9cS
 NmZHTptvngp5Q1c7rZL6gAAAA==
X-Change-ID: 20240921-msm-mdss-ubwc-105589e05f35
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Connor Abbott <cwabbott0@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Awfx1uj7GWmNyTbncLyYqj3YeiEUQM92uIC4PxSF4K4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnRybyTdBGPMzM2WIyfuTcNhdMbTAUb/2tvctHL
 Jam+Z4nmBKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0cm8gAKCRCLPIo+Aiko
 1Rx5B/9lunJDTciQmLjaJcsjsjKWM5jxx+FakpMngARXvBBZo4b2ntmIWJbBk00P6yfPhJjWkCk
 +S6QuYEw52Blfvsi7T5rFVqVeZ+2YcxiI8PDutT75UtGvfubgbXvOWxvGlDALnPw0NzzkLY/xs8
 KEf1p15baAKO19G1vZz97uQa+lMFNvRuHAur0PaAA6pMh/R48B9WfbziqlSltAgd5QYkDWf2fTo
 4foNKhePqDMVnwobTAUrSinMNNUBpK+y6krSYAfO2Mbds0An0Cc1NJYYF/MNz7jqzouSE/SCIvv
 7ATxElK5TwgWRF1qufGQ4yUxwkJcdl80acOpx3DgCUhwAUte
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
Changes in v3:
- Changed UBWC_MIN_ACC_LEN to be two-bit field (Abhinav)
- Link to v2: https://lore.kernel.org/r/20241123-msm-mdss-ubwc-v2-0-41344bc6ef9c@linaro.org

Changes in v2:
- Dropped applied patches
- Added defines for UBWC_AMSBC, UBWC_MIN_ACC_LEN and UBWC_BANK_SPREAD
  and .ubwc_bank_spread flag in struct msm_mdss_data (kudos to Abhinav
  for helping to handle this on Qualcomm side)
- Changed msm_mdss_data to use true/false to set macrotile_mode
- Link to v1: https://lore.kernel.org/r/20240921-msm-mdss-ubwc-v1-0-411dcf309d05@linaro.org

---
Dmitry Baryshkov (3):
      drm/msm/mdss: define bitfields for the UBWC_STATIC register
      drm/msm/mdss: reuse defined bitfields for UBWC 2.0
      drm/msm/mdss: use boolean values for macrotile_mode

 drivers/gpu/drm/msm/msm_mdss.c                 | 71 ++++++++++++++++----------
 drivers/gpu/drm/msm/msm_mdss.h                 |  4 +-
 drivers/gpu/drm/msm/registers/display/mdss.xml | 11 +++-
 3 files changed, 55 insertions(+), 31 deletions(-)
---
base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
change-id: 20240921-msm-mdss-ubwc-105589e05f35

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


