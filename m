Return-Path: <linux-kernel+bounces-516277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C240A36F14
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3A41894B73
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C142AA5;
	Sat, 15 Feb 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnJ+mmQZ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AB1DDC2C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632976; cv=none; b=uWDv1jyxgFXr1HEylCLISTMpmm0ptVC04AU9J7yo08c5fJy2C6kSujU1E6/vEUQeSDJr5FJpchhbAuntOlkvGBt8wuuBbByPpf9LHWX+slhR7cHmE7q4ku5Ezmf/uJUDQ7D3MwhUdseb0N5sFh4bf7ooBYbfBNxZuOP/9tIo9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632976; c=relaxed/simple;
	bh=ot4shzajuE90HxsFFMmVirML9i4Ru8URXgw7E2tV8lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJgvrQhoPxnL71kV62Wc69d2vMyzBzX9uRX9YQkgrDkoZNZvXJ+vtLczc0okD/EHOqjuE/dtrkI/BwreFo4UmSkoYBte6layM1cl2R76kRHz5lIDclUpW01dltinXyGRqj6xfFyPaqUzfAHrMCMN5pi9LMdKytey9Xqpd2excR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnJ+mmQZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dbdbdaeedso1348203276.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739632972; x=1740237772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ya1HOp4At8o4rZdZ1CZR9DS9vtC+SlJcJNAQgmy2no=;
        b=qnJ+mmQZ19M8T8zvWmKXkLLyi10q9gXmvuOCrLbITuXvJQdFp6t5sgVXdEvgZ8ktzq
         B6V3lVv742xn5KyWmmh+I2SMuAwAT6tfyfMcDVLHxvEljRSzLH9Xjh7ENa1GA7ztuzov
         /fPPSEqNAidmHqU9XoymDhf3yNCwiM7SNmJP6P+kArmY8MobBy6WSWvDi7IBw3FK9YfT
         QMCTd9H7u7ghg76lk9QKBKXK8Z+LzLvghkTknyTm0OlGKEjKNfdXB+ggFhxteAOXtnLj
         usGmVPeQfsLy7vhj9TIY+IPUg23mdWDdjn6OLme83WZDc1RrrZriiz9+zvrQgtkqVGP/
         iLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739632972; x=1740237772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ya1HOp4At8o4rZdZ1CZR9DS9vtC+SlJcJNAQgmy2no=;
        b=jb2/oq+wrsfwKXX/sYU3k3K3IvmhaUyixNJJjrUog5oApmcM/tmYpc1C0TPpVk//ov
         n9jogKPciCFIlJFu841EwBahFrR1I/AGWrTUinHyd5X402IA77sXIVVP1YJiCdC3wwjZ
         6EyCunRNoDkvNXW9uyPPY422fV7TpsTnFFjETvgohUvD7w6TdfBMBZgVr+gI3sAVuACo
         6M2lQkHXvYXihLl8POxN/dax75KmLdf0RRIzeR3aU5KGQjeiF1uc6Y3C24gmnqYkD51P
         0AwZk0UxPTJzVUf1FWWu9gLwzzQiGjJmdp6leuISjM4XI0jS5uoeDeBz1s6pawwtzOXV
         Ywqg==
X-Forwarded-Encrypted: i=1; AJvYcCV1ksZMrIo8wOs4a+si9z7zk1PPfpGYEyDF3evQtcDASieud1rTtyfx66HvppVmuYHMC9U7Fu+Nb1G9da0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyko0iV1I2CpmH8ZxBuLWZ2kj+vACUYeJZO+eNBALVo8BWC7fvr
	x9MLshRD2HKUTzqmwzNMheCpa6Q78wvfvbUUiyWQ953prkxTolLomFoypl9lKlTk4+AqKr9KGT4
	3WF1Z4CjeVx27Qo6L+tCYSyZgiwsefV9cyxqoIA==
X-Gm-Gg: ASbGncubk27Vuq9LZUB6sBI9W/DV++hW8D+ENgPD5TIqXflpAI0zANXCOB63cz//qVO
	1DbPEjZnO93yVjdVaG2wkl0qoHPCpl9DEzofpJKBDKhJ7Tu67EitCdD7Q4W7kJ4hCqZHRcuV3Hj
	cl3EdC6J8JZOJbhJeK5x2Kxyujcw==
X-Google-Smtp-Source: AGHT+IHCM9nGvMBLMHM0urprzaVEMr1E9JJGwJN2aU4oCsO5lmJSn8L5sb5ABAdmNNdEk78PHDTei2/liPwZS3V/suk=
X-Received: by 2002:a05:690c:6405:b0:6ef:6f24:d093 with SMTP id
 00721157ae682-6fb58260edamr32798287b3.6.1739632972228; Sat, 15 Feb 2025
 07:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
 <20250213-a623-gpu-support-v1-2-993c65c39fd2@quicinc.com> <ttipuo56z76svx3womcrrqurglvovkqehsx2orgnegjj2z7uxn@d3cov6qmmalm>
 <182b7896-9cfc-4f94-b9d4-759fd85fd997@quicinc.com>
In-Reply-To: <182b7896-9cfc-4f94-b9d4-759fd85fd997@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 15 Feb 2025 17:22:40 +0200
X-Gm-Features: AWEUYZkkpka5cr642Meq7bthCAe5gt3dTkRMkIvHVkAt9bN0FOufwH7vzAGO4cA
Message-ID: <CAA8EJppO6ob+oQTzPkx1D6Fmq7bfyNquEyXwFXhmiiTKtXrOAA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/msm/a6xx: Add support for Adreno 623
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jie Zhang <quic_jiezh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 13:49, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 2/13/2025 10:24 PM, Dmitry Baryshkov wrote:
> > On Thu, Feb 13, 2025 at 09:40:07PM +0530, Akhil P Oommen wrote:
> >> From: Jie Zhang <quic_jiezh@quicinc.com>
> >>
> >> Add support for Adreno 623 GPU found in QCS8300 chipsets.
> >>
> >> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> >> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c   | 29 +++++++++++++++++++++++++++++
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  8 ++++++++
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  2 +-
> >>  drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  5 +++++
> >>  4 files changed, 43 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> index edffb7737a97..ac156c8b5af9 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> @@ -879,6 +879,35 @@ static const struct adreno_info a6xx_gpus[] = {
> >>                      { 0, 0 },
> >>                      { 137, 1 },
> >>              ),
> >> +    }, {
> >> +            .chip_ids = ADRENO_CHIP_IDS(0x06020300),
> >> +            .family = ADRENO_6XX_GEN3,
> >> +            .fw = {
> >> +                    [ADRENO_FW_SQE] = "a650_sqe.fw",
> >> +                    [ADRENO_FW_GMU] = "a623_gmu.bin",
> >> +            },
> >> +            .gmem = SZ_512K,
> >> +            .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> >> +            .quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> >> +                    ADRENO_QUIRK_HAS_HW_APRIV,
> >> +            .init = a6xx_gpu_init,
> >> +            .a6xx = &(const struct a6xx_info) {
> >> +                    .hwcg = a620_hwcg,
> >> +                    .protect = &a650_protect,
> >> +                    .gmu_cgc_mode = 0x00020200,
> >> +                    .prim_fifo_threshold = 0x00010000,
> >> +                    .bcms = (const struct a6xx_bcm[]) {
> >> +                            { .name = "SH0", .buswidth = 16 },
> >> +                            { .name = "MC0", .buswidth = 4 },
> >> +                            {
> >> +                                    .name = "ACV",
> >> +                                    .fixed = true,
> >> +                                    .perfmode = BIT(3),
> >> +                            },
> >> +                            { /* sentinel */ },
> >> +                    },
> >> +            },
> >> +            .address_space_size = SZ_16G,
> >>      }, {
> >>              .chip_ids = ADRENO_CHIP_IDS(
> >>                      0x06030001,
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> index 0ae29a7c8a4d..1820c167fcee 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -616,6 +616,14 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
> >>              gpu->ubwc_config.uavflagprd_inv = 2;
> >>      }
> >>
> >> +    if (adreno_is_a623(gpu)) {
> >> +            gpu->ubwc_config.highest_bank_bit = 16;
> >> +            gpu->ubwc_config.amsbc = 1;
> >
> > This bit causes my question: the patch for msm_mdss states that on the
> > display side both UBWC encoder and decoder are 4.0, which means that the
> > UBWC_AMSBC bit won't be set in the UBWC_STATIC register.
>
> Not sure, but my guess is that AMSBC encoding is probably implicitly
> enabled by MDSS HW when UBWC v4 is configured.

Ack.

>
> -Akhil
>
> >
> >> +            gpu->ubwc_config.rgb565_predicator = 1;
> >> +            gpu->ubwc_config.uavflagprd_inv = 2;
> >> +            gpu->ubwc_config.macrotile_mode = 1;
> >> +    }
> >> +
> >>      if (adreno_is_a640_family(gpu))
> >>              gpu->ubwc_config.amsbc = 1;
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >> index 2c10474ccc95..3222a406d089 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >> @@ -1227,7 +1227,7 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
> >>      _a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[1],
> >>              &a6xx_state->gmu_registers[1], true);
> >>
> >> -    if (adreno_is_a621(adreno_gpu))
> >> +    if (adreno_is_a621(adreno_gpu) || adreno_is_a623(adreno_gpu))
> >>              _a6xx_get_gmu_registers(gpu, a6xx_state, &a621_gpucc_reg,
> >>                      &a6xx_state->gmu_registers[2], false);
> >>      else
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> >> index dcf454629ce0..92caba3584da 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> >> @@ -442,6 +442,11 @@ static inline int adreno_is_a621(const struct adreno_gpu *gpu)
> >>      return gpu->info->chip_ids[0] == 0x06020100;
> >>  }
> >>
> >> +static inline int adreno_is_a623(const struct adreno_gpu *gpu)
> >> +{
> >> +    return gpu->info->chip_ids[0] == 0x06020300;
> >> +}
> >> +
> >>  static inline int adreno_is_a630(const struct adreno_gpu *gpu)
> >>  {
> >>      return adreno_is_revn(gpu, 630);
> >>
> >> --
> >> 2.45.2
> >>
> >
>


-- 
With best wishes
Dmitry

