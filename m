Return-Path: <linux-kernel+bounces-445618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CB9F1860
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E1F188EB91
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C718198A34;
	Fri, 13 Dec 2024 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njbFiaLd"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC31953A1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128080; cv=none; b=AJ1IxQd+TLtcO7kSDfGbLl5GMj5LV9svoIax2CsQOUPp34YPZgf/H4SLuSQPQV4wopLx+NmOdJlZVhYkcAwYKzWXpOaE26zPqBQlSG/FRZlMMU627sMA0RDCF1YWhDEEafsCIhz+OOBe865uKh8rkkd+vHSQ9ioYZFHn6nB5EdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128080; c=relaxed/simple;
	bh=AGT0VwRtMSmQJOGxsFl1LCGIke4RBrOxt2Uij10pqgU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kbNIhOybI0lP1KLNK5rTn2xAk9cjQvON4vURHYSXTqtMEse4rxf796dUNvYU4aUUCAb46Ag9R/Qcqja6ewLtJfl2GwA9nb3vUoCOyIM0M0l7+Nm4QyeKyQHKgF48/tLPBs17WktjbRYK6Xe1ed6g1o56JMPFOeXnVMizqPYwEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=njbFiaLd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30227c56b11so20666271fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128076; x=1734732876; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piO3iEUonvXG/YpP5cYnqXXHXA3RyScwDLylgHSdgeM=;
        b=njbFiaLdyAPdWSnsZ6qR1/iiUt47mZEc/eVjComIbIpzIitXBE/4ZPl/6VgJF/b/tY
         K5upL0bLH3vj0ron4M4gz8xQnobGHkfIkksLVjYP3IKlks8Gw8a8i1gWaXXdCoeOdCoj
         5PFWB+YuARdk2AmJ69rRYaW/PNSDtxfz7k4Vjh6c2p8eRDB3ySbrGnTeLfaYaVuaQ+Hp
         d8REDbEOAwj7p2QiTGNfnV4JCn6SYb8XcwEKtMBoJDg6i9tQ+ytSQFNqzlyqqpmZjLT4
         0ERJ5SjDWT3zzgb3J//GiOCRnyp1az7hDPCg1cosj0HkfSMlD2r7BhUw7G15QOhiPeiz
         bREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128076; x=1734732876;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piO3iEUonvXG/YpP5cYnqXXHXA3RyScwDLylgHSdgeM=;
        b=iFzLWiJUTfRwl9AqtT3siDFQ23oo9ekE0ELml0N63eGsZM8tPRyX7R/4eGHYyfxDZG
         LCLZFD+V+Gd5shrf7JWm7Se8D3gsNe+6qL5OrwIaXISivPm/gqgWFT94E1GoV+VWAgXV
         hGA0o9kBTd1K+CCnnTsxR+OBeeNGfpg7Mn0AyTnwP5uPPXT/5OVd/EzKZeHHPa9O779h
         4bGZurSFLXpUzaOXphYQFpm/mDXRE4tL+B1hXlwLoL2npY4Uim2evxN8gm5isZrtIerJ
         lWgGjnZDR55zLdb0Wzj4/+D3QfUFwEOsGWgNHKK1gDc41qtyG/A20WJg2d0TynUJsFa6
         AZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHoATSOBa+r1wC935tCMHnoIMkAvrUqjfkGWrhiLfJixELso5J25SxKpPel3yce8TOfphz8ewc56G0nWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8TeZZysqX/OIde/2B+DnrutsQhhBcFmbB5xPp3goLIfdbyd5
	j2ICJ5po0w1noj+EkUYj2WuA97YscsVBHF4m5Q1s77vo1UdNdNO3/N4vvXvC/eo=
X-Gm-Gg: ASbGnctc6MGeQn3kbEeukr3RP2pJUFB4be05Xs4WJvndycLHdtv011FsXw48EqA6Mqs
	2dVNJXkFLyDIMffpI6MxHonMz8r3o/TilGrGSsL2Nb915r3Yhhh4CEG3ItEGNucibt6isA8icXi
	w7Sl5Vtp6havOylQi8jI/IYUKJehY0Xx5JK5EEYA1wVii4c9YOG4IudjGtjAYaKk8uTI7WPJj91
	VuGlm6rmJ5aIA+WKvwAVyvDmEuRIGSlwDN8k1EDroEg9ZGjhdge/V21fiCFVsW3
X-Google-Smtp-Source: AGHT+IGbQqQ7Qu8wQL0kA96Y19GVt8yuyIETIpiRDuqRBPKtq0Iu6InmLiOUw9B5NZ9yHih+nFaIkg==
X-Received: by 2002:a05:651c:54f:b0:300:3bcd:8d05 with SMTP id 38308e7fff4ca-3025443fe17mr12038911fa.15.1734128076440;
        Fri, 13 Dec 2024 14:14:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:14:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 00/35] drm/msm/dpu: rework HW block feature handling
Date: Sat, 14 Dec 2024 00:14:16 +0200
Message-Id: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALixXGcC/x3MOwqAMBBF0a3I1A6YRPxtRSzEPHUaDRMVQdy7w
 fIU9z4UoYJIXfaQ4pIo+5Zg8oymddwWsPhksoUtjTWOfTjZ6x54xnicish1VTg/OcA0LaUuKGa
 5/2c/vO8HvttxPGMAAAA=
X-Change-ID: 20241213-dpu-drop-features-7603dc3ee189
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5889;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AGT0VwRtMSmQJOGxsFl1LCGIke4RBrOxt2Uij10pqgU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3rMxsOXTfVnHvEOViw5rhYkmXLKpKmjzXtdQezx2jJ3y
 5SCq8adjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZhI7SMOhplWHlseaZ38crrJ
 tP7onjQv+RlWLyPsQ92nzL3tvm/F7saIjT3zmuZ/vGp2+MWGrZrSHw7tyl3yeYHlIW3/jOSGAw9
 v2StxhoiY7OV2PDg9y/DTpK8SHawJfutS/WLLUs7oKrs+ZPk0VVF+Q4Gi+2nZekMVo4kf9O72+k
 i/kdw4+fbZZgv9i8YmAdefP7L+/abSYdaHJ87n+6rF7nHfsJ5oxjCVc21IiMikEvkb6X5bJhb5b
 +Be1Zk3I15mJ6czNwujTqG1asDt9gUSRWGFps94RCsF3VwOSWZMjnqufMUtbW9o9pEY4y2VevrX
 Xt25W6IUfePk19zwp1aSfgYuPexf7fyreeNvTNh06ZkGAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Some time ago we started the process of converting HW blocks to use
revision-based checks instead of having feature bits (which are easy to
miss or to set incorrectly). Then the process of such a conversion was
postponed. (Mostly) finish the conversion. The only blocks which still
have feature bits are SSPP, WB and VBIF. In the rare cases where
behaviour actually differs from platform to platform (or from block to
block) use unsigned long bitfields, they have simpler syntax to be
checked and don't involve test_bit() invocation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (35):
      drm/msm/dpu: skip watchdog timer programming through TOP on >= SM8450
      drm/msm/dpu: enable DPU_WB_INPUT_CTRL for DPU 5.x
      drm/msm/dpu: stop passing mdss_ver to setup_timing_gen()
      drm/msm/dpu: drop INTF_SC7280_MASK
      drm/msm/dpu: inline _setup_ctl_ops()
      drm/msm/dpu: inline _setup_dsc_ops()
      drm/msm/dpu: inline _setup_dspp_ops()
      drm/msm/dpu: inline _setup_mixer_ops()
      drm/msm/dpu: remove DSPP_SC7180_MASK
      drm/msm/dpu: get rid of DPU_CTL_HAS_LAYER_EXT4
      drm/msm/dpu: get rid of DPU_CTL_ACTIVE_CFG
      drm/msm/dpu: get rid of DPU_CTL_FETCH_ACTIVE
      drm/msm/dpu: get rid of DPU_CTL_DSPP_SUB_BLOCK_FLUSH
      drm/msm/dpu: get rid of DPU_CTL_VM_CFG
      drm/msm/dpu: get rid of DPU_DATA_HCTL_EN
      drm/msm/dpu: get rid of DPU_INTF_STATUS_SUPPORTED
      drm/msm/dpu: get rid of DPU_INTF_INPUT_CTRL
      drm/msm/dpu: get rid of DPU_PINGPONG_DSC
      drm/msm/dpu: get rid of DPU_PINGPONG_DITHER
      drm/msm/dpu: get rid of DPU_MDP_VSYNC_SEL
      drm/msm/dpu: get rid of DPU_MDP_PERIPH_0_REMOVED
      drm/msm/dpu: get rid of DPU_MDP_AUDIO_SELECT
      drm/msm/dpu: get rid of DPU_MIXER_COMBINED_ALPHA
      drm/msm/dpu: get rid of DPU_DIM_LAYER
      drm/msm/dpu: get rid of DPU_DSC_HW_REV_1_2
      drm/msm/dpu: get rid of DPU_DSC_OUTPUT_CTRL
      drm/msm/dpu: get rid of DPU_WB_INPUT_CTRL
      drm/msm/dpu: get rid of DPU_SSPP_QOS_8LVL
      drm/msm/dpu: drop unused MDP TOP features
      drm/msm/dpu: drop ununused PINGPONG features
      drm/msm/dpu: drop ununused MIXER features
      drm/msm/dpu: get rid of DPU_MIXER_SOURCESPLIT
      drm/msm/dpu: get rid of DPU_DSC_NATIVE_42x_EN
      drm/msm/dpu: get rid of DPU_CTL_SPLIT_DISPLAY
      drm/msm/dpu: move features out of the DPU_HW_BLK_INFO

 .../drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h    |  53 +++-----
 .../drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h   |   4 -
 .../drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h   |   3 -
 .../drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h   |   4 -
 .../drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h    |  15 +--
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |  19 +--
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h |  19 +--
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h |  12 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h |  21 +---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h |   1 -
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  41 ++-----
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  43 ++-----
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h |  31 ++---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h |  14 ---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  42 ++-----
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  14 +--
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |   5 -
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h |  16 +--
 .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |   5 -
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h |   6 -
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  44 ++-----
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  22 +---
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  50 ++------
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  47 ++------
 .../drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h    |  53 ++------
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  47 ++------
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |  52 ++------
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |   2 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   3 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  51 +-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     | 134 ++-------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         | 106 ++++++++--------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |   4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  21 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     |   7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c        |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |  14 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |  28 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h          |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c     |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         |  11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  17 ++-
 50 files changed, 295 insertions(+), 836 deletions(-)
---
base-commit: 789384eb1437aed94155dc0eac8a8a6ba1baf578
change-id: 20241213-dpu-drop-features-7603dc3ee189

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


