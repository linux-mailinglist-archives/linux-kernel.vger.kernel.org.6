Return-Path: <linux-kernel+bounces-525996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B65A3F864
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2FF3BF882
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A721129C;
	Fri, 21 Feb 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzsC9dmn"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF721129B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151493; cv=none; b=ajq8YCLGpt6E5EOavz4PZndsD2ePJT19CjuTc1A1nPmPk0EOAA+YAAETXLRMDsxwdfVZKD1DseCh9le82zw3AM7PecuBcMcFuiCM3TfA8jwM+bJwq7KN9hwA5rQanyLxNPCDeVTTrQOwptbjZIEzwyk5wr0Ny+rKlH04btk9nXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151493; c=relaxed/simple;
	bh=i5ri9ekSIIkKVxsR8eLTipN73T78Eiw6G+aO7XJu3cM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZPwiLg001ZWRtQJcwXN7KVqaDvuHJWKg8/l7yWMSQa1zfegvqs3XL3CqUc/Iqi/j9uZq8niubHR2ElP/LjYSKhcQJ0K7ygQoEZz5BUWzOQMfC4OmJ/obzE9foLo+jba8J3oyYoD2hOPdJjdN3WJ2SyFM5rdYQkpU9GXsL5apDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzsC9dmn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbb16a0565so32321266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151490; x=1740756290; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjw3owe+g82tMuYky0eC0Z5b8YUq4oE+S7asTRjT1vQ=;
        b=GzsC9dmnm+mXYNX37PXkk9izQc9IpekdUa/9ABeW2N9MB/ykkBqKJK/XN3hHjxhfoy
         pia8wgt1PkeiChSmQo1VFDuKyEXthVP87hxVkEIQuF3pacwEHNVphiczQYnVkjs05nDb
         v1UqFOan3kwxLTLqGXul2e8/rf13LZn2BYfTgwIgrIjt3Xv64pSRiZcf1Q7l5/kp7rqO
         TBI8n/cFPex/yi24lpsO1VbWQml6DVFoA2QV1pMBIMf0QNGlAbsWff5F6xUYpuCnTF+N
         uy0Zvr3GIFYOhkdKJp+pqlV1gupwfhYMX2InlfAr9ZBskR+5cPc1UUZe19JLKe0ySIiP
         T8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151490; x=1740756290;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjw3owe+g82tMuYky0eC0Z5b8YUq4oE+S7asTRjT1vQ=;
        b=hNQJAqg69sa0NxBzj3YgaHesrcNwGKighL+nDKNVnzxml8UdiAx3kgGaVIpUVtv5QY
         5IWjs5Rw3JmL/CQKwH+Cn8NftX+wwKokzic/e3nc2Ep6Ha/enzMqXRzC50VT71u0rkEd
         heR6MqeikNe/78qvvtW4c8CNYE6vhhEiqtAg3CloztrtT93HjKBH8xiXt9LGbcek1SKR
         UUWd0GrEFrW5juy+ETCxLWetAfhaKeBaNeSXelxDden3MZVf48IX6lSgEi9+bmbwIA70
         Hd2ud57nPMlT3uw44m9xpR2AaaKc6w8ocY44tqqocWE+PL8p21OEA0lTq2ihol43goyX
         bhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq6fLUzlVWIZ8+Kd/0t3YSHSBIci2RDJWXV5BGF+bCEO6thuaOYAdH3awXR/xuHG77L/tIY50JEivqhjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPPoPAWplYObL552AjypIHEE6GNDt9ox/Af+PMZp8nJWjyuLB
	jYAm798lCmDbEFj3cOxTxrbFKQkcnc9q1DsCRMHSdnA0ncdez62M6YWXJkJFQ1I=
X-Gm-Gg: ASbGncvaBsWxNQA2A6qvWu5eNC+76VBLA8kl0MjqmHLYzU8jf9BgP2gqt1wFMJge7f7
	QhcyD3atiin3QsXHunrfUyj/W+5tOiFPoDWH4VhuFb23D8CxPF4xOi6QnCcQPkrBmHxJ2QZF/s9
	2Jpf0FMM9PoBqVxo6APw1pk2EhnD7a7MBwU78l8GxZ2eeUEpNUgVJ8Ar4bRvq+c0FBYXe9ALJZj
	f541MNWL04jS0ajzA3Cp5J7+8VpJHfz0djUC0aRz+2CDjxtGTcyfun8t9HQldA1Lu4OCrUAT5jg
	manUwC6y6U+iRgfZutVbP9HC+g5Yl4LiK5EN6A5VnTdST+u3XtcqdwnifGvSQNOfEyOdk6Pgcqt
	V
X-Google-Smtp-Source: AGHT+IGXCIe+EFHyzaoM7U0Y6loffB3qhAExuxR0V1/JrX/SWeHYnZhv9Xq5ZXQeBdS0Q4AwCEt9hQ==
X-Received: by 2002:a17:907:9448:b0:ab7:d10b:e1f2 with SMTP id a640c23a62f3a-abc09c24983mr110312366b.12.1740151490054;
        Fri, 21 Feb 2025 07:24:50 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:24:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 00/21] drm/msm: Add support for SM8750
Date: Fri, 21 Feb 2025 16:24:10 +0100
Message-Id: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqauGcC/33N0QqDIBTG8VcJr+dQ01xd7T3GLk6pdaBl6JBF9
 O6zbsZg7PL/wfmdlUQb0EbSFCsJNmFEP+UoTwXpBph6S9HkJoIJxTiraStpfFy0YtRgnEdYaGV
 BlVorCY6TfDcH6/B1mLd77gHj04fleJH4vv7TEqeMtqXjyoGTXa2vI04Q/NmHnuxcEh9CcP2LE
 JkwgnHTGQMVyC9i27Y3DlL7+fYAAAA=
X-Change-ID: 20250109-b4-sm8750-display-6ea537754af1
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4977;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=i5ri9ekSIIkKVxsR8eLTipN73T78Eiw6G+aO7XJu3cM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJqoWunlfAqOpvG4bmHGrkxmWzkH8NU2CUEkd
 zn5511S4GCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iaqAAKCRDBN2bmhouD
 11fFD/0YjOnqKODGT/NKcg+eRYSgezae33GlG8IyOWxVduqrTXeiAz888StStw5817hOkWA47o0
 4/ScVy1MjVWOElWkhrB+Yv2CvtpDw4VyRT2MaS18SNbr9d0X1ozn0imfSD16fXInlMKk7q7HOD6
 2x1cvUYPVnsYPCzvh+Q09Yl9YOSNXQamIz3krykTJHhopXa7/5UDCYCIzDiebkWhQodbFLYZ+e3
 N34ZcIi2oWHiFotwTgnDI8CiFeUuiLBTIM0zx0moLGOSCmz3FtrKsYSB7ghtkrPRFhoPTXyPUr+
 hsbroIy0+wwl/GBU88h/kic9cg+uFlb5xfiT3th2shl+vhMGyPKyI4Nox5/tMrv1JQk6aCbFsgH
 FeO2KhzdM5DusNyS/o6iEvrkg2Wl/2/kZQnzpCwSiDEJzr8Mpg7wwVHIl5lvW88KfW9Bzl25bLH
 62v34hlrbN/PIcb6LDfd2gEyhherif9Ss/Zz5TSUzzAf7/cElZCAaIO0Zd/jq8/S11sFRRuhECL
 1T3KR0VgY0fZgMvMnPJ1pi4zNTf2BdRQGCcfDhQWlrpR7ztZTJ4rfkvFAxQ10cxOixahoVMZXmO
 rvNG9Y31S8jNvBVU1iczliDISJa+Ty0NKnY1GIR8VELfUqCji6h7Nqq5qL34DdlBtopWwb8rN5K
 Ak2AA3zQ6JjeVDw==
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
Krzysztof Kozlowski (21):
      dt-bindings: display/msm: dsi-controller-main: Combine if:then: entries
      dt-bindings: display/msm: dsi-controller-main: Add missing minItems
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
 .../bindings/display/msm/dsi-controller-main.yaml  | 124 +++---
 .../bindings/display/msm/dsi-phy-7nm.yaml          |   1 +
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   1 +
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     | 470 +++++++++++++++++++
 .../drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h    | 496 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  59 ++-
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
 26 files changed, 1654 insertions(+), 101 deletions(-)
---
base-commit: b29308070eeaeae75762724bb01d98b71216f97a
change-id: 20250109-b4-sm8750-display-6ea537754af1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


