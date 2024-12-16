Return-Path: <linux-kernel+bounces-447483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A8B9F3334
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F95B1885302
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E9205E04;
	Mon, 16 Dec 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aLOauIXC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F677204584
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359233; cv=none; b=ImyGoNdrFzWHVLJ+Aaj3zUpEB6XBOaHuLidbFUj+iSOpmbiQrc4c1zhlIwJ5WYkNTzog7UT0j5N7dHC2GVRSq8+PfbnTUcpSTt/YTEIX1A5185qPlfrS6ZW8bAZUEOCNc432ST2/ZcnP70HSbefJ76bTrqDcfw2T8CvzKNIliOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359233; c=relaxed/simple;
	bh=ED5JTQkZ6fE65RM3jQ6gIcZ0j02817IKZ+GJ3EmtFAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf3ScVtNzdjryGvqJJueA4/7LXp+l7nXO4b3OU5MXT35xeebALzRDS0wEiltd1IG8YHFihfrEOVg86iN16ip7jDal3kEexudfEAGKA2G1q7A3uK53X+7eWj3M7Lb7aMNCkpT7PxUPJ2KllxIRb+yxb+JjUALSI/RUGhTBGX07AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=aLOauIXC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43622267b2eso44498305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1734359228; x=1734964028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8Oktj07WxPQkf8tAMVutVUrZO5J/YvoL7NP4SyxFZg=;
        b=aLOauIXCZ2zW4HtOpxN1clNGaG39CNChA6kbCOGmQd38kiFavgqN42KUyW7cd6mH+e
         WH71OlsZqgMhQ2fYFPbTZaPq+V7jsO5/Pw7oIXoI3eNpYW3NNVEjcpUV9OY0791Ce476
         tiqOZ1VYeKnA/Zn7izIdBkdePmljvqXbPTbSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359228; x=1734964028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8Oktj07WxPQkf8tAMVutVUrZO5J/YvoL7NP4SyxFZg=;
        b=J1Uu87Yl8J4EFe79UVnFu2bEahLcTpv74Z3FU9DjnStVRM16RJVsNYzIr2oIDpZdyn
         nNlDHbPhotpVBXLgCprSUR7GhESsutZBHc72g5941wJc/e3xH3SBM/rVRLr4xV23NdCL
         MG1+UPSm+a9RZQ4o0qolEbl05XUS6Dpzxi952K87Kv8MNoMcEN5g9aEg8dbLK+GTf/O4
         6mFUmTXXCBFkx/pZeagdqsLrDvvdWncEh1bQ5SK2tpw894rVt6Nr8+QH0WRuWe4kVjjw
         soRegbdBGsR9yXkKPVYlSHVyAHjTY28HijsAv0H5sobJeI3w2XYUX7AUL36/EXQOKg7v
         sSdw==
X-Forwarded-Encrypted: i=1; AJvYcCVm6hAlhdIdYaXyCN20b1uM1tU+MyVhElb9HWO2yg7Hu4OHk1b6RHMa/zJfWtLZ1HJjVL9I/o1WCAT7Lws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sCvrkCsdUKoK94gasSxfjW8wGhvL2rOq6mibcqB77ze6lUYp
	zUJTLVPn4rEyBKrgZyIvhSXHB35/7WUpNuQufZ8fXg6qVQBDT831XuaBo8xU4vc=
X-Gm-Gg: ASbGnctu8apWwGzg0kjWS37D1i4qw6hM5L3elIS+/O/YHXs3KG4biLscT13yeoZQjpd
	+FbYjc2WQfZWAWA1kEkph12d1gzPIGOoX2Jh+nBH1Z7yiYwBinCykWrdAvZUcbkJ1cWdR7ObEP+
	nQr9b7DZHaGXhqiQnVRXHz/mXYZOFhKfMISGRl0zk02rFrfHmAfnTdSK2egHTcGH2i8G/Xk9sOp
	yVP7oZkVxC/fwsa1NEl9h9HxRIzPFjH33fb1fO4UOFNk4keFjuZu6VZmtNwWrddGBeU
X-Google-Smtp-Source: AGHT+IGn5RgQ81hy0jW21u7TUA0sQjR5dFe9QEPAlFJD5h/VCFCRbd8HnQjhW9nAjZ+l5PGK8UsXnQ==
X-Received: by 2002:a05:600c:b99:b0:435:9ed3:5698 with SMTP id 5b1f17b1804b1-4362aa9784cmr102190165e9.24.1734359228496;
        Mon, 16 Dec 2024 06:27:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c54bsm141004955e9.13.2024.12.16.06.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:27:07 -0800 (PST)
Date: Mon, 16 Dec 2024 15:27:05 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maxime Ripard <mripard@kernel.org>, Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 02/22] drm: Add valid clones check
Message-ID: <Z2A4uahCHuOz45Fc@phenom.ffwll.local>
Mail-Followup-To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maxime Ripard <mripard@kernel.org>, Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-2-7849f900e863@quicinc.com>
 <20240925-hasty-bald-caribou-eedbf5@houat>
 <80d08449-71de-4a7f-8b2a-8af565d8d701@quicinc.com>
 <54188c68-41c7-4a42-9eca-67363b30217a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54188c68-41c7-4a42-9eca-67363b30217a@quicinc.com>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Sun, Dec 15, 2024 at 06:19:08PM -0800, Abhinav Kumar wrote:
> Hi Maxime
> 
> Gentle reminder on this one.
> 
> We are looking for some advice on how to go about KUnit for this static
> function.
> 
> Please help with our question below.
> 
> Thanks
> 
> Abhinav
> 
> On 12/6/2024 4:48 PM, Jessica Zhang wrote:
> > 
> > 
> > On 9/25/2024 12:23 AM, Maxime Ripard wrote:
> > > On Tue, Sep 24, 2024 at 03:59:18PM GMT, Jessica Zhang wrote:
> > > > Check that all encoders attached to a given CRTC are valid
> > > > possible_clones of each other.
> > > > 
> > > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > > ---
> > > >   drivers/gpu/drm/drm_atomic_helper.c | 23 +++++++++++++++++++++++
> > > >   1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> > > > b/drivers/gpu/drm/drm_atomic_helper.c
> > > > index 43cdf39019a4..cc4001804fdc 100644
> > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > @@ -574,6 +574,25 @@ mode_valid(struct drm_atomic_state *state)
> > > >       return 0;
> > > >   }
> > > > +static int drm_atomic_check_valid_clones(struct
> > > > drm_atomic_state *state,
> > > > +                     struct drm_crtc *crtc)
> > > > +{
> > > > +    struct drm_encoder *drm_enc;
> > > > +    struct drm_crtc_state *crtc_state =
> > > > drm_atomic_get_new_crtc_state(state,
> > > > +                                      crtc);
> > > > +
> > > > +    drm_for_each_encoder_mask(drm_enc, crtc->dev,
> > > > crtc_state->encoder_mask) {
> > > > +        if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
> > > > +            crtc_state->encoder_mask) {
> > > > +            DRM_DEBUG("crtc%d failed valid clone check for mask
> > > > 0x%x\n",
> > > > +                  crtc->base.id, crtc_state->encoder_mask);
> > > > +            return -EINVAL;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   /**
> > > >    * drm_atomic_helper_check_modeset - validate state object for
> > > > modeset changes
> > > >    * @dev: DRM device
> > > > @@ -745,6 +764,10 @@ drm_atomic_helper_check_modeset(struct
> > > > drm_device *dev,
> > > >           ret = drm_atomic_add_affected_planes(state, crtc);
> > > >           if (ret != 0)
> > > >               return ret;
> > > > +
> > > > +        ret = drm_atomic_check_valid_clones(state, crtc);
> > > > +        if (ret != 0)
> > > > +            return ret;
> > > >       }
> > > 
> > > Pretty much the same comment, we should have kunit tests for this.
> > 
> > Hey Maxime,
> > 
> > I'm working on the kunit test for this and had a question on the design
> > for the unit test:
> > 
> > Since this is a static helper that returns a pretty common error code,
> > how would you recommend going about making sure that
> > `drm_atomic_check_valid_clones()` specifically is returning the error
> > (and not a different part of check_modeset) when testing the
> > check_valid_clones() failure path?

So the usual way to test very specific things of a big function is to
first setup a driver and atomic request which does pass all checks. And
then do a minimal change which does not pass anymore.

So what you could do here is have 3 connectors 1 crtc, but only the first
two connectors can be cloned. Then do an atomic request with those two
connectors and the crtc. Then the 2nd request is with one of the
connectors replaced with the 3rd one (so it's still a clone config, but
not an invalid one), then have a failure.

Note: I didn't check all the details, I might be getting something wrong
here, but the idea should work.

Cheers, Sima

> > 
> > Thanks,
> > 
> > Jessica Zhang
> > 
> > > 
> > > Maxime
> > 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

