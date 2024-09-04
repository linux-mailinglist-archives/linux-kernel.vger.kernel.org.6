Return-Path: <linux-kernel+bounces-311840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CB968E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1317E1C22F1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585881AB6F3;
	Mon,  2 Sep 2024 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uoo6M8Zl"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93D1552E3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304818; cv=none; b=TYZUgBEJ4sskp6Kt1xb0tE11P0vZ4rbGR4WuijAy/eCIZG6nIOUwcYRnpUQlPTllQMnrznEucrzNYCX2AKGA73nW/gCgsFkySXUxRyLxb/s3ljzGHRhw4/slpOkoQJGfwYQRpgeYsmwZOlG8SWJh9vD1MhD0aIkLlPk7kL8auSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304818; c=relaxed/simple;
	bh=cmawlIm1yQd/9nEXCuK21y7Yb+lglVWJwuFvLA1PTno=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFy68vcCT7s3q79cOihjKoIZBX/DUgnRZRk2YeRT8UPHfrSxdaV3fc92BfWREyoZPxNdFupxsdhgOFS4z6SqWAtJzpWjV6DzQXrOnMIMkv2ztlikaEwib6iWCs6G4qInAobUSM3HPUVzZYJBeQxtH0sWr7YJVhEKxK5IwFcAS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uoo6M8Zl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5343617fdddso7791022e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725304815; x=1725909615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUGAXK1hKOV3+wB8uekRhtvLfY66UbI/02mitVxdOs0=;
        b=Uoo6M8ZlFPEtKq/XB8ebgT6FcVrRT/vHpnSZJnL3xmfwiBk6svuLSSBSRSrkzg740a
         wwOoHj4jXhDI1C5OXVBOS4Qa3YzWEptOKqQ8muqTuv17zC5uOQ9XKH9gDxPXymzqc3wZ
         csiX5A8m+ell1QPXlYI56+O1Z3kLkM0a9EEUFFoj5n3u9cnlvoIA0ZeOXT2q+eY57I4w
         ZxIpallXRMsDaSTKwbQzDLkWsQwB/nhOMpicKDICB728fG3SHm9jbaOZ7gE3ryt72EIG
         pjIBcoX3jh4BiqkzAPIqS9Aep95BhbkV04u0xIJcM+ljLAJl9y/zNU7jS/K6ZfRMkLVM
         IRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725304815; x=1725909615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUGAXK1hKOV3+wB8uekRhtvLfY66UbI/02mitVxdOs0=;
        b=mrrUHEoM5ijpcCF9iN4zViq+mbG99hq/zs05zXmsY9eha1VkK6cRAy3nT92k3qPqpq
         oPFLTZ+/szyUBSoqBvlzq/9gxtBIH3epsNu/e/Nw3nXWGAsOyBE6ui+gILwvn7UcdpKZ
         sw3r75Se97IQ98R3fmwPyeTj7NgY++x78TPbKNpsKwolj5i63+iXNgkjgvXJOb4uTNJo
         XRZBaoQprSFQt/gz+rbSKTS8pVS8H3hrJyuqLe08dTv/xFjVCp3HH3Pgi1UNEBYL+rI/
         f5qxFrd0+ZPdQ4g3i9c5t43xx80bZ9Gg/+FEmnmV3g1ED69MP+lboBxDRACOgBx5XdrH
         KO+A==
X-Forwarded-Encrypted: i=1; AJvYcCU6MfHEoJc8I2l7JjEUa/iSECwNtJv0yI1NDaLmDstuG/sGweTWV0Mm4LUMwTcDwC6j+0W4Dlqn/k1UKgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXl4KqZF6qM16vxhRJ4+0ItTnieBYWSCqkcHFJ3PSP08HkQQJ7
	zKILjxRj5gTt/8Imvjk/msFC8ZEwVXlPVQFGcVrD42VhucaSAp5baEZRatVikvI=
X-Google-Smtp-Source: AGHT+IGGo56pov4G+ai8zQD/ZYuRwqu3sLehEJovaHclSKmZPLCymGG8vHRMwdbvoarWm4cuSQl1jg==
X-Received: by 2002:a05:6512:159d:b0:52f:cd03:a84a with SMTP id 2adb3069b0e04-53546bde0f1mr9344200e87.39.1725304814162;
        Mon, 02 Sep 2024 12:20:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084ddd9sm1747449e87.256.2024.09.02.12.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 12:20:13 -0700 (PDT)
Date: Mon, 2 Sep 2024 22:20:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 13/21] drm/msm/dpu: Require modeset if clone mode status
 changes
Message-ID: <zg3v3uoq2j6qqnqai4epdsdqdkd7tr36dfb3nbtggc2wrmhszl@dkfqbb2g6lun>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-13-502b16ae2ebb@quicinc.com>
 <ZtW_S0j5AEr4g0QW@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtW_S0j5AEr4g0QW@phenom.ffwll.local>

On Mon, Sep 02, 2024 at 03:36:11PM GMT, Daniel Vetter wrote:
> On Thu, Aug 29, 2024 at 01:48:34PM -0700, Jessica Zhang wrote:
> > If the clone mode enabled status is changing, a modeset needs to happen
> > so that the resources can be reassigned
> > 
> > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > index 1b0cc899e8c1..99eaaca405a4 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > @@ -1306,6 +1306,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
> >  	int rc = 0;
> >  
> >  	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
> > +	bool clone_mode_requested = drm_crtc_in_clone_mode(crtc->state);
> > +	bool clone_mode_enabled = drm_crtc_in_clone_mode(crtc_state);
> >  
> >  	/* there might be cases where encoder needs a modeset too */
> >  	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
> > @@ -1313,6 +1315,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
> >  			crtc_state->mode_changed = true;
> >  	}
> >  
> > +	if ((clone_mode_requested && !clone_mode_enabled) ||
> > +			(!clone_mode_requested && clone_mode_enabled))
> > +		crtc_state->mode_changed = true;
> 
> So two things, and kinda about the overall patch series:
> 
> - msm is confused about crtc_state->mode_changed, e.g. it sets it if
>   crtc_state->active_changed, which is wrong. Or msm dpu code doesn't use
>   drm_atomic_crtc_needs_modeset() correctly.

This seems to be a leftover from prehistoric times and it should be
removed or reworked. I'll take a look during the next development cycle.

> 
> - changing crtc_state->mode_changed from your crtc or plane callbacks
>   means you cannot use drm_atomic_helper_check directly, but need to roll
>   your own that calls drm_atomic_helper_check_modesets again as needed.
>   See the kerneldoc comment for drm_atomic_helper_check_modesets()
> 
> - the same holds if you set mode_changed from your encoder or bridge
>   functions, but I think this doesn't apply here for this patch.

Yes. But we have it already in dpu_encoder.c. And we didn't notice that.

We have the code in dpu_encoder.c which makes sure that the hardware
resources get reallocated if required. As we already have code in
msm_atomic.c which sets mode_changed for this purpose (before calling
drm_atomic_helper_check()) it might simply make sense to add pre-check
callbacks to msm/dpu encoder. I will try working on that during or after
the LPC if Abhinav doesn't pick up that issue.

In the end we still have debt regarding the allow_modeset in
msm_atomic_check(), I remember.

> 
> I think it'd be really good to
> 
> - review existing kerneldoc and please submit patches where it's not clear
>   or detailed enough
> 
> - add checks to the atomic helper code to catch this. I think the best way
>   would be to check if drm_atomic_crtc_needs_modeset() changes outside of
>   areas where the helper code allows it already (essentially connector
>   functions setting ->connectors_changed), and set a new
>   drm_atomic_state->dirty_needs_modeset. Which
>   drm_atomic_helper_check_modeset would clear, and which would result in a
>   WARN_ON in drm_atomic_check if it's not yet cleared when the driver
>   returns with success.
> 
>   Otherwise there's just no way I think to make sure drivers get this
>   right.
> 
> Can I please sign you up for these patches?

Ack.

Thanks a lot for pointing out the issue!

> 
> Thanks, Sima
> 
> > +
> >  	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> >  		rc = dpu_crtc_assign_resources(crtc, crtc_state);
> >  		if (rc < 0)
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
With best wishes
Dmitry

