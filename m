Return-Path: <linux-kernel+bounces-211722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3994F9055F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B639F1F25065
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DA17FAC9;
	Wed, 12 Jun 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5YzMXPw"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149F17F4F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204249; cv=none; b=MunjPztagI5rwGeNwfNwP8oW4m6JsD8FrTBfPuix1KKAuaKHyS2ziWKCxrFBTB3g1EgHtQCaHE4TD387lQW5hI2Ss4k5IyT5yIDxY6xLGkTSeNKNrO7ElTSvl+y86RNHsgONm5n672TggR+k+s2/sJ9yn2I4XN8BBR1adxQnAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204249; c=relaxed/simple;
	bh=J7cqgWYezIrErNWN/jrvMFBbXRqtb6RXM13dQg5Nh/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXkyctCGHD/jvYUfPeZW2LI+J6yq5fXyMzb/5e0t6vA+/MD5bBIzyvVQn0+FoXcI974HvVhRanD6DqSVsNfA/4VST07m4loLkS688m8SxWr26D8RbPLNYmg85kxsiWKDZi4Mz9Y6Hwz+XxNWgXNui9iO2hkSSv4FrZr66Cr8B3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k5YzMXPw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b08857f3b8so13262436d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718204246; x=1718809046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaS2PBL4S8jQlK2xlwvpgjVyDocb+xKvGvfIH82q2zM=;
        b=k5YzMXPwuYIqnZmQ2KpRelLuhd6tbD7QeZZqJrVn8Hbf0k/CgTghxqFKvXDYDTKDT/
         GWEuY7V8V6TNOTr4RO46lWwjOThisurZepEL6Sc96k3/8510V/BWr+9yQ1vbuCisVvb/
         sa7uPXjLcNGm5OmTaffsn5MZs66Zo4CNkbCG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204246; x=1718809046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaS2PBL4S8jQlK2xlwvpgjVyDocb+xKvGvfIH82q2zM=;
        b=imlU7rD0Udmhd5oTK6DlMVYwC7cR0f/kPBr0I5PT0w8iIm1aUJAF29vGHO+FvyBpeH
         7wCSjsHuzsxs+JfdPz3xdufBTX0nqZL0LLjRO1q5AurIXUe4HO9PhRXJZRQBjssOTuEx
         Hc4ABNmzmR35Rzs9B2rCgwGaGMNY/IpFkTWq3armvGkFOGLlZprQHZOQwjuqA0kL80PK
         ogxlB8hpzV+DWvhKo9hRI9HIQ94o0dq3l9tYoOuvFG3fqbxAI+Ao0fKZjr5Bg+BUEb0Q
         bCytydlb3eLwwyNRLbqIScf8JG8QfS+4k43sqRHFcBhjxzI61TfPgYobCXuceu3bxxKH
         cAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJfWtGhu0Phts+NAnAwmeMLR9lgi2TfNeJ+YdNtyi6D2jFTLi38Ul0mJyWzVfRKakvHkAQKChN34/97Wmc0uflNGwyHB1hhXyKe3Mx
X-Gm-Message-State: AOJu0YwFlH5pp7X3D2vvpQTiRDgfLCLjbfoOvnaolaODPoNn5CCftfUA
	mbkCqDpAVzsLVEZNZKArdUTxQjKA459VOxz58rB0FpBTPYRmgpX8nka+0Hk1OKBuZTxDr/nGUuA
	=
X-Google-Smtp-Source: AGHT+IE/zGtwnBBO8Fj8TQ7PN5z11SLjsbAnKgDI9qFhYEDv9i9OWDWzUXKeAkt3+K27dOBebzLfNw==
X-Received: by 2002:a05:6214:448d:b0:6b0:77da:3ab6 with SMTP id 6a1803df08f44-6b191498efemr20006096d6.12.1718204246249;
        Wed, 12 Jun 2024 07:57:26 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b080f4d85fsm29047456d6.137.2024.06.12.07.57.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:57:26 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44056f72257so351751cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:57:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdBr8lM4BlD6PjqD+mlFErBI5LIG+SxRryIskdOkKxaJ/b6uS7AJlm0r7W/Il3T8w1d5ctpws7bCfBtYI8BBeMIg8uZ2aykdjfzqi/
X-Received: by 2002:a05:622a:124b:b0:441:4920:1fc4 with SMTP id
 d75a77b69052e-44158dc2347mr4800881cf.28.1718203787073; Wed, 12 Jun 2024
 07:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local>
In-Reply-To: <ZmljNHteJ9L5EdE9@phenom.ffwll.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 07:49:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
Message-ID: <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 1:58=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Tue, Jun 11, 2024 at 07:48:51AM -0700, Douglas Anderson wrote:
> > At shutdown if you've got a _properly_ coded DRM modeset driver then
> > you'll get these two warnings at shutdown time:
> >
> >   Skipping disable of already disabled panel
> >   Skipping unprepare of already unprepared panel
> >
> > These warnings are ugly and sound concerning, but they're actually a
> > sign of a properly working system. That's not great.
> >
> > It's not easy to get rid of these warnings. Until we know that all DRM
> > modeset drivers used with panel-simple and panel-edp are properly
> > calling drm_atomic_helper_shutdown() or drm_helper_force_disable_all()
> > then the panel drivers _need_ to disable/unprepare themselves in order
> > to power off the panel cleanly. However, there are lots of DRM modeset
> > drivers used with panel-edp and panel-simple and it's hard to know
> > when we've got them all. Since the warning happens only on the drivers
> > that _are_ updated there's nothing to encourage broken DRM modeset
> > drivers to get fixed.
> >
> > In order to flip the warning to the proper place, we need to know
> > which modeset drivers are going to shutdown properly. Though ugly, do
> > this by creating a list of everyone that shuts down properly. This
> > allows us to generate a warning for the correct case and also lets us
> > get rid of the warning for drivers that are shutting down properly.
> >
> > Maintaining this list is ugly, but the idea is that it's only short
> > term. Once everyone is converted we can delete the list and call it
> > done. The list is ugly enough and adding to it is annoying enough that
> > people should push to make this happen.
> >
> > Implement this all in a shared "header" file included by the two panel
> > drivers that need it. This avoids us adding an new exports while still
> > allowing the panel drivers to be modules. The code waste should be
> > small and, as per above, the whole solution is temporary.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I came up with this idea to help us move forward since otherwise I
> > couldn't see how we were ever going to fix panel-simple and panel-edp
> > since they're used by so many DRM Modeset drivers. It's a bit ugly but
> > I don't hate it. What do others think?
>
> I think it's terrible :-)

Well, we're in agreement. It is terrible. However, in my opinion it's
still a reasonable way to move forward.


> Why does something like this now work?
>
> drm_panel_shutdown_fixup(panel)
> {
>         /* if you get warnings here, fix your main drm driver to call
>          * drm_atomic_helper_shutdown()
>          */
>         if (WARN_ON(panel->enabled))
>                 drm_panel_disable(panel);
>
>         if (WARN_ON(panel->prepared))
>                 drm_panel_unprepare(panel);
> }
>
> And then call that little helper in the relevant panel drivers? Also feel
> free to bikeshed the name and maybe put a more lengthly explainer into th=
e
> kerneldoc for that ...
>
> Or am I completely missing the point here?

The problem is that the ordering is wrong, I think. Even if the OS was
calling driver shutdown functions in the perfect order (which I'm not
convinced about since panels aren't always child "struct device"s of
the DRM device), the OS should be calling panel shutdown _before_
shutting down the DRM device. That means that with your suggestion:

1. Shutdown starts and panel is on.

2. OS calls panel shutdown call, which prints warnings because panel
is still on.

3. OS calls DRM driver shutdown call, which prints warnings because
someone else turned the panel off.

:-P

Certainly if I goofed and the above is wrong then let me know--I did
my experiments on this many months ago and didn't try repeating them
again now.

In any case, the only way I could figure out around this was some sort
of list. As mentioned in the commit message, it's super ugly and
intended to be temporary. Once we solve all the current in-tree
drivers, I'd imagine that long term for new DRM drivers this kind of
thing would be discovered during bringup of new boards. Usually during
bringup of new boards EEs measure timing signals and complain if
they're not right. If some EE cared and said we weren't disabling the
panel correctly at shutdown time then we'd know there was a problem.

-Doug

