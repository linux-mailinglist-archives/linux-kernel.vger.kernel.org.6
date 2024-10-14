Return-Path: <linux-kernel+bounces-363336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F999C0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E521F2375C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE53146D65;
	Mon, 14 Oct 2024 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0TF3mS/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F534C7C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890007; cv=none; b=JSz4xvEWNH0BunBIsypMLnTIj7PGAx1P5KelYYEIUJfDyFuxhF1kqFSQr7aSt4XFxD4WjFzo7oF2k++AM1+IPerz5nO7tudFocAZB1GucBltW3LhuOKqW2rE8jI00UFkJ2g/0dAB3H/LbySh2qRSWwuzTazkm3Y8dbHVxQVu56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890007; c=relaxed/simple;
	bh=soZUGN/CewBFVNfdz3KR1OQHSXx2AxZY9PlPrmTUB3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn56es+k7o7eR9DhtB2bBpprd1USmlb6mgNO/8zk0z03Fu4/EAL5M7TuB8hlvLNpFXcWuxK4WMa5C5GS2giCT07avsHUM94NdQptBoqDLquC87o4g0tGrjM5fH77gRzuo3FkrsctTf3K5c+f71mlDPWn6+saBT7z4XjvrUob1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0TF3mS/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e13375d3so2489743e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728890002; x=1729494802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cthvJbNHIUuZVAOfCaJNB5q9EvmZX6lNdstcrG6zo4=;
        b=Z0TF3mS/KRDkX2o+DMktKlS0MlrXrbbV3PtR5XQmp+LiHKlkPfPZ0QNMBmYpjY7obu
         KtSYnHm/WcfRVnHoyKhvuceQ/wMIubgXTkfaVUDWiVJR3fP8BxdGtEUeJG6ZDG0NJF0Z
         I/v58gBBYt31/z5K2OCw2nTkXngpwEfb4dmTA3gaFGI07fN1VLp+xzbTUgsLQJxNkrXV
         xFZJL1tMzvLsyubGCQSXWF7bLgA/9SfwfVWAoJAKeDaJ7gWLpuNoBfCPybyQ+GO72ZYW
         YikR7YvV12IoGm7MFn5yil0WpzrSx6P9Y18hcXXJ8bhxymbsz3RP98UVyYmpu1z1mw9A
         JJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728890002; x=1729494802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cthvJbNHIUuZVAOfCaJNB5q9EvmZX6lNdstcrG6zo4=;
        b=gs+omX0jYlVjHbRBy+KnVepYPlwb3SE7A5okOhZB56tcqoc8friLeFp0CxlzhsJVnm
         fspKqyUOQ/fcj3mZ2Sf9Ux6lQfCBjuz0kfMOI0mvfLm6OADLnBE4J/EJE1mDhb3bzJiS
         kjdL8Kauvb+fgve2XpiT6tP6yfuxt7a2ruJegFQAu2Xs/eH6lZZvg3m+JkRZaMJfb0rP
         +JJt0SvPsYx3AK4psLV+xn850Ta/NrDTZtDBo1P2UzVwriO+4ZCT2/+xon8XXT9FHFfS
         KlWKNV/+aQeZscg+vEaO1wTClcAx64+9zptUBWjMPKfaRJf9FH/vwnNHf9x/TvdLk8VQ
         hSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMUAI3LaJtmMqff4nIpCXzcN2z9QzKHMHoLGxgsjQfyY+7neLHbq6NWz6oZkwW4X9LWe41t81kkYwbjdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxledVOUvS1KZ/3pAMTUJ441vmx0lNDoaifyfXg807ClT1CF+Qe
	1A/GSr9w4RuwmvnUHZ2IyYNIdrWjhHLWFO+aCoVnmaYd+gUjPFbzdoKkhPzaK1E=
X-Google-Smtp-Source: AGHT+IEBN6UgXvC/JiYyQZMKU0lBe2gQnD6YwBDWWDisNaW1eInShMqX2HIrW1+nlG/NKSGaVJphGw==
X-Received: by 2002:ac2:4c4e:0:b0:535:d4e6:14e2 with SMTP id 2adb3069b0e04-539da4fb618mr4542670e87.36.1728890002303;
        Mon, 14 Oct 2024 00:13:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539d69405e9sm1224978e87.280.2024.10.14.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:13:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:13:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: don't always activate merge_3d block
Message-ID: <pahfbstxa6snym7bem456npsp6bdekjqhnjcsrlpbfn77hkrut@uviaesubwz2a>
References: <20241011-merge3d-fix-v2-1-2082470f573c@quicinc.com>
 <kah73euzauizsxvcrgmfsatshfe4pytgb7xe5iprtajg7abhsv@l7jdcxza5gd2>
 <0ca707a4-bd5f-4a31-a424-f466afa08e0d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ca707a4-bd5f-4a31-a424-f466afa08e0d@quicinc.com>

On Sun, Oct 13, 2024 at 07:37:20PM -0700, Abhinav Kumar wrote:
> Hi Dmitry
> 
> On 10/13/2024 5:20 PM, Dmitry Baryshkov wrote:
> > On Fri, Oct 11, 2024 at 10:25:13AM -0700, Jessica Zhang wrote:
> > > Only enable the merge_3d block for the video phys encoder when the 3d
> > > blend mode is not *_NONE since there is no need to activate the merge_3d
> > > block for cases where merge_3d is not needed.
> > > 
> > > Fixes: 3e79527a33a8 ("drm/msm/dpu: enable merge_3d support on sm8150/sm8250")
> > > Suggested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > ---
> > > Changes in v2:
> > > - Added more detailed commit message
> > > - Link to v1: https://lore.kernel.org/r/20241009-merge3d-fix-v1-1-0d0b6f5c244e@quicinc.com
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > LGTM now. Please clarify, is there any dependency between this patch and
> > [1]
> > 
> 
> No dependency as such. Both are tackling similar issues though. One for
> video mode and the other for writeback thats all. Namely:
> 
> 1) We should not be enabling merge_3d block if two LMs are not being used as
> that block needs to be enabled only to merge two streams. If its always
> enabled, its incorrect programming because as per the docs its mentioned "if
> required". Even if thats not causing issues, I would prefer not to enable it
> always due to the "if required" clause and also we dont need to enable a
> hardware sub-block unnecessarily.
> 
> 2) We should be flushing the merge_3d only if its active like Jessica wrote
> in the commit message of [1]. Otherwise, the flush bit will never be taken
> by hardware leading to the false timeout errors.
> 
> It has been sent as two patches as one is for video mode and the other for
> writeback and for writeback it includes both (1) and (2) together in the
> same patch.

I think it's better to handle (1) in a single patch (both for video and
WB) and (2) in another patch. This way it becomes more obvious that WB
had two different independent issues issues.

> 
> I thought this separation is fine, if we need to squash it, let me know.
> 
> Thanks
> 
> Abhinav
> 
> > [1] https://lore.kernel.org/dri-devel/20241009-mode3d-fix-v1-1-c0258354fadc@quicinc.com/
> > 
> > > 
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > > index ba8878d21cf0e1945a393cca806cb64f03b16640..c5e27eeaff0423a69fad98122ffef7e041fbc68e 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > > @@ -302,7 +302,7 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
> > >   	intf_cfg.stream_sel = 0; /* Don't care value for video mode */
> > >   	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
> > >   	intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
> > > -	if (phys_enc->hw_pp->merge_3d)
> > > +	if (intf_cfg.mode_3d && phys_enc->hw_pp->merge_3d)
> > >   		intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
> > >   	spin_lock_irqsave(phys_enc->enc_spinlock, lock_flags);
> > > 
> > > ---
> > > base-commit: a20a91fb1bfac5d05ec5bcf9afe0c9363f6c8c93
> > > change-id: 20240828-merge3d-fix-1a8d005e3277
> > > 
> > > Best regards,
> > > -- 
> > > Jessica Zhang <quic_jesszhan@quicinc.com>
> > > 
> > 

-- 
With best wishes
Dmitry

