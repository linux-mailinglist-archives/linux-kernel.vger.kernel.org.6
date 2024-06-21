Return-Path: <linux-kernel+bounces-225031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C688D912AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7402E281CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2A15EFDA;
	Fri, 21 Jun 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZhMVTlYI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C314F215
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985848; cv=none; b=eg0W0f07PpCiUHarwXFI0z54LxYQvsbZOLI7gPwwu7/mjs7F1JCyVhAsj92+O/+tPgZ2iB2oLxIGfCzyV6oidnBxVwLoNF9VqmouXE/ZdQUBR+b9whIe7646nRhcVOq+cV5/IyjOmZZpwHRrycddRKDXODtYCX9APw51+409jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985848; c=relaxed/simple;
	bh=GRii09jWj7oa82KnO/sJmVrri1gO9a1IACLF/McKDxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz7q1P9sVQzxu3Jwu/2SnvTKwslkhc0KGblB0ev3vaFzSeQtSt7hZTOFxWbv8ZeswTC1962IG0A5WZ+A9pIZfNATOCKK6evhvhvXhrtYGn9XAe4kGpyehOE4+xePJz9LRw+hqHD/UghRVMCFREKkYrxCjJLygPQKt8WJvGowQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZhMVTlYI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so2759715e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718985845; x=1719590645; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vN260L65NdwhhzFhGRzhHpkMdYHsvIyA4ZNIAeJjPbg=;
        b=ZhMVTlYIdzs1LtGxTm0wln5gn4YHVWkcmn+PTnEyAW4uWHHeiW5nmtUaCVWtkWWf1f
         DF2FjjB30zy6qPshmOAsT/kPZssNJBvgVbIFZVLD8Lxi8Rz+sc9i4nPjZCts//p6BCMd
         1HhMcjhI0W6xe1l8hmClijvNvVqJPL1IbImb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718985845; x=1719590645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vN260L65NdwhhzFhGRzhHpkMdYHsvIyA4ZNIAeJjPbg=;
        b=X9fKVfhb9I6GNa8C7Xx1AtbxT3dja9sZjlFB0c+Psg6x7yZZOCrjE4VvwnJl0uof+/
         Mhcuf9+/FxARI+Stj7awtaA9coWy+bYIfmdfrGhnpRUV8oymAwA7LJBmzC27cWyVwvCW
         MOUU5ClmqpGwTjtscXzXx0FE/Rmw/t+ZFRINw7zMD3RTKOS0s1Y4B0qx4mcMFhPTIvXY
         CyiUMb0vl3dQjrF9sapmPw/71E9VAHfReOuxVfS8qdOqH6nOQq4tA6wLgGWLn+YqSZC7
         cx2pgID5C1nQuH3IaD9K94YKHlc/kHnkSuVK9Di4Hj2+LYhUJnyjrjxOdAH2/HGu1rCP
         KbZw==
X-Forwarded-Encrypted: i=1; AJvYcCWY4o4lrzlzH9CExxgFpbZY8hA3gkq40Cds0RToy7jJa0SBMDio2k84jCtD8tX5THClG+CoSxU4ZEnz9PJlGMUM/M7YyMeurFAvXlYA
X-Gm-Message-State: AOJu0YwfBtR0+HTq/mPEc/hI8jTjV8zHkDINjjckyu1IOURkWlw+M3LI
	mPPi9tPRrNSyTldpgVEFPp0j2ag8t1Mlzu6gddvASN3kbm8DCN8b7CWHLpub6b0=
X-Google-Smtp-Source: AGHT+IFVeU3xce+k26r2+DnW8GeU78oyhJggZBPOJmXKmQ3sZUYdc630B9SNBh7u3If+X/hS+ML+Pg==
X-Received: by 2002:a05:6000:1f86:b0:360:8490:74d with SMTP id ffacd0b85a97d-36319990f76mr6226350f8f.5.1718985845005;
        Fri, 21 Jun 2024 09:04:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6d16sm2172707f8f.3.2024.06.21.09.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 09:04:04 -0700 (PDT)
Date: Fri, 21 Jun 2024 18:04:02 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at
 shutdown
Message-ID: <ZnWkcodVWXe7gPVa@phenom.ffwll.local>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local>
 <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
 <Zmm6i6iQOdP613w3@phenom.ffwll.local>
 <CAD=FV=WBVfBZrgGay=XY2Usq3FA3m9i6y0cU4=b=w7qO6gRBFQ@mail.gmail.com>
 <ZnBFgDO37xhMfvzV@phenom.ffwll.local>
 <CAD=FV=UindNjK4rWMvsMybgp_bPULbNz2A-u8x60MD4scrnHSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UindNjK4rWMvsMybgp_bPULbNz2A-u8x60MD4scrnHSQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Tue, Jun 18, 2024 at 04:49:22PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 17, 2024 at 7:17 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > > That all being said, I'm also totally OK with any of the following:
> > >
> > > 1. Dropping my patch and just accepting that we will have warnings
> > > printed out for all DRM drivers that do things correctly and have no
> > > warnings for broken DRM drivers.
> >
> > Can't we just flip the warnings around? Like make the hacky cleanup
> > conditional on the panel not yet being disabled/cleaned up, and complain
> > in that case only. With that:
> > - drivers which call shutdown shouldn't get a warning anymore, and also
> >   not a surplus call to drm_panel_disable/unprepare
> > - drivers which are broken still get the cleanup calls
> > - downside: we can't enforce this, because it's not yet enforced through
> >   device_link ordering
> 
> I feel like something is getting lost in the discussion here. I'm just
> not sure where to put the hacky cleanup without either having a list
> like I have or fixing the device link problem so that the DRM device
> shutdown gets called before the panel. Specifically, right now I think
> it's possible for the panel's shutdown() callback to happen before the
> DRM Device's shutdown(). Thus, we have:
> 
> 1. Panel shutdown() checks and says "it's not shutdown yet so do my
> hacky cleanup."
> 2. DRM device shutdown() gets called and tries to cleanup again.
> 
> ...and thus in step #1 we can't detect a broken DRM device. What am I missing?

The above is a broken drm driver, because shutting down something that the
main drm driver needs _before_ it is shut down itself is broken. That's
why we need the device link.

So if this case goes a bit wrong that's imo ok. That was my point that
without device links, we cannot have _any_ warning at all, but we can at
least make sure that correct drivers, meaning:
- they make sure the panel is around for longer than the drm device
- and they call drm atomic_helper_shutdown in the right places

Wont either double-shutdown the panel or get the warning.

It's not great, but it's at least better than the current situation where
correct drivers get a warning, and some broken drivers don't. So still an
improvement.

That leaves us with the issue of warning for all broken drivers. We have
two proposals for that:

- Your explicit list, which is a pain imo, and I'm not seeing the benefit
  of this, because it'll encourage each driver to hack around the core
  code bug of not having the right device links.

- Fixing this with a device link and adding the warning for everyone.

This isn't a great situation, because it's likely going to be another few
years without the device link situation sorted out. But that's been the
case already for years so *shrug*.

> > > 2. Someone else posting / landing a patch to remove the hacky "disable
> > > / unprepare" for panel-simple and panel-edp and asserting that they
> > > don't care if they break any DRM drivers that are still broken. I
> > > don't want to be involved in authoring or landing this patch, but I
> > > won't scream loudly if others want to do it.
> > >
> > > 3. Someone else taking over trying to solve this problem.
> > >
> > > ...mostly this work is janitorial and I'm trying to help move the DRM
> > > framework forward and get rid of cruft, so if it's going to cause too
> > > much conflict I'm fine just stepping back.
> >
> > My issue is that you're trading an ugly warning that hurts maintenance
> > with an explicit list of working drivers, which also hurts maintenance.
> > Does seem like forward progress to me, just pushing the issue around.
> 
> IMO it at least moves things forward. If we make the warning obvious
> enough then I think we could assert that, within a few kernel
> versions, everyone who hit the warning would have addressed it. Once
> that happens we can fully get rid of the ugly list and just make the
> assumption that things are good. That feels like a clear path to me...

Yeah, but your warning I think just encourages more hacks in drivers that
shouldn't be there (for the ordering issue). So I'm not sure it's strictly
better.

And we have _tons_ of drm driver api misuse that we don't catch with
warnings and checks. Sometimes that's just not possible, because the
situation is too messy. If we add an explicit "I'm not broken" list for
each such case, we will have an unmaintainable mess. Sometimes a "I'm the
last broken driver" flag makes sense, but even there I'm cautious that
it's a bright idea.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

