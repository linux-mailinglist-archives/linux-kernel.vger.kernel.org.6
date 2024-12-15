Return-Path: <linux-kernel+bounces-446394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50D9F23D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FDE164599
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13338187876;
	Sun, 15 Dec 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hu6CN6MN"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A0185B62
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266427; cv=none; b=heefpquHYad1N83+oXlfWJqtHwFo2qvrk2CLHD8Y0Rtr3ukAnssfRHvX5mIXTJkGklgUKT7fhQ9RhF/hZ1ddD0zTJtjMDiYrXHtBhLaanHcylOKx8SvchyIDzqQDjHGigmsaiZKTshCANFr05+ANAiv4XJogmZw0knrneVe6ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266427; c=relaxed/simple;
	bh=o3CAU1EODTzcKPocc/8+D8oMugooV1iRvnhbu/Q4A3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dencvZwidCq10adJxbr6vy1snxLR/01cC5BmnHM9OUI010h6H69fTf3HxY9k8EM5w93N0dAddfflpqkaoCELvMykp/nuoNR8hBZADAGicwaavsLZiSNKhJcMx8uJyvf1BwLUCMpwrSd11rszEvQOg6TBjH8Ch5pxLUZ6meAPdlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hu6CN6MN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df6322ea7so4547864e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734266422; x=1734871222; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0v+ql97l8D44LGjcV7SZRS15NuWmWYhnQwY5KtcOkq8=;
        b=hu6CN6MN6xCwV0I8kZqbSZGq7UoTqR3HccrFQGOceZa1AEkj1S/qM2XKsm7h+n7a0j
         HcZTky74es6bFu2jkjClkEsAxx/ME04KeAgUu3vsiju1XmwSC3NczmvUv4mqdOuKrZTh
         2N+M2MI5WohWhj2SQ8Mo4N6J0jQ//sfTnn/W6zvWvGBQ+vsrIHi0vxTpYNvAIwSeZaIt
         WOyUfibEpyvJkDyb/HR+Shy26PjXR0POOyaZ06A2aTaRQ5DJ6c5Zdp+Nn9m8PMfaptik
         j4TUKYn5LanHoOGDGYAEz2jeHqiDSkqOeEhdjO2fI2t4J2+ZtJnMtdLMrjjYcAURaiYa
         BAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734266422; x=1734871222;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v+ql97l8D44LGjcV7SZRS15NuWmWYhnQwY5KtcOkq8=;
        b=rgy2BeUoWLWQHFQRmYrrIT0+rOxTSXUoXEwv941SyVemV+A/JlBdDEcIIFBhspbR6X
         fVchlc0EQUTLZbxG8AeMRGbNReVznGD3kbcgAHD6gmMuLP6aQV/S65ZELeFNi1bzUuX4
         PDFEfCA4Jvx66CWCxcAC2+R7wslHa4ostl1yfzPQF/PDBJwuTouyQ9hpOcWsYCFm4OlF
         b0Ekzmm79fnPjlFhPXmbU3b22nt5J1nEgjF/pQoBDH3ATTQhnU0Nh8tDX+wmnnVn/GSV
         BihapTmVV5ZemztQp3jBNMZ32sBxMg+kYV+yQX1+WvVejBaI257Awx1c7bgU+1FkWJQe
         W9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDECoOiWFW48+DDArr1m1MAfePRuXVJ7QT4PtZVZL+52KkpI21JxRQC+szktZM0KSM3mdzaertrQCSecA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TOnFJgqq1qe3OnbO76M7DrKWHOgSpHMFIR48edXmV0FltZFh
	XkGh1KygnOCBxSxR+O6Mfku+UMrCJkUQ7QMisoJ1nPx7jbs4E8/kVMYic1ZWExwsFsdNX/j8vYk
	T
X-Gm-Gg: ASbGncvzs3EOWIY16nd1m0KJRl0l3fXe1iLCHPvavVff4+PdP2yBL9e2jEVQM/qeyH7
	ES7k4arXtFOEPjeijfQ1+DH/iOdcDGGqgJg4WvdH4xtCl0VTgNDoqi3TEelsVaXZ19kTifLlk3B
	TqMwI2oSHXFgtr5GjrKmmSWbWDQTmMZMiH44kAnn0h1X4xGSum4VvllWqSdGnp5eDqkVcxA7ARd
	AV3cyQ8PEagJErGQ8V58M07/T/kF3cqcFcPOpW+CUmH8F5EKoAO4xU9EDh5VOI7
X-Google-Smtp-Source: AGHT+IGW+6gJLxZY+Aax02ZMZPpaXkEE56Wt69IxPrHWrUaaSKL2/RkoKDbB3hhhE41N86vLyXBdRA==
X-Received: by 2002:a05:6512:6cb:b0:540:2160:1f79 with SMTP id 2adb3069b0e04-54099b69b26mr3212609e87.51.1734266422335;
        Sun, 15 Dec 2024 04:40:22 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13be2sm491481e87.195.2024.12.15.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 04:40:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v8 0/3] drm/msm/dpu: support virtual wide planes
Date: Sun, 15 Dec 2024 14:40:15 +0200
Message-Id: <20241215-dpu-virtual-wide-v8-0-65221f213ce1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/OXmcC/23O0W7CIBiG4VsxHI/mBwqIR7uPxQNowZJpMT8V1
 5je+6jJ5hY9/A6+J++NZI/RZ7Lb3Aj6EnNMYx3btw3pBjsePI193YQDb0FxRfvzhZaI08Ue6TX
 2njrvg9OtsgaA1NsZfYhfd/JjX3fAdKLTgN4+IMFaAOBMNcJw2RrKaH+KE86Nszjn4TOV92McL
 aYm4WFVh5inhPO9s8jV/knSz0lFUqCyZhnonNs6/xdbm4r6FRhw+UJQVaiZEHrJjFbySdAPgQl
 4IegqGMNAitAFJbp/wrIs38Eb0WB7AQAA
X-Change-ID: 20240626-dpu-virtual-wide-beefb746a900
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3900;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=o3CAU1EODTzcKPocc/8+D8oMugooV1iRvnhbu/Q4A3A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXs4znUjPnubBnxjQjArJ6OVPt2jb33UT1Y/v+
 in8RGD+WOmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ17OMwAKCRCLPIo+Aiko
 1cxYB/0fQEURTCrrdI1BswgvVa69d9grQ3HArczMwM8UTrv8gRsGLimIkwX0VDG6j+JEJxWV0fb
 YTlQ5fMlspASVWbwvtfml0HfML56jvQMd5wPtOvckP+/hs6I1rZmNOGlIj6rxqpR6Qh4jRbfZmQ
 BY6UB+fT9HzRoupLwxxcRs8TBRSubpR8ZtGs94VZ5Dv6vKvM/pl2n/KVKtttLstZr8znQPeDAoc
 BSBse4WL3GSqLyJ6zv5Y8T2AHrab646+Rv8lw1I+04N2TEEEBOZ7oeVB3vqSfvh2Hy4++Vmk0Zl
 Ma3h7iu7kmpM0nsZLxjRDok2cx6FcectR4Lh8N72jESCvWSZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As promised in the basic wide planes support ([1]) here comes a series
supporting 2*max_linewidth for all the planes.

Note: Unlike v1 and v2 this series finally includes support for
additional planes - having more planes than the number of SSPP blocks.

Note: this iteration features handling of rotation and reflection of the
wide plane. However rot90 is still not tested: it is enabled on sc7280
and it only supports UBWC (tiled) framebuffers, it was quite low on my
priority list.

IGT tests were manually exectuted at [2].

[1] https://patchwork.freedesktop.org/series/99909/
[2] https://gitlab.freedesktop.org/drm/msm/-/merge_requests/142/pipelines

---
Changes in v8:
- Fixed missing argument description in dpu_rm_release_all_sspp()
- Link to v7: https://lore.kernel.org/r/20241130-dpu-virtual-wide-v7-0-991053fcf63c@linaro.org

Changes in v7:
- Unify code between dpu_plane_atomic_check() and
  dpu_plane_virtual_assign_resources() (Abhinav)
- Link to v6: https://lore.kernel.org/r/20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org

Changes in v6:
- Renamed dpu_plane_atomic_check_nopipe() ->
  dpu_plane_atomic_check_nosspp() and dpu_plane_atomic_check_pipes() ->
  dpu_plane_atomic_check_sspp() (Abhinav)
- In dpu_rm_reserve_sspp() replaced hweight usage with explicit type
  allocation (Abhinav)
- In dpu_plane_atomic_check() set r_pipe->sspp (Jun Nie)
- In dpu_rm_reserve_sspp() check hw_sspp->ops.setup_scaler to rule out
  SSPP blocks with unsupported scaler blocks (RGB, QSEED2)
- Link to v5: https://lore.kernel.org/r/20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org

Changes in v5:
- Dropped extra dpu_kms instance from dpu_plane_atomic_check() (Abhinav)
- Use DRM_PLANE_NO_SCALING instead of (1 << 16) (Abhinav)
- Dropped excess returns documentation for dpu_rm_reserve_sspp() (Sui
  Jingfeng, Abhinav)
- best_weght -> best_weight (Abhinav)
- Moved drm_rect_width() call back to the the patch "split
  dpu_plane_atomic_check()" (Abhinav)
- Got rid of saved_fmt / saved dimensions (Abhinav)
- Expanded the commit message to describe SSPP allocation per CRTC id
  (Abhinav)
- Added comment on why the size change also causes resource reallocation
  (Abhinav)
- Dropeed several last "feature" patches, leaving only SSPP reallocation
  and using 2 SSPPs per plane for now. The rest will be submitted
  separately.

Changes since v3:
- Dropped the drm_atomic_helper_check_plane_noscale (Ville)
- Reworked the scaling factor according to global value and then check
  if SSPP has scaler_blk later on.
- Split drm_rect_fp_to_int from the rotation-related fix (Abhinav)

Changes since v2:
- Dropped the encoder-related parts, leave all resource allocation as is
  (Abhinav)
- Significantly reworked the SSPP allocation code
- Added debugging code to dump RM state in dri/N/state

Changes since v1:
- Fixed build error due to me missing one of fixups, it was left
  uncommitted.
- Implementated proper handling of wide plane rotation & reflection.

---
Dmitry Baryshkov (3):
      drm/msm/dpu: add support for virtual planes
      drm/msm/dpu: allow using two SSPP blocks for a single plane
      drm/msm/dpu: include SSPP allocation state into the dumped state

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  50 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c   |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h   |   4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 396 ++++++++++++++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h |  13 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c    |  89 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h    |  14 ++
 7 files changed, 498 insertions(+), 78 deletions(-)
---
base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
change-id: 20240626-dpu-virtual-wide-beefb746a900

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


