Return-Path: <linux-kernel+bounces-538300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60410A496D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F333A83AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5125BAB9;
	Fri, 28 Feb 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXQHh8SH"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93071253326
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737783; cv=none; b=XiafpaWidye5Dh9U48yBmgK4hM+XaJZGkHPlCbuveyElQXbdmopRINL/e6JBYjvPdNnYoSIlMdZskm3G7vvR8YtQr25J9Ox4eIsFB1SdcpUrdX7AzX2AUgkKKoSqOVQSUt2e5jmkPwMZuY7b2ipslcO1QqY73UmWjnocPZbLTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737783; c=relaxed/simple;
	bh=ElAgw7bPQpwdQMY7KlsMy4E7ti8qBB32uSy2iTZjWX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlIrs87F+xvChv/UThTv46Bp45JPC9arIAbBTHfKpa/9nDHdJCtAXWmSjzotuk9d5CMIQOcaePLac2Y48heBhxooqEIY1NHV/USx5XzNlTOX0Y4I92dHo68FJ00F4NC+HvOPagrFvzx5qi8IjNwxtNJ7CjfwKesPF2YIFzqHrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXQHh8SH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a303a656aso20440321fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740737778; x=1741342578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wat92wf7UjNd1anwYmYBV9KhWwXM1sob582ltedV7ts=;
        b=MXQHh8SHN7qhYLS0Xw/FUgcMg9llu850aedQHyKb7voHyW5x85JkHGawgounFOhokX
         t6LX6/5EMxU6JFThZ0WjwHXbpc/q8jRhOUWkXZof1WJlql+42iL2c7LgrCTAfXum/gx9
         2B6zmn2cAZGECvDjau0nA7T+hzM7o31QTEEteL3RUUmlnR47x//jhIRWtF2Q+4ZBRas2
         MdxQfHAgKHdFSYkstAKQAnifwF4NHxP+uIt92ej2f01jqqRJrxab3bSt/yN65/my9j1I
         L/MGFLN5/GzgdfGFRhP5lW+YrxyffbWpWT44qRRQ+fTAC7EUdQIUeN2CGS0IFHilJs6I
         +0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737778; x=1741342578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wat92wf7UjNd1anwYmYBV9KhWwXM1sob582ltedV7ts=;
        b=pZXCJEQui902tK6J0HzK44Q6R6mG4WGS16PPR1DQv1ZiyfjHXd/OW4wABtNAH6I1ae
         vsz50NRgqgcDNxJ98IRRG944Rawtvs0voCe1S7GIt9Bn9/lFw8UY6EWsLfPdieWMjzok
         1oOS9J+SGtop7zQBMMRujHvXPnpgetLvcDGtqCk1otsq+e7sn9/25R4IFuo45CDtmkXq
         faFTdlow5aNSQ+4dlStBcugk86XPPaUBh7x6r02MGQrhEuKa2Afd5EH1hlyP7L80t/7c
         3UIJqWoqus70MSZ//ERToY20+sH/CKnfBsRKEOLWTuWsC97ONoAlH8r/XfCxcGiV8uM/
         SWZA==
X-Forwarded-Encrypted: i=1; AJvYcCVPITxjeFEND7LO5viPL2l6J3A28XDGpT7Ox1tQLdLccwS5+t2S3m/s4b34F0jBwKnzg7dFE5Kuh6Kzhbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmeuloLK+TjpJIyhUGQKCI5kvrQpGjY67Qo2NCtuG3mV4nFdm
	MTamJw29/RsrUZH2Ll7vH0MN1yoCBsmpBvI8bLYxFZSMj7SgAAx3MpDNoJa1Lsk=
X-Gm-Gg: ASbGnctJzuUpOnSBMgjJqO6PHcvhO0ZlbWexTf2q/AUtgQ2rnMd3DesPPdzKfgcBBE/
	nhSLaVWVBra5049N7z8g4g01xkaaZRE0+8lmPFaWVMpwakca6yN3YnpkQjCxYPDujRLkIsUfRjP
	8z8FjSK6p5phdN2Kl68cxG0dqL6st5zCuB7XSYQpbUjDcEXDZT7rLha+1zv7/NGYn9QeCU1P5hB
	jfU5Rfxl5XRyPX+mMP0W+l51Ln0wOoh7TMYoVpfaLVUfb2zL85zA161r8rPA1Dpgot+bs7NWz9Z
	6ryb0RhhwBbHsyNygt3lb3Kq3uZMp4gQfCJXkYo/kppfHap6j9CBSEtqJpZpQKsBMTcakZUPfIZ
	Z6te40A==
X-Google-Smtp-Source: AGHT+IGBfL2RkQl+kxLXV/hMApga37HIH6Rl9s2LmnykJ9ZsNHMREbfcwnGOHv1Q2EhRdw2KuDyx9g==
X-Received: by 2002:a05:6512:1047:b0:545:a1a:5576 with SMTP id 2adb3069b0e04-5494c32905fmr1113184e87.22.1740737778531;
        Fri, 28 Feb 2025 02:16:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cb6ccsm445728e87.212.2025.02.28.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:16:17 -0800 (PST)
Date: Fri, 28 Feb 2025 12:16:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] drm/msm/dpu: program master INTF value
Message-ID: <r6lkyug64endt2oos4anz4lqven3rstw3oupfywnrwd3i6qece@zt36tm33lqc2>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
 <20250228-dpu-active-ctl-v2-2-9a9df2ee5193@linaro.org>
 <CAACA6C8-441A-4B6E-AC07-A46094A02126@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAACA6C8-441A-4B6E-AC07-A46094A02126@somainline.org>

On Fri, Feb 28, 2025 at 10:23:54AM +0100, Marijn Suijten wrote:
> On 28 February 2025 05:14:06 CET, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >If several interfaces are being handled through a single CTL, a main
> >('master') INTF needs to be programmed into a separate register. Write
> >corresponding value into that register.
> >
> >Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
> >Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >---
> > drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 12 ++++++++++++
> > drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h |  2 ++
> > 2 files changed, 14 insertions(+)
> >
> >diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >index 32ab33b314fc44e12ccb935c1695d2eea5c7d9b2..ffff60c4206c6f2833293fdcc56b653f7d3124a5 100644
> >--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >@@ -583,6 +583,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
> > 	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, dsc_active);
> > 	DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE, merge_3d_active);
> > 
> >+	if (cfg->intf_master)
> >+		DPU_REG_WRITE(c, CTL_INTF_MASTER, BIT(cfg->intf_master - INTF_0));
> >+
> > 	if (cfg->cdm)
> > 		DPU_REG_WRITE(c, CTL_CDM_ACTIVE, cfg->cdm);
> > }
> >@@ -625,6 +628,7 @@ static void dpu_hw_ctl_reset_intf_cfg_v1(struct dpu_hw_ctl *ctx,
> > {
> > 	struct dpu_hw_blk_reg_map *c = &ctx->hw;
> > 	u32 intf_active = 0;
> >+	u32 intf_master = 0;
> > 	u32 wb_active = 0;
> > 	u32 merge3d_active = 0;
> > 	u32 dsc_active;
> >@@ -651,6 +655,14 @@ static void dpu_hw_ctl_reset_intf_cfg_v1(struct dpu_hw_ctl *ctx,
> > 		intf_active = DPU_REG_READ(c, CTL_INTF_ACTIVE);
> > 		intf_active &= ~BIT(cfg->intf - INTF_0);
> > 		DPU_REG_WRITE(c, CTL_INTF_ACTIVE, intf_active);
> >+
> >+		intf_master = DPU_REG_READ(c, CTL_INTF_MASTER);
> >+
> >+		/* Unset this intf as master, if it is the current master */
> >+		if (intf_master == BIT(cfg->intf - INTF_0)) {
> >+			DPU_DEBUG_DRIVER("Unsetting INTF_%d master\n", cfg->intf - INTF_0);
> 
> Don't think you want to include my testing ramblings here: we didn't print a message either when the master was _set_, and don't print messages for other register writes either.

Okay, I'll drop it.

> 
> After that:
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> >+			DPU_REG_WRITE(c, CTL_INTF_MASTER, 0);
> >+		}
> > 	}
> > 
> > 	if (cfg->wb) {
> >diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> >index 85c6c835cc8780e6cb66f3a262d9897c91962935..e95989a2fdda6344d0cb9d3036e6ed22a0458675 100644
> >--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> >+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> >@@ -36,6 +36,7 @@ struct dpu_hw_stage_cfg {
> > /**
> >  * struct dpu_hw_intf_cfg :Describes how the DPU writes data to output interface
> >  * @intf :                 Interface id
> >+ * @intf_master:           Master interface id in the dual pipe topology
> 
> Not sure if you've seen my comment in v1 about the dual word; maybe the quadpipe series can update it since they might need a master (or two?) as well?

Yes, it should be updated by the quad-pipe series.

> 
> - Marijn
> 
> >  * @mode_3d:               3d mux configuration
> >  * @merge_3d:              3d merge block used
> >  * @intf_mode_sel:         Interface mode, cmd / vid
> >@@ -45,6 +46,7 @@ struct dpu_hw_stage_cfg {
> >  */
> > struct dpu_hw_intf_cfg {
> > 	enum dpu_intf intf;
> >+	enum dpu_intf intf_master;
> > 	enum dpu_wb wb;
> > 	enum dpu_3d_blend_mode mode_3d;
> > 	enum dpu_merge_3d merge_3d;
> >
> 

-- 
With best wishes
Dmitry

