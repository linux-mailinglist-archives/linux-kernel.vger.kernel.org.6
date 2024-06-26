Return-Path: <linux-kernel+bounces-231553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628029199EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096882827E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E76194085;
	Wed, 26 Jun 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6m1WJhM"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A796180A7C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438366; cv=none; b=H7wcGK9v0D3gTnEpiNqefcJTJwwPdbWynA2Z0qp35SCh9AFFb7sW1jJ2SpVwn+enXRJf+KTty9v7zNL2N+5p9DVRps1NCSF3uqYSaNZXBcfqxkgfEC0lFavEOCz0hs1uYMc6XHPqcAyaOGcQ5aONmEl3fnJ2kn5CvOPwE2EJ/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438366; c=relaxed/simple;
	bh=qJ1GEziPu7S8OI1OCbOkdnos7rw3FO0P0DsB9fp+pKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dF2+wa24pe8scZ8KvdxvtAcJP3sVcDbTysMimdyw+vOWd9xpHxpdspSLWh3n7g74Ti+KQyObJ/PM9MohxajgS44OlnsiLiPWm2lUwv4QFFBw8ksfCRRz1QMt7Uyye8/bZ8i3WgynftIz/O5wO+rveba0v1uW0e2gUWAEHpQfMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U6m1WJhM; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso58683951fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719438363; x=1720043163; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSG3AAcIbmONfpePJ3GBLSDEosIWhd8mjxtqUsWpmL0=;
        b=U6m1WJhMysY0U+5UazicsER/DNSkVWUEqVI9yKSUdTg/d5F8LVEzMvp5JqhucesCKV
         1QxIlHDQLmDABpt/VFmMdvMYJoWjdThqnF4vJM1UkTFSvRi1Z2X86d6OZn4wX655namw
         Y+jSxLWfi2VbmSuXIVTaMz5wssUexPC1P0li9+JuE/jJ4E5MyI0oLA7mywJpF0PMxmQq
         4bQbaoqW7dsygPP8dh9TiqKtiEEcm7gF82HBwx4Q7BoPmTy+vznB9eqQp1AfEQyw5Ynk
         2dvEGOLCDp4xayepB6eBrYfsy1SrVZSH5f2BjebwdkoSp+9CZZnOzZ+vbatUh8VP9gmJ
         tzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719438363; x=1720043163;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSG3AAcIbmONfpePJ3GBLSDEosIWhd8mjxtqUsWpmL0=;
        b=Su0jqDUpLpGQQI0I0NhK70GotU5W2sTrpeAdQvxRtsdRJjFFsP7L/Dy7+5PxlDJSJk
         s16SxP9l523j0HvcVkHrWw0jm4movIA6PvH7a9DpnTGgt9P7Ry6OEpcB5m7Dn+mRNMTE
         st1p6dOtHrAfarUgeXSa6+RypUNO+55UYZFrQDxI/e1wbcaPjy8s7jll61uDNDeGtCam
         +HjldE02qIXzZAPRubhdE7LbQ4GSO41xFs8k7MzAxmQ+9g9Y+zugAM6Vwy1UQgedlnTv
         lB8hWBF0dNvghs1xEMUSO7myWftOCsWCJ7GlfCRoDJx7E6dfIZxVx3nGGNu5/fKayBkm
         Yubw==
X-Forwarded-Encrypted: i=1; AJvYcCXV8HPEJENAcsvquLRpOPtP5TJ2U0Sx1x+5QyLMAnx6V0Spax4qHvg3PspL8Heip/cyEIMR8kmttC4yvgUe/ZfjmfzM0xY9iCfElp76
X-Gm-Message-State: AOJu0YwoLR0fHB+jH/MptfxbCZqD8zfSUM9N4yZ7RAliGJiwE5mIK2hf
	W5aUVwGdbauXCzro9MDUmGXgaq4Lauj8ubLA670Gjnw2pZIFXBM9vOooIP2NzVw=
X-Google-Smtp-Source: AGHT+IGRVUcK2vgQ7z3lRceQ7EQseMWvpFfYSJ61KqlG+Np2uVeFvoj0JA7iyvcvwWsVy3+jCCiZUg==
X-Received: by 2002:a2e:7a0a:0:b0:2ec:63f:fe91 with SMTP id 38308e7fff4ca-2ec5b357921mr84428191fa.38.1719438362757;
        Wed, 26 Jun 2024 14:46:02 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a350d96sm23201fa.49.2024.06.26.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 14:46:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 00/12] drm/msm/dpu: support virtual wide planes
Date: Thu, 27 Jun 2024 00:45:54 +0300
Message-Id: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKMfGYC/0XMQQ6CMBBA0auQWTuklFKDK+9hXBQ7wESkZAooI
 dzdxo3Lt/h/h0jCFOGS7SC0cuQwJlSnDB69GztC9smglTbKaot+WnBlmRc34Js9YUPUNmdjXa0
 UpGwSavnzW97uya2EF869kPuPysIopXRh87LWlamxQP/iWba8cbLF/hnW68Cjk5AH6eA4vqYjv
 7CoAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qJ1GEziPu7S8OI1OCbOkdnos7rw3FO0P0DsB9fp+pKo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1pNjzhr8J0G/nL/aHemuNOvPF4tTNWfsmLrk9NsQjuYs
 zY8bDXsZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBExMLY//vXKSRd4u9x9Y/g
 ztK7at4qcz83pff7tDlXBJ9bVb8t2+LgkRZ4nvF1KVP09jsBkQeLjI6eabd1Sjp4TEi2YKPMxfp
 9Cw41FN+PK569L0f68OeCVNdnO9WetQgz/HVM3zJ5/Z3QvOknNCwT1nHE8vJPs7gf23li9ZwsfU
 OzWuWIUotJFu6r5fKbfzwWL1/6acmJ4/cNlbYv+mKdayTlMFFDwYnhokv13TqNhzrhCXOOp/F4d
 JVfzg+uYSq99/Ci1o19u31n31MIbppU2OQkKHjxAt+JqRbLml8WnNjccZQvLMQ91O9GzvE/DicP
 /F3a3choU/fiyf2II1Y+k6K/Ku2rvr20+NjUoH+R6ay2AA==
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

[1] https://patchwork.freedesktop.org/series/99909/

To: Rob Clark <robdclark@gmail.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

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
Dmitry Baryshkov (12):
      drm/msm/dpu: limit QCM2290 to RGB formats only
      drm/msm/dpu: relax YUV requirements
      drm/msm/dpu: take plane rotation into account for wide planes
      drm/msm/dpu: use drm_rect_fp_to_int()
      drm/msm/dpu: move pstate->pipe initialization to dpu_plane_atomic_check
      drm/msm/dpu: drop virt_formats from SSPP subblock configuration
      drm/msm/dpu: move scaling limitations out of the hw_catalog
      drm/msm/dpu: split dpu_plane_atomic_check()
      drm/msm/dpu: move rot90 checking to dpu_plane_atomic_check_pipe()
      drm/msm/dpu: add support for virtual planes
      drm/msm/dpu: allow using two SSPP blocks for a single plane
      drm/msm/dpu: include SSPP allocation state into the dumped state

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  50 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  24 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |   8 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h        |   4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c      | 539 ++++++++++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h      |  18 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c         |  84 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h         |  27 ++
 10 files changed, 621 insertions(+), 145 deletions(-)
---
base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
change-id: 20240626-dpu-virtual-wide-beefb746a900

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


