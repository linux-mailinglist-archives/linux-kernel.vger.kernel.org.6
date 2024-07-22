Return-Path: <linux-kernel+bounces-259044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA9939061
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AE128205B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC816D9DC;
	Mon, 22 Jul 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="giUCwqx5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCF1DFE3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657585; cv=none; b=HyqziTucmsXe0laNe12yFLJztF9bODNaprq5HCkV0LgKZUDqYYzrO5tUgVL9pbFKyNbqkhQ4+VJhG1hLKw8/Sr4mJFZ787hcu2Wb8PaDXSOfSdzAJnpv2oLKvoXlokoMxvBXjV7tiWUFDTraAgEnAcXDcxgJ/Rpy+bG4S9SNeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657585; c=relaxed/simple;
	bh=Ac0ZVFezlunGPwPXMVZW5bxBBc/RGcpHkhCF3Mu5yoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpAZ0lBh+SJ2Rjabw50E/n7HaTk3xVRIsDLkH4ERNUGohQrs2HyuVIaIZ8v1SvKX1e4Ww4s2KVm706GYTw55wRayGYKjEyru0khb8Hp6y9H2sVjaVOHxlLJ0gMwn3DOcfixixVPd00WcluCGScTkqbm/nw44DrnQMTyEb8dRsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=giUCwqx5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266ea4e4bdso5011895e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721657581; x=1722262381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tgbm5Spa6iNkRq2Ux0zzj+WvaN7ol/xJ5I1VMsf8wA=;
        b=giUCwqx5TOsMiiOYTyefyb54PRX1ac9GYkm+BaIVksZx6VEOTWewc9yyT07Z6KQ8dF
         NYfEWPhJ+GLgPwvNKu/lFiVImFNAb+XcI/hCc2qTsBr1YBuzwKFFtswrKwUQ3Afa+WDi
         IUFMEkVaESZkdO+rh2M4DtWWJosj/3FizblLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721657581; x=1722262381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Tgbm5Spa6iNkRq2Ux0zzj+WvaN7ol/xJ5I1VMsf8wA=;
        b=FDfkl2idPzB2KfG2/M4ey/Gj/r91/6CWxpd3NM6gIqMNjLFoHMKDKblk72YX6VxadT
         BvAHir6kbYinpHkefgaYBbn9ZJLecleox3Kj41/RKpbfGLYc0FWLDHxaBCBn+DVsx7Ol
         mOKzdk7giI6KJTGbLpLvkHT2R5dWZk3AGFSS8EE2OCQvG+ItfqwgCZ9IbCOvOrgx+RcN
         phC7SNzblS5pr0VKT4U31tvKwQ/2NmwvqfNcg1BBFP4igMCh+E1Kh/p6yC+Jv9sDd/1H
         VHrcHMSdEPC/GbdAwxK/Xp44E6NSbRrdNuEQBK9H+6CBheaSOBwFkSug+ITlWugXTC7D
         neGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAn74NX98o/sVZaZnBzAuPt1Z43Q4EAJNrChwI+OsERCuqKBHmUCETtb/StoKD2J67keJj97zvMPnpJQIRhVgPUw6hW0vl7yp3z7ts
X-Gm-Message-State: AOJu0Yx5l0tJAjBttvGHU3MG7VSlwKYprCjtG+24cMOHm5y/s84cJmNd
	jAxW9uJRZPPV8Josf5kpUzdAx9opWnHfkjZ4v5iKDseTQ/o/bN8A+wdK1ijrnac=
X-Google-Smtp-Source: AGHT+IEWsvPxVi7zS2plkJNlwJ+meC0H3C4mcFP8YEp/srMJx9fmtOr9AjHG6UxguTL2eGdmswxsrw==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr33298725e9.5.1721657580586;
        Mon, 22 Jul 2024 07:13:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6901781sm129162825e9.14.2024.07.22.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 07:12:59 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:12:57 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
Message-ID: <Zp5o6fnBuTlxm-X_@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-2-jfalempe@redhat.com>
 <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
 <34305c58-38a6-4b5a-9777-69833aefa003@redhat.com>
 <60419d31-f467-4277-97da-23c9573af2bf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60419d31-f467-4277-97da-23c9573af2bf@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Thu, Jul 18, 2024 at 11:30:05AM +0200, Jocelyn Falempe wrote:
> 
> 
> On 18/07/2024 09:04, Jocelyn Falempe wrote:
> > 
> > 
> > On 17/07/2024 17:08, Daniel Vetter wrote:
> > > On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
> > > > It allows to check if the drm device supports drm_panic.
> > > > Prepare the work to have better integration with fbcon and vtconsole.
> > > > 
> > > > Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> > > > ---
> > > >   drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
> > > >   include/drm/drm_panic.h     |  2 ++
> > > >   2 files changed, 22 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> > > > index 948aed00595e..d9a25c2d0a65 100644
> > > > --- a/drivers/gpu/drm/drm_panic.c
> > > > +++ b/drivers/gpu/drm/drm_panic.c
> > > > @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct
> > > > drm_plane *plane, int index)
> > > >   static void debugfs_register_plane(struct drm_plane *plane,
> > > > int index) {}
> > > >   #endif /* CONFIG_DRM_PANIC_DEBUG */
> > > > +/**
> > > > + * drm_panic_is_enabled
> > > > + * @dev: the drm device that may supports drm_panic
> > > > + *
> > > > + * returns true if the drm device supports drm_panic
> > > > + */
> > > > +bool drm_panic_is_enabled(struct drm_device *dev)
> > > > +{
> > > > +    struct drm_plane *plane;
> > > > +
> > > > +    if (!dev->mode_config.num_total_plane)
> > > > +        return false;
> > > > +
> > > > +    drm_for_each_plane(plane, dev)
> > > > +        if (plane->helper_private &&
> > > > plane->helper_private->get_scanout_buffer)
> > > > +            return true;
> > > > +    return false;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_panic_is_enabled);
> > > 
> > > This feels like overkill since you currently only have one user in the
> > > fbdev emulation code, but maybe useful in some other places ...
> > > 
> > > > +
> > > >   /**
> > > >    * drm_panic_register() - Initialize DRM panic for a device
> > > >    * @dev: the drm device on which the panic screen will be displayed.
> > > > diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> > > > index 73bb3f3d9ed9..c3a358dc3e27 100644
> > > > --- a/include/drm/drm_panic.h
> > > > +++ b/include/drm/drm_panic.h
> > > > @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
> > > >   #ifdef CONFIG_DRM_PANIC
> > > > +bool drm_panic_is_enabled(struct drm_device *dev);
> > > 
> > > Since it's internal only, this should be in
> > > drivers/gpu/drm/drm_crtc_internal.h and not int he include for drivers.
> > 
> > Yes, that makes sense, drivers won't need that API.
> > 
> > > With that:
> > > 
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > 
> > > >   void drm_panic_register(struct drm_device *dev);
> > > >   void drm_panic_unregister(struct drm_device *dev);
> > > 
> > > These two are only used in drm.ko. Can you please move them to
> > > drm_crtc_internal.h too and drop the EXPORT_SYMBOL in a follow-up patch?
> > > We're trying to limit the exported interface and official headers to
> > > really only the pieces drivers actually need.
> > 
> > Sure, I'll add this to my next drm_panic series.
> 
> I think this also applies to drm_panic_init() and drm_panic_exit(), that I
> introduce in my QR code series:
> https://patchwork.freedesktop.org/patch/604890/?series=135944&rev=2
> I will move them to drm_crtc_internal.h

Yup.
-Sima

> 
> > 
> > > 
> > > Thanks, Sima
> > > 
> > > >   #else
> > > > +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
> > > >   static inline void drm_panic_register(struct drm_device *dev) {}
> > > >   static inline void drm_panic_unregister(struct drm_device *dev) {}
> > > > -- 
> > > > 2.45.2
> > > > 
> > > 
> > 
> > Best regards,
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

