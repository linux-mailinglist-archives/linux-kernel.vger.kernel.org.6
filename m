Return-Path: <linux-kernel+bounces-211766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3A90568C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342C8B28BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB2C1802A0;
	Wed, 12 Jun 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EZb/lZIH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692317F507
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205072; cv=none; b=BVlV7eln9dFHkB/GwV/92RGp8EueBfjGQjs9ZjooX6OHHLbRjsRVRILBu61bGTUWyKEewyndojS7RphbNqptpe9LGFNcn/Nyk6z2PikB/f/JpH8dOm7KojH+obIWiGaDO7wIL7hlRJ6eLBVY61xeXyuP1LEf+NrTJT3FrXERpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205072; c=relaxed/simple;
	bh=G0+hLd6oELx91zxUvRGFLWG7LPKQ6qmGL0/jI3fP+Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLvMGNB9XCyiPhts/fbkNRKRymXq4vTRExpm31c2QtAGJ7JtGXA6bApuUkgtFcLIkiLGau8maN0K53nYbq+kKSzNDL5Swx7ID1gyFEAlLpvNZg9rF6Q9G7+Q5ReZdGC/habogwlu7Os7RTO5+w1H/LBpb+GKS6LOiNqSBi/PHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=EZb/lZIH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42110872bf9so7232415e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718205069; x=1718809869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3rEd/N79zsTx5bN2Ceul3LBY+GMeO3ZQ5xYcqq+Lx8=;
        b=EZb/lZIHRdr9rDuV6Ufuh9HnxicTYLbfBGtSoLa4m9UPFnRBLqwekpMXWN7ziVgUL6
         KN567xYdKn+9BJS3NyW9JrlyATO+gNWXNyC24xQcbzIYZwiZkIsdsLZ697K80/KSLcRr
         bhEXiKDefUIM1h1NcnTw3KDSKvzxdTG6HK/zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205069; x=1718809869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3rEd/N79zsTx5bN2Ceul3LBY+GMeO3ZQ5xYcqq+Lx8=;
        b=ZoYEQol3AR8PlgC27F7SKHLqtwq0IwrPT5JoztphUoPcduqjBBT7X0kl+KxNH5MYf7
         r3kTIZrJVdOW3AV4gJBjIBV1zXgZMYh0M+sNH1g63fbKwb2AXd63iNjRKsT0JgJemAjZ
         XdG28yTTNWbtw5AcjznfN8MzQpqC14eEh5hKnrgdQ1gKUNUeDxQ+Td9af3OxuXwojJWX
         cKuODgJeQywmq2NLPaqRogPYAn6iXHn7wt6m7PsIUfdPmWcgRvnw//itAQ/Lr4Lym5/i
         m/h2dIJg6mow80L1fx3n7NAIwFHPzrMMZ14tF5XxJmN5ylAFPfBHIz+e+zFxGLFgeSVL
         l3ug==
X-Forwarded-Encrypted: i=1; AJvYcCXsE2yfYdWgkP1JhLF5SkrFAqFHEUSb2u1WvckdSB0uGUwyjm5663D7IG7q5vJjwyzlU8eVTEvx93E2CeOt2oLudb3DrviEbSJreN2d
X-Gm-Message-State: AOJu0YyktQb9iq2qDaYjxCZkmgDu1looa3/kHtlfbZci2s48ikKuxrj1
	+HqmAeMdmkioHMz5WgLbwILofe2273M/KJr6TEQb9b7MbLXehV1YuR4w1TEkfYE=
X-Google-Smtp-Source: AGHT+IGOokcQBaF0gtzavB63Lm/hzcbJyOl+IEUlftNYtxr6X9d0tMA3jKNn1cu9xWD4Kz5+Y3xExQ==
X-Received: by 2002:a05:600c:1c85:b0:421:de31:76 with SMTP id 5b1f17b1804b1-422866bcc38mr14735365e9.3.1718205069428;
        Wed, 12 Jun 2024 08:11:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe919bsm28783255e9.19.2024.06.12.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:11:09 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:11:07 +0200
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
Message-ID: <Zmm6i6iQOdP613w3@phenom.ffwll.local>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 12, 2024 at 07:49:31AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 1:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Jun 11, 2024 at 07:48:51AM -0700, Douglas Anderson wrote:
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
> > I think it's terrible :-)
> 
> Well, we're in agreement. It is terrible. However, in my opinion it's
> still a reasonable way to move forward.
> 
> 
> > Why does something like this now work?
> >
> > drm_panel_shutdown_fixup(panel)
> > {
> >         /* if you get warnings here, fix your main drm driver to call
> >          * drm_atomic_helper_shutdown()
> >          */
> >         if (WARN_ON(panel->enabled))
> >                 drm_panel_disable(panel);
> >
> >         if (WARN_ON(panel->prepared))
> >                 drm_panel_unprepare(panel);
> > }
> >
> > And then call that little helper in the relevant panel drivers? Also feel
> > free to bikeshed the name and maybe put a more lengthly explainer into the
> > kerneldoc for that ...
> >
> > Or am I completely missing the point here?
> 
> The problem is that the ordering is wrong, I think. Even if the OS was
> calling driver shutdown functions in the perfect order (which I'm not
> convinced about since panels aren't always child "struct device"s of
> the DRM device), the OS should be calling panel shutdown _before_
> shutting down the DRM device. That means that with your suggestion:
> 
> 1. Shutdown starts and panel is on.
> 
> 2. OS calls panel shutdown call, which prints warnings because panel
> is still on.
> 
> 3. OS calls DRM driver shutdown call, which prints warnings because
> someone else turned the panel off.

Uh, that's a _much_ more fundamental issue.

The fix for that is telling the driver core about this dependency with
device_link_add. Unfortuantely, despite years of me trying to push for
this, drm_bridge and drm_panel still don't automatically add these,
because the situation is a really complex mess.

Probably need to read dri-devel archives for all the past attempts around
device_link_add.

But the solution is definitely not to have a manually tracked list, what's
very architectural unsound way to tackle this problem.

> Certainly if I goofed and the above is wrong then let me know--I did
> my experiments on this many months ago and didn't try repeating them
> again now.

Oh the issue is very real and known since years. It also wreaks module
unload and driver unbinding, since currently nothing makes sure your
drm_panel lives longer than your drm_device.

> In any case, the only way I could figure out around this was some sort
> of list. As mentioned in the commit message, it's super ugly and
> intended to be temporary. Once we solve all the current in-tree
> drivers, I'd imagine that long term for new DRM drivers this kind of
> thing would be discovered during bringup of new boards. Usually during
> bringup of new boards EEs measure timing signals and complain if
> they're not right. If some EE cared and said we weren't disabling the
> panel correctly at shutdown time then we'd know there was a problem.

You've stepped into an entire hornets nest with this device dependency
issue unfortunately, I'm afraid :-/

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

