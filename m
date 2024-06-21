Return-Path: <linux-kernel+bounces-225070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3980912B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305101C2250E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73515FCFE;
	Fri, 21 Jun 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NjjGpzV9"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653C15F412
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987849; cv=none; b=YLpg2CfbbZ0/9w7FHdTBQmXO8OKPVcBpdNx6YNHQZARLeqBFIvVRM1zerVoc8EC3vExhr5r7hTcCiBvx222wOymWfZAHp+W6EhHonL74eWQz5lkPp+b+2lOJPLl1HZWucCN1llOKyj2rm603W/vT4iLB+IJ5TYmpKnzKcjUOLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987849; c=relaxed/simple;
	bh=Ju/L6HjNk94nS8RJ5lAjD0K5RBfT8p4Mjt4RcZ3KuE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEpeoVV7BGSwKSYLA9oZzdoLJIAGyIxBniWOg7Bw/DJiYOP7r4wn2FatdYptcsSEuVyXG0h33uGCuomsjKurjvt5/myz7UxyRR7plqo237emyx+yuizF/UWaPzi+u3PcF6iRVz9evVRMkcnjeZu8nAot4xagk5MM7nw4YEp/LzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=NjjGpzV9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42181803bf2so3253785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718987845; x=1719592645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjchbneGrDWxr8AFTRkd9v6VKSwRAoQm1Q6qE+BStWQ=;
        b=NjjGpzV9pdfGEoGalvaJskkcJk4fY/io35v6Yab8thyMyIFMOKxNQmAj9LMnGb06RB
         yGd5tdSh/xpy3O3Yc8zUrTWNLCwrsrd6wTT1vg8yIxbh5ouE03UiU2ftzkrbvUFTtZhr
         e5Kk00JnDapTW8jBaUL/TQkuY4JV0VJXdTVZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718987845; x=1719592645;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjchbneGrDWxr8AFTRkd9v6VKSwRAoQm1Q6qE+BStWQ=;
        b=M225l7c8DfE6zCkXvIuNaZBqIFfY3A5s5+BzBNL29rZNEQ/I1m6q9zar33rXDpUjeZ
         b2Z9RmxNwllxqe+3852okyHZUQOs8yGi7rDVOZQYKQucVY5RbejySWYg8jNBNRh36LVj
         T658JVVz1J4iZg1encjbRrs1h6BQvHQWZKd9MVvvtjI0mch7rWu3qiQX1PdA7XKLy6Df
         oTCD8RbB665G6csEK9Gct8A3gfF1YXhREb3rFASg9Tizx3RWeBrttPkRdQYJHY6ZdE5B
         YGhV+whj/smkn1h5mrheXOKhkxCFeYdZdFwWXdzxSKDsU3UtACJbgjGC9y/CqgeaHbPe
         kmqA==
X-Forwarded-Encrypted: i=1; AJvYcCWJlbDe7c/vqYpfuZ8YMC4FdxO9ZT0rHb2LXiJKl83mxSbm/cPoT08NWXiafniLuo5uH8o1jGF463mylUEwr6tVG+hVmP5oaPIRwUMD
X-Gm-Message-State: AOJu0YzAR4hT3ZNDy+gK0qxDB9eJGny7gxSkmMT3gsQfbKg2Y3sX/nfl
	VFNUJQo1PGD8d1/50Vf+4OX8LWTpZBJTfA4LWuToZh4euv5+ST/jTMcy8s6AwDU=
X-Google-Smtp-Source: AGHT+IFpJZuWD6jGk2oIvCOrR61oKPuBS6Ak+YtPL+k8dN+5A9g3/L5D+hKs9iTSHX0BfMiQTWVl6w==
X-Received: by 2002:a05:600c:3b12:b0:423:573:ab2a with SMTP id 5b1f17b1804b1-424750168f1mr63047115e9.0.1718987845506;
        Fri, 21 Jun 2024 09:37:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b0esm70718525e9.38.2024.06.21.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 09:37:25 -0700 (PDT)
Date: Fri, 21 Jun 2024 18:37:23 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Add drm_panic support
Message-ID: <ZnWsQ36q44l4CmOJ@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>, linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
References: <20240620222222.155933-1-javierm@redhat.com>
 <24205cdf-a3c6-475e-ba8a-a52d039a402d@redhat.com>
 <87h6dmjry6.fsf@minerva.mail-host-address-is-not-set>
 <87ed8qjo8y.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed8qjo8y.fsf@minerva.mail-host-address-is-not-set>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Fri, Jun 21, 2024 at 05:42:53PM +0200, Javier Martinez Canillas wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
> > Jocelyn Falempe <jfalempe@redhat.com> writes:
> >
> > Hello Jocelyn, thanks for your feedback!
> >
> >> On 21/06/2024 00:22, Javier Martinez Canillas wrote:
> >>> Add support for the drm_panic infrastructure, which allows to display
> >>> a user friendly message on the screen when a Linux kernel panic occurs.
> >>> 
> >>> The display controller doesn't scanout the framebuffer, but instead the
> >>> pixels are sent to the device using a transport bus. For this reason, a
> >>> .panic_flush handler is needed to flush the panic image to the display.
> >>
> >> Thanks for this patch, that's really cool that drm_panic can work on 
> >> this device too.
> >>
> >
> > Indeed, that's why I did it. Just to see if it could work :)
> >
> > [...]
> >
> >>> +static void ssd130x_primary_plane_helper_panic_flush(struct drm_plane *plane)
> >>> +{
> >>> +	struct drm_plane_state *plane_state = plane->state;
> >>> +	struct ssd130x_plane_state *ssd130x_plane_state = to_ssd130x_plane_state(plane_state);
> >>> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> >>> +	struct drm_crtc *crtc = plane_state->crtc;
> >>> +	struct ssd130x_crtc_state *ssd130x_crtc_state = to_ssd130x_crtc_state(crtc->state);
> >>> +
> >>> +	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &plane_state->dst,
> >>> +			     ssd130x_plane_state->buffer, ssd130x_crtc_state->data_array,
> >>> +			     &shadow_plane_state->fmtcnv_state);
> >>
> >> ssd130x_fb_blit_rect() will call regmap->write(), which involve mutex 
> >> and might sleep. And if the mutex is taken when the panic occurs, it 
> >> might deadlock the panic handling.
> >
> > That's a good point and I something haven't considered...
> >
> >> One solution would be to configure the regmap with config->fast_io and 
> >> config->use_raw_spinlock, and check that the lock is available with 
> >> try_lock(map->raw_spin_lock)
> >> But that means it will waste cpu cycle with busy waiting for normal 
> >> operation, which is not good.
> >>
> >
> > Yeah, I would prefer to not change the driver for normal operation.
> >
> 
> Another option, that I believe makes more sense, is to just disable the
> regmap locking (using struct regmap_config.disable_locking field [0]).
> 
> Since this regmap is not shared with other drivers and so any concurrent
> access should already be prevented by the DRM core locking scheme.
> 
> Is my understanding correct?

Quick irc discussion summary: Since these are panels that sit on i2c/spi
buses, you need to put the raw spinlock panic locking into these
subsystems. Which is going to be extreme amounts of fun, becuase:

- You need to protect innermost register access with a raw spinlock, but
  enough so that every access is still consistent.

- You need separate panic paths which avoid all the existing subsystem
  locking (i2c/spi have userspace apis, so they need mutexes) and only
  rely on the caller having done the raw spinlock trylocking.

- Bonus points: Who even owns that raw spinlock ...

I'm afraid, this is going to be a tough nut to crack :-/

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

