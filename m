Return-Path: <linux-kernel+bounces-529202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13681A421B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFBE4408CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B48243369;
	Mon, 24 Feb 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5osQ64j"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D417C61
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404358; cv=none; b=sPWU2vphNK8iXJmuHcqCTM2AYXQ8+fZbIDQXvaML+7QiU6ytu8ilqRDg5H5w75ETpvFZWVwVedKRImRoM+nWWO884jV3ZO/+U7azMr+LsMc2SP0c+I2ovwAUFFNY5S1YWIseYphKnpViIAK5giNQHj5CpxaNOLUbFz3b9ZiBnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404358; c=relaxed/simple;
	bh=2Q0BHdgQDmG9X8NLzS/hG5zXNRKSKOpJ6FUVcWK6oQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN4eFOqPhQRrY9MsPED4PWM3WDT1I0gFBTJ+VsN5hehvt2Gc0qhuKfivVaBK8QNU4/isrcUGbUnjeib/+tA+WOYStFbcJtzn6PDuA9qPkw6Ob3RM+dc3eP5bGHYJrxclUhOrvC3V3DhrsIYY2OHOhYWGNkQtPqCuBHiEoWdwniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x5osQ64j; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30797730cbdso43540691fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740404354; x=1741009154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpiZKM1D+dktug9FLneInEDvc/Zhfv4RR713WMJNSc8=;
        b=x5osQ64j8GvnO2Gqxu/8DN2oxzAt0k2QW5flkuRG/ykRcq4u0tcRwz7iTcL5bjiWiN
         RahPaPnIaEqFKa4gBeCR3Le3/nANyNRfvwPeB87V5Fs9yZjDLrfhG16iNheACVpeyaiI
         JHPvFuOt6b+WO657QxIN+7YwB2dWfZXjzkf7i7+Fir8+Gr5eGxHFXv85iiK5+a/290q/
         V392NKro8CDTmORaohRFd94Oh6NFGh2nW+AcEJPGqNQmunIK38CD2N/bkuRpjcHE6GP4
         1HGpzH8mc6ofH/JMrqwOQ1phYJqDD4UqtrF5r9XtUrB1n9xYXLHUdwJc1IUg5TxR7TXQ
         gSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404354; x=1741009154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpiZKM1D+dktug9FLneInEDvc/Zhfv4RR713WMJNSc8=;
        b=bwZLHqxuLkF+rWBGQb49i5Vv7UFCFDFpDHBSAThugceszkrrA6FQxfK8NJaxFPgqk8
         PqKsM8dXhaSp14vpk72A+Em9m/Wck++3iEZxy1GKxKM1Tgcgxq3CTWrdXVm4JDpaZ0Zc
         Ub5gjzmJ7pPr7wcvgd/pJn4Cp+w2uIjBe031msHn3gOPTLF2pb6P0iffZy9PnGicIm4+
         vilJ7LBkb/LhNLVCxy8COrCYsSFZE8ilIWegkBCpSXGyJqZ/vtQMCVbzL0wKD+zJBgPZ
         JjFfoc45J+cl6gfwf4sMHpp9FryGSSj+gr7s8Cp42I13xWOuACMZ6dexN8Zn55m0gVnS
         nkrA==
X-Forwarded-Encrypted: i=1; AJvYcCV0E7NAJ1x0ZUnWKLtVKqrzVM9M7Y487MSDFaGXrzs0mSQgqVaHD8pYgdHnRSeZV78jNiVL8aeDzUHmdII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlVukLbpWMMl1XaNrc9xvTJpbu0XCVxIeOh2DTPElYYCl/1AL
	OpWoNPsfmF6zWfM0rcd2cEXd7fAVYfSXq4TnecoFEMyexMKIoUVK5Eqx4+93vSQ=
X-Gm-Gg: ASbGnctzewItHlS2P9pbV4mtLzH6jH5/0//9g0Zn2vnV5AbAmxWJafoShGzlcvA9kow
	qHBy5xvXLPW6YCeQ+uquzTUqQLad7YVA4W2adRQxJaAoLKHxNr7xz9SPyj/HcOIsBvO329OYRXt
	AgzIvOvLTyfdzsNN/z4Tw4j9aZM6+lVLXuakWXUBq8I0fmM53xBrkArFT3dVHucYm5/C6xi+rNQ
	mV4lfmtg/bko9Ed/vnbC8abubtzkKjkPnDJK3VAUKaMMECgIxwhOxr2uxiYcp59ZT4m/FYU3j3n
	flPK6AZRDK/viFUHT0d8mSYCCIXJlTcfZzH5/W6Naj0wCpsjG9V+wjbw9jTqwKHuPYHDDv52Ph8
	iLaD2qw==
X-Google-Smtp-Source: AGHT+IGpWpgpPy98plh9aAWeGN4aFpnSv7Z09YXBn/2iaCyySuDx/5dPxRzvR239TBYipIAbDWvEPQ==
X-Received: by 2002:a2e:9b05:0:b0:308:f6fc:9569 with SMTP id 38308e7fff4ca-30a59986b49mr35140841fa.29.1740404353659;
        Mon, 24 Feb 2025 05:39:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091e04742esm34522851fa.86.2025.02.24.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:39:13 -0800 (PST)
Date: Mon, 24 Feb 2025 15:39:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] drm/msm/dpu: allocate single CTL for DPU >= 5.0
Message-ID: <d4chicea6vhlbvw23lclnqovlhq4rfdtefkk66vnbo5y3wf5y4@ajrutdjao2e2>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
 <20250220-dpu-active-ctl-v1-6-71ca67a564f8@linaro.org>
 <4aix26abutkas2fpj6ubu2hbqeljpgr5e3m24akeb3jz33limj@c7rymwz6zmft>
 <7vcnej2hh3knti66dfyatbcyrlygbwqtwdlumpf4aqmupuopcf@pcpkbn6fs4h4>
 <n6cljmchentiycfbnlxoptl6gtrv5n5353gdmvbrrssfp7mkiy@lenjcbxn732p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n6cljmchentiycfbnlxoptl6gtrv5n5353gdmvbrrssfp7mkiy@lenjcbxn732p>

On Mon, Feb 24, 2025 at 01:38:22PM +0100, Marijn Suijten wrote:
> On 2025-02-21 01:58:58, Dmitry Baryshkov wrote:
> > On Fri, Feb 21, 2025 at 12:34:12AM +0100, Marijn Suijten wrote:
> > > On 2025-02-20 12:26:23, Dmitry Baryshkov wrote:
> > > > Unlike previous generation, since DPU 5.0 it is possible to use just one
> > > > CTL to handle all INTF and WB blocks for a single output. And one has to
> > > > use single CTL to support bonded DSI config. Allocate single CTL for
> > > > these DPU versions.
> > > > 
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++----
> > > >  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
> > > >  2 files changed, 15 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > > index 5baf9df702b84b74ba00e703ad3cc12afb0e94a4..4dbc9bc7eb4f151f83055220665ee5fd238ae7ba 100644
> > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > > > @@ -53,6 +53,8 @@ int dpu_rm_init(struct drm_device *dev,
> > > >  	/* Clear, setup lists */
> > > >  	memset(rm, 0, sizeof(*rm));
> > > >  
> > > > +	rm->has_legacy_ctls = (cat->mdss_ver->core_major_ver < 5);
> > > > +
> > > >  	/* Interrogate HW catalog and create tracking items for hw blocks */
> > > >  	for (i = 0; i < cat->mixer_count; i++) {
> > > >  		struct dpu_hw_mixer *hw;
> > > > @@ -381,10 +383,16 @@ static int _dpu_rm_reserve_ctls(
> > > >  	int i = 0, j, num_ctls;
> > > >  	bool needs_split_display;
> > > >  
> > > > -	/* each hw_intf needs its own hw_ctrl to program its control path */
> > > > -	num_ctls = top->num_intf;
> > > > +	if (rm->has_legacy_ctls) {
> > > > +		/* each hw_intf needs its own hw_ctrl to program its control path */
> > > > +		num_ctls = top->num_intf;
> > > >  
> > > > -	needs_split_display = _dpu_rm_needs_split_display(top);
> > > > +		needs_split_display = _dpu_rm_needs_split_display(top);
> > > > +	} else {
> > > > +		/* use single CTL */
> > > > +		num_ctls = 1;
> > > > +		needs_split_display = false;
> > > > +	}
> > > >  
> > > >  	for (j = 0; j < ARRAY_SIZE(rm->ctl_blks); j++) {
> > > >  		const struct dpu_hw_ctl *ctl;
> > > > @@ -402,7 +410,8 @@ static int _dpu_rm_reserve_ctls(
> > > >  
> > > >  		DPU_DEBUG("ctl %d caps 0x%lX\n", j + CTL_0, features);
> > > >  
> > > > -		if (needs_split_display != has_split_display)
> > > > +		if (rm->has_legacy_ctls &&
> > > > +		    needs_split_display != has_split_display)
> > > 
> > > I deduced a long time ago that the check for rm->has_legacy_ctls is not needed.
> > > 
> > > needs_split_display is always false on DPU >= 5, and neither of those SoCs has
> > > DPU_CTRL_SPLIT_DISPLAY which means false != false is false, and this condition
> > > never triggers on active CTLs even without checking has_legacy_ctls.
> > 
> > During the transition time of 1 or 2 patches there is a window of
> > DPU >= 5 and DPU_CTRL_SPLIT_DISPLAY.
> 
> Correct, but would there be any harm in reordering the patches?  Before this
> patch DPU_CTL_SPLIT_DISPLAY seems to have caused wrongfully allocating multiple
> CTLs when multiple intfs are requested anyway.

Why do you think that it is done wrongly? Before this patch there was no
way to use one CTL in such a case.

> 
> - Marijn
> 
> > > Other than that, this is all successfully tested and:
> > > 
> > > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > 
> > > >  			continue;
> > > >  
> > > >  		ctl_idx[i] = j;
> > > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> > > > index 99bd594ee0d1995eca5a1f661b15e24fdf6acf39..130f753c36338544e84a305b266c3b47fa028d84 100644
> > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> > > > @@ -24,6 +24,7 @@ struct dpu_global_state;
> > > >   * @dspp_blks: array of dspp hardware resources
> > > >   * @hw_sspp: array of sspp hardware resources
> > > >   * @cdm_blk: cdm hardware resource
> > > > + * @has_legacy_ctls: DPU uses pre-ACTIVE CTL blocks.
> > > >   */
> > > >  struct dpu_rm {
> > > >  	struct dpu_hw_blk *pingpong_blks[PINGPONG_MAX - PINGPONG_0];
> > > > @@ -37,6 +38,7 @@ struct dpu_rm {
> > > >  	struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
> > > >  	struct dpu_hw_sspp *hw_sspp[SSPP_MAX - SSPP_NONE];
> > > >  	struct dpu_hw_blk *cdm_blk;
> > > > +	bool has_legacy_ctls;
> > > >  };
> > > >  
> > > >  struct dpu_rm_sspp_requirements {
> > > > 
> > > > -- 
> > > > 2.39.5
> > > > 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

