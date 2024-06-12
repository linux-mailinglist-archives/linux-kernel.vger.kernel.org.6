Return-Path: <linux-kernel+bounces-211770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B247905695
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A062889A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F21181311;
	Wed, 12 Jun 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hkOcCANq"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06D18131C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205189; cv=none; b=VlWOnKulYrHpwzwGEbFZMql/fV9JgiSSt459/ZQzu5ktKGmkFoDBw1ydERDSH1gTdDmixccvFj/hytjwJKzWwAPE5bqS2bwGr463RGYIxJd5024/9vlb+HddHy+A1JXjYdfGGNBHDaRxHJiBP4Lm0S1D734Obz/qlNeYHmhshOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205189; c=relaxed/simple;
	bh=flfZFIJ3Ruh9pFgp4NIRcL7v+Dq+/bgpsa+cad/DG4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHNpFaoBkYA0Js1+Y7tggIXAX6a3wQzhbSRAH9hyobIsFp5ZIRaKaGQYCiO/b0AvSCjsOYctnfmp9Dgs4/1fWPOBRvTN8jn/6crSAAT6c9BDsHJURWhH44fjhGPXiHtLWEh0krkrZK2kv+BJE9F6/mb2qM+KvOGLxNGPqv6v2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hkOcCANq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f1c7d1286so435796f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718205186; x=1718809986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aB2lXUipFe+ilhQGDKfy5yRSSxNAEcN/w1KJXQoXXRo=;
        b=hkOcCANqv0cbobXuBGHYwCXJcUQG8y3qU1cKfG/pp7Z6bQ15vN0b+Fzt1RTPo/hQMZ
         qbUZJlUkKBmO7jmhWzkiSRuZ5W01nq2Pf1s3lTS6X9NwkPurpkh1JbPs8B1Zp3lnSR/t
         gLEap5rVXHmT2usLvPy01MkDT9KZgnwYyl7/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205186; x=1718809986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aB2lXUipFe+ilhQGDKfy5yRSSxNAEcN/w1KJXQoXXRo=;
        b=uv/6J7rojbuQZ7kDzGqWYai4u3NxGTiOHY3owVMLh00S/pM9xpNU1B51HSN7wQ6Fp4
         6TtQ3ZBBd0VLpiJpdjrtPAgJix0DqX8ojX097FsJm+D73r8Hv7ahdjhxfpVFfo550llR
         3SS3tct0NFmpInqNBzlDEZkoouWGjoEkFr0Oc5GWpqSu2adtM+J4WcbOp24bID6sXHui
         11efy900Nung1mXVx/V+f78wM681PrgLApef5SCEN4Bl8d0Rk/mcTfC2EfdyXcr2EuUE
         co2xfq1PcMnigANawFjxbOTZtzLOrZvK+lqgkxfwUfeMDTB12xBsSgL7U7OuxVkbPjKo
         T3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsEhTE48ARFPLyrYjhJuMzkKcEUrg3WRctW4zGYjZhQJJLXoUQ9gdaq4V6EtWWz9V1NMalU55QHzIEAdbH/k3Y6AL2aJIkaAXDz6Jy
X-Gm-Message-State: AOJu0YwmC5hYNnpY94R64H3UvQ106DCdwwZBEDbw06BYjpXjCuHqeM9M
	sSGODDZLDu6VDq7HBsZY+V7rHKl+YCDU/KimAmStfka/bdcsKDs2M3BCKiFtLzM=
X-Google-Smtp-Source: AGHT+IG6G6UfkgYLOZrbaC3u6RFF77X5XQGCNP3Hq482PX0DbBDxDJ6zJg1aOTxpQe4xxXI8x1blEA==
X-Received: by 2002:a05:6000:1445:b0:354:e03c:b39a with SMTP id ffacd0b85a97d-35fe88fe708mr1617633f8f.6.1718205186150;
        Wed, 12 Jun 2024 08:13:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f30c04d63sm3301375f8f.110.2024.06.12.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:13:05 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:13:03 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Doug Anderson <dianders@chromium.org>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at
 shutdown
Message-ID: <Zmm6_27GikpmT3HQ@phenom.ffwll.local>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <20240612-garnet-condor-from-saturn-1c51bb@houat>
 <CAD=FV=Xpu0-_kEvRWy9w8ypjo7pF7tsFWxHfhMZ=YjHugTqG1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Xpu0-_kEvRWy9w8ypjo7pF7tsFWxHfhMZ=YjHugTqG1w@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 12, 2024 at 07:39:01AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 1:09 AM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 11, 2024 at 07:48:51AM GMT, Douglas Anderson wrote:
> > > At shutdown if you've got a _properly_ coded DRM modeset driver then
> > > you'll get these two warnings at shutdown time:
> > >
> > >   Skipping disable of already disabled panel
> > >   Skipping unprepare of already unprepared panel
> > >
> > > These warnings are ugly and sound concerning, but they're actually a
> > > sign of a properly working system. That's not great.
> > >
> > > It's not easy to get rid of these warnings. Until we know that all DRM
> > > modeset drivers used with panel-simple and panel-edp are properly
> > > calling drm_atomic_helper_shutdown() or drm_helper_force_disable_all()
> > > then the panel drivers _need_ to disable/unprepare themselves in order
> > > to power off the panel cleanly. However, there are lots of DRM modeset
> > > drivers used with panel-edp and panel-simple and it's hard to know
> > > when we've got them all. Since the warning happens only on the drivers
> > > that _are_ updated there's nothing to encourage broken DRM modeset
> > > drivers to get fixed.
> > >
> > > In order to flip the warning to the proper place, we need to know
> > > which modeset drivers are going to shutdown properly. Though ugly, do
> > > this by creating a list of everyone that shuts down properly. This
> > > allows us to generate a warning for the correct case and also lets us
> > > get rid of the warning for drivers that are shutting down properly.
> > >
> > > Maintaining this list is ugly, but the idea is that it's only short
> > > term. Once everyone is converted we can delete the list and call it
> > > done. The list is ugly enough and adding to it is annoying enough that
> > > people should push to make this happen.
> > >
> > > Implement this all in a shared "header" file included by the two panel
> > > drivers that need it. This avoids us adding an new exports while still
> > > allowing the panel drivers to be modules. The code waste should be
> > > small and, as per above, the whole solution is temporary.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > I came up with this idea to help us move forward since otherwise I
> > > couldn't see how we were ever going to fix panel-simple and panel-edp
> > > since they're used by so many DRM Modeset drivers. It's a bit ugly but
> > > I don't hate it. What do others think?
> >
> > I don't think it's the right approach, even more so since we're so close
> > now to having it in every driver.
> >
> > I ran the coccinelle script we started with, and here are the results:
> >
> > ./drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:1640:25-39: ERROR: KMS driver vmw_pci_driver is missing shutdown implementation
> > ./drivers/gpu/drm/kmb/kmb_drv.c:621:30-49: ERROR: KMS driver kmb_platform_driver is missing shutdown implementation
> > ./drivers/gpu/drm/tiny/arcpgu.c:422:30-52: ERROR: KMS driver arcpgu_platform_driver is missing shutdown implementation
> 
> Sure, although I think we agreed even back when we talked about this
> last that your coccinelle script wasn't guaranteed to catch every
> driver. ...so I guess the question is: are we willing to accept that
> we'll stop disabling panels at shutdown for any drivers that might
> were missed. For instance, looking at it by hand (which also could
> miss things), I previously thought that we also might need:
> 
> * nouveau
> * tegra
> * amdgpu
> * sprd
> * gma500
> * radeon
> 
> I sent patches for those drivers but they don't go through drm-misc
> and some of the drivers had a lot of abstraction layers and were hard
> to reason about. I'm also not 100% confident that all of those drivers
> really are affected--they'd have to be used with panel-simple or
> panel-edp...

Aside from amdgpu and radeon they're all in -misc now, and Alex is
generally fairly responsive.

> In any case, having some sort of warning that would give us a
> definitive answer would be nice. My proposed patch would give us that
> warning. I could even jump to a WARN_ON right from the start.

Yeah we defo want some warning to at least check this at runtime.

> My proposed patch is self-admittedly super ugly and is also designed
> to be temporary, so I don't think of this as giving up right before
> crossing the finish line but instead accepting a tiny bit of temporary
> ugliness to make sure that we don't accidentally regress anyone. I
> would really hope it would be obvious to anyone writing / reviewing
> drivers that the function I introduced isn't intended for anyone but
> panel-simple and panel-edp.

See my other reply for the proper design fix, and my apologies for what
you stepped into here :-/
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

