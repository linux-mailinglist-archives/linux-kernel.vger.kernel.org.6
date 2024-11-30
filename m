Return-Path: <linux-kernel+bounces-426075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB7A9DEE85
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FDCB226E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095E7080B;
	Sat, 30 Nov 2024 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zo4d0zrP"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3F1F5F6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931725; cv=none; b=dDzYDxhOWRzEfWHPOOb2KmMWDwc8KNLIC7EeQYyEVo1n/nRtreYgRBK9kG7Pe8Ybtlgy7TAbQ6RCAZqvxQcwI8mnSeT9h+a1+TMpl9NJAo5iz24z1TvnjK4kU6CoCpYXhNq0Nv1g8CipH6UiVahTtdYGuveQxcGy2z9LoPFKyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931725; c=relaxed/simple;
	bh=xq6nGgVJ3hLPGwL0aMu+xi3aav9I/mBH+GZszTQ9WpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bbnsONi91id2+LzBPUeo81KomtyVsA8ti2ph9zaUAHysnXvEfFCvkD6gHRZN+o+096Wg8/8bfI7I4GTVFjeS/zVCE10ADEhZT2tUyoPGE/whaM082VIrfw/MWduz+eCN88BQyPjdui7ELzsVHOfg57ABw3ezPR5+uLLAv4bdBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zo4d0zrP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df1d1b726so2910571e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931722; x=1733536522; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxZss+jNi0+17IT96EOP8YI8ZZP9Ocvt1i9TZYayBN4=;
        b=Zo4d0zrPD/iXdoiM6ceczhwudv5AL+lMz7N6QzrZ6HaAh68VrfjZg+iqvZTJImcTiw
         xx5dRDa83UALpfqKRc7Gahef5uQN2ajOM+uXR4zpO+ay8BcvfhqniCZt1UfRq8BWqAku
         V5IJ1icQ5XNM4HmnYW/4U4hj5kvrE0wKInO2QvFhbFPp66OcGLiuwHO0jvVkIR+NV8DC
         TxwVoWkqSwpF0MyR2cDdQrFsuUsbnXTyQGM1bsHy9ifHcEIYlaprzeG+QQCIB9BhaO4/
         0eyM8+qGVp3lRZrxn19yRCK6sTX4QcFh+pUEn6JBTypcLMkIFan33C3/RjNNQA5OKs9F
         bDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931722; x=1733536522;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxZss+jNi0+17IT96EOP8YI8ZZP9Ocvt1i9TZYayBN4=;
        b=Kgg5RD+HEOpSuih7RM59Momr4ImcMBix5iwG9oXZVtmwRS+fP/YthbFmzI4DUEaG6H
         7bKPpPCuCFPJciZoCB1e3Jq12NRnxklzQ0KZR7eUkayabUMhDYbGhKRKPsIeqYeApXNE
         M0Iwa+dQE89hyDhAU4zI3o0gY2edCWaTR75av3I4rVh74fRG/73yCTlfztZB1aEeemTY
         GV8MWbBYUQFyol1jrhmtR3o1ajBo/J8qMWkksxq1CCf0r0MY/TSWD+FVM9ebGOI5BvIp
         7E5epOB7CMRQMKmfrdBNNrONcJjl6YGuB7BTSPxpa0to6Oe+nWwn30H9aXjbydklfmBw
         H8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWus7TA6nKyo5bh5M3EM+NZpWatjMDL+gfsESgXql+yDh8RppZUVtnypfHpRswZbSjzjlGonmhKkdsUbPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6d/LQ/QlnfJlWmziKVIWP+OUq3h3lzadQw2vsx38goscKTEZ
	qaF9ccYfprAzTEsUvoN/3LaimP6oME9rjdDaoNxI4syZpNRovINH7BDxYTw+Knk=
X-Gm-Gg: ASbGncusOOVwZqm5z5+vmYSgAIgU+DZMKH8wTlo9ek+uevYICKEpr0G7R360HSyinS2
	BbkFIl/n4oglRKmHMR4hszbvZ7tmZlCqlyAhJCSBTzoNpd9qvNXm9mc4hT+pCkE7GhY3UblDdOq
	34RMV4YIpLfi3+vYV21ZDycFzbFBvrBDVf/hsHRoL8MWZP1pm0bYt1lgfCwk7CZHZMw3MCDBbuP
	/xMqksarT2XnxYcDh4iOrrZMyOsOqlu7K3bwxiMIpvJRsDMWtKWfqK/+A==
X-Google-Smtp-Source: AGHT+IG+JLl7qsTn5FPckMQo1MLbci5ofQR5z1K3kw4R71u9Gt/sDVozi/MWvxfjcUJ7gUZrvI5UJA==
X-Received: by 2002:a05:6512:3ba5:b0:535:82eb:21d1 with SMTP id 2adb3069b0e04-53df01178e6mr9267268e87.57.1732931721924;
        Fri, 29 Nov 2024 17:55:21 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6430cc8sm635601e87.31.2024.11.29.17.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:55:20 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 0/3] drm/msm/dpu: support virtual wide planes
Date: Sat, 30 Nov 2024 03:55:16 +0200
Message-Id: <20241130-dpu-virtual-wide-v7-0-991053fcf63c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIRwSmcC/23Oy27DIBCF4VeJWHesgRhcsup7VFlAwPGoiYkGh
 9SK/O7FkXpTuzyL8+m/ixyZYha7zV1wLJQpjXV0TxtxGNx4jEChbqFQtWiUgXC5QiGeru4ENwo
 RfIy971rjLKKotwvHnt4f5Ou+7p7TGaaBo/uGtrJFRCVNs7VKtxYkhDNNPDfe8ZyHt1ReTjQ6T
 k3i46oOlKfE86Oz6NX+TOr+JhUNCLpmWTx4/+zjT2xtKuZLkKj0P4KpQs3EPmhpO6N/CcuyfAB
 N77ToOQEAAA==
X-Change-ID: 20240626-dpu-virtual-wide-beefb746a900
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3719;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xq6nGgVJ3hLPGwL0aMu+xi3aav9I/mBH+GZszTQ9WpE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSnCGGhtClVK8P7SVPfk6TR+BwydRYmpK+MNCT
 1EPzizAxCGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pwhgAKCRCLPIo+Aiko
 1TdiB/oDPfpCFH3TWfmYxUxcbPx8VG89rmv+4cnUNOLUXsd7CWDgKZXPvMUNvO3GeTGESIB0y0c
 JU9Jm7jHO1/zlnyb4FjX3+rsypwu/MVvGyqN3hlKZeGYh62+jviIFz8IoksgWLlYugkGVoP2gdu
 kAF3ywaZegLPTNr2wo6ZqBBHWYpk74YSFJU3fVNQ2hyF2l3s5yAIrUrsSm9r8GeT1OYiRWes2LV
 jrwX05yh0tZUtHvhtFkLjFNzv6UvxTi1veBli+ecA6px6ecsVcNbVdJ7RkcZU9BkkSJ8xW2RppI
 bYFSBAE5wgi5NZbngCb9DcUsu6hNDZRlA6cR9XyPDLBH2sjz
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


