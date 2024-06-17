Return-Path: <linux-kernel+bounces-217716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2404090B353
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8432883CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82F1459F6;
	Mon, 17 Jun 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="htF5EsRT"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D414264A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633861; cv=none; b=rROl7HVZNmzX0Qj+6lqEDsEIrI4XtA4ScVnkEHztsL8yPF91axVc23N6FCKwNNW0S8Wf2TE9+uzqUNco5a5yEOJgp0zq3vxXYz3AHYjH+ktWK9a5TIkDYYsYXfgLFeHX+sriAopPlkIME+M0HqFuGjU3PZSyGY7Dp37OJevdfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633861; c=relaxed/simple;
	bh=If2TSuPAOoh1j+KOdFrdsJKyO4BKHONrPprdY4sRdbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1kolomD/RoW/rybRhv3rVbey9Y4pLyf4vAnEnw4cMy+FZTUrsuO5ipzuXgqysdSi91XxvfpvA/7jzq6JIQjrecYOdYIIr/7wo3tNM8ymGO8FHj238AANwSqzMtB4mp9i+Z3fbTqX4/ahP6m4eCE3G+eUp+Gosv84E3mj4andGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=htF5EsRT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42110872bf9so3837885e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718633858; x=1719238658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQM95NhZnQZa7dlF/QRLcwl7uH7baUwpwDD/MIgaZ74=;
        b=htF5EsRTRE6tfF2IlzVHTInamf1gAKyPsCDCOcUlkikxOVwI+sJMAsk7uTJ/WPbTwb
         VN2awZUnLJYrnqZnOGcAQ8lEJVRTq5t0cC/4OBWd9cNCdnbn+aKN5qH2XbmX/zxwH7TI
         xZa6zoxLvuQzP4u3bpvmaWHIe49YbytPInWrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633858; x=1719238658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQM95NhZnQZa7dlF/QRLcwl7uH7baUwpwDD/MIgaZ74=;
        b=Lq3p2yhzGtBtYm3rA6duFa/kDAEu4ckRqu+lD+iWcZdZRNxSrdEzlkWueJXbnWrEX1
         FUJPZbDKvzn9kx+j9EhFg4u9NxUziCnPvbAwrYtjBazG85i93W3UI4oEXkVB9vj/trGl
         PyHXwhVKM4uVGCinYYuge0qHv+EXSady5Lb7lq1hsWQdwyolTscvzAPEeN4cEEM6Diaj
         npdfyEDHV4q0Tp8FzU//ZF/NCNZOyQxLJTVYDEjAuWQPbF+5JEYnmeUSraYtAyZo210C
         ojpVDU0fpThYxZeAEpyo8SkGBrdpEczEvo/+UuCYWK08NfioTykbPVHjtoKmsImoSXR7
         H0yg==
X-Forwarded-Encrypted: i=1; AJvYcCX0S/Atyu1x3UQNY0hDCkxSARF1hs3LOwrkT07VshVzc6oA7zTHVzimUNwjoabdnPfmw7izRhPn+JS66rIhb5w1Y/cVHzQiXr7BVSV0
X-Gm-Message-State: AOJu0YyttbziBhRxed2wHS2B0S4ej+gX3GPGsXMlAVtlf3aytCFv5Qk9
	/E4UBTHHUX3qhRwnDd1tvesHU0NkLdAoJkwVZlrfHNaMoH22Y/XOv3+bX7Luo+Y4EO4VTefuXJQ
	o
X-Google-Smtp-Source: AGHT+IFaPmZ5YPaGTAKYQuL1A8FFLHJdpy9zr6av7LaKtOLyHHiP9Q9wE0M/rUpSCmZEz6upnZzs3Q==
X-Received: by 2002:a05:6000:1849:b0:35f:e38:6758 with SMTP id ffacd0b85a97d-3607a789ad4mr6496360f8f.7.1718633858470;
        Mon, 17 Jun 2024 07:17:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm11835024f8f.59.2024.06.17.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:17:38 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:17:36 +0200
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
Message-ID: <ZnBFgDO37xhMfvzV@phenom.ffwll.local>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WBVfBZrgGay=XY2Usq3FA3m9i6y0cU4=b=w7qO6gRBFQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 12, 2024 at 09:00:29AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 8:11 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > > The problem is that the ordering is wrong, I think. Even if the OS was
> > > calling driver shutdown functions in the perfect order (which I'm not
> > > convinced about since panels aren't always child "struct device"s of
> > > the DRM device), the OS should be calling panel shutdown _before_
> > > shutting down the DRM device. That means that with your suggestion:
> > >
> > > 1. Shutdown starts and panel is on.
> > >
> > > 2. OS calls panel shutdown call, which prints warnings because panel
> > > is still on.
> > >
> > > 3. OS calls DRM driver shutdown call, which prints warnings because
> > > someone else turned the panel off.
> >
> > Uh, that's a _much_ more fundamental issue.
> >
> > The fix for that is telling the driver core about this dependency with
> > device_link_add. Unfortuantely, despite years of me trying to push for
> > this, drm_bridge and drm_panel still don't automatically add these,
> > because the situation is a really complex mess.
> >
> > Probably need to read dri-devel archives for all the past attempts around
> > device_link_add.
> >
> > But the solution is definitely not to have a manually tracked list, what's
> > very architectural unsound way to tackle this problem.
> >
> > > Certainly if I goofed and the above is wrong then let me know--I did
> > > my experiments on this many months ago and didn't try repeating them
> > > again now.
> >
> > Oh the issue is very real and known since years. It also wreaks module
> > unload and driver unbinding, since currently nothing makes sure your
> > drm_panel lives longer than your drm_device.
> 
> In this case I'm mostly worried about the device "shutdown" call, so
> it's not quite a lifetime issue but it is definitely related.

There's the "this is for pm" type of device_link, they have a few
flavours. And if that doesn't yet cover ->shutdown, then I guess that
needs to be addressed.

> As per my reply to Maxime, though, I'd expect that if all ordering
> issues were fixed and things were perfect then we'd still have a
> problem. Specifically it would seem pretty wrong to me to say that the
> panel is the "parent" of the DRM device, right? So if the panel is the
> "child" of the DRM device that means it'll get shutdown first and that
> means that the panel's shutdown call cannot be used to tell whether
> the DRM device's shutdown call behaved properly.

The device_link (if you add it the correct way round) means a
provider-consumer relationship. Which means:

- driver core unbinds the consumer before the provider (e.g. on module
  unload)
- driver core disables the consumer before the provider for power
  management stuff
- driver core enables providers before consumers when enabling power again

So yeah this should work the right way round ...

> > > In any case, the only way I could figure out around this was some sort
> > > of list. As mentioned in the commit message, it's super ugly and
> > > intended to be temporary. Once we solve all the current in-tree
> > > drivers, I'd imagine that long term for new DRM drivers this kind of
> > > thing would be discovered during bringup of new boards. Usually during
> > > bringup of new boards EEs measure timing signals and complain if
> > > they're not right. If some EE cared and said we weren't disabling the
> > > panel correctly at shutdown time then we'd know there was a problem.
> >
> > You've stepped into an entire hornets nest with this device dependency
> > issue unfortunately, I'm afraid :-/
> 
> As you've said, you've been working on this problem for years. Solving
> the device link problem doesn't help me, but even if it did it's
> really not fundamental to the problem here. The only need is to get a
> warning printed out so we know for sure which DRM drivers need to be
> updated before deleting the old crufty code. Blocking that on a
> difficult / years-long struggle might not be the best.

The issue is that everyone just gives up, so it's not moving.

> That all being said, I'm also totally OK with any of the following:
> 
> 1. Dropping my patch and just accepting that we will have warnings
> printed out for all DRM drivers that do things correctly and have no
> warnings for broken DRM drivers.

Can't we just flip the warnings around? Like make the hacky cleanup
conditional on the panel not yet being disabled/cleaned up, and complain
in that case only. With that:
- drivers which call shutdown shouldn't get a warning anymore, and also
  not a surplus call to drm_panel_disable/unprepare
- drivers which are broken still get the cleanup calls
- downside: we can't enforce this, because it's not yet enforced through
  device_link ordering

> 2. Someone else posting / landing a patch to remove the hacky "disable
> / unprepare" for panel-simple and panel-edp and asserting that they
> don't care if they break any DRM drivers that are still broken. I
> don't want to be involved in authoring or landing this patch, but I
> won't scream loudly if others want to do it.
> 
> 3. Someone else taking over trying to solve this problem.
> 
> ...mostly this work is janitorial and I'm trying to help move the DRM
> framework forward and get rid of cruft, so if it's going to cause too
> much conflict I'm fine just stepping back.

My issue is that you're trading an ugly warning that hurts maintenance
with an explicit list of working drivers, which also hurts maintenance.
Does seem like forward progress to me, just pushing the issue around.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

