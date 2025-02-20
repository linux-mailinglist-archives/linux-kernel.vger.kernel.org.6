Return-Path: <linux-kernel+bounces-524941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AFA3E8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55324218DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E41264FA7;
	Thu, 20 Feb 2025 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8wUuVbB"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42789213E75
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095946; cv=none; b=QfbbKzkoH/vznhHngocKG85M7UFEfYe1SFgGgG1BUoGstOiWNTbWb6qedImHxbKkUEhy4ZXnEmre8f7GPAiAa59JZ0hotzpBS4qXxj9a2+7pHQnfbiKEpCwkSiAvzq2SbiNVHbD+8fUmI/NpD3s1/Sbq1ZdBNXvxtp/27PI3yIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095946; c=relaxed/simple;
	bh=uEZwZevB+ke9t9htkUz6VLo8kbZCeYgFLzfobqOoShI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYPmVKQHwLVascUdV8vkD/uPMk8mBIJvzM+A/+5ZFg1JaFKzHUgIaFM2AZJmXc02CVIKwMTq2GRP98pOzSmJaEiSSg6QwE8HmTuihN+LHaccn+95+s2gtMFnCU5Ma2TbHMBzP1OrBjojuuP2PMd9G9D1uqLkC6uwfDANlITdJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8wUuVbB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30761be8fcfso14060181fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740095942; x=1740700742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMtrq7jLHSed46Czeo2rEh53wj+rn3fFBHyDQDyX/HA=;
        b=U8wUuVbBa1G5g0Eb/cG/qcuSLLAaL+e2mspfAik/RKEx+B+7ykfiDgy/zYOQokrYTp
         1Hh0QbsfvaxppCaKOVyPwAkY7OZgjYwef6wsVSAaEj4L66vuqk8zh2VA1D18vEC40eyb
         pONTIrp0HzyBeTMkfaC6rWdLXlMmNnJ9Pz723dL975RMntDq8tfGc60/I1jXSCR25c93
         uYaFfmtGp7oTb9Lh19xIjnw0rOsMQ1mHITCjM8UU0AFbGIPn4kPB4OHBcQ0+xronzs5I
         MWYXPqxK6kl8K81W5oE/1jQQJH4Besr17jEGMF0aixVXaJAxzJGewUPix6LNR556EzU0
         0apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095942; x=1740700742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMtrq7jLHSed46Czeo2rEh53wj+rn3fFBHyDQDyX/HA=;
        b=vDv5CFLqCcpKzEOtwzQISyFOk4wb65xd+gAdOQJEFogtd6ZjLkrlVz1/tm02cDJDzh
         +vRwHagR/opJoaPJqTU+Q7luOdjLSWxA8BxlQDOwUp3bz82+FJDaJJRBHutenqFrevNa
         Vvtu5fGyFcJ6d06WJaWJ5RsXxtYrFq3hG6MnPfhpkKnnY+Qi3u/oXW/r8NFXl9ceAFat
         wyveWhbtAL+3rnlLl6FzZ6Op6qwOET6p8/pzl1eHloCTYwwbVm4olAcIRBcHQWW5zxJy
         dXAYO1/OxxGtBPmIV3zTLCt6oG1dMcbWVN45yBPab2P5EX+jcnHv3ljHmIVNDzegaWGF
         gGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHSpZ9IW4u4wylxqqv6+Is4CIHkKIraQy26yrF/dKJRt3qlO9kNDNaheqAXEKKDJE2hhMpDwfxbH5IpG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQek4OZHbB4gvhgWVU5dolj7t8qzaIxnTEK8HPGDobsRJNfFg3
	yD7Lt+pMd+BeQ2vSbNnyEN+QOOAD076Xe1Y8msAvlZIzNQcGTbjSLlt/ipwqUxo=
X-Gm-Gg: ASbGncuozRfyNu9P6cEcw/5Yq3YE3EGYvKkSHtWEiTgux4X2h7wJ9/kVCUc61sj2bhZ
	V6ASefT27yWZLhCiWiVQrLTGMbQzjee5md71LVoQJexH7m5oa86RbPzlbPyQ+I1O0PyBV1QlA6m
	JYNRiqEceVYON0gHhRdD1tzt6deKquaqpZsTAhwIXIaQeiFhmTBYeNy7FNk8wsSajU8ZbYv9dH+
	mXXJrhb1S29icuryTmpUVQk0ClpexX/kwJkhhTZWUKYo4PJ4A9fG7mmGgW4OwLsvbVVG2RiKR9j
	6uBWXfxgMMT3irfHvBymT6e9ZJ6JzxGSI97xNgWdqZ63jkZjoo/0hW6r1mO7YaTLhO+15m8=
X-Google-Smtp-Source: AGHT+IFRmoaRAMtXQeskCBCDhTrEaQ+Ff7h67LqHPuXzExls+JzAw5IkkULjzP9XZbzdpa2zldli3A==
X-Received: by 2002:a2e:7009:0:b0:309:23ea:5919 with SMTP id 38308e7fff4ca-30a5998baa8mr2567221fa.31.1740095942262;
        Thu, 20 Feb 2025 15:59:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091fbf58cfsm23285251fa.110.2025.02.20.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:59:00 -0800 (PST)
Date: Fri, 21 Feb 2025 01:58:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] drm/msm/dpu: allocate single CTL for DPU >= 5.0
Message-ID: <7vcnej2hh3knti66dfyatbcyrlygbwqtwdlumpf4aqmupuopcf@pcpkbn6fs4h4>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
 <20250220-dpu-active-ctl-v1-6-71ca67a564f8@linaro.org>
 <4aix26abutkas2fpj6ubu2hbqeljpgr5e3m24akeb3jz33limj@c7rymwz6zmft>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aix26abutkas2fpj6ubu2hbqeljpgr5e3m24akeb3jz33limj@c7rymwz6zmft>

On Fri, Feb 21, 2025 at 12:34:12AM +0100, Marijn Suijten wrote:
> On 2025-02-20 12:26:23, Dmitry Baryshkov wrote:
> > Unlike previous generation, since DPU 5.0 it is possible to use just one
> > CTL to handle all INTF and WB blocks for a single output. And one has to
> > use single CTL to support bonded DSI config. Allocate single CTL for
> > these DPU versions.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++----
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > index 5baf9df702b84b74ba00e703ad3cc12afb0e94a4..4dbc9bc7eb4f151f83055220665ee5fd238ae7ba 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> > @@ -53,6 +53,8 @@ int dpu_rm_init(struct drm_device *dev,
> >  	/* Clear, setup lists */
> >  	memset(rm, 0, sizeof(*rm));
> >  
> > +	rm->has_legacy_ctls = (cat->mdss_ver->core_major_ver < 5);
> > +
> >  	/* Interrogate HW catalog and create tracking items for hw blocks */
> >  	for (i = 0; i < cat->mixer_count; i++) {
> >  		struct dpu_hw_mixer *hw;
> > @@ -381,10 +383,16 @@ static int _dpu_rm_reserve_ctls(
> >  	int i = 0, j, num_ctls;
> >  	bool needs_split_display;
> >  
> > -	/* each hw_intf needs its own hw_ctrl to program its control path */
> > -	num_ctls = top->num_intf;
> > +	if (rm->has_legacy_ctls) {
> > +		/* each hw_intf needs its own hw_ctrl to program its control path */
> > +		num_ctls = top->num_intf;
> >  
> > -	needs_split_display = _dpu_rm_needs_split_display(top);
> > +		needs_split_display = _dpu_rm_needs_split_display(top);
> > +	} else {
> > +		/* use single CTL */
> > +		num_ctls = 1;
> > +		needs_split_display = false;
> > +	}
> >  
> >  	for (j = 0; j < ARRAY_SIZE(rm->ctl_blks); j++) {
> >  		const struct dpu_hw_ctl *ctl;
> > @@ -402,7 +410,8 @@ static int _dpu_rm_reserve_ctls(
> >  
> >  		DPU_DEBUG("ctl %d caps 0x%lX\n", j + CTL_0, features);
> >  
> > -		if (needs_split_display != has_split_display)
> > +		if (rm->has_legacy_ctls &&
> > +		    needs_split_display != has_split_display)
> 
> I deduced a long time ago that the check for rm->has_legacy_ctls is not needed.
> 
> needs_split_display is always false on DPU >= 5, and neither of those SoCs has
> DPU_CTRL_SPLIT_DISPLAY which means false != false is false, and this condition
> never triggers on active CTLs even without checking has_legacy_ctls.

During the transition time of 1 or 2 patches there is a window of
DPU >= 5 and DPU_CTRL_SPLIT_DISPLAY.

> 
> Other than that, this is all successfully tested and:
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> >  			continue;
> >  
> >  		ctl_idx[i] = j;
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> > index 99bd594ee0d1995eca5a1f661b15e24fdf6acf39..130f753c36338544e84a305b266c3b47fa028d84 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> > @@ -24,6 +24,7 @@ struct dpu_global_state;
> >   * @dspp_blks: array of dspp hardware resources
> >   * @hw_sspp: array of sspp hardware resources
> >   * @cdm_blk: cdm hardware resource
> > + * @has_legacy_ctls: DPU uses pre-ACTIVE CTL blocks.
> >   */
> >  struct dpu_rm {
> >  	struct dpu_hw_blk *pingpong_blks[PINGPONG_MAX - PINGPONG_0];
> > @@ -37,6 +38,7 @@ struct dpu_rm {
> >  	struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
> >  	struct dpu_hw_sspp *hw_sspp[SSPP_MAX - SSPP_NONE];
> >  	struct dpu_hw_blk *cdm_blk;
> > +	bool has_legacy_ctls;
> >  };
> >  
> >  struct dpu_rm_sspp_requirements {
> > 
> > -- 
> > 2.39.5
> > 

-- 
With best wishes
Dmitry

