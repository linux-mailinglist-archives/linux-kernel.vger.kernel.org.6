Return-Path: <linux-kernel+bounces-338255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D89298557D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3E1C226F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184115A864;
	Wed, 25 Sep 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYxVLF4u"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8F1598EE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252944; cv=none; b=bfB5qF5N8bBHeNe6sW9YlbkUlx/fe6ew0rfNj24a7N0pvLI/nrK8P/aGFTvmI5lVtDq+djFz4KEGhVGBT8o1EvUFvByWwd8AbhU5n6oSLs+4hDceD0FKx1mPFp+n2nNPkm5HA4PcHmNbG1KuZzqnaZKMDfmEcQkDsKPaqxhfXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252944; c=relaxed/simple;
	bh=q29PEj4IlMN9GSxCgG1by5KAX38sxz8FA6VWkjwf1+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In2EfPBFrJvBnSiGAosNfNaEUtfaupT0vMXjdeGGf+62r22bJDAD5kotOQfqF+dVDn4q0nTv7JCVqj8iiRjm3cVe3qOevErq7QUyrIR4bHn2tdt2DTzB3ZgYiXJCooZ4tBWvQb/MfDoLQSJ/73/3iyl3H7KV9xt+jjyIVU7nAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iYxVLF4u; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53654e2ed93so7640762e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727252940; x=1727857740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJc/ZEonsSpvQx65a5f325f6xswc665KOha+qhiv8i8=;
        b=iYxVLF4uOOaUooX9pmelWwGNWXXDY/6O5fYHVjSnvArikmH1ULv6LImgfk9uub+B+M
         9NPsqTDi1cz42N7Hfoxa397tV//PW3j0gxux+7Mk2r8Koy1H3E+q+UlStQvl6Lmr0YCs
         y/pQY6MgGLYbeu+b31hKHhtVLUW49IelRGigZuTZd3YT3zPK6Pd29sq1QugYtKUmIRVA
         3kCee9zrOIMwcNQj17nzjFSOeZYX7rs8xfwCJ/4kl6JmH48WQlE/xTKAw8/jv/WTVst9
         l8VoX6nFhfGvrZqR0epPu3IHD4uILHSSZnUQ7LFuOfYdNQ2vRNI6DLli23RkuE0YIKdZ
         TJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727252940; x=1727857740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJc/ZEonsSpvQx65a5f325f6xswc665KOha+qhiv8i8=;
        b=VtiZ34J930mzm8tQOpEngxbiSiXp4uRuVoqBF0c4IpUlnX7jdjCVe96UGrvVxIRcCC
         9OzJ0iSTMMtH/cWNwZmJo4jbTv9poc+4ylNntDgfBf8tqm1oPI4OhA164z37PCO/dVut
         hcaQ+og0S+ITBND5ZSQaK6SES6T/fpU1rATtn1fBj1ppdqz5DeBM21SqMPZ2ttm4U/Rq
         BgyBVaAVe9eHmHRKvf3CI+9rklNFzyXixMbCNiAEZ/C3kuW88ZvZTEbEOifKLqKaXsSm
         sEqp1z/6W+g7uMqxFqag3y8XGMdwKyH3znxGfF/h68dFcKXyzrnZyXr//SEGxgM6PM/s
         uz2w==
X-Forwarded-Encrypted: i=1; AJvYcCVWXGPLST+njntirFAjs5z+ZCZFrCO+jfvbo4j5JZ/fqfj8YQ+EygOJGy4DEmHo9aTjHC9SwQgnHJhMS9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBPdTmvqvarwbJZ6cgL0D3i4hLKRQV+nEwfYG8YRUEIEqdRV6
	EyttJunwX4E9Yw7Py2yfWngaCc/jMjEky84CuzX/wQw2DgBjbjbhPJMlkf+1IX8=
X-Google-Smtp-Source: AGHT+IFWtR5Spi/hxHDKmyK+yEjL67FVSC0HLJLKUPO8bW2hzqf39SxWRho/7uZXgcWIoMTcw6ko+w==
X-Received: by 2002:a05:6512:3f07:b0:535:6ba7:7725 with SMTP id 2adb3069b0e04-5387048a6d7mr1170484e87.3.1727252940511;
        Wed, 25 Sep 2024 01:29:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8648d41sm454852e87.224.2024.09.25.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:28:59 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:28:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 14/22] drm/msm/dpu: Require modeset if clone mode
 status changes
Message-ID: <zwxgml3qi3t253y2yhmi5lcpxg5odugrncfgh74y36kwubd4xv@oem2vicytu5i>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-14-7849f900e863@quicinc.com>
 <yjfe5wajajeqmcp65kbvcttzgkrsfv5rhkbvqvioqx3rwdn6g6@2h2byk2l2imy>
 <75297d0d-528a-4152-b35f-ba41fbf914dc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75297d0d-528a-4152-b35f-ba41fbf914dc@quicinc.com>

On Tue, Sep 24, 2024 at 05:05:43PM GMT, Abhinav Kumar wrote:
> 
> 
> On 9/24/2024 4:25 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 24, 2024 at 03:59:30PM GMT, Jessica Zhang wrote:
> > > If the clone mode enabled status is changing, a modeset needs to happen
> > > so that the resources can be reassigned
> > 
> > Sima's comment regarding crtc_state->mode_changed seems to be ignored...
> > 
> 
> Not ignored. One of us has to take that up. There is a broader cleanup
> required for that.

At least then it should be mentioned in the commit message or under the
commit message.

> 
> We can sync up on how to tackle this : whether it needs to be in this series
> or push another one cleaning up all the instances.


Yes, let's sync separately.

> 
> > > 
> > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > index a7850bf844db..f20e44e9fc05 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > > @@ -1268,6 +1268,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
> > >   {
> > >   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
> > >   									  crtc);
> > > +	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
> > > +									      crtc);
> > >   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
> > >   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc_state);
> > > @@ -1279,6 +1281,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
> > >   	int rc = 0;
> > >   	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
> > > +	bool clone_mode_requested = drm_crtc_in_clone_mode(old_crtc_state);
> > > +	bool clone_mode_enabled = drm_crtc_in_clone_mode(crtc_state);
> > >   	/* there might be cases where encoder needs a modeset too */
> > >   	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
> > > @@ -1286,6 +1290,10 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
> > >   			crtc_state->mode_changed = true;
> > >   	}
> > > +	if ((clone_mode_requested && !clone_mode_enabled) ||
> > > +	    (!clone_mode_requested && clone_mode_enabled))
> > > +		crtc_state->mode_changed = true;
> > > +
> > >   	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> > >   		rc = dpu_crtc_assign_resources(crtc, crtc_state);
> > >   		if (rc < 0)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 

-- 
With best wishes
Dmitry

