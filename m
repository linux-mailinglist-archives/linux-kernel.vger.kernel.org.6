Return-Path: <linux-kernel+bounces-252834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EF9318A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C91C1F224DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAA3B295;
	Mon, 15 Jul 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XU6zqNTr"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6C4643B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061629; cv=none; b=CmChor1DQWgA6wtKNu018WkcBtbTvA81zN7U7yncrY7PUCv0KHWgm1firZogTzMYzOqX/ceckgB7vJ+dzRn6fe78nh4kP3MlTnDgEbBfcfXxkLaxuTaheXGfOaOBOf0XIvm6jd+Oan8USQaTOdhJNGeVg06qvwANl6hNG7cCpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061629; c=relaxed/simple;
	bh=kBWBnjXh7VOgbtn1rxNBCQXca9txmQle+V4SDlhC8HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFDhEQCi+Qd2tESZf7BqumhobV/1yrMzYLctpmaxMKzrZTmSEyeBnA6LZfEgNwhQF197mxJsAX8hG+IdazRN/ZKvVHe9YEX42G+wuJkHVk3ffrWOaotHAS+lwc7a2O2iX0uNqEhUXwqSr9s9bWMJk5zWBMckegP/JU2/7txYKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XU6zqNTr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f178e6225so316388285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721061623; x=1721666423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q43fP/YwIscAu2HdaErO2TBIovUlIaQMWdgLOPVgO94=;
        b=XU6zqNTryXv3s8FpkljJm3gLDCklCN+bU5KnWRob2tJPRx1V8AfNoH+9fSaeZnOQRa
         nF+wGCC1PehulayCbhiCwIn/+9hrCBTjCmSW/TktrSojHIWaBulYlntSdZz009aGY4In
         dLoCPE9Q4FIzYAW+kH69YRnrhP/a48uUpNks4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061623; x=1721666423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q43fP/YwIscAu2HdaErO2TBIovUlIaQMWdgLOPVgO94=;
        b=l1X4uwvecx63s1cP44H76Y5HVlH86mBh1iIMnSP8r2QvJoBkzwo1PS66L4ayB68Y/M
         gk9Zq52DD1Yr4Kk9vjz+39NRN7tSUwmgj/lVakXnGA5yskVDb0krH4OnfZFoSJQkfr79
         cS/fhmMXuT5tr+zcnojpr57rDZ8/BAnpql8ZwmDE93yGBRg6TAmzx3fVcKMfm23yfmaf
         1824U4lzFrkOnSUzabcDFsyDFQcAVXpEVxeGiNnG4gdxwRQ5ttgvy3wn1fPAEN/tu7Ws
         aF5wOUmjRJ2AZjVJZKLvuEs2WHEX5AKMY5geY0x0K2sJjXYrAAp2+WHX3d0HA43J6e0p
         +5tg==
X-Forwarded-Encrypted: i=1; AJvYcCVAzJUn0o1DYam/3xh7I9CpTu1sdrljvYo7ykBXaO0o3CIdngL7kHamIPplKXzR07Lj+aD0TBdOD7GfgW77kSFa5l4zUpj3K3rhPJu/
X-Gm-Message-State: AOJu0YypSaKriSHvoYG8KaApIDELHtan/e5m87tGeBN64bEDO8pC+X3l
	orSYuQKziTLApM6uIzE99dSmzEwDINKGmkvD5sGY1IqCwU+u/NtIMDEuxjJFI9LWTiotQFB63sU
	=
X-Google-Smtp-Source: AGHT+IFq7Pd9iJES9nLvJQIYuozaGyiO/dJNNec+L0us5FTFqyDEOk+Qgc6wpdcfIlFlfbNyS/Le8w==
X-Received: by 2002:a05:620a:288f:b0:79f:523:ac97 with SMTP id af79cd13be357-7a179f3dd62mr37936385a.27.1721061623162;
        Mon, 15 Jul 2024 09:40:23 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160b9c31dsm213440885a.20.2024.07.15.09.40.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:40:22 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447f8aa87bfso7441cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:40:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH6lWKvvpMt/60MMDSdDzJDUsKNXC19BFGXn+mQIueSuUnYx5+Xp0C7It+ySK01StadqCN3fiAfAxDtFl6JvlcC1gHroUxKk15Sgq5
X-Received: by 2002:ac8:6908:0:b0:447:e497:95d0 with SMTP id
 d75a77b69052e-44f5ac90b7dmr6164531cf.17.1721061621306; Mon, 15 Jul 2024
 09:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621134427.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <CAD=FV=VwebY8F3XjeVt6kvKwB7QZ8Khn5oJJoDThuemiGx9y+g@mail.gmail.com>
In-Reply-To: <CAD=FV=VwebY8F3XjeVt6kvKwB7QZ8Khn5oJJoDThuemiGx9y+g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Jul 2024 09:40:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UdsuEiyPK2K3sYdQm50WNukA5pxD=wUaEAVQStNnNA_A@mail.gmail.com>
Message-ID: <CAD=FV=UdsuEiyPK2K3sYdQm50WNukA5pxD=wUaEAVQStNnNA_A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 1:46=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Jun 21, 2024 at 1:45=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > At shutdown if you've got a _properly_ coded DRM modeset driver then
> > you'll get these two warnings at shutdown time:
> >
> >   Skipping disable of already disabled panel
> >   Skipping unprepare of already unprepared panel
> >
> > These warnings are ugly and sound concerning, but they're actually a
> > sign of a properly working system. That's not great.
> >
> > We're not ready to get rid of the calls to drm_panel_disable() and
> > drm_panel_unprepare() because we're not 100% convinced that all DRM
> > modeset drivers are properly calling drm_atomic_helper_shutdown() or
> > drm_helper_force_disable_all() at the right times. However, having the
> > warning show up for correctly working systems is bad.
> >
> > As a bit of a workaround, add some "if" tests to try to avoid the
> > warning on correctly working systems. Also add some comments and
> > update the TODO items in the hopes that future developers won't be too
> > confused by what's going on here.
> >
> > Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This patch came out of discussion on dri-devel on 2024-06-21
> > [1]. NOTE: I have put all changes into one patch since it didn't seem
> > to add anything to break up the updating of the TODO or the comments
> > in the core into separate patches since the patch is all about one
> > topic and all code is expected to land in the same tree.
> >
> > Previous versions:
> > v0: https://lore.kernel.org/r/20240604172305.v3.24.Ieb287c2c3ee3f6d3b0d=
5f49b29f746b93621749c@changeid/
> > v1: https://lore.kernel.org/r/20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49=
b29f746b93621749c@changeid
> >
> > [1] https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel=
&date=3D2024-06-21
> >
> >  Documentation/gpu/todo.rst           | 35 +++++++++++++---------------
> >  drivers/gpu/drm/drm_panel.c          | 18 ++++++++++++++
> >  drivers/gpu/drm/panel/panel-edp.c    | 26 ++++++++++++++-------
> >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++-------
> >  4 files changed, 68 insertions(+), 37 deletions(-)
>
> Ugh! I realized right after I hit "send" that I forgot to mark this as
> V2 and give it version history. Sorry! :( Please consider this to be
> v2. It's basically totally different than v1 based on today's IRC
> discussion, which should be linked above.
>
> If I need to send a new version I will send it as v3.

Is anyone willing to give me a Reviewed-by and/or Acked by for this
patch? ...or does anything want me to make any changes? Given all the
discussion we had, it would be nice to get this landed before we
forget what we agreed upon. :-P

-Doug

