Return-Path: <linux-kernel+bounces-556785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B12A5CEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0944C7AC932
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B7E264A7D;
	Tue, 11 Mar 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNSUyQ2O"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058C264A6E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719742; cv=none; b=QxitYXZ8uz+J5Gl9fdISaqvlnOZpb/UQi9GiLXGISqknOTtmIHTYa+iwdgfvDqHlOxRa7kszuYF07hrIencV7pR8i/9sTpAVxM3y8Tsez399FF3gwHxvQxnHLcnD6JEXtX78cvcvNiZ9xXbQwe77hjpAuGzEDNDpVO8aSHOEtJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719742; c=relaxed/simple;
	bh=jc3n0i1vXKx1+JIl89FqEB6tXU+MLI2NmDag34yasGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=THRUtI7LLHNXuhOSsgBTE37EY+fKMUrkt3uFlraPNlLEo9w2CCTnEm3uUpWI0HgPHGYCXWH9zWHzGEsIqGxthok0tMtUZjtC3PoOgfEY+mD1U/211/q8gjdeAUy4xTXXH07llumYQu9YQ2bWO4sw0CRwwBq0FZPSKNvSTvI+aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YNSUyQ2O; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391295490c8so351675f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719739; x=1742324539; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSC0gS+NrwfsmC47kkGNX38UoKPMT1JGdxUOUzGrzgM=;
        b=YNSUyQ2O7B8Xb9We460KBMZPq4s2UMRGMc0I0CEpvbEzrpqeBn6vfIKWnGF0bmLF9G
         fDxd1RtQSHeOPb/Mom/Jmihq1WQeVyHON5RfkeOYcE2F9BFZgoI0OVuRvU7utWSFOUdZ
         Wa+HMpHDgu62hCakcSWoB1tXM9zQeVjrNtIS4JB4WZK0PbeyYUtM8aE076r+Z+YXNnNS
         n5nwLP+rJ1DNY1TZPjKoF9reP0ts2wODSztb1/5CdnYEROCr6q0FXCejnHgIeiFVjBFA
         px4K1e4jnw3AovLWLcAyKgpVNQ3cxe5rpDhSL9mhjgJrdE9iQQK70gbefbu12KU41f36
         oOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719739; x=1742324539;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSC0gS+NrwfsmC47kkGNX38UoKPMT1JGdxUOUzGrzgM=;
        b=IP3RpfDuDwNJN7JaoQTSmrtUyjas/h6hwmqyadNuuV9xHElLHj+Y0BjdPiUtLg3Bk0
         mlvUUS3eDog3+OqPsE0ENH/4KpXfjUV12V5k/6FrytUDrAqOIqTleRcWYJ1a1DkBm22k
         l9TDGrRFqOJi6zJZVmm7w2Zv1vhf7vAkmVHVX0CAh8PvExOfzZ1wV0jL0Z4fOLMRe/U9
         ks6b60NIAuGzYgIWe+rAV3k6TmWTkKLkgkEroXwnoArreUXhxkMGNSE654Ya1HMEbtdz
         J6wIYsonrgZTDCTneezvz7+ekzowEhiqSRDbwlUEQh3e8w+8/MAS7pDhYvHy3j+/fvsU
         ZAxA==
X-Forwarded-Encrypted: i=1; AJvYcCXvOk1eERB62TrOuAiekCeHA+YvUHwSRRSgtJcONc0JN8INXaqrC3V0Xl766yjMvzVc00hgLVKSfgNSK50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOndRLxaFOB/wdu84c0pxJyw8YqyE4Qa+xxJfYD5YvRFXjRC9M
	CNekwS71owyQFL+INGR4Yv/e9WEjumxJMyfvJ5ZsHI6gaWRln4hqXerffe/DOsE=
X-Gm-Gg: ASbGnctQpCAB5/ecAwfk7J14bx+9zWu/P4gcON4Drlrw9fuIjgojA+ntcbzQBXKVAXJ
	6rh/wQtZwZqhER11CS1CRUuAQhEF/46rFTDsBPE0Y46QngMxwricyk+0MlmwFlBbmmPtVxdtiZB
	G5hYGOrrBPRtxRB0Ebv/T1LHlBYGLhIiOSTrXn9m/xxV5BtzEgvOPRqWTTu9mTzq4GMA3W8Od0R
	5wunViG51AlAck/maZ5bX7yn9tMXrWEZuydkP+ZhnzqnX23CiBBefgET0mzxFxmbExKxNuQNxgu
	3Hd0r35fxfSexfeYRPxHEI3b39GXKFpnwIK4wIuLmByWvNmxJY+F6TbK/L0=
X-Google-Smtp-Source: AGHT+IFYrUoqvLPzbgL0a6R1c4IH1BBJw/9NVQaDwgWi3ogRXxdqNgEPTM53uC76gYTIHTu9smfshQ==
X-Received: by 2002:a05:6000:1f84:b0:391:cd7:82f2 with SMTP id ffacd0b85a97d-392640c53fcmr1919995f8f.6.1741719737569;
        Tue, 11 Mar 2025 12:02:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 00/19] drm/msm: Add support for SM8750
Date: Tue, 11 Mar 2025 20:01:50 +0100
Message-Id: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ6I0GcC/33NTQ6CMBCG4auQrq3p9IeKK+9hXAy0hSYIpDVEQ
 ri7hY0aicv3S+aZmUQbvI3knM0k2NFH33cp5CEjVYNdbak3qQlnXDFgBS0ljfeTVowaH4cWJ5p
 bVEJrJdEBSXdDsM4/N/N6S934+OjDtL0YYV3/aSNQRkvhQDl0sir0pfUdhv7Yh5qs3MjfBAe9R
 /BEGM7AVMZgjvKHEB8Ehz1CJEJYLFQJuWAWv4hlWV6EDF30OQEAAA==
X-Change-ID: 20250109-b4-sm8750-display-6ea537754af1
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5247;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jc3n0i1vXKx1+JIl89FqEB6tXU+MLI2NmDag34yasGQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0IihJ+Fd9HD9/CtRJx7OUsuxzbjJWY8wnZT3C
 Txn2woLQqmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIoQAKCRDBN2bmhouD
 1zI2D/4g3QYZC1eqCZy7oFPz1QdFmOkhAkhE51YG+xXsiZ4NCrCQABPqCsvqoY5Z/yUkEkuGrhg
 lPKHkl2jFu+YiHtBd+m1Nj90x1O091Rd8arqUHuQtDVoi3lkewimyY5jqZdy0v2GVxLHhZXf9RE
 vqeqVda70U/Pb5GdJWykcUMSJv93tUYap+m3vWz9r3yyYwIflUhUcVReHFc76FtThmAGZkP+npN
 V1YGg2SUbVFoZ17dzt/7QnOTOpMUMiM0fd6XUGTo3OrEBunMVS0AtGJM8A5xrqM/PAmc9wMjGtI
 txRAGgepu+yZYKGZrqrfQW+nPn1xRWX/4Dk4+NSJfQJEYvzFhw6dcgLAhqatsvQ/KDcDDl5slgr
 za7IUu0BmcXEM7JrLfxTGsmCo5t+4XoyrXxsuhJgdm77yZm4L6NXWGd1zTLZZ8GAZ813UDZOJfw
 zdjLyiCSqne/I9RXBAZ9xKFDevqUkcdpR6MGl6ZY+D0BUjLmiaVl/vEmC1EvfRH2ThAVbAFCQGd
 9kQkoPCVPd8aL+v179jiCX72CB/flxhnzhbdgjYICyekGbJ9R6shAl+WAc/eIhO1+vlgSp+7Ps8
 YnIGG3WBERQL9Mu100e/d69cxwqlyxFJjVDrnZKyuxBPlge1q8nf9h73CDD7Zkrvi9CbnQsHFFn
 HF+ti8LqLCrgVFg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Dependency / Rabased on top of
==============================
https://lore.kernel.org/all/20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org/

Merging
=======
DSI pieces here might not be ready - I got modetest writeback working,
but DSI panel on MTP8750 still shows darkness.  Therefore we discussed
that DPU/catalog things could be applied first.

Changes in v4
=============
- Add ack/rb tags
- Implement Dmitry's feedback (lower-case hex, indentation, pass
  mdss_ver instead of ctl), patches:
  drm/msm/dpu: Implement 10-bit color alpha for v12.0 DPU
  drm/msm/dpu: Implement CTL_PIPE_ACTIVE for v12.0 DPU

- Rebase on latest next
- Drop applied two first patches
- Link to v3: https://lore.kernel.org/r/20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org

Changes in v3
=============
- Add ack/rb tags
- #5: dt-bindings: display/msm: dp-controller: Add SM8750:
  Extend commit msg

- #7: dt-bindings: display/msm: qcom,sm8750-mdss: Add SM8750:
  - Properly described interconnects
  - Use only one compatible and contains for the sub-blocks (Rob)

- #12: drm/msm/dsi: Add support for SM8750:
  Drop 'struct msm_dsi_config sm8750_dsi_cfg' and use sm8650 one.
- drm/msm/dpu: Implement new v12.0 DPU differences
  Split into several patches
- Link to v2: https://lore.kernel.org/r/20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org

Changes in v2
=============
- Implement LM crossbar, 10-bit alpha and active layer changes:
  New patch: drm/msm/dpu: Implement new v12.0 DPU differences
- New patch: drm/msm/dpu: Add missing "fetch" name to set_active_pipes()
- Add CDM
- Split some DPU patch pieces into separate patches:
  drm/msm/dpu: Drop useless comments
  drm/msm/dpu: Add LM_7, DSC_[67], PP_[67] and MERGE_3D_5
  drm/msm/dpu: Add handling of LM_6 and LM_7 bits in pending flush mask
- Split DSI and DSI PHY patches
- Mention CLK_OPS_PARENT_ENABLE in DSI commit
- Mention DSI PHY PLL work:
  https://patchwork.freedesktop.org/patch/542000/?series=119177&rev=1
- DPU: Drop SSPP_VIG4 comments
- DPU: Add CDM
- Link to v1: https://lore.kernel.org/r/20250109-b4-sm8750-display-v1-0-b3f15faf4c97@linaro.org

Best regards,
Krzysztof

---
Krzysztof Kozlowski (19):
      dt-bindings: display/msm: dsi-phy-7nm: Add SM8750
      dt-bindings: display/msm: dsi-controller-main: Add SM8750
      dt-bindings: display/msm: dp-controller: Add SM8750
      dt-bindings: display/msm: qcom,sm8650-dpu: Add SM8750
      dt-bindings: display/msm: qcom,sm8750-mdss: Add SM8750
      drm/msm/dpu: Add missing "fetch" name to set_active_pipes()
      drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE on mixer reset
      drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE on ctl_path reset
      drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE before blend setup
      drm/msm/dpu: Drop useless comments
      drm/msm/dpu: Add LM_7, DSC_[67], PP_[67] and MERGE_3D_5
      drm/msm/dpu: Add handling of LM_6 and LM_7 bits in pending flush mask
      drm/msm/dsi/phy: Add support for SM8750
      drm/msm/dsi: Add support for SM8750
      drm/msm/dpu: Add support for SM8750
      drm/msm/dpu: Implement 10-bit color alpha for v12.0 DPU
      drm/msm/dpu: Implement CTL_PIPE_ACTIVE for v12.0 DPU
      drm/msm/dpu: Implement LM crossbar for v12.0 DPU
      drm/msm/mdss: Add support for SM8750

 .../bindings/display/msm/dp-controller.yaml        |   4 +
 .../bindings/display/msm/dsi-controller-main.yaml  |  54 ++-
 .../bindings/display/msm/dsi-phy-7nm.yaml          |   1 +
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   1 +
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     | 470 +++++++++++++++++++
 .../drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h    | 496 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  58 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  12 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  35 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  71 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  19 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          | 210 ++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h          |  18 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dsi/dsi.h                      |   2 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |  14 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  80 ++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  79 +++-
 drivers/gpu/drm/msm/msm_mdss.c                     |  33 ++
 drivers/gpu/drm/msm/msm_mdss.h                     |   1 +
 .../gpu/drm/msm/registers/display/dsi_phy_7nm.xml  |  14 +
 26 files changed, 1643 insertions(+), 41 deletions(-)
---
base-commit: 3772cd6a20f716117ce666721c9f083c4e6ebbd4
change-id: 20250109-b4-sm8750-display-6ea537754af1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


