Return-Path: <linux-kernel+bounces-433488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FD9E591C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81C91883184
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20C218AC2;
	Thu,  5 Dec 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xh3H8NYz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB31A28D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410881; cv=none; b=lh2XDMP/rZ+VlOqJMf7b+iuyxWQUWeNTuFPFXNxHl2K+f+7r5av14EHQkIsMbiAkdzL52+jEzoq3VvT/kJB8hUiBbNK2qA4V2Ae4cZk7kfEIWZ/wVZhLNiiSkpzasLHm7GO6iNwatMy+zx4GRYWOTvQ5fv0wVWz+L0Oe9ShQocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410881; c=relaxed/simple;
	bh=b1pKFZiTa/F6E8Dkp//xdfPfKGEfW16l02UZUYI5EXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DHifhFRz/FcGwgXqPc6CtjDZixhLLFLm2b1tmzWrX3BeJCfLvD//uN1N1ftsPll3gGWebW0RA+ySzi1xlvIizM3HwVrOk1g0aNHB++gYooAp4YcD/qcdDpuKth6Kvlctt1clAtBovo9YJf6sy3SrF64oWeV7A7zfPhDBIRGiDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xh3H8NYz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso7161605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733410878; x=1734015678; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tbWDMh1oOyUt0FdrCtOOr0ppw77dNgGcXJzOMWhRrgU=;
        b=xh3H8NYzEToI7POXewtoB0zW3VVojp8sReKE2j/Et0U1brPUhroOx6Ye1f86iQmsxw
         JJykD6GySoVud9lHwFvBiV8IPD/WX4yBt8DT4vtOYxWD+SAIJPCHEig5cmeL62BDtt/J
         OWGp09fnnQ4I8Q3irZWt1sgUpDufCb3jnLx8qOhaxjSR/bM7W77TO6SffNQ2P/H0PElR
         lVy74Oi2hmPxiHZ9K//9dVksSiOxD6QUATHM+opfFoeWQkl8WMztMR2UNPzgmV1TksDP
         LbFAfMcwLMhX6RcnySEiUJwkCRTUdnVnw7f7Q7RIfSRDpjdlJTAwgFxTLvVSoK1Uysnc
         WDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410878; x=1734015678;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbWDMh1oOyUt0FdrCtOOr0ppw77dNgGcXJzOMWhRrgU=;
        b=MaYVGpgjnwRSax66re2q1qXm7Qydb50+Z6uXoQJsVHiFuUwIGjO/5hDpKQFhj5FDvS
         9LbbE5MgbZ85YnaTmXbFexhrTHOvReFb8sncb/rkzSlvqy3G/INnQQVdHBUcgSZTg/EQ
         w6um0ENML2haOWgw1NgkDH4SGn/etFGOdygTbl+5Ku2x6E2no6sXAKONeNqo3QHHHLua
         AfSexbpmITncXXoQzfIbqawncq3AXbLGUMWniMN40AhGdgw8Jd0GhiK2Etc2PpRtNbAr
         zUd3HeOQC03+tGEplx4pHnFrZjgI4Lq1sPemBK4YWo29U+hRoAEekhzdnnNTXHNUfkW+
         YDTg==
X-Forwarded-Encrypted: i=1; AJvYcCVmmzpoBnfAadg9oVNPsULPkz4t33DU8XMsTU+1JZPrwwTPo9d1gMgIHq5hevPwG5O/cmY4NcVGI36o1HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8tgk0gEXp01/Xrdzm2HJECr7OpSyfGg4Wplf0edib5H2Ejk/
	AxGwlM5nDARk9yHYAVht9HOgplZWqO9iXCheaT1OekGPJa1iP0VjRG6YjZcUIjo=
X-Gm-Gg: ASbGncuXFsnE0O4FfHJv0LJdBfp4OvEpsy+ZGXYDGtCIOl2Zr9oWsohKPzVQgc0K/0E
	MADydChvhlFbv5xsJjVT6ND7cuxfhVH+T5Qtx8Qs0Q9B8gvS8/djCf03Yx7/Te6pKb7/u/GdWXh
	/VCqiknNSYTP1vPSs50XqR2NNafPPPyRuPqQ5rN6pH75G6Nla7/ThKHwijQ7ym74JU4fmsy75Oz
	ig3QOpQzMswKNs56TmtX7X9X7PTrBqm/NOxUKN74g19gnV9joMovBaBBKUca6RCw4CDe+4=
X-Google-Smtp-Source: AGHT+IGhmRzBKdM9swwZgZIhKLM8LIVgc35epsroCYtGmEdGqZoyNJjXT65jo1zPO+hOdn8NoRrpXQ==
X-Received: by 2002:a05:600c:a03:b0:434:a923:9310 with SMTP id 5b1f17b1804b1-434d09cf141mr95386425e9.15.1733410876246;
        Thu, 05 Dec 2024 07:01:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm62830795e9.35.2024.12.05.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:01:15 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/7] drm/msm: adreno: add support for DDR bandwidth
 scaling via GMU
Date: Thu, 05 Dec 2024 16:01:04 +0100
Message-Id: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDAUWcC/43NTQ6CMBCG4auYrh3TP2xx5T2MCwoDNlFKWqwYw
 t0trDAmxOX7JfPMSAJ6i4GcdiPxGG2wrk0h9ztS3oq2QbBVasIpl4wxAb3rbAnhoYeMQtM9wbw
 guh6hzpByXqMqpCLpvPNY22GhL9fUNxt659/Lp8jm9Q80MqAgjK5EroQqcnO+27bw7uB8Q2Y18
 rWUb0g8SbJCo5VBLnP9I4mVxPWGJJKkWXWkJaO1UeJLmqbpA3vk/pxVAQAA
X-Change-ID: 20241113-topic-sm8x50-gpu-bw-vote-f5e022fe7a47
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4651;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=b1pKFZiTa/F6E8Dkp//xdfPfKGEfW16l02UZUYI5EXY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUcA3CO6vTLpJYs2HfLccENhknf2A1LzscxmXacWJ
 DSE4GaSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1HANwAKCRB33NvayMhJ0Ym2D/
 sGsBTqzQIxIkxjoTaZNHUXJu8Mr86SPSQQl31/btttbW3+YSds2lwaOFSMcEvEMhFwe6+OCmdouI7u
 Cw/VnAoXXrzhqfqSen6+xRVUwzNtA+r/pceTVli8XTxGwNht7XookQgx1HQevlrejPJQhTqxQKikP1
 b6i9472TF2UfqftjOgwE/bwW/zZlah0rLW1ChvmthJ08w6pdJWTur4u1cYizpV51hg90VUo3eFjKsi
 GxxCsPuRSI8NTbdb6022gm5IqsHnzB+qXp+k4rv9dDlnb1qulazMbJzYasD53rNxVHafJLhp5y7W+4
 kznWNdI5yELL90ljk4QoiruUN3U7Mkv6x2+cKNjy2d/0VqHVqT0Ha0UBYQg9IY4KUAIVU64KSDpj5F
 DuFnQjSMvSGiI9cSUhtkoyEJ7Gaj5s9HW2LiQEo+16+BtagaWk+ZG646og2KyNl+wk8+idNzCt4GUv
 f5/GFoz5l2nU1iaKlKhxO5tVWt1Nkh95N0b6DlRkk4iJ2+evRkGVOxPaVUgsG0y7w3mcvvfOwuAwDI
 RH211J2I61kVJLecu/TeitNBoYC/XLJiN1sJQGpHJA6RnhKkXRebwb+k6njXACwrLtO/kPYGwDYDFp
 6ewKoA5KMxGH2+288XbMcWQ7Weu/TOIhpGIMdeAnyw1RCyKkPPuKbIXp7AKA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GPU Management Unit (GMU) can also vote for DDR Bandwidth
along the Frequency and Power Domain level, but by default we leave the
OPP core scale the interconnect ddr path.

While scaling the interconnect path was sufficient, newer GPUs
like the A750 requires specific vote parameters and bandwidth to
achieve full functionnality.

In order to get the vote values to be used by the GPU Management
Unit (GMU), we need to parse all the possible OPP Bandwidths and
create a vote value to be send to the appropriate Bus Control
Modules (BCMs) declared in the GPU info struct.
The added dev_pm_opp_get_bw() is used in this case.

The vote array will then be used to dynamically generate the GMU
bw_table sent during the GMU power-up.

Those entries will then be used by passing the appropriate
bandwidth level when voting for a GPU frequency.

This will make sure all resources are equally voted for a
same OPP, whatever decision is done by the GMU, it will
ensure all resources votes are synchronized.

Depends on [1] to avoid crashing when getting OPP bandwidths.

[1] https://lore.kernel.org/all/20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org/

Ran full vulkan-cts-1.3.7.3-0-gd71a36db16d98313c431829432a136dbda692a08 with mesa 25.0.0+git3ecf2a0518 on:
- QRD8550
- QRD8650
- HDK8650

Any feedback is welcome.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Collected review tags
- Dropped bcm_div() and switched to clamp() instead
- Dropped pre-calculation of AB votes
- Instead calculate a 25% floor vote in a6xx_gmu_set_freq() as recommended
- Use QCOM_ICC_TAG_ALWAYS in DT
- Made a740_generate_bw_table() generic, using defines to fill the table
- Link to v3: https://lore.kernel.org/r/20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org

Changes in v3:
- I didn't take Dmitry's review tags since I significantly changed the patches
- Dropped applied OPP change
- Dropped QUIRK/FEATURE addition/rename in favor of checking the a6xx_info->bcms pointer
- Switch a6xx_info->bcms to a pointer, so it can be easy to share the table
- Generate AB votes in advance, the voting was wrong in v2 we need to quantitiwe each bandwidth value
- Do not vote via GMU is there's only the OFF vote because DT doesn't have the right properties
- Added defines for the a6xx_gmu freqs tables to not have magic 16 and 4 values
- Renamed gpu_bw_votes to gpu_ib_votes to match the downstream naming
- Changed the parameters of a6xx_hfi_set_freq() to u32 to match the data type we pass
- Drop "request for maximum bus bandwidth usage" and merge it in previous changes
- Link to v2: https://lore.kernel.org/r/20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org

Changes in v2:
- opp: rename to dev_pm_opp_get_bw, fix commit message and kerneldoc
- remove quirks that are features and move them to a dedicated .features bitfield
- get icc bcm kerneldoc, and simplify/cleanup a6xx_gmu_rpmh_bw_votes_init()
  - no more copies of data
  - take calculations from icc-rpmh/bcm-voter
  - move into a single cleaner function
- fix a6xx_gmu_set_freq() but not calling dev_pm_opp_set_opp() if !bw_index
- also vote for maximum bus bandwidth usage (AB)
- overall fix typos in commit messages
- Link to v1: https://lore.kernel.org/r/20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org

---
Neil Armstrong (7):
      drm/msm: adreno: add defines for gpu & gmu frequency table sizes
      drm/msm: adreno: add plumbing to generate bandwidth vote table for GMU
      drm/msm: adreno: dynamically generate GMU bw table
      drm/msm: adreno: find bandwidth index of OPP and set it along freq index
      drm/msm: adreno: enable GMU bandwidth for A740 and A750
      arm64: qcom: dts: sm8550: add interconnect and opp-peak-kBps for GPU
      arm64: qcom: dts: sm8650: add interconnect and opp-peak-kBps for GPU

 arch/arm64/boot/dts/qcom/sm8550.dtsi      |  13 +++
 arch/arm64/boot/dts/qcom/sm8650.dtsi      |  15 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c |  22 ++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 183 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h     |  26 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c     |  47 +++++++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h     |   5 +
 8 files changed, 301 insertions(+), 11 deletions(-)
---
base-commit: df210b30304e9113866a213363894a6d768411ec
change-id: 20241113-topic-sm8x50-gpu-bw-vote-f5e022fe7a47

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


