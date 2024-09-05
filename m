Return-Path: <linux-kernel+bounces-317171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3B896DA59
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC481C2333F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CF19CC2B;
	Thu,  5 Sep 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW/lu/zI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE919885F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543065; cv=none; b=FcqABGfOvsz8+NUVRjPK9mS2fFMZ7vdSGRFK0b2q+3xbHGfCN0mHaJyt1a2QvvfyQMtD7Kht4S7/cnIBBZubmu1p2F6mL5tRXLB/a96ooGimfM2kRFrQMPZMQncmaAz0iqwmyvwOXgDsiANcVQed6ZIQtCLbBVWkBMpQZMvOUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543065; c=relaxed/simple;
	bh=jCBxyDwdRdzQG9NCtadq7qnQcES9+sSB/YqrGNS5eEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj5O2IegDUUW8MtMyBMzijDmWhK5bgJn0CY+VtsbgNBmdbePW8zCfeNq1qpgaVMblsi9BXNTaW5lLkx6bB8iMOg9x8jDe+PzVnHZZEX9JpBiPo/wF40z6Eq44hVmfo6yB9hxFxIPu1R7FpZRRM4m9CGCMfQ74mIivSSlvXm0J9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DW/lu/zI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f74e468baeso5769881fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725543061; x=1726147861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3k38Kc8SysJksU5Yyhb2OSFNacT0HPlW64jE0pgeAk=;
        b=DW/lu/zIjLfvLix+D9tKUUF/hzytj9PnkfAX8kI1fBq2g0Pp1GDQXwUT+YlcUJVtvV
         FJgPwIr7BWGIDAstDDhhLotxkpvmN/+IyBqK9qfzDWJb0PHszNpBqENastVHOEOjwG1m
         rTRMMvcTQlFfdu/IZfc9Cu5l8GEHMfSHovStZCVLaE+HKBCheNdU/iO3NgmgNKvBm1j5
         71AFxF5C4s9140skuI7S4bBHSPvglDeeiJ0l5xKaMpAznrVINhzSK0oitFA0kk0de+PY
         7odsM5l/PgSG3pxktkSIeIsAfIXLlADboHvXzWC1X4xLmyJpRpv7QzuiRu61yKVxoJla
         jZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543061; x=1726147861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3k38Kc8SysJksU5Yyhb2OSFNacT0HPlW64jE0pgeAk=;
        b=ha4+GLn1vXHtUdSc4hE1yIPpO0BEdxrWlOkMSEc5mHeMwJ04GK4qORA/ERd+Aipr5V
         CpElzgXS1kebqTzJcHqSX9AwgVutPq2AykH2hLn+HRuOTe9laGfIC9OUxA6CUgqX0SS6
         FtFQ8F4DtVKUBRx7eUqNFnvSmmP2eyZdEQfE1F6h8bvCh6DN7h57rf2j0cRHSiok3QEU
         Qij76f487zIcfYecR+fC6MGI2WLAnSrnxMQVCl/D37IqRpWBV5PsG9S8vJnIv0BXvA/5
         H/cRQAJxySr3+kVLqpwlVun0Lx0MZSxIuMj1fgvjNCbZfX6216tyily2KaD7FEyZTTnv
         Mp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXbYIbw8yULwl2BF/BcRX5/cQfm9v2j7Q9Q1ipPl6dBTGOZ6/gSdNyiV8SEVPgqos5LuAG9Y1jq0dk4NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6Rlbz8iEcfiS+PErfH6NvBXm3fb+kmjZpslBcKUlBmZxjqWx
	1q0wIg7CLwVKJRKdEEZePliKQMpIx0i0qjZq9/2aNlGycQ0yL+IhszNKzEj8NTc=
X-Google-Smtp-Source: AGHT+IFSzRPX0vhrJF4hsWI0jD6hUXLgrjoxaCWQKO60u2DVzfx/QrL8RLTYXfoMlWEoHfD0p9vpbg==
X-Received: by 2002:a05:651c:b13:b0:2f1:6cb1:44c0 with SMTP id 38308e7fff4ca-2f61038c633mr185813771fa.6.1725543060140;
        Thu, 05 Sep 2024 06:31:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614eff0d8sm28799801fa.30.2024.09.05.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:30:59 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:30:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 11/21] drm/msm/dpu: Add RM support for allocating CWB
Message-ID: <7ya6xrvbhdqddkglzzj6mtdxn735j56quguhohd5oid7vqut2w@wygb7ryzkj4r>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-11-502b16ae2ebb@quicinc.com>
 <pf6xgu7yjanzjigfpupons4ud6jbcmbr5icnd7yur6qhh3n5sf@plj4bi3beguw>
 <665da6e9-d9f3-4a28-a53b-0f467967fc78@quicinc.com>
 <CAA8EJpo0X7yRaqYV-tTco9+9WyexiPN_ey8hKivFrE3jTojUpg@mail.gmail.com>
 <0e5dc874-0b50-4a6b-ba98-83cb01f7cce6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e5dc874-0b50-4a6b-ba98-83cb01f7cce6@quicinc.com>

On Tue, Sep 03, 2024 at 06:04:13PM GMT, Jessica Zhang wrote:
> 
> 
> On 8/30/2024 3:16 PM, Dmitry Baryshkov wrote:
> > On Fri, 30 Aug 2024 at 22:28, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 8/30/2024 10:18 AM, Dmitry Baryshkov wrote:
> > > > On Thu, Aug 29, 2024 at 01:48:32PM GMT, Jessica Zhang wrote:
> > > > > Add support for allocating the concurrent writeback mux as part of the
> > > > > WB allocation
> > > > > 
> > > > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  5 ++++-
> > > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 30 +++++++++++++++++++++++++++--
> > > > >    2 files changed, 32 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > index c17d2d356f7a..c43cb55fe1d2 100644
> > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> > > > > @@ -1,5 +1,7 @@
> > > > >    /* SPDX-License-Identifier: GPL-2.0-only */
> > > > > -/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> > > > > +/*
> > > > > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > > + * Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
> > > > >     */
> > > > > 
> > > > >    #ifndef _DPU_HW_MDSS_H
> > > > > @@ -352,6 +354,7 @@ struct dpu_mdss_color {
> > > > >    #define DPU_DBG_MASK_DSPP     (1 << 10)
> > > > >    #define DPU_DBG_MASK_DSC      (1 << 11)
> > > > >    #define DPU_DBG_MASK_CDM      (1 << 12)
> > > > > +#define DPU_DBG_MASK_CWB      (1 << 13)
> > > > > 
> > > > >    /**
> > > > >     * struct dpu_hw_tear_check - Struct contains parameters to configure
> > > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > > > index bc99b04eae3a..738e9a081b10 100644
> > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > > > @@ -1,9 +1,10 @@
> > > > >    // SPDX-License-Identifier: GPL-2.0-only
> > > > >    /*
> > > > >     * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> > > > > - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > > + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > >     */
> > > > > 
> > > > > +#include <drm/drm_managed.h>
> > > > >    #include "msm_drv.h"
> > > > >    #define pr_fmt(fmt)        "[drm:%s] " fmt, __func__
> > > > >    #include "dpu_kms.h"
> > > > > @@ -34,6 +35,7 @@ int dpu_rm_init(struct drm_device *dev,
> > > > >               void __iomem *mmio)
> > > > >    {
> > > > >       int rc, i;
> > > > > +    struct dpu_hw_blk_reg_map *cwb_reg_map;
> > > > > 
> > > > >       if (!rm || !cat || !mmio) {
> > > > >               DPU_ERROR("invalid kms\n");
> > > > > @@ -100,11 +102,35 @@ int dpu_rm_init(struct drm_device *dev,
> > > > >               rm->hw_intf[intf->id - INTF_0] = hw;
> > > > >       }
> > > > > 
> > > > > +    if (cat->cwb_count > 0) {
> > > > > +            cwb_reg_map = drmm_kzalloc(dev,
> > > > > +                            sizeof(*cwb_reg_map) * cat->cwb_count,
> > > > > +                            GFP_KERNEL);
> > > > 
> > > > Please move CWB block pointers to dpu_rm. There is no need to allocate a
> > > > separate array.
> > > 
> > > Hi Dmitry,
> > > 
> > > Sorry, I'm not sure what you mean here. Can you clarify your comment?
> > > 
> > > This is just allocating an array of the CWB register addresses so that
> > > the hw_wb block can use it to configure the CWB mux registers.
> > 
> > Excuse me. I asked to make the cwb_reg_map array a part of the
> > existing dpu_rm structure. This way other subblocks can access it
> > through dpu_rm API.
> 
> Got it, thanks for the clarification. Just wondering, is the intent here to
> add CWB to rm's get_assigned_resourced?
> 
> The CWB registers will be handled by hw_wb and isn't referenced anywhere
> outside of hw_wb (aside from when it's being allocated and passed into
> hw_wb_init) so I'm not sure what's the benefit of adding it to the dpu_rm
> struct.

To have a single point where all the blocks are handled, pretty much
like we have a single catalog where all blocks are allocated. Note how
e.g. how MERGE_3D is handled. Or how we return harware instances for
INTF or WB. 

> 
> > 
> > > 
> > > Thanks,
> > > 
> > > Jessica Zhang
> > > 
> > > > 
> > > > > +
> > > > > +            if (!cwb_reg_map) {
> > > > > +                    DPU_ERROR("failed cwb object creation\n");
> > > > > +                    return -ENOMEM;
> > > > > +            }
> > > > > +    }
> > > > > +
> > > > > +
> > > > > +    for (i = 0; i < cat->cwb_count; i++) {
> > > > > +            struct dpu_hw_blk_reg_map *cwb = &cwb_reg_map[i];
> > > > > +
> > > > > +            cwb->blk_addr = mmio + cat->cwb[i].base;
> > > > > +            cwb->log_mask = DPU_DBG_MASK_CWB;
> > > > > +    }
> > > > > +
> > > > >       for (i = 0; i < cat->wb_count; i++) {
> > > > >               struct dpu_hw_wb *hw;
> > > > >               const struct dpu_wb_cfg *wb = &cat->wb[i];
> > > > > 
> > > > > -            hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
> > > > > +            if (cat->cwb)
> > > > > +                    hw = dpu_hw_wb_init_with_cwb(dev, wb, mmio,
> > > > > +                                    cat->mdss_ver, cwb_reg_map);
> > > > > +            else
> > > > > +                    hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
> > > > > +
> > > > >               if (IS_ERR(hw)) {
> > > > >                       rc = PTR_ERR(hw);
> > > > >                       DPU_ERROR("failed wb object creation: err %d\n", rc);
> > > > > 
> > > > > --
> > > > > 2.34.1
> > > > > 
> > > > 
> > > > --
> > > > With best wishes
> > > > Dmitry
> > 
> > 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

