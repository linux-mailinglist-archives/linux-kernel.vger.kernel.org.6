Return-Path: <linux-kernel+bounces-309516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC140966C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A438328512C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98F1C1AAC;
	Fri, 30 Aug 2024 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwCAbl+n"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8B1C1751
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056191; cv=none; b=SL+kFees2DIfShKFCFtKE1I1Z9Di/udKp1XcFUDgJaC2PT0HdBo7H6pQoWxYKbouI5Q4hLeytbVYqcJ+VjfpMnxvvT6x7T+nvAPi4XhMR9xZvAeHFkiJqwPY3FpmcK6EqkXhnCCt8HrXDKtymYH14hWa0jRBMQkK/hgpCg2b1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056191; c=relaxed/simple;
	bh=q24YQHMqdDaHIRrMFVWRSb8dxdfIQqcrBR9swz7mMCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGtf3OI91YlqrkoIlVF2PtB3rqghE2R5+33NSXWy8qtUB8nrJYNhDyP6Ufg4RCAFCEkf6fyQYGEHxorYYaT4CvqCgKTuWZknk89x36DHY8oEuDYn2q6YklMMNhY1cGpOjO3/hqnCU9LXQvq7t4gvDgNjAu2p7wEU1/TVBrOgUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwCAbl+n; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b47ff8a59aso21713757b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725056188; x=1725660988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg0OcxRkiJ9mILCxT4CPJe/4xi2OQv9TcXwbD36UhOo=;
        b=ZwCAbl+nA+NBzZSEhS7hsc/aexBCr/uKhyrID/OusbjPA5etgZrQPjXGbM4hUuIBSv
         oJTwTZC/BJZ40T4HjH6ZigaKs+RB/qYJKVU8SzDm34txCKStK3ZSzAkZvvAyZTI8VgNb
         UyRqJwt1jeOeGafPrcrpr9L5ihwFHkxoEluwFK2zaE9ETmpHbmlOxn3D4hOMQyeAxXHW
         dCFiZ9yPHO7FO/vm01PGzgAp1TOvUoI01Qbf5upyXd+eozXUHsFgZk3+Xa/QBDLiQb2T
         E4ybfTgW1QTzMiljePUp9+e7OfikN5sfb0HZe/dgcb8bag3rLCLncFMvNvzEGPLsPUO7
         fNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056188; x=1725660988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kg0OcxRkiJ9mILCxT4CPJe/4xi2OQv9TcXwbD36UhOo=;
        b=kDUZPpHGLQ4rjC8SOHVHpnt/IPKEQZy1uL2vMo/9rHicPLZ708nua+XxBLPxmSOYk8
         6ySQo/pKGF8HJFNn5xcFQST2MrkB937Nc3WLGcEi929Sta5VfNzX6SKqnXTMlO6L5Peb
         JZz5HVsp/wZk/9LWl9sc2LTyE6IZtW20VFmbBZKan6iHEHsw0hnFhvpiNCTTjNLBVj9+
         fNDe0u7l/tetBiHblHg+ZkRCeb3vgglHFWoU7EDjE/DoRhqhwPlYm7Zz33GXhndGUbbt
         46IePLokOKAhDY9qMJ8rE/X9irzmQqxdPAg4yLRGIm4cMZt+fgyGupYQyjbbKc5UTkor
         s8dg==
X-Forwarded-Encrypted: i=1; AJvYcCUFKmK63VwIXRlzn9qt+zsSONNquCYUAHsdWOjpFfB3CzrYEoYaV8d7oi8gMfWNbZmm0dMCy1Xyc/NvBxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Bwe8WrKItpdB4dPpsramJiYObtSZ2/RtAgKNxLPH/DXbmTxk
	HQ/EPo3WoMic+CB8olbWG2lgmBkVS2W/EiCJ6RysAIad9439Cc/6iMQKtj6jMEwtkBFd0SVcrse
	DgAENtPAlOqwpAwdVhZ2Q7md390Fw2m3jMAUkaQ==
X-Google-Smtp-Source: AGHT+IHgOBmdwt0xUdZkJgCOZZM6PHszQRsO5mml5cm8WKpLa4tuyNCeZ9ZjuBiXceqbfQLAyAgRg28VJm8LcQEYicM=
X-Received: by 2002:a05:690c:6711:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6d40f82a5dcmr47478337b3.23.1725056188103; Fri, 30 Aug 2024
 15:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-11-502b16ae2ebb@quicinc.com> <pf6xgu7yjanzjigfpupons4ud6jbcmbr5icnd7yur6qhh3n5sf@plj4bi3beguw>
 <665da6e9-d9f3-4a28-a53b-0f467967fc78@quicinc.com>
In-Reply-To: <665da6e9-d9f3-4a28-a53b-0f467967fc78@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 31 Aug 2024 01:16:16 +0300
Message-ID: <CAA8EJpo0X7yRaqYV-tTco9+9WyexiPN_ey8hKivFrE3jTojUpg@mail.gmail.com>
Subject: Re: [PATCH 11/21] drm/msm/dpu: Add RM support for allocating CWB
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 22:28, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
>
>
> On 8/30/2024 10:18 AM, Dmitry Baryshkov wrote:
> > On Thu, Aug 29, 2024 at 01:48:32PM GMT, Jessica Zhang wrote:
> >> Add support for allocating the concurrent writeback mux as part of the
> >> WB allocation
> >>
> >> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  5 ++++-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 30 +++++++++++++++++++++++++++--
> >>   2 files changed, 32 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> index c17d2d356f7a..c43cb55fe1d2 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> >> @@ -1,5 +1,7 @@
> >>   /* SPDX-License-Identifier: GPL-2.0-only */
> >> -/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> >> +/*
> >> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> >> + * Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> >>    */
> >>
> >>   #ifndef _DPU_HW_MDSS_H
> >> @@ -352,6 +354,7 @@ struct dpu_mdss_color {
> >>   #define DPU_DBG_MASK_DSPP     (1 << 10)
> >>   #define DPU_DBG_MASK_DSC      (1 << 11)
> >>   #define DPU_DBG_MASK_CDM      (1 << 12)
> >> +#define DPU_DBG_MASK_CWB      (1 << 13)
> >>
> >>   /**
> >>    * struct dpu_hw_tear_check - Struct contains parameters to configure
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> index bc99b04eae3a..738e9a081b10 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> >> @@ -1,9 +1,10 @@
> >>   // SPDX-License-Identifier: GPL-2.0-only
> >>   /*
> >>    * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> >> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> >> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> >>    */
> >>
> >> +#include <drm/drm_managed.h>
> >>   #include "msm_drv.h"
> >>   #define pr_fmt(fmt)        "[drm:%s] " fmt, __func__
> >>   #include "dpu_kms.h"
> >> @@ -34,6 +35,7 @@ int dpu_rm_init(struct drm_device *dev,
> >>              void __iomem *mmio)
> >>   {
> >>      int rc, i;
> >> +    struct dpu_hw_blk_reg_map *cwb_reg_map;
> >>
> >>      if (!rm || !cat || !mmio) {
> >>              DPU_ERROR("invalid kms\n");
> >> @@ -100,11 +102,35 @@ int dpu_rm_init(struct drm_device *dev,
> >>              rm->hw_intf[intf->id - INTF_0] = hw;
> >>      }
> >>
> >> +    if (cat->cwb_count > 0) {
> >> +            cwb_reg_map = drmm_kzalloc(dev,
> >> +                            sizeof(*cwb_reg_map) * cat->cwb_count,
> >> +                            GFP_KERNEL);
> >
> > Please move CWB block pointers to dpu_rm. There is no need to allocate a
> > separate array.
>
> Hi Dmitry,
>
> Sorry, I'm not sure what you mean here. Can you clarify your comment?
>
> This is just allocating an array of the CWB register addresses so that
> the hw_wb block can use it to configure the CWB mux registers.

Excuse me. I asked to make the cwb_reg_map array a part of the
existing dpu_rm structure. This way other subblocks can access it
through dpu_rm API.

>
> Thanks,
>
> Jessica Zhang
>
> >
> >> +
> >> +            if (!cwb_reg_map) {
> >> +                    DPU_ERROR("failed cwb object creation\n");
> >> +                    return -ENOMEM;
> >> +            }
> >> +    }
> >> +
> >> +
> >> +    for (i = 0; i < cat->cwb_count; i++) {
> >> +            struct dpu_hw_blk_reg_map *cwb = &cwb_reg_map[i];
> >> +
> >> +            cwb->blk_addr = mmio + cat->cwb[i].base;
> >> +            cwb->log_mask = DPU_DBG_MASK_CWB;
> >> +    }
> >> +
> >>      for (i = 0; i < cat->wb_count; i++) {
> >>              struct dpu_hw_wb *hw;
> >>              const struct dpu_wb_cfg *wb = &cat->wb[i];
> >>
> >> -            hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
> >> +            if (cat->cwb)
> >> +                    hw = dpu_hw_wb_init_with_cwb(dev, wb, mmio,
> >> +                                    cat->mdss_ver, cwb_reg_map);
> >> +            else
> >> +                    hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
> >> +
> >>              if (IS_ERR(hw)) {
> >>                      rc = PTR_ERR(hw);
> >>                      DPU_ERROR("failed wb object creation: err %d\n", rc);
> >>
> >> --
> >> 2.34.1
> >>
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

